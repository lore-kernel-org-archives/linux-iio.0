Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	daniel.baluta@intel.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/3] iio: magnetometer: mmc35240: Add PM sleep support
Date: Wed, 15 Apr 2015 14:02:05 +0300
Message-Id: <1429095726-10055-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1429095726-10055-1-git-send-email-daniel.baluta@intel.com>
References: <1429095726-10055-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

We rely on regmap to save the state of the registers at suspend,
and then we do an explicit sync at resume.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/mmc35240.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index c46c1f7..4c76938 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
+#include <linux/pm.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -454,6 +455,39 @@ static int mmc35240_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mmc35240_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mmc35240_data *data = iio_priv(indio_dev);
+
+	regcache_cache_only(data->regmap, true);
+
+	return 0;
+}
+
+static int mmc35240_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mmc35240_data *data = iio_priv(indio_dev);
+	int ret;
+
+	regcache_mark_dirty(data->regmap);
+	ret = regcache_sync_region(data->regmap, MMC35240_REG_CTRL0,
+				   MMC35240_REG_CTRL1);
+	if (ret < 0)
+		dev_err(dev, "Failed to restore control registers\n");
+
+	regcache_cache_only(data->regmap, false);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops mmc35240_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mmc35240_suspend, mmc35240_resume)
+};
+
 static const struct i2c_device_id mmc35240_id[] = {
 	{"MMC35240", 0},
 	{}
@@ -463,6 +497,7 @@ MODULE_DEVICE_TABLE(i2c, mmc35240_id);
 static struct i2c_driver mmc35240_driver = {
 	.driver = {
 		.name = MMC35240_DRV_NAME,
+		.pm = &mmc35240_pm_ops,
 	},
 	.probe		= mmc35240_probe,
 	.remove		= mmc35240_remove,
-- 
1.9.1
