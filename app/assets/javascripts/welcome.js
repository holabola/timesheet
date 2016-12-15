/**
 * Created by sbarsam on 11/8/2016.
 */



$( document ).ready(function() {
    var login,forgot,register,alertMes,loginMes,RegisterMes,lazyCheckDark;

    login = "#loginWrap";
    register = "#registerWrap";
    forgot = "#forgotWrap";
    alertMes = (($("div div li").text()).replace(/\s+/, '')).substr(0,10);
    loginMes = "Invalid Em";
    RegisterMes = "Emailcan't";
    lazyCheckDark = 1;

    /* Expense */

    function toggleAutoComplete(){
        $("#input-4").fileinput({
            showRemove: false,
            showUploadedThumbs: false,
            showUpload: true,
            allowedFileTypes: ['image'],
            maxFileCount: 1,
            showCaption: false,
        });
    }
    $(document).ready(function(){ toggleAutoComplete() });
    document.addEventListener('page:load', function(){ toggleAutoComplete() });



    /* Login */

    setTimeout(function() {
        $('.containerError').fadeOut('slow');
    }, 3000);

    if ( alertMes === loginMes) {
        $(login).css("display", "inherit");
        $("#shadowOnOff").css("opacity", "0.1");
    }
    if ( alertMes === RegisterMes) {
        $(register).css("display", "inherit");
        $("#shadowOnOff").css("opacity", "0.1");
    }

    $('.exitButton').click(function(){
        $("#shadowOnOff").css("opacity", "1");
        $(login).css("display", "none");
        $(forgot).css("display", "none");
        $(register).css("display", "none");
    });





    if (lazyCheckDark === 2) {
        $('body').click(function(evt){
            if(evt.target.id == "alertID")
                return;
            //For descendants of menu_content being clicked, remove this check if you do not want to put constraint on descendants.
            if($(evt.target).closest('#alertID').length)
                return;
            if(evt.target.id == "offBut")
                return;
            //For descendants of menu_content being clicked, remove this check if you do not want to put constraint on descendants.
            if($(evt.target).closest('#offBut').length)
                return;
            if(evt.target.id == "myCarousel")
                return;
            //For descendants of menu_content being clicked, remove this check if you do not want to put constraint on descendants.
            if($(evt.target).closest('#myCarousel').length)
                return;

            //Do processing of click event here for every element except with id menu_content
            $("#shadowOnOff").css("opacity", "1");
            $(login).css("display", "none");
            $(forgot).css("display", "none");
            $(register).css("display", "none");

        });
    }

    $('#loginToolbar').click(function(){
        $(login).css("display", "inherit");
        $("#shadowOnOff").css("opacity", "0.1");
        lazyCheckDark = 2;
    });

    $('#loginButton').click(function(){
        $(login).css("display", "inherit");
        $("#shadowOnOff").css("opacity", "0.1");
        lazyCheckDark = 2;
    });
    $('#forgotPass').click(function(){
        $(login).css("display", "none");

        $(forgot).css("display", "inherit");
    });
    $('#newUser').click(function(){
        $(login).css("display", "none");

        $(register).css("display", "inherit");
    });

    //Forgot Page
    $('#registerForgot').click(function(){
        $(forgot).css("display", "none");

        $(register).css("display", "inherit");
    });
    $('#loginForgot').click(function(){
        $(forgot).css("display", "none");

        $(login).css("display", "inherit");
    });

    //Register Page
    $('#loginRegister').click(function(){
        $(register).css("display", "none");

        $(login).css("display", "inherit");
    });





});

