Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 1/1] iio: ltr301: Add support for ltr301
Date: Wed,  1 Apr 2015 21:10:56 -0700
Message-Id: <6c06e64f0cf6c5314b987490775cf9d85af1eda5.1427947743.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1427947743.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427947743.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1427947743.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427947743.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added support for Liteon 301 Ambient light sensor. Since
LTR301 and LTR501 are register compatible(and even have same
part id), LTR501 driver has been extended to support both
devices. LTR501 is similar to LTR301 in ALS sensing, But the
only difference is, LTR501 also supports proximity sensing.

LTR501 - ALS + Proximity combo
LTR301 - ALS sensor.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iio/light/Kconfig  |  2 +-
 drivers/iio/light/ltr501.c | 56 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index a224afd..4b2ec51 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -159,7 +159,7 @@ config LTR501
 	select IIO_TRIGGERED_BUFFER
 	help
 	 If you say yes here you get support for the Lite-On LTR-501ALS-01
-	 ambient light and proximity sensor.
+	 ambient light and proximity sensor or LTR301 Ambient light sensor.
 
 	 This driver can also be built as a module.  If so, the module
          will be called ltr501.
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 62b7072..66d9a2c 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -45,10 +45,17 @@
 
 #define LTR501_PS_DATA_MASK 0x7ff
 
+enum ltr_chipset {
+	LTR301,
+	LTR501,
+	LTR_MAX_CHIPS /* this must be last */
+};
+
 struct ltr501_data {
 	struct i2c_client *client;
 	struct mutex lock_als, lock_ps;
 	u8 als_contr, ps_contr;
+	u8 chip_id;
 };
 
 static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
@@ -124,6 +131,13 @@ static const struct iio_chan_spec ltr501_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec ltr301_channels[] = {
+	LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0),
+	LTR501_INTENSITY_CHANNEL(1, LTR501_ALS_DATA1, IIO_MOD_LIGHT_IR,
+		BIT(IIO_CHAN_INFO_SCALE)),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
 static const int ltr501_ps_gain[4][2] = {
 	{1, 0}, {0, 250000}, {0, 125000}, {0, 62500}
 };
@@ -244,10 +258,19 @@ static struct attribute *ltr501_attributes[] = {
 	NULL
 };
 
+static struct attribute *ltr301_attributes[] = {
+	&iio_const_attr_in_intensity_scale_available.dev_attr.attr,
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
@@ -255,6 +278,13 @@ static const struct iio_info ltr501_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static const struct iio_info ltr301_info = {
+	.read_raw = ltr501_read_raw,
+	.write_raw = ltr501_write_raw,
+	.attrs = &ltr301_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int ltr501_write_contr(struct i2c_client *client, u8 als_val, u8 ps_val)
 {
 	int ret = i2c_smbus_write_byte_data(client, LTR501_ALS_CONTR, als_val);
@@ -347,6 +377,13 @@ static int ltr501_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+
+	/* TODO: Add condition for ACPI */
+	if (id)
+		data->chip_id = id->driver_data;
+	else
+		return -ENOSYS
+
 	mutex_init(&data->lock_als);
 	mutex_init(&data->lock_ps);
 
@@ -357,12 +394,24 @@ static int ltr501_probe(struct i2c_client *client,
 		return -ENODEV;
 
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->info = &ltr501_info;
-	indio_dev->channels = ltr501_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ltr501_channels);
 	indio_dev->name = LTR501_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	switch (data->chip_id) {
+	case LTR301:
+		indio_dev->info = &ltr301_info;
+		indio_dev->channels = ltr301_channels;
+		break;
+	case LTR501:
+		indio_dev->info = &ltr501_info;
+		indio_dev->channels = ltr501_channels;
+		break;
+	default:
+		dev_warn(&client->dev, "ltr chip invalid\n");
+		return -ENODEV;
+	}
+
 	ret = ltr501_init(data);
 	if (ret < 0)
 		return ret;
@@ -422,7 +471,8 @@ static int ltr501_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
 static const struct i2c_device_id ltr501_id[] = {
-	{ "ltr501", 0 },
+	{ "ltr301", LTR301 },
+	{ "ltr501", LTR501 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
-- 
1.9.1
