Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF63806C0
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314269; cv=none; b=MaXe3h1mSLH2Mu4GIsFK6qYrMlFus6ZJJBuLfBktN3dT95By7R3RCFvoVJ6hbE8BujDfQQ0r3IkSLGMfC+geyligDsRcAGNk8kAevgh/BehyJTJFlFq8aCPuRXli6Q/Tboxx2qDQUfSr5DNymRhyuiLBAvRGXLBaE0btUlQsf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314269; c=relaxed/simple;
	bh=fxVLOlAEEZbasRlArOnsqOxmKKwvvuCbKQBI3wtqDEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK8IJ+Sj/QHXzvCUm2Qvfprnkhm6ccu63uKsZgiSnNalZ9xtT2CZvZtF9ZPtK1QWi5Y6AX6k7LK1FYMD1/QJXHs1EuNeQvVMRuoHO+K+QUZ5WZx7MztyGkdV7Kg0c4WT5jxqEx0wCoBDv0SRjoAPe9Ospdw5h0xZuFSdgbjZ3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlPXlQfc; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlPXlQfc"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c8dbf4ef0so73565041fa.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784314265; x=1784919065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wbe43CsBKlhwl8/JrNzWyfSM3Jsa2BsdWg38CIyjaB0=;
        b=qlPXlQfccrnL2jrsX+qfgkXSi1JbplodHaqm3rc4kwNyzrmGehXUyXS1OsgB6qWx02
         RFz8qim9hN/8uasatfsT4IX3tc3zc1swxPrQ5WstVBEL0GH22wZq3TtyatdEUJYkTh7B
         FJqDUE5lzdGV0pV4dl/+dK7QLzITRStmLGhIj1RRR8Q/z7ak8QzGq4CFF5Wegjyn93r9
         LYRf5LgPNqEO7UQYkSA+c9l8Ai1XEbOMog5ofFsstPJapuKKeQDGlDsSWO+gcziYPDNE
         ySGTDKrPKDp92nHrU6GCaQkJnJWEEP+J6EKGdaTMRKzsWblWNR8Lgof9r9N/BPVB/NiV
         YqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784314265; x=1784919065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wbe43CsBKlhwl8/JrNzWyfSM3Jsa2BsdWg38CIyjaB0=;
        b=IN+Lt+1fl/lSdZaVW079YBVZvUoqpTcRjbC4tghAeHA/nrZuEY5A1SD+n2TYpie21p
         SoYlKrnYkcOJTCmGSYGf4ynCQ/l7bQIvaJJnKGSFu67lDTay0MyzxLH5f8jCzf/FGgsj
         KOLaq+mZTPR9IJ+BAfx2zT3Kd2RIpBrxrmuYtHAV4+TKTdhzZSGkOph4goenyPA35vFC
         qt8w+2u908GgH5/1x69hb60TjYNZQF4mdNdZv9wtFv6fpbQ5CHYEHY+VXUUXaGTulle8
         oEELaQxYlC0sH3jBTJ3Mxv4TXSDJD0WQB8D/FQ5p5BWIOdU1M4Ht2+5xaLQ2PhvwEwEm
         lJGw==
X-Gm-Message-State: AOJu0YyOXx8O+e8Y61fWKpYzEBRv0qlVNurMO4dh0wsHU77Aj5cAYP8t
	xYDVLiPXbrP/Mesu3IFONLR8qmotpVO82x7+u4akjk5IFhaUzYOypkI0bYodOxzw
X-Gm-Gg: AfdE7clp0UBsW2lkYfSdJjn7LDUZWGVQ2j7B0NZd6LdpMmH15WlAvYC4REkM2RjQ118
	LbXyrPMEcUdI+iiN2bceOGcWdep96PGPj24mnpSsbnS+qdr/hsNtgMjp2D+R2MfGCmPKAa0EDFp
	p6yRyofrF6DrXnSe7Woae7KHaQ6Eoac/6dwtdmBFoU8eW1L4+kDqQFgmh10+vyFGbGstOpSxA1w
	MUCmZGDmqegIpsZ1m9wtlGUeHsquqrXuxqB3iOOfT7yElK9WR16fBN5Fk+17femrRJpehKUmNMm
	IOYM98V9wyR1WRy18bks7+aVZ2Ae5YWfoKn9HqNj/oopzPSb465jrImSV/LI3eZzeWs/z7j0NJa
	FZMCNo+y/SoE3DJUHZafGnJ+dyNv7fb716/Ok668idv4Xv6g3m3PtqXl9LT4+nIgYM+ys91lbnp
	ZhN/jjWALdMXqvD+PFvqzyU+NPOea4XFPoofV3
X-Received: by 2002:a2e:be83:0:b0:39c:9955:9e0c with SMTP id 38308e7fff4ca-39eb274e2bfmr9366311fa.6.1784314265496;
        Fri, 17 Jul 2026 11:51:05 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:9d0c:8f55:3d10:318d])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39eb4fd4ba2sm3431721fa.24.2026.07.17.11.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:51:03 -0700 (PDT)
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
Subject: [PATCH v8 3/3] iio: adc: ti-ads1100: Add ti-ads1110 support to  ti-ads1100 driver
Date: Fri, 17 Jul 2026 20:50:33 +0200
Message-ID: <20260717185033.246580-4-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717185033.246580-1-jakubszczudlo40@gmail.com>
References: <20260717185033.246580-1-jakubszczudlo40@gmail.com>
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
 drivers/iio/adc/ti-ads1100.c | 93 ++++++++++++++++++++++++++----------
 2 files changed, 74 insertions(+), 28 deletions(-)

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
index 363f790ca5d5..19533667e6cd 100644
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
@@ -139,14 +177,16 @@ static int ads1100_new_data_is_ready(struct ads1100_data *data)
 		return ret;
 	}
 
-	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]) ? 0 : 1;
+	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
 }
 
 static int ads1100_poll_data_ready(struct ads1100_data *data)
 {
-	int data_rate_Hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
+	int data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
+	int data_rate_Hz = data->chip_info->available_data_rate_hz[data_rate_index];
 	/* To be sure we wait 5 times more than data rate */
-	unsigned long wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 2 * data_rate_Hz);
+	unsigned long period_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, data_rate_Hz);
+	unsigned long wait_time_us = 5UL * period_us;
 	int data_ready;
 	u8 buffer[3];
 	int ret;
@@ -159,7 +199,7 @@ static int ads1100_poll_data_ready(struct ads1100_data *data)
 	}
 
 	ret = readx_poll_timeout(ads1100_new_data_is_ready, data,
-				 data_ready, data_ready != 0,
+				 data_ready, data_ready == 0,
 				 wait_time_us, ADS1100_MAX_DRDY_TIMEOUT_US);
 	if (data_ready < 0)
 		return data_ready;
@@ -185,7 +225,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (ret)
 		return ret;
 
-	microvolts = regulator_get_voltage(data->reg_vdd);
+	microvolts = ads1100_get_vref_millivolts(data) * (MICRO / MILLI);
 	/*
 	 * val2 is in 'micro' units, n = val2 / 1000000
 	 * result must be millivolts, d = microvolts / 1000
@@ -208,9 +248,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 	unsigned int size;
 	int ret;
 
-	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
+	size = data->supports_data_rate ? data->chip_info->data_rate_count : 1;
 	for (i = 0; i < size; i++) {
-		if (ads1100_data_rate[i] == rate)
+		if (data->chip_info->available_data_rate_hz[i] == rate)
 			break;
 	}
 
@@ -230,14 +270,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
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
@@ -259,9 +294,9 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
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
@@ -281,6 +316,7 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct ads1100_data *data = iio_priv(indio_dev);
+	int data_rate_index;
 
 	guard(mutex)(&data->lock);
 	switch (mask) {
@@ -296,12 +332,12 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
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
@@ -381,7 +417,12 @@ static int ads1100_probe(struct i2c_client *client)
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
@@ -463,16 +504,18 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
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

