Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9CD30595B
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780857458; cv=none; b=muuiCqD3InSVLxbhoPlPRpnEYL7pb9ziG9KHlz1Fn5xH0M9CjM7+Cwn1GRl9nTi66l+PjrLy4kDsXlvoFZDbPlzZBhAl48ky+HsDs+IbZIo9fezPFlPgAsmYGU3sKe757lYTskha5HEdjIPHkeevPl0+qCDvZ+SvKY8+YOFjuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780857458; c=relaxed/simple;
	bh=xQsh1Dv1Iu54/Cb3594y8odpVQjN0OB8h6ISUFWnpH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQpbtDWTfzM9IofoDEsFY5zPI2o8YuCRbDl5YEdHAINE2Vbr4DcaEzWpS0GwZ5f86Ek2t20PhS385694vUvobn9c0YkZBJfmBEhbB2+MNDah1lxnph8X1dO7odeWKBmwYvHR+elyqncoNb0aoZfrE8r1+9L4j17iIMIEMkKBGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXinIQUB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXinIQUB"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so2982218e87.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 11:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780857455; x=1781462255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gi9RhOvXuN1inW3/JT5BCjZHZCw1onAyhDikSR7H1fw=;
        b=mXinIQUBjkR0UIFVCpjoVt05obybVHDyuN/7TgYv3voJa2EiDZXxXbRYyKx2hCFsDK
         08jWKJEFwet0Z8+1HsrgWZ8qjbyr3t3HlSnAdER9wg/lyyQZKi6+LEWV2ZxUJbfQkRrY
         IP5aHTxPY57pIMiyq/33oWYjwIJ0b4Yex2+Z1AB3KkbNAuxPxXkyHwh8XJgKkXVFD2Yi
         jzxzdnCvOlN7K4Mm5JgUmV4xr075JxCfJuLF+kgpkfAWmiM8+RZC003qouHQ5+FBH0gB
         IzzsBzOP4sWPxw1QWt9X+yd0/dSKx7WF2gq39u1EO9fyyPklWO6ACw7+87hlCeJYVA+p
         gL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780857455; x=1781462255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gi9RhOvXuN1inW3/JT5BCjZHZCw1onAyhDikSR7H1fw=;
        b=e9eEqInhm2uR6etXH29Bytv0sydlcaHmsDxZIqIHoDmy8+VZ2ceuI74VllVL9qizrq
         tiRYZMSZEX34nzRdx/ptY/QNJL+jmseVeNNAnK1/xpTJ1Roxq2umOxeJzxYx3RiIv7i1
         3XyCFnRlwn+buHzuAFoIGzG7phyr5Ea6kU1gitNxhyvS0eoo+B97G9z8hsTJ28cz6KsZ
         7g5CbozueMgiU5UIagMxu9g2cmgmDROv/tyCUEdbEnxUTDHBDQPok2+V8KOvmd3DCm74
         Cn6trddYKAK163CMerUpJia+KErnQq/8HvzkC8TOcH21Ypu43iqfEPIrJ5hdVYk9Jnip
         pI1w==
X-Gm-Message-State: AOJu0YwPVo/seoKxOxbM32K840uTdMhAjiKCxBDa+tZ7UYvvB+wvEZA2
	UrmSFLQO3RYn+Ulcy661CH2YFKEIJupwrPh1Y+o8ZQnYrWm47AWEnkbhk1h2ztFY
X-Gm-Gg: Acq92OFAtckT1/ZaZJi3Hyrja5MPRoQD9CsT9+9AQJFZ3S8/Xflx+z6JWz/uGqV6fs7
	nQ2tsrN76cxhKTnmisb1wsn8Rs4DI07ZwGiSWr089U7lUGaaLEsLCrgUL5+TpPGKglysfSkcKms
	Fm2veF9TGoINu2h2zTeTatjBca6YMLZweODnypzvhVDKB6AbOeGfUj9fDhIWnOHB7R9UgL8Smyj
	oiPIEy/7bzPt1oYNzWgH1VF2tczu8FErXATe+COZQnCYww6ZkMdsME5sq03NUNo0dAXBMr4nOAO
	OBPYycUqpBme88roN4xl0ToAOYEB64SI9wcDKDoMeK765vObXmggvJI5j/C2nn2vHlGKfPw+Z8Z
	7RZXjTkGtgb3gQ+x/iHyW5jMFLUBYhSKSd07Ha7ZxcGFIw4cLNTWiBVTPVpoH1Z/lRdJ6FCPyYw
	RDyh9FUSx6LANQbK8fbYkECqtNQkWuups4MnJxj6PsxGsC4eb9zPPWzwNDj1fzFqUGarmeXijLe
	jKVyw==
X-Received: by 2002:a05:6512:6c8:b0:5aa:6b98:7a78 with SMTP id 2adb3069b0e04-5aa87b53eadmr3301875e87.13.1780857455386;
        Sun, 07 Jun 2026 11:37:35 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:efe3:f920:63b7:5b7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fc426sm3240809e87.26.2026.06.07.11.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 11:37:33 -0700 (PDT)
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
	jszczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100 driver
Date: Sun,  7 Jun 2026 20:35:42 +0200
Message-ID: <20260607183542.368184-4-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jszczudlo <jakubszczudlo40@gmail.com>

add ADS1100 support
make changing gain and datarate wait for new reading
fix unbalanced regulator disable when removing in singleshot mode

Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>
---
 drivers/iio/adc/ti-ads1100.c | 165 ++++++++++++++++++++++++++---------
 1 file changed, 126 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index aa8946063c7d..11d6fe1e8abc 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -5,18 +5,15 @@
  * Copyright (c) 2023, Topic Embedded Products
  *
  * Datasheet: https://www.ti.com/lit/gpn/ads1100
- * IIO driver for ADS1100 and ADS1000 ADC 16-bit I2C
+ * IIO driver for ADS1100, ADS1000 and ADS1110 ADC 16-bit I2C
  */
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
-#include <linux/cleanup.h>
-#include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/property.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/units.h>
@@ -39,17 +36,39 @@
 #define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
 
 #define ADS1100_SLEEP_DELAY_MS	2000
+#define ADS1110_REFERENCE_VOLTAGE_MICROVOLT 2048000
+
+/* Timeout based on the minimum sample rate of 8 SPS (7500000us) */
+#define ADS11x0_MAX_DRDY_TIMEOUT	7500000
 
 static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
+static const int ads1110_data_rate[] = { 240, 60, 30, 15 };
 static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
 
+struct ads11x0_config {
+	const int *data_rate;
+	bool has_reference_voltage;
+};
+
+static const struct ads11x0_config ads1100_config = {
+	.data_rate = ads1100_data_rate,
+	.has_reference_voltage = false,
+};
+
+static const struct ads11x0_config ads1110_config = {
+	.data_rate = ads1110_data_rate,
+	.has_reference_voltage = true,
+};
+
 struct ads1100_data {
 	struct i2c_client *client;
 	struct regulator *reg_vdd;
 	struct mutex lock;
 	int scale_avail[2 * 4]; /* 4 gain settings */
 	u8 config;
-	bool supports_data_rate; /* Only the ADS1100 can select the rate */
+	bool supports_data_rate; /* Only the ADS1100/ADS1110 can select the rate */
+	bool has_reference_voltage; /* The ADS1110 has an internal reference, so fixed scale */
+	const int *data_rate;
 };
 
 static const struct iio_chan_spec ads1100_channel = {
@@ -59,12 +78,6 @@ static const struct iio_chan_spec ads1100_channel = {
 	    BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	.info_mask_shared_by_all_available =
 	    BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	.scan_type = {
-		      .sign = 's',
-		      .realbits = 16,
-		      .storagebits = 16,
-		      .endianness = IIO_CPU,
-		       },
 	.datasheet_name = "AIN",
 };
 
@@ -85,6 +98,50 @@ static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
 	return 0;
 };
 
+static int ads11x0_get_voltage_microvolts(struct ads1100_data *data)
+{
+	if (data->has_reference_voltage)
+		return ADS1110_REFERENCE_VOLTAGE_MICROVOLT;
+	else
+		return regulator_get_voltage(data->reg_vdd);
+}
+
+static int ads11x0_get_voltage_milivolts(struct ads1100_data *data)
+{
+	return ads11x0_get_voltage_microvolts(data) / (MICRO / MILLI);
+}
+
+static bool ads11x0_new_data_ready(struct ads1100_data *data)
+{
+	int ret;
+	u8 buffer[3];
+
+	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+	if (ret < sizeof(buffer)) {
+		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
+		return 0;
+	}
+
+	int return_val = FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
+
+	return return_val;
+}
+
+static int ads11x0_poll_data_ready(struct ads1100_data *data)
+{
+	bool data_ready;
+	u8 buffer[3];
+	int datarate = data->data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
+	unsigned long wait_time = DIV_ROUND_CLOSEST(MICRO, 5 * datarate);
+
+	/* To be sure that polled value will have value after config change */
+	i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+
+	return read_poll_timeout(ads11x0_new_data_ready, data_ready,
+				 !data_ready, wait_time,
+				 ADS11x0_MAX_DRDY_TIMEOUT, false, data);
+}
+
 static int ads1100_data_bits(struct ads1100_data *data)
 {
 	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
@@ -105,9 +162,10 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
 
 	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
 
+	pm_runtime_mark_last_busy(&data->client->dev);
 	pm_runtime_put_autosuspend(&data->client->dev);
 
-	if (ret < 0) {
+	if (ret < sizeof(buffer)) {
 		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
 		return ret;
 	}
@@ -127,7 +185,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 {
 	int microvolts;
 	int gain;
-
+	int ret;
 	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
 	if (val)
 		return -EINVAL;
@@ -135,7 +193,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (!val2)
 		return -EINVAL;
 
-	microvolts = regulator_get_voltage(data->reg_vdd);
+	microvolts = ads11x0_get_voltage_microvolts(data);
 	/*
 	 * val2 is in 'micro' units, n = val2 / 1000000
 	 * result must be millivolts, d = microvolts / 1000
@@ -147,34 +205,49 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (gain < BIT(0) || gain > BIT(3))
 		return -EINVAL;
 
+	ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (ret < 0)
+		return ret;
+
 	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);
 
-	return 0;
+	ret = ads11x0_poll_data_ready(data);
+
+	pm_runtime_mark_last_busy(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+
+	return ret;
 }
 
 static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 {
 	unsigned int i;
 	unsigned int size;
+	int ret;
 
 	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
 	for (i = 0; i < size; i++) {
-		if (ads1100_data_rate[i] == rate)
-			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
-						       FIELD_PREP(ADS1100_DR_MASK, i));
+		if (data->data_rate[i] == rate) {
+			ret = pm_runtime_resume_and_get(&data->client->dev);
+			if (ret < 0)
+				return ret;
+
+			ads1100_set_config_bits(data, ADS1100_DR_MASK,
+						FIELD_PREP(ADS1100_DR_MASK, i));
+			ret = ads11x0_poll_data_ready(data);
+
+			pm_runtime_mark_last_busy(&data->client->dev);
+			pm_runtime_put_autosuspend(&data->client->dev);
+			return ret;
+		}
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
+	int millivolts = ads11x0_get_voltage_milivolts(data);
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
@@ -196,7 +269,7 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*type = IIO_VAL_INT;
-		*vals = ads1100_data_rate;
+		*vals = data->data_rate;
 		if (data->supports_data_rate)
 			*length = ARRAY_SIZE(ads1100_data_rate);
 		else
@@ -233,12 +306,11 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* full-scale is the supply voltage in millivolts */
-		*val = ads1100_get_vdd_millivolts(data);
+		*val = ads11x0_get_voltage_milivolts(data);
 		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
-						   data->config)];
+		*val = data->data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -280,8 +352,8 @@ static int ads1100_setup(struct ads1100_data *data)
 		return ret;
 
 	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
-	if (ret < 0)
-		return ret;
+	if (ret < sizeof(buffer))
+		return -1;
 
 	/* Config register returned in third byte, strip away the busy status */
 	data->config = buffer[2] & ~ADS1100_CFG_ST_BSY;
@@ -292,9 +364,13 @@ static int ads1100_setup(struct ads1100_data *data)
 	return 0;
 }
 
-static void ads1100_reg_disable(void *reg)
+static void ads1100_reg_disable(void *data)
 {
-	regulator_disable(reg);
+	struct ads1100_data *ads1100_data = data;
+
+	/* Disable when not already disabled by the driver */
+	if (!(ads1100_data->config & ADS1100_CFG_SC))
+		regulator_disable(ads1100_data->reg_vdd);
 }
 
 static void ads1100_disable_continuous(void *data)
@@ -307,6 +383,7 @@ static int ads1100_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	struct ads1100_data *data;
 	struct device *dev = &client->dev;
+	const struct ads11x0_config *model;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -334,10 +411,18 @@ static int ads1100_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret,
 				     "Failed to enable vdd regulator\n");
 
-	ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data->reg_vdd);
+	ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data);
 	if (ret)
 		return ret;
 
+	model = device_get_match_data(dev);
+	if (!model)
+		return dev_err_probe(dev, ret,
+				"Can't set device data\n");
+
+	data->data_rate = model->data_rate;
+	data->has_reference_voltage = model->has_reference_voltage;
+
 	ret = ads1100_setup(data);
 	if (ret)
 		return dev_err_probe(dev, ret,
@@ -400,16 +485,18 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
 				 NULL);
 
 static const struct i2c_device_id ads1100_id[] = {
-	{ "ads1100" },
-	{ "ads1000" },
+	{ .name = "ads1100", .driver_data = (kernel_ulong_t)&ads1100_config },
+	{ .name = "ads1000", .driver_data = (kernel_ulong_t)&ads1100_config },
+	{ .name = "ads1110", .driver_data = (kernel_ulong_t)&ads1110_config },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, ads1100_id);
 
 static const struct of_device_id ads1100_of_match[] = {
-	{.compatible = "ti,ads1100" },
-	{.compatible = "ti,ads1000" },
+	{ .compatible = "ti,ads1100", .data = &ads1100_config },
+	{ .compatible = "ti,ads1000", .data = &ads1100_config },
+	{ .compatible = "ti,ads1110", .data = &ads1110_config },
 	{ }
 };
 
-- 
2.47.3

