Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675AB46AF0F
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034886; cv=none; b=bAnxh9cHYsNJyUS/G0g4bux3IacfQCPiiU0/iAGrC5PS2kAGfOY5DF50UpLKbeEWlkUjnP02VnmKnDg6GZpMw8qwqfDD9mF9dYwvN+d4OMD7vd+qYD8+0LpXSl7hIHrf0DgcFPKy/glN1YOcqsrYxh6YTTiFjtQCXyhn1VSWtCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034886; c=relaxed/simple;
	bh=3zLr5wC29AQBJyM1LTNCrLPJ/9RCUeECH8DF5+2Hswk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHVa5Mrnuqn8/veFZDLo1IebV3o6yKx+fHSuqYgL3J7hF2lRLugBPoPfZj5R0y31XHA1ty9l+ueu3Ws4vf4sBAQpduqhDpGWRPqnAnii6rQbgIOKAmW7AuCKYYyEVN4bkwdiqdEIAwl/by5io3X/8xHM7+kbeFTp/KYaRs0sA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXOvue1c; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXOvue1c"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e7632b193so99734185a.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784034878; x=1784639678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4sdtcAcnvXtBkdPDuwsN8gXcGpdW7yo4L5WrP92J294=;
        b=FXOvue1cLWut9tP02Otc9Zn3JKnb5EWxfVAMspxU3s00Kq0yYBLoij+KhUppdi02mM
         kAtd4LAEUFMArEPXVaZt0UCc5IeGtYpg6nbmEzIj3sEjsg1EmNhoyGSdVaJF/rRouaXq
         Sr1UaK+vMRrQPYyDrLGlIGI22x0qTiGvBezV2RxDgVNIcOuBaS3Calc3YqN2cvl1qxin
         U8aioO5a77CflROx2suIqd/2mSA74AIAcMyzKdUDorsn9QY8P4qPyL0ndXhHgHNUjIeH
         w2DpXMb7ZVCGwdPrC5HZNRndZNT9IsBgEORcfLpRf9IcZ7gvXBQO1FvqOYgzcHYdS7dj
         6v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034878; x=1784639678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4sdtcAcnvXtBkdPDuwsN8gXcGpdW7yo4L5WrP92J294=;
        b=PxlvzSnT9whgqglVSVJjssWCHHAMI7xphyN4IBrJeomrBGBaOaruwhB15xyyTAU8nj
         Jk517ciWY0zTI34GdkAaarQem0mAw7c+qZsGVU0JOcj1VaF2RZO7Uvhh6A7VwxZqSSau
         fQVue/6prdhxJkbwOmcLfCHwGj9XwSFX7nBoC8nSabdN8NA4WxIamgjQRo1MVHHKhy0i
         bGJYqqPPionZjbi9YsIey0dzC9tziy/LDZZNmsn/VtosQt2kmvMcED0h6VIr8J3BcmnU
         lxYvb86tZmq7EwwX+iL0JvSX9YJEnuQNSvDULAfINMgtnfqcNd/UxUYNHa90f8xhazDh
         pmrg==
X-Forwarded-Encrypted: i=1; AHgh+RotiTTBLLj1uLX6u5V80KBPyoN+SMcN5k3NoyCjczMdR7mzXtY0hOhXMTFQq2ogtemAMOGmAp3kXcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMb1t/FLBBnI7+HryFJQrEQ+2PAN3ryETn2UoNBAR4dkjhSam2
	/fSlwtc5zu++Z/eM7fTGGuUP52IBkbNUK2fOZnridgSm/QbV0Hqk5TJ7
X-Gm-Gg: AfdE7clzFxGdkhLglNQf3teggmOyccM16hORJdrxm3DGG3FMnqOdJWietc7OJVHxdpa
	YsUCk8Yip7x+5UAtOlbpi9fk+z+ivR17eIbbPQ9XJRlbAy/Wf/xAKYevZX2zwqDUZ3Gehq0bKe3
	VISbd/Jc5QElDX/iE86bRw9NxZleVDRggONw8ZIOUYySYdnfx6w7WX2uWUd/gm3lNWl62UnLuIb
	vna5aWp2Y7dYWzesqY8R45ymvmdUJiBHXMdRQOSXNAOTD+qmhpSfGO1pG/M/LUfgBUjwO9FJLVi
	CMQGiL6mitY5ymVB0oaOceqlV8662UnvFoO59Dj72kO1M4Fb5whnUHoGt4DnyzO1u7oaEtPGNb0
	nPZJXrnsKX0ESniOiZ3UtkpXEQg52cqRaDnzdELBKb94FlTgGxc58QpH+FXjMTc6OlMQSjAcTHZ
	fOP/Nrq+9mTmk/Rvebm9qKpSN2EeVQY0bi2r0tIjyA+uiX517k1yp2aA==
X-Received: by 2002:a05:620a:8398:b0:92b:4474:76b with SMTP id af79cd13be357-92ef2c1fa8bmr1220305185a.45.1784034877981;
        Tue, 14 Jul 2026 06:14:37 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5bcb074sm1464651785a.21.2026.07.14.06.14.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 06:14:37 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: linusw@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH v3] iio: gyro: mpu3050: Fix runtime PM leak and refactor trigger state
Date: Tue, 14 Jul 2026 18:44:27 +0530
Message-ID: <20260714131426.4257-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260615214504.38979-1-birenpandya@gmail.com>
References: <20260615214504.38979-1-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpu3050_drdy_trigger_set_state() calls pm_runtime_get_sync() when the
trigger is enabled, but several error paths in the enable branch return
directly without dropping the usage counter again. pm_runtime_get_sync()
increments the usage counter, so every failed enable leaks a runtime PM
reference and the device can no longer autosuspend. The driver state flag
hw_irq_trigger is also left set after a failed enable.

To fix the error unwind clearly and avoid an asymmetric goto block inside a
monolithic function, this patch breaks the trigger state handler into two
distinct helpers: mpu3050_drdy_trigger_enable() and
mpu3050_drdy_trigger_disable(). The enable helper correctly implements the
error unwind path to drop the PM reference and clear the flag.

Additionally, pm_runtime_get_sync() is replaced with
pm_runtime_resume_and_get() for robust error checking.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---

Changes in v3:
- Fixed kernel-doc warning for mpu3050_drdy_trigger_set_state().
- Fixed the Fixes tag title to exactly match the target commit.
- Link to v2: https://lore.kernel.org/all/20260615214504.38979-1-birenpandya@gmail.com/
 drivers/iio/gyro/mpu3050-core.c | 166 ++++++++++++++++++--------------
 1 file changed, 92 insertions(+), 74 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b4314..9de126c3b4350 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -945,102 +945,120 @@ static irqreturn_t mpu3050_irq_thread(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-/**
- * mpu3050_drdy_trigger_set_state() - set data ready interrupt state
- * @trig: trigger instance
- * @enable: true if trigger should be enabled, false to disable
- */
-static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
-					  bool enable)
+static int mpu3050_drdy_trigger_disable(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
 	unsigned int val;
 	int ret;
 
-	/* Disabling trigger: disable interrupt and return */
-	if (!enable) {
-		/* Disable all interrupts */
-		ret = regmap_write(mpu3050->map,
-				   MPU3050_INT_CFG,
-				   0);
-		if (ret)
-			dev_err(mpu3050->dev, "error disabling IRQ\n");
+	/* Disable all interrupts */
+	ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, 0);
+	if (ret)
+		dev_err(mpu3050->dev, "error disabling IRQ\n");
 
-		/* Clear IRQ flag */
-		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
-		if (ret)
-			dev_err(mpu3050->dev, "error clearing IRQ status\n");
+	/* Clear IRQ flag */
+	ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
+	if (ret)
+		dev_err(mpu3050->dev, "error clearing IRQ status\n");
 
-		/* Disable all things in the FIFO and reset it */
-		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
-		if (ret)
-			dev_err(mpu3050->dev, "error disabling FIFO\n");
+	/* Disable all things in the FIFO and reset it */
+	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
+	if (ret)
+		dev_err(mpu3050->dev, "error disabling FIFO\n");
 
-		ret = regmap_write(mpu3050->map, MPU3050_USR_CTRL,
-				   MPU3050_USR_CTRL_FIFO_RST);
-		if (ret)
-			dev_err(mpu3050->dev, "error resetting FIFO\n");
+	ret = regmap_write(mpu3050->map, MPU3050_USR_CTRL,
+			   MPU3050_USR_CTRL_FIFO_RST);
+	if (ret)
+		dev_err(mpu3050->dev, "error resetting FIFO\n");
 
-		pm_runtime_put_autosuspend(mpu3050->dev);
-		mpu3050->hw_irq_trigger = false;
+	pm_runtime_put_autosuspend(mpu3050->dev);
+	mpu3050->hw_irq_trigger = false;
 
-		return 0;
-	} else {
-		/* Else we're enabling the trigger from this point */
-		pm_runtime_get_sync(mpu3050->dev);
-		mpu3050->hw_irq_trigger = true;
+	return 0;
+}
 
-		/* Disable all things in the FIFO */
-		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
-		if (ret)
-			return ret;
+static int mpu3050_drdy_trigger_enable(struct iio_trigger *trig)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
 
-		/* Reset and enable the FIFO */
-		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
-				      MPU3050_USR_CTRL_FIFO_EN |
-				      MPU3050_USR_CTRL_FIFO_RST);
-		if (ret)
-			return ret;
+	ret = pm_runtime_resume_and_get(mpu3050->dev);
+	if (ret)
+		return ret;
 
-		mpu3050->pending_fifo_footer = false;
+	mpu3050->hw_irq_trigger = true;
 
-		/* Turn on the FIFO for temp+X+Y+Z */
-		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN,
-				   MPU3050_FIFO_EN_TEMP_OUT |
-				   MPU3050_FIFO_EN_GYRO_XOUT |
-				   MPU3050_FIFO_EN_GYRO_YOUT |
-				   MPU3050_FIFO_EN_GYRO_ZOUT |
-				   MPU3050_FIFO_EN_FOOTER);
-		if (ret)
-			return ret;
+	/* Disable all things in the FIFO */
+	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
+	if (ret)
+		goto err_put_autosuspend;
 
-		/* Configure the sample engine */
-		ret = mpu3050_start_sampling(mpu3050);
-		if (ret)
-			return ret;
+	/* Reset and enable the FIFO */
+	ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
+			      MPU3050_USR_CTRL_FIFO_EN |
+			      MPU3050_USR_CTRL_FIFO_RST);
+	if (ret)
+		goto err_put_autosuspend;
 
-		/* Clear IRQ flag */
-		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
-		if (ret)
-			dev_err(mpu3050->dev, "error clearing IRQ status\n");
+	mpu3050->pending_fifo_footer = false;
 
-		/* Give us interrupts whenever there is new data ready */
-		val = MPU3050_INT_RAW_RDY_EN;
+	/* Turn on the FIFO for temp+X+Y+Z */
+	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN,
+			   MPU3050_FIFO_EN_TEMP_OUT |
+			   MPU3050_FIFO_EN_GYRO_XOUT |
+			   MPU3050_FIFO_EN_GYRO_YOUT |
+			   MPU3050_FIFO_EN_GYRO_ZOUT |
+			   MPU3050_FIFO_EN_FOOTER);
+	if (ret)
+		goto err_put_autosuspend;
 
-		if (mpu3050->irq_actl)
-			val |= MPU3050_INT_ACTL;
-		if (mpu3050->irq_latch)
-			val |= MPU3050_INT_LATCH_EN;
-		if (mpu3050->irq_opendrain)
-			val |= MPU3050_INT_OPEN;
+	/* Configure the sample engine */
+	ret = mpu3050_start_sampling(mpu3050);
+	if (ret)
+		goto err_put_autosuspend;
 
-		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
-		if (ret)
-			return ret;
-	}
+	/* Clear IRQ flag */
+	ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
+	if (ret)
+		dev_err(mpu3050->dev, "error clearing IRQ status\n");
+
+	/* Give us interrupts whenever there is new data ready */
+	val = MPU3050_INT_RAW_RDY_EN;
+
+	if (mpu3050->irq_actl)
+		val |= MPU3050_INT_ACTL;
+	if (mpu3050->irq_latch)
+		val |= MPU3050_INT_LATCH_EN;
+	if (mpu3050->irq_opendrain)
+		val |= MPU3050_INT_OPEN;
+
+	ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
+	if (ret)
+		goto err_put_autosuspend;
 
 	return 0;
+
+err_put_autosuspend:
+	pm_runtime_put_autosuspend(mpu3050->dev);
+	mpu3050->hw_irq_trigger = false;
+	return ret;
+}
+
+/**
+ * mpu3050_drdy_trigger_set_state() - set data ready interrupt state
+ * @trig: trigger instance
+ * @enable: true if trigger should be enabled, false to disable
+ */
+static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
+					  bool enable)
+{
+	if (enable)
+		return mpu3050_drdy_trigger_enable(trig);
+	else
+		return mpu3050_drdy_trigger_disable(trig);
 }
 
 static const struct iio_trigger_ops mpu3050_trigger_ops = {
-- 
2.50.1 (Apple Git-155)

