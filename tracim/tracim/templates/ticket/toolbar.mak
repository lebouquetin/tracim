<%namespace name="TIM" file="tracim.templates.pod"/>
<%namespace name="ICON" file="tracim.templates.widgets.icon"/>
<%namespace name="BUTTON" file="tracim.templates.widgets.button"/>

<%def name="SECURED_TICKET(user, workspace, ticket)">

    % if ticket.is_editable:
        <div class="btn-group btn-group-vertical">
            ${BUTTON.MARK_CONTENT_READ_OR_UNREAD(user, workspace, ticket)}
        </div>
        <hr class="t-toolbar-btn-group-separator"/>
        <p></p>
    % endif

    <% edit_disabled = ('', 'disabled')[ticket.selected_revision!='latest' or ticket.status.id[:6]=='closed'] %>
    <% delete_or_archive_disabled = ('', 'disabled')[ticket.selected_revision!='latest'] %> 
    % if h.user_role(user, workspace)>1 and ticket.is_editable:
        <div class="btn-group btn-group-vertical">
            <a title="${_('Edit current ticket')}" class="btn btn-default ${edit_disabled}" data-toggle="modal" data-target="#ticket-edit-modal-dialog" data-remote="${tg.url('/workspaces/{}/folders/{}/tickets/{}/edit'.format(ticket.workspace.id, ticket.parent.id, ticket.id))}" >
                ${ICON.FA_FW('t-less-visible fa fa-edit')}
                ${_('Edit')}
            </a>
        </div>
        <p></p>
    % endif
    
    % if (user.profile.id>=3 or h.user_role(user, workspace)>=4) and ticket.is_editable:
        ## if the user can see the toolbar, it means he is the workspace manager.
        ## So now, we need to know if he alsa has right to delete workspaces
        <div class="btn-group btn-group-vertical">
            <a title="${_('Archive ticket')}" class="btn btn-default ${delete_or_archive_disabled}" href="${tg.url('/workspaces/{}/folders/{}/tickets/{}/put_archive'.format(ticket.workspace.id, ticket.parent.id, ticket.id))}">
                ${ICON.FA_FW('t-less-visible fa fa-archive')}
                ${_('Archive')}
            </a>
            <a title="${_('Delete ticket')}" class="btn btn-default ${delete_or_archive_disabled}" href="${tg.url('/workspaces/{}/folders/{}/tickets/{}/put_delete'.format(ticket.workspace.id, ticket.parent.id, ticket.id))}">
                ${ICON.FA_FW('t-less-visible fa fa-trash')}
                ${_('Delete')}
            </a>
        </div>
    % endif

    % if ticket.is_deleted or ticket.is_archived:
        <div class="btn-group btn-group-vertical">
            % if ticket.is_archived:
                <a title="${_('Restore')}"
                   class="btn btn-default"
                   href="${tg.url('/workspaces/{}/folders/{}/tickets/{}/put_archive_undo'.format(ticket.workspace.id, ticket.parent.id, ticket.id))}">
                    <i class="fa fa-archive fa-fw tracim-less-visible"></i>
                    ${_('Restore')}
                </a>
            % endif
            % if ticket.is_deleted:
                <a title="${_('Restore')}"
                   class="btn btn-default"
                   href="${tg.url('/workspaces/{}/folders/{}/tickets/{}/put_delete_undo'.format(ticket.workspace.id, ticket.parent.id, ticket.id))}">
                    <i class="fa fa-archive fa-fw tracim-less-visible"></i>
                    ${_('Restore')}
                </a>
            % endif
        </div>
        <p></p>
    % endif

</%def>

