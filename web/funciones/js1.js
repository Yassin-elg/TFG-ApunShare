/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validarRegistro() {
    var spanGmail = document.getElementById("spanGmail");
    spanGmail.innerHTML = "";
    var spanClave = document.getElementById("spanClave");
    spanClave.innerHTML = "";
    var spanRClave = document.getElementById("spanRClave");
    spanRClave.innerHTML = "";
    var spanNombre = document.getElementById("spanNombre");
    spanNombre.innerHTML = "";

    var ok = "true";
    var f = document.getElementById("registro");
    
    //validar correo  
    if (f.correo.value === "") {
        ok = false;
        spanGmail.innerHTML = "Correo Requerido.";
    }
    ;
    //validar clave
    var clave = document.getElementById("clave");
    var numbers = /[0-9]/g;
    var capitals = /[A-Z]/g;
    if (f.clave.value === "") {//si es vacio
        ok = false;
        spanClave.innerHTML = "Clave requerida.";
    } else if (clave.value.length < 7) {//si es menor que 7
        ok = false;
        spanClave.innerHTML = "La clave debe contener almenos 7 caracteres.";
    } else if (!clave.value.match(numbers)) {//si no tiene numero
        ok = false;
        spanClave.innerHTML = "La clave debe contener almenos 1 número.";
    }else if (!clave.value.match(capitals)) {//si no tiene mayúsculas
        ok = false;
        spanClave.innerHTML = "La clave debe contener almenos 1 letra mayúscula.";
    }
    ;
    //validar repetir clave
    if (f.rclave.value === "") {
        ok = false;
        spanRClave.innerHTML = "Es necesario que los campos \"Clave\" y \"Repetir clave\" coincidan.";
    } else if (f.rclave.value != f.clave.value) {
        ok = false;
        spanRClave.innerHTML = "Claves diferentes.";
    }
    ;
    //validar nombre
    if (f.nombre.value === "") {
        ok = false;
        spanNombre.innerHTML = "Nombre Requerido.";
    }
    ;

    return ok;
}

function validarSubida() {
    var spanTipo = document.getElementById("spanTipo");
    spanTipo.innerHTML = "";
    var spanArchivo = document.getElementById("spanArchivo");
    spanArchivo.innerHTML = "";
    var spanEnlace = document.getElementById("spanEnlace");
    spanEnlace.innerHTML = "";
    var spanNombre = document.getElementById("spanNombre");
    spanNombre.innerHTML = "";

    var ok = "true";
    var f = document.getElementById("formSubida");
    
    //validar eleccion de subida
    if (!document.getElementById('radioArchivo').checked && !document.getElementById('radioEnlace').checked) {
        ok = false;
        spanTipo.innerHTML = "Debe seleccionar una opción de subida";
    }
    ;
    //validar archivo
    var ext = f.archivo.value.substring(f.archivo.value.lastIndexOf('.') + 1);
    if (document.getElementById('radioArchivo').checked && f.archivo.files.length == 0) {//Si es vacio
        ok = false;
        spanArchivo.innerHTML = "Debe elegir un archivo.";
    } else if (ext !== "pdf"){
        ok = false;
        spanArchivo.innerHTML = "El archivo subido debe ser de tipo PDF.";
    }
    ;
    //validar enlace
    if (document.getElementById('radioEnlace').checked && f.enlace.value === "") {
        ok = false;
        spanEnlace.innerHTML = "Debe insertar un enlace.";
    }
    ;
    //validar nombre
    if (f.nombre.value === "") {
        ok = false;
        spanNombre.innerHTML = "Nombre Requerido.";
    }
    ;

    return ok;
}

function subidaArchivo() {
    var x = document.getElementById("archivo");
    var y = document.getElementById("enlace");
    x.style.display = "block";
    y.style.display = "none";

}

function subidaEnlace() {
    var x = document.getElementById("archivo");
    var y = document.getElementById("enlace");
    x.style.display = "none";
    y.style.display = "block";

}

function confirmarBajaUsuario(nombre) {
    var answer = confirm("¿ Está seguro de que desea dar de baja a al usuario " + nombre + " ?");
    if (answer == true) {
        return true;
    } else {
        return false;
    }
}

function confirmarBorrarFavoritos(nombre) {
    var answer = confirm("¿ Está seguro de que desea eliminar " + nombre + " de su lista de favoritos ?");
    if (answer == true) {
        return true;
    } else {
        return false;
    }
}

function confirmarCerrarSesion() {
    var answer = confirm("¿ Está seguro de que desea salir de ApunShare ?");
    if (answer == true) {
        return true;
    } else {
        return false;
    }
}

function confirmarBorrarPdf(pdf, asig) {
    var answer = confirm("¿ Está seguro de que desea borrar el archivo " + pdf + " de la asignatura " + asig + " ?");
    if (answer == true) {
        return true;
    } else {
        return false;
    }
}

function AsigFav(asig) {
    alert("Se ha añadido la asignatura " + asig + " a su lista de favoritos.");

}

function confirmarSubidaApuntes() {
    var answer = confirm("                                            DISCLAIMER:\n\
Al subir contenido a ApunShare usted se hace responsable del mismo. En caso de que sea contenido inadecuado o irrelevante será eliminado por los administradores de la web.");
    if (answer == true) {
        return true;
    } else {
        return false;
    }
}

function confirmarBorrarNotif() {
    var answer = confirm("¿ Está seguro de que desea borrar esta notificación de su perfil ?");
    if (answer == true) {
        return true;
    } else {
        return false;
    }
}

function mostrarNotif() {
    if (document.getElementById("motrarNotifLeidas").style.display == "none") {
        document.getElementById("motrarNotifLeidas").style.display = "block";
        document.getElementById("botonMostrar").firstChild.data = "Ocultar";
    } else if (document.getElementById("motrarNotifLeidas").style.display == "block") {
        document.getElementById("motrarNotifLeidas").style.display = "none";
        document.getElementById("botonMostrar").firstChild.data = "Mostrar";
    }
}

function confirmarBorrarGrado(nombre) {
    var answer = confirm("¿ Está seguro de que desea borrar el grado " + nombre + " de Apunshare ? Si borra este grado, también se borrarán todas las asignaturas y apuntes asociados a él.");
    if (answer == true) {
        return true;
    } else {
        return false;
    }
}

function confirmarBorrarAsig(nombre) {
    var answer = confirm("¿ Está seguro de que desea borrar la asignautra " + nombre + " de Apunshare ? Si borra esta asignatura, también se borrarán todos los apuntes y exámenes asociados a ella.");
    if (answer == true) {
        return true;
    } else {
        return false;
    }
}

function añadirAsig() {
    document.getElementById("formAsig").style.display = "block";
    document.getElementById("cancelAsig").style.display = "block";
}

function cancelAsig() {
    document.getElementById("formAsig").style.display = "none";
    document.getElementById("cancelAsig").style.display = "none";
}

function añadirGrado() {
    document.getElementById("formGrado").style.display = "block";
    document.getElementById("cancelGrado").style.display = "block";
}

function cancelGrado() {
    document.getElementById("formGrado").style.display = "none";
    document.getElementById("cancelGrado").style.display = "none";
}

function onSignIn(googleUser) {
    var profile = googleUser.getBasicProfile();
    var idToken = googleUser.getAuthResponse().id_token;

    var auth2 = gapi.auth2.getAuthInstance();
    auth2.disconnect();
    gapi.auth2.getAuthInstance().disconnect().then(function () {

        console.log('ID: ' + profile.getId());
        console.log('Name: ' + profile.getName());
        console.log('Image URL: ' + profile.getImageUrl());
        console.log('Email: ' + profile.getEmail());
        console.log('id_token: ' + googleUser.getAuthResponse().id_token);

        var idToken = googleUser.getAuthResponse().id_token;

        var redirectUrl = 'loginGmail';

        var form = $('<form action="' + redirectUrl + '" method="post">' +
                '<input type="text" name="nombre" value="' +
                profile.getName() + '" />' +
                '<input type="text" name="correo" value="' +
                profile.getEmail() + '" />' +
                '</form>');
        $('body').append(form);
        form.submit();

    });

}

