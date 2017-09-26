<%namespace name="TIM" file="tracim.templates.pod"/>
<%namespace name="TICKET_FORMS" file="tracim.templates.ticket.forms"/>
<%namespace name="ICON" file="tracim.templates.widgets.icon"/>

${TICKET_FORMS.NEW('form-ticket-new', result.item.workspace.id, result.item.parent.id)}
<script src="${tg.url('/assets/tinymce/js/tinymce/tinymce.min.js')}"></script>
${TIM.TINYMCE_INIT_SCRIPT('.pod-rich-textarea')}

