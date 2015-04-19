Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24938 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490AbbDSJKM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 19 Apr 2015 05:10:12 -0400
From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 5/5] iio: ltr501: Add ACPI enumeration support
Date: Sun, 19 Apr 2015 02:10:04 -0700
Message-Id: <24456f45bdb0586e6058a18f0c76ff455ffe5ea1.1429433882.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1429433882.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1429433882.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1429433882.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1429433882.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added ACPI enumeration support for LTR501 chip.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index d9b4536..0162e86 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
+#include <linux/acpi.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/events.h>
@@ -1264,6 +1265,12 @@ static int ltr501_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
+static const struct acpi_device_id ltr_acpi_match[] = {
+	{"LTER0501", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
+
 static const struct i2c_device_id ltr501_id[] = {
 	{ "ltr501", 0 },
 	{ }
@@ -1274,6 +1281,7 @@ static struct i2c_driver ltr501_driver = {
 	.driver = {
 		.name   = LTR501_DRV_NAME,
 		.pm	= &ltr501_pm_ops,
+		.acpi_match_table = ACPI_PTR(ltr_acpi_match),
 		.owner  = THIS_MODULE,
 	},
 	.probe  = ltr501_probe,
-- 
1.9.1

