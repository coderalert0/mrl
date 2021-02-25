function showTab(clicked_id) {
    // Hide all text fields
    var divs = ["js-program", "js-program-visa", "js-program-contact", "js-program-statistics", "js-program-misc"];
    var arrayLength = divs.length;
    for (var i = 0; i < arrayLength; i++) {
        element = document.getElementById(divs[i]);
        element.classList.add('d-none')
    }

    // Show fields for clicked tab
    var element = document.getElementById(clicked_id.replace('-tab', ''));
    element.classList.remove('d-none');

    // Make all tabs inactive
    var tabs = document.getElementsByClassName('nav-link')
    for(var i = tabs.length-1; i > -1; i--) {
        tabs[i].classList.remove("active");
    }

    // Make clicked tab active
    var clicked_tab = document.getElementById(clicked_id);
    clicked_tab.classList.add('active');

}