diff --git a/Gemfile b/Gemfile
index 0e215c7..59b67c9 100644
--- a/Gemfile
+++ b/Gemfile
@@ -31,7 +31,7 @@ end
 gem 'execjs'
 gem 'jquery-rails'
 
-gem "nested_form", :git => 'https://github.com/ryanb/nested_form.git'
+gem "nested_form", :git => "git://github.com/madebydna/nested_form.git"
 gem 'therubyracer'
 # To use debugger
 # gem 'ruby-debug'
diff --git a/Gemfile.lock b/Gemfile.lock
index 1559f28..92019c1 100644
--- a/Gemfile.lock
+++ b/Gemfile.lock
@@ -1,8 +1,8 @@
 GIT
-  remote: https://github.com/ryanb/nested_form.git
-  revision: 486e0f0e93f3ca455d5d0fc7869053257b6afce2
+  remote: git://github.com/madebydna/nested_form.git
+  revision: bce54d4741ef698de7bcdc97cb86010812dbf81f
   specs:
-    nested_form (0.2.0)
+    nested_form (0.0.0)
 
 GEM
   remote: http://rubygems.org/
diff --git a/app/assets/javascripts/application.js b/app/assets/javascripts/application.js
index b8dafde..aeecb5b 100644
--- a/app/assets/javascripts/application.js
+++ b/app/assets/javascripts/application.js
@@ -7,75 +7,23 @@
 //= require jquery
 //= require jquery_ujs
 //= require_tree .
-
-jQuery(function($) {
-  window.NestedFormEvents = function() {
-    this.addFields = $.proxy(this.addFields, this);
-    this.removeFields = $.proxy(this.removeFields, this);
-  };
-
-  NestedFormEvents.prototype = {
-    addFields: function(e) {
-      // Setup
-      var link    = e.currentTarget;
-      var assoc   = $(link).attr('data-association');            // Name of child
-      var content = $('#' + assoc + '_fields_blueprint').html(); // Fields template
-
-      // Make the context correct by replacing new_<parents> with the generated ID
-      // of each of the parent objects
-      var context = ($(link).closest('.fields').find('input:first').attr('name') || '').replace(new RegExp('\[[a-z]+\]$'), '');
-
-      // context will be something like this for a brand new form:
-      // project[tasks_attributes][new_1255929127459][assignments_attributes][new_1255929128105]
-      // or for an edit form:
-      // project[tasks_attributes][0][assignments_attributes][1]
-      if (context) {
-        var parentNames = context.match(/[a-z_]+_attributes/g) || [];
-        var parentIds   = context.match(/(new_)?[0-9]+/g) || [];
-
-        for(var i = 0; i < parentNames.length; i++) {
-          if(parentIds[i]) {
-            content = content.replace(
-              new RegExp('(_' + parentNames[i] + ')_.+?_', 'g'),
-              '$1_' + parentIds[i] + '_');
-
-            content = content.replace(
-              new RegExp('(\\[' + parentNames[i] + '\\])\\[.+?\\]', 'g'),
-              '$1[' + parentIds[i] + ']');
-          }
-        }
-      }
-
-      // Make a unique ID for the new child
-      var regexp  = new RegExp('new_' + assoc, 'g');
-      var new_id  = new Date().getTime();
-      content     = content.replace(regexp, "new_" + new_id);
-
-      var field = this.insertFields(content, assoc, link);
-      $(link).closest("form")
-        .trigger({ type: 'nested:fieldAdded', field: field })
-        .trigger({ type: 'nested:fieldAdded:' + assoc, field: field });
-      return false;
-    },
-    insertFields: function(content, assoc, link) {
-      return $(content).insertBefore(link);
-    },
-    removeFields: function(e) {
-      var link = e.currentTarget;
-      var hiddenField = $(link).prev('input[type=hidden]');
-      hiddenField.val('1');
-      // if (hiddenField) {
-      //   $(link).v
-      //   hiddenField.value = '1';
-      // }
-      var field = $(link).closest('.fields');
-      field.hide();
-      $(link).closest("form").trigger({ type: 'nested:fieldRemoved', field: field });
-      return false;
+$(function() {
+  $('form a.add_child').click(function() {
+    var association = $(this).attr('data-association');
+    var template = $('#' + association + '_fields_template').html();
+    var regexp = new RegExp('new_' + association, 'g');
+    var new_id = new Date().getTime();
+
+    $(this).parent().before(template.replace(regexp, new_id));
+    return false;
+  });
+
+  $('form a.remove_child').live('click', function() {
+    var hidden_field = $(this).prev('input[type=hidden]')[0];
+    if(hidden_field) {
+      hidden_field.value = '1';
     }
-  };
-
-  window.nestedFormEvents = new NestedFormEvents();
-  $('form a.add_nested_fields').live('click', nestedFormEvents.addFields);
-  $('form a.remove_nested_fields').live('click', nestedFormEvents.removeFields);
-});
\ No newline at end of file
+    $(this).parents('.fields').hide();
+    return false;
+  });
+});
diff --git a/app/assets/javascripts/docters.js.coffee b/app/assets/javascripts/docters.js.coffee
index 7615679..e2a5cb6 100644
--- a/app/assets/javascripts/docters.js.coffee
+++ b/app/assets/javascripts/docters.js.coffee
@@ -1,3 +1,44 @@
 # Place all the behaviors and hooks related to the matching controller here.
 # All this logic will automatically be available in application.js.
 # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
+<script type="text/javascript">
+    $(document).ready(function()
+    {
+        $("select#docter_categories_d_id").change(function()
+        {
+            var id_value_string = $(this).val();
+            if (id_value_string == "") 
+            {
+                // if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
+                $("select#docter_sub_categories_d_id option").remove();
+                var row = "<option value=\"" + "" + "\">" + "" + "</option>";
+                $(row).appendTo("select#docter_sub_categories_d_id");
+            }
+            else 
+            {
+                // Send the request and update sub category dropdown
+                $.ajax({
+                    dataType: "json",
+                    cache: false,
+                    url: '/sub_categories_ds/for_categories_d_id/' + id_value_string,
+                    timeout: 2000,
+                    error: function(XMLHttpRequest, errorTextStatus, error){
+                        alert("Failed to submit : "+ errorTextStatus+" ;"+error);
+                    },
+                    success: function(data){                    
+                        // Clear all options from sub category select
+                        $("select#docter_sub_categories_d_id option").remove();
+                        //put in a empty default line
+                        var row = "<option value=\"" + "" + "\">" + "" + "</option>";
+                        $(row).appendTo("select#docter_sub_categories_d_id");                        
+                        // Fill sub category select
+                        $.each(data, function(i, j){
+                            row = "<option value=\"" + j.sub_categories_d.id + "\">" + j.sub_categories_d.name + "</option>";  
+                            $(row).appendTo("select#docter_sub_categories_d_id");                    
+                        });            
+                     }
+                });
+            };
+                });
+    });
+</script>
\ No newline at end of file
diff --git a/app/assets/javascripts/javascripts.js.coffee b/app/assets/javascripts/javascripts.js.coffee
deleted file mode 100644
index 7615679..0000000
--- a/app/assets/javascripts/javascripts.js.coffee
+++ /dev/null
@@ -1,3 +0,0 @@
-# Place all the behaviors and hooks related to the matching controller here.
-# All this logic will automatically be available in application.js.
-# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
diff --git a/app/assets/javascripts/nested_form.js b/app/assets/javascripts/nested_form.js
deleted file mode 100644
index d6750b9..0000000
--- a/app/assets/javascripts/nested_form.js
+++ /dev/null
@@ -1,71 +0,0 @@
-jQuery(function($) {
-  window.NestedFormEvents = function() {
-    this.addFields = $.proxy(this.addFields, this);
-    this.removeFields = $.proxy(this.removeFields, this);
-  };
-
-  NestedFormEvents.prototype = {
-    addFields: function(e) {
-      // Setup
-      var link    = e.currentTarget;
-      var assoc   = $(link).attr('data-association');            // Name of child
-      var content = $('#' + assoc + '_fields_blueprint').html(); // Fields template
-
-      // Make the context correct by replacing new_<parents> with the generated ID
-      // of each of the parent objects
-      var context = ($(link).closest('.fields').find('input:first').attr('name') || '').replace(new RegExp('\[[a-z]+\]$'), '');
-
-      // context will be something like this for a brand new form:
-      // project[tasks_attributes][new_1255929127459][assignments_attributes][new_1255929128105]
-      // or for an edit form:
-      // project[tasks_attributes][0][assignments_attributes][1]
-      if (context) {
-        var parentNames = context.match(/[a-z_]+_attributes/g) || [];
-        var parentIds   = context.match(/(new_)?[0-9]+/g) || [];
-
-        for(var i = 0; i < parentNames.length; i++) {
-          if(parentIds[i]) {
-            content = content.replace(
-              new RegExp('(_' + parentNames[i] + ')_.+?_', 'g'),
-              '$1_' + parentIds[i] + '_');
-
-            content = content.replace(
-              new RegExp('(\\[' + parentNames[i] + '\\])\\[.+?\\]', 'g'),
-              '$1[' + parentIds[i] + ']');
-          }
-        }
-      }
-
-      // Make a unique ID for the new child
-      var regexp  = new RegExp('new_' + assoc, 'g');
-      var new_id  = new Date().getTime();
-      content     = content.replace(regexp, "new_" + new_id);
-
-      var field = this.insertFields(content, assoc, link);
-      $(link).closest("form")
-        .trigger({ type: 'nested:fieldAdded', field: field })
-        .trigger({ type: 'nested:fieldAdded:' + assoc, field: field });
-      return false;
-    },
-    insertFields: function(content, assoc, link) {
-      return $(content).insertBefore(link);
-    },
-    removeFields: function(e) {
-      var link = e.currentTarget;
-      var hiddenField = $(link).prev('input[type=hidden]');
-      hiddenField.val('1');
-      // if (hiddenField) {
-      //   $(link).v
-      //   hiddenField.value = '1';
-      // }
-      var field = $(link).closest('.fields');
-      field.hide();
-      $(link).closest("form").trigger({ type: 'nested:fieldRemoved', field: field });
-      return false;
-    }
-  };
-
-  window.nestedFormEvents = new NestedFormEvents();
-  $('form a.add_nested_fields').live('click', nestedFormEvents.addFields);
-  $('form a.remove_nested_fields').live('click', nestedFormEvents.removeFields);
-});
diff --git a/app/assets/stylesheets/allergies.css.scss b/app/assets/stylesheets/allergies.css.scss
deleted file mode 100644
index 4bbe1f4..0000000
--- a/app/assets/stylesheets/allergies.css.scss
+++ /dev/null
@@ -1,3 +0,0 @@
-// Place all the styles related to the allergies controller here.
-// They will automatically be included in application.css.
-// You can use Sass (SCSS) here: http://sass-lang.com/
diff --git a/app/assets/stylesheets/allergy.css.scss b/app/assets/stylesheets/allergy.css.scss
deleted file mode 100644
index 0b51b9e..0000000
--- a/app/assets/stylesheets/allergy.css.scss
+++ /dev/null
@@ -1,3 +0,0 @@
-// Place all the styles related to the allergy controller here.
-// They will automatically be included in application.css.
-// You can use Sass (SCSS) here: http://sass-lang.com/
diff --git a/app/assets/stylesheets/javascripts.css.scss b/app/assets/stylesheets/javascripts.css.scss
deleted file mode 100644
index 03c8811..0000000
--- a/app/assets/stylesheets/javascripts.css.scss
+++ /dev/null
@@ -1,3 +0,0 @@
-// Place all the styles related to the javascripts controller here.
-// They will automatically be included in application.css.
-// You can use Sass (SCSS) here: http://sass-lang.com/
diff --git a/app/controllers/countries_controller.rb b/app/controllers/countries_controller.rb
index d27bd06..105578b 100644
--- a/app/controllers/countries_controller.rb
+++ b/app/controllers/countries_controller.rb
@@ -1,83 +1,35 @@
 class CountriesController < ApplicationController
-  # GET /countries
-  # GET /countries.json
-  def index
-    @countries = Country.all
-
-    respond_to do |format|
-      format.html # index.html.erb
-      format.json { render json: @countries }
-    end
-  end
-
-  # GET /countries/1
-  # GET /countries/1.json
-  def show
-    @country = Country.find(params[:id])
-
-    respond_to do |format|
-      format.html # show.html.erb
-      format.json { render json: @country }
-    end
-  end
-
-  # GET /countries/new
-  # GET /countries/new.json
-  def new
-    @country = Country.new
-
-    respond_to do |format|
-      format.html # new.html.erb
-      format.json { render json: @country }
-    end
-  end
-
-  # GET /countries/1/edit
-  def edit
-    @country = Country.find(params[:id])
-  end
-
-  # POST /countries
-  # POST /countries.json
-  def create
-    @country = Country.new(params[:country])
+   before_filter :find_country, :except => [:index, :new, :create]
+def index
+@countries = Country.all
+end
 
-    respond_to do |format|
-      if @country.save
-        format.html { redirect_to @country, notice: 'Country was successfully created.' }
-        format.json { render json: @country, status: :created, location: @country }
-      else
-        format.html { render action: "new" }
-        format.json { render json: @country.errors, status: :unprocessable_entity }
-      end
-    end
-  end
+def new
+@country = Country.new
+end
 
-  # PUT /countries/1
-  # PUT /countries/1.json
-  def update
-    @country = Country.find(params[:id])
+def edit
+end
 
-    respond_to do |format|
-      if @country.update_attributes(params[:country])
-        format.html { redirect_to @country, notice: 'Country was successfully updated.' }
-        format.json { head :ok }
-      else
-        format.html { render action: "edit" }
-        format.json { render json: @country.errors, status: :unprocessable_entity }
-      end
-    end
-  end
+def create
+@country = Country.new(params[:country])
+if @country.save
+redirect_to countries_path
+else
+render :action => :new
+end
+end
 
-  # DELETE /countries/1
-  # DELETE /countries/1.json
-  def destroy
-    @country = Country.find(params[:id])
-    @country.destroy
+def update
+if @country.update_attributes(params[:country])
+redirect_to countries_path
+else
+render :action => :edit
+end
+end
 
-    respond_to do |format|
-      format.html { redirect_to countries_url }
-      format.json { head :ok }
-    end
-  end
+private
+def find_country
+@country = Country.find(params[:id])
+end
 end
diff --git a/app/controllers/javascripts_controller.rb b/app/controllers/javascripts_controller.rb
deleted file mode 100644
index 9af332c..0000000
--- a/app/controllers/javascripts_controller.rb
+++ /dev/null
@@ -1,7 +0,0 @@
-class JavascriptsController < ApplicationController
-  def dynamic_states
-  @states = State.find(:all)
-end
-
-
-end
diff --git a/app/controllers/patients_controller.rb b/app/controllers/patients_controller.rb
index 5deaf6c..cdede8f 100644
--- a/app/controllers/patients_controller.rb
+++ b/app/controllers/patients_controller.rb
@@ -1,16 +1,8 @@
 class PatientsController < ApplicationController
-  
+  include PatientsHelper
   def new
     @patient = Patient.new
     allergy = @patient.allergies
-    immunization = @patient.immunizations
-    insu = @patient.insurances
-    problem = @patient.problems
-    procedure = @patient.procedures
-    result = @patient.results
-    medication = @patient.medications
-    #@patient = Patient.find_by_user_id(params[:id])
-    #@patient.allergies.build
 
   end
 
diff --git a/app/controllers/states_controller.rb b/app/controllers/states_controller.rb
index fc4a6aa..386a819 100644
--- a/app/controllers/states_controller.rb
+++ b/app/controllers/states_controller.rb
@@ -1,83 +1,2 @@
 class StatesController < ApplicationController
-  # GET /states
-  # GET /states.json
-  def index
-    @states = State.all
-
-    respond_to do |format|
-      format.html # index.html.erb
-      format.json { render json: @states }
-    end
-  end
-
-  # GET /states/1
-  # GET /states/1.json
-  def show
-    @state = State.find(params[:id])
-
-    respond_to do |format|
-      format.html # show.html.erb
-      format.json { render json: @state }
-    end
-  end
-
-  # GET /states/new
-  # GET /states/new.json
-  def new
-    @state = State.new
-
-    respond_to do |format|
-      format.html # new.html.erb
-      format.json { render json: @state }
-    end
-  end
-
-  # GET /states/1/edit
-  def edit
-    @state = State.find(params[:id])
-  end
-
-  # POST /states
-  # POST /states.json
-  def create
-    @state = State.new(params[:state])
-
-    respond_to do |format|
-      if @state.save
-        format.html { redirect_to @state, notice: 'State was successfully created.' }
-        format.json { render json: @state, status: :created, location: @state }
-      else
-        format.html { render action: "new" }
-        format.json { render json: @state.errors, status: :unprocessable_entity }
-      end
-    end
-  end
-
-  # PUT /states/1
-  # PUT /states/1.json
-  def update
-    @state = State.find(params[:id])
-
-    respond_to do |format|
-      if @state.update_attributes(params[:state])
-        format.html { redirect_to @state, notice: 'State was successfully updated.' }
-        format.json { head :ok }
-      else
-        format.html { render action: "edit" }
-        format.json { render json: @state.errors, status: :unprocessable_entity }
-      end
-    end
-  end
-
-  # DELETE /states/1
-  # DELETE /states/1.json
-  def destroy
-    @state = State.find(params[:id])
-    @state.destroy
-
-    respond_to do |format|
-      format.html { redirect_to states_url }
-      format.json { head :ok }
-    end
-  end
 end
diff --git a/app/controllers/users_controller.rb b/app/controllers/users_controller.rb
index 5527193..2bccc0e 100644
--- a/app/controllers/users_controller.rb
+++ b/app/controllers/users_controller.rb
@@ -10,5 +10,5 @@ class UsersController < ApplicationController
       format.xml  { render :xml => @users }
       end
   end
-
+  
 end
diff --git a/app/helpers/application_helper.rb b/app/helpers/application_helper.rb
index 9ba961b..e777e41 100644
--- a/app/helpers/application_helper.rb
+++ b/app/helpers/application_helper.rb
@@ -1,7 +1,26 @@
 module ApplicationHelper
 
-def javascript(*files)
-  content_for(:head) { javascript_include_tag(*files) }
+
+def add_child_link(name, association)
+  link_to(name, "javascript:void(0)", :class => "add_child", :"data-association" => association)
+end
+
+def remove_child_link(name, f)
+  f.hidden_field(:_destroy) + link_to(name, "javascript:void(0)", :class => "remove_child")
+end
+
+def new_child_fields_template(form_builder, association, options = {})
+  options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
+  options[:partial] ||= association.to_s.singularize
+  options[:form_builder_local] ||= :f
+
+  content_for :jstemplates do
+    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
+      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|        
+        render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })        
+      end
+    end
+  end
 end
 
 end
diff --git a/app/helpers/javascripts_helper.rb b/app/helpers/javascripts_helper.rb
deleted file mode 100644
index c33f5c0..0000000
--- a/app/helpers/javascripts_helper.rb
+++ /dev/null
@@ -1,2 +0,0 @@
-module JavascriptsHelper
-end
diff --git a/app/helpers/patients_helper.rb b/app/helpers/patients_helper.rb
index 47526e6..e1284d4 100644
--- a/app/helpers/patients_helper.rb
+++ b/app/helpers/patients_helper.rb
@@ -1,3 +1,18 @@
 module PatientsHelper
+   def link_to_add(name, association)
+      @fields ||= {}
+      @template.after_nested_form do
+        model_object = object.class.reflect_on_association(association).klass.new
+        output = %Q[<div id="#{association}_fields_blueprint" style="display: none">].html_safe
+        output << fields_for(association, model_object, 
+                  :child_index => "new_#{association}", 
+                  &@fields[association])
+        output.safe_concat('</div>')
+        output
+      end
+      @template.link_to(name, "javascript:void(0)", 
+                        :class => "add_nested_fields", 
+                        "data-association" => association)
+    end
 
 end
diff --git a/app/models/allergy.rb b/app/models/allergy.rb
index dab5940..c83de7d 100644
--- a/app/models/allergy.rb
+++ b/app/models/allergy.rb
@@ -1,5 +1,4 @@
 class Allergy < ActiveRecord::Base
-     belongs_to       :patients
-     attr_accessible  :patient_id, :allergic, :affect, :started, :ended, :severity, :journal_entry, :user_id
-     
+  belongs_to   :patient
+     attr_accessible  :patient_id
 end
diff --git a/app/models/city.rb b/app/models/city.rb
index 406ecd8..ceba1d0 100644
--- a/app/models/city.rb
+++ b/app/models/city.rb
@@ -1,4 +1,2 @@
 class City < ActiveRecord::Base
-  belongs_to :country
-  belongs_to :state
 end
diff --git a/app/models/country.rb b/app/models/country.rb
index b7cec2b..bf464c1 100644
--- a/app/models/country.rb
+++ b/app/models/country.rb
@@ -1,2 +1,4 @@
 class Country < ActiveRecord::Base
+   has_many :states
+   has_many :cities, :through => :states
 end
diff --git a/app/models/patient.rb b/app/models/patient.rb
index 9eefcc9..0b3ddd7 100644
--- a/app/models/patient.rb
+++ b/app/models/patient.rb
@@ -7,6 +7,6 @@ class Patient < ActiveRecord::Base
     has_many                  :medications
     has_many                  :procedures
     has_many                  :results
-    attr_accessible :user_id, :name, :phone, :address_line1, :address_line2, :address_line3, :suffering_from, :patient_id, :allergic, :affect, :started, :ended, :severity, :journal_entry, :user_id
-    accepts_nested_attributes_for :allergies, :allow_destroy => true
+    attr_accessible :user_id, :name, :phone, :address_line1, :address_line2, :address_line3, :suffering_from, :patient_id
+    accepts_nested_attributes_for :allergies
 end
diff --git a/app/models/state.rb b/app/models/state.rb
index 60e7254..fdf055b 100644
--- a/app/models/state.rb
+++ b/app/models/state.rb
@@ -1,2 +1,3 @@
 class State < ActiveRecord::Base
+  has_many :cities
 end
diff --git a/app/views/countries/_form.html.erb b/app/views/countries/_form.html.erb
deleted file mode 100644
index 0892483..0000000
--- a/app/views/countries/_form.html.erb
+++ /dev/null
@@ -1,21 +0,0 @@
-<%= form_for(@country) do |f| %>
-  <% if @country.errors.any? %>
-    <div id="error_explanation">
-      <h2><%= pluralize(@country.errors.count, "error") %> prohibited this country from being saved:</h2>
-
-      <ul>
-      <% @country.errors.full_messages.each do |msg| %>
-        <li><%= msg %></li>
-      <% end %>
-      </ul>
-    </div>
-  <% end %>
-
-  <div class="field">
-    <%= f.label :name %><br />
-    <%= f.text_field :name %>
-  </div>
-  <div class="actions">
-    <%= f.submit %>
-  </div>
-<% end %>
diff --git a/app/views/countries/edit.html.erb b/app/views/countries/edit.html.erb
deleted file mode 100644
index 7c899ad..0000000
--- a/app/views/countries/edit.html.erb
+++ /dev/null
@@ -1,6 +0,0 @@
-<h1>Editing country</h1>
-
-<%= render 'form' %>
-
-<%= link_to 'Show', @country %> |
-<%= link_to 'Back', countries_path %>
diff --git a/app/views/countries/index.html.erb b/app/views/countries/index.html.erb
deleted file mode 100644
index 52238a1..0000000
--- a/app/views/countries/index.html.erb
+++ /dev/null
@@ -1,23 +0,0 @@
-<h1>Listing countries</h1>
-
-<table>
-  <tr>
-    <th>Name</th>
-    <th></th>
-    <th></th>
-    <th></th>
-  </tr>
-
-<% @countries.each do |country| %>
-  <tr>
-    <td><%= country.name %></td>
-    <td><%= link_to 'Show', country %></td>
-    <td><%= link_to 'Edit', edit_country_path(country) %></td>
-    <td><%= link_to 'Destroy', country, confirm: 'Are you sure?', method: :delete %></td>
-  </tr>
-<% end %>
-</table>
-
-<br />
-
-<%= link_to 'New Country', new_country_path %>
diff --git a/app/views/countries/new.html.erb b/app/views/countries/new.html.erb
deleted file mode 100644
index f318547..0000000
--- a/app/views/countries/new.html.erb
+++ /dev/null
@@ -1,5 +0,0 @@
-<h1>New country</h1>
-
-<%= render 'form' %>
-
-<%= link_to 'Back', countries_path %>
diff --git a/app/views/countries/show.html.erb b/app/views/countries/show.html.erb
deleted file mode 100644
index 8a85043..0000000
--- a/app/views/countries/show.html.erb
+++ /dev/null
@@ -1,10 +0,0 @@
-<p id="notice"><%= notice %></p>
-
-<p>
-  <b>Name:</b>
-  <%= @country.name %>
-</p>
-
-
-<%= link_to 'Edit', edit_country_path(@country) %> |
-<%= link_to 'Back', countries_path %>
diff --git a/app/views/docters/_city.html.erb b/app/views/docters/_city.html.erb
deleted file mode 100644
index 7d99667..0000000
--- a/app/views/docters/_city.html.erb
+++ /dev/null
@@ -1,2 +0,0 @@
-<%= collection_select(nil, :city_id, cities, :id, :title,
-                     {:prompt   => "Select a city"}) %>
\ No newline at end of file
diff --git a/app/views/docters/_form.html.erb b/app/views/docters/_form.html.erb
index 2444fb5..6bb6f92 100644
--- a/app/views/docters/_form.html.erb
+++ b/app/views/docters/_form.html.erb
@@ -1,6 +1,5 @@
 
 
-<%= javascript 'dynamic_states' %>
 <%= form_for(@docter) do |f| %>
 
 
@@ -15,14 +14,8 @@
     <%= f.text_field  :address_line3 %>
   </p>
  
-<p>
- 
-  <%= f.collection_select :countries_id, Country.find(:all), :name, :prompt => "Select a Country" %>
-</p>
-<p>
- 
-  <%= f.collection_select :states_id, State.find(:all), :name, :prompt => "Select a State" %>
-</p>
+
+
 
    <p>
     <%= f.label       :contact_no %><br />
diff --git a/app/views/docters/_state.html.erb b/app/views/docters/_state.html.erb
deleted file mode 100644
index d2724e4..0000000
--- a/app/views/docters/_state.html.erb
+++ /dev/null
@@ -1,5 +0,0 @@
-<%= collection_select(nil, :state_id, states, :id, :name,
-                     {:prompt   => "Select an state"},
-                     {:onchange => "#{remote_function(:url  => {:action => "update_cities"},
-                                                      :with => "'state_id='+value")}"}) %>
-<br/>
\ No newline at end of file
diff --git a/app/views/javascripts/dynamic_states.js.erb b/app/views/javascripts/dynamic_states.js.erb
deleted file mode 100644
index a48b0d1..0000000
--- a/app/views/javascripts/dynamic_states.js.erb
+++ /dev/null
@@ -1,25 +0,0 @@
-var states = new Array();
-<% for state in @states -%>
-  states.push(new Array(<%= state.country_id %>, '<%=h state.name %>', <%= state.id %>));
-<% end -%>
-
-function countrySelected() {
-  country_id = $('person_country_id').getValue();
-  options = $('person_state_id').options;
-  options.length = 1;
-  states.each(function(state) {
-    if (state[0] == country_id) {
-      options[options.length] = new Option(state[1], state[2]);
-    }
-  });
-  if (options.length == 1) {
-    $('state_field').hide();
-  } else {
-    $('state_field').show();
-  }
-}
-
-document.observe('dom:loaded', function() {
-  countrySelected();
-  $('person_country_id').observe('change', countrySelected);
-});
\ No newline at end of file
diff --git a/app/views/layouts/application.html.erb b/app/views/layouts/application.html.erb
index f96651c..10fe8ac 100644
--- a/app/views/layouts/application.html.erb
+++ b/app/views/layouts/application.html.erb
@@ -3,11 +3,9 @@
 <head>
   <title>Doctor</title>
   <%= stylesheet_link_tag    "application" %>
-<%= javascript_include_tag 'jquery', 'nested_form' %>
-
-
+	<%= javascript_include_tag  :defaults %>
 	
-<%= yield(:head)%>
+
 
   <%= csrf_meta_tags %>
 </head>
@@ -27,6 +25,6 @@
          </center>
    		 <br />  <br />  <br />   <br />  <br /> 
       <%= yield %>
-
+	
 </body>
 </html>
\ No newline at end of file
diff --git a/app/views/patients/_allergy.html.erb b/app/views/patients/_allergy.html.erb
index daec94c..3eb1897 100644
--- a/app/views/patients/_allergy.html.erb
+++ b/app/views/patients/_allergy.html.erb
@@ -1,4 +1,3 @@
-
 <p>
   <%= f.label :allergic_to  %> <br />
   <%= f.text_field :allergic  %><br />
diff --git a/app/views/patients/_form.html.erb b/app/views/patients/_form.html.erb
index c8682f0..0265714 100644
--- a/app/views/patients/_form.html.erb
+++ b/app/views/patients/_form.html.erb
@@ -1,5 +1,5 @@
 
-<%= nested_form_for @patient do |f|  %>
+<%= form_for (@patient) do |f| %>
 
 
 <%= f.label :name %><br />
@@ -19,11 +19,11 @@
 
 <%= f.hidden_field :user_id, :value => current_user.id %>
 
- <h3> allergies</h3>
-	<%= f.fields_for :allergies do |f| %>
-	<%= render :partial =>'allergy',  :locals => { :f => f }%>
-	<% end %>
-<p><%= f.link_to_add "Add a allergy", :allergies %></p>
+ <%= f.fields_for :allergy do |bud| %>
+   <%= add_child_link "Add allergy", :allergy %></p>
+  <%= new_child_fields_template f, :allergy %>
+ <% end %>
+ <p>
 
 
 <%= f.submit "Create" %>
diff --git a/app/views/patients/_immu.html.erb b/app/views/patients/_immu.html.erb
deleted file mode 100644
index 48fedde..0000000
--- a/app/views/patients/_immu.html.erb
+++ /dev/null
@@ -1,15 +0,0 @@
-<p>
-  <%= f.label :immunization_name  %> <br />
-  <%= f.text_field :immu_name  %><br />
-</p>
-
-<p>
-  <%= f.label :date %><br />
-  <%= f.date_select  :date %><br />
-</p>
-<p>
-  <%= f.label :journal_entry %> <br />
-  <%= f.text_area  :journal_entry %><br />
-</p>
-
-<%= f.hidden_field :user_id, :value => current_user.id %>
diff --git a/app/views/patients/partials/_immu.html.erb b/app/views/patients/partials/_immu.html.erb
new file mode 100644
index 0000000..e69de29
diff --git a/app/views/patients/partials/_insu.html.erb b/app/views/patients/partials/_insu.html.erb
index dfaff7a..e69de29 100644
--- a/app/views/patients/partials/_insu.html.erb
+++ b/app/views/patients/partials/_insu.html.erb
@@ -1,48 +0,0 @@
-<p>
-  <%= f.label :insurance_type %> <br />
-  <%= f.text_field  :type_insurance %><br />
-</p>
-<p>
-  <%= f.label :company_name %> <br />
-  <%= f.text_field  :comp_name %><br />
-</p>
-<p>
-  <%= f.label :plan_name %> <br />
-  <%= f.text_field  :plan_name %><br />
-</p>
-<p>
-  <%= f.label :plan_id %> <br />
-  <%= f.text_field  :plan_id %><br />
-</p>
-<p>
-  <%= f.label :card_name %> <br />
-  <%= f.text_field  :card_name %><br />
-</p>
-<p>
-  <%= f.label :plan_name %> <br />
-  <%= f.text_field  :plan_name %><br />
-</p>
-<p>
-  <%= f.label :policy_id %> <br />
-  <%= f.text_field  :policy_id %><br />
-</p>
-<p>
-  <%= f.label :insure_phone %> <br />
-  <%= f.text_field  :insure_phone %><br />
-</p>
-
-<p>
-  <%= f.label :started %> <br />
-  <%= f.date_select :start_date %><br />
-</p>
-<p>
-  <%= f.label :ended %><br />
-  <%= f.date_select  :end_date %><br />
-</p>
-
-<p>
-  <%= f.label :journal_entry %> <br />
-  <%= f.text_area  :journal_entry %><br />
-</p>
-
-<%= f.hidden_field :user_id, :value => current_user.id %>
diff --git a/app/views/patients/partials/_medi.html.erb b/app/views/patients/partials/_medi.html.erb
index e8263e8..e69de29 100644
--- a/app/views/patients/partials/_medi.html.erb
+++ b/app/views/patients/partials/_medi.html.erb
@@ -1,40 +0,0 @@
-
-
-<p>
-  <%= f.label :medication  %> <br />
-  <%= f.text_field :medication  %><br />
-</p>
-<p>
-  <%= f.label :take_medi  %> <br />
-  <%= f.text_field :take_medi  %><br />
-</p>
-<p>
-  <%= f.label :started %> <br />
-  <%= f.date_select :started %><br />
-</p>
-<p>
-  <%= f.label :ended %><br />
-  <%= f.date_select  :ended %><br />
-</p>
-<p>
-  <%= f.label :route  %> <br />
-  <%= f.text_field :route  %><br />
-</p>
-<p>
-  <%= f.label :strength  %> <br />
-  <%= f.text_field :strength  %><br />
-</p>
-<p>
-  <%= f.label :how_many  %> <br />
-  <%= f.text_field :how_many  %><br />
-</p>
-<p>
-  <%= f.label :how_often  %> <br />
-  <%= f.text_field :how_often  %><br />
-</p>
-<p>
-  <%= f.label :journal_entry %> <br />
-  <%= f.text_area  :journal_entry %><br />
-</p>
-
-<%= f.hidden_field :user_id, :value => current_user.id %>
\ No newline at end of file
diff --git a/app/views/patients/partials/_problem.html.erb b/app/views/patients/partials/_problem.html.erb
index be149b4..e69de29 100644
--- a/app/views/patients/partials/_problem.html.erb
+++ b/app/views/patients/partials/_problem.html.erb
@@ -1,24 +0,0 @@
-
-
-
-<p>
-  <%= f.label :symptom %> <br />
-  <%= f.text_field :symptom %><br />
-</p>
-p>
-  <%= f.label :problem %> <br />
-  <%= f.text_field :problem %><br />
-</p>
-<p>
-  <%= f.label :started %> <br />
-  <%= f.date_select :started %><br />
-</p>
-<p>
-  <%= f.label :ended %><br />
-  <%= f.date_select  :ended %><br />
-</p>
-<p>
-  <%= f.label :journal_entry %> <br />
-  <%= f.text_area  :journal_entry %><br />
-</p>
-<%= f.hidden_field :user_id, :value => current_user.id %>
\ No newline at end of file
diff --git a/app/views/patients/partials/_proce.html.erb b/app/views/patients/partials/_proce.html.erb
index bb1e7dc..e69de29 100644
--- a/app/views/patients/partials/_proce.html.erb
+++ b/app/views/patients/partials/_proce.html.erb
@@ -1,22 +0,0 @@
-
-<p>
-  <%= f.label :surgery %> <br />
-  <%= f.text_field :surgery %><br />
-</p>
-
-
-<p>
-  <%= f.label :started %> <br />
-  <%= f.date_select :started %><br />
-</p>
-<p>
-  <%= f.label :ended %><br />
-  <%= f.date_select  :ended %><br />
-</p>
-
-<p>
-  <%= f.label :journal_entry %> <br />
-  <%= f.text_area  :journal_entry %><br />
-</p>
-
-<%= f.hidden_field :user_id, :value => current_user.id %>
diff --git a/app/views/patients/partials/_result.html.erb b/app/views/patients/partials/_result.html.erb
index f9980a0..e69de29 100644
--- a/app/views/patients/partials/_result.html.erb
+++ b/app/views/patients/partials/_result.html.erb
@@ -1,35 +0,0 @@
-
-<p>
-  <%= f.label :test_name %> <br />
-  <%= f.text_field :test_name %><br />
-</p>
-
-<p>
-  <%= f.label :final_result %> <br />
-  <%= f.text_field :final_result %><br />
-</p>
-
-<p>
-  <%= f.label :unit %> <br />
-  <%= f.text_field :unit %><br />
-</p>
-<p>
-  <%= f.label :date_test %> <br />
-  <%= f.date_select :date_test %><br />
-</p>
-<p>
-  <%= f.label :goal %> <br />
-  <%= f.text_field :goal %><br />
-</p>
-<p>
-  <%= f.label :per_entry %> <br />
-  <%= f.text_field :per_entry %><br />
-</p>
-
-
-<p>
-  <%= f.label :journal_entry %> <br />
-  <%= f.text_area  :journal_entry %><br />
-</p>
-
-<%= f.hidden_field :user_id, :value => current_user.id %>
diff --git a/app/views/patients/shared/_allergy.html.erb b/app/views/patients/shared/_allergy.html.erb
deleted file mode 100644
index 3eb1897..0000000
--- a/app/views/patients/shared/_allergy.html.erb
+++ /dev/null
@@ -1,30 +0,0 @@
-<p>
-  <%= f.label :allergic_to  %> <br />
-  <%= f.text_field :allergic  %><br />
-</p>
-
-<p>
-  <%= f.label :affect %> <br />
-  <%= f.text_field :affect %><br />
-</p>
-
-<p>
-  <%= f.label :started %> <br />
-  <%= f.date_select :started %><br />
-</p>
-<p>
-  <%= f.label :ended %><br />
-  <%= f.date_select  :ended %><br />
-</p>
-
-<p>
-  <%= f.label :severity %><br />
-  <%= f.text_field  :severity %><br />
-</p>
-
-<p>
-  <%= f.label :journal_entry %> <br />
-  <%= f.text_area  :journal_entry %><br />
-</p>
-
-<%= f.hidden_field :user_id, :value => current_user.id %>
diff --git a/app/views/patients/shared/_immu.html.erb b/app/views/patients/shared/_immu.html.erb
deleted file mode 100644
index e69de29..0000000
diff --git a/app/views/patients/shared/_insu.html.erb b/app/views/patients/shared/_insu.html.erb
deleted file mode 100644
index e69de29..0000000
diff --git a/app/views/patients/shared/_medi.html.erb b/app/views/patients/shared/_medi.html.erb
deleted file mode 100644
index e69de29..0000000
diff --git a/app/views/patients/shared/_problem.html.erb b/app/views/patients/shared/_problem.html.erb
deleted file mode 100644
index e69de29..0000000
diff --git a/app/views/patients/shared/_proce.html.erb b/app/views/patients/shared/_proce.html.erb
deleted file mode 100644
index e69de29..0000000
diff --git a/app/views/patients/shared/_result.html.erb b/app/views/patients/shared/_result.html.erb
deleted file mode 100644
index e69de29..0000000
diff --git a/app/views/states/_form.html.erb b/app/views/states/_form.html.erb
deleted file mode 100644
index 3ce237b..0000000
--- a/app/views/states/_form.html.erb
+++ /dev/null
@@ -1,21 +0,0 @@
-<%= form_for(@state) do |f| %>
-  <% if @state.errors.any? %>
-    <div id="error_explanation">
-      <h2><%= pluralize(@state.errors.count, "error") %> prohibited this state from being saved:</h2>
-
-      <ul>
-      <% @state.errors.full_messages.each do |msg| %>
-        <li><%= msg %></li>
-      <% end %>
-      </ul>
-    </div>
-  <% end %>
-
-  <div class="field">
-    <%= f.label :name %><br />
-    <%= f.text_field :name %>
-  </div>
-  <div class="actions">
-    <%= f.submit %>
-  </div>
-<% end %>
diff --git a/app/views/states/edit.html.erb b/app/views/states/edit.html.erb
deleted file mode 100644
index 0484ba0..0000000
--- a/app/views/states/edit.html.erb
+++ /dev/null
@@ -1,6 +0,0 @@
-<h1>Editing state</h1>
-
-<%= render 'form' %>
-
-<%= link_to 'Show', @state %> |
-<%= link_to 'Back', states_path %>
diff --git a/app/views/states/index.html.erb b/app/views/states/index.html.erb
deleted file mode 100644
index b14899c..0000000
--- a/app/views/states/index.html.erb
+++ /dev/null
@@ -1,23 +0,0 @@
-<h1>Listing states</h1>
-
-<table>
-  <tr>
-    <th>Name</th>
-    <th></th>
-    <th></th>
-    <th></th>
-  </tr>
-
-<% @states.each do |state| %>
-  <tr>
-    <td><%= state.name %></td>
-    <td><%= link_to 'Show', state %></td>
-    <td><%= link_to 'Edit', edit_state_path(state) %></td>
-    <td><%= link_to 'Destroy', state, confirm: 'Are you sure?', method: :delete %></td>
-  </tr>
-<% end %>
-</table>
-
-<br />
-
-<%= link_to 'New State', new_state_path %>
diff --git a/app/views/states/new.html.erb b/app/views/states/new.html.erb
deleted file mode 100644
index dcfb6f2..0000000
--- a/app/views/states/new.html.erb
+++ /dev/null
@@ -1,5 +0,0 @@
-<h1>New state</h1>
-
-<%= render 'form' %>
-
-<%= link_to 'Back', states_path %>
diff --git a/app/views/states/show.html.erb b/app/views/states/show.html.erb
deleted file mode 100644
index 4b191fa..0000000
--- a/app/views/states/show.html.erb
+++ /dev/null
@@ -1,10 +0,0 @@
-<p id="notice"><%= notice %></p>
-
-<p>
-  <b>Name:</b>
-  <%= @state.name %>
-</p>
-
-
-<%= link_to 'Edit', edit_state_path(@state) %> |
-<%= link_to 'Back', states_path %>
diff --git a/config/routes.rb b/config/routes.rb
index 48a7f6b..0fefae3 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -2,10 +2,6 @@ Doctor::Application.routes.draw do
 
 
 
-  resources :states
-
-  resources :countries
-
   # welcome screen
   root :to => "home#index"
 
@@ -23,6 +19,7 @@ Doctor::Application.routes.draw do
        resources  :hospitals
     match '/dashboard'  => "home#new", :as => :root
    end
+ 
 
 
 end
diff --git a/db/migrate/20120320065353_create_countries.rb b/db/migrate/20120320065353_create_countries.rb
deleted file mode 100644
index 3f621f0..0000000
--- a/db/migrate/20120320065353_create_countries.rb
+++ /dev/null
@@ -1,9 +0,0 @@
-class CreateCountries < ActiveRecord::Migration
-  def change
-    create_table :countries do |t|
-      t.string :name
-
-      t.timestamps
-    end
-  end
-end
diff --git a/db/migrate/20120320065443_create_states.rb b/db/migrate/20120320065443_create_states.rb
deleted file mode 100644
index 12a18a3..0000000
--- a/db/migrate/20120320065443_create_states.rb
+++ /dev/null
@@ -1,9 +0,0 @@
-class CreateStates < ActiveRecord::Migration
-  def change
-    create_table :states do |t|
-      t.string :name
-
-      t.timestamps
-    end
-  end
-end
diff --git a/public/javascripts/nested_form.js b/public/javascripts/nested_form.js
index d6750b9..5a805f1 100644
--- a/public/javascripts/nested_form.js
+++ b/public/javascripts/nested_form.js
@@ -1,71 +1,46 @@
-jQuery(function($) {
-  window.NestedFormEvents = function() {
-    this.addFields = $.proxy(this.addFields, this);
-    this.removeFields = $.proxy(this.removeFields, this);
-  };
-
-  NestedFormEvents.prototype = {
-    addFields: function(e) {
-      // Setup
-      var link    = e.currentTarget;
-      var assoc   = $(link).attr('data-association');            // Name of child
-      var content = $('#' + assoc + '_fields_blueprint').html(); // Fields template
-
-      // Make the context correct by replacing new_<parents> with the generated ID
-      // of each of the parent objects
-      var context = ($(link).closest('.fields').find('input:first').attr('name') || '').replace(new RegExp('\[[a-z]+\]$'), '');
-
-      // context will be something like this for a brand new form:
-      // project[tasks_attributes][new_1255929127459][assignments_attributes][new_1255929128105]
-      // or for an edit form:
-  