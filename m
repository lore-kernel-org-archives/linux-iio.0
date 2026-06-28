Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452336604B
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782675858; cv=none; b=CIJ5Pz6bLHorprCaHSZ/EmASKJ9aCgjjySfmF1qxv+mKnasMVFtS9zNwOAjPIu1pqo5TZ0cZpVeGz2mPlkCKjW6++nFALrUITUHo6kIc5FVgUFKPYdHxlItEkU1nQ6ETPp9Lj8AXm7NJ/X5lUhjbLHDzXdZQD9wyRUcQbxkiaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782675858; c=relaxed/simple;
	bh=LObyv+0MPi2fW2rL7bscdjsjljB64GljoAZx1wVgIlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1dlRzq3myMi5Igtx6AoWtKtgSMstOgwZcJJii1M7maR8CqGTKnyYLUEVmbE2y16mwmTbXug0F8NIIEWhhoG7MLoRRmQMr+zmNVjwy+saF7Do2i7ecOVWMf2yHdkNoEMuuN+U9jps7Nkx4kOCTx4k8rk3MPl/MDlyr19dCOVpPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grVj35R9; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grVj35R9"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39aec83e14aso9464651fa.2
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782675855; x=1783280655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiRM/gUyFVEnWa5sPUNoJb4fGTnb5oyNPDDOH+drofQ=;
        b=grVj35R9O3ETVG3GBv+yWGME/Pdd508KoV3MHVgICpQX9mJb2wtjuhVDjW7ptZFyU5
         LvCtsKWxEbCXDoYZQwN6EfjulJUxfNnnB4M+4xCUuJTaybLGBH1L/tD2E5VLe2mVsHLe
         HQ3rrCgBlV3OXN8XLMfmo2ziQGBftLkvrgD6KzmyPXiSuxQDcSiUOFquBS2hxhxshQlu
         Gwhu7U2XX8T6sGOvaw/ij4HnZ55+1yM9yAnjcVlDbHbfEkhMcULSPE8z+1wCWqm8+95Z
         MDKIVU+4qsmddq7HVFL144X3dmCPHxvlAd0XmwXWyXZXjxEpwHYF3YStQQtSbQNgImnz
         Dy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782675855; x=1783280655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iiRM/gUyFVEnWa5sPUNoJb4fGTnb5oyNPDDOH+drofQ=;
        b=mxnqf4Vg5BIt2WonCc8N4n2PGIimG/XygxWBvJd6YJUcehBFks96N4sLE7Y+Z3P00G
         +ASxKBV66WCIc8xNVzE/iW4aE2q7woSPMAoYYEqQ2tcsaMx0cV2VYrzIIuWN1RQccSYw
         IVoyjGKQzrWqOay2NKe2TgSmzUXNrdAQs0f8ItzRKC1Hj5yCE+lV6hJX+13OXvwSeotB
         0ohBy8Ej7e2mcqHnqsknRo51Clpy6Ovse0JNogoZ0zpvDncIZq3VuB0mv3bB4tqKsUcu
         iN8dj26+iZi2jG3B9KTiKjLf7720S4bP0HATan00tKjv36OcRUA4peoub7o8pOgzY/LM
         +V0A==
X-Gm-Message-State: AOJu0YyFO7aFg0D/6VWKjw4xN9j/RYdV2aDM2Gj6CkrTWEOVXQ+ZHo6J
	Q41Px9PMpwbrEPWgOgwoljrwJscgl0ymgTf7wKRT7LLHtW9fBoIpR5aJDHlvYpN+
X-Gm-Gg: AfdE7ckqqzDGOUL7+FffJHLlLefe5EpAociPZeLpFtwixGu2dW4zzRS8Y30wnZ5d/cZ
	KcMh/cwhARC8I11I00A7RaseCGVs7aCwIiLVy+R5G8P/HuDPyZft+1XbmSOM0T0+UtHwvD8XvRg
	I2H9Gbv2r1nwOYdXM5CRdfOT8GXk1FhYs2WQ6wxhYvwKGpui0e6P+uRsyvXa/Spzu6zZxTUva18
	fXdrVHREYA128mCbugvx8SJB+23SHbmZQheFdpJqGdllbTVz746cQ0zOOze/DyM8wfHqKUWFmvA
	sfIQy2x40K+jH9d8zFaCO10DxUFKHL+H8oz+WT/wqbatEKkD9tADx/FYRMKOiDaKztC6KkhJ80V
	XD29kGulxgq+d8rfMx+5HQqZD5MiaDGbGXVAbXkfa70HpfDPL2/TOvStO3o9UeoeHB3MPE2lPWh
	HVBoqUyOdeJJI2rnV2ak0+P7gqCW77
X-Received: by 2002:a05:6512:3e17:b0:5ae:b232:ec03 with SMTP id 2adb3069b0e04-5aeb232edb5mr1030090e87.42.1782675854588;
        Sun, 28 Jun 2026 12:44:14 -0700 (PDT)
Received: from Nitro5-JS.kielce.vectranet.pl ([2a02:2a40:27ec:2900::3ab6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69551002sm5221688e87.24.2026.06.28.12.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 12:44:12 -0700 (PDT)
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
Subject: [PATCH v5 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100 driver
Date: Sun, 28 Jun 2026 21:43:41 +0200
Message-ID: <20260628194341.66752-4-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628194341.66752-1-jakubszczudlo40@gmail.com>
References: <20260628194341.66752-1-jakubszczudlo40@gmail.com>
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
 drivers/iio/adc/ti-ads1100.c | 79 +++++++++++++++++++++++++++---------
 2 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1c663c98c6c9..2459ff2af105 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1765,11 +1765,14 @@ config TI_ADS1018
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
+	  * ADS1000 12-Bit, 128 MSPS Analog-to-Digital Converter
+	  * ADS1100 16-Bit, 128 MSPS Analog-to-Digital Converter
+	  * ADS1110 16-Bit, 240 MSPS Analog-to-Digital Converter
 
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1100.
diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 71b31adeba3c..c937e00e0a40 100644
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
+	const struct ads1100_config *ads_config;
 	u8 config;
-	bool supports_data_rate; /* Only the ADS1100 can select the rate */
+	bool supports_data_rate;
 };
 
 static const struct iio_chan_spec ads1100_channel = {
@@ -90,6 +114,20 @@ static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
 	return 0;
 };
 
+static int ads1100_get_vref_milivolts(struct ads1100_data *data)
+{
+	int voltage_uV;
+
+	if (data->ads_config->has_internal_vref_only)
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
@@ -181,7 +219,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (ret)
 		return ret;
 
-	microvolts = regulator_get_voltage(data->reg_vdd);
+	microvolts = ads1100_get_vref_milivolts(data) * (MICRO / MILLI);
 	/*
 	 * val2 is in 'micro' units, n = val2 / 1000000
 	 * result must be millivolts, d = microvolts / 1000
@@ -204,7 +242,7 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 	unsigned int size;
 	int ret;
 
-	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
+	size = data->supports_data_rate ? data->ads_config->data_rate_count : 1;
 	for (i = 0; i < size; i++) {
 		if (i == size)
 			return -EINVAL;
@@ -225,14 +263,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
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
@@ -254,9 +287,9 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*type = IIO_VAL_INT;
-		*vals = ads1100_data_rate;
+		*vals = data->ads_config->available_data_rate_hz;
 		if (data->supports_data_rate)
-			*length = ARRAY_SIZE(ads1100_data_rate);
+			*length = data->ads_config->data_rate_count;
 		else
 			*length = 1;
 		return IIO_AVAIL_LIST;
@@ -275,6 +308,7 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long mask)
 {
 	int ret;
+	int data_rate_index;
 	struct ads1100_data *data = iio_priv(indio_dev);
 
 	guard(mutex)(&data->lock);
@@ -291,12 +325,12 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
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
+		*val = data->ads_config->available_data_rate_hz[data_rate_index];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -396,6 +430,11 @@ static int ads1100_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	data->ads_config = i2c_get_match_data(client);
+	if (!data->ads_config)
+		return dev_err_probe(dev, -EINVAL,
+				     "Can't get device data from firmware\n");
+
 	ret = ads1100_setup(data);
 	if (ret)
 		return dev_err_probe(dev, ret,
@@ -458,16 +497,18 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
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

