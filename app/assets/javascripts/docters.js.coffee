# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
<script type="text/javascript">
    $(document).ready(function()
    {
        $("select#docter_categories_d_id").change(function()
        {
            var id_value_string = $(this).val();
            if (id_value_string == "") 
            {
                // if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
                $("select#docter_sub_categories_d_id option").remove();
                var row = "<option value=\"" + "" + "\">" + "" + "</option>";
                $(row).appendTo("select#docter_sub_categories_d_id");
            }
            else 
            {
                // Send the request and update sub category dropdown
                $.ajax({
                    dataType: "json",
                    cache: false,
                    url: '/sub_categories_ds/for_categories_d_id/' + id_value_string,
                    timeout: 2000,
                    error: function(XMLHttpRequest, errorTextStatus, error){
                        alert("Failed to submit : "+ errorTextStatus+" ;"+error);
                    },
                    success: function(data){                    
                        // Clear all options from sub category select
                        $("select#docter_sub_categories_d_id option").remove();
                        //put in a empty default line
                        var row = "<option value=\"" + "" + "\">" + "" + "</option>";
                        $(row).appendTo("select#docter_sub_categories_d_id");                        
                        // Fill sub category select
                        $.each(data, function(i, j){
                            row = "<option value=\"" + j.sub_categories_d.id + "\">" + j.sub_categories_d.name + "</option>";  
                            $(row).appendTo("select#docter_sub_categories_d_id");                    
                        });            
                     }
                });
            };
                });
    });
</script>