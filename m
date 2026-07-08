Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAC3C3453
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539221; cv=none; b=BSfyNvtCAqQnbC2KsRRTt617lcqIMrzD9ozKI3Uq1vMIjAfj7KnW3u8e3Bz5oRaxYWJyryU0se4nlA8cxnSVLxm1lbdOJbb6NPtGLFA9wiR7ejFl+C0HpoBz2DtLH88MyNTQbNhIFHFRlOxmGtdtHWITuspolxL2HqrBlU2IyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539221; c=relaxed/simple;
	bh=dzJ0H++KOQilZd5rNkl8lB16HpmuYHtSjZpFq4x3xzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PE1Ir7GsIyt7BvLaJl/lNFK6SFGFhjmWrq10KrJ7+RzrS2wW20/sn7SI0zUP7s6WWmx+emz7oNMwqpxFsqO+593Q/Pp0kSzA2pOaXHmq6HKHUcw5AVkA4FPRYphblDFBfFtfwb8JGQSXMJXwwceCSoePJF0+aWWPtD0f6FVdsqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hChn3Hc0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hChn3Hc0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4629051c9d1so625395f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 08 Jul 2026 12:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783539218; x=1784144018; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gf/Ap7cWQ9f2bGDGctrMDT6wCSygD29oifzTpHVYBfs=;
        b=hChn3Hc0SQohCnkKr3hWjFCbosy7MdI0x59mVtbGXHXnxSNJ4eMLem7TKZUedq9rG3
         ZGhjPHEoyNl+ntbMdmiiYbQ3XSlwJ/FPoz9/OA6c7CArXdiqhPtJ1CyCtUznn1pAcCqe
         NtCOlnhqk/dlnTO0eX5IvgcwTeyXpDfEGwaxCD4SPDEAY/h422rpj9adcAxifRoCUwm5
         ecUjk+SMRO8d5+ZmJViUcbvGaRDGfVLTzzKjZvWvVYzvJMxOm1hvDpQLjN76X4SIY1J6
         FPH3L9eItBj1e6g7CKIH1+VGjMCG//j0HkuMPdBjWNKuC794LeZMIv4dxMllPdcShxDz
         theQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783539218; x=1784144018;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gf/Ap7cWQ9f2bGDGctrMDT6wCSygD29oifzTpHVYBfs=;
        b=LLWPNpwYF494pphEqHZG0Q6RvRtz096hpFsQVYHGJpwwONNMhYNCoXBejFslinLN3z
         HW53Tq8aGWTmYfj6OrDwKK/WkYKT129aXodObkrRXx/MLqm/ABdax6LmU5wMdXSeD44U
         92b2ktzXa8Io6cVx47I9Sj2R+cRfc3uW5GgS4tuagBk4rJtw33C2Ova3dgbt0gv0K/9m
         qCFJQ3a3BNzSMeFc0t5nghCIwtAyPLBn0wZA6kTYsMTJYauP7BNM3j35GP7O6o/MyBcS
         FVQQCaG/rTtdNofBnvL+2G+4YpN/W0yFnSJMvv466X4X5LgKB+sXq2boAejP2H5SuPWX
         wsTw==
X-Gm-Message-State: AOJu0YzWi6I1fxVCbT1tB7cYgKk+gkX4tqoKTQ2pU/nHVxE2EqyurWEX
	fuyEB2m3DMC+8rG4+y/mVwCtqoF0bV9h5hCwKNTv2a/OPeTUuKNOvEgv
X-Gm-Gg: AfdE7cksmafgCEZPJ3iJyz+Ha7mM+LBsBLodkWZyfd/i9EMVsk8Oetal9Wa3mA6YrS0
	5D9zzZxt/+imXffvEXwi0aoaxnCWMJpNnk7zp9tFhVrd+8+VjGGffCT0rQtY3R3fGe/LwENwrZ2
	CZ0Yot1CTXrUsldDR2Uv1vR4Lp750oMg+LR1Cv3eU5CW8srOrv9jri99D/evB2XTpb+nq7/yY96
	wfGBL+Y/dSdeCTlgOls4s4o42O47zFquNlLRyBvgeZ6PoFHvDnvIakjpNq+oqsi+VO6NuJNxbd4
	aI1X44HD6qjuh/GOk9LRBNWDuntv3UURNPoNCWPbfdKzDNzLVazKbJOoeDSBnGEhPVISePlQWpr
	vnapshGZOiqS5McTEdoQoxERV6rWC/OvSbLNTzqcbhhO1Ffnw9BH3YcqPXEgQO580wrX2w6OBCW
	nHZruKj0KeuX8V6fLC+LUG+7kcBNhGJo+3V32FKDx5/m8bzdD1+PSmuQCeoh5TVF/fKONGIhptH
	ECHgFqX+W3bxBkkM3ebLut6jPovsj74pFz+ulZe3Ws2RcWevTmMfmSPrCvFGiTtCIzgZBHocq9/
	g6WwxNGsiH+zlUQEN6AYAlN1X9whop6WweJcl+iOif4GiRGMC4dZNg==
X-Received: by 2002:a05:6000:200c:b0:474:6a5b:860b with SMTP id ffacd0b85a97d-47df07f0039mr3921789f8f.37.1783539217854;
        Wed, 08 Jul 2026 12:33:37 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960816sm43305262f8f.29.2026.07.08.12.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 12:33:37 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 08 Jul 2026 21:33:20 +0200
Subject: [PATCH] iio: light: opt3001: split opt3001_get_processed() logic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-opt3001-unwind-cleanup-v1-1-900b2cfddb6a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwML3fyCEmMDA0Pd0rzyzLwU3eSc1MS80gJdy8TU1JRUYzNTM1NTJaD
 mgqLUtMwKsMHRsbW1AGWqxYhoAAAA
X-Change-ID: 20260708-opt3001-unwind-cleanup-9aeede365655
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783539217; l=7860;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=dzJ0H++KOQilZd5rNkl8lB16HpmuYHtSjZpFq4x3xzo=;
 b=6oIlaXQKidDGm3ERKYCitneQlvLyJuWOM41pDbueNWvREry3lAGbxf+GGWP1gC6cXC05VesW1
 vhOE7Gc3BwRBIRj7h1M/H/oMNAexYrCmzWynssjJIVZAfi4Zh/8VKTC
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
 drivers/iio/light/opt3001.c | 197 ++++++++++++++++++++++++++------------------
 1 file changed, 118 insertions(+), 79 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 2bce6cd5f4e4..8430f4ddc23a 100644
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
+	long timeout;
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
+	timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
+		   OPT3001_RESULT_READY_SHORT : OPT3001_RESULT_READY_LONG;
+	msleep(timeout);
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

