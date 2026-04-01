Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22873F8814
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042676; cv=none; b=gaor3x4hLQ7hjlk9FKdys4nITPFy9ZzB6oJ9kP9oYgdHNAe/tRP5/qzNGmMyVAq9UYBfHUR9An4N4ztuz3EUYFPo2ag08VTYppjyK6vf2vBNDMl5nz+JJvnFSLaaef9zhkukieSHqXU5CkuMJy5dFBJ/xd4N6xYG+/PK2uc3/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042676; c=relaxed/simple;
	bh=vYqIW/Gqq4fflDfaI8Jf/yJIutWh/VhqHqfWtmFgBVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=beI00ohOGld3v5hp2vJF/cWVxbgnaS9POcLSuC7eKf3IA0KZk2yFzCT9fUvKj518BbXnCKGador8X2q5SJFrSYSTPs0ARSD6WDFSlcSsnpKF3nbdUXLBJscTQICepdsTWeUaz+uew9LpW59Ho675NTMI/9Yqh5Z2AW3jdtCV6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4c0KfSr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4c0KfSr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4887d4c6234so20814975e9.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 04:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775042673; x=1775647473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9895e4FwG2ovO6tBDWw3OwKtNs1gDVGzeGbxIRzOTSQ=;
        b=o4c0KfSr0pwJYs56IU0D9krouQYo8ifmPFomN3pDSpK9Xct79Di5IGseUxPAP8kBm2
         Auu2B/XUgT0vrdnSLDzEsTx1Bqm2g6dWw6r8mqs3CpwaSMz0xyy/WldIrydFibhWQmna
         qBqWr8sGPMsPHTfazaHHlXmd0bvjmz14yahoGGP3vjS2K0c2K4cg29PGTrrnG5wePUr3
         3oEyQfgFoYVQ+QrmcMQCvmmRc1IP65hZ/a/AjU4ug8Nm3xg6Zhh7Wlq456oROcbAOJrx
         qKvLOiCPLAn01akalOsZB6zpzpP0XMjZ0vHTpK2R75R4MEevt+IpWNnE7jXUFhcDeXIA
         /wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775042673; x=1775647473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9895e4FwG2ovO6tBDWw3OwKtNs1gDVGzeGbxIRzOTSQ=;
        b=PaEwaeIOsFkp4Cxyikmm0vaLUokkJBSEvtwoTjR4p/RhcmEizaNkvBE2WrOPKYIa7L
         3rlACIQo7inNm2Eq5FzhpVzoFrPlN63wkiPn1P3nSiVuoNbVl/OTwU4rp6yDowHDVSO+
         cVouStgR7fgiMbYxZLjqOMRhV7mcBR+E7bic4k7b4MlT3cjgoFOAFfXSxcpS4qhu4Vos
         d/M3lhHZION/F1wHNjlKBeKHs50psbsYbahrRWLF2fEXbl8EHSn1GWDYI3nYI+LPejEv
         hJcUavaAEd2j5bqaEF1/6ENn7LcODccw4BvypvJ6Dycnf9xYCwRTvUO9cw7smLTgq2Id
         oYJQ==
X-Gm-Message-State: AOJu0YysKP4ikXnw+HfpMewwwyja/i7r5kf23+7AQ2+VvVwgi0OZjJfM
	S9xSDYXYqKU5I8+YoFH2fl+1Y/ylPYaChYSK+ol5/Njs/iXUasUIz16n
X-Gm-Gg: ATEYQzzzu8nx8jT5i8F1+wZlUMvms0Hf/F8XvnQQGJiz6xwjFGsWKDdE9Eki+HePjTA
	ZtJCDOpf0ye+pI7SrdPHig4/tKVefm89tR3Dl0qzsH6LDghxKeKDYy+uJ+Vf6ZBLWanzzdLe5ve
	+yTIR7wUcZZmHOhz4oJStexe3OgNWdBWihBnXa04pahYD+RmFwVb44lWrq/5k3zQEvECShqVNY6
	0cocPeDpnxELPkXdJsBJOtsquBb5TlGTDJxPvvqmTxIDtvEGK6caxYF5qBkUv2d2Pl5uv4ujRpM
	saFuXYfcpuUqaiTnqRvF1Exg5nTTqt9IUvaQDPJ9wg2UmPg4510fS6ZJNfyFmrgIXbYphhhveYe
	jZn7AaKXJd168bpwsqx2ZkemHMqq/VHyXQDt5HFEDC0hqINp0VLaGuXl+Mg9lLuVlKVY8LlZ5OW
	jw0Cnr/utvGDRDKYwiS7TmsbV4BfyvXTrR
X-Received: by 2002:a05:600c:828f:b0:485:2ce2:4c8a with SMTP id 5b1f17b1804b1-4888355ec67mr57945285e9.1.1775042673055;
        Wed, 01 Apr 2026 04:24:33 -0700 (PDT)
Received: from [127.0.0.1] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887aacb99csm43450165e9.1.2026.04.01.04.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:24:32 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Wed, 01 Apr 2026 14:22:37 +0300
Subject: [PATCH 2/3] iio: light: vcnl4000: drop enum id table in favor of
 chip structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-vcnl4000-drop-enum-v1-2-ffd201f0c848@gmail.com>
References: <20260401-vcnl4000-drop-enum-v1-0-ffd201f0c848@gmail.com>
In-Reply-To: <20260401-vcnl4000-drop-enum-v1-0-ffd201f0c848@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

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
2.52.0

