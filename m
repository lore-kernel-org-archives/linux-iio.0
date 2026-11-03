Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697612;
	b=R8HjrdRDwrybY0hLvEsRpxCLWxXKsIqqP4vMj1Zw9GXALbY0XZerkpnnvjqUqPNWJBGO
	 0uQxLUmTENJqpK3LXZG02C5eqJHW7TdpKH+oTLtv6zfq0RPptlJWrjDaME9Mrme5NhzxE
	 EX6vQ3XCux6vR7p4o1C1GyV3b+/xQW8Zh/H23S8ODKqQ5JYdly1Wbf3h7wa0dxIPRiJLU
	 RjPwP2U70nUXNEEYRfykXygmzpHy+XrUKRYpJRLoTe5tNEGpkydznYIpQYXV9rieIq+/s
	 oSADj+RnIPgV/Xx/mOyeLfmklGwdBdxc2RoRexzt7eCmneyDRjTldnGdXqhqBbu0KHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697612;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GoJJGnLjJbadu3Fw6HjM1zaWLD+B1Y7DHixLvyyq14M=;
	b=yGMWRqUosdyG6xba4qrXfAYPTY6Gq3/zwHE5yIySpcVxCuueA0wk1znM4LxKtkvmQ/h5
	 OzubpF9GquhYlQu2CSUrnE4YPx3zYE4Saot4VsN80PT/4WDkk0SG8JGWdfOpFwBbRfI+U
	 xOhP7NFVOB83LS16cKzUdwQpLNo8VXAiZjYI6hv8Bg6otz1J0Be3bLV0U/7YXLrrB614U
	 tc+vg4cXcrhz1PsvCDOjsSarFYKY9pfoa2CscP7FvgddhYrqnNqAROuaW+oTyoUy651E4
	 5b3NY9no6C+G5z2lVCL+O3oK7WIHxJGsrYj4N90TgNmfukXkGUWKZvZ4I5jHBhiNLDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=fkioqmsJ;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C53606A32E;
	Tue,  3 Nov 2026 09:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22C53606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=fkioqmsJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=fkioqmsJ8ofUb4mCPa18sy0tfUBZBE9WmiJNXJEeNXN6OhG7rkMPhRxAOkxTb+YmuzGYiM4fsC9Sy
	 pq/VJq2/vPNfFETuk6bfs66N1ybX85MHNP7QXqVyjBa3BqtXKBUVLgfPKzTWiiA3SLWVUDrnL2u3++
	 m7WLJRiZqyCdCAtY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56ae9a7489cb-90bb0;
	Tue, 03 Nov 2026 17:20:09 +0800 (CST)
X-RM-TRANSID:2ee56ae9a7489cb-90bb0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ae9a744004-f3e3b;
	Tue, 03 Nov 2026 17:20:09 +0800 (CST)
X-RM-TRANSID:2ee66ae9a744004-f3e3b
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v3 1/2] iio: gyro: mpu3050: Split data ready trigger enable/disable into helpers
Date: Tue,  3 Nov 2026 17:20:01 +0800
Message-ID: <20261103092002.1332-2-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261103092002.1332-1-laixiangwu@cmss.chinamobile.com>
References: <20261103092002.1332-1-laixiangwu@cmss.chinamobile.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: laixiangwu <laixiangwu@cmss.chinamobile.com>

mpu3050_drdy_trigger_set_state() implements both the enable and the
disable path of the data ready trigger in the two legs of a large
if/else statement.

Split the two legs out into separate mpu3050_drdy_trigger_enable()
and mpu3050_drdy_trigger_disable() helpers and reduce
mpu3050_drdy_trigger_set_state() to dispatching to the appropriate
one. This is a pure code move with no functional change, done to make
the error handling of the enable path easier to read.

Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
---

Changes in v3:
- none; reposted in a new top-level thread.

Link: https://lore.kernel.org/r/20261101092327.197-2-laixiangwu@cmss.chinamobile.com
 drivers/iio/gyro/mpu3050-core.c | 173 ++++++++++++++++++--------------
 1 file changed, 99 insertions(+), 74 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 07c0f9011..d966911ab 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -946,103 +946,128 @@ static irqreturn_t mpu3050_irq_thread(int irq, void *p)
 }
 
 /**
- * mpu3050_drdy_trigger_set_state() - set data ready interrupt state
- * @trig: trigger instance
- * @enable: true if trigger should be enabled, false to disable
+ * mpu3050_drdy_trigger_enable() - enable the data ready trigger
+ * @mpu3050: device to configure
+ *
+ * Power up the device, enable the FIFO and configure the data ready
+ * interrupt.
  */
-static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
-					  bool enable)
+static int mpu3050_drdy_trigger_enable(struct mpu3050 *mpu3050)
 {
-	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
-	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
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
+	pm_runtime_get_sync(mpu3050->dev);
+	mpu3050->hw_irq_trigger = true;
 
-		/* Clear IRQ flag */
-		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
-		if (ret)
-			dev_err(mpu3050->dev, "error clearing IRQ status\n");
+	/* Disable all things in the FIFO */
+	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
+	if (ret)
+		return ret;
 
-		/* Disable all things in the FIFO and reset it */
-		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
-		if (ret)
-			dev_err(mpu3050->dev, "error disabling FIFO\n");
+	/* Reset and enable the FIFO */
+	ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
+			      MPU3050_USR_CTRL_FIFO_EN |
+			      MPU3050_USR_CTRL_FIFO_RST);
+	if (ret)
+		return ret;
 
-		ret = regmap_write(mpu3050->map, MPU3050_USR_CTRL,
-				   MPU3050_USR_CTRL_FIFO_RST);
-		if (ret)
-			dev_err(mpu3050->dev, "error resetting FIFO\n");
+	mpu3050->pending_fifo_footer = false;
 
-		pm_runtime_put_autosuspend(mpu3050->dev);
-		mpu3050->hw_irq_trigger = false;
+	/* Turn on the FIFO for temp+X+Y+Z */
+	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN,
+			   MPU3050_FIFO_EN_TEMP_OUT |
+			   MPU3050_FIFO_EN_GYRO_XOUT |
+			   MPU3050_FIFO_EN_GYRO_YOUT |
+			   MPU3050_FIFO_EN_GYRO_ZOUT |
+			   MPU3050_FIFO_EN_FOOTER);
+	if (ret)
+		return ret;
 
-		return 0;
-	} else {
-		/* Else we're enabling the trigger from this point */
-		pm_runtime_get_sync(mpu3050->dev);
-		mpu3050->hw_irq_trigger = true;
+	/* Configure the sample engine */
+	ret = mpu3050_start_sampling(mpu3050);
+	if (ret)
+		return ret;
 
-		/* Disable all things in the FIFO */
-		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
-		if (ret)
-			return ret;
+	/* Clear IRQ flag */
+	ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
+	if (ret)
+		dev_err(mpu3050->dev, "error clearing IRQ status\n");
 
-		/* Reset and enable the FIFO */
-		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
-				      MPU3050_USR_CTRL_FIFO_EN |
-				      MPU3050_USR_CTRL_FIFO_RST);
-		if (ret)
-			return ret;
+	/* Give us interrupts whenever there is new data ready */
+	val = MPU3050_INT_RAW_RDY_EN;
 
-		mpu3050->pending_fifo_footer = false;
+	if (mpu3050->irq_actl)
+		val |= MPU3050_INT_ACTL;
+	if (mpu3050->irq_latch)
+		val |= MPU3050_INT_LATCH_EN;
+	if (mpu3050->irq_opendrain)
+		val |= MPU3050_INT_OPEN;
 
-		/* Turn on the FIFO for temp+X+Y+Z */
-		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN,
-				   MPU3050_FIFO_EN_TEMP_OUT |
-				   MPU3050_FIFO_EN_GYRO_XOUT |
-				   MPU3050_FIFO_EN_GYRO_YOUT |
-				   MPU3050_FIFO_EN_GYRO_ZOUT |
-				   MPU3050_FIFO_EN_FOOTER);
-		if (ret)
-			return ret;
+	ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
+	if (ret)
+		return ret;
 
-		/* Configure the sample engine */
-		ret = mpu3050_start_sampling(mpu3050);
-		if (ret)
-			return ret;
+	return 0;
+}
 
-		/* Clear IRQ flag */
-		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
-		if (ret)
-			dev_err(mpu3050->dev, "error clearing IRQ status\n");
+/**
+ * mpu3050_drdy_trigger_disable() - disable the data ready trigger
+ * @mpu3050: device to configure
+ *
+ * Disable the data ready interrupt, flush the FIFO and drop the
+ * runtime PM reference taken in mpu3050_drdy_trigger_enable().
+ */
+static int mpu3050_drdy_trigger_disable(struct mpu3050 *mpu3050)
+{
+	unsigned int val;
+	int ret;
 
-		/* Give us interrupts whenever there is new data ready */
-		val = MPU3050_INT_RAW_RDY_EN;
+	/* Disable all interrupts */
+	ret = regmap_write(mpu3050->map,
+			   MPU3050_INT_CFG,
+			   0);
+	if (ret)
+		dev_err(mpu3050->dev, "error disabling IRQ\n");
 
-		if (mpu3050->irq_actl)
-			val |= MPU3050_INT_ACTL;
-		if (mpu3050->irq_latch)
-			val |= MPU3050_INT_LATCH_EN;
-		if (mpu3050->irq_opendrain)
-			val |= MPU3050_INT_OPEN;
+	/* Clear IRQ flag */
+	ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
+	if (ret)
+		dev_err(mpu3050->dev, "error clearing IRQ status\n");
 
-		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
-		if (ret)
-			return ret;
-	}
+	/* Disable all things in the FIFO and reset it */
+	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
+	if (ret)
+		dev_err(mpu3050->dev, "error disabling FIFO\n");
+
+	ret = regmap_write(mpu3050->map, MPU3050_USR_CTRL,
+			   MPU3050_USR_CTRL_FIFO_RST);
+	if (ret)
+		dev_err(mpu3050->dev, "error resetting FIFO\n");
+
+	pm_runtime_put_autosuspend(mpu3050->dev);
+	mpu3050->hw_irq_trigger = false;
 
 	return 0;
 }
 
+/**
+ * mpu3050_drdy_trigger_set_state() - set data ready interrupt state
+ * @trig: trigger instance
+ * @enable: true if trigger should be enabled, false to disable
+ */
+static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
+					  bool enable)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
+
+	if (enable)
+		return mpu3050_drdy_trigger_enable(mpu3050);
+
+	return mpu3050_drdy_trigger_disable(mpu3050);
+}
+
 static const struct iio_trigger_ops mpu3050_trigger_ops = {
 	.set_trigger_state = mpu3050_drdy_trigger_set_state,
 };
-- 
2.50.1.windows.1



