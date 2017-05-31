(function() {
  CKEDITOR.editorConfig = function(config) {
    config.language = 'en';
    config.height = '600';
    config.toolbar_Pure = [
      {
        name: 'document',
        items: ['Source', '-', 'Save', 'NewPage', 'DocProps', 'Preview', 'Print', '-', 'Templates']
      }, {
        name: 'clipboard',
        items: ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo']
      }, {
        name: 'editing',
        items: ['Find', 'Replace', '-', 'SelectAll', '-', 'SpellChecker', 'Scayt']
      }, {
        name: 'tools',
        items: ['Maximize', 'ShowBlocks', '-', 'About']
      }, '/', {
        name: 'basicstyles',
        items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat']
      }, {
        name: 'paragraph',
        items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl']
      }, {
        name: 'links',
        items: ['Link', 'Unlink', 'Anchor']
      }, '/', {
        name: 'styles',
        items: ['Styles', 'Format', 'Font', 'FontSize']
      }, {
        name: 'colors',
        items: ['TextColor', 'BGColor']
      }, {
        name: 'insert',
        items: ['Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak']
      }
    ];
    config.toolbar = 'Pure';
    return true;
  };

}).call(this);
