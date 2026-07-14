Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C2433045
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058468; cv=none; b=ZUr+F5yBYqmrof1NEwAyGj4fqLe06NosPWoarJHWw7CV0bxITpWR+groH7/vmveDR1uEGIUtn/P/4lWdvzTazNk9OtmctFHXmcHa/6MNHsSkHtEipwmoTyORirOEc4+toGLCGSd+vvP09FHIBNd0HFl5nfUiZ52dHB+IC3sQgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058468; c=relaxed/simple;
	bh=x5xeEm5V2RUVbJPpiW7WO6S+OyLmpUCyxUEr4Fp4/mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl5y77+cUbY9SpEg7FiRVqCBGaxWFXnHHTiyxm3VLT4ZXLnXmBKFQf/o+OnrQq65StadnuGmyZTmBDjy5zQUa8owVRNtTJbiiLd0eeqCbVC9EVPABpUFuE72dHe6Uxl0xl67jD3KRQBYdUuzIOzsfo4u4NQ9pHshqbhgAegNook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Moft9qN/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Moft9qN/"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b0117dda13so1208159e87.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784058464; x=1784663264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5ekcSFTL4/hgcBZvhEGy/Z9aZabj+fJ0ywhsDg/4Uw=;
        b=Moft9qN/guihsKiXKCcSdZM/eL2KokMUN9bfIRrRfYDi92aULNWF2uPFB3TMjQ+4Tu
         BWtyVKZ1jYSymu2ZQkl4oSYhvjZrlh1tScS9hBkLvFC4dU4ij/h/JgW5/OBLwgReHjUe
         qqaHzmd+b05VJqeUQm27mTeBNK+EvWe7Ka0LDTXx47HgsgpR6U/xdWbkufb6hEcDfaBx
         gkTQS+pNYzu/xh5m0ZFmHoPEy69vX4yMB8Jf9jUsA4yoQlL2Eh5mhy2h4/lva+BCAzgY
         /QXCYtjayBB0tUTx+qzIQnEQyB038apjri8CVbdjbEWLax/GYkLHfdN4tpD7MtGJsKQY
         puHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784058464; x=1784663264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C5ekcSFTL4/hgcBZvhEGy/Z9aZabj+fJ0ywhsDg/4Uw=;
        b=UAkqy4YnWtJCe0ph9kn9H9/0SCP/F2tDju0oHZajQW6v3uDmUZn45mXa3Z18DIxB8z
         MkX6iVLcYBpMV0tGGug3PcwDC2ujsimxQsltEWyNtaLPmygcsAPoThZsAAR3cfy+uT2r
         Ezc3DEAEOwHmFUsxGGXiKZXLEwVUgTFEI+bdQMZM4e5Tk+YvtNBMraS8Ai0DEqWeHXKD
         +TPXJ0Vyq2opBhRekeHEATcb6do4Nh73Xo/OyXiblFsnRgNkteQS032xqHWNRyMTJbKv
         7HEh+RIR57ujz+k+iJcbo0rpTQ0PtCjM3YjZ8GdSszCSAr05emJjLK/TJwU26lIMe8kt
         hVKw==
X-Gm-Message-State: AOJu0YwSKO+AINLy26jIFOa8/VnurNCCavvNWegYVM+vmi1iF+vMqFLr
	ggG+GnOxOgUGuC24R+xKq85UGjYt2q+xYw9Azb2oPN3Wsjxs1Nv+lizj3mBAiYlZ
X-Gm-Gg: AfdE7cm3F6G0IQDvvBr3Zi8nx27hS7fsBqShn7yFq6uRWPFQivyRCOA3lW6h9HneR2z
	NbMkdmGnGuJeUyfzKHerABJMdMnPS50mKfBiQ/1/RENuoifrxpE+WPC2aeTfojUUEP1jGRo1yNV
	5XkEwXEi17D/jExY21j+hoPzyhL8s0SP45WCuXs3HzUTi2SlU+kCJB2bQGQoSMNxpKvuQCJYslS
	Hu3r8WkV74sbK7pRd4egwnChnBZm6XM6o3l8NKutNhJA7PFs4ZMYedrk9UpUMOga/jcdkcWngli
	AZplrBdC1dbFFg6F9W7U2UCV+BetBFYQhBJGc9jRTEp0pWLZn0v4GGpvHB+3WP/0yEI1DNed1Ta
	hRSp6dujf5fue0NxTeudQSH/wDctWhaCQ+0S7NHNMsgbIrgpW88ydrNtlb0/WDReK8NIfzoWACf
	rIJZxKT+RLyJnLinlHUDwfSwMrS4rbvbL/zqgaDwALy30zCFY=
X-Received: by 2002:ac2:508c:0:b0:5b0:e70:c6e8 with SMTP id 2adb3069b0e04-5b0236c0babmr2541636e87.59.1784058463983;
        Tue, 14 Jul 2026 12:47:43 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:822e:374d:22e8:16cf])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca50a8esm3780287e87.28.2026.07.14.12.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:47:42 -0700 (PDT)
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
Subject: [PATCH v7 3/3] iio: adc: ti-ads1100: Add ti-ads1110 support to ti-ads1100 driver
Date: Tue, 14 Jul 2026 21:47:17 +0200
Message-ID: <20260714194717.596193-4-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714194717.596193-1-jakubszczudlo40@gmail.com>
References: <20260714194717.596193-1-jakubszczudlo40@gmail.com>
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
 drivers/iio/adc/ti-ads1100.c | 84 +++++++++++++++++++++++++++---------
 2 files changed, 69 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3755a81c1efd..9de2f4eb72fa 100644
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
+	  * ADS1000 12-Bit, 128 MSPS Analog-to-Digital Converter
+	  * ADS1100 16-Bit, 128 MSPS Analog-to-Digital Converter
+	  * ADS1110 16-Bit, 240 MSPS Analog-to-Digital Converter
 
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1100.
diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index f0a30ae139af..ad9099aaf19c 100644
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
@@ -144,7 +182,8 @@ static int ads1100_new_data_is_ready(struct ads1100_data *data)
 
 static int ads1100_poll_data_ready(struct ads1100_data *data)
 {
-	int data_rate_Hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
+	int data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
+	int data_rate_Hz = data->ads_config->available_data_rate_hz[data_rate_index];
 	/* To be sure we wait 5 times more than data rate */
 	unsigned long wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 5 * data_rate_Hz);
 	int data_ready;
@@ -185,7 +224,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (ret)
 		return ret;
 
-	microvolts = regulator_get_voltage(data->reg_vdd);
+	microvolts = ads1100_get_vref_milivolts(data) * (MICRO / MILLI);
 	/*
 	 * val2 is in 'micro' units, n = val2 / 1000000
 	 * result must be millivolts, d = microvolts / 1000
@@ -208,9 +247,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 	unsigned int size;
 	int ret;
 
-	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
+	size = data->supports_data_rate ? data->ads_config->data_rate_count : 1;
 	for (i = 0; i < size; i++) {
-		if (ads1100_data_rate[i] == rate)
+		if (data->ads_config->available_data_rate_hz[i] == rate)
 			break;
 	}
 
@@ -230,14 +269,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
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
+	int millivolts = ads1100_get_vref_milivolts(data);
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
@@ -259,9 +293,9 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
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
@@ -280,6 +314,7 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long mask)
 {
 	int ret;
+	int data_rate_index;
 	struct ads1100_data *data = iio_priv(indio_dev);
 
 	guard(mutex)(&data->lock);
@@ -296,12 +331,12 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
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
@@ -401,6 +436,11 @@ static int ads1100_probe(struct i2c_client *client)
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
@@ -463,16 +503,18 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
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

