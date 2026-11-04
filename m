Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764817;
	b=2INacW70ZMgBG7DWsOXo/E92taF62DgCzn7SiYVc/D9o6SGF8+/TY47a7gFlHuH6Eryg
	 Jx4SSvhyXySYFj49sPWAVvYbdo/kar0y7xl/K7lJu0AbYshRofZdUbHV2mkwqjjuyobxG
	 ozrjSj/EOpGh5S93krEcbSxCA8FyI42aDR8mmkKlLirth0rrkdR0Z3rV+htWhi43cy1UL
	 vIvBIdAdfH+3pTbsJ0qkvI/RE1kHw9pDlQgE/wvuf+QZMxW3lxbU960NRLt1Zh86/xJ03
	 qPQcuC82xsbW1gMvmW4lR8COfD2OokPwm8fm4qwkiX/5etIWQMmnYi+c2ceMOoV2v1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764817;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XjpP4STVmb5v5/oS8e17CWFE5+WCKLC0u4EW/fzeisI=;
	b=IcMVxorS8c5aGagOyPXiS7KzOiQUtu7oIjL1k5H4YyTJByhgY9vfUcJTqunvFZ/AoqK8
	 EhB+oXsaCl6SSAOfLx2hqtQeqHLvDjlMugoRFcY5ekrdYNcq4rTX7Tf1cHu6SsjI52JVs
	 pX4SNEZBy0LlvWTgDOXDLhu6ZncTI8r2DFlvpL3ItKLA3ofHarTCxi5IHWgAAOOv2HPee
	 M6YUORBj6l08e9A9ET+m9E5ilAITfrt7ZuzHox8dgbrTU7Mb5sOlqHEwV/qmAK4o+e/tW
	 QmD6RSLpDoCTQC0PLiUec4iwPw+dpX74h+fHhcKtlNyYy9EgUXucXuYONgbme7tRjRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=V3OxPSen;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6E606A31B;
	Wed,  4 Nov 2026 04:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AF6E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=V3OxPSen
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=V3OxPSenKMmoy43PCUanrgSDhCQMtB0SrZy/WckCyHK73yEsE/OxtT+1dLQCtwVd752iMZ9qMOzwi
	 lZ8ASldlBWhaSbrcneyKXe+z2jl48tc/sy+8PM7wmNGCBbyiOaF7LfzVDsmJrIPx/47tir8tdcgtHx
	 ix17sTkVkpv+PEWY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aeaadcc978-6615b;
	Wed, 04 Nov 2026 12:00:13 +0800 (CST)
X-RM-TRANSID:2ee66aeaadcc978-6615b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66aeaadc9e9f-120bc;
	Wed, 04 Nov 2026 12:00:13 +0800 (CST)
X-RM-TRANSID:2ee66aeaadc9e9f-120bc
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v4 1/2] iio: gyro: mpu3050: Split data ready trigger enable/disable into helpers
Date: Wed,  4 Nov 2026 12:00:06 +0800
Message-ID: <20261104040008.1458-2-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261104040008.1458-1-laixiangwu@cmss.chinamobile.com>
References: <20261104040008.1458-1-laixiangwu@cmss.chinamobile.com>
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

Changes in v4:
- use an else for the either/or dispatch in
  mpu3050_drdy_trigger_set_state(), as suggested by the reviewer.

Changes in v3:
- none; reposted in a new top-level thread.

Link: https://lore.kernel.org/r/20261103092002.1332-2-laixiangwu@cmss.chinamobile.com
Link: https://lore.kernel.org/r/20261101092327.197-2-laixiangwu@cmss.chinamobile.com
 drivers/iio/gyro/mpu3050-core.c | 173 ++++++++++++++++++--------------
 1 file changed, 99 insertions(+), 74 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 07c0f9011..62e416df3 100644
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
+	else
+		return mpu3050_drdy_trigger_disable(mpu3050);
+}
+
 static const struct iio_trigger_ops mpu3050_trigger_ops = {
 	.set_trigger_state = mpu3050_drdy_trigger_set_state,
 };
-- 
2.50.1.windows.1



