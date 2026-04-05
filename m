Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC542C1584
	for <linux-iio@vger.kernel.org>; Sun,  5 Apr 2026 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775405341; cv=none; b=WkyM0N0EMCFzHdab1BDaQfVh0EUtUCRU2i9cV3aM12QMI5vsgXC6tWlmy3OQfnJWnyXYjjkZeDHX9ucRPx/u5vqhoM2tsvrZQoErxJGx6j4V5mmwGtdVUsTMkW/eT92WKUP1gY3wAWaECufryBt1z1/yS29NdHAs5GUwRWMhmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775405341; c=relaxed/simple;
	bh=Lkl/tCma/DG7kpmMYlXl6z94zAlSivBuq3aJqoYjUAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QE8SCZjtjBfKKhm+y2bndFwGmXSPnMbnTrs5sB0S1qdjkCUa5e3J84cjHmWAAONHTQxmfs1ELcI4tLemcPVqAFJdW9sp9sJdGYazLKbVUNLBUejATqFsUnaxEDguOs/KBHDAWCCD04F7FIkRdT8fTtAHP4ngpNqdNbRVWtNCSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5oIDpd+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5oIDpd+"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66dd0531d01so4932570a12.3
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775405337; x=1776010137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rr/dqvB3ImU/fbrclGNRtxKGepRSAGEKqUVvA+ogmJ0=;
        b=D5oIDpd+24Sc58rv34HoR5eBC9MDMz8Ymzm8ECjLGOwZVu6Da4RTnrjGEpucQqZRUY
         Soo4Sh2rGp+lUuHyeTNkybO9BQASgtGKJPE5QldSYy4rHcKQLl3YHN5rcAZ1DZTrTY6N
         BbMzbqaPhfy28O0DJpXVaRLSeMwcGcm7Aap5nsTGJ+nUR8TQUNu2vsAC8PCKkFBXYoDX
         LOjiDl1nKwKPtNGmb86MonDVHDhfRJc6thyTvcOWPTfcT6xF1C2fL2MzRYzLiAi6vO88
         XWxAGhh37/fFkGm5uyOQo99JoKoUgontYqpjsJugF+T9uX09Rx1LRXfAAMMGEm3xIDRc
         9Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775405337; x=1776010137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rr/dqvB3ImU/fbrclGNRtxKGepRSAGEKqUVvA+ogmJ0=;
        b=oqM5cCUPQomltbgp/Of1LPmWuX83aVaDFqsOVHtvJevyWsvvtVYEEDfvHPcPj3+WBJ
         8Yo3UNCaj8OMj9vE75WaDdJ+oWduB8RuuNdn0lnwkkci1eLQUXLQ5K94d2h0/PaljV8f
         kuy/HBW7hQxJ84Dkyhq6o3KkSrvzYWcrUD1G3rE6dT8+JiB9BWRkVPD1j5I2woml9L2B
         Ifyf9F1TYZgQGrmcrA2ParvgEqjn2vPy82D52CoZmSDPDd9nrCr3E7UbIF2/nKq809B4
         VXQrJ6YMyjVuIBkt4fMZU3N2AoqfFD6GoGKK0V9hkIf9NbSOd3hPuzIQiVNPTaadfbxs
         OFLg==
X-Gm-Message-State: AOJu0YyTZffGSG2DbV0Zi3HfyW/YUqFNF99hbTQSaO7nradsMuahS9NU
	z3bVWoCfdY7kZJORUjpRTxSLdYE+o0k8956pKAhynvGZLJ3nZlpbM7K3cCbuMat4
X-Gm-Gg: AeBDievaV9ghe8bWQnB1Z64llQxNMiMkAcWkxUnA7k6z/iFCzdCvuUgnadR8s1sIjOZ
	qHJFk6D3ecnmH83qXkdOeJKhlLAP5+whFju/kauVvRmREDRmR7IHSzwYDdl9k1ly5II+LuclGid
	I3/Dpq7sL5D9Kx3SejTP6pc/zOyIblmMJEbOTQZmgVWzI4pT/ernwXQfIwkEDepVY7VqJhPpjIb
	7V8WIpXyGcvbVHnzfv3KXjS0axQWicwSTciimxF1aWFZbp+qMX5bFbPEv7q9i12JNfCgzc1Czxn
	9x8UWYa909fOnxSTlGx1pWsKCmwiEMCRqayNc2tIXHnCdwecTTi515CbxrRRxetNhgtJwXPqDHQ
	yVcrqJR0HH7IYBHnwudWsJFa3jyPg3FWC4kgg3fAwL6D5bNklbfb2TzJO2WfSDrtK9XzXvKw3Bd
	yLwSGGGJrV/OjOnrYJOBwQE/Nb0n3tByfPxv95
X-Received: by 2002:a05:6402:350f:b0:66e:b997:2b61 with SMTP id 4fb4d7f45d1cf-66eb9975d30mr1357163a12.18.1775405337142;
        Sun, 05 Apr 2026 09:08:57 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e02f389absm3195890a12.13.2026.04.05.09.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 09:08:56 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sun, 05 Apr 2026 19:08:40 +0300
Subject: [PATCH v2 3/6] iio: light: vcnl4000: drop enum id table in favor
 of chip structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-vcnl4000-drop-enum-v2-3-7c8dc98c3974@gmail.com>
References: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
In-Reply-To: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
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
index 604e7412bea7..bbb84b71f226 100644
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
@@ -2079,14 +2058,14 @@ static int vcnl4000_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id vcnl_4000_of_match[] = {
-	{ .compatible = "capella,cm36672p", .data = (void *)CM36672P, },
+	{ .compatible = "capella,cm36672p", .data = &cm36672p_spec, },
 	/* Capella CM36686 is fully compatible with Vishay VCNL4040 */
-	{ .compatible = "capella,cm36686", .data = (void *)VCNL4040, },
-	{ .compatible = "vishay,vcnl4000", .data = (void *)VCNL4000, },
-	{ .compatible = "vishay,vcnl4010", .data = (void *)VCNL4010, },
-	{ .compatible = "vishay,vcnl4020", .data = (void *)VCNL4010, },
-	{ .compatible = "vishay,vcnl4040", .data = (void *)VCNL4040, },
-	{ .compatible = "vishay,vcnl4200", .data = (void *)VCNL4200, },
+	{ .compatible = "capella,cm36686", .data = &vcnl4040_spec, },
+	{ .compatible = "vishay,vcnl4000", .data = &vcnl4000_spec, },
+	{ .compatible = "vishay,vcnl4010", .data = &vcnl4010_spec, },
+	{ .compatible = "vishay,vcnl4020", .data = &vcnl4010_spec, },
+	{ .compatible = "vishay,vcnl4040", .data = &vcnl4040_spec, },
+	{ .compatible = "vishay,vcnl4200", .data = &vcnl4200_spec, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);
@@ -2127,6 +2106,18 @@ static int vcnl4000_runtime_resume(struct device *dev)
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

