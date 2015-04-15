Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	daniel.baluta@intel.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 3/3] iio: magnetometer: Add ACPI support for MMC35240
Date: Wed, 15 Apr 2015 14:02:06 +0300
Message-Id: <1429095726-10055-4-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1429095726-10055-1-git-send-email-daniel.baluta@intel.com>
References: <1429095726-10055-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

We assume that ACPI device tables use MMC35240 to
identify MEMSIC's 3 axis magnetic sensor.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/mmc35240.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 4c76938..8811714 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
+#include <linux/acpi.h>
 #include <linux/pm.h>
 
 #include <linux/iio/iio.h>
@@ -488,6 +489,12 @@ static const struct dev_pm_ops mmc35240_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mmc35240_suspend, mmc35240_resume)
 };
 
+static const struct acpi_device_id mmc35240_acpi_match[] = {
+	{"MMC35240", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, mmc35240_acpi_match);
+
 static const struct i2c_device_id mmc35240_id[] = {
 	{"MMC35240", 0},
 	{}
@@ -498,6 +505,7 @@ static struct i2c_driver mmc35240_driver = {
 	.driver = {
 		.name = MMC35240_DRV_NAME,
 		.pm = &mmc35240_pm_ops,
+		.acpi_match_table = ACPI_PTR(mmc35240_acpi_match),
 	},
 	.probe		= mmc35240_probe,
 	.remove		= mmc35240_remove,
-- 
1.9.1
