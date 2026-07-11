Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC782DC321
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783750500; cv=none; b=BodUhZLwa6Hl/BRkLmCJXGUAAalianZUcYEW/mM1+zHeQgkm8yJzUJqr0hkuRFcGLvyosDVgvzfMdIEGaRUxBfr/9fKhxfjO5wfQeuDmu+rbqSOPzlMeVt2/w9qq3ncE5kxjBmWKKFaKb4NTAAgs5AKVWQWxPDLF2f/RtoFJW/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783750500; c=relaxed/simple;
	bh=Dt2McddnuMrKbEBasU+CodMhNZI4YbUKvzbXXcjZPq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PqeLi8v7hqbuJYTE9n8pXeaX+d5NxdbqGXA1UffrL0vusA4agE7mvoJ2Gbs/j5QZUonI2Rb4Ddxujpry+5/j5Q4OTyjZ0297uPJpBzP/Wwd/AsCTmhYarzNbLf4sXL4WC/sLXkEb+3K+oDMNMXlKo3VI6CmneVEvNa8UUwxhSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4pCblNp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4pCblNp"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b7612475so13268725e9.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783750497; x=1784355297; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WyQMHFX4gASHzVhLS9z0EW0RqD5Wshc7uaJzjeKpyBM=;
        b=a4pCblNpQk3Bcy6d0nnUiosGLwqN/ST0CJJOfdzf/1UmqJioj09JXfZnYfDEVjdz9e
         y/QAynbvy5c0fTXf97GEWw78vLoJMfVvNeCCUSKk/6QSyJVvY9vBinqa+bLocX5ttX9f
         +K3D/6LJg4CAoP1blmbw4toEeVAZdr+d5P3qlPJPu0cIyqHMjxTK36UQtdgL9YS607cH
         MKl8Y4kzU2dB/IAVIk1d73mJRwHtuG/+1QwGuTxY+U0o6TWD+Ws4YAovg/Je9AwX2CU8
         ckL2V3XK7vQXPIxGU0SVSkIjWqpb+YRv8J65npdk9cWwbscW/TpC7HiRv1UElRTjXPoJ
         6EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783750497; x=1784355297;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WyQMHFX4gASHzVhLS9z0EW0RqD5Wshc7uaJzjeKpyBM=;
        b=AcNoc1uOLUttIUoKc1WkSq4/G82IX0HssQ+9iXss/N+hsBdFbULUTUjb0zmA38eT3V
         DXSfXj8KBirSSALMDpgsHRsnJ9O4moB2puHrDxEjkDxOaXc+fjK9A1nlV9hQlOvLiMez
         aXJpNx+mBOFqWv9/T5L+ZSZsI3DTfkKItKXRgjc6vRIvyqHtiLUWMZPLnm6MAom9Aziv
         +LUHoBqyV68zeD+DyW5MaLLeJwvq/3AlNOeOQN88PzValI/cfI0qlakifz2Tk0sJ0rIl
         NNobxvcYjc8/Bb6Nu4uXcqk2JYttXSFjJcIFraRbZaPnlg1Ds1U99YBcM+8PFjJO2SSJ
         u/uw==
X-Gm-Message-State: AOJu0YzAI1bT2lwaR6wnIA5XM2TJG8flqaSFjeO00qag7GsF8IiSD4TW
	CWIIpCXP/PJ/vAyHIHrUkhPqYVKNurQ4xN4cBzyeHyRpRQP/ELWWh472
X-Gm-Gg: AfdE7cl2/HWde3SG5RREs4R1C9VErV3BLh0yaP/AwSEVtdLvPFlRao78WGlKJvM4W/X
	puwi2dpMq8RMSXEuiH+Uz48so+tDR8jZQoABMGzivjOzMM23fNnBuDq8HxPvDYo7yq0Cak/rTRX
	JOTSYd+x0LHXLNdvl5MzZL1Y1ycTpV/ATXIP+AEVUfT6FEoS9Mv4kv1awl4cDseeP0iwkNUNj5i
	tGaM/ZzbhS7n1l1TiHWdG8p7wBXn5CNPbUkwhwmWHNeqmQl36i5bTCdgfIqM53Pf4qg6C428yYD
	MwywmaZ8r1RZrDd8LxEZ/TYXK2osYj5u4y5fs/Ym6zVP97LMjx26iSgovATKmveT6RUIwM3t5jZ
	bO5DWQ+/RUTaXIaQWJuug7qy8b+8Jq5tNvJQIhHt0Lnt9ji/uwTvgKWv7tYP8/H6Oib+qKWsyaP
	RRwH+S3Z38JU180Y3t0hscnaxu88QpADDMRNTGW1K+JGHc5zLR6SmppeqbwutNoMkZoMOWVbcDr
	2L0yyco4wOpexJQD37UmgkM6IVEPVGOpVSSkm8utyUeWGYrMv2QtmGVzSd6V8eTmRCNG2tHYQp3
	zpcKncFpK/nGp4S5VNUuVG/1PB7943vO4Ywsbq/o5PNfyFKYIG0U+itrJJv2DAgW
X-Received: by 2002:a05:600c:190f:b0:493:adcb:d368 with SMTP id 5b1f17b1804b1-493f87e9aa1mr15683975e9.9.1783750497363;
        Fri, 10 Jul 2026 23:14:57 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f49755f9sm101453365e9.8.2026.07.10.23.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 23:14:57 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 11 Jul 2026 08:14:54 +0200
Subject: [PATCH v2] iio: light: opt3001: split opt3001_get_processed()
 logic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-opt3001-unwind-cleanup-v2-1-47f617e00c65@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr2Jmbc20hCquvIdhUdoBJoGWtIAaw
 t2tXMDle8l/f4NEkSnB/bRBpJUTB59BnU9ge+M7Euwyg0Kl8Yo3Eaa5QJRi8S/2TtiBjF8mURk
 iR4UudVlCHk+RWn4f4Weduec0h/g5flb5s3+TqxRSVIiNsq1zjTaPbjQ8XGwYod73/QsD3G7pv
 AAAAA==
X-Change-ID: 20260708-opt3001-unwind-cleanup-9aeede365655
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783750496; l=8030;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=Dt2McddnuMrKbEBasU+CodMhNZI4YbUKvzbXXcjZPq8=;
 b=pV9DvZ5YJA/xSr+SjahlOWCeYCyjjLk4QWMtFVHPMWcNgiSPSa31vHWNKz0zA0Ckog/34X66O
 R/UidHj2sORB8X59TvKUVZN7NkNNFsNJA2MGyJoqmtpLYrs3InjMyX7
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
Changes in v2:
- Remove ternary operator and add if/else
- Remove timeout variable
- Link to v1: https://lore.kernel.org/r/20260708-opt3001-unwind-cleanup-v1-1-900b2cfddb6a@gmail.com
---
 drivers/iio/light/opt3001.c | 197 ++++++++++++++++++++++++++------------------
 1 file changed, 118 insertions(+), 79 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 2bce6cd5f4e4..d1a2426cd355 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -316,36 +316,33 @@ static const struct iio_chan_spec opt3002_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
-static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
+static int opt3001_get_processed_irq(struct opt3001 *opt, int *val, int *val2)
 {
 	struct i2c_client *client = opt->client;
 	struct device *dev = &client->dev;
-	int ret;
 	u16 mantissa;
-	u16 reg;
 	u8 exponent;
 	u16 value;
-	long timeout;
+	u16 reg;
+	int ret;
 
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
+	/*
+	 * Enable the end-of-conversion interrupt mechanism. Note that
+	 * doing so will overwrite the low-level limit value however we
+	 * will restore this value later on.
+	 */
+	ret = i2c_smbus_write_word_swapped(client,
+					   OPT3001_LOW_LIMIT,
+					   OPT3001_LOW_LIMIT_EOC_ENABLE);
+	if (ret < 0) {
+		dev_err(dev, "failed to write register %02x\n",
+			OPT3001_LOW_LIMIT);
+		return ret;
 	}
 
+	/* Allow IRQ to access the device despite lock being set */
+	opt->ok_to_ignore_lock = true;
+
 	/* Reset data-ready indicator flag */
 	opt->result_ready = false;
 
@@ -367,70 +364,33 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 		goto err;
 	}
 
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
+	ret = wait_event_timeout(opt->result_ready_queue,
+				 opt->result_ready,
+				 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
+	if (ret == 0)
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
+	 * Disable the end-of-conversion interrupt mechanism by
+	 * restoring the low-level limit value (clearing
+	 * OPT3001_LOW_LIMIT_EOC_ENABLE). Note that selectively clearing
+	 * those enable bits would affect the actual limit value due to
+	 * bit-overlap and therefore can't be done.
+	 */
+	value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
+	ret = i2c_smbus_write_word_swapped(client,
+					   OPT3001_LOW_LIMIT,
+					   value);
+	if (ret < 0) {
+		dev_err(dev, "failed to write register %02x\n",
+			OPT3001_LOW_LIMIT);
+		return ret;
 	}
 
 	exponent = OPT3001_REG_EXPONENT(opt->result);
@@ -441,6 +401,85 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 	return IIO_VAL_INT_PLUS_MICRO;
 }
 
+static int opt3001_get_processed_noirq(struct opt3001 *opt, int *val, int *val2)
+{
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
+	u16 mantissa;
+	u8 exponent;
+	int ret;
+	u16 reg;
+
+	/* Reset data-ready indicator flag */
+	opt->result_ready = false;
+
+	/* Configure for single-conversion mode and start a new conversion */
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_CONFIGURATION);
+		goto err;
+	}
+
+	reg = ret;
+	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SINGLE);
+
+	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
+	if (ret < 0) {
+		dev_err(dev, "failed to write register %02x\n",
+			OPT3001_CONFIGURATION);
+		goto err;
+	}
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
+		goto err;
+	}
+
+	if (!(ret & OPT3001_CONFIGURATION_CRF)) {
+		ret = -ETIMEDOUT;
+		goto err;
+	}
+
+	/* Obtain value */
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
+	if (ret < 0) {
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_RESULT);
+		goto err;
+	}
+
+	opt->result = ret;
+	opt->result_ready = true;
+
+err:
+	if (ret < 0)
+		return ret;
+
+	exponent = OPT3001_REG_EXPONENT(opt->result);
+	mantissa = OPT3001_REG_MANTISSA(opt->result);
+
+	opt3001_to_iio_ret(opt, exponent, mantissa, val, val2);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
+{
+	if (opt->use_irq)
+		return opt3001_get_processed_irq(opt, val, val2);
+
+	return opt3001_get_processed_noirq(opt, val, val2);
+}
+
 static int opt3001_get_int_time(struct opt3001 *opt, int *val, int *val2)
 {
 	*val = 0;

---
base-commit: fef4337eb2888c758c7058e1723903204f012a26
change-id: 20260708-opt3001-unwind-cleanup-9aeede365655

Best regards,
-- 
Kind regards

CJD

