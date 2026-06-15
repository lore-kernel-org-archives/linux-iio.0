Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232B3B71B7
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781559915; cv=none; b=RwlOBfTMtkjiRki2rhI/6qbPIQLpEUTeqDfRIRG9AlF1LDy8BOm8WyshbGZOFrewLetXCuYna0FV2uJitcH5/aInVN02JGhS8he9Ldd/54QqvLSBcovF7/+8b4jA+C3pz6L7AnQ0vtzdmOyBZ3MvWUyS8Cuu0UW2je5tlBZS8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781559915; c=relaxed/simple;
	bh=SvbBjoww5+wFF7u1xt4uuxqBSFtLaP5ox/IbkHa9AY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKX8HjkITfDiuS18EcXMLGv17jTetl60QFMyNhCPXJsRH+39iTwNqyynNjnznI2DDU500UUkyS9nM+5TEI0r0XdeJ9eBzFacgn0Pz59X5xu+XnlTJd2Ho2VetFyM/V5j6xe/H7dEsPIEwqAbQ7J7qxgx4weYNqJBxRU9hH3jsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN8qTfY8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN8qTfY8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c379e8ffso25875895ad.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 14:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781559913; x=1782164713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wiHNRxAKs4w3ZzKjOxr2PmYcSM7f1pBK0Mu0fcOh5JM=;
        b=gN8qTfY8htv8fPO6tP+eYdaI7DmVX0LZisM0bvYDw69CuVWt/81rziVx7XUU7+fUsc
         4C/C8iZ91fXLytWKBZuqWBuPrAE9/f/dT7Lrpp2sMNUafYk8WIuCZ3QYrSdhkwLL68rr
         u799j8LC373PDJGdEOKA0Wt6JDLjy8q7VaMSn+zSx3cq1C8XjMtEIdGS1lgT9xvuSL/O
         NockYDL1nOYeq7XWSX0caq/vLWyaV7KO5yy41j9xF0x/4c9oF56Ol5/RUs9iqv3jmVTI
         WOiTkMK6AiwcjGgJTMF+HSShhv1ZA2ECuscr6eYUgiWPTlQVGfwyPmpamnAJdRK8+36L
         WMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781559913; x=1782164713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiHNRxAKs4w3ZzKjOxr2PmYcSM7f1pBK0Mu0fcOh5JM=;
        b=NI3KoZUrs/61liWun31DG4UAOZSi1lmpGqqZFA0B/lyF6T1QxUwHYci97cwfF0rbiU
         x6PZImQqzcEl0XK+XUS/iQty1l/T/qM8Jvtf73CSW7fggMizaAq7myLDoJpY2liaVDkZ
         GuEe4xKT6qOFvB4scq2b76mv/RjfNbFLkrrbnJNDW2n4MpxGumNcmzyTqTfXXBWZsnxY
         qbJdek9NYs6N5XMXIW0Em1Mj/WJ2SPuTHWzhQ8oymkN0624UhLmsmbpiB+qsrhLwiYPS
         0AjRQZg7sD6PIPc1bz1Wg1ww0i9uwbB+dyvBo3GKdyDiPOkbnqwAc5apfuTuMEOs33Am
         veSg==
X-Forwarded-Encrypted: i=1; AFNElJ/OYvvDrWPbxUujN56SeYrF08Z+376x9xlDaYnSFIDRpufGBfYKp3MEOxfPBxwhD7bzJBOTKzm9G1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0FhJY/msU8RtfGb76U1opkRR+yljmm1GNMb0fusLg1yk1s48z
	pTfHjOQBe/8ObXmEDvo/AONC4G0zMl/qhVSZh9IHABeoUoFNot5kyJdilba19F/T
X-Gm-Gg: Acq92OFHcyuQKYaogvg6ozhKovvlj8aGiN/+0MUgNcJxrZ8uq4JcXMEEy9+91UBXHIk
	0lWm20+uIL/Ew5kOjtsQS5oR9SuL1c920q+scSiyM2Iz3gZA5UW49T4545CC2+cmv7W+mFPuj1Y
	2de2IrITQ45MFVEfg4NCJeF9s/z1d41eSF8edN9ywsgVYYYatxMsdbik7jQ3PHRHkPBALYiXoUF
	tVvHjN5zujqsVkhttt+gYxMartDmFXU5nWOAi/wVz/SeJ05dAUdV66L1Z0+mJmGF01hvz2e6p6/
	dJSLbB4vYmTAhXOjnJ1z/o/asR310VGglVw47JTr3JSQvB8DFt9a8iLWhdG2IF129Ny5WAqViOW
	wOZFRR4SyMyNdCUEIfZgsedgopr5kYgapeHipxaZjWQmEjIc5HNmUNVRgrDtUOxQ++5K2XEzVQy
	455fRs4BezC15+xsgzN6I0VWjx/wfM84+lRG2tcX81h8BpUx24CLkkEjbmU4kj8uE=
X-Received: by 2002:a17:903:2442:b0:2c0:ab82:6bb8 with SMTP id d9443c01a7336-2c66420992cmr135847835ad.27.1781559913245;
        Mon, 15 Jun 2026 14:45:13 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8dd4bsm113139625ad.60.2026.06.15.14.45.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jun 2026 14:45:12 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH v2] iio: gyro: mpu3050: Fix runtime PM leak and refactor trigger state
Date: Tue, 16 Jun 2026 03:15:04 +0530
Message-ID: <20260615214504.38979-1-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Fixes: 3904b28efb2c ("iio: gyro: Add core driver for the MPU-3050")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---

 drivers/iio/gyro/mpu3050-core.c | 156 ++++++++++++++++++--------------
 1 file changed, 87 insertions(+), 69 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b431..7dea7ab6b2d6 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -950,97 +950,115 @@ static irqreturn_t mpu3050_irq_thread(int irq, void *p)
  * @trig: trigger instance
  * @enable: true if trigger should be enabled, false to disable
  */
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

