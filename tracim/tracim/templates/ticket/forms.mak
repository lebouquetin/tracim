<%namespace name="TIM" file="tracim.templates.pod"/>
<%namespace name="BUTTON" file="tracim.templates.widgets.button"/>
<%namespace name="ICON" file="tracim.templates.widgets.icon"/>
<%namespace name="WIDGETS" file="tracim.templates.user_workspace_widgets"/>

<%def name="NEW(dom_id, workspace_id, parent_id=None)">
    <div id="{dom_id}">
        <form role="form" method="POST" enctype="multipart/form-data" action="${tg.url('/workspaces/{}/folders/{}/tasks').format(workspace_id, parent_id)}">
            <input type="hidden" name="parent_id" value="${parent_id}">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">${_('Close')}</span></button>
                <h4 class="modal-title" >${ICON.FA('fa-tasks t-task-color')} ${_('New Task')}</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="task-name">${_('Task')}</label>
                    <input id="task-name" class="form-control" name="label" type="text" placeholder="${_('...')}">
                </div>

                <div class="form-group">
                    <label for="task-message">${_('Detail')}</label>
                    <textarea id="task-message" class="form-control pod-rich-textarea" name="content" type="text" placeholder="${_('...')}"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <span class="pull-right" style="margin-top: 0.5em;">
                    <button id="folder-save-button" type="submit" class="btn btn-small btn-success" title="${_('Create task')}"><i class="fa fa-check"></i> ${_('Validate')}</button>
                </span>
            </div>
        </form>
    </div>
</%def>

<%def name="NEW_COMMENT_IN_TASK(dom_id, workspace_id, folder_id, task_id)">
    <div id="${dom_id}" class="collapse">
        <div class="pod-inline-form t-spacer-below" >
            <form role="form" method="POST" action="${tg.url('/workspaces/{}/folders/{}/tasks/{}/comments').format(workspace_id, folder_id, task_id)}">
                <div class="form-group">
                    <label for="task-message">${_('Your message')}</label>
                    <textarea id="task-message" class="form-control pod-rich-textarea" name="content" type="text" placeholder="${_('...')}"></textarea>
                </div>
                <span class="pull-right t-modal-form-submit-button">
                    <button id="${dom_id}-submit-button" type="submit" class="btn btn-small btn-success" title="${_('Validate')}"><i class=" fa fa-check"></i> ${_('Validate')}</button>
                </span>

                <div style="clear: both;"></div>
            </form>
        </div>
    </div>
</%def>

