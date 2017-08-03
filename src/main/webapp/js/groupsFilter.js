
var usersTable = document.getElementById('users-table');

/**
 * A function that filters list of users by selected group.
 * Called by clicking on group row in table.
 * @param groupCell
 */
function groupSelection(groupCell) {
    
    showAllGroups();

    var groupName = groupCell.innerHTML;

    for (i = 1; i < usersTable.rows.length; i += 2) {
        if (usersTable.rows[i].nextElementSibling.cells[1].innerHTML.indexOf(groupName) == -1) {
            usersTable.rows[i].style.display = 'none';
        }
    }
};

/**
 * A function to remove previously added filters.
 */
function showAllGroups() {
    for (i = 1; i < usersTable.rows.length; i++) {
        usersTable.rows[i].style.display = '';
    }
}