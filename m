Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792883638;
	b=48FMFBSBLldti3laSHmuTOVkgwVsEiSbBaitFDOMRyF71EgYgsIjM5TZzzeEEIpjc1jP
	 iG+5pd+H293ECigAIfG5Go3oI6252QMpBGfy1u6lDXLB1E+MY9MPMiHPk9uLtHji0AFb9
	 oOPwZ2gtt9xeGlAb+OdMcVzpAVdaggLATPDuLZkhKvvc3ZENd7vytMHAmZ6gAvi3Ytb2w
	 fCcTPSDTgI17U7wHOXdPt1LKxZHqgGpfTWTgxYREszszjryBrnxn8wvymH27qJtCfvpoM
	 14WqnIe2zamqCCHyXBrkg+ZkpMYcf1PTasZiV767FT77vxTvmHQorjHTN/NIwP8sgiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792883638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jukZhbeSE3vZT26DKiUtvj3STQ7HhhHa3ejl4CuGsTI=;
	b=ZCKwLUS9I1cSTsKwC9+Nx7IrNSs+IQY5h1QM8YbEOx8PhSvUyxGEeqm9nDhFT9+a0xLU
	 b/dRzh5f3MsZexEtJDWqPAffuFtEEawf6LafCG6Cg65p6EHPbO9Fy5ge5SoWfbRC3hyPk
	 4HuICkDIV72HoMSAkWuwfbgU7Cx9aXkKYPNp+rFFB85+mOuWY+MqfzHVYnrzARwWwPsvY
	 hDdocv6OqX2GoVFS0+q3ARTpWPAUy+HjHELU2uT4ruDvf0VpGr61MKiFUFtBfTdB7M5XS
	 rMaJ4EINP9DG278KWGFbO6oaFCzB025dUUnVaAn3aGoFH8T/LpMlw12Y5jzXwf8wzzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SHpYscFK;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B9606A31E
	for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 23:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC5B9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SHpYscFK
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eaeb7fdda2so1968726e0c.3
        for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792883637; x=1793488437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jukZhbeSE3vZT26DKiUtvj3STQ7HhhHa3ejl4CuGsTI=;
        b=SHpYscFK0AX4L9xsPRIMFFy+mix71uns9ZMInXNrSsLITKaqioH9iZh3MYVzBVa5pT
         cQGQos0yDv3P6K7bIl72uu/SoEw/2jDfXnHysbT6AxOcyNCXjf/yeE5uiMNHmt97GNkJ
         8Pov5RnKsZ8j3woPVEj4tScj88HXc53Z78uhP4tLpBNg4QIyg5luLvzpU5ZmxBVO5p77
         dVHOpTsyy1i9a0AS0yRed+T4t+rPCuKhjj+laDXAjpGJNr2pCKEUdswsF5Nhzs9AHnhw
         iJuSwkxFOWU5f2cb4t49IS2svvRR6rKQHflw9rgJqf5GzzNxhIo1CsfP0k/V4NAWOpPv
         PSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792883637; x=1793488437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jukZhbeSE3vZT26DKiUtvj3STQ7HhhHa3ejl4CuGsTI=;
        b=mf4IICf8a+J15o90lDGUAqJ27iQ+onrKSq3pBFfb7okyDxKZNzDQv1Nh/S+TY32/8m
         RWAFzmT18WncHBjGSzIOiqBX6GQU503PMD6UhsCUEYxldzmfoKw2hZkt/vs9mOPuyUMT
         pkDHW0DYz2PwQ08qcl27o0HAqrrdV4jMf4RO7ANj//4VToPBpFnwxkFkCaQUsMoCHmu5
         LmYiI7zQJpWZp0oLfuAIGgeUZchX3H10Y6Z+HG/CJCjGQw0s8ueY5IZDLc+1t4EP7zDo
         LOGm5QdkNVl4rYeBVzYKKPJQZxg7qVnzparHmalhUNk6iC6BWVWEmCEEg8+Z9bjexUMU
         KFJA==
X-Forwarded-Encrypted: i=1; AKwUvBy/2dDRUXzJqvOPKoZeKSMpCQY1qeW2qp8aX8vtMbywRjaXqXBfnLm0/letF628EMgOKsVyCD59+dQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlqsjyW353AsY+D2Ny2mxD1oCEaxjjDCSPGlJO7ZT+7p1oQc7V
	oD/k3rcqMHe2zzAR8jxYyAtMj/mA5aZOU/3cS4TbamuhA1ozLFENdO3ZCJVguidn
X-Gm-Gg: AYBFou2e//RhszsB7fjLcJ9qIBdEb2EMGNCwwEILq8LBlbpu8Db7WZKyVoCNvUkq6vj
	vadnEQOxDDRbVBmB/vIj6Ag91m990oi/6sY3fvNu5ocTxZrJOXVS0bmklT0fHP6v3xkamybXrL+
	RhqNJD2DpylatPWCl5IKkU1lF+txdfzm+wM5uFVXMQHGe2HGRTnVzDVoeUr7QIIL1WbUzzcS5pO
	PVk4qcGdmBwsJITg1otQeEC1VBYQtYm7MniUXHCfgZ4xORkJlql4YI7pqc9M/txFcgM9YYNq3zj
	lMeoGNuWolC0f8sHC+QWqKYzmxrKmu6GOhY8mTJP3rp88xooZckfgXb4f9coU7ig23ExkYreB4W
	XiqB+wDnJksL6B6/hSo90SeXa6T4KvIoIflKL4/t8diCT4kqTPC89kH0Feo5wqS4NE8Kh4bfy2M
	FrQhCY1CTsV09OnxZCjdOhZoN4XtNH6q/9/4aT0cVbTky/FqrvLXi32b98H9T8S7BsszXC/eJ2D
	g/Tm1mjwrcCTRUcS3eOAx0b0uCftuQgzmh6LFs1sqta/FfNTgfkjA3InZmCulljoHnTWrQgaNk7
	jU3Z
X-Received: by 2002:a05:6102:a4a:b0:7cc:174b:f7d8 with SMTP id ada2fe7eead31-7ce5ca1d325mr1021515137.1.1792883636801;
        Sat, 24 Oct 2026 16:13:56 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:efc9:520c:e99d:e5ce])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e7b8f0csm3775406241.5.2026.10.24.16.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 16:13:56 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] iio: adc: ti-ads1298: fix the data read path
Date: Sat, 24 Oct 2026 20:13:30 -0300
Message-ID: <20261024231335.280955-2-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024231335.280955-1-stephanbrrs8@gmail.com>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
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

Fix five issues in how the driver reads samples:

- cmd_buffer serves both the register accessors, under the regmap lock,
  and the commands, under the IIO device lock, and shares a cacheline
  with rx_buffer and tx_buffer. A register access can then rewrite a
  command on the bus, or corrupt an RDATA transfer in flight on a
  platform without coherent DMA. Give each path its own buffer, each on
  its own cacheline.

- After STOP, the conversion in progress still raises DRDY, so an RDATA
  transfer can be in flight when the core frees the active scan mask.
  Track in the driver whether samples go to the buffer, wait in
  predisable for the last DRDY and its transfer, and push the sample
  before marking the transfer done. update_scan_mode reset the transfer
  counter, which let a new transfer be queued over one in flight; wait
  for it instead.

- When a single-shot read times out, its transfer may still be in
  flight, and the next read then wakes up with the old sample. On
  unbind, nothing waits for the DRDY interrupt or its transfer. Wait for
  the transfer before a single-shot read, and on teardown disable the
  interrupt and wait for the last transfer.

- The return value of spi_async() and the status of the RDATA message
  are ignored: a failure leaves the transfer counter stuck, and a failed
  transfer is reported as a sample. Handle both.

- read_raw takes the sample out of rx_buffer after releasing direct
  mode, so a buffer enabled in between can overwrite it. Take it while
  direct mode is still held.

The first, second and last were found by review and not reproduced.
The third and fourth were found by review and reproduced on an emulated
device only.

Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 183 +++++++++++++++++++++++++++--------
 1 file changed, 144 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 06c6353aa..1d32b1f47 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
 #include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/module.h>
@@ -18,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/units.h>
+#include <linux/wait.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -119,15 +121,26 @@ struct ads1298_private {
 	 * >2 = Multiple DRDY during transfer, lost rdata_xfer_busy - 2 samples
 	 */
 	unsigned int rdata_xfer_busy;
+	/* Samples go to the buffer; under irq_busy_lock */
+	bool buffered;
+	/* Woken when rdata_xfer_busy drops to 0 */
+	wait_queue_head_t idle_wq;
+	/* Status of the last single-shot read */
+	int rdata_status;
 
 	/* Temporary storage for demuxing data after SPI transfer */
 	u32 bounce_buffer[ADS1298_MAX_CHANNELS];
 
-	/* For synchronous SPI exchanges (read/write registers) */
-	u8 cmd_buffer[ADS1298_SPI_CMD_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
-
+	/*
+	 * Each buffer below is used by one path at a time and has its own
+	 * cacheline, so that no two transfers in flight share one.
+	 */
+	/* Register access, under the regmap lock */
+	u8 reg_buffer[ADS1298_SPI_CMD_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
+	/* Commands, under the IIO device lock or in probe */
+	u8 cmd_buffer[1] __aligned(IIO_DMA_MINALIGN);
 	/* Buffer used for incoming SPI data */
-	u8 rx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE_MAX];
+	u8 rx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE_MAX] __aligned(IIO_DMA_MINALIGN);
 	/* Contains the RDATA command and zeroes to clock out */
 	u8 tx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE_MAX];
 };
@@ -185,10 +198,49 @@ static int ads1298_write_cmd(struct ads1298_private *priv, u8 command)
 	return spi_sync_transfer(priv->spi, &xfer, 1);
 }
 
+/* Whether no RDATA transfer is queued or in flight */
+static bool ads1298_rdata_idle(struct ads1298_private *priv)
+{
+	guard(spinlock_irqsave)(&priv->irq_busy_lock);
+	return !priv->rdata_xfer_busy;
+}
+
+static int ads1298_wait_rdata_idle(struct ads1298_private *priv)
+{
+	if (!wait_event_timeout(priv->idle_wq, ads1298_rdata_idle(priv),
+				msecs_to_jiffies(100)))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+/* Called with irq_busy_lock held */
+static void ads1298_rdata_start(struct ads1298_private *priv)
+{
+	int ret;
+
+	ret = spi_async(priv->spi, &priv->rdata_msg);
+	if (!ret)
+		return;
+
+	/* No completion will run for this transfer */
+	priv->rdata_xfer_busy = 0;
+	if (!priv->buffered) {
+		priv->rdata_status = ret;
+		complete(&priv->completion);
+	}
+	wake_up(&priv->idle_wq);
+}
+
 static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
 {
 	int ret;
 
+	/* A transfer left over from an earlier timeout must finish first */
+	ret = ads1298_wait_rdata_idle(priv);
+	if (ret)
+		return ret;
+
 	/* Enable the channel */
 	ret = regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(chan_index),
 				 ADS1298_MASK_CH_PD, 0);
@@ -217,7 +269,7 @@ static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
 	if (!wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50)))
 		return -ETIMEDOUT;
 
-	return 0;
+	return priv->rdata_status;
 }
 
 static int ads1298_get_samp_freq(struct ads1298_private *priv, int *val)
@@ -330,14 +382,17 @@ static int ads1298_read_raw(struct iio_dev *indio_dev,
 			return -EBUSY;
 
 		ret = ads1298_read_one(priv, chan->scan_index);
+		/* Once direct mode is released, a buffer may overwrite rx_buffer */
+		if (!ret)
+			*val = sign_extend32(get_unaligned_be24(priv->rx_buffer +
+								chan->address),
+					     ADS1298_BITS_PER_SAMPLE - 1);
 
 		iio_device_release_direct(indio_dev);
 
 		if (ret)
 			return ret;
 
-		*val = sign_extend32(get_unaligned_be24(priv->rx_buffer + chan->address),
-				     ADS1298_BITS_PER_SAMPLE - 1);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		return ads1298_get_scale(priv, chan->channel, val, val2);
@@ -373,8 +428,8 @@ static int ads1298_reg_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct ads1298_private *priv = context;
 	struct spi_transfer reg_write_xfer = {
-		.tx_buf = priv->cmd_buffer,
-		.rx_buf = priv->cmd_buffer,
+		.tx_buf = priv->reg_buffer,
+		.rx_buf = priv->reg_buffer,
 		.len = 3,
 		.speed_hz = ADS1298_SPI_BUS_SPEED_SLOW,
 		.delay = {
@@ -383,9 +438,9 @@ static int ads1298_reg_write(void *context, unsigned int reg, unsigned int val)
 		},
 	};
 
-	priv->cmd_buffer[0] = ADS1298_CMD_WREG | reg;
-	priv->cmd_buffer[1] = 0; /* Number of registers to be written - 1 */
-	priv->cmd_buffer[2] = val;
+	priv->reg_buffer[0] = ADS1298_CMD_WREG | reg;
+	priv->reg_buffer[1] = 0; /* Number of registers to be written - 1 */
+	priv->reg_buffer[2] = val;
 
 	return spi_sync_transfer(priv->spi, &reg_write_xfer, 1);
 }
@@ -394,8 +449,8 @@ static int ads1298_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct ads1298_private *priv = context;
 	struct spi_transfer reg_read_xfer = {
-		.tx_buf = priv->cmd_buffer,
-		.rx_buf = priv->cmd_buffer,
+		.tx_buf = priv->reg_buffer,
+		.rx_buf = priv->reg_buffer,
 		.len = 3,
 		.speed_hz = ADS1298_SPI_BUS_SPEED_SLOW,
 		.delay = {
@@ -405,15 +460,15 @@ static int ads1298_reg_read(void *context, unsigned int reg, unsigned int *val)
 	};
 	int ret;
 
-	priv->cmd_buffer[0] = ADS1298_CMD_RREG | reg;
-	priv->cmd_buffer[1] = 0; /* Number of registers to be read - 1 */
-	priv->cmd_buffer[2] = 0;
+	priv->reg_buffer[0] = ADS1298_CMD_RREG | reg;
+	priv->reg_buffer[1] = 0; /* Number of registers to be read - 1 */
+	priv->reg_buffer[2] = 0;
 
 	ret = spi_sync_transfer(priv->spi, &reg_read_xfer, 1);
 	if (ret)
 		return ret;
 
-	*val = priv->cmd_buffer[2];
+	*val = priv->reg_buffer[2];
 
 	return 0;
 }
@@ -429,13 +484,6 @@ static int ads1298_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return regmap_write(priv->regmap, reg, writeval);
 }
 
-static void ads1298_rdata_unmark_busy(struct ads1298_private *priv)
-{
-	/* Notify we're no longer waiting for the SPI transfer to complete */
-	guard(spinlock_irqsave)(&priv->irq_busy_lock);
-	priv->rdata_xfer_busy = 0;
-}
-
 static int ads1298_update_scan_mode(struct iio_dev *indio_dev,
 				    const unsigned long *scan_mask)
 {
@@ -444,8 +492,10 @@ static int ads1298_update_scan_mode(struct iio_dev *indio_dev,
 	int ret;
 	int i;
 
-	/* Make the interrupt routines start with a clean slate */
-	ads1298_rdata_unmark_busy(priv);
+	/* Nothing may be in flight when the buffer starts */
+	ret = ads1298_wait_rdata_idle(priv);
+	if (ret)
+		return ret;
 
 	/* Configure power-down bits to match scan mask */
 	for (i = 0; i < indio_dev->num_channels; i++) {
@@ -470,22 +520,22 @@ static void ads1298_rdata_release_busy_or_restart(struct ads1298_private *priv)
 {
 	guard(spinlock_irqsave)(&priv->irq_busy_lock);
 
-	if (priv->rdata_xfer_busy > 1) {
+	if (priv->buffered && priv->rdata_xfer_busy > 1) {
 		/*
 		 * DRDY interrupt occurred before SPI completion. Start a new
 		 * SPI transaction now to retrieve the data that wasn't latched
 		 * into the ADS1298 chip's transfer buffer yet.
-		 */
-		spi_async(priv->spi, &priv->rdata_msg);
-		/*
+		 *
 		 * If more than one DRDY took place, there was an overrun. Since
 		 * the sample is already lost, reset the counter to 1 so that
 		 * we will wait for a DRDY interrupt after this SPI transaction.
 		 */
 		priv->rdata_xfer_busy = 1;
+		ads1298_rdata_start(priv);
 	} else {
 		/* No pending data, wait for DRDY */
 		priv->rdata_xfer_busy = 0;
+		wake_up(&priv->idle_wq);
 	}
 }
 
@@ -494,19 +544,32 @@ static void ads1298_rdata_complete(void *context)
 {
 	struct iio_dev *indio_dev = context;
 	struct ads1298_private *priv = iio_priv(indio_dev);
+	int status = priv->rdata_msg.status;
 	int scan_index;
 	u32 *bounce = priv->bounce_buffer;
+	bool buffered;
 
-	if (!iio_buffer_enabled(indio_dev)) {
+	/* Only changes while no transfer is in flight */
+	scoped_guard(spinlock_irqsave, &priv->irq_busy_lock)
+		buffered = priv->buffered;
+
+	if (!buffered) {
 		/*
 		 * for a single transfer mode we're kept in direct_mode until
 		 * completion, avoiding a race with buffered IO.
 		 */
-		ads1298_rdata_unmark_busy(priv);
+		priv->rdata_status = status;
+		ads1298_rdata_release_busy_or_restart(priv);
 		complete(&priv->completion);
 		return;
 	}
 
+	/* A failed transfer leaves no sample to push */
+	if (status) {
+		ads1298_rdata_release_busy_or_restart(priv);
+		return;
+	}
+
 	/* Demux the channel data into our bounce buffer */
 	iio_for_each_active_channel(indio_dev, scan_index) {
 		const struct iio_chan_spec *scan_chan =
@@ -516,10 +579,13 @@ static void ads1298_rdata_complete(void *context)
 		*bounce++ = get_unaligned_be24(data);
 	}
 
-	/* rx_buffer can be overwritten from this point on */
-	ads1298_rdata_release_busy_or_restart(priv);
-
+	/*
+	 * Push before marking the transfer done: predisable waits for that,
+	 * and the scan must not be torn down while it is used here.
+	 */
 	iio_push_to_buffers(indio_dev, priv->bounce_buffer);
+
+	ads1298_rdata_release_busy_or_restart(priv);
 }
 
 static irqreturn_t ads1298_interrupt(int irq, void *dev_id)
@@ -533,7 +599,7 @@ static irqreturn_t ads1298_interrupt(int irq, void *dev_id)
 	wasbusy = priv->rdata_xfer_busy++;
 	/* When no SPI transfer in transit, start one now */
 	if (!wasbusy)
-		spi_async(priv->spi, &priv->rdata_msg);
+		ads1298_rdata_start(priv);
 
 	return IRQ_HANDLED;
 };
@@ -549,14 +615,39 @@ static int ads1298_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	return ads1298_write_cmd(priv, ADS1298_CMD_START);
+	scoped_guard(spinlock_irqsave, &priv->irq_busy_lock)
+		priv->buffered = true;
+
+	ret = ads1298_write_cmd(priv, ADS1298_CMD_START);
+	if (ret) {
+		scoped_guard(spinlock_irqsave, &priv->irq_busy_lock)
+			priv->buffered = false;
+	}
+
+	return ret;
 }
 
 static int ads1298_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ads1298_private *priv = iio_priv(indio_dev);
+	int ret, ret2;
+	int rate;
+
+	ret = ads1298_write_cmd(priv, ADS1298_CMD_STOP);
+
+	/*
+	 * The conversion in progress completes and raises DRDY once more.
+	 * Wait for it and for its transfer before the core tears down the
+	 * scan.
+	 */
+	if (ads1298_get_samp_freq(priv, &rate) >= 0 && rate > 0)
+		fsleep(2 * DIV_ROUND_UP(USEC_PER_SEC, rate));
+	ret2 = ads1298_wait_rdata_idle(priv);
 
-	return ads1298_write_cmd(priv, ADS1298_CMD_STOP);
+	scoped_guard(spinlock_irqsave, &priv->irq_busy_lock)
+		priv->buffered = false;
+
+	return ret ?: ret2;
 }
 
 static const struct iio_buffer_setup_ops ads1298_setup_ops = {
@@ -569,6 +660,15 @@ static void ads1298_reg_disable(void *reg)
 	regulator_disable(reg);
 }
 
+static void ads1298_quiesce(void *data)
+{
+	struct ads1298_private *priv = data;
+
+	/* No new transfer may start, and the last one must end, before teardown */
+	disable_irq(priv->spi->irq);
+	ads1298_wait_rdata_idle(priv);
+}
+
 static const struct regmap_range ads1298_regmap_volatile_range[] = {
 	regmap_reg_range(ADS1298_REG_LOFF_STATP, ADS1298_REG_LOFF_STATN),
 };
@@ -690,6 +790,7 @@ static int ads1298_probe(struct spi_device *spi)
 
 	priv->spi = spi;
 	init_completion(&priv->completion);
+	init_waitqueue_head(&priv->idle_wq);
 	spin_lock_init(&priv->irq_busy_lock);
 	priv->regmap = devm_regmap_init(dev, NULL, priv, &ads1298_regmap_config);
 	if (IS_ERR(priv->regmap))
@@ -735,6 +836,10 @@ static int ads1298_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, ads1298_quiesce, priv);
+	if (ret)
+		return ret;
+
 	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &ads1298_setup_ops);
 	if (ret)
 		return ret;
-- 
2.43.0

