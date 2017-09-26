<%namespace name="TIM" file="tracim.templates.pod"/>
<%namespace name="ICON" file="tracim.templates.widgets.icon"/>

<%def name="title()"></%def>

<%def name="FORM(task)">
    <form role="form" method="POST" action="${tg.url('/workspaces/{}/folders/{}/tasks/{}?_method=PUT'.format(task.workspace.id, task.parent.id, task.id))}">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">${_('Close')}</span></button>
            <h4 class="modal-title" id="myModalLabel">${ICON.FA_FW('fa fa-check-square t-task-color')} ${_('Edit Task')}</h4>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="task-title">${_('Task')}</label>
                <input name="label" type="text" class="form-control" id="task-title" placeholder="${_('Subject')}" value="${task.label}">
            </div>
            <div class="form-group">
                <label for="task-content">${_('Detail')}</label>
                <textarea id="task-content-textarea" name="content" class="form-control pod-rich-textarea" id="task-content" placeholder="${_('Optionnaly, you can describe the subject')}">${task.content}</textarea>
            </div>
        </div>
        <div class="modal-footer">
            <span class="pull-right" style="margin-top: 0.5em;">
                <button id="task-save-button" type="submit" class="btn btn-small btn-success" title="${_('Validate')}"><i class="fa fa-check"></i> ${_('Validate')}</button>
            </span>
        </div>
        ${TIM.TINYMCE_INIT_SCRIPT('#task-content-textarea')}
    </form> 
</%def>

${FORM(result.item)}

