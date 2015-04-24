Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH v2 3/3] iio: magnetometer: Add ACPI support for MMC35240
Date: Fri, 24 Apr 2015 18:58:32 +0300
Message-Id: <1429891112-11888-4-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1429891112-11888-1-git-send-email-daniel.baluta@intel.com>
References: <1429891112-11888-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

We assume that ACPI device tables use MMC35240 to
identify MEMSIC's 3 axis magnetic sensor.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/mmc35240.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 7a52c3e..3282862 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
+#include <linux/acpi.h>
 #include <linux/pm.h>
 
 #include <linux/iio/iio.h>
@@ -481,6 +482,12 @@ static const struct dev_pm_ops mmc35240_pm_ops = {
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
@@ -491,6 +498,7 @@ static struct i2c_driver mmc35240_driver = {
 	.driver = {
 		.name = MMC35240_DRV_NAME,
 		.pm = &mmc35240_pm_ops,
+		.acpi_match_table = ACPI_PTR(mmc35240_acpi_match),
 	},
 	.probe		= mmc35240_probe,
 	.id_table	= mmc35240_id,
-- 
1.9.1
