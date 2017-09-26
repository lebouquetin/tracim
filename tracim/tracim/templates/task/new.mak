<%namespace name="TIM" file="tracim.templates.pod"/>
<%namespace name="TASK_FORMS" file="tracim.templates.task.forms"/>
<%namespace name="ICON" file="tracim.templates.widgets.icon"/>

${TASK_FORMS.NEW('form-task-new', result.item.workspace.id, result.item.parent.id)}
<script src="${tg.url('/assets/tinymce/js/tinymce/tinymce.min.js')}"></script>
${TIM.TINYMCE_INIT_SCRIPT('.pod-rich-textarea')}

