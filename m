Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EFB329E64
	for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494188; cv=none; b=do4zJgMXEc/1kYk7M7cihHY6EORZ4Fp0itV2aLSRcdbHWyxMXBuoy/3vk1SYEoTXoonBjyxpmxi1qf4Yc6lAJL/Z9IZ3m24UBkX3sAHaauNJfoU8ITsj9+ZUW9xaATU13eyL4vTqHMN/hSx5xgNkkF1B4gZUAGOv7R8ixDkYYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494188; c=relaxed/simple;
	bh=ROeV3eFQ6wFSDgrK1HKXQAwS3oeqGxNJwHliijxFUnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfXAlEI7I2izN42idNIS9GkXuxzOCSU2LBy8wEq/cK4AfPXcnyncIEGRFxCnpSA3DdBNWPJo9Xl9gvy9yqtq7NZSqsoYsy/lRQdn30TLlXFg0L9cUcmLfXMcUDPEJxlWkX774XQB5SZ92r8A2ZH12HAAwbIXyiwY/mdrVdnARHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGk-0003pd-0E; Tue, 27 Jan 2026 07:09:42 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGk-002hiS-07;
	Tue, 27 Jan 2026 07:09:41 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGj-0000000GQFj-13aU;
	Tue, 27 Jan 2026 07:09:41 +0100
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
Subject: [PATCH v2 7/8] iio: dac: ds4424: add Rfs-based scale and per-variant limits
Date: Tue, 27 Jan 2026 07:09:38 +0100
Message-ID: <20260127060939.3914006-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127060939.3914006-1-o.rempel@pengutronix.de>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
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
index 8110ca7f062f..891069d8c80a 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -14,6 +14,7 @@
 #include <linux/iio/machine.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -21,6 +22,7 @@
 #define DS4424_MAX_DAC_CHANNELS		4
 
 #define DS4424_DAC_MASK			GENMASK(6, 0)
+#define DS4404_DAC_MASK			GENMASK(4, 0)
 #define DS4424_DAC_SOURCE		BIT(7)
 
 #define DS4424_DAC_ADDR(chan)   ((chan) + 0xf8)
@@ -40,9 +42,38 @@ enum ds4424_device_ids {
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
+	int vref_mv;
+	int scale_denom;
+	u8 result_mask;
+};
+
+static const struct ds4424_chip_info ds4424_info = {
+	.vref_mv = 976,
+	.scale_denom = 16,
+	.result_mask = DS4424_DAC_MASK,
+};
+
+/* DS4402 is handled like DS4404 (same resolution and scale formula). */
+static const struct ds4424_chip_info ds4404_info = {
+	.vref_mv = 1230,
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
@@ -125,11 +156,20 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
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
+		*val = data->chip_info->vref_mv;
+		*val2 = data->rfs_ohms[chan->channel] *
+			data->chip_info->scale_denom;
+		return IIO_VAL_FRACTIONAL;
 
 	default:
 		return -EINVAL;
@@ -150,7 +190,7 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		abs_val = abs(val);
 
-		if (abs_val > DS4424_DAC_MASK)
+		if (abs_val > data->chip_info->result_mask)
 			return -EINVAL;
 
 		/*
@@ -185,6 +225,65 @@ static int ds4424_verify_chip(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int ds4424_setup_channels(struct i2c_client *client,
+				 struct ds4424_data *data,
+				 struct iio_dev *indio_dev)
+{
+	struct iio_chan_spec *channels;
+	size_t channels_size;
+
+	channels_size = indio_dev->num_channels * sizeof(ds4424_channels[0]);
+	/* Use a local non-const pointer for modification */
+	channels = devm_kmemdup(&client->dev, ds4424_channels, channels_size,
+				GFP_KERNEL);
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
+			return dev_err_probe(dev, -EINVAL, "maxim,rfs-ohms entry %d is zero\n",
+					     i);
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
@@ -220,7 +319,7 @@ static int ds4424_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ds4424_pm_ops, ds4424_suspend, ds4424_resume);
 
-static const struct iio_info ds4424_info = {
+static const struct iio_info ds4424_iio_info = {
 	.read_raw = ds4424_read_raw,
 	.write_raw = ds4424_write_raw,
 };
@@ -257,15 +356,20 @@ static int ds4424_probe(struct i2c_client *client)
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
@@ -282,9 +386,16 @@ static int ds4424_probe(struct i2c_client *client)
 	if (ret < 0)
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

