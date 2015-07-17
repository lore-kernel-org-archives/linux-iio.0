Return-Path: <qingsong.gou@ck-telecom.com>
From: Jandy Gou <qingsong.gou@ck-telecom.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com,
	viorel.suman@intel.com,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jandy Gou <qingsong.gou@ck-telecom.com>
Subject: [PATCH 1/2] iio: magnetometer: mmc35240: Add DT binding
Date: Fri, 17 Jul 2015 16:34:35 +0800
Message-Id: <1437122076-29816-2-git-send-email-qingsong.gou@ck-telecom.com>
In-Reply-To: <1437122076-29816-1-git-send-email-qingsong.gou@ck-telecom.com>
References: <1437122076-29816-1-git-send-email-qingsong.gou@ck-telecom.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jandy Gou <qingsong.gou@ck-telecom.com>
---
 drivers/iio/magnetometer/mmc35240.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 7a2ea71..9bc542d 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -550,6 +550,12 @@ static const struct dev_pm_ops mmc35240_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mmc35240_suspend, mmc35240_resume)
 };
 
+static const struct of_device_id mmc35240_of_match[] = {
+	{ .compatible = "memsic,mmc35240", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmc35240_of_match);
+
 static const struct acpi_device_id mmc35240_acpi_match[] = {
 	{"MMC35240", 0},
 	{ },
@@ -565,6 +571,7 @@ MODULE_DEVICE_TABLE(i2c, mmc35240_id);
 static struct i2c_driver mmc35240_driver = {
 	.driver = {
 		.name = MMC35240_DRV_NAME,
+		.of_match_table = mmc35240_of_match,
 		.pm = &mmc35240_pm_ops,
 		.acpi_match_table = ACPI_PTR(mmc35240_acpi_match),
 	},
-- 
1.9.1
