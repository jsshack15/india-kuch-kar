<html>
<body>
<%@ page language="java" %>
<%@ page import="com.devsphere.mapping.*, com.devsphere.logging.*" %>
<jsp:useBean id="uploadBean" scope="request"
    class="com.devsphere.examples.mapping.upload.UploadBean"/>
<%
// Determine the HTTP method
boolean isPostMethod = request.getMethod().equals("POST");

// Verify the content length
int contentLength = request.getContentLength();
if (isPostMethod && (contentLength < 0 || contentLength > 400000))
    application.log("Request ignored. Content-Length: " + contentLength);
else {
    // Get the bean resources
    java.util.ResourceBundle beanRes
        = HandlerUtils.getBeanResources(uploadBean.getClass());

    // Construct the base path
    String basePath = request.getServletPath();
    int slashIndex = basePath.lastIndexOf('/');
    basePath = slashIndex != -1 ? basePath.substring(0, slashIndex+1) : "";

    // Create a logger that wraps the servlet context
    ServletLogger logger = new ServletLogger(application);

    // Wrap the form data
    FormData formData = new ServletFormData(request, true);

    // Form-to-bean mapping: request parameters are mapped to bean properties
    java.util.Hashtable errorTable
        = FormUtils.formToBean(formData, uploadBean, logger);

    if (isPostMethod && errorTable == null) {
        // Construct the processor's path
        String procPath = basePath + beanRes.getString("[PROC_NAME]").trim();

        // Process the valid data bean instance
        application.getRequestDispatcher(procPath).forward(request, response);
    } else {
        if (!isPostMethod)
            // Ignore the user errors if the form is requested with GET.
            errorTable = HandlerUtils.removeUserErrors(errorTable);

        // Construct the form's path
        String formPath = basePath + beanRes.getString("[FORM_NAME]").trim();
        formPath = application.getRealPath(formPath);

        // Get the form template
        FormTemplate template = FormUtils.getTemplate(new java.io.File(formPath));

        // Get a new document
        FormDocument document = template.getDocument();

        // Bean-to-form mapping: bean properties are mapped to form elements
        FormUtils.beanToForm(uploadBean, errorTable, document, logger);

        // Send the form document
        document.send(out);
    }
}
%>
</body>
</html>
