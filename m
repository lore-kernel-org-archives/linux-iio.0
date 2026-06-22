Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90053793CB
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782166581; cv=none; b=GLucXu70UjmmIpwI0Pn1MSMLg36bbfcjfIBFH8iCW1VCJQjdCbPgQzKqSje/yGNa/ULyVuDy5695IUp1b0oUEEkv18s2tRyESVTqcMvDYqlv3k6K+4vScUe2tabTwb9h7mqLErF5EuXChvR8jmJwSii1nsTi1t+yzDDmHNqZqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782166581; c=relaxed/simple;
	bh=i5eGL+0bjOTgStgBRZume+8QWckqbNTYKLWKt/J3/Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ushLg8I0wW9uW+cO1myENKpwCKeInPMmMjBT01ZT4guXOF0Uy7Y2v5ooZyiVgaEOfqDcWQRgPznJ3cOfLsVwH817qhZxpjbHCVTxudhcu/iJOPLMbAdC3+nsKdIi+cuq0EcLEdbvxkqYLjx3TuD0hUg64mOEjlSDXA/51UGsF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgwfReTk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgwfReTk"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-462bb734793so2964983f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 15:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782166578; x=1782771378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nx/Y27zDaJEu50hN4vyc9cmgq80oWEzGh4CPSjvb3QU=;
        b=mgwfReTk4w/5vWK58+vTiaRKa8KJX1XdQvRbvOCst88Q6dFucUyYMjaE3wFjcHv+8x
         FkdkWhHMpHlHS0RnwC+u/vi2KCOw9tO00L+JOiSeSsyBDg4Q4ApD1RkhMCrSU53feSTy
         2eGG5rLZUwjJy3+40vFraghHf44slVcv8jyjPYVu3z4hR2fczUlKEtdhhfwVOm4s/J94
         ie0T04aLJ0AF2tEXoI8EoFVaVwPXZe/iYEt/mjBvj08sPtTnQedVKmT8Ld6//q+qVsZ1
         2pZRLpcGHEp0Pr3Ncjvc+XP8pbIvthPyeJgzs5gJsyDy/Q73HdZABKPhypUUWEjiMdKi
         EYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782166578; x=1782771378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nx/Y27zDaJEu50hN4vyc9cmgq80oWEzGh4CPSjvb3QU=;
        b=FV8pCGSlsfgck7un8GikC7lYDNEgCm9mXKdpdRyUYSrQvC3l71NU4znz/p3zIX1Hip
         PkW61GvRmAxhwaCDaEHJoHrX1rBnqh+m0c0l2KRcoQkeJLl1BIL0pUb8D38pADaGlRQW
         Yw14wKyP1bNondl2NWvVBGLxyzGbqwYldY67jBnUKI1W4KgMrG7hZVs8atdozTsQDCGF
         eaXthTrFlVlFrwAgp4zR9s5LY4psUgjby8HkdWEpFI2dAeifpv9vVbN3NcLbg1iuNNhl
         xPOupKm+sRK6h7Pn6y95fSY0Ds8z5utjqQs58DHkZj4UF3lo+Kb0c7nz3bwXeBldkoRf
         Qzww==
X-Gm-Message-State: AOJu0YwVyah2aON+Wz5OnwA0PHj/qgFNMoPeuu1lrVPzt7v3imAvc1gx
	Upf4PJvsS3P/YFa8Iui3e+b3NMBN/kDQeCPGogP6JrgNhsQXALQsl3pL1na6wZKB
X-Gm-Gg: AfdE7ckVEUaQSzdXB7kRANYof14NZZvX2UA4iE+Cx9rO3ZDFV9Qoavg8JpW/2Ohlrw9
	SsoLdlFCI71lXhzH5zF9cFLpXdCrprpjRPEl+7HTz4Hj+JgGAHaFhC56C0zJPxSLb6Eo4zJZa9K
	EWb5wrTn43bxJF2VYkp+CCQlNZsNIktEyX9TNxIqgJoaciNMeTKyefa0J3Bx93IZX/IasSkUFfb
	yjlVJGDIMINesCN62/1uZosE+vfN5GgV3HqUL1VTI5anYwxb72omW4ddKr28MD2Nnep7U4cKzX2
	AuOlI9NLcqIHQS3zO/W7uLUW5Kls9QDHpXEVlZESq4RaUFmNIQ7gkEpbdF8PF7CCv/T5SBb7VWn
	Yetgm9Is15CpL1KGDn/Z2oWUaCDu56CaSCEu66B0nor5bRQcClcJVemOKXW9z42fqPchGKgoQGN
	B9NxehBOh7Q496fFHlLuG/miKZsEc5
X-Received: by 2002:a05:6000:4013:b0:454:a41f:d082 with SMTP id ffacd0b85a97d-466607440bcmr18403853f8f.3.1782166578349;
        Mon, 22 Jun 2026 15:16:18 -0700 (PDT)
Received: from Nitro5-JS.kielce.vectranet.pl ([2a02:2a40:27ec:2900::3ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c53fdsm31319845f8f.10.2026.06.22.15.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:16:17 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	antoniu.miclaus@analog.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	duje@dujemihanovic.xyz,
	jic23@kernel.org,
	jishnu.prakash@oss.qualcomm.com,
	jorge.marques@analog.com,
	joshua.crofts1@gmail.com,
	krzk+dt@kernel.org,
	linusw@kernel.org,
	jakubszczudlo40@gmail.com,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	robh@kernel.org,
	sakari.ailus@linux.intel.com,
	wens@kernel.org
Subject: [PATCH v4 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100 driver
Date: Tue, 23 Jun 2026 00:15:50 +0200
Message-ID: <20260622221550.374235-4-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
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
 drivers/iio/adc/Kconfig      |  6 +--
 drivers/iio/adc/ti-ads1100.c | 81 +++++++++++++++++++++++++++---------
 2 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1c663c98c6c9..30198335c63b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1765,11 +1765,11 @@ config TI_ADS1018
          called ti-ads1018.
 
 config TI_ADS1100
-	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
+	tristate "Texas Instruments ADS1100 and similar single channel I2C ADC"
 	depends on I2C
 	help
-	  If you say yes here you get support for Texas Instruments ADS1100 and
-	  ADS1000 ADC chips.
+	  If you say yes here you get support TI ADS1100 and similar single
+	  channel I2C Analog to Digital Converters.
 
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1100.
diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index e3c801381434..ec79a89464fb 100644
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
@@ -40,20 +40,44 @@
 #define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
 
 #define ADS1100_SLEEP_DELAY_MS	2000
+#define ADS1110_INTERNAL_REF_mV 2048
 
 static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
+static const int ads1110_data_rate[] = { 240, 60, 30, 15 };
 static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
 
 /* Timeout based on the minimum sample rate of 8 SPS (7.5s) */
 #define ADS1100_MAX_DRDY_TIMEOUT_US	7500000
 
+struct ads1100_config {
+	const char *name;
+	const int *data_rate;
+	const int data_rate_count;
+	bool has_internal_vref_only;
+};
+
+static const struct ads1100_config ads1100_config = {
+	.name = "ads1100",
+	.data_rate = ads1100_data_rate,
+	.data_rate_count = ARRAY_SIZE(ads1100_data_rate),
+	.has_internal_vref_only = false,
+};
+
+static const struct ads1100_config ads1110_config = {
+	.name = "ads1110",
+	.data_rate = ads1110_data_rate,
+	.data_rate_count = ARRAY_SIZE(ads1110_data_rate),
+	.has_internal_vref_only = true,
+};
+
 struct ads1100_data {
 	struct i2c_client *client;
 	struct regulator *reg_vdd;
 	struct mutex lock;
 	int scale_avail[2 * 4]; /* 4 gain settings */
+	const struct ads1100_config *ads_config;
 	u8 config;
-	bool supports_data_rate; /* Only the ADS1100 can select the rate */
+	bool supports_data_rate;
 };
 
 static const struct iio_chan_spec ads1100_channel = {
@@ -89,6 +113,14 @@ static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
 	return 0;
 };
 
+static int ads1100_get_vref_milivolts(struct ads1100_data *data)
+{
+	if (data->ads_config->has_internal_vref_only)
+		return ADS1110_INTERNAL_REF_mV;
+
+	return regulator_get_voltage(data->reg_vdd) / MILLI;
+}
+
 static int ads1100_data_bits(struct ads1100_data *data)
 {
 	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
@@ -114,6 +146,9 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
 	if (ret < 0) {
 		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
 		return ret;
+	} else if (ret < 2) {
+		dev_err(&data->client->dev, "Short I2C read\n");
+		return -EIO;
 	}
 
 	/* Value is always 16-bit 2's complement */
@@ -184,7 +219,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (ret)
 		return ret;
 
-	microvolts = regulator_get_voltage(data->reg_vdd);
+	microvolts = ads1100_get_vref_milivolts(data) * (MICRO / MILLI);
 	/*
 	 * val2 is in 'micro' units, n = val2 / 1000000
 	 * result must be millivolts, d = microvolts / 1000
@@ -209,9 +244,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 	unsigned int size;
 	int ret;
 
-	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
+	size = data->supports_data_rate ? data->ads_config->data_rate_count : 1;
 	for (i = 0; i < size; i++) {
-		if (ads1100_data_rate[i] != rate)
+		if (data->ads_config->data_rate[i] != rate)
 			continue;
 
 		PM_RUNTIME_ACQUIRE_AUTOSUSPEND(&data->client->dev, pm);
@@ -233,14 +268,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 	return -EINVAL;
 }
 
-static int ads1100_get_vdd_millivolts(struct ads1100_data *data)
-{
-	return regulator_get_voltage(data->reg_vdd) / (MICRO / MILLI);
-}
-
 static void ads1100_calc_scale_avail(struct ads1100_data *data)
 {
-	int millivolts = ads1100_get_vdd_millivolts(data);
+	int millivolts = ads1100_get_vref_milivolts(data);
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
@@ -262,9 +292,9 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*type = IIO_VAL_INT;
-		*vals = ads1100_data_rate;
+		*vals = data->ads_config->data_rate;
 		if (data->supports_data_rate)
-			*length = ARRAY_SIZE(ads1100_data_rate);
+			*length = data->ads_config->data_rate_count;
 		else
 			*length = 1;
 		return IIO_AVAIL_LIST;
@@ -283,6 +313,7 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long mask)
 {
 	int ret;
+	int data_rate_index;
 	struct ads1100_data *data = iio_priv(indio_dev);
 
 	guard(mutex)(&data->lock);
@@ -299,12 +330,12 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* full-scale is the supply voltage in millivolts */
-		*val = ads1100_get_vdd_millivolts(data);
+		*val = ads1100_get_vref_milivolts(data);
 		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
-						   data->config)];
+		data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
+		*val = data->ads_config->data_rate[data_rate_index];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -373,6 +404,7 @@ static int ads1100_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	struct ads1100_data *data;
 	struct device *dev = &client->dev;
+	const struct ads1100_config *model;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -404,6 +436,13 @@ static int ads1100_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	model = i2c_get_match_data(client);
+	if (!model)
+		return dev_err_probe(dev, -EINVAL,
+				     "Can't get device data from firmware\n");
+
+	data->ads_config = (struct ads1100_config *)model;
+
 	ret = ads1100_setup(data);
 	if (ret)
 		return dev_err_probe(dev, ret,
@@ -466,16 +505,18 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
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

