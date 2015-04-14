Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	daniel.baluta@gmail.com
Subject: [PATCH v7 2/2] iio: ltr501: Add support for ltr301
Date: Tue, 14 Apr 2015 16:37:22 +0300
Message-Id: <1429018642-4838-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1429018642-4838-1-git-send-email-daniel.baluta@intel.com>
References: <1429018642-4838-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Added support for Liteon 301 Ambient light sensor. Since
LTR-301 and LTR-501 are register compatible(and even have same
part id), LTR-501 driver has been extended to support both
devices. LTR-501 is similar to LTR-301 in ALS sensing, But the
only difference is, LTR-501 also supports proximity sensing.

LTR-501 - ALS + Proximity combo
LTR-301 - ALS sensor.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iio/light/Kconfig  |  2 +-
 drivers/iio/light/ltr501.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 16a0ba1..a437bad 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -170,7 +170,7 @@ config LTR501
 	help
 	 If you say yes here you get support for the Lite-On LTR-501ALS-01
 	 ambient light and proximity sensor. This driver also supports LTR-559
-	 ALS/PS sensor.
+	 ALS/PS or LTR-301 ALS sensors.
 
 	 This driver can also be built as a module.  If so, the module
          will be called ltr501.
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 55ccd5c..2cb6fa7 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -50,6 +50,7 @@
 enum {
 	ltr501 = 0,
 	ltr559,
+	ltr301,
 };
 
 struct ltr501_gain {
@@ -96,6 +97,8 @@ struct ltr501_chip_info {
 	u8 als_mode_active;
 	u8 als_gain_mask;
 	u8 als_gain_shift;
+	struct iio_chan_spec const *channels;
+	const struct iio_info *info;
 };
 
 struct ltr501_data {
@@ -179,6 +182,13 @@ static const struct iio_chan_spec ltr501_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec ltr301_channels[] = {
+	LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0),
+	LTR501_INTENSITY_CHANNEL(1, LTR501_ALS_DATA1, IIO_MOD_LIGHT_IR,
+				 BIT(IIO_CHAN_INFO_SCALE)),
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
 static int ltr501_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -344,10 +354,19 @@ static struct attribute *ltr501_attributes[] = {
 	NULL
 };
 
+static struct attribute *ltr301_attributes[] = {
+	&iio_dev_attr_in_intensity_scale_available.dev_attr.attr,
+	NULL
+};
+
 static const struct attribute_group ltr501_attribute_group = {
 	.attrs = ltr501_attributes,
 };
 
+static const struct attribute_group ltr301_attribute_group = {
+	.attrs = ltr301_attributes,
+};
+
 static const struct iio_info ltr501_info = {
 	.read_raw = ltr501_read_raw,
 	.write_raw = ltr501_write_raw,
@@ -355,6 +374,13 @@ static const struct iio_info ltr501_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static const struct iio_info ltr301_info = {
+	.read_raw = ltr501_read_raw,
+	.write_raw = ltr501_write_raw,
+	.attrs = &ltr301_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static struct ltr501_chip_info ltr501_chip_info_tbl[] = {
 	[ltr501] = {
 		.chip_id = 0x08,
@@ -365,6 +391,8 @@ static struct ltr501_chip_info ltr501_chip_info_tbl[] = {
 		.als_mode_active = BIT(0) | BIT(1),
 		.als_gain_mask = BIT(3),
 		.als_gain_shift = 3,
+		.info = &ltr501_info,
+		.channels = ltr501_channels,
 	},
 	[ltr559] = {
 		.chip_id = 0x09,
@@ -375,6 +403,18 @@ static struct ltr501_chip_info ltr501_chip_info_tbl[] = {
 		.als_mode_active = BIT(1),
 		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
 		.als_gain_shift = 2,
+		.info = &ltr501_info,
+		.channels = ltr501_channels,
+	},
+	[ltr301] = {
+		.chip_id = 0x08,
+		.als_gain = ltr501_als_gain_tbl,
+		.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
+		.als_mode_active = BIT(0) | BIT(1),
+		.als_gain_mask = BIT(3),
+		.als_gain_shift = 3,
+		.info = &ltr301_info,
+		.channels = ltr301_channels,
 	},
 };
 
@@ -500,8 +540,8 @@ static int ltr501_probe(struct i2c_client *client,
 		return -ENODEV;
 
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->info = &ltr501_info;
-	indio_dev->channels = ltr501_channels;
+	indio_dev->info = data->chip_info->info;
+	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = ARRAY_SIZE(ltr501_channels);
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -562,6 +602,7 @@ static SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 static const struct i2c_device_id ltr501_id[] = {
 	{ "ltr501", ltr501},
 	{ "ltr559", ltr559},
+	{ "ltr301", ltr301 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
-- 
1.9.1
