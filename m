Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42189 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaCHRol (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Mar 2014 12:44:41 -0500
In-Reply-To: <1394290447-31702-1-git-send-email-angelo.compagnucci@gmail.com>
References: <1394290447-31702-1-git-send-email-angelo.compagnucci@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] Add support for Microchip Technology's MCP3426/7/8 ADC
From: Jonathan Cameron <jic23@kernel.org>
Date: Sat, 08 Mar 2014 17:44:37 +0000
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	linux-iio@vger.kernel.org
Message-ID: <f1ede9f5-4433-4230-888a-8f8bb09e946f@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On March 8, 2014 2:54:07 PM GMT+00:00, Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
>This patch extends previous mcp3422 driver to support
>missing members of the family mcp3426/7/8.
>
>Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Hi

The reindenting and switching round of if/else logic do not belong in this patch...

The fundamental changes look fine at a glance. Will take another look after the irrelevant stuff is stripped out.
>---
> drivers/iio/adc/Kconfig   |  7 ++--
>drivers/iio/adc/mcp3422.c | 84
>++++++++++++++++++++++++++++++-----------------
> 2 files changed, 57 insertions(+), 34 deletions(-)
>
>diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>index 5553206..246d9d2 100644
>--- a/drivers/iio/adc/Kconfig
>+++ b/drivers/iio/adc/Kconfig
>@@ -146,11 +146,12 @@ config MCP320X
> 	  called mcp320x.
> 
> config MCP3422
>-	tristate "Microchip Technology MCP3422/3/4 driver"
>+	tristate "Microchip Technology MCP3422/3/4/6/7/8 driver"
> 	depends on I2C
> 	help
>-	  Say yes here to build support for Microchip Technology's MCP3422,
>-	  MCP3423 or MCP3424 analog to digital converters.
>+	  Say yes here to build support for Microchip Technology's
>+	  MCP3422, MCP3423, MCP3424, MCP3426, MCP3427 or MCP3428 
>+	  analog to digital converters.
> 
>	  This driver can also be built as a module. If so, the module will be
> 	  called mcp3422.
>diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
>index 47dcb34..76e206a 100644
>--- a/drivers/iio/adc/mcp3422.c
>+++ b/drivers/iio/adc/mcp3422.c
>@@ -1,10 +1,11 @@
> /*
>- * mcp3422.c - driver for the Microchip mcp3422/3/4 chip family
>+ * mcp3422.c - driver for the Microchip mcp3422/3/4/6/7/8 chip family
>  *
>  * Copyright (C) 2013, Angelo Compagnucci
>  * Author: Angelo Compagnucci <angelo.compagnucci@gmail.com>
>  *
>* Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/22088b.pdf
>+ *           
>http://ww1.microchip.com/downloads/en/DeviceDoc/22226a.pdf
>  *
>  * This driver exports the value of analog input voltage to sysfs, the
>  * voltage unit is nV.
>@@ -26,18 +27,18 @@
> #include <linux/iio/sysfs.h>
> 
> /* Masks */
>-#define MCP3422_CHANNEL_MASK	0x60
>-#define MCP3422_PGA_MASK	0x03
>-#define MCP3422_SRATE_MASK	0x0C
>-#define MCP3422_SRATE_240	0x0
>-#define MCP3422_SRATE_60	0x1
>-#define MCP3422_SRATE_15	0x2
>-#define MCP3422_SRATE_3	0x3
>-#define MCP3422_PGA_1	0
>-#define MCP3422_PGA_2	1
>-#define MCP3422_PGA_4	2
>-#define MCP3422_PGA_8	3
>-#define MCP3422_CONT_SAMPLING	0x10
>+#define MCP3422_CHANNEL_MASK    0x60
>+#define MCP3422_PGA_MASK        0x03
>+#define MCP3422_SRATE_MASK      0x0C
>+#define MCP3422_SRATE_240       0x0
>+#define MCP3422_SRATE_60        0x1
>+#define MCP3422_SRATE_15        0x2
>+#define MCP3422_SRATE_3         0x3
>+#define MCP3422_PGA_1           0
>+#define MCP3422_PGA_2           1
>+#define MCP3422_PGA_4           2
>+#define MCP3422_PGA_8           3
>+#define MCP3422_CONT_SAMPLING   0x10
> 
>#define MCP3422_CHANNEL(config)	(((config) & MCP3422_CHANNEL_MASK) >>
>5)
> #define MCP3422_PGA(config)	((config) & MCP3422_PGA_MASK)
>@@ -65,7 +66,6 @@ static const u32 rates_to_lsb[] = {1000000, 250000,
>62500, 15625};
>  *  rates_to_lsb[sample_rate] / (1 << pga);
>  *  pga is 1 for 0, 2
>  */
>-
> static const int mcp3422_scales[4][4] = {
> 	{ 1000000, 250000, 62500, 15625 },
> 	{ 500000 , 125000, 31250, 7812 },
>@@ -96,6 +96,7 @@ static const int mcp3422_sign_extend[4] = {
> /* Client data (each client gets its own) */
> struct mcp3422 {
> 	struct i2c_client *i2c;
>+	u8 id;
> 	u8 config;
> 	u8 pga[4];
> 	struct mutex lock;
>@@ -125,14 +126,14 @@ static int mcp3422_read(struct mcp3422 *adc, int
>*value, u8 *config)
> 	u8 buf[4] = {0, 0, 0, 0};
> 	u32 temp;
> 

Why do this next bit?
>-	if (sample_rate == MCP3422_SRATE_3) {
>-		ret = i2c_master_recv(adc->i2c, buf, 4);
>-		temp = buf[0] << 16 | buf[1] << 8 | buf[2];
>-		*config = buf[3];
>-	} else {
>+	if (sample_rate != MCP3422_SRATE_3) {
> 		ret = i2c_master_recv(adc->i2c, buf, 3);
> 		temp = buf[0] << 8 | buf[1];
> 		*config = buf[2];
>+	} else {
>+		ret = i2c_master_recv(adc->i2c, buf, 4);
>+		temp = buf[0] << 16 | buf[1] << 8 | buf[2];
>+		*config = buf[3];
> 	}
> 
> 	*value = sign_extend32(temp, mcp3422_sign_extend[sample_rate]);
>@@ -141,7 +142,7 @@ static int mcp3422_read(struct mcp3422 *adc, int
>*value, u8 *config)
> }
> 
> static int mcp3422_read_channel(struct mcp3422 *adc,
>-				struct iio_chan_spec const *channel, int *value)
>+		struct iio_chan_spec const *channel, int *value)
> {
> 	int ret;
> 	u8 config;
>@@ -163,8 +164,8 @@ static int mcp3422_read_channel(struct mcp3422
>*adc,
> }
> 
> static int mcp3422_read_raw(struct iio_dev *iio,
>-			struct iio_chan_spec const *channel, int *val1,
>-			int *val2, long mask)
>+		struct iio_chan_spec const *channel, int *val1,
>+		int *val2, long mask)
This reinventing should as with other cases be in a separate patch if actually desired...
> {
> 	struct mcp3422 *adc = iio_priv(iio);
> 	int err;
>@@ -197,8 +198,8 @@ static int mcp3422_read_raw(struct iio_dev *iio,
> }
> 
> static int mcp3422_write_raw(struct iio_dev *iio,
>-			struct iio_chan_spec const *channel, int val1,
>-			int val2, long mask)
>+		struct iio_chan_spec const *channel, int val1,
>+		int val2, long mask)
> {
> 	struct mcp3422 *adc = iio_priv(iio);
> 	u8 temp;
>@@ -238,6 +239,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
> 			temp = MCP3422_SRATE_15;
> 			break;
> 		case 3:
>+			if (adc->id > 4)
>+				return -EINVAL;
> 			temp = MCP3422_SRATE_3;
> 			break;
> 		default:
>@@ -271,6 +274,17 @@ static int mcp3422_write_raw_get_fmt(struct
>iio_dev *indio_dev,
> 	}
> }
> 
>+static ssize_t mcp3422_show_samp_freq(struct device *dev,
>+		struct device_attribute *attr, char *buf)
>+{
>+	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
>+
>+	if (adc->id > 4)
>+		return sprintf(buf, "240 60 15\n");
>+
>+	return sprintf(buf, "240 60 15 3\n");
>+}
>+
> static ssize_t mcp3422_show_scales(struct device *dev,
> 		struct device_attribute *attr, char *buf)
> {
>@@ -284,12 +298,13 @@ static ssize_t mcp3422_show_scales(struct device
>*dev,
> 		mcp3422_scales[sample_rate][3]);
> }
> 
>-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("240 60 15 3");
>+static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
>+		mcp3422_show_samp_freq, NULL, 0);
> static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
> 		mcp3422_show_scales, NULL, 0);
> 
> static struct attribute *mcp3422_attributes[] = {
>-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> 	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
> 	NULL,
> };
>@@ -303,7 +318,7 @@ static const struct iio_chan_spec
>mcp3422_channels[] = {
> 	MCP3422_CHAN(1),
> };
> 
>-static const struct iio_chan_spec mcp3424_channels[] = {
>+static const struct iio_chan_spec mcp3426_channels[] = {
> 	MCP3422_CHAN(0),
> 	MCP3422_CHAN(1),
> 	MCP3422_CHAN(2),
>@@ -335,6 +350,7 @@ static int mcp3422_probe(struct i2c_client *client,
> 
> 	adc = iio_priv(indio_dev);
> 	adc->i2c = client;
>+	adc->id = (u8)(id->driver_data);
> 
> 	mutex_init(&adc->lock);
> 
>@@ -343,15 +359,18 @@ static int mcp3422_probe(struct i2c_client
>*client,
> 	indio_dev->modes = INDIO_DIRECT_MODE;
> 	indio_dev->info = &mcp3422_info;
> 
>-	switch ((unsigned int)(id->driver_data)) {
>+	switch (adc->id) {
> 	case 2:
> 	case 3:
>+	case 6:
>+	case 7:
> 		indio_dev->channels = mcp3422_channels;
> 		indio_dev->num_channels = ARRAY_SIZE(mcp3422_channels);
> 		break;
> 	case 4:
>-		indio_dev->channels = mcp3424_channels;
>-		indio_dev->num_channels = ARRAY_SIZE(mcp3424_channels);
>+	case 8:
>+		indio_dev->channels = mcp3426_channels;
>+		indio_dev->num_channels = ARRAY_SIZE(mcp3426_channels);
> 		break;
> 	}
> 
>@@ -375,6 +394,9 @@ static const struct i2c_device_id mcp3422_id[] = {
> 	{ "mcp3422", 2 },
> 	{ "mcp3423", 3 },
> 	{ "mcp3424", 4 },
>+	{ "mcp3426", 6 },
>+	{ "mcp3427", 7 },
>+	{ "mcp3428", 8 },
> 	{ }
> };
> MODULE_DEVICE_TABLE(i2c, mcp3422_id);
>@@ -399,5 +421,5 @@ static struct i2c_driver mcp3422_driver = {
> module_i2c_driver(mcp3422_driver);
> 
> MODULE_AUTHOR("Angelo Compagnucci <angelo.compagnucci@gmail.com>");
>-MODULE_DESCRIPTION("Microchip mcp3422/3/4 driver");
>+MODULE_DESCRIPTION("Microchip mcp3422/3/4/6/7/8 driver");
> MODULE_LICENSE("GPL v2");

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
