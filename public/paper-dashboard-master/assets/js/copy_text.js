function copyClipboard() {
    var elm = document.getElementById("textToCopy");
    // for Internet Explorer

    if(document.body.createTextRange) {
        var range = document.body.createTextRange();
        range.moveToElementText(elm);
        range.select();
        document.execCommand("Copy");

        var div = document.getElementById('js-placeholder');
        div.innerHTML = '<p class="alert alert-success">Program ID copied to clipboard</p>';
    }
    else if(window.getSelection) {
        // other browsers

        var selection = window.getSelection();
        var range = document.createRange();
        range.selectNodeContents(elm);
        selection.removeAllRanges();
        selection.addRange(range);
        document.execCommand("Copy");

        var div = document.getElementById('js-placeholder');
        div.innerHTML = '<p class="alert alert-success">Program ID copied to clipboard</p>';
    }
}