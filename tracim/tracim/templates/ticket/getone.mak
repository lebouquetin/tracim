<%inherit file="local:templates.master_authenticated_left_treeview_right_toolbar"/>

<%namespace name="TIM" file="tracim.templates.pod"/>
<%namespace name="TOOLBAR" file="tracim.templates.ticket.toolbar"/>
<%namespace name="LEFT_MENU" file="tracim.templates.widgets.left_menu"/>
<%namespace name="WIDGETS" file="tracim.templates.user_workspace_widgets"/>


<%namespace name="FORMS" file="tracim.templates.ticket.forms"/>
<%namespace name="BUTTON" file="tracim.templates.widgets.button"/>
<%namespace name="TABLE_ROW" file="tracim.templates.widgets.table_row"/>
<%namespace name="ICON" file="tracim.templates.widgets.icon"/>
<%namespace name="P" file="tracim.templates.widgets.paragraph"/>



<%def name="title()">${result.ticket.label}</%def>

<%def name="SIDEBAR_LEFT_CONTENT()">
    ${LEFT_MENU.TREEVIEW('sidebar-left-menu', 'workspace_{}__item_{}'.format(result.ticket.workspace.id, result.ticket.id))}
</%def>

<%def name="SIDEBAR_RIGHT_CONTENT()">
    ${TOOLBAR.SECURED_TICKET(fake_api.current_user, result.ticket.workspace, result.ticket)}
</%def>

<%def name="REQUIRED_DIALOGS()">
    ${TIM.MODAL_DIALOG('ticket-edit-modal-dialog', 'modal-lg')}
    ${TIM.MODAL_DIALOG('ticket-move-modal-dialog')}
</%def>

############################################################################
##
## TICKET CONTENT BELOW
##
############################################################################

<div class="content-container ${'not-editable' if not result.ticket.is_editable else ''} ${'archived' if result.ticket.is_archived else ''} ${'deleted' if result.ticket.is_deleted else ''}">

    <div class="t-page-header-row bg-secondary">
        <div class="main">
            <h1 class="page-header t-ticket-color-border">
                <i class="fa fa-fw fa-lg fa-ambulance tracim-less-visible t-ticket-color"></i>
                ${result.ticket.label}
                <span class="pull-right">
                    ${WIDGETS.SECURED_SHOW_CHANGE_STATUS_FOR_TICKET(fake_api.current_user, result.ticket.workspace, result.ticket)}
                </span>
            </h1>

            <div style="margin: -1.5em auto -1.5em auto;" class="tracim-less-visible">
                <% created_localized = h.get_with_timezone(result.ticket.created) %>
                <% updated_localized = h.get_with_timezone(result.ticket.updated) %>
                <% last_modification_author = result.ticket.last_modification_author.name %>
                <p>${_('ticket created on {date} at {time} by <b>{author}</b>').format(date=h.date(created_localized), time=h.time(created_localized), author=result.ticket.owner.name)|n}
                    % if result.ticket.revision_nb > 1:
                      ${_(' (last modification on {update_date} at {update_time} by {last_modification_author})').format(update_date=h.update_date(updated_localized), update_time=h.update_time(updated_localized), last_modification_author = last_modification_author)|n}
                    % endif
                </p>

        </div>
    </div>

    % if (result.ticket.is_archived) :
    <div class="alert alert-info" role="alert">
        <div class="">
            <p>
                <span class="pull-left"><i class="fa fa-fw fa-2x fa-warning" alt="" title=""></i></span>
                ${_('Vous consultez <b>une version archivée</b> de la page courante.')|n}
            </p>
        </div>
    </div>
    % elif (result.ticket.is_deleted) :
    <div class="alert alert-info" role="alert">
        <div class="">
            <p>
                <span class="pull-left"><i class="fa fa-fw fa-2x fa-warning" alt="" title=""></i></span>
                ${_('Vous consultez <b>une version supprimée</b> du ticket.')|n}
            </p>
        </div>
    </div>
    % endif

    % if result.ticket.status.id=='closed-deprecated':
    <div class="alert alert-warning" role="alert">
        <div class="">
            <p>
                <span class="pull-left">${ICON.FA_FW_2X('fa-warning')}</span>
                ${_('<b>This information is deprecated</b>')|n}
            </p>
        </div>
    </div>
    % endif

    % if result.ticket.content:
    <div class="">
        ## TODO - 2015-07-22 - D.A. - should we show a breadcrumb or not ?
        ## <button id="current-page-breadcrumb-toggle-button" class="btn btn-link" title="${_('Show localisation')}"><i class="fa fa-map-marker"></i></button>
        ## ${WIDGETS.BREADCRUMB('current-page-breadcrumb', fake_api.breadcrumb)}

        <div class="well t-half-spacer-above">
            % if result.ticket.status.id in ('closed-validated', 'closed-unvalidated'):
                <span style="font-size: 1.5em;"><i class="pull-right fa fa-4x ${result.ticket.status.css} ${result.ticket.status.icon}"></i></span>
            % endif
            ${result.ticket.content|n}
        </div>
    </div>
    % endif

    <div class="content__detail ticket">
        <div class="tickets-history-reverse">
        % if inverted:
            <a href="${tg.url('/workspaces/{}/folders/{}/tickets/{}'.format(result.ticket.workspace.id, result.ticket.parent.id, result.ticket.id))}">
                <i class="fa fa-chevron-down" aria-hidden="true"></i>
        % else:
            <a href="${tg.url('/workspaces/{}/folders/{}/tickets/{}?inverted=1'.format(result.ticket.workspace.id, result.ticket.parent.id, result.ticket.id))}">
                <i class="fa fa-chevron-up" aria-hidden="true"></i>
        % endif
                ${_('Invert order')}
            </a>
        </div>
        % if h.user_role(fake_api.current_user, result.ticket.workspace)<=1:
            ## READONLY USER
            <% a = 'b' %>
        % else:
            % if result.ticket.status.id!='open':
                <p class="tracim-less-visible">${_('<b>Note</b>: In case you\'d like to post a reply, you must first open again the ticket')|n}</p>
            % else:
                % if (not result.ticket.is_archived and not result.ticket.is_deleted) :
                    <p class="t-half-spacer-below">
                        ${BUTTON.DATA_TARGET_AS_TEXT('new-comment', _('Post a comment...'), 'btn btn-link')}
                        ${FORMS.NEW_COMMENT_IN_TICKET('new-comment', result.ticket.workspace.id, result.ticket.parent.id, result.ticket.id)}
                    </p>
                % endif
            % endif
        % endif

        <!-- % for event in reversed(result.ticket.history): -->
        % for event in result.ticket.history:
            ## TODO - D.A. - 2015-08-20
            ## Allow to show full history (with status change and archive/unarchive)
            ${WIDGETS.SECURED_HISTORY_VIRTUAL_EVENT(fake_api.current_user, event)}
        % endfor

        ## % for comment in result.ticket.comments:
        ##     ${WIDGETS.SECURED_TIMELINE_ITEM(fake_api.current_user, comment)}
        ## % endfor
        ##

    </div>

</div>
