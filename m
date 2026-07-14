Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1323644A4
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043419; cv=none; b=MLcS6j6YYwMq2hKiBZrJTg+raBTR6M2O/olnCYVqB7LGiXixMwR5KWchq05uRa/MR33QjeIZHJXax3Oc6eJ1wvnedzTMEOyuPR+fLiGZNGKGB/SKwedTD93UPmtQMJJ/oNVc1Tjkbr2A65T/IHauJE250v1OnSQua82fEvR/AJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043419; c=relaxed/simple;
	bh=FUKRz5QZbEpD2ppSUUSJKph2gxfJRcgreInDDRklvQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=auP9VGOSXXHI/U6OFv/96iYC4nDw6d6wC3k0vF1PMNYbhpadu6abZdaVXdscsijmRsLIhHKEuwO68G2/IXuCq49evCVKGqfjM20CjkS5NykqcccV5geoJmicBGsVlAGMW34X0ggB1MIalPwVRkFNG3ek6Xv68GZRQ2OPca9IS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F93kF1UL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F93kF1UL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c7902f47so40074075e9.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784043415; x=1784648215; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yFqzpW0R11/PPWKTn87rkaqLDktCu2fOc1hLjHnrcEc=;
        b=F93kF1ULnWBzz6LEBp3Y6NJ4vRPY+ApI5P9zC6IUlAKW7h1VYiO/UJ68cWqp3QBH8c
         45R7hC7UyZtD1x3Rf8AX224zNCn/So1iiLi32M0BuIpXbSTE8UjhRB77Xy2dj18XiSdk
         CUUPSkuOvjwRd1loCSi4hGRMB0Qbpa6K2peW2reFsgAsy9CC6V4OfWYtXmQuRcyDeKgY
         yRqOjcKKgzNVAg4eudXsRGfWhuVsmjzsBIIpOYf9SvUfHlB6oEJBLjGPVb1Nz1hL7wKT
         9GmU7sKz/DxGinWzB0WSBHvz3mvcorHx3G+NRGYyB6IBzvcG+BwvIsd7/mBTzkylONni
         fPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784043415; x=1784648215;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yFqzpW0R11/PPWKTn87rkaqLDktCu2fOc1hLjHnrcEc=;
        b=YI0tLUg2STuMHjJAiZ40EZOVDrFQ+kt9xvOFEED7DOzd8RUB5ecmtH+xt5g0XZUq5y
         JJI/GVpCCB9wDotmn23oPnbMUrj855tUoTMEf3paQmU55iS58wNiLd2kfFIevsCoVrs4
         ONIMMGZJlX858ZVTw1PI0RRNEbBx55lN0M+Ao8AFg5gKFjfpXDeAX0bmh+1zyuaxOmTy
         hagzWhHFml03yRI0c0jEMSyuZKZXyzYA9nIOJvSFvRBMAVMfxlY0eUtULFPrIYk0XIQi
         S31XOIU+mW8kigR6LMRWs9Bg5sUTOSSqDf3dnRg264JFju5Lox3U3uP3KOmrtiYQDZk7
         +sOg==
X-Gm-Message-State: AOJu0Ywxwv9PUcm8FiVITe7yATZSk/oIczJm49mDunfLBvw4jdW8Wtzf
	5qQFqbjTQ9wuDIVuI/yxH27ioiGzSqLld+YW0a0mbHp6zu5jvHnPHKX2
X-Gm-Gg: AfdE7clzxaaqhybP6G/KF1qMe1A2l0DhuEutM63LeKvYJfA5eVfdDSg0mBI2KEZNmB9
	nKDDsz+USIi1ujyutqs1F/cVi1JFbg+PB29RH5Qq2y+XE4vJJ4e3VQ2U/Kiu0NNDhi6lUb1pLI0
	xXvEEjcsRJAZDJdD8q0wa7OWUC2UalswKy1exHfmftguYU3cCj6AY+Cq0ZhtqY4lNF9lVc7qEFF
	UvEjQza9PjfGoJRuj5PAu5LAR1A/3GDGwetNMe4SkA9wUbKvfHsAWZl7w0uF+53f7oYNg+Kd7uV
	dd0EVRhJhHYeIm709tynIOhbvq/jX9JbxFoTppXs/Wc0i/52LHqnIHj/ROwbzSg4q8vij7x22Sh
	DIkg6Aydun36f2Q770W/yZQdxGKV4rFpynMeJNLCLPjdqH4XJibbf+9C5nmoYUjVXp3lCO/5nl+
	U24N4kEnpU1cpdG2lVfhGlD1mE1aixbU/IXGAnWaM4ZQxJbdE5928H5saDKSkBFJC0u4/LmgEqf
	sx52r0m0RBXSnEoCa6pOp1QdmuktxyuiYcWvVObddlx9MA2Ae5Cq8HyzoexPyTqcIlCCI3efPgq
	9I4CoO4FDsjmxPHfYcSUYr7Lp3BSddmiV7AG0H09koGkIK36EgBIKg==
X-Received: by 2002:a05:600c:3143:b0:493:b87c:c87d with SMTP id 5b1f17b1804b1-493f87e9f43mr142113605e9.11.1784043415131;
        Tue, 14 Jul 2026 08:36:55 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464b7e22sm8964103f8f.25.2026.07.14.08.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 08:36:54 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 14 Jul 2026 17:36:48 +0200
Subject: [PATCH v4] iio: light: opt3001: split opt3001_get_processed()
 logic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-opt3001-unwind-cleanup-v4-1-7ebea805bfac@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNTQqDMBCG4atI1k2ZJCZqV71H6SImowY0in9tE
 e/e6EoK0uX7wTyzkAF7hwO5RQvpcXaDa32I+BIRU2lfInU2NOHAFSSQ0rYbBQCjk385b6mpUfu
 po5lGtCiUVFKScNz1WLj3Dj+eoSs3jG3/2f/MbFv/kjOjjGYAOTeFtbnS97LRrr6atiEbOfMDw
 9gpwwMTJ4ViCQIYJX8ZcWT4KSMCIwsthEoTlUN6ZNZ1/QLeyVTNSgEAAA==
X-Change-ID: 20260708-opt3001-unwind-cleanup-9aeede365655
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784043414; l=8125;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=FUKRz5QZbEpD2ppSUUSJKph2gxfJRcgreInDDRklvQw=;
 b=6OEgFUke56iApxZ/GuMw0cqpKQm7j56FLGSu04VgsrpBCnV31v3TbAoFDOqztDkfL7c8biahf
 wU5Y76GFsIKBG9pzIoyCVJnRpeRBNohzxZM09jLJDVTUNlsKVc4oAY/
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Split the logic inside the opt3001_get_processed() function, as the
current flow is hard to read, mixing IRQ and non-IRQ code blocks.

Separate the IRQ code path into its own function, same for the
non-IRQ path.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
This patch fixes the absolutely horrible code flow in the
opt3001_get_processed() function, where the original implementation
used checks whether IRQ mode is enabled to execute blocks of code,
making the function hard to read. Ideas on how to improve the functions
are more than welcome.

Originally suggested by Jonathan Cameron.
---
Changes in v4:
- Simplify error checks and end of functions (Andy)
- Refactor timeout check (Andy)
- Link to v3: https://lore.kernel.org/r/20260712-opt3001-unwind-cleanup-v3-1-5fa336876b08@gmail.com

Changes in v3:
- Move duplicated code blocks to common functions (David)
- Change wrapping of comments and function call (Jonathan)
- Link to v2: https://lore.kernel.org/r/20260711-opt3001-unwind-cleanup-v2-1-47f617e00c65@gmail.com

Changes in v2:
- Remove ternary operator and add if/else (Andy)
- Remove timeout variable (Andy)
- Link to v1: https://lore.kernel.org/r/20260708-opt3001-unwind-cleanup-v1-1-900b2cfddb6a@gmail.com
---
 drivers/iio/light/opt3001.c | 192 ++++++++++++++++++++++++--------------------
 1 file changed, 106 insertions(+), 86 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 434ef7e034fe..12cfb0e58870 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -315,35 +315,12 @@ static const struct iio_chan_spec opt3002_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
-static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
+static int opt3001_start_conversion(struct opt3001 *opt)
 {
 	struct i2c_client *client = opt->client;
 	struct device *dev = &client->dev;
-	int ret;
-	u16 mantissa;
 	u16 reg;
-	u8 exponent;
-	u16 value;
-	long timeout;
-
-	if (opt->use_irq) {
-		/*
-		 * Enable the end-of-conversion interrupt mechanism. Note that
-		 * doing so will overwrite the low-level limit value however we
-		 * will restore this value later on.
-		 */
-		ret = i2c_smbus_write_word_swapped(client,
-						   OPT3001_LOW_LIMIT,
-						   OPT3001_LOW_LIMIT_EOC_ENABLE);
-		if (ret < 0) {
-			dev_err(dev, "failed to write register %02x\n",
-				OPT3001_LOW_LIMIT);
-			return ret;
-		}
-
-		/* Allow IRQ to access the device despite lock being set */
-		opt->ok_to_ignore_lock = true;
-	}
+	int ret;
 
 	/* Reset data-ready indicator flag */
 	opt->result_ready = false;
@@ -353,85 +330,128 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 	if (ret < 0) {
 		dev_err(dev, "failed to read register %02x\n",
 			OPT3001_CONFIGURATION);
-		goto err;
+		return ret;
 	}
 
 	reg = ret;
 	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SINGLE);
 
 	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dev, "failed to write register %02x\n",
 			OPT3001_CONFIGURATION);
+
+	return ret;
+}
+
+static int opt3001_get_processed_irq(struct opt3001 *opt)
+{
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
+	u16 value;
+	int ret;
+
+	/*
+	 * Enable the end-of-conversion interrupt mechanism. Note that doing so
+	 * will overwrite the low-level limit value however we will restore this
+	 * value later on.
+	 */
+	ret = i2c_smbus_write_word_swapped(client,
+					   OPT3001_LOW_LIMIT,
+					   OPT3001_LOW_LIMIT_EOC_ENABLE);
+	if (ret < 0) {
+		dev_err(dev, "failed to write register %02x\n",
+			OPT3001_LOW_LIMIT);
+		return ret;
+	}
+
+	/* Allow IRQ to access the device despite lock being set */
+	opt->ok_to_ignore_lock = true;
+
+	ret = opt3001_start_conversion(opt);
+	if (ret)
 		goto err;
-	}
 
-	if (opt->use_irq) {
-		/* Wait for the IRQ to indicate the conversion is complete */
-		ret = wait_event_timeout(opt->result_ready_queue,
-					 opt->result_ready,
-					 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
-		if (ret == 0) {
-			ret = -ETIMEDOUT;
-			goto err;
-		}
-	} else {
-		/* Sleep for result ready time */
-		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
-			OPT3001_RESULT_READY_SHORT : OPT3001_RESULT_READY_LONG;
-		msleep(timeout);
-
-		/* Check result ready flag */
-		ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
-		if (ret < 0) {
-			dev_err(dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
-			goto err;
-		}
-
-		if (!(ret & OPT3001_CONFIGURATION_CRF)) {
-			ret = -ETIMEDOUT;
-			goto err;
-		}
-
-		/* Obtain value */
-		ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
-		if (ret < 0) {
-			dev_err(dev, "failed to read register %02x\n",
-				OPT3001_RESULT);
-			goto err;
-		}
-		opt->result = ret;
-		opt->result_ready = true;
-	}
+	if (wait_event_timeout(opt->result_ready_queue, opt->result_ready,
+			       msecs_to_jiffies(OPT3001_RESULT_READY_LONG)))
+		ret = 0;
+	else
+		ret = -ETIMEDOUT;
 
 err:
-	if (opt->use_irq)
-		/* Disallow IRQ to access the device while lock is active */
-		opt->ok_to_ignore_lock = false;
+	opt->ok_to_ignore_lock = false;
 
 	if (ret < 0)
 		return ret;
 
-	if (opt->use_irq) {
-		/*
-		 * Disable the end-of-conversion interrupt mechanism by
-		 * restoring the low-level limit value (clearing
-		 * OPT3001_LOW_LIMIT_EOC_ENABLE). Note that selectively clearing
-		 * those enable bits would affect the actual limit value due to
-		 * bit-overlap and therefore can't be done.
-		 */
-		value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
-		ret = i2c_smbus_write_word_swapped(client,
-						   OPT3001_LOW_LIMIT,
-						   value);
-		if (ret < 0) {
-			dev_err(dev, "failed to write register %02x\n",
-				OPT3001_LOW_LIMIT);
-			return ret;
-		}
+	/*
+	 * Disable the end-of-conversion interrupt mechanism by restoring the
+	 * low-level limit value (clearing OPT3001_LOW_LIMIT_EOC_ENABLE). Note
+	 * that selectively clearing those enable bits would affect the actual
+	 * limit value due to bit-overlap and therefore can't be done.
+	 */
+	value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
+	ret = i2c_smbus_write_word_swapped(client, OPT3001_LOW_LIMIT, value);
+	if (ret < 0)
+		dev_err(dev, "failed to write register %02x\n",
+			OPT3001_LOW_LIMIT);
+
+	return ret;
+}
+
+static int opt3001_get_processed_noirq(struct opt3001 *opt)
+{
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
+	int ret;
+
+	ret = opt3001_start_conversion(opt);
+	if (ret)
+		return ret;
+
+	if (opt->int_time == OPT3001_INT_TIME_SHORT)
+		msleep(OPT3001_RESULT_READY_SHORT);
+	else
+		msleep(OPT3001_RESULT_READY_LONG);
+
+	/* Check result ready flag */
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_CONFIGURATION);
+		return ret;
 	}
 
+	if (!(ret & OPT3001_CONFIGURATION_CRF))
+		return -ETIMEDOUT;
+
+	/* Obtain value */
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
+	if (ret < 0) {
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_RESULT);
+		return ret;
+	}
+
+	opt->result = ret;
+	opt->result_ready = true;
+
+	return 0;
+}
+
+static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
+{
+	u16 mantissa;
+	u8 exponent;
+	int ret;
+
+	if (opt->use_irq)
+		ret = opt3001_get_processed_irq(opt);
+	else
+		ret = opt3001_get_processed_noirq(opt);
+	if (ret)
+		return ret;
+
 	exponent = OPT3001_REG_EXPONENT(opt->result);
 	mantissa = OPT3001_REG_MANTISSA(opt->result);
 

---
base-commit: 2e2f2de7532cbbc2269de8be20ec709606c6e79b
change-id: 20260708-opt3001-unwind-cleanup-9aeede365655

Best regards,
-- 
Kind regards,
Joshua Crofts

