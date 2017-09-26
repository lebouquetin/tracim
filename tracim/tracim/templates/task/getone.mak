<%inherit file="local:templates.master_authenticated_left_treeview_right_toolbar"/>

<%namespace name="TIM" file="tracim.templates.pod"/>
<%namespace name="TOOLBAR" file="tracim.templates.task.toolbar"/>
<%namespace name="LEFT_MENU" file="tracim.templates.widgets.left_menu"/>
<%namespace name="WIDGETS" file="tracim.templates.user_workspace_widgets"/>


<%namespace name="FORMS" file="tracim.templates.task.forms"/>
<%namespace name="BUTTON" file="tracim.templates.widgets.button"/>
<%namespace name="TABLE_ROW" file="tracim.templates.widgets.table_row"/>
<%namespace name="ICON" file="tracim.templates.widgets.icon"/>
<%namespace name="P" file="tracim.templates.widgets.paragraph"/>



<%def name="title()">${result.task.label}</%def>

<%def name="SIDEBAR_LEFT_CONTENT()">
    ${LEFT_MENU.TREEVIEW('sidebar-left-menu', 'workspace_{}__item_{}'.format(result.task.workspace.id, result.task.id))}
</%def>

<%def name="SIDEBAR_RIGHT_CONTENT()">
    ${TOOLBAR.SECURED_TASK(fake_api.current_user, result.task.workspace, result.task)}
</%def>

<%def name="REQUIRED_DIALOGS()">
    ${TIM.MODAL_DIALOG('task-edit-modal-dialog', 'modal-lg')}
    ${TIM.MODAL_DIALOG('task-move-modal-dialog')}
</%def>

############################################################################
##
## TASK CONTENT BELOW
##
############################################################################

<div class="content-container ${'not-editable' if not result.task.is_editable else ''} ${'archived' if result.task.is_archived else ''} ${'deleted' if result.task.is_deleted else ''}">

    <div class="t-page-header-row bg-secondary">
        <div class="main">
            <h1 class="page-header t-task-color-border">
                <i class="fa fa-fw fa-lg fa-check-square tracim-less-visible t-task-color"></i>
                ${result.task.label}
                <span class="pull-right">
                    ${WIDGETS.SECURED_SHOW_CHANGE_STATUS_FOR_TASK(fake_api.current_user, result.task.workspace, result.task)}
                </span>
            </h1>

            <div style="margin: -1.5em auto -1.5em auto;" class="tracim-less-visible">
                <% created_localized = h.get_with_timezone(result.task.created) %>
                <% updated_localized = h.get_with_timezone(result.task.updated) %>
                <% last_modification_author = result.task.last_modification_author.name %>
                <p>${_('task created on {date} at {time} by <b>{author}</b>').format(date=h.date(created_localized), time=h.time(created_localized), author=result.task.owner.name)|n}
                    % if result.task.revision_nb > 1:
                      ${_(' (last modification on {update_date} at {update_time} by {last_modification_author})').format(update_date=h.update_date(updated_localized), update_time=h.update_time(updated_localized), last_modification_author = last_modification_author)|n}
                    % endif
                </p>

        </div>
    </div>

    % if (result.task.is_archived) :
    <div class="alert alert-info" role="alert">
        <div class="">
            <p>
                <span class="pull-left"><i class="fa fa-fw fa-2x fa-warning" alt="" title=""></i></span>
                ${_('Vous consultez <b>une version archivée</b> de la page courante.')|n}
            </p>
        </div>
    </div>
    % elif (result.task.is_deleted) :
    <div class="alert alert-info" role="alert">
        <div class="">
            <p>
                <span class="pull-left"><i class="fa fa-fw fa-2x fa-warning" alt="" title=""></i></span>
                ${_('Vous consultez <b>une version supprimée</b> de la page courante.')|n}
            </p>
        </div>
    </div>
    % endif

    % if result.task.status.id=='closed-deprecated':
    <div class="alert alert-warning" role="alert">
        <div class="">
            <p>
                <span class="pull-left">${ICON.FA_FW_2X('fa-warning')}</span>
                ${_('<b>This information is deprecated</b>')|n}
            </p>
        </div>
    </div>
    % endif

    % if result.task.content:
    <div class="">
        ## TODO - 2015-07-22 - D.A. - should we show a breadcrumb or not ?
        ## <button id="current-page-breadcrumb-toggle-button" class="btn btn-link" title="${_('Show localisation')}"><i class="fa fa-map-marker"></i></button>
        ## ${WIDGETS.BREADCRUMB('current-page-breadcrumb', fake_api.breadcrumb)}

        <div class="well t-half-spacer-above">
            % if result.task.status.id in ('closed-validated', 'closed-unvalidated'):
                <span style="font-size: 1.5em;"><i class="pull-right fa fa-4x ${result.task.status.css} ${result.task.status.icon}"></i></span>
            % endif
            ${result.task.content|n}
        </div>
    </div>
    % endif

    <div class="content__detail task">
        <div class="tasks-history-reverse">
        % if inverted:
            <a href="${tg.url('/workspaces/{}/folders/{}/tasks/{}'.format(result.task.workspace.id, result.task.parent.id, result.task.id))}">
                <i class="fa fa-chevron-down" aria-hidden="true"></i>
        % else:
            <a href="${tg.url('/workspaces/{}/folders/{}/tasks/{}?inverted=1'.format(result.task.workspace.id, result.task.parent.id, result.task.id))}">
                <i class="fa fa-chevron-up" aria-hidden="true"></i>
        % endif
                ${_('Invert order')}
            </a>
        </div>
        % if h.user_role(fake_api.current_user, result.task.workspace)<=1:
            ## READONLY USER
            <% a = 'b' %>
        % else:
            % if result.task.status.id!='open':
                <p class="tracim-less-visible">${_('<b>Note</b>: In case you\'d like to post a reply, you must first open again the task')|n}</p>
            % else:
                % if (not result.task.is_archived and not result.task.is_deleted) :
                    <p class="t-half-spacer-below">
                        ${BUTTON.DATA_TARGET_AS_TEXT('new-comment', _('Post a comment...'), 'btn btn-link')}
                        ${FORMS.NEW_COMMENT_IN_TASK('new-comment', result.task.workspace.id, result.task.parent.id, result.task.id)}
                    </p>
                % endif
            % endif
        % endif

        <!-- % for event in reversed(result.task.history): -->
        % for event in result.task.history:
            ## TODO - D.A. - 2015-08-20
            ## Allow to show full history (with status change and archive/unarchive)
            ${WIDGETS.SECURED_HISTORY_VIRTUAL_EVENT(fake_api.current_user, event)}
        % endfor

        ## % for comment in result.task.comments:
        ##     ${WIDGETS.SECURED_TIMELINE_ITEM(fake_api.current_user, comment)}
        ## % endfor
        ##

    </div>

</div>
