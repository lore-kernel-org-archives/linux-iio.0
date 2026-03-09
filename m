Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910233783A3
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053151; cv=none; b=F4rGalzZQJzgEsynCpnQ9bTNvHjyGxTpEwRcl2Hd3kL3/kxvBTuISXaDU49uaZq/Vvy1FiK8NGvEz0Zr5BPGBNDnQU0tQisgExRnUst3afUcEQpV5o1gNFd3EICW2dS48Ij/et6G/RSRZgRoPjvsrne+zP7+bi7IZwXsb3AMypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053151; c=relaxed/simple;
	bh=dpKzNAnS8HQPu4PRJGiva2/2RDBESK1CeKhJa0iML2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK+bjiJYYhV9W0n/8YWH//lFhryvBxgA68X0OXMOSd7eCq6GbCKiB4XPT5nR3U+dgje/n4v3b/5+mtIsa3lsQM8FheHL40BV29m9Ev7iQM4MFlN6lOvJlIQZ930IqsrsjMJRUQMnXLz7iMJJAs58CaIViajUcAnktRVLjPfyygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbUTRg/9; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbUTRg/9"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c73aabd620bso1094965a12.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773053149; x=1773657949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1+4zFEYGwSJBUTzwJys2AMyShZGJ2AyoitkWaRrBOI=;
        b=WbUTRg/9KRaFmehKxPGNjg/tC6oGXTW62cSgT98r0+mphoMGEGlmvQP7TehqrTjf1n
         +0I8vTFpDv8BM1Ozt35bacDvdrrLoDcAxNGUpPEL+enwRgXSdhsbx8C3Se8CqyMIa6/X
         8Ty4en3Z4m83hv58TTq7AipHEoSI80fDYl10iQ8GVfDnvtNIa5SqEktBwK6qmzw7dK0e
         TR3SDt5qqXor9eUgLIkw5SVGUodHJXNhEnv+sjawcDVbwPjnBYclG04PbnG5fXmcO4vH
         RLA8ONMUFt7dhRPprmeSsSfvkI7YVu2F3bWulfsfyBR06CN4ndRJO5DBSZiNCfZbHCIP
         H4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773053149; x=1773657949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x1+4zFEYGwSJBUTzwJys2AMyShZGJ2AyoitkWaRrBOI=;
        b=oQgbJYrIhw7LKMJ2ODaZ3q7oiJkcEG469T4Ofrbv3GifcBzF/jmDocyH6M8ITdtufF
         eKR4ZCt1AXAVCDVzU4Yd+Yle2/DeUtmv5+RxceRhRYdWhRoykXrTlYoeet5/xt95haDH
         +RrsH6UPJlS1UQ2xo2b+/EWvXUAYEwoKepn5qYZdWjEYX0WF2ccBZAlAdGg1LLG9Jk+V
         R2rKKquwMMiqnL9k4getWlAsFrfL4wlSeT6SBLPAr6Vd2vZcLPA7Hnmpz9ptTGXWHJb6
         2p7jn2gAR5XOgMB5C5OS3CQyg4JzQPeANLRVFxJs18rM8nXQ/M+As/RgwoKaqkgFxT1b
         cd9g==
X-Forwarded-Encrypted: i=1; AJvYcCUoi2B0H+zgawiY40XqZ+PS5YnjCEB2ULV2ZfYiKFQq8c69R80MYnn2yj+kyTHeZ1dyXg0PAo+asXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxDlZW95v4hJ1ucAtFlWIvLW5+OIbSPbwoEQ7R62UQcvyjGbhi
	7apG3jQHGd3+FA+VAnqLI8wtPqmmi5W/xTL9qp2LI8i6H967xjPEMGmB
X-Gm-Gg: ATEYQzxqNgKe6PHfMVwxMES2txSAYQaq3TcbOWjvu9SrsJ9+5lbPMSB4vbQGMCHkeLJ
	NE3iTjoIv4ZileEdwLuWneK7pM90g8Sq5g4NtAb06a25nTf+sNRpTxC4Ebd81e+H2EeWmTPVHh3
	TLjEuVyt1MSNrke9oxW5XE12P9Cd7pIoSwHqX9sbcLxLc42yo3KwAdJ/BFcX81YnbX0OBRV1UP2
	krNQZQEGH/pCg3o9X6mRTYusHij4Izy1OWk1ko2dg60Gus7dIXu39P/WZ+6kF3dOsfXIZURZWX4
	r/o9ZSiaDpqqhX4l6vYsF42GTX7uh0lYJ3z/lGxoyLJq0yTzdjS62Pv6dcfENRDYEu1eSOGUHVT
	2U4v15hV91A/XxSaqpWtUnw9hl1wKc7URxke+JEP5Tp5Kb7YlLSIsOc5GH2mQs3sWl7x2UaQNZO
	ahGSO60bokT7H1X2oFlkxe5Z8m
X-Received: by 2002:a05:6300:6710:b0:394:642e:ff2c with SMTP id adf61e73a8af0-398590b3e8cmr9303224637.50.1773053148837;
        Mon, 09 Mar 2026 03:45:48 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:2ea1:a1a7:f2aa:545b:3c1e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4657445sm10276143b3a.17.2026.03.09.03.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 03:45:48 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v3 2/6] iio: adc: fix spelling mistakes in comments
Date: Mon,  9 Mar 2026 16:15:09 +0530
Message-ID: <20260309104513.40359-3-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309104513.40359-1-i.shihao.999@gmail.com>
References: <20260309104513.40359-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were several spelling mistakes in comments such as mulitiply,
referrence, ocurring, consequtive, and celcius, as well as other
occurrences. Fix these spelling mistakes to improve code readability
and consistency.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/adc/ad4030.c           | 2 +-
 drivers/iio/adc/ad4170-4.c         | 6 +++---
 drivers/iio/adc/ad7380.c           | 2 +-
 drivers/iio/adc/ad7887.c           | 2 +-
 drivers/iio/adc/ad7923.c           | 4 ++--
 drivers/iio/adc/at91_adc.c         | 4 ++--
 drivers/iio/adc/max1363.c          | 2 +-
 drivers/iio/adc/mcp3564.c          | 2 +-
 drivers/iio/adc/men_z188_adc.c     | 2 +-
 drivers/iio/adc/npcm_adc.c         | 2 +-
 drivers/iio/adc/palmas_gpadc.c     | 2 +-
 drivers/iio/adc/rohm-bd79124.c     | 4 ++--
 drivers/iio/adc/spear_adc.c        | 2 +-
 drivers/iio/adc/stm32-adc-core.c   | 2 +-
 drivers/iio/adc/stm32-adc.c        | 2 +-
 drivers/iio/adc/sun20i-gpadc-iio.c | 2 +-
 drivers/iio/adc/ti_am335x_adc.c    | 2 +-
 drivers/iio/adc/twl4030-madc.c     | 2 +-
 drivers/iio/adc/twl6030-gpadc.c    | 2 +-
 19 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 68446db9bef1..eb56043c7424 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -623,7 +623,7 @@ static int ad4030_conversion(struct iio_dev *indio_dev)
	/* Add one byte if we are using a differential + common byte mode */
	bytes_to_read += (st->mode == AD4030_OUT_DATA_MD_24_DIFF_8_COM ||
			st->mode == AD4030_OUT_DATA_MD_16_DIFF_8_COM) ? 1 : 0;
-	/* Mulitiply by the number of hardware channels */
+	/* Multiply by the number of hardware channels */
	bytes_to_read *= st->chip->num_voltage_inputs;

	for (i = 0; i < cnv_nb; i++) {
diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 82205bfae531..77af0e6b2c59 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -275,9 +275,9 @@ static const unsigned int ad4170_reg_size[] = {
 };

 enum ad4170_ref_buf {
-	AD4170_REF_BUF_PRE,	/* Pre-charge referrence buffer */
-	AD4170_REF_BUF_FULL,	/* Full referrence buffering */
-	AD4170_REF_BUF_BYPASS,	/* Bypass referrence buffering */
+	AD4170_REF_BUF_PRE,	/* Pre-charge reference buffer */
+	AD4170_REF_BUF_FULL,	/* Full reference buffering */
+	AD4170_REF_BUF_BYPASS,	/* Bypass reference buffering */
 };

 /* maps adi,positive/negative-reference-buffer property values to enum */
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index bfd908deefc0..074198877816 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1850,7 +1850,7 @@ static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,

	/*
	 * Starting with a quite low frequency, to allow oversampling x32,
-	 * user is then reponsible to adjust the frequency for the specific case.
+	 * user is then responsible to adjust the frequency for the specific case.
	 */
	ret = ad7380_set_sample_freq(st, sample_rate / 32);
	if (ret)
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 87ff95643794..cf1fbc05d098 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -104,7 +104,7 @@ static int ad7887_ring_postdisable(struct iio_dev *indio_dev)
 {
	struct ad7887_state *st = iio_priv(indio_dev);

-	/* dummy read: restore default CH0 settin */
+	/* dummy read: restore default CH0 setting */
	return spi_sync(st->spi, &st->msg[AD7887_CH0]);
 }

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 0369151c7db1..acc87d486aa4 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -30,7 +30,7 @@
 #define AD7923_PM_MODE_AS	(1)		/* auto shutdown */
 #define AD7923_PM_MODE_FS	(2)		/* full shutdown */
 #define AD7923_PM_MODE_OPS	(3)		/* normal operation */
-#define AD7923_SEQUENCE_OFF	(0)		/* no sequence fonction */
+#define AD7923_SEQUENCE_OFF	(0)		/* no sequence function */
 #define AD7923_SEQUENCE_PROTECT	(2)		/* no interrupt write cycle */
 #define AD7923_SEQUENCE_ON	(3)		/* continuous sequence */

@@ -39,7 +39,7 @@
 #define AD7923_CHANNEL_WRITE(channel)	((channel) << 6) /* write channel */
 #define AD7923_SEQUENCE_WRITE(sequence)	((((sequence) & 1) << 3) \
					+ (((sequence) & 2) << 9))
-						/* write sequence fonction */
+						/* write sequence function */
 /* left shift for CR : bit 11 transmit in first */
 #define AD7923_SHIFT_REGISTER	4

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 920dd9ffd27a..d33ad19fa33d 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -171,7 +171,7 @@ struct at91_adc_trigger {
 };

 /**
- * struct at91_adc_reg_desc - Various informations relative to registers
+ * struct at91_adc_reg_desc - Various information relative to registers
  * @channel_base:	Base offset for the channel data registers
  * @drdy_mask:		Mask of the DRDY field in the relevant registers
  *			(Interruptions registers mostly)
@@ -231,7 +231,7 @@ struct at91_adc_state {
	struct iio_trigger	**trig;
	bool			use_external;
	u32			vref_mv;
-	u32			res;		/* resolution used for convertions */
+	u32			res;		/* resolution used for conversions */
	wait_queue_head_t	wq_data_avail;
	const struct at91_adc_caps	*caps;

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 9dd547e62b6c..d35f4487b2f9 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -121,7 +121,7 @@ enum max1363_modes {
 };

 /**
- * struct max1363_chip_info - chip specifc information
+ * struct max1363_chip_info - chip specific information
  * @info:		iio core function callbacks structure
  * @channels:		channel specification
  * @num_channels:       number of channels
diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index fcdf13f49c48..36675563829e 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -349,7 +349,7 @@ struct mcp3564_chip_info {
  * struct mcp3564_state - working data for a ADC device
  * @chip_info:		chip specific data
  * @spi:		SPI device structure
- * @vref_mv:		voltage reference value in miliVolts
+ * @vref_mv:		voltage reference value in millivolts
  * @lock:		synchronize access to driver's state members
  * @dev_addr:		hardware device address
  * @oversampling:	the index inside oversampling list of the ADC
diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
index 90919d282e7b..5bd334ec5655 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * MEN 16z188 Analog to Digial Converter
+ * MEN 16z188 Analog to Digital Converter
  *
  * Copyright (C) 2014 MEN Mikroelektronik GmbH (www.men.de)
  * Author: Johannes Thumshirn <johannes.thumshirn@men.de>
diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index c8283873cdee..ddabb9600d46 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -38,7 +38,7 @@ struct npcm_adc {
	 * read access from userspace. Reading a raw value requires a sequence
	 * of register writes, then a wait for a event and finally a register
	 * read, during which userspace could issue another read request.
-	 * This lock protects a read access from ocurring before another one
+	 * This lock protects a read access from occurring before another one
	 * has finished.
	 */
	struct mutex lock;
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 3f433064618e..3aea12e9d4fb 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -105,7 +105,7 @@ struct palmas_gpadc_thresholds {
  *		of register writes, then a wait for a completion callback,
  *		and finally a register read, during which userspace could issue
  *		another read request. This lock protects a read access from
- *		ocurring before another one has finished.
+ *		occurring before another one has finished.
  *
  * This is the palmas_gpadc structure to store run-time information
  * and pointers for this driver instance.
diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
index fc0452749b79..40d00bd0cc9d 100644
--- a/drivers/iio/adc/rohm-bd79124.c
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -75,7 +75,7 @@

 /*
  * The high limit, low limit and last measurement result are each stored in
- * 2 consequtive registers. 4 bits are in the high bits of the first register
+ * 2 consecutive registers. 4 bits are in the high bits of the first register
  * and 8 bits in the next register.
  *
  * These macros return the address of the first reg for the given channel.
@@ -962,7 +962,7 @@ static int bd79124_hw_init(struct bd79124_data *data)
	if (ret)
		return ret;

-	/* Enable writing the measured values to the regsters */
+	/* Enable writing the measured values to the registers */
	ret = regmap_set_bits(data->map, BD79124_REG_GEN_CFG,
			      BD79124_MSK_STATS_EN);
	if (ret)
diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 50b0a607baeb..91995489bb1c 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -82,7 +82,7 @@ struct spear_adc_state {
	 * of register writes, then a wait for a completion callback,
	 * and finally a register read, during which userspace could issue
	 * another read request. This lock protects a read access from
-	 * ocurring before another one has finished.
+	 * occurring before another one has finished.
	 */
	struct mutex lock;
	u32 current_clk;
diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index e39a4c0db25e..a42d82d61cb8 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -227,7 +227,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
	if (priv->aclk) {
		/*
		 * Asynchronous clock modes (e.g. ckmode == 0)
-		 * From spec: PLL output musn't exceed max rate
+		 * From spec: PLL output mustn't exceed max rate
		 */
		rate = clk_get_rate(priv->aclk);
		if (!rate) {
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 2d7f88459c7c..46106200bb86 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1662,7 +1662,7 @@ static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
		/*
		 * Clear ovr bit to avoid subsequent calls to IRQ handler.
		 * This requires to stop ADC first. OVR bit state in ISR,
-		 * is propaged to CSR register by hardware.
+		 * is propagated to CSR register by hardware.
		 */
		adc->cfg->stop_conv(indio_dev);
		stm32_adc_irq_clear(indio_dev, regs->isr_ovr.mask);
diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
index e4dfe76e6362..861c14da75ad 100644
--- a/drivers/iio/adc/sun20i-gpadc-iio.c
+++ b/drivers/iio/adc/sun20i-gpadc-iio.c
@@ -55,7 +55,7 @@ struct sun20i_gpadc_iio {
	 * of register writes, then a wait for a completion callback,
	 * and finally a register read, during which userspace could issue
	 * another read request. This lock protects a read access from
-	 * ocurring before another one has finished.
+	 * occurring before another one has finished.
	 */
	struct mutex		lock;
 };
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index a1a28584de93..668198708136 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -116,7 +116,7 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
	 * Steps forwards i.e. from 0 towards 16 are used by ADC
	 * depending on number of input lines needed.
	 * Channel would represent which analog input
-	 * needs to be given to ADC to digitalize data.
+	 * needs to be given to ADC to digitize data.
	 */
	for (i = 0; i < adc_dev->channels; i++) {
		int chan;
diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index fe3b31ec976e..f0274cd74973 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -252,7 +252,7 @@ static const struct s16_fract twl4030_divider_ratios[16] = {
	{5, 11},	/* CHANNEL 15 */
 };

-/* Conversion table from -3 to 55 degrees Celcius */
+/* Conversion table from -3 to 55 degrees Celsius */
 static int twl4030_therm_tbl[] = {
	30800,	29500,	28300,	27100,
	26000,	24900,	23900,	22900,	22000,	21100,	20300,	19400,	18700,
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 3ac774ebf678..7810d6b2b668 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -416,7 +416,7 @@ static u8 twl6032_channel_to_reg(int channel)
 {
	/*
	 * for any prior chosen channel, when the conversion is ready
-	 * the result is avalable in GPCH0_LSB, GPCH0_MSB.
+	 * the result is available in GPCH0_LSB, GPCH0_MSB.
	 */

	return TWL6032_GPADC_GPCH0_LSB;
--
2.53.0
