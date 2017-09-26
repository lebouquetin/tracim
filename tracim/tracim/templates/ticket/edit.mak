<%namespace name="TIM" file="tracim.templates.pod"/>
<%namespace name="ICON" file="tracim.templates.widgets.icon"/>

<%def name="title()"></%def>

<%def name="FORM(ticket)">
    <form role="form" method="POST" action="${tg.url('/workspaces/{}/folders/{}/tickets/{}?_method=PUT'.format(ticket.workspace.id, ticket.parent.id, ticket.id))}">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">${_('Close')}</span></button>
            <h4 class="modal-title" id="myModalLabel">${ICON.FA_FW('fa fa-ambulances t-ticket-color')} ${_('Edit Ticket')}</h4>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="ticket-title">${_('Ticket')}</label>
                <input name="label" type="text" class="form-control" id="ticket-title" placeholder="${_('Subject')}" value="${ticket.label}">
            </div>
            <div class="form-group">
                <label for="ticket-content">${_('Detail')}</label>
                <textarea id="ticket-content-textarea" name="content" class="form-control pod-rich-textarea" id="ticket-content" placeholder="${_('Optionnaly, you can describe the subject')}">${ticket.content}</textarea>
            </div>
        </div>
        <div class="modal-footer">
            <span class="pull-right" style="margin-top: 0.5em;">
                <button id="ticket-save-button" type="submit" class="btn btn-small btn-success" title="${_('Validate')}"><i class="fa fa-check"></i> ${_('Validate')}</button>
            </span>
        </div>
        ${TIM.TINYMCE_INIT_SCRIPT('#ticket-content-textarea')}
    </form> 
</%def>

${FORM(result.item)}

