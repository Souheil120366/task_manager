$(document).ready(function() {
    $("#title, #description, #date").on("input", function() {
        var errorsId = $(this).attr("id") + "Errors";
        $("#" + errorsId).html(""); // Clear the error messages
    });
});