Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:50377 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab1LWIJb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2011 03:09:31 -0500
Date: 23 Dec 2011 08:09:29 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: Pirmin Duss <pirmin.duss@flytec.ch>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2.1] Adds support for the Texas Instruments ADS1110 adc. 
Message-ID: <Prayer.1.3.4.1112230809290.970@hermes-2.csi.cam.ac.uk>
In-Reply-To: <1324549139-22337-1-git-send-email-pirmin.duss@flytec.ch>
References: <4EF1C71B.6020802@metafoo.de>
 <1324549139-22337-1-git-send-email-pirmin.duss@flytec.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Pirmin,

Please repost this as a single patch merged with the original driver one.

Makes for much easier review!

Jonathan
>From: Duss Pirmin <pirmin.duss@flytec.ch>
>
>Fixes issues found by Lars-Peter Clausen:
> 	adds locking for config changes
> 	caches the configuration register loaclly
> 	renamed the gain attribute to scale and changed it to a integer value
> 	only reads 2 bytes when reading the data from chip
> 	some cosmetical changes
>
>
>Signed-off-by: Duss Pirmin <pirmin.duss@flytec.ch>
>---
> drivers/staging/iio/adc/ads1110.c |  160 +++++++++++++++++++-----------------
> 1 files changed, 84 insertions(+), 76 deletions(-)
>
>diff --git a/drivers/staging/iio/adc/ads1110.c b/drivers/staging/iio/adc/ads1110.c
>index ad0d386..9bb0d24 100644
>--- a/drivers/staging/iio/adc/ads1110.c
>+++ b/drivers/staging/iio/adc/ads1110.c
>@@ -24,50 +24,43 @@
>  * ADS1110 definitions
>  */
> 
>+#define ADS1110_DATA_BYTES		2
>+#define ADS1110_CONFIG_BYTES		3
>+
> #define ADS1110_CYC_MASK		0x0C
> #define ADS1110_CYC_SHIFT		2
>-#define ADS1110_CYC_TCONF_15		3
>-#define ADS1110_CYC_TCONF_30		2
>-#define ADS1110_CYC_TCONF_60		1
>-#define ADS1110_CYC_TCONF_240		0
>+#define ADS1110_CYC_15			3
>+#define ADS1110_CYC_30			2
>+#define ADS1110_CYC_60			1
>+#define ADS1110_CYC_240			0
> 
> #define ADS1110_PGA_MASK		0x03
>-#define ADS1110_PGA_CLEAR   		0x9C
> #define ADS1110_PGA_1			0
> #define ADS1110_PGA_2			1
> #define ADS1110_PGA_4			2
> #define ADS1110_PGA_8			3
> 
>-#define ADS1110_MAX_CONV_MODE		2
>-#define ADS1110_MAX_DATA_RATE		4
>-#define ADS1110_MAX_PGA			4
>-
> /*
>  * struct ads1110_chip_info  - chip specifig information
>  */
> 
> struct ads1110_chip_info {
> 	struct i2c_client	*client;
>+	u8 	config;
> };
> 
> static const unsigned int ads1110_frequencies[] = {
>-	[ADS1110_CYC_TCONF_240] = 240,
>-	[ADS1110_CYC_TCONF_60] = 60,
>-	[ADS1110_CYC_TCONF_30] = 30,
>-	[ADS1110_CYC_TCONF_15] = 15,
>+	[ADS1110_CYC_240] = 240,
>+	[ADS1110_CYC_60] = 60,
>+	[ADS1110_CYC_30] = 30,
>+	[ADS1110_CYC_15] = 15,
> };
> 
>-struct ads1110_pga {
>-	char *name;
>-	u8 reg_cfg;
>-};
>-
>-static struct ads1110_pga
>-ads1110_pga_table[ADS1110_MAX_PGA] = {
>-	{ "gain-1",  ADS1110_PGA_1 },
>-	{ "gain-2",  ADS1110_PGA_2 },
>-	{ "gain-4",  ADS1110_PGA_4 },
>-	{ "gain-8",  ADS1110_PGA_8 },
>+static const unsigned int ads1110_pga_table[] = {
>+	[ADS1110_PGA_1] = 1,
>+	[ADS1110_PGA_2] = 2,
>+	[ADS1110_PGA_4] = 4,
>+	[ADS1110_PGA_8] = 8,
> };
> 
> /*
>@@ -75,7 +68,7 @@ ads1110_pga_table[ADS1110_MAX_PGA] = {
>  */
> 
> static const struct iio_chan_spec ads1110_channels[] = {
>-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0, 0, 0, 0, 
>+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0, 0, 0, 0,
> 		IIO_ST('s', 16, 16, 0), 0),
> };
> 
>@@ -87,10 +80,10 @@ static int ads1110_i2c_read_config(struct ads1110_chip_info *chip, u8 *data)
> {
> 	struct i2c_client *client = chip->client;
> 	int ret = 0;
>-	u8 tmp[3];		/* read three bytes ; first two are data third is the config */
>+	u8 tmp[ADS1110_CONFIG_BYTES];	/* read three bytes ; first two are data third is the config */
> 
>-	ret = i2c_master_recv(client, tmp, 3);
>-	if (ret < 3) {
>+	ret = i2c_master_recv(client, tmp, ADS1110_CONFIG_BYTES);
>+	if (ret < ADS1110_CONFIG_BYTES) {
> 		dev_err(&client->dev, "I2C read error\n");
> 		return ret;
> 	}
>@@ -104,26 +97,25 @@ static int ads1110_i2c_read_data(struct ads1110_chip_info *chip, int *data)
> {
> 	struct i2c_client *client = chip->client;
> 	int ret = 0;
>-	u8 tmp[3];		/* read three bytes ; first two are data third is the config */
>+	__be16 tmp;
> 
>-	ret = i2c_master_recv(client, tmp, 3);
>-	if (ret < 3) {
>+	ret = i2c_master_recv(client, (char *)&tmp, ADS1110_DATA_BYTES);
>+	if (ret < ADS1110_DATA_BYTES) {
> 		dev_err(&client->dev, "I2C read error\n");
> 		return ret;
> 	}
> 
>-	*data = (int)(tmp[0] << 8) + tmp[1];
>+	*data = be16_to_cpu(tmp);
> 
> 	return ret;
> }
> 
>-
> static int ads1110_i2c_write_config(struct ads1110_chip_info *chip, u8 data)
> {
> 	struct i2c_client *client = chip->client;
> 	int ret = 0;
> 
>-	ret = i2c_master_send(client, &data, 1);        /* there is only one register to write to. */
>+	ret = i2c_master_send(client, &data, 1);	/* there is only one register to write to. */
> 	if (ret < 0)
> 		dev_err(&client->dev, "I2C write error\n");
> 
>@@ -142,8 +134,7 @@ static ssize_t ads1110_read_frequency(struct device *dev,
> 	struct ads1110_chip_info *st = iio_priv(indio_dev);
> 	u8 cfg;
> 
>-	ads1110_i2c_read_config(st, &cfg);
>-	cfg = ((cfg & ADS1110_CYC_MASK) >> ADS1110_CYC_SHIFT);
>+	cfg = ((st->config & ADS1110_CYC_MASK) >> ADS1110_CYC_SHIFT);
> 
> 	return sprintf(buf, "%d\n", ads1110_frequencies[cfg]);
> }
>@@ -157,15 +148,15 @@ static ssize_t ads1110_write_frequency(struct device *dev,
> 	struct ads1110_chip_info *st = iio_priv(indio_dev);
> 	unsigned long lval;
> 	int ret, i;
>-	u8 cfg;
>-
>-	ads1110_i2c_read_config(st, &cfg);
>+	u8 *cfg = &st->config;
> 
>+	mutex_lock(&indio_dev->mlock);
> 	ret = kstrtoul(buf, 10, &lval);
> 	if (ret)
>-		return ret;
>+		goto out;
> 
>-	if (lval < 15 || lval > 240) {
>+	if ((lval < ads1110_frequencies[ADS1110_CYC_15]) || 
>+		(lval > ads1110_frequencies[ADS1110_CYC_240])) {
> 		ret = -EINVAL;
> 		goto out;
> 	}
>@@ -179,12 +170,13 @@ static ssize_t ads1110_write_frequency(struct device *dev,
> 		goto out;
> 	}
> 
>-	cfg &= ~ADS1110_CYC_MASK;               /* erase old datarate */
>-	cfg |= (i << ADS1110_CYC_SHIFT);
>+	*cfg &= ~ADS1110_CYC_MASK;		/* erase old datarate */
>+	*cfg |= (i << ADS1110_CYC_SHIFT);
> 
>-	ads1110_i2c_write_config(st, cfg);
>+	ads1110_i2c_write_config(st, *cfg);
> 
> out:
>+	mutex_unlock(&indio_dev->mlock);
> 	return ret ? ret : len;
> }
> 
>@@ -201,13 +193,13 @@ static ssize_t ads1110_show_gains(struct device *dev,
> 	int i;
> 	int len = 0;
> 
>-	for (i = 0; i < ADS1110_MAX_PGA; i++)
>-		len += sprintf(buf + len, "%s\n", ads1110_pga_table[i].name);
>+	for (i = 0; i < ARRAY_SIZE(ads1110_pga_table); i++)
>+		len += sprintf(buf + len, "%d\n", ads1110_pga_table[i]);
> 
> 	return len;
> }
> 
>-static IIO_DEVICE_ATTR(gains_available,
>+static IIO_DEVICE_ATTR(scale_available,
> 		S_IRUGO,
> 		ads1110_show_gains, NULL, 0);
> 
>@@ -217,12 +209,11 @@ static ssize_t ads1110_show_gain(struct device *dev,
> {
> 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> 	struct ads1110_chip_info *st = iio_priv(indio_dev);
>-	u8 cfg;
>+	u8 cfg = st->config;
> 
>-	ads1110_i2c_read_config(st, &cfg);
> 	cfg = (cfg & ADS1110_PGA_MASK);
> 
>-	return sprintf(buf, "%s\n", ads1110_pga_table[cfg].name);
>+	return sprintf(buf, "%d\n", ads1110_pga_table[cfg]);
> }
> 
> static ssize_t ads1110_store_gain(struct device *dev,
>@@ -232,26 +223,41 @@ static ssize_t ads1110_store_gain(struct device *dev,
> {
> 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> 	struct ads1110_chip_info *st = iio_priv(indio_dev);
>-	u8 cfg;
>-	int i;
>+	unsigned long lval;
>+	u8 *cfg = &st->config;
>+	int ret, i;
> 
>-	for (i = 0; i < ADS1110_MAX_PGA; i++) {
>-		if (strncmp(buf, ads1110_pga_table[i].name,
>-				strlen(ads1110_pga_table[i].name)) == 0) {
>-			ads1110_i2c_read_config(st, &cfg);
>-			cfg &= ADS1110_PGA_CLEAR;							/* clear old value */
>-			cfg |= ads1110_pga_table[i].reg_cfg;
>-			ads1110_i2c_write_config(st, cfg);
>-			return len;
>-		}
>+	mutex_lock(&indio_dev->mlock);
>+	ret = kstrtoul(buf, 10, &lval);
>+	if (ret)
>+		goto out;
>+
>+	if ((lval < ads1110_pga_table[ADS1110_PGA_1]) || 
>+		(lval > ads1110_pga_table[ADS1110_PGA_8])) {
>+		ret = -EINVAL;
>+		goto out;
>+	}
>+
>+	for (i = 0; i < ARRAY_SIZE(ads1110_pga_table); i++)
>+		if (lval == ads1110_pga_table[i])
>+			break;
>+
>+	if (i == ARRAY_SIZE(ads1110_pga_table)) {
>+		ret = -EINVAL;
>+		goto out;
> 	}
> 
>-	dev_err(dev, "not supported gain\n");
>+	*cfg &= ~ADS1110_PGA_MASK;		/* erase old gain */
>+	*cfg |= i;
>+
>+	ads1110_i2c_write_config(st, *cfg);
> 
>-	return -EINVAL;
>+out:
>+	mutex_unlock(&indio_dev->mlock);
>+	return ret ? ret : len;
> }
> 
>-static IIO_DEVICE_ATTR(gain,
>+static IIO_DEVICE_ATTR(scale,
> 		S_IRUGO | S_IWUSR,
> 		ads1110_show_gain, ads1110_store_gain, 0);
> 
>@@ -265,7 +271,7 @@ static int ads1110_read_raw(struct iio_dev *indio_dev,
> 	int ret, data;
> 
> 	ret = ads1110_i2c_read_data(st, &data);
>-	if (ret!=3)
>+	if (ret != ADS1110_DATA_BYTES)
> 		return -EIO;
> 
> 	*val = data;
>@@ -281,11 +287,11 @@ static int ads1110_read_raw(struct iio_dev *indio_dev,
> static struct attribute *ads1110_attributes[] = {
> 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>-	&iio_dev_attr_gains_available.dev_attr.attr,
>-	&iio_dev_attr_gain.dev_attr.attr,
>+	&iio_dev_attr_scale_available.dev_attr.attr,
>+	&iio_dev_attr_scale.dev_attr.attr,
> 	NULL,
> };
>- 
>+
> static const struct attribute_group ads1110_attribute_group = {
> 	.attrs = ads1110_attributes,
> };
>@@ -304,11 +310,11 @@ static const struct iio_info ads1110_info = {
> static int __devinit ads1110_probe(struct i2c_client *client,
> 		const struct i2c_device_id *id)
> {
>-	int ret = 0, regdone = 0;
>+	int ret = 0;
> 	struct ads1110_chip_info *chip;
> 	struct iio_dev *indio_dev;
> 
>-	indio_dev= iio_allocate_device(sizeof(*chip));
>+	indio_dev = iio_allocate_device(sizeof(*chip));
> 	if (indio_dev == NULL) {
> 		ret = -ENOMEM;
> 		goto error_ret;
>@@ -331,15 +337,17 @@ static int __devinit ads1110_probe(struct i2c_client *client,
> 	ret = iio_device_register(indio_dev);
> 	if (ret)
> 		goto error_free_dev;
>-	regdone = 1;
>+
>+	/* read the config register from the chip */
>+	ret = ads1110_i2c_read_config(chip, &chip->config);
>+	if (ret != 3)
>+		goto error_free_dev;
> 
> 	dev_err(&client->dev, "%s ADC registered.\n", id->name);
> 
> 	return 0;
> 
> error_free_dev:
>-	if (regdone)
>-		iio_device_unregister(indio_dev);
> 	iio_free_device(indio_dev);
> 	kfree(chip);
> error_ret:
>@@ -365,7 +373,7 @@ static const struct i2c_device_id ads1110_id[] = {
> 	{ "ads1110-ed5", 0x53 },
> 	{ "ads1110-ed6", 0x54 },
> 	{ "ads1110-ed7", 0x55 },
>-	{}
>+	{},
> };
> 
> MODULE_DEVICE_TABLE(i2c, ads1110_id);
>@@ -379,12 +387,12 @@ static struct i2c_driver ads1110_driver = {
> 	.id_table = ads1110_id,
> };
> 
>-static __init int ads1110_init(void)
>+static int __init ads1110_init(void)
> {
> 	return i2c_add_driver(&ads1110_driver);
> }
> 
>-static __exit void ads1110_exit(void)
>+static void __exit ads1110_exit(void)
> {
> 	i2c_del_driver(&ads1110_driver);
> }
>
