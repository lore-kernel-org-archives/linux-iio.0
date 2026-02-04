Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736740FDAE
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213657; cv=none; b=Ig8dPsGE/sxDH2I0bqo3M6FlMPml/J8N6UcFb2a2/e0NwWaxYwkQvhKKKZ28Hc1+Js+Z3JD83pobdpgUXTMezdWwsYXjvntTVg9TePWT/vzvEGcwrq0M82QdZFfFRGEdtwpP3/I6oRu+It+9pZXjC2EVSSomS2cVcs9hvooO8tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213657; c=relaxed/simple;
	bh=i3ch3iPA3rmTH9H9IqwUidQQKFlQPdh+XB+pDpfhAfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO1sWonLW1c4+CPGZehSt8rFNRdI1V/G4GqGwmn7OK8OTmDBTA/j3LPwWmskk8BkGNAHU3uAYRxbh92Vhdg0frMLs3Sd4b3nhMBVAw0r+FEozoV3sXr4WMIG19FXGwoZBitbqgXmciCWd4cTVNJdYlLePTnGGTek73FxtlnZ5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR1-0001Qo-Jr; Wed, 04 Feb 2026 15:00:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR1-0045FW-20;
	Wed, 04 Feb 2026 15:00:46 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR0-00000001dh9-3RY7;
	Wed, 04 Feb 2026 15:00:46 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v5 11/13] iio: dac: ds4424: convert to regmap
Date: Wed,  4 Feb 2026 15:00:43 +0100
Message-ID: <20260204140045.390677-12-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260204140045.390677-1-o.rempel@pengutronix.de>
References: <20260204140045.390677-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Refactor the driver to use the regmap API.

Replace the driver-specific mutex and manual shadow buffers with the
standard regmap infrastructure for locking and caching.

This ensures the cache is populated from hardware at probe, preventing
state desynchronization (e.g. across suspend/resume).

Define access tables to validate the different register maps of DS44x2
and DS44x4.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Sander Vanheule <sander@svanheule.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
changes v5:
- Add Reviewed-by: Andy ..
- Add include for types.h
- s/{ 0 }/{ }
changes v4:
- Split patch: Moved fsleep() conversion to a separate cleanup patch
- Style fix: Add parentheses to function name in comments
- Cleanup: Remove redundant comment in regmap_config
- Fix typo: Change error message to "Failed to read hardware values"
changes v3:
- Switch to REGCACHE_MAPLE to efficiently handle the sparse register map
  (offset 0xF8) and avoid allocating memory for the unused 0x00-0xF7 range.
- Use explicit regmap_bulk_read() in probe to seed the cache with the
  bootloader configuration. This avoids the invalid read from address 0x00
  that occurred with generic cache defaults.
- Remove ds4424_verify_chip(); devm_regmap_init_i2c() and the subsequent
  bulk read implicitly validate the device presence.
- Use regmap_bulk_write() in ds4424_suspend() to efficiently zero all
  channels.
- Adopt fsleep() for delays and include <linux/array_size.h>.
- Use dev_err_ratelimited() with the physical device context in the read
  path (incorporating feedback aimed at v2 patch 8).
changes v2:
- new patch
---
 drivers/iio/dac/Kconfig  |   1 +
 drivers/iio/dac/ds4424.c | 163 +++++++++++++++++++++------------------
 2 files changed, 91 insertions(+), 73 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 7cd3caec1262..dbbbc45e8718 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -408,6 +408,7 @@ config DPOT_DAC
 config DS4424
 	tristate "Maxim Integrated DS4422/DS4424 DAC driver"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Maxim chips DS4422, DS4424.
 
diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 0a1c7b15fdd2..94fb783ca0b6 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -5,14 +5,17 @@
  * Copyright (C) 2017 Maxim Integrated
  */
 
+#include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/time64.h>
+#include <linux/types.h>
 
 #include <linux/iio/consumer.h>
 #include <linux/iio/driver.h>
@@ -62,11 +65,8 @@ static const struct ds4424_chip_info ds4424_info = {
 };
 
 struct ds4424_data {
-	struct i2c_client *client;
-	struct mutex lock;
-	uint8_t save[DS4424_MAX_DAC_CHANNELS];
+	struct regmap *regmap;
 	struct regulator *vcc_reg;
-	uint8_t raw[DS4424_MAX_DAC_CHANNELS];
 	const struct ds4424_chip_info *chip_info;
 };
 
@@ -77,41 +77,72 @@ static const struct iio_chan_spec ds4424_channels[] = {
 	DS4424_CHANNEL(3),
 };
 
-static int ds4424_get_value(struct iio_dev *indio_dev,
-			     int *val, int channel)
-{
-	struct ds4424_data *data = iio_priv(indio_dev);
-	int ret;
+static const struct regmap_range ds44x2_ranges[] = {
+	regmap_reg_range(DS4424_DAC_ADDR(0), DS4424_DAC_ADDR(1)),
+};
 
-	mutex_lock(&data->lock);
-	ret = i2c_smbus_read_byte_data(data->client, DS4424_DAC_ADDR(channel));
-	if (ret < 0)
-		goto fail;
+static const struct regmap_range ds44x4_ranges[] = {
+	regmap_reg_range(DS4424_DAC_ADDR(0), DS4424_DAC_ADDR(3)),
+};
 
-	*val = ret;
+static const struct regmap_access_table ds44x2_table = {
+	.yes_ranges = ds44x2_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ds44x2_ranges),
+};
 
-fail:
-	mutex_unlock(&data->lock);
-	return ret;
-}
+static const struct regmap_access_table ds44x4_table = {
+	.yes_ranges = ds44x4_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ds44x4_ranges),
+};
 
-static int ds4424_set_value(struct iio_dev *indio_dev,
-			     int val, struct iio_chan_spec const *chan)
+static const struct regmap_config ds44x2_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_MAPLE,
+	.max_register = DS4424_DAC_ADDR(1),
+	.rd_table = &ds44x2_table,
+	.wr_table = &ds44x2_table,
+};
+
+static const struct regmap_config ds44x4_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_MAPLE,
+	.max_register = DS4424_DAC_ADDR(3),
+	.rd_table = &ds44x4_table,
+	.wr_table = &ds44x4_table,
+};
+
+static int ds4424_init_regmap(struct i2c_client *client,
+			      struct iio_dev *indio_dev)
 {
 	struct ds4424_data *data = iio_priv(indio_dev);
+	const struct regmap_config *regmap_config;
+	u8 vals[DS4424_MAX_DAC_CHANNELS];
 	int ret;
 
-	mutex_lock(&data->lock);
-	ret = i2c_smbus_write_byte_data(data->client,
-			DS4424_DAC_ADDR(chan->channel), val);
-	if (ret < 0)
-		goto fail;
+	if (indio_dev->num_channels == DS4424_MAX_DAC_CHANNELS)
+		regmap_config = &ds44x4_regmap_config;
+	else
+		regmap_config = &ds44x2_regmap_config;
 
-	data->raw[chan->channel] = val;
+	data->regmap = devm_regmap_init_i2c(client, regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
+				     "Failed to init regmap.\n");
 
-fail:
-	mutex_unlock(&data->lock);
-	return ret;
+	/*
+	 * Prime the cache with the bootloader's configuration.
+	 * regmap_bulk_read() will automatically populate the cache with
+	 * the values read from the hardware.
+	 */
+	ret = regmap_bulk_read(data->regmap, DS4424_DAC_ADDR(0), vals,
+			       indio_dev->num_channels);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to read hardware values\n");
+
+	return 0;
 }
 
 static int ds4424_read_raw(struct iio_dev *indio_dev,
@@ -119,11 +150,13 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct ds4424_data *data = iio_priv(indio_dev);
-	int ret, regval;
+	unsigned int regval;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = ds4424_get_value(indio_dev, &regval, chan->channel);
+		ret = regmap_read(data->regmap, DS4424_DAC_ADDR(chan->channel),
+				  &regval);
 		if (ret < 0) {
 			dev_err_ratelimited(indio_dev->dev.parent,
 					    "Failed to read channel %d: %pe\n",
@@ -166,58 +199,44 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 		if (val > 0)
 			abs_val |= DS4424_DAC_SOURCE;
 
-		return ds4424_set_value(indio_dev, abs_val, chan);
+		return regmap_write(data->regmap, DS4424_DAC_ADDR(chan->channel),
+				    abs_val);
 
 	default:
 		return -EINVAL;
 	}
 }
 
-static int ds4424_verify_chip(struct iio_dev *indio_dev)
-{
-	int ret, val;
-
-	ret = ds4424_get_value(indio_dev, &val, 0);
-	if (ret < 0)
-		dev_err(&indio_dev->dev,
-				"%s failed. ret: %d\n", __func__, ret);
-
-	return ret;
-}
-
 static int ds4424_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ds4424_data *data = iio_priv(indio_dev);
-	int ret = 0;
-	int i;
-
-	for (i = 0; i < indio_dev->num_channels; i++) {
-		data->save[i] = data->raw[i];
-		ret = ds4424_set_value(indio_dev, 0,
-				&indio_dev->channels[i]);
-		if (ret < 0)
-			return ret;
+	u8 zero_buf[DS4424_MAX_DAC_CHANNELS] = { };
+	int ret;
+
+	/* Disable all outputs, bypass cache so the '0' isn't saved */
+	regcache_cache_bypass(data->regmap, true);
+	ret = regmap_bulk_write(data->regmap, DS4424_DAC_ADDR(0),
+				zero_buf, indio_dev->num_channels);
+	regcache_cache_bypass(data->regmap, false);
+	if (ret) {
+		dev_err(dev, "Failed to zero outputs: %pe\n", ERR_PTR(ret));
+		return ret;
 	}
-	return ret;
+
+	regcache_cache_only(data->regmap, true);
+	regcache_mark_dirty(data->regmap);
+
+	return 0;
 }
 
 static int ds4424_resume(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ds4424_data *data = iio_priv(indio_dev);
-	int ret = 0;
-	int i;
 
-	for (i = 0; i < indio_dev->num_channels; i++) {
-		ret = ds4424_set_value(indio_dev, data->save[i],
-				&indio_dev->channels[i]);
-		if (ret < 0)
-			return ret;
-	}
-	return ret;
+	regcache_cache_only(data->regmap, false);
+	return regcache_sync(data->regmap);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ds4424_pm_ops, ds4424_suspend, ds4424_resume);
@@ -245,7 +264,6 @@ static int ds4424_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-	data->client = client;
 	indio_dev->name = id->name;
 	data->chip_info = chip_info;
 
@@ -254,7 +272,6 @@ static int ds4424_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(data->vcc_reg),
 				     "Failed to get vcc-supply regulator.\n");
 
-	mutex_init(&data->lock);
 	ret = regulator_enable(data->vcc_reg);
 	if (ret < 0) {
 		dev_err(&client->dev,
@@ -269,15 +286,15 @@ static int ds4424_probe(struct i2c_client *client)
 	 */
 	fsleep(1 * USEC_PER_MSEC);
 
-	ret = ds4424_verify_chip(indio_dev);
-	if (ret < 0)
-		goto fail;
-
 	indio_dev->num_channels = chip_info->num_channels;
 	indio_dev->channels = ds4424_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ds4424_iio_info;
 
+	ret = ds4424_init_regmap(client, indio_dev);
+	if (ret)
+		goto fail;
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev,
-- 
2.47.3

