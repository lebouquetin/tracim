<%namespace name="TIM" file="tracim.templates.pod"/>
<%namespace name="ICON" file="tracim.templates.widgets.icon"/>
<%namespace name="BUTTON" file="tracim.templates.widgets.button"/>

<%def name="SECURED_TASK(user, workspace, task)">

    % if task.is_editable:
        <div class="btn-group btn-group-vertical">
            ${BUTTON.MARK_CONTENT_READ_OR_UNREAD(user, workspace, task)}
        </div>
        <hr class="t-toolbar-btn-group-separator"/>
        <p></p>
    % endif

    <% edit_disabled = ('', 'disabled')[task.selected_revision!='latest' or task.status.id[:6]=='closed'] %>
    <% delete_or_archive_disabled = ('', 'disabled')[task.selected_revision!='latest'] %> 
    % if h.user_role(user, workspace)>1 and task.is_editable:
        <div class="btn-group btn-group-vertical">
            <a title="${_('Edit current task')}" class="btn btn-default ${edit_disabled}" data-toggle="modal" data-target="#task-edit-modal-dialog" data-remote="${tg.url('/workspaces/{}/folders/{}/tasks/{}/edit'.format(task.workspace.id, task.parent.id, task.id))}" >
                ${ICON.FA_FW('t-less-visible fa fa-edit')}
                ${_('Edit')}
            </a>
        </div>
        <p></p>
    % endif
    
    % if (user.profile.id>=3 or h.user_role(user, workspace)>=4) and task.is_editable:
        ## if the user can see the toolbar, it means he is the workspace manager.
        ## So now, we need to know if he alsa has right to delete workspaces
        <div class="btn-group btn-group-vertical">
            <a title="${_('Archive task')}" class="btn btn-default ${delete_or_archive_disabled}" href="${tg.url('/workspaces/{}/folders/{}/tasks/{}/put_archive'.format(task.workspace.id, task.parent.id, task.id))}">
                ${ICON.FA_FW('t-less-visible fa fa-archive')}
                ${_('Archive')}
            </a>
            <a title="${_('Delete task')}" class="btn btn-default ${delete_or_archive_disabled}" href="${tg.url('/workspaces/{}/folders/{}/tasks/{}/put_delete'.format(task.workspace.id, task.parent.id, task.id))}">
                ${ICON.FA_FW('t-less-visible fa fa-trash')}
                ${_('Delete')}
            </a>
        </div>
    % endif

    % if task.is_deleted or task.is_archived:
        <div class="btn-group btn-group-vertical">
            % if task.is_archived:
                <a title="${_('Restore')}"
                   class="btn btn-default"
                   href="${tg.url('/workspaces/{}/folders/{}/tasks/{}/put_archive_undo'.format(task.workspace.id, task.parent.id, task.id))}">
                    <i class="fa fa-archive fa-fw tracim-less-visible"></i>
                    ${_('Restore')}
                </a>
            % endif
            % if task.is_deleted:
                <a title="${_('Restore')}"
                   class="btn btn-default"
                   href="${tg.url('/workspaces/{}/folders/{}/tasks/{}/put_delete_undo'.format(task.workspace.id, task.parent.id, task.id))}">
                    <i class="fa fa-archive fa-fw tracim-less-visible"></i>
                    ${_('Restore')}
                </a>
            % endif
        </div>
        <p></p>
    % endif

</%def>

