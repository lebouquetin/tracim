<%namespace name="TIM" file="tracim.templates.pod"/>
<%namespace name="BUTTON" file="tracim.templates.widgets.button"/>
<%namespace name="ICON" file="tracim.templates.widgets.icon"/>
<%namespace name="WIDGETS" file="tracim.templates.user_workspace_widgets"/>

<%def name="NEW(dom_id, workspace_id, parent_id=None)">
    <div id="{dom_id}">
        <form role="form" method="POST" enctype="multipart/form-data" action="${tg.url('/workspaces/{}/folders/{}/tickets').format(workspace_id, parent_id)}">
            <input type="hidden" name="parent_id" value="${parent_id}">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">${_('Close')}</span></button>
                <h4 class="modal-title" >${ICON.FA('fa-ambulances t-ticket-color')} ${_('New ticket')}</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="ticket-name">${_('Label')}</label>
                    <input id="ticket-name" class="form-control" name="label" type="text" placeholder="${_('...')}">
                </div>

                <div class="form-group">
                    <label for="ticket-message">${_('Detailled description')}</label>
                    <textarea id="ticket-message" class="form-control pod-rich-textarea" name="content" type="text" placeholder="${_('...')}"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <span class="pull-right" style="margin-top: 0.5em;">
                    <button id="folder-save-button" type="submit" class="btn btn-small btn-success" title="${_('Create ticket')}"><i class="fa fa-check"></i> ${_('Validate')}</button>
                </span>
            </div>
        </form>
    </div>
</%def>

<%def name="NEW_COMMENT_IN_TICKET(dom_id, workspace_id, folder_id, ticket_id)">
    <div id="${dom_id}" class="collapse">
        <div class="pod-inline-form t-spacer-below" >
            <form role="form" method="POST" action="${tg.url('/workspaces/{}/folders/{}/tickets/{}/comments').format(workspace_id, folder_id, ticket_id)}">
                <div class="form-group">
                    <label for="ticket-message">${_('Your message')}</label>
                    <textarea id="ticket-message" class="form-control pod-rich-textarea" name="content" type="text" placeholder="${_('...')}"></textarea>
                </div>
                <span class="pull-right t-modal-form-submit-button">
                    <button id="${dom_id}-submit-button" type="submit" class="btn btn-small btn-success" title="${_('Validate')}"><i class=" fa fa-check"></i> ${_('Validate')}</button>
                </span>

                <div style="clear: both;"></div>
            </form>
        </div>
    </div>
</%def>

