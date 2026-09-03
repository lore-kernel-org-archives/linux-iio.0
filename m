Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E157137F307
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 04:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411271; cv=none; b=nYZzmYYSvSv8Hn47H4CMn7DXOtZ2n0w+BYlZJeAyfoiH52CO/wTWzRc+APbVka3hI/5YATgVOuaq+/P1lrvy4fxPiYIAqOv35vpQ56MBZE2WzLNlV8Achm+yFFGXXB79x6jFmoMLZVuw9nCgbQah2qGmiVaTBfYNYhxW2Vj4xZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411271; c=relaxed/simple;
	bh=0RCbxmfE0LDuYQWLscku9kxsP8ZuobBC4DjCMkP9Vy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=anlWUJP+gaxSG57L00QH8r/6Z8X6YJr4RKVHCS5q75xfc6EqVrBDkiyPPucQRth/S71tyiTBRibbqB7YTfDuF/snUXPNOQIJq5Dk1On5x3S5t+4C/BVHPCB6w0Qhr59cgp0B12hKK94LZOs744Q15ejdXMNAisaoPDw8VOqVgt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POCgk0nt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POCgk0nt"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1790260a91.2
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 21:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411269; x=1789016069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ImX6Rvm3vbsJZJLLrx74I6kO9MORDO3uU8EKdO+wQ+I=;
        b=POCgk0ntVvyYrpxXmMdh5B1lj+266WujHmTAZnKznKXh4um+JRCrOYy6ebtuEivAqM
         Mhb2rN/KB/NVZpTeqmiK3G1tF8l3gsJVsVmsxrP4Ga46zDa97oAhDckpryWopyMvUNbV
         mBpWfLOpdBo8lLBLQu1CIH+6m7XD64n5Ir5t9Nh3PlKsiKt8NtYyDEBikvfMakVxyNXg
         UJ+K9aYPXzyYKZOZzsnYIflUZ1/0merb3VVrVS40FuLJwqLccaaULSjK+/OIneWTqyjv
         u0swCeEBeDtGL6VNqU97D4DBepSPT1C8vL6uFOyseEneAZ/Niv+nvkXvLUrKytyZkbvV
         HQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411269; x=1789016069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ImX6Rvm3vbsJZJLLrx74I6kO9MORDO3uU8EKdO+wQ+I=;
        b=ikcVa4UqCVjsklOB1jLSVqVbEF+qvJUd5yOjUVuzCvIg7mBQ2qxCq7pM10j2sUANh7
         g+Bvcaa6blwHwEOhYUric7Jos8Qhy8pD08AhTfZ7GY/ZJyFAO+INtG8kyMkyDM9HTEir
         NTOTQng1QSA8XjrqhzPUk7//EDlDxtUN8E2lPz0gx17WhPRJ8ep9Nw9KcLO1NcazCbQf
         bfHeGVT+C7Ap9erBzo2jHdmSQPW+rGtW3q019M+lfOaU7DmuwziIWYJlbvZpzEWzjDNG
         qoJc0BKK/DhjecswAEFjAt6cfOU+zhPfEMTJMAHE4AbJEsf4J8pR2QcOYlFd2/1u+4lK
         BYfA==
X-Gm-Message-State: AFuF++k2bfDmOZ9ThEyOT1DV4GlhPcCcHIKfdquFvKk+GTUd0n7fxhbD
	3zObUKJ8YS5fWQQ1bgTB1T6+CM6ZMAv3vPEYBesJboJwXXvp8h7U6Cbh
X-Gm-Gg: AYBFou00uz1N7iRXR+3M40N4aQ5zzOnjbsPWvGRhWO6t4BjvdId+iZcU2lGpM9bPfUk
	ztqMEn8+KrjZN4Ppv1rPblp6G5R9I4swgky6Z1D9FWnebpFEK8x39uo2lVvNRwxQPGkYklGTlyU
	/21WcemxguYHIazyhV9bKepercKhYBav8CuTwvnGNU0ayVM/b0QrUXoR4Zyrdoph2Lh/BoMIiyG
	BCjywDi1NU6RQdhLKIrCTVmsuyluPUNapptawvT3GznEKn6Bc31XVqQYswdvDS1ifAS4WdB5wZW
	94kTpZkzLnKvli3pqeEA+BvG4RwLika16WiBhizPAwwReWmkiMUrIOwExq8MwfAfT6LdMLBjsvI
	8KAf9uRJau8Ew7Z1Mp68w/wksyc7PbfjiEO3qE+lNkpt8YIfXMqRUqmJX76AlCmIwNR3jRdKnb6
	iBZWG4nAVVJq0CK/wo7IOJp2ikF7Ef1dOYu5MBe/XomYSXgWnbSfVS6E0Gatb1juZJ1Q==
X-Received: by 2002:a17:90b:17cf:b0:398:d286:344d with SMTP id 98e67ed59e1d1-39aee178e92mr14420581a91.22.1788411269177;
        Wed, 02 Sep 2026 21:54:29 -0700 (PDT)
Received: from [192.168.20.42] ([115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8f1cf6dsm2300801a91.3.2026.09.02.21.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 21:54:28 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Date: Thu, 03 Sep 2026 14:53:49 +1000
Subject: [PATCH v3 4/5] iio: light: vcnl4000: Add IRQ disable callback on
 cleanup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-vcnl4000-v3-4-5e69c2e715a8@jacques.com.au>
References: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
In-Reply-To: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

During driver unbind, devm cleans up resources in LIFO order. The IRQ
handler is freed before the device is powered down. This can lead to
unhandled interrupts.

Register a devm action to disable interrupt explicitly after
devm_request_threaded_irq(), so that the interrupt is disabled before
the IRQ handler is freed. This prevents any unhandled interrupts.

Add a disable_irq callback to chip info structure. This allows each chip
type to implement its own disable sequence.

Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
 drivers/iio/light/vcnl4000.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index f77b219c46e4..df929eab2bef 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -217,6 +217,7 @@ struct vcnl4000_chip_spec {
 	int (*measure_light)(struct vcnl4000_data *data, int *val);
 	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
 	int (*set_power_state)(struct vcnl4000_data *data, bool on);
+	int (*disable_irq)(struct vcnl4000_data *data);
 	irqreturn_t (*irq_thread)(int irq, void *priv);
 	irqreturn_t (*trig_buffer_func)(int irq, void *priv);
 
@@ -1466,6 +1467,48 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
+static int vcnl4010_disable_irq(struct vcnl4000_data *data)
+{
+	int ret;
+
+	guard(mutex)(&data->vcnl4000_lock);
+
+	ret = vcnl4010_stop(data);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
+	if (ret < 0)
+		return ret;
+
+	ret &= VCNL4010_INT_THR | VCNL4010_INT_DRDY;
+	if (!ret)
+		return 0;
+
+	return i2c_smbus_write_byte_data(data->client, VCNL4010_ISR, ret);
+}
+
+static int vcnl4040_disable_irq(struct vcnl4000_data *data)
+{
+	int ret;
+
+	guard(mutex)(&data->vcnl4000_lock);
+
+	ret = vcnl4040_update_ps_int(data, VCNL4040_PS_CONF2_PS_INT, false);
+	if (ret < 0)
+		return ret;
+
+	ret = vcnl4040_update_als_int(data, VCNL4040_ALS_CONF_INT_EN, false);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(data->client, data->chip_spec->int_reg);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
@@ -1815,6 +1858,7 @@ static const struct vcnl4000_chip_spec cm36672p_spec = {
 	.init = vcnl4200_init,
 	.measure_proximity = vcnl4200_measure_proximity,
 	.set_power_state = vcnl4200_set_power_state,
+	.disable_irq = vcnl4040_disable_irq,
 	.channels = cm36672p_channels,
 	.num_channels = ARRAY_SIZE(cm36672p_channels),
 	.info = &vcnl4040_info,
@@ -1843,6 +1887,7 @@ static const struct vcnl4000_chip_spec vcnl4010_spec = {
 	.measure_light = vcnl4000_measure_light,
 	.measure_proximity = vcnl4000_measure_proximity,
 	.set_power_state = vcnl4000_set_power_state,
+	.disable_irq = vcnl4010_disable_irq,
 	.channels = vcnl4010_channels,
 	.num_channels = ARRAY_SIZE(vcnl4010_channels),
 	.info = &vcnl4010_info,
@@ -1858,6 +1903,7 @@ static const struct vcnl4000_chip_spec vcnl4040_spec = {
 	.measure_light = vcnl4200_measure_light,
 	.measure_proximity = vcnl4200_measure_proximity,
 	.set_power_state = vcnl4200_set_power_state,
+	.disable_irq = vcnl4040_disable_irq,
 	.channels = vcnl4040_channels,
 	.num_channels = ARRAY_SIZE(vcnl4040_channels),
 	.info = &vcnl4040_info,
@@ -1877,6 +1923,7 @@ static const struct vcnl4000_chip_spec vcnl4200_spec = {
 	.measure_light = vcnl4200_measure_light,
 	.measure_proximity = vcnl4200_measure_proximity,
 	.set_power_state = vcnl4200_set_power_state,
+	.disable_irq = vcnl4040_disable_irq,
 	.channels = vcnl4040_channels,
 	.num_channels = ARRAY_SIZE(vcnl4040_channels),
 	.info = &vcnl4040_info,
@@ -1912,6 +1959,21 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 	return devm_iio_trigger_register(&client->dev, trigger);
 }
 
+static void vcnl4000_disable_irq_action(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct vcnl4000_data *chip = iio_priv(indio_dev);
+	struct device *dev = &chip->client->dev;
+	int ret;
+
+	if (!chip->chip_spec->disable_irq)
+		return;
+
+	ret = chip->chip_spec->disable_irq(chip);
+	if (ret)
+		dev_warn(dev, "Failed to disable interrupt(%pe)", ERR_PTR(ret));
+}
+
 static void vcnl4000_cleanup(void *data)
 {
 	struct iio_dev *indio_dev = data;
@@ -1995,6 +2057,11 @@ static int vcnl4000_probe(struct i2c_client *client)
 		ret = vcnl4010_probe_trigger(indio_dev);
 		if (ret < 0)
 			return ret;
+
+		ret = devm_add_action_or_reset(dev, vcnl4000_disable_irq_action,
+					       indio_dev);
+		if (ret)
+			return ret;
 	}
 
 	ret = devm_pm_runtime_set_active_enabled(dev);

-- 
2.55.0

