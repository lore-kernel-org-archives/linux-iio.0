Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586BE2E06ED
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614713; cv=none; b=bqQwKupPq+Nz2JzdJ5u/FU179GBBqDH2xFA60osm/hSUSLjpeZETBbD9u/ucU8wKw32Bg3uOPC+qQPb2c6/AKZC3J7hJ2Uc4I2sviLKvKnyTvXe/SC4VmGF7nq7JI9Ic5b0KIWtLfdN/5L8CPzjKExVqjZcE1N85ih89j6O10+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614713; c=relaxed/simple;
	bh=g2b3UszPCHECOmiGzz20e72H5NdvyxMqvnX7o6q8Vr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbmBAw5DuiRP4kBOoFU1P6lrDDpcdfj4+5/8r9gthKIlUrHRdcJy5kkHVgUu89TxoswDBiENFN2m3N4Jzv26uc7KqSgNUr8P/IwaHMwXjEM6/O3OnshdAgBzY65CShBUpQ59KVgolXOoc3QY9X0aEtlPL7eoYVOwm/hNBFkpNcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vl7cg-0003ow-Nh; Wed, 28 Jan 2026 16:38:26 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vl7cg-002wSZ-3A;
	Wed, 28 Jan 2026 16:38:26 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vl7cg-0000000FRAv-0oe3;
	Wed, 28 Jan 2026 16:38:26 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v3 8/8] iio: dac: ds4424: add Rfs-based scale and per-variant limits
Date: Wed, 28 Jan 2026 16:38:24 +0100
Message-ID: <20260128153824.3679187-9-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128153824.3679187-1-o.rempel@pengutronix.de>
References: <20260128153824.3679187-1-o.rempel@pengutronix.de>
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

Select per-variant parameters to match the shared register map while
handling different data widths and full-scale current calculations.

Behavior changes:
- If maxim,rfs-ohms is present, IIO_CHAN_INFO_SCALE becomes available
  and reports mA/step derived from Rfs.
- If maxim,rfs-ohms is missing, SCALE is not exposed to keep older DTs
  working without requiring updates.
- RAW writes are now limited to the representable sign-magnitude range
  of the detected variant to avoid silent truncation (e.g. +/-31 on
  DS440x).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
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
 drivers/iio/dac/ds4424.c | 121 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 116 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 9bef1c60b2eb..2b01e20daee4 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -12,6 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -24,6 +25,7 @@
 #define DS4424_MAX_DAC_CHANNELS		4
 
 #define DS4424_DAC_MASK			GENMASK(6, 0)
+#define DS4404_DAC_MASK			GENMASK(4, 0)
 #define DS4424_DAC_SOURCE		BIT(7)
 
 #define DS4424_DAC_ADDR(chan)   ((chan) + 0xf8)
@@ -43,9 +45,38 @@ enum ds4424_device_ids {
 	ID_DS4424,
 };
 
+/*
+ * Two variant groups share the same register map but differ in:
+ * - resolution/data mask (DS4402/DS4404: 5-bit, DS4422/DS4424: 7-bit)
+ * - full-scale current calculation (different Vref and divider)
+ * Addressing also differs (DS440x tri-level, DS442x bi-level), but is
+ * handled via board configuration, not driver logic.
+ */
+struct ds4424_chip_info {
+	int vref_mV;
+	int scale_denom;
+	u8 result_mask;
+};
+
+static const struct ds4424_chip_info ds4424_info = {
+	.vref_mV = 976,
+	.scale_denom = 16,
+	.result_mask = DS4424_DAC_MASK,
+};
+
+/* DS4402 is handled like DS4404 (same resolution and scale formula). */
+static const struct ds4424_chip_info ds4404_info = {
+	.vref_mV = 1230,
+	.scale_denom = 4,
+	.result_mask = DS4404_DAC_MASK,
+};
+
 struct ds4424_data {
 	struct regmap *regmap;
 	struct regulator *vcc_reg;
+	const struct ds4424_chip_info *chip_info;
+	u32 rfs_ohms[DS4424_MAX_DAC_CHANNELS];
+	bool has_rfs;
 };
 
 static const struct iio_chan_spec ds4424_channels[] = {
@@ -144,11 +175,20 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		}
 
-		*val = regval & DS4424_DAC_MASK;
+		*val = regval & data->chip_info->result_mask;
 		if (!(regval & DS4424_DAC_SOURCE))
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
@@ -168,7 +208,7 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		abs_val = abs(val);
-		if (abs_val > DS4424_DAC_MASK)
+		if (abs_val > data->chip_info->result_mask)
 			return -EINVAL;
 
 		/*
@@ -187,6 +227,65 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int ds4424_setup_channels(struct i2c_client *client,
+				 struct ds4424_data *data,
+				 struct iio_dev *indio_dev)
+{
+	struct iio_chan_spec *channels;
+
+	/* Use a local non-const pointer for modification */
+	channels = devm_kmemdup_array(&client->dev, ds4424_channels,
+				      indio_dev->num_channels,
+				      sizeof(ds4424_channels[0]), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	if (data->has_rfs) {
+		for (unsigned int i = 0; i < indio_dev->num_channels; i++)
+			channels[i].info_mask_separate |=
+				BIT(IIO_CHAN_INFO_SCALE);
+	}
+
+	indio_dev->channels = channels;
+
+	return 0;
+}
+
+static int ds4424_parse_rfs(struct i2c_client *client,
+			    struct ds4424_data *data,
+			    struct iio_dev *indio_dev)
+{
+	struct device *dev = &client->dev;
+	int count, ret;
+
+	if (!device_property_present(dev, "maxim,rfs-ohms")) {
+		dev_info_once(dev, "maxim,rfs-ohms missing, scale not supported\n");
+		return 0;
+	}
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
@@ -221,7 +320,7 @@ static int ds4424_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ds4424_pm_ops, ds4424_suspend, ds4424_resume);
 
-static const struct iio_info ds4424_info = {
+static const struct iio_info ds4424_iio_info = {
 	.read_raw = ds4424_read_raw,
 	.write_raw = ds4424_write_raw,
 };
@@ -258,15 +357,20 @@ static int ds4424_probe(struct i2c_client *client)
 	switch (id->driver_data) {
 	case ID_DS4402:
 		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
+		/* See ds4404_info comment above. */
+		data->chip_info = &ds4404_info;
 		break;
 	case ID_DS4404:
 		indio_dev->num_channels = DS4424_MAX_DAC_CHANNELS;
+		data->chip_info = &ds4404_info;
 		break;
 	case ID_DS4422:
 		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
+		data->chip_info = &ds4424_info;
 		break;
 	case ID_DS4424:
 		indio_dev->num_channels = DS4424_MAX_DAC_CHANNELS;
+		data->chip_info = &ds4424_info;
 		break;
 	default:
 		dev_err(&client->dev,
@@ -279,9 +383,16 @@ static int ds4424_probe(struct i2c_client *client)
 	if (ret)
 		goto fail;
 
-	indio_dev->channels = ds4424_channels;
+	ret = ds4424_parse_rfs(client, data, indio_dev);
+	if (ret)
+		goto fail;
+
+	ret = ds4424_setup_channels(client, data, indio_dev);
+	if (ret)
+		goto fail;
+
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &ds4424_info;
+	indio_dev->info = &ds4424_iio_info;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-- 
2.47.3

