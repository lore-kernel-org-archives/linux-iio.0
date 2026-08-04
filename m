Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA074A2E24
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871753; cv=none; b=JbQwc1KTZGf4Auq4qLRX9fXPA09DfQIsPFFRud+H4tnhtuPRpqhaBexV1ybldbluwAPoqXM3NIOPD+VnU6kqvHWlSHpPbEp8Pg5LLf3OMYxYMSZYWBGykgC971AMBmGDTOio9UzZAvpNgyLTI9PhOdRZagHj5BIx/vKWwp33sFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871753; c=relaxed/simple;
	bh=ihfieZOmGRUlg9L0kPunx38Slio+02jdZ49LHDO693Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHud5nDVQzO43wH3r3uuANi9tEg9UpJHHbhOyNg4mKUlJdl9LwJ9975JWEZdAgJ5Q3XFqnzste7ar9AnWp2+OIiaMkXdRFWXWE2e3/gnTSAYDjU8FBT7GnvPqjv2gIcy4xl6uVHuhhShTrPK26UHUheKgBolo9luevCNKU/kYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOqPUJfd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOqPUJfd"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49800c6a846so1412955e9.3
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785871745; x=1786476545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EsUmxdiO7N7txn+9Zra2ZwFC2m1JBFv1qJhgneFjwTc=;
        b=JOqPUJfdUO3xbpmDCwsMNwOKn1JK2Gr4oB0BzIy3LD+M+d1U3ICnR8X1An7oBUa6Z8
         b9E+czlujj/Bon1i9w/aW7rS04vdSarCtbwfWKPc9uStvjB1lcllueyaO5Yqg7xuMMso
         N1Eb4cyjumxieSuZQ+YawDP9HZF777x4eMKrRRS2LTct7pjBIZ2tUdbihvPv2QB71uNk
         w2Yq1BD+w/f9uSJba6dby4OR0UTVtf5oZcpIAYXiJIUVDjPFKEMw47HB144fnGAwbO+1
         osZ2OL2BuiNnMzJ+WrCw9HbE+of9laNT60uyjfT3SvfRN8ue65jySxHeRHmm2hNPgl2G
         C3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785871745; x=1786476545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EsUmxdiO7N7txn+9Zra2ZwFC2m1JBFv1qJhgneFjwTc=;
        b=EJoqpVQQ8SdhACWp6ML1+s4N6nuvKjYvbvstn6Apnbemt+dnxt6x5d2hdJQhleQSLX
         E2BH0GCJcJv0uyemS2oPgUw3EpT6f6C2U6KcDODUWeG2JmKIgRY0+j3wkcbvcH+40p7v
         7ZqZkCrm/wBD4mjA7vNvBt6miPtiZBNUYeLbRmj9A+ZN22/GCCtfyQUHHYWIEGKWla4j
         YMiueXAFF75Vm/Fso638BTUrgXFQ4jJMcLC9hxhQZmn4pavnkcd0Dfo1HCGpq4jMUxxJ
         mmJOx4rmXpq3DKbitjoCdwh0gWcY6WUhJiUuS29UEgarNalLv+FgB2cNtL79UTTAiDL3
         1irg==
X-Gm-Message-State: AOJu0YyHoznSCmSDym8CBQWBK25+TE3Pqp9ZpCpA5ABBpsI8JH0E85Pk
	w9qNVqrhZoXfmH22ht+lwuRXnsNIwLXuQ1Qtherfo2zbp+4Iizu/zJM3r4eJIvtk
X-Gm-Gg: AR+sD12oOq2r+lD41bbrZQD2ecJk1EMgW9PNEdjkh5X1+h0C8nG/FIxZezVaA9K/CwT
	IoefdatQOS7rEn1zmWYggRaAhWADQKHWcwIB2wi/S7h9yYZemUamY0ym1VnqjHtGDdlXYHvRaA5
	iYO1vq/ZrU6nHx6NQkbixUgI+7Yk8OVaEu1QPGAWqrMHuWCneZViGGnfzo4UoDA61wR41Y8r03u
	i/s3TTUjGW8rxNqCer8jLLWbsWy564qhY7d/3XSAAXIteitLk5LtK9rVl8lC/2xRORPwER1Vtbj
	ScEqN7mhXg+AHokej2Ut6YpwoRDNL8ZVoaY70xo0CFTig8T6ebGH4E6U8jZ9d81fnwA5+1TeiVx
	5heSstsmRTDlG9tc2wIC7jasgT/AICDvAj380cBypiKXEQ8gvyzjYkrMMjdz69lOh7a25RGB+uK
	LuHohPApHgi0szIGVv8/izoQ2J3LFMxfJkkaVVhMo2xV13oweJVYQNqkqiZlTBSEv/FOmcjYP8e
	4ON7NFHRU2OHGlCQ9x+szo=
X-Received: by 2002:a7b:cc97:0:b0:492:6447:7a7f with SMTP id 5b1f17b1804b1-4994e7a7f1fmr5617565e9.6.1785871745299;
        Tue, 04 Aug 2026 12:29:05 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:68f0:30cb:8ca1:f965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf820sm8248745e9.0.2026.08.04.12.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:29:04 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mike.looijmans@topic.nl,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jorge.marques@analog.com,
	antoniu.miclaus@analog.com,
	mazziesaccount@gmail.com,
	jishnu.prakash@oss.qualcomm.com,
	duje@dujemihanovic.xyz,
	wens@kernel.org,
	sakari.ailus@linux.intel.com,
	linusw@kernel.org,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH v9 3/3] iio: adc: ti-ads1100: Add ti-ads1110 support to  ti-ads1100 driver
Date: Tue,  4 Aug 2026 21:28:40 +0200
Message-ID: <20260804192840.29121-4-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260804192840.29121-1-jakubszczudlo40@gmail.com>
References: <20260804192840.29121-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ADS1110 support that have faster datarate than ADS1100, it also uses
internal voltage reference of 2.048V for measurement.

Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
---
 drivers/iio/adc/Kconfig      |  9 ++--
 drivers/iio/adc/ti-ads1100.c | 85 ++++++++++++++++++++++++++----------
 2 files changed, 69 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3755a81c1efd..49a9ac3bf43d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1768,11 +1768,14 @@ config TI_ADS1018
          called ti-ads1018.
 
 config TI_ADS1100
-	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
+	tristate "Texas Instruments ADS1100 and similar single channel I2C ADC"
 	depends on I2C
 	help
-	  If you say yes here you get support for Texas Instruments ADS1100 and
-	  ADS1000 ADC chips.
+	  If you say yes here you get support for TI single channel I2C Analog
+	  Devices.
+	  * ADS1000 12-Bit, 128 SPS Analog-to-Digital Converter
+	  * ADS1100 16-Bit, 128 SPS Analog-to-Digital Converter
+	  * ADS1110 16-Bit, 240 SPS Analog-to-Digital Converter
 
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1100.
diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 288d209ecf92..acbf9b96c545 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2023, Topic Embedded Products
  *
  * Datasheet: https://www.ti.com/lit/gpn/ads1100
- * IIO driver for ADS1100 and ADS1000 ADC 16-bit I2C
+ * IIO driver for ADS1100 and similar single channel ADC 16-bit I2C
  */
 
 #include <linux/bitfield.h>
@@ -41,20 +41,44 @@
 #define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
 
 #define ADS1100_SLEEP_DELAY_MS	2000
+#define ADS1110_INTERNAL_REF_mV 2048
 
 static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
+static const int ads1110_data_rate[] = { 240, 60, 30, 15 };
 static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
 
 /* Timeout based on the minimum sample rate of 8 SPS (7500ms) */
 #define ADS1100_MAX_DRDY_TIMEOUT_US	(7500 * USEC_PER_MSEC)
 
+struct ads1100_config {
+	const char *name;
+	const int *available_data_rate_hz;
+	const int data_rate_count;
+	bool has_internal_vref_only;
+};
+
+static const struct ads1100_config ads1100_config = {
+	.name = "ads1100",
+	.available_data_rate_hz = ads1100_data_rate,
+	.data_rate_count = ARRAY_SIZE(ads1100_data_rate),
+	.has_internal_vref_only = false,
+};
+
+static const struct ads1100_config ads1110_config = {
+	.name = "ads1110",
+	.available_data_rate_hz = ads1110_data_rate,
+	.data_rate_count = ARRAY_SIZE(ads1110_data_rate),
+	.has_internal_vref_only = true,
+};
+
 struct ads1100_data {
 	struct i2c_client *client;
 	struct regulator *reg_vdd;
 	struct mutex lock;
 	int scale_avail[2 * 4]; /* 4 gain settings */
+	const struct ads1100_config *chip_info;
 	u8 config;
-	bool supports_data_rate; /* Only the ADS1100 can select the rate */
+	bool supports_data_rate;
 };
 
 static const struct iio_chan_spec ads1100_channel = {
@@ -90,6 +114,20 @@ static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
 	return 0;
 };
 
+static int ads1100_get_vref_millivolts(struct ads1100_data *data)
+{
+	int voltage_uV;
+
+	if (data->chip_info->has_internal_vref_only)
+		return ADS1110_INTERNAL_REF_mV;
+
+	voltage_uV = regulator_get_voltage(data->reg_vdd);
+	if (voltage_uV < 0)
+		return voltage_uV;
+
+	return voltage_uV / (MICRO / MILLI);
+}
+
 static int ads1100_data_bits(struct ads1100_data *data)
 {
 	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
@@ -145,7 +183,7 @@ static int ads1100_conversion_busy(struct ads1100_data *data)
 static int ads1100_wait_single_conversion(struct ads1100_data *data)
 {
 	int data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
-	int data_rate_Hz = ads1100_data_rate[data_rate_index];
+	int data_rate_Hz = data->chip_info->available_data_rate_hz[data_rate_index];
 	unsigned long poll_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, data_rate_Hz) / 4;
 	int busy;
 	int ret;
@@ -222,7 +260,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (ret)
 		return ret;
 
-	microvolts = regulator_get_voltage(data->reg_vdd);
+	microvolts = ads1100_get_vref_millivolts(data) * (MICRO / MILLI);
 	/*
 	 * val2 is in 'micro' units, n = val2 / 1000000
 	 * result must be millivolts, d = microvolts / 1000
@@ -245,9 +283,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 	unsigned int size;
 	int ret;
 
-	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
+	size = data->supports_data_rate ? data->chip_info->data_rate_count : 1;
 	for (i = 0; i < size; i++) {
-		if (ads1100_data_rate[i] == rate)
+		if (data->chip_info->available_data_rate_hz[i] == rate)
 			break;
 	}
 
@@ -267,14 +305,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 	return ads1100_poll_data_ready(data);
 }
 
-static int ads1100_get_vdd_millivolts(struct ads1100_data *data)
-{
-	return regulator_get_voltage(data->reg_vdd) / (MICRO / MILLI);
-}
-
 static void ads1100_calc_scale_avail(struct ads1100_data *data)
 {
-	int millivolts = ads1100_get_vdd_millivolts(data);
+	int millivolts = ads1100_get_vref_millivolts(data);
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
@@ -296,9 +329,9 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*type = IIO_VAL_INT;
-		*vals = ads1100_data_rate;
+		*vals = data->chip_info->available_data_rate_hz;
 		if (data->supports_data_rate)
-			*length = ARRAY_SIZE(ads1100_data_rate);
+			*length = data->chip_info->data_rate_count;
 		else
 			*length = 1;
 		return IIO_AVAIL_LIST;
@@ -318,6 +351,7 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct ads1100_data *data = iio_priv(indio_dev);
+	int data_rate_index;
 
 	guard(mutex)(&data->lock);
 	switch (mask) {
@@ -333,12 +367,12 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* full-scale is the supply voltage in millivolts */
-		*val = ads1100_get_vdd_millivolts(data);
+		*val = ads1100_get_vref_millivolts(data);
 		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
-						   data->config)];
+		data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
+		*val = data->chip_info->available_data_rate_hz[data_rate_index];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -418,7 +452,12 @@ static int ads1100_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->lock);
 
-	indio_dev->name = "ads1100";
+	data->chip_info = i2c_get_match_data(client);
+	if (!data->chip_info)
+		return dev_err_probe(dev, -ENODATA,
+				     "Can't get device data from firmware\n");
+
+	indio_dev->name = data->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &ads1100_channel;
 	indio_dev->num_channels = 1;
@@ -500,16 +539,18 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
 				 NULL);
 
 static const struct i2c_device_id ads1100_id[] = {
-	{ .name = "ads1100" },
-	{ .name = "ads1000" },
+	{ .name = "ads1000", .driver_data = (kernel_ulong_t)&ads1100_config },
+	{ .name = "ads1100", .driver_data = (kernel_ulong_t)&ads1100_config },
+	{ .name = "ads1110", .driver_data = (kernel_ulong_t)&ads1110_config },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, ads1100_id);
 
 static const struct of_device_id ads1100_of_match[] = {
-	{.compatible = "ti,ads1100" },
-	{.compatible = "ti,ads1000" },
+	{ .compatible = "ti,ads1000", .data = &ads1100_config },
+	{ .compatible = "ti,ads1100", .data = &ads1100_config },
+	{ .compatible = "ti,ads1110", .data = &ads1110_config },
 	{ }
 };
 
-- 
2.47.3

