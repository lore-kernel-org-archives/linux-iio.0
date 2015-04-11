Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2641 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932695AbbDKA7t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Apr 2015 20:59:49 -0400
From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net
Cc: daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 1/1] iio: ltr501: Add support for ltr301
Date: Fri, 10 Apr 2015 17:59:50 -0700
Message-Id: <c0bfd1b4f763e166eec1b6a1d8585cd0fca37de5.1428713872.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1428713872.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1428713872.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1428713872.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1428713872.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
 drivers/iio/light/ltr501.c | 99 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index a224afd..215e4a3 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -159,7 +159,7 @@ config LTR501
 	select IIO_TRIGGERED_BUFFER
 	help
 	 If you say yes here you get support for the Lite-On LTR-501ALS-01
-	 ambient light and proximity sensor.
+	 ambient light and proximity sensor or LTR-301 ambient light sensor.
 
 	 This driver can also be built as a module.  If so, the module
          will be called ltr501.
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 5939cda..4945405 100644
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
@@ -105,29 +108,6 @@ struct ltr501_data {
 	u8 als_contr, ps_contr;
 };
 
-static struct ltr501_chip_info ltr501_chip_info_tbl[] = {
-	[ltr501] = {
-		.chip_id = 0x08,
-		.als_gain = ltr501_als_gain_tbl,
-		.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
-		.ps_gain = ltr501_ps_gain_tbl,
-		.ps_gain_tbl_size = ARRAY_SIZE(ltr501_ps_gain_tbl),
-		.als_mode_active = BIT(0) | BIT(1),
-		.als_gain_mask = BIT(3),
-		.als_gain_shift = 3,
-	},
-	[ltr559] = {
-		.chip_id = 0x09,
-		.als_gain = ltr559_als_gain_tbl,
-		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
-		.ps_gain = ltr559_ps_gain_tbl,
-		.ps_gain_tbl_size = ARRAY_SIZE(ltr559_ps_gain_tbl),
-		.als_mode_active = BIT(1),
-		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
-		.als_gain_shift = 2,
-	},
-};
-
 static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
 {
 	int tries = 100;
@@ -202,6 +182,13 @@ static const struct iio_chan_spec ltr501_channels[] = {
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
@@ -367,10 +354,19 @@ static struct attribute *ltr501_attributes[] = {
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
@@ -378,6 +374,50 @@ static const struct iio_info ltr501_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static const struct iio_info ltr301_info = {
+	.read_raw = ltr501_read_raw,
+	.write_raw = ltr501_write_raw,
+	.attrs = &ltr301_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
+static struct ltr501_chip_info ltr501_chip_info_tbl[] = {
+	[ltr501] = {
+		.chip_id = 0x08,
+		.als_gain = ltr501_als_gain_tbl,
+		.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
+		.ps_gain = ltr501_ps_gain_tbl,
+		.ps_gain_tbl_size = ARRAY_SIZE(ltr501_ps_gain_tbl),
+		.als_mode_active = BIT(0) | BIT(1),
+		.als_gain_mask = BIT(3),
+		.als_gain_shift = 3,
+		.info = &ltr501_info,
+		.channels = ltr501_channels,
+	},
+	[ltr559] = {
+		.chip_id = 0x09,
+		.als_gain = ltr559_als_gain_tbl,
+		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
+		.ps_gain = ltr559_ps_gain_tbl,
+		.ps_gain_tbl_size = ARRAY_SIZE(ltr559_ps_gain_tbl),
+		.als_mode_active = BIT(1),
+		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
+		.als_gain_shift = 2,
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
+	},
+};
+
 static int ltr501_write_contr(struct i2c_client *client, u8 als_val, u8 ps_val)
 {
 	int ret = i2c_smbus_write_byte_data(client, LTR501_ALS_CONTR, als_val);
@@ -463,7 +503,7 @@ static int ltr501_probe(struct i2c_client *client,
 	struct ltr501_data *data;
 	struct iio_dev *indio_dev;
 	const char *name = NULL;
-	int chip_id = 0;
+	int chip_id;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
@@ -476,10 +516,12 @@ static int ltr501_probe(struct i2c_client *client,
 	mutex_init(&data->lock_als);
 	mutex_init(&data->lock_ps);
 
+	/* TODO: Add condition for ACPI */
 	if (id) {
-		name = id->name;
+		name = id->name ? id->name : LTR501_DRV_NAME;
 		chip_id = id->driver_data;
-	}
+	} else
+		return -ENODEV;
 
 	data->chip_info = &ltr501_chip_info_tbl[chip_id];
 
@@ -490,8 +532,8 @@ static int ltr501_probe(struct i2c_client *client,
 		return -ENODEV;
 
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->info = &ltr501_info;
-	indio_dev->channels = ltr501_channels;
+	indio_dev->info = data->chip_info->info;
+	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = ARRAY_SIZE(ltr501_channels);
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -557,6 +599,7 @@ static SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 static const struct i2c_device_id ltr501_id[] = {
 	{ "ltr501", ltr501},
 	{ "ltr559", ltr559},
+	{ "ltr301", ltr301 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
-- 
1.9.1

