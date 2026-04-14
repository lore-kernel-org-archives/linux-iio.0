Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1B83E63A4
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170247; cv=none; b=q/0e8ZqkdccOKTruGW7uvQ0Acf+PEKVvtl/ZTnWehxMKn7l/D/HoyCYN8+eFo96GiPiTxL+8dzJLsHpEId8UfpcqGRlD/U4rRjW4lIJaU1T8nvHAV3saBr0137snF2+vv0kKFnYo4cJCeKO5EpeXs8hmEAzuwEO7CbzM63QoWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170247; c=relaxed/simple;
	bh=KrnoUz78ZCgANaKIHExVuIBpkCPu6OWq0Lp+hZUPfQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WcZQgGyVJlimmos1Gp7fvf5yRTOKHuvScyYaZYYsJUqYyMnYalSrY/jvkG9ju4dK3+z+TasZyZ4K66GStiVneveTRYhaUDEtM7OwEgcwtD4c7rNG0PrusnTwpPt4uBGiuHqyzLjERNQXNuZ8Vjl9SVItyW1voSUTN11srVMDbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5/3yYF1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5/3yYF1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso67771715e9.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 05:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776170243; x=1776775043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cj+kdY279Gb4TgUYsjwC3hozMaQyiytM6srAMYFvSS4=;
        b=f5/3yYF1u1I61kI5hi9IFSzcM1ghJ0qa0owK4gMuqmRO4H3InIyfTneHXmMu/QkNJw
         ZsmOEqeIgSq1robGihViN4JMgZhRmA4oEmXzqKcDcnLafRo+kKx/w+qv7hszlZCQrjIv
         QU1UIN1l2NSnIiYyTTvALTlXgWuFNdaahPlvAHSadZRSixMpjX7NbG+a+J9Cwqti/rlB
         pSf3xGghx146UMFBrW74KdZsJOwBfteqp5GcsGNkcTJC1A5jEFIMoy8Lguh0lJgtCupb
         ZC3xCY9JuCIt/BGQ/+j0R58AcF3inETo4EeAscC12/jCnt+SoRrcrzrvzDsJben60Xsy
         alWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170243; x=1776775043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cj+kdY279Gb4TgUYsjwC3hozMaQyiytM6srAMYFvSS4=;
        b=OdyisZQKcxTWe++Y7BWX+xX1ye+AgOl0WkHCHVJcjYskszYixGYNIPS+GTPmsWrRt1
         pBaZhucbgLcTqvmGUbC2X+ZwZZJJOnM06TSk/jkkZHQpvWnM9LupoRRRVUWIq8fRLt+f
         dcWtkXMxZsGiu8EdfTOefVkl2Mka8LWgsMHx0FWYUaZINzQTLwIkLxHAeSioMHph2MVM
         Mytpz4713c/x1/VS13jKkXeuqHzSxHvnEIh2tJ6DRcFhvPwXVq762wb0rHIxUBh9hBFv
         O1Gi3x+MEm8/NP5rcPXtyCDW253aYPTR/lBlVtWZPeQ5W9v5knx/Cd/i+Hy6lWfwpO49
         eVEQ==
X-Gm-Message-State: AOJu0Yz+urAWUE/Qiobpz0cjdHpCMMqf1kpW/Z+AIQxYgf0MrptR0odO
	VuI2LgIH1Qfni9ZynsFne+RxdOqdgW94UGdNjWPc98r7pobX07BA98/e
X-Gm-Gg: AeBDieuKLoLYCM8IZxvrIdmxBIdOUWSONEYTli2tHbwnAFT6KtlWQvMRaQ/io6Rgsrw
	04AR13TbRPqElqI17knV9bFh0d1rjvCVUNt004BX5sh1wIm1mHrpbUgkw5mKkO7vzSy9lPTwayT
	yCckElP5KEhnLUJXV3XX1waIKA4Z5vveqXblktpnqLNmunaQn0PwSOzITmAvubks/3Lahh74pWH
	0Dh/S/qr6AQX0pHCv7RNrlZDkWggKHX4TaZd5n31BOUu/IkhqpeKu/7wV8XGCZNC7eoXy9BUSGe
	IPNyW7wU59PBvLmYT3GeoKHMQdcy0S3x6rK3fbpHykr8P2T032G718+Da5ZsF9Un9w+199RgX4u
	s6jq/Rc2q6fZfGXbfZXCu8ws4EnmReAN9f7QZQ2gvXnHJ6gun/UswSnEhtQU7/evCGtGLNKFlRQ
	1CfrURoN7lbS/y2nJ9Z54QhH5DyDRgDA==
X-Received: by 2002:a05:600c:a415:b0:487:1108:48af with SMTP id 5b1f17b1804b1-488d67bf7c7mr180734665e9.4.1776170242611;
        Tue, 14 Apr 2026 05:37:22 -0700 (PDT)
Received: from [192.168.8.79] ([2a00:f502:260:5bd3:9217:8960:5f33:aaab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm41552729f8f.24.2026.04.14.05.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:37:22 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Tue, 14 Apr 2026 15:37:18 +0300
Subject: [PATCH v4 2/6] iio: light: vcnl4000: drop enum id table in favor
 of chip structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-vcnl4000-drop-enum-v4-2-59fde2932a0f@gmail.com>
References: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
In-Reply-To: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2

Instead of creating an enum table with chip IDs, store pointers to
structs directly. This drops the association between chip structs and
enum IDs and allows for easier addition or removal of new devices.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 205 +++++++++++++++++++++----------------------
 1 file changed, 98 insertions(+), 107 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 72d68d54864e..cbe0a9e056ec 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -185,14 +185,6 @@ static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
 
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
-enum vcnl4000_device_ids {
-	CM36672P,
-	VCNL4000,
-	VCNL4010,
-	VCNL4040,
-	VCNL4200,
-};
-
 struct vcnl4200_channel {
 	u8 reg;
 	ktime_t last_measurement;
@@ -202,7 +194,6 @@ struct vcnl4200_channel {
 
 struct vcnl4000_data {
 	struct i2c_client *client;
-	enum vcnl4000_device_ids id;
 	int rev;
 	int al_scale;
 	int ps_scale;
@@ -237,18 +228,6 @@ struct vcnl4000_chip_spec {
 	const int prod_id;
 };
 
-static const struct i2c_device_id vcnl4000_id[] = {
-	{ "cm36672p", CM36672P },
-	{ "cm36686", VCNL4040 },
-	{ "vcnl4000", VCNL4000 },
-	{ "vcnl4010", VCNL4010 },
-	{ "vcnl4020", VCNL4010 },
-	{ "vcnl4040", VCNL4040 },
-	{ "vcnl4200", VCNL4200 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
-
 static int vcnl4000_set_power_state(struct vcnl4000_data *data, bool on)
 {
 	/* no suspend op */
@@ -1889,82 +1868,84 @@ static const struct iio_info vcnl4040_info = {
 	.read_avail = vcnl4040_read_avail,
 };
 
-static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
-	[CM36672P] = {
-		.prod = "CM36672P",
-		.init = vcnl4200_init,
-		.measure_proximity = vcnl4200_measure_proximity,
-		.set_power_state = vcnl4200_set_power_state,
-		.channels = cm36672p_channels,
-		.num_channels = ARRAY_SIZE(cm36672p_channels),
-		.info = &vcnl4040_info,
-		.irq_thread = vcnl4040_irq_thread,
-		.int_reg = VCNL4040_INT_FLAGS,
-		.ps_it_times = &vcnl4040_ps_it_times,
-		.num_ps_it_times = ARRAY_SIZE(vcnl4040_ps_it_times),
-		.prod_id = VCNL4040_PROD_ID,
-	},
-	[VCNL4000] = {
-		.prod = "VCNL4000",
-		.init = vcnl4000_init,
-		.measure_light = vcnl4000_measure_light,
-		.measure_proximity = vcnl4000_measure_proximity,
-		.set_power_state = vcnl4000_set_power_state,
-		.channels = vcnl4000_channels,
-		.num_channels = ARRAY_SIZE(vcnl4000_channels),
-		.info = &vcnl4000_info,
-		.prod_id = VCNL4000_PROD_ID,
-	},
-	[VCNL4010] = {
-		.prod = "VCNL4010/4020",
-		.init = vcnl4000_init,
-		.measure_light = vcnl4000_measure_light,
-		.measure_proximity = vcnl4000_measure_proximity,
-		.set_power_state = vcnl4000_set_power_state,
-		.channels = vcnl4010_channels,
-		.num_channels = ARRAY_SIZE(vcnl4010_channels),
-		.info = &vcnl4010_info,
-		.irq_thread = vcnl4010_irq_thread,
-		.trig_buffer_func = vcnl4010_trigger_handler,
-		.buffer_setup_ops = &vcnl4010_buffer_ops,
-		.prod_id = VCNL4010_PROD_ID,
-	},
-	[VCNL4040] = {
-		.prod = "VCNL4040",
-		.init = vcnl4200_init,
-		.measure_light = vcnl4200_measure_light,
-		.measure_proximity = vcnl4200_measure_proximity,
-		.set_power_state = vcnl4200_set_power_state,
-		.channels = vcnl4040_channels,
-		.num_channels = ARRAY_SIZE(vcnl4040_channels),
-		.info = &vcnl4040_info,
-		.irq_thread = vcnl4040_irq_thread,
-		.int_reg = VCNL4040_INT_FLAGS,
-		.ps_it_times = &vcnl4040_ps_it_times,
-		.num_ps_it_times = ARRAY_SIZE(vcnl4040_ps_it_times),
-		.als_it_times = &vcnl4040_als_it_times,
-		.num_als_it_times = ARRAY_SIZE(vcnl4040_als_it_times),
-		.ulux_step = 100000,
-		.prod_id = VCNL4040_PROD_ID,
-	},
-	[VCNL4200] = {
-		.prod = "VCNL4200",
-		.init = vcnl4200_init,
-		.measure_light = vcnl4200_measure_light,
-		.measure_proximity = vcnl4200_measure_proximity,
-		.set_power_state = vcnl4200_set_power_state,
-		.channels = vcnl4040_channels,
-		.num_channels = ARRAY_SIZE(vcnl4000_channels),
-		.info = &vcnl4040_info,
-		.irq_thread = vcnl4040_irq_thread,
-		.int_reg = VCNL4200_INT_FLAGS,
-		.ps_it_times = &vcnl4200_ps_it_times,
-		.num_ps_it_times = ARRAY_SIZE(vcnl4200_ps_it_times),
-		.als_it_times = &vcnl4200_als_it_times,
-		.num_als_it_times = ARRAY_SIZE(vcnl4200_als_it_times),
-		.ulux_step = 24000,
-		.prod_id = VCNL4200_PROD_ID,
-	},
+static const struct vcnl4000_chip_spec cm36672p_spec = {
+	.prod = "CM36672P",
+	.init = vcnl4200_init,
+	.measure_proximity = vcnl4200_measure_proximity,
+	.set_power_state = vcnl4200_set_power_state,
+	.channels = cm36672p_channels,
+	.num_channels = ARRAY_SIZE(cm36672p_channels),
+	.info = &vcnl4040_info,
+	.irq_thread = vcnl4040_irq_thread,
+	.int_reg = VCNL4040_INT_FLAGS,
+	.ps_it_times = &vcnl4040_ps_it_times,
+	.num_ps_it_times = ARRAY_SIZE(vcnl4040_ps_it_times),
+	.prod_id = VCNL4040_PROD_ID,
+};
+
+static const struct vcnl4000_chip_spec vcnl4000_spec = {
+	.prod = "VCNL4000",
+	.init = vcnl4000_init,
+	.measure_light = vcnl4000_measure_light,
+	.measure_proximity = vcnl4000_measure_proximity,
+	.set_power_state = vcnl4000_set_power_state,
+	.channels = vcnl4000_channels,
+	.num_channels = ARRAY_SIZE(vcnl4000_channels),
+	.info = &vcnl4000_info,
+	.prod_id = VCNL4000_PROD_ID,
+};
+
+static const struct vcnl4000_chip_spec vcnl4010_spec = {
+	.prod = "VCNL4010/4020",
+	.init = vcnl4000_init,
+	.measure_light = vcnl4000_measure_light,
+	.measure_proximity = vcnl4000_measure_proximity,
+	.set_power_state = vcnl4000_set_power_state,
+	.channels = vcnl4010_channels,
+	.num_channels = ARRAY_SIZE(vcnl4010_channels),
+	.info = &vcnl4010_info,
+	.irq_thread = vcnl4010_irq_thread,
+	.trig_buffer_func = vcnl4010_trigger_handler,
+	.buffer_setup_ops = &vcnl4010_buffer_ops,
+	.prod_id = VCNL4010_PROD_ID,
+};
+
+static const struct vcnl4000_chip_spec vcnl4040_spec = {
+	.prod = "VCNL4040",
+	.init = vcnl4200_init,
+	.measure_light = vcnl4200_measure_light,
+	.measure_proximity = vcnl4200_measure_proximity,
+	.set_power_state = vcnl4200_set_power_state,
+	.channels = vcnl4040_channels,
+	.num_channels = ARRAY_SIZE(vcnl4040_channels),
+	.info = &vcnl4040_info,
+	.irq_thread = vcnl4040_irq_thread,
+	.int_reg = VCNL4040_INT_FLAGS,
+	.ps_it_times = &vcnl4040_ps_it_times,
+	.num_ps_it_times = ARRAY_SIZE(vcnl4040_ps_it_times),
+	.als_it_times = &vcnl4040_als_it_times,
+	.num_als_it_times = ARRAY_SIZE(vcnl4040_als_it_times),
+	.ulux_step = 100000,
+	.prod_id = VCNL4040_PROD_ID,
+};
+
+static const struct vcnl4000_chip_spec vcnl4200_spec = {
+	.prod = "VCNL4200",
+	.init = vcnl4200_init,
+	.measure_light = vcnl4200_measure_light,
+	.measure_proximity = vcnl4200_measure_proximity,
+	.set_power_state = vcnl4200_set_power_state,
+	.channels = vcnl4040_channels,
+	.num_channels = ARRAY_SIZE(vcnl4000_channels),
+	.info = &vcnl4040_info,
+	.irq_thread = vcnl4040_irq_thread,
+	.int_reg = VCNL4200_INT_FLAGS,
+	.ps_it_times = &vcnl4200_ps_it_times,
+	.num_ps_it_times = ARRAY_SIZE(vcnl4200_ps_it_times),
+	.als_it_times = &vcnl4200_als_it_times,
+	.num_als_it_times = ARRAY_SIZE(vcnl4200_als_it_times),
+	.ulux_step = 24000,
+	.prod_id = VCNL4200_PROD_ID,
 };
 
 static const struct iio_trigger_ops vcnl4010_trigger_ops = {
@@ -1991,7 +1972,6 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 
 static int vcnl4000_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	const char * const regulator_names[] = { "vdd", "vio", "vled" };
 	struct device *dev = &client->dev;
 	struct vcnl4000_data *data;
@@ -2005,8 +1985,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
-	data->id = id->driver_data;
-	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
+	data->chip_spec = i2c_get_match_data(client);
 
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
 					     regulator_names);
@@ -2081,32 +2060,32 @@ static int vcnl4000_probe(struct i2c_client *client)
 static const struct of_device_id vcnl_4000_of_match[] = {
 	{
 		.compatible = "capella,cm36672p",
-		.data = (void *)CM36672P,
+		.data = &cm36672p_spec,
 	},
 	/* Capella CM36686 is fully compatible with Vishay VCNL4040 */
 	{
 		.compatible = "capella,cm36686",
-		.data = (void *)VCNL4040,
+		.data = &vcnl4040_spec,
 	},
 	{
 		.compatible = "vishay,vcnl4000",
-		.data = (void *)VCNL4000,
+		.data = &vcnl4000_spec,
 	},
 	{
 		.compatible = "vishay,vcnl4010",
-		.data = (void *)VCNL4010,
+		.data = &vcnl4010_spec,
 	},
 	{
 		.compatible = "vishay,vcnl4020",
-		.data = (void *)VCNL4010,
+		.data = &vcnl4010_spec,
 	},
 	{
 		.compatible = "vishay,vcnl4040",
-		.data = (void *)VCNL4040,
+		.data = &vcnl4040_spec,
 	},
 	{
 		.compatible = "vishay,vcnl4200",
-		.data = (void *)VCNL4200,
+		.data = &vcnl4200_spec,
 	},
 	{ }
 };
@@ -2148,6 +2127,18 @@ static int vcnl4000_runtime_resume(struct device *dev)
 static DEFINE_RUNTIME_DEV_PM_OPS(vcnl4000_pm_ops, vcnl4000_runtime_suspend,
 				 vcnl4000_runtime_resume, NULL);
 
+static const struct i2c_device_id vcnl4000_id[] = {
+	{ "cm36672p", (kernel_ulong_t)&cm36672p_spec },
+	{ "cm36686", (kernel_ulong_t)&vcnl4040_spec },
+	{ "vcnl4000", (kernel_ulong_t)&vcnl4000_spec },
+	{ "vcnl4010", (kernel_ulong_t)&vcnl4010_spec },
+	{ "vcnl4020", (kernel_ulong_t)&vcnl4010_spec },
+	{ "vcnl4040", (kernel_ulong_t)&vcnl4040_spec },
+	{ "vcnl4200", (kernel_ulong_t)&vcnl4200_spec },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
+
 static struct i2c_driver vcnl4000_driver = {
 	.driver = {
 		.name   = VCNL4000_DRV_NAME,

-- 
2.53.0

