Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 4/4] iio: ltr501: Add ACPI enumeration support
Date: Wed,  1 Apr 2015 20:51:47 -0700
Message-Id: <98aeb419a18ae30f8987eebb113ede8d66fd18ff.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added ACPI enumeration support for LTR501 chip.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 5d20e4c..b8d9ac7 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/acpi.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/events.h>
@@ -834,6 +835,12 @@ static int ltr501_resume(struct device *dev)
 
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
@@ -844,6 +851,7 @@ static struct i2c_driver ltr501_driver = {
 	.driver = {
 		.name   = LTR501_DRV_NAME,
 		.pm	= &ltr501_pm_ops,
+		.acpi_match_table = ACPI_PTR(ltr_acpi_match),
 		.owner  = THIS_MODULE,
 	},
 	.probe  = ltr501_probe,
-- 
1.9.1
