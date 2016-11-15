/**
 * Created by sbarsam on 11/8/2016.
 */



$( document ).ready(function() {
    var login,forgot,register;
    login = "#loginWrap";
    register = "#registerWrap";
    forgot = "#forgotWrap";

    //alert("This javascript thing is reals making me mad! IT WORKS");
    $('#loginButton').click(function(){
        //$(login).css("display", "inherit");
        //$(login).css("visibility", "visible");
        //$(login).css("opacity", "1");
        $(login).css("display", "inherit");
        $("#shadowOnOff").css("opacity", "0.1");
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