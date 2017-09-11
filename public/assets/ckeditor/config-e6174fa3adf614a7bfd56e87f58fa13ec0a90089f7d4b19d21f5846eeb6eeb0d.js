CKEDITOR.editorConfig = function(config) {
    config.language = 'en';
    // config.width = '700';
    config.height = '250';
    config.enterMode = CKEDITOR.ENTER_BR;
    config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
    config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
    config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
    config.filebrowserImageUploadUrl = "/ckeditor/pictures";
    config.filebrowserUploadUrl = "/ckeditor/attachment_files";
    config.toolbar = 'Pure';
    config.allowedContent = true;
    myFonts = ['Architects Daughter', 'Open Sans', 'Dancing Script'];
    config.font_names = 'sans serif';

    for(var i = 0; i<myFonts.length; i++){
     config.font_names = config.font_names+';'+myFonts[i];
     myFonts[i] = 'http://fonts.googleapis.com/css?family='+myFonts[i].replace(' ','+');

     //assuming you use jquery
     $("head").append("<link rel='stylesheet' href='"+ myFonts[i] +"'>");
  }

    config.toolbar_Pure = [
        { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
        { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
      
        '/',
       
        { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv',
        '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
        '/',
        
    ];
  
    return true; 
}

;
