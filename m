Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6CE1F91F6
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377839; cv=none; b=e8UrN5/kYAFWjwVHAS6ayJBoeMU1oSYkHQ6ZsyyYCW2AfFvoeLBkNgXazSUNZpJbU48cU4Iq2kCqvQZArsNCBqGxcHdFh6jhfqiXX1Q00GQllKuQZAHhAbOygLMqOZMz5qy/f5QCwLciB/QzCwHm1lzlE3rz/1y24gnVNyZXu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377839; c=relaxed/simple;
	bh=/ATcjgQBg4PKaQAKJoJ+QyJHoBhwM3d25iuyZbX1jKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOc9Pv2m73WzOdixG6PiSAIHRVb3QeDFMYfnYQ34ohoOzMpA2MGeofOrN/ZLHsdcZqjheNnNeY4ed6or8pH58ojyFKWhCTRPx3tRwDCG9Kva8xZRRog3C6ZdHyWADfNH87JUk68Va/9d1AZiuRJyjmu+E+BCwx+z4Pr1b3SojqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUyjg8N9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUyjg8N9"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec423a5265so373097166b.1
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 12:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781377837; x=1781982637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI/dslK6AvANzEH96zaO8Q+P15bLXwMMeUyI+PCap/M=;
        b=UUyjg8N9k9KaovYFY3vaBVbF4e3QD1ibqFkfaKYvpLHhDtm84JQLdWGWI5XxzoYXo8
         m7NL5+dyYQOHsqCI7XUBPevWPtJRmcpJDnqQ1byNMkv2cqYVj7x+ZtwepWhThXOfwmLs
         AS0dndpaOTPDoKsJIA23Pw7WEeUkNyUycqy2vUbknhdCN0Q7DeXQoEdL83t8rTbmkCJo
         xiOax2fnrsZxFZp9Md033AGIhqx6OuW0Yj1nS7H48/XBD1PXhax1OCf4PdCuiFy8Dv5I
         k0u7YNJM3ZjC4rx0eey36NgZ2CzsCGI+gEOURVntCnoNU8d8iKfqDg/sHbrHW5ZHhWoK
         Maig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781377837; x=1781982637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YI/dslK6AvANzEH96zaO8Q+P15bLXwMMeUyI+PCap/M=;
        b=fCZOd0QmFq+ShMoLb3Nk0McPcXzCIPxQ5UVX9MDXbSw3BAaeH+FGN1SeB6mDyGLYdG
         B/YfGNFDfwUOsVKY7WQIqHlYA7osd+BnMai2K9lXAxtP3tBeD9JOyO0Hq5OiAdQ2dtbO
         rE+uR2gZBJFiooEZ8Itz42nUEqhhgUoljI4vJ01I1PknZgteq2qney4x9PcLrktATDce
         ncsh5cxmKJIeX/WNkLdAnyeOQ3BkzwO9m670M3nbnctKArflOXnD2rGIOF7JYhhkXXBW
         RqWwrQmrA/OKwITUmRW3gVyXl+tU4UjCVjtVI90KuJekhfYwdDDRV8N3fZwXLwINiICZ
         0Cog==
X-Gm-Message-State: AOJu0YxA6dOX+33z4F1gIlDu9RXgc4etOa9xqZPnTVu+tK2GvA/jRmKO
	LA0bUXzpeiTYACs8F2crQV+sZD15uh66YTnNoMSjmAMOYy/SyMXVEHzb9iSigkEP
X-Gm-Gg: Acq92OFc46SysgxjHjQxB26Gewl+pvZQjp9NYXZ9lNqD8ERkWZYVSrm7+Jq/9UHTYBq
	JAo/kqNYPa/E3Oc9Nha1/fqTrun7gFC628VomkFNRuatJJeOT+9qI3e6YphkhfKJaIC6oE2YOPT
	+kAqmPrk9mKttYOmNJAxG8TUeZw2jPXOJQh+9wXJQ44xGyUT/lLVsMaIpMLjUwjjJcFCKK2PDW7
	zvo2EFrVX/v8ZmoLHHoRqWCCnfNaVN5HI0rd1maAC0njLrIGBTCgPRKByeZTqppcKjJnQ9hcfMV
	JJKsR3nn6ORzbS49gmenPNT8iXwr67wR8btbaYaAomkzc8Ktw4UdiMQZ1K+tOY/edwt9UajoXKd
	EDgJeZPtudzzeV7Tyr7KyY4ftVyr3xfdhHuoKOzAs143Pubp6ZACdUPTcYgDdgWH4ermgM7mu3H
	25Uck2bjibfwe4Ptr3cv5eZxhjzna8k9qeseJW/s1dC+ehNu5yvtxpREaM5g==
X-Received: by 2002:a17:907:7285:b0:bee:aed6:9d50 with SMTP id a640c23a62f3a-bfe2bfa08a5mr337807066b.48.1781377836530;
        Sat, 13 Jun 2026 12:10:36 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:9790:7740:8855:4d8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b2276fsm237193366b.17.2026.06.13.12.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 12:10:35 -0700 (PDT)
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
	krzk+dt@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	robh@kernel.org,
	sakari.ailus@linux.intel.com,
	wens@kernel.org,
	joshua.crofts1@gmail.com,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH v3 2/3] iio: adc: Add ti-ads1110 support to ti-ads1100 driver
Date: Sat, 13 Jun 2026 21:09:56 +0200
Message-ID: <20260613190957.654798-3-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260613190957.654798-1-jakubszczudlo40@gmail.com>
References: <20260613190957.654798-1-jakubszczudlo40@gmail.com>
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
 drivers/iio/adc/ti-ads1100.c | 83 +++++++++++++++++++++++++++---------
 2 files changed, 65 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..54a0149a3838 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1747,11 +1747,11 @@ config TI_ADS1018
          called ti-ads1018.
 
 config TI_ADS1100
-	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
+	tristate "Texas Instruments ADS1100 and similar single channel I2C ADC"
 	depends on I2C
 	help
-	  If you say yes here you get support for Texas Instruments ADS1100 and
-	  ADS1000 ADC chips.
+	  If you say yes here you get support TI ADS1100 and similar single
+	  channel I2C Analog to Digital Converters
 
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1100.
diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index aa8946063c7d..76de2466dc53 100644
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
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/iopoll.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/pm_runtime.h>
@@ -39,17 +40,41 @@
 #define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
 
 #define ADS1100_SLEEP_DELAY_MS	2000
+#define ADS1110_REFERENCE_VOLTAGE_MILIVOLTS 2048
+
+/* Timeout based on the minimum sample rate of 8 SPS (7500000us) */
+#define ADS1100_MAX_DRDY_TIMEOUT	7500000
 
 static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
+static const int ads1110_data_rate[] = { 240, 60, 30, 15 };
 static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
 
+struct ads1100_config {
+	const char *name;
+	const int *data_rate;
+	bool has_reference_voltage;
+};
+
+static const struct ads1100_config ads1100_config = {
+	.name = "ads1100",
+	.data_rate = ads1100_data_rate,
+	.has_reference_voltage = false,
+};
+
+static const struct ads1100_config ads1110_config = {
+	.name = "ads1110",
+	.data_rate = ads1110_data_rate,
+	.has_reference_voltage = true,
+};
+
 struct ads1100_data {
 	struct i2c_client *client;
 	struct regulator *reg_vdd;
 	struct mutex lock;
 	int scale_avail[2 * 4]; /* 4 gain settings */
+	struct ads1100_config *ads_config;
 	u8 config;
-	bool supports_data_rate; /* Only the ADS1100 can select the rate */
+	bool supports_data_rate; /* Only the ADS1100/ADS1110 can select the rate */
 };
 
 static const struct iio_chan_spec ads1100_channel = {
@@ -85,6 +110,19 @@ static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
 	return 0;
 };
 
+static int ads1100_get_voltage_milivolts(struct ads1100_data *data)
+{
+	if (data->ads_config->has_reference_voltage)
+		return ADS1110_REFERENCE_VOLTAGE_MILIVOLTS;
+	else
+		return regulator_get_voltage(data->reg_vdd) / MILLI;
+}
+
+static int ads1100_get_voltage_microvolts(struct ads1100_data *data)
+{
+	return ads1100_get_voltage_milivolts(data) * MICRO / MILLI;
+}
+
 static int ads1100_data_bits(struct ads1100_data *data)
 {
 	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
@@ -107,9 +145,9 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
 
 	pm_runtime_put_autosuspend(&data->client->dev);
 
-	if (ret < 0) {
+	if (ret < 2) {
 		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
-		return ret;
+		return -EIO;
 	}
 
 	/* Value is always 16-bit 2's complement */
@@ -135,7 +173,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (!val2)
 		return -EINVAL;
 
-	microvolts = regulator_get_voltage(data->reg_vdd);
+	microvolts = ads1100_get_voltage_microvolts(data);
 	/*
 	 * val2 is in 'micro' units, n = val2 / 1000000
 	 * result must be millivolts, d = microvolts / 1000
@@ -159,22 +197,17 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 
 	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
 	for (i = 0; i < size; i++) {
-		if (ads1100_data_rate[i] == rate)
+		if (data->ads_config->data_rate[i] == rate)
 			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
-						       FIELD_PREP(ADS1100_DR_MASK, i));
+					FIELD_PREP(ADS1100_DR_MASK, i));
 	}
 
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
+	int millivolts = ads1100_get_voltage_milivolts(data);
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
@@ -196,7 +229,7 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*type = IIO_VAL_INT;
-		*vals = ads1100_data_rate;
+		*vals = data->ads_config->data_rate;
 		if (data->supports_data_rate)
 			*length = ARRAY_SIZE(ads1100_data_rate);
 		else
@@ -233,12 +266,11 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* full-scale is the supply voltage in millivolts */
-		*val = ads1100_get_vdd_millivolts(data);
+		*val = ads1100_get_voltage_milivolts(data);
 		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
-						   data->config)];
+		*val = data->ads_config->data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -307,6 +339,7 @@ static int ads1100_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	struct ads1100_data *data;
 	struct device *dev = &client->dev;
+	const struct ads1100_config *model;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -338,6 +371,12 @@ static int ads1100_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	model = device_get_match_data(dev);
+	if (!model)
+		return dev_err_probe(dev, -EINVAL,
+				     "Can't get device data from firmware\n");
+
+	data->ads_config = (struct ads1100_config *)model;
 	ret = ads1100_setup(data);
 	if (ret)
 		return dev_err_probe(dev, ret,
@@ -400,16 +439,18 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
 				 NULL);
 
 static const struct i2c_device_id ads1100_id[] = {
-	{ "ads1100" },
-	{ "ads1000" },
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

