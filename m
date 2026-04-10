Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15B73C2763
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837761; cv=none; b=PpIcLggninyC0OHLwjHv+mM5ywYyqEZIm+F/G+n+fEdmx0GIo5PXfB3fsSO3Ypm+YC1crq/gsq6lRYh92V2AG+mEhrfM63YD0+icV2798X8fvsp9+W1tTHdNmVQQWgsjwtvopVqBBkqT2h1A/W2n0+8lUkLYlVIWE4lMLq6hfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837761; c=relaxed/simple;
	bh=HYuBVvTYYb55Y4/eAe8/nY1GiKvbIyaGdjh1yZlzxJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FhQYDgvcgPbB8Gk9MPKcNptI9DRKA6boMJ8Inq3OfD9UoRZnU1LwcLhOrcaXNwwcr1z18DaAL9kvPVuGHJXqgoo19rRGMl5OtXFdiDxZnDBW+CM+1YUXTY4DmAX+NQz7Mf5bmmwFS9TnRwFa9RST10bfJLWXFM3tZ1GKTTV2C+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJxUHcLZ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJxUHcLZ"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a535e7c00so27290147b3.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775837758; x=1776442558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEC+NZji/WPrxNlnU3fGBPXtsIIFdYI/pacJYdiIFV0=;
        b=NJxUHcLZ8XFxRGYjHFTHqy5IK7PWeAfgwPXm6lCEq+wjbBDccukmd9DVS37s1kw7gz
         wjWC012HU18xl9JfPB3PNEOvcPeOwhX+750x6r1l2pyzrERvvkueQZtYXn58Oy0WjJSc
         lCm4q1BjPWndLMld+JezejDtuhs1rSDeEEMD7GS8JYRABzNFcRvEt0bpPvhuP327EC3H
         Nd4PeAblwaP5k6pyjO5+raiAoJUoeSSIrX3SdF6ggBxIDyEandy7oxKaSUEmzYucj1Be
         1Xb2aBG49RREUksW9tDIU0Bfdd1L5Xf2Wuhqcpy7t/qrCQG1NZwIbJVN9j9kjdyGYOpK
         RtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775837758; x=1776442558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PEC+NZji/WPrxNlnU3fGBPXtsIIFdYI/pacJYdiIFV0=;
        b=q5MlquGexeKF48QsZp18VXlRlwahsvI5jrbz2m4u8tIq/kCeHmK6vLeKvOXikbC8Xn
         2L982hzphlbV1J/ZkfJQGPF5qi1QBqs6yBkSLi5Q/2iiTeKQ+vN/bVHxkuMXS5qOVWWv
         IsRecrivS9AK9Egg2nS7uT0yufgWOj6q1nM+z/lTBvDiRSwDW5PoWMhmVP1TxNgzrgA2
         uknVc+brRa3XziXHx/nbUMBo/UgI6vGVGRSLdl/Wusb7QHGgyvz5H/QATHnZI5Xzj88t
         OXlFpVVDC23xmbzJTvewz4jl7RNEMqrGBfFsDkysJhwrHOxbBW1CBNgBDmtCUBAJ2o/P
         a2iw==
X-Gm-Message-State: AOJu0YwAYAZ8Q0VY3kRQcarQmj3HFsXgRYUBnxjd+2PgxC2uA1BXMOCN
	jr6OFuzmT23mD7H929WB945sEO7NbBHxFx1Zpmbubq7uzXQph2Co42JA
X-Gm-Gg: AeBDievZaC9BRHfe2E1G8vfspRb4XSYpcbwyKqXFJOpKe6TySH3cW1a5bZIk8o7fuIe
	w5TFUP/0QkhyAuqGE1hw03NnrNf44CGOHNFBkZXtB/qNBC2HUQMVhxhmZsq/XWat8mw0sOTGpii
	NzidcdDbhogDYFzJqbgBhfIqgSJeOwS4vor1SV5aAcUhICMz13XqY7e17wYdJrx1bHRAcE3hUH+
	/eHOPnNSQf4M3ptTP/1hwnImi1o+NdESf6pYknVtuDIokyTNIlS9le3Pqknf//3mcDHogzdn5te
	10TiZkITCXe3hL/om+wSS1QBw2TjL6y/nK2fRNmS1nYzwj9PiK7v+5BrvTE9Sgs6ZxdvJidV8t1
	85859wByxBKsAdqslgCDPMEYViDhD4MaA42pyTZIULu0AHPr37jwOsAXApDySM4jVssIi7I2BlE
	KkiH2fX4nCh9SKjVS/cGHsqBGLKg==
X-Received: by 2002:a05:690c:6604:b0:79b:82a1:645d with SMTP id 00721157ae682-7af71282b58mr41933277b3.29.1775837757694;
        Fri, 10 Apr 2026 09:15:57 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa05b48sm15408337b3.33.2026.04.10.09.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:15:57 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Fri, 10 Apr 2026 19:11:18 +0300
Subject: [PATCH v3 2/6] iio: light: vcnl4000: drop enum id table in favor
 of chip structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-vcnl4000-drop-enum-v3-2-2ea2bc6f5dfb@gmail.com>
References: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
In-Reply-To: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.1

Instead of creating an enum table with chip IDs, store pointers to
structs directly. This drops the association between chip structs and
enum IDs and allows for easier addition or removal of new devices.

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

