Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15A306B11
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783795479; cv=none; b=Q0ERvIzGRzNW02Z/nMerhnTCHy87t/r/ssw9CO8mJE93aSYBrNkJSoZ++wkVwyK3KEbGZMgQgTtacLswUIMkC72+5TawMMEakmN3lJQBtqhRpsa9gwxbjgN/Ac0vR1HgH7VF4sWRbmZag1zUVwVVzhIxEWju4t7dcPYCQB9uxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783795479; c=relaxed/simple;
	bh=rVnOU6mzWAlVKAHbWIlIHyp/Ys6ngSFfeoucVzE+Hhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7pGSqm9dnxtKfHYHOb52fImIyU71npsqjlH9O13CPP98wb8eEGwVPqD8TYhOWgpfSrBWS22rHbdU0TTqdYU78S/QFeFtRZECkHO5oOX/w6ri49PbVKi+PSKrqynTpcFUiRASwe4ZqPID7TZfz3JxpZPyz05kozQ3XK2LXjIB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFIwghkI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFIwghkI"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47122683cf3so1068137f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 11:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783795476; x=1784400276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gNijW8QFAppCEeO1nD09R5T+lcFHeKLLz7g1+wjLN8I=;
        b=IFIwghkI6F2vhRf13GaRs4uvZhfhhk4OdwLQhhSAWpqsXc9uwaDMoCgpJ8SKul5J9S
         Af6hj+k/iOcsUkC+4MAAXk4sj2RTjbNgby6rQDekGV+iKfW14MjFdvQZY0G3FnqdxGiQ
         wdDVfzBQJGS6RpmbhZbv4p9CYVvPJGuo5DObRtx7+IObnKJwbzg3VArFtEt0wc+CxQbm
         d1jmgxT0TcSKhLabMU7rFKWehW3ApUM1tjyvqCFRkScsbX3KCQC9cIndonIg3cdzCHuP
         uqY2FQ4GO0W1D8V9g89qkNgUiRa1EvCsVbr1SYV0PO034sUikZKp2+m7t7HPhCFz7S8q
         7A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783795476; x=1784400276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gNijW8QFAppCEeO1nD09R5T+lcFHeKLLz7g1+wjLN8I=;
        b=h5knRgCo7u16RgtdXxKC7ABleAJGxxJj2da/kd5cvjK0WllDIfPP5C24mSfSbzlJdQ
         pyDSMM/2uGcuRLapRwY3ma6jHfLR+DOQCyGId8JLPBcbc7FhYmsgtBb68e4IIIVaTY1x
         Io34Ue2MEeiu+QXUpBfx5cwYHaIJ6LmboLkdos6b6R5Cafxgef37KAMG+/T+vQLofgYT
         NJRhHH2h7gD6z4KwYQbkj+QQ+kTnLsna19/MYAziXi4IZF+ehVh3BjueMYAvDWzjpECy
         0Lw8vJS+dVfjEdE09k9qy6EzPBeqqsZ/nam3BlsqcJjCtBuY6dP5yokI4+M5buljnRXl
         x35w==
X-Gm-Message-State: AOJu0YykjxCFACAE3x88EOwtwuX9ZgWwlTbFRQF2NS5jWpnfDkOF65Ya
	svDaaPyXCAFB9/ZeqD8/JacRMcV/SdxTSdHDRFsEPo1mm0qhKdRBnZ6mXZpsaERx
X-Gm-Gg: AfdE7cmoENSH75qLgc8bZKfGwM7Be5dY4Lzn7vHihWmYoZ4urshjfP0HQFeO9bSgg70
	dzQ1vqH9QpgYdpBg6L/JrpBUdIKWqY6Wuom++B0zL+r5zUKiWCJRRZj7nIpEBon01SSjnZX59ck
	TBdEicivnHqPXshBzDgozOECpM2elQTYKFupxuWMJYa9+O11TPDTmVDUQuuxwXzUZrlJGTnZjJd
	qJStPk5MIkpNGFEVDc6dlWHs+lZIynnFNegrVlCIhV6oSmTPcZnoqA1ZE/4gu8wytgDtfWiTxQ+
	Psq/ok2lPOcqTCt7dMcEfZ+N3ggTwxu0afaTOazhGQXxu9hLmTp4kEob8i36axO8SzW/BeN0IiR
	+W0omgzxfe7/TZSWXS3niw1fzpaWj8tWmTlRwMJPkXbUEjoZW8Bo/7Zey6qu251imzs/YSg/pjV
	vLmXWNOTtzG2fB6iMrrg3yoCRZ8ZGYRN3ni3sGRJffLFjwaFI=
X-Received: by 2002:a05:6000:184d:b0:46f:7d90:8121 with SMTP id ffacd0b85a97d-47f2dcbd321mr3726648f8f.14.1783795476056;
        Sat, 11 Jul 2026 11:44:36 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:e6c9:27be:161c:632d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm70825745f8f.11.2026.07.11.11.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 11:44:35 -0700 (PDT)
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
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	robh@kernel.org,
	sakari.ailus@linux.intel.com,
	wens@kernel.org
Subject: [PATCH v6 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100 driver
Date: Sat, 11 Jul 2026 20:44:14 +0200
Message-ID: <20260711184414.1013686-4-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
References: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
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
index 6ad80d42d390..06892ebc593d 100644
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
@@ -144,7 +182,8 @@ static bool ads1100_new_data_not_ready(struct ads1100_data *data)
 
 static int ads1100_poll_data_ready(struct ads1100_data *data)
 {
-	int data_rate_Hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
+	int data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
+	int data_rate_Hz = data->ads_config->available_data_rate_hz[data_rate_index];
 	/* To be sure we wait 5 times more than data rate */
 	unsigned long wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 5 * data_rate_Hz);
 	bool data_ready;
@@ -181,7 +220,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (ret)
 		return ret;
 
-	microvolts = regulator_get_voltage(data->reg_vdd);
+	microvolts = ads1100_get_vref_milivolts(data) * (MICRO / MILLI);
 	/*
 	 * val2 is in 'micro' units, n = val2 / 1000000
 	 * result must be millivolts, d = microvolts / 1000
@@ -204,9 +243,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 	unsigned int size;
 	int ret;
 
-	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
+	size = data->supports_data_rate ? data->ads_config->data_rate_count : 1;
 	for (i = 0; i < size; i++) {
-		if (ads1100_data_rate[i] == rate)
+		if (data->ads_config->available_data_rate_hz[i] == rate)
 			break;
 	}
 
@@ -226,14 +265,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
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
@@ -255,9 +289,9 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
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
@@ -276,6 +310,7 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long mask)
 {
 	int ret;
+	int data_rate_index;
 	struct ads1100_data *data = iio_priv(indio_dev);
 
 	guard(mutex)(&data->lock);
@@ -292,12 +327,12 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
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
@@ -397,6 +432,11 @@ static int ads1100_probe(struct i2c_client *client)
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
@@ -459,16 +499,18 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
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

