$(document).ready( function() {
    var x = "";
    var y = "";
    var direction = "horizontal";
    console.log("in js file");

//    slick the cells
    $( ".cell" ).click(function() {
        console.log("In the click function");
        if ( !$( this ).hasClass( "active" ) ) {
            console.log("In the active setup");
            x = $( this ).data('x');
            console.log("x is " + x);
            y = $( this ).data('y');
            console.log("y is " + y);
            $( "*" ).removeClass( "clicked" );
            $( this ).addClass( "clicked" );
        }
    });

//    click the direction button
    $( ".btn-primary" ).click(function() {
        direction = $(this).data('direction');
        console.log("direction is " + direction);
    });

//    click the submit button
    $('#submit').click(function() {
        window.location = 'http://' + location.host + '/setup?x=' + x + '&y=' + y + '&direction=' + direction;
    });
} );