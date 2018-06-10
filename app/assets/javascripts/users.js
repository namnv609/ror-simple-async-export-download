$(function() {
  var $statusElm = $("div.export-status");

  $("button#export").on("click", function(e) {
    $.ajax({
      url: "/export",
      dataType: "json"
    }).done(function(response, status, ajaxOpts) {
      if (status === "success" && response && response.jid) {
        var jobId = response.jid;
        var intervalName = "job_" + jobId;

        $statusElm.text("Exporting 0%...");
        window[intervalName] = setInterval(function() {
          getExportJobStatus(jobId, intervalName);
        }, 800);
      }
    }).fail(function(error) {
      console.log(error);
    });
  });

  function getExportJobStatus(jobId, intervalName) {
    $.ajax({
      url: "/export_status",
      dataType: "json",
      data: {
        job_id: jobId
      }
    }).done(function(response, status, ajaxOpt) {
      if (status === "success") {
        var percentage = response.percentage;

        $statusElm.text("Exporting " + percentage + "%...");

        if (response.status === "complete") {
          $statusElm.text("Export completed. Downloading...");
          setTimeout(function() {
            clearInterval(window[intervalName]);
            delete window[intervalName];

            $(location).attr("href", "/export_download.xlsx?id=" + jobId);
            $statusElm.text("");
          }, 500);
        }
      }
    }).fail(function(error) {
      console.log(error);
    });
  }
});
