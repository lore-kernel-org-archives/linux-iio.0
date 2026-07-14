Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A143A7F9
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058951; cv=none; b=LoYs+xaJQiRR4Io3H8OwjW6jR/L16LSHue3ysvp9qQ8QBjRfJSSd5lsqPiBvDF72BnR9Y3gCJkfInSGBPazWRyRypUF6C70Z7K2SpBjJbQNiF5M11LcCs8yAjvSATf0p1/RRRauZUbbvAyZ1ypKuQ4NZFN29PoLEckcTCTgIfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058951; c=relaxed/simple;
	bh=cii1G3ic+VcA6JAeMUIU3jgPC6eG1P3jczjEU1l42Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrdQYedFdkyQsW628AQJJwoiE+RHcXbO8zk2KK1NlXGCl28WeSAB7sulwNbV8LbbGAA5Rin/JG9aXiMJWW408Ric3kB/go8rSAh5MAw4qdI/BNtYe2vo2n2CxppYinQ8AK5Yta2pAqqm6vNS6cQnWXsb6P02Cx4CeczjfqRB01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtksgXja; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtksgXja"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so1331422e87.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784058948; x=1784663748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tr5NsWPWcjaYE0XW3mtUvZHR+Y1ij5DruwTL98K42t4=;
        b=jtksgXjawBUpdNcS8gQ/p2Dkh6TsrGYKqtyMoNQ/DoOyeEKc+sU7ydZhdiBeseY1Aj
         wcQBmDuWfK1fH6PX6FhgPiracvkG4XAndO31CspHQ1ZMl9Q0CkbD1zMco1Abx2fAVisG
         r81PBOWfZYxmSp4uYAktw/yA7fhsu4p4B8Hhs+bjEqO2ZlEFG7le+l6BMfTSvcKGkZ95
         jnkmWJPA8/N2CEItBnh8VkIBH+5dntS5laT2AQtGajRR0UfLz5fVPeLEZv4hAkQlQ2Ri
         ImMmy+i8VhU7RXTuFffg+WnqcpIyPxtl7iQVptB5Z2AwDoiYmW36tZcFUjPFl+eYFiA1
         0nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784058948; x=1784663748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tr5NsWPWcjaYE0XW3mtUvZHR+Y1ij5DruwTL98K42t4=;
        b=apbMtftNDbqzFWjqkF9qRayFK+UDiUYyRg1uTZMgmMG5+zciVole3XPYegVouhK0vZ
         hP87thAZPB4SoIve2frrTwzZeP1EdjoKkyunNzrYH+eJ0hgOrqE8UhXXdN4Nh/JkHXjp
         itu2pNXRh6EkbacUgm50ZAjA1qDJxHr0dVgGTlGawJKaYbo777yKAmrYu/cVbOj7utPg
         VZs+goYId8ceD9QRhCpTvT62Bo5dm2ZEfqycztPR2jMtLP3x8x3GZe2pJSBcXpl5tPdV
         1kUwewZk69X8wm6q0j6/CJXJmHfKNZCLPbMfVvypMN3zogsr2WchWt+hSM6x4nqvVGVP
         HRMQ==
X-Gm-Message-State: AOJu0YyeT1xQq28eIgjxEFlEvJBhlfkq8vFOToSetflIwBpZ+px39rpp
	mDCyV8iust5TGsGns0hXyCDzxV9GMFyIdUuqsfq8HRsv6bimzROrqS7Cg0rENuo0
X-Gm-Gg: AfdE7ck9FXgBXca0ThT4kJcqWWuKy4HWga5f4WC+iJ4g7mG/F5k00wYh4Q0t0wPPNPP
	GyWiENn71ryN2Hb6YioX46fnYqlvsBFOsrSzomobejiTCOrmTW2DvZj+SEjObyX36zmqat+wjyq
	JGrk08VTw6LzbVNKUHebj57wC+kKNDpSKCSMEqjMvU2iAuxPv9qXIrUF2+aC1h2vqRi3ta0bTLR
	PUrfFH5CjNAY+8qxm4tnHvoQo4JKxmi6T4dFNauayrQ3B4XKwUAjdojKCBau2ECF514wsrMY2yC
	ilzQ3TI7+m6UYQKG/QfxJnik9wZtkjSur5ElQNcGYTedK5tFJ8st5d9+MOMDIaE3g0qYZ539pUf
	qmyL9RVeqqzoFuyFM48QPF4GabuXQpKcjjn4LKh94a9MQpRqtPbdclN93rkuIrLuRlpRp2ZoLjn
	lw6/idKZ32NncgUm950W5iwHtWhnzz59Him46Ea0v52xDdJBk=
X-Received: by 2002:ac2:57c6:0:b0:5b0:17e7:67d0 with SMTP id 2adb3069b0e04-5b0236c860amr2422594e87.62.1784058947539;
        Tue, 14 Jul 2026 12:55:47 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:822e:374d:22e8:16cf])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca501bfsm3693490e87.26.2026.07.14.12.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:55:47 -0700 (PDT)
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
Date: Tue, 14 Jul 2026 21:55:28 +0200
Message-ID: <20260714195528.597753-4-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714195528.597753-1-jakubszczudlo40@gmail.com>
References: <20260714195528.597753-1-jakubszczudlo40@gmail.com>
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
 drivers/iio/adc/ti-ads1100.c | 87 +++++++++++++++++++++++++++---------
 2 files changed, 71 insertions(+), 25 deletions(-)

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
index f0a30ae139af..5d798bfcc74e 100644
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
 
+static int ads1100_get_vref_millivolts(struct ads1100_data *data)
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
+	microvolts = ads1100_get_vref_millivolts(data) * (MICRO / MILLI);
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
+	int millivolts = ads1100_get_vref_millivolts(data);
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
+		*val = ads1100_get_vref_millivolts(data);
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
@@ -381,7 +416,6 @@ static int ads1100_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->lock);
 
-	indio_dev->name = "ads1100";
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &ads1100_channel;
 	indio_dev->num_channels = 1;
@@ -401,6 +435,13 @@ static int ads1100_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	data->ads_config = i2c_get_match_data(client);
+	if (!data->ads_config)
+		return dev_err_probe(dev, -EINVAL,
+				     "Can't get device data from firmware\n");
+
+	indio_dev->name = data->ads_config->name;
+
 	ret = ads1100_setup(data);
 	if (ret)
 		return dev_err_probe(dev, ret,
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

