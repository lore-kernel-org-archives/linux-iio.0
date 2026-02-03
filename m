Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F36139903E
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111285; cv=none; b=bgsuCRK7pAqGjEm7G5OQETSjgIvl8gbZP7eoPKoo+5T9yrFYITfORALzFeW+OwIemOUAq6H36AL8HbCe3SPb51mGTi49RAhuOhtXfzmazIkvhD08h62FATlvaSwjCA4qlYsV0lQwG8pLMg7qhpXlT9xHlPbBGZD/4NdL/Y7z8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111285; c=relaxed/simple;
	bh=rmjahTQPvSv9XFT3G+4DeZzcjyYHvnDAvMCOEXwXrn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjhY4cpGzcR+u8r7O8jqsmMazXKC+jSAlLDptxLyyKKPWP8s7ruj6pScpN2dfww91Qec0zUt0SIW332GOg8iwV1ml7B2rrM2JVX+LJdpBoO/v0CEXKAXiB/myHVNKyONidNDc1kisV8aONCqLELFVMByU97K5VGJMsawchMk5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-0003lo-S0; Tue, 03 Feb 2026 10:34:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCns-003sli-0S;
	Tue, 03 Feb 2026 10:34:35 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-0000000AhAo-1IEc;
	Tue, 03 Feb 2026 10:34:35 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v4 13/13] iio: dac: ds4424: add Rfs-based scale and per-variant limits
Date: Tue,  3 Feb 2026 10:34:33 +0100
Message-ID: <20260203093434.2548978-14-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203093434.2548978-1-o.rempel@pengutronix.de>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
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

Parse optional maxim,rfs-ohms values to derive the per-channel output
current scale (mA per step) for the IIO current ABI.

Behavior changes:
- If maxim,rfs-ohms is present, IIO_CHAN_INFO_SCALE becomes available
  and reports mA/step derived from Rfs.
- If maxim,rfs-ohms is missing, SCALE is not exposed to keep older DTs
  working without requiring updates.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
changes v4:
- Split series: moved infrastructure and RAW limit fixes to a preceding patch.
- Replaced dynamic channel allocation (devm_kmemdup_array()) with static
  const arrays (ds4424_channels_with_scale) to handle the two states.
- Removed log message when maxim,rfs-ohms is missing.
changes v3:
- Added explicit check for negative return from device_property_count_u32().
- Rename vref_mv to vref_mV
- Use devm_kmemdup_array() instead of devm_kmemdup()
- Use %u for unsigned index in Rfs error logs.
- Consolidated Rfs parse logs to a single line.
changes v2:
- Reorder struct ds4424_chip_info members to optimize padding.
- Use GENMASK() for chip variant masks instead of hex constants.
- Simplify ds4424_setup_channels: use direct devm_kmemdup to avoid stack
  usage and memcpy.
- Use local 'dev' pointer and dev_err_probe() in ds4424_parse_rfs for
  cleaner error handling.
- Rename the static iio_info struct to ds4424_iio_info to prevent name
  collision with the new hardware chip_info structs.
- Use unsigned int for loop counters.
- Rebase on top of regmap and symmetrical raw_access refactoring.
---
 drivers/iio/dac/ds4424.c | 81 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index d7ccf031b234..e34a8c3fba87 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -12,6 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -37,27 +38,46 @@
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 }
 
+#define DS4424_CHANNEL_WITH_SCALE(chan) { \
+	.type = IIO_CURRENT, \
+	.indexed = 1, \
+	.output = 1, \
+	.channel = chan, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE), \
+}
+
 struct ds4424_chip_info {
+	int vref_mV;
+	int scale_denom;
 	u8 result_mask;
 	u8 num_channels;
 };
 
 static const struct ds4424_chip_info ds4402_info = {
+	.vref_mV = 1230,
+	.scale_denom = 4,
 	.result_mask = DS4404_DAC_MASK,
 	.num_channels = DS4422_MAX_DAC_CHANNELS,
 };
 
 static const struct ds4424_chip_info ds4404_info = {
+	.vref_mV = 1230,
+	.scale_denom = 4,
 	.result_mask = DS4404_DAC_MASK,
 	.num_channels = DS4424_MAX_DAC_CHANNELS,
 };
 
 static const struct ds4424_chip_info ds4422_info = {
+	.vref_mV = 976,
+	.scale_denom = 16,
 	.result_mask = DS4424_DAC_MASK,
 	.num_channels = DS4422_MAX_DAC_CHANNELS,
 };
 
 static const struct ds4424_chip_info ds4424_info = {
+	.vref_mV = 976,
+	.scale_denom = 16,
 	.result_mask = DS4424_DAC_MASK,
 	.num_channels = DS4424_MAX_DAC_CHANNELS,
 };
@@ -66,6 +86,8 @@ struct ds4424_data {
 	struct regmap *regmap;
 	struct regulator *vcc_reg;
 	const struct ds4424_chip_info *chip_info;
+	u32 rfs_ohms[DS4424_MAX_DAC_CHANNELS];
+	bool has_rfs;
 };
 
 static const struct iio_chan_spec ds4424_channels[] = {
@@ -75,6 +97,13 @@ static const struct iio_chan_spec ds4424_channels[] = {
 	DS4424_CHANNEL(3),
 };
 
+static const struct iio_chan_spec ds4424_channels_with_scale[] = {
+	DS4424_CHANNEL_WITH_SCALE(0),
+	DS4424_CHANNEL_WITH_SCALE(1),
+	DS4424_CHANNEL_WITH_SCALE(2),
+	DS4424_CHANNEL_WITH_SCALE(3),
+};
+
 static const struct regmap_range ds44x2_ranges[] = {
 	regmap_reg_range(DS4424_DAC_ADDR(0), DS4424_DAC_ADDR(1)),
 };
@@ -167,6 +196,15 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
 			*val = -*val;
 
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (!data->has_rfs)
+			return -EINVAL;
+
+		/* SCALE is mA/step: mV / Ohm = mA. */
+		*val = data->chip_info->vref_mV;
+		*val2 = data->rfs_ohms[chan->channel] *
+			data->chip_info->scale_denom;
+		return IIO_VAL_FRACTIONAL;
 
 	default:
 		return -EINVAL;
@@ -205,6 +243,39 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int ds4424_parse_rfs(struct i2c_client *client,
+			    struct ds4424_data *data,
+			    struct iio_dev *indio_dev)
+{
+	struct device *dev = &client->dev;
+	int count, ret;
+
+	if (!device_property_present(dev, "maxim,rfs-ohms"))
+		return 0;
+
+	count = device_property_count_u32(dev, "maxim,rfs-ohms");
+	if (count < 0)
+		return dev_err_probe(dev, count, "Failed to count maxim,rfs-ohms entries\n");
+	if (count != indio_dev->num_channels)
+		return dev_err_probe(dev, -EINVAL, "maxim,rfs-ohms must have %u entries\n",
+				     indio_dev->num_channels);
+
+	ret = device_property_read_u32_array(dev, "maxim,rfs-ohms",
+					     data->rfs_ohms,
+					     indio_dev->num_channels);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read maxim,rfs-ohms property\n");
+
+	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
+		if (!data->rfs_ohms[i])
+			return dev_err_probe(dev, -EINVAL, "maxim,rfs-ohms entry %u is zero\n", i);
+	}
+
+	data->has_rfs = true;
+
+	return 0;
+}
+
 static int ds4424_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -284,7 +355,6 @@ static int ds4424_probe(struct i2c_client *client)
 
 	indio_dev->name = client->name;
 	indio_dev->num_channels = chip_info->num_channels;
-	indio_dev->channels = ds4424_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ds4424_iio_info;
 
@@ -292,6 +362,15 @@ static int ds4424_probe(struct i2c_client *client)
 	if (ret)
 		goto fail;
 
+	ret = ds4424_parse_rfs(client, data, indio_dev);
+	if (ret)
+		goto fail;
+
+	if (data->has_rfs)
+		indio_dev->channels = ds4424_channels_with_scale;
+	else
+		indio_dev->channels = ds4424_channels;
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev,
-- 
2.47.3

