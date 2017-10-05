Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60676 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdJEQCo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Oct 2017 12:02:44 -0400
From: Thierry Escande <thierry.escande@collabora.com>
To: Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] platform/chrome: cros_ec_lpc: Register the driver if ACPI entry is missing.
Date: Thu,  5 Oct 2017 18:02:34 +0200
Message-Id: <1507219357-5722-2-git-send-email-thierry.escande@collabora.com>
In-Reply-To: <1507219357-5722-1-git-send-email-thierry.escande@collabora.com>
References: <1507219357-5722-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Commit 12278dc7c572 ("platform/chrome: cros_ec_lpc: Add support for
GOOG004 ACPI device") added support when the firmware reports the ACPI
device, there are some firmwares though that doesn't report this device
but have it. In such cases we need to instantiate the driver explicitly
if it is not instantiated through ACPI.

Fixes: 12278dc7c572 ("platform/chrome: cros_ec_lpc: Add support for GOOG004 ACPI device")
Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 1baf720..0b26a09 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -35,6 +35,9 @@
 #define DRV_NAME "cros_ec_lpcs"
 #define ACPI_DRV_NAME "GOOG0004"
 
+/* True if ACPI device is present */
+static bool cros_ec_lpc_acpi_device_found;
+
 static int ec_response_timed_out(void)
 {
 	unsigned long one_second = jiffies + HZ;
@@ -396,9 +399,21 @@ static struct platform_driver cros_ec_lpc_driver = {
 	.remove = cros_ec_lpc_remove,
 };
 
+static struct platform_device cros_ec_lpc_device = {
+	.name = DRV_NAME
+};
+
+static acpi_status cros_ec_lpc_parse_device(acpi_handle handle, u32 level,
+					    void *context, void **retval)
+{
+	*(bool *)context = true;
+	return AE_CTRL_TERMINATE;
+}
+
 static int __init cros_ec_lpc_init(void)
 {
 	int ret;
+	acpi_status status;
 
 	if (!dmi_check_system(cros_ec_lpc_dmi_table)) {
 		pr_err(DRV_NAME ": unsupported system.\n");
@@ -415,11 +430,28 @@ static int __init cros_ec_lpc_init(void)
 		return ret;
 	}
 
-	return 0;
+	status = acpi_get_devices(ACPI_DRV_NAME, cros_ec_lpc_parse_device,
+				  &cros_ec_lpc_acpi_device_found, NULL);
+	if (ACPI_FAILURE(status))
+		pr_warn(DRV_NAME ": Looking for %s failed\n", ACPI_DRV_NAME);
+
+	if (!cros_ec_lpc_acpi_device_found) {
+		/* Register the device, and it'll get hooked up automatically */
+		ret = platform_device_register(&cros_ec_lpc_device);
+		if (ret) {
+			pr_err(DRV_NAME ": can't register device: %d\n", ret);
+			platform_driver_unregister(&cros_ec_lpc_driver);
+			cros_ec_lpc_reg_destroy();
+		}
+	}
+
+	return ret;
 }
 
 static void __exit cros_ec_lpc_exit(void)
 {
+	if (!cros_ec_lpc_acpi_device_found)
+		platform_device_unregister(&cros_ec_lpc_device);
 	platform_driver_unregister(&cros_ec_lpc_driver);
 	cros_ec_lpc_reg_destroy();
 }
-- 
2.7.4

