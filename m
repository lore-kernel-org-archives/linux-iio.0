Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E033396B9C
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935768; cv=none; b=D16WuJjdsBiCvQYP4W/cP/mx5KN4Gii58JupwkWWr2fZvaZaB86tMreLmvLeRP8pMhZYkUvGQuHFz/jNKo84coZYlUNcG9RM+RI589GMw7ue7gJvukBx9bR++AOIJEeoy0TLN+2vZP9W4rybawazuxccc5KlR0OUkptCDQtEb8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935768; c=relaxed/simple;
	bh=MT8uvM8l0kRVf9pMNs3Ul3rgvOQ7PLOEeWBhUBV+AJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i18IeT7eUG2wZmiXalIozthhP3derD7gdJgOUuL548++/UxVmMvp2IP+j3wPy8WS4oBE21orMNv7Z6h1DmFXCA1QwUMZzun7qgwpSRhi1bfzDNagskaRphmUktnr9wdTLET3Er5a97R/XjEvqHnNCUSnxVhCKZj3x7wnLHw2ZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A14NVbRf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A14NVbRf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806fd9033bso7567675e9.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 04:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771935765; x=1772540565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrHPev5XYSZQTvZH8SaHnakXK3hl/tOE+3HyCGJvQlg=;
        b=A14NVbRf19WzeTbQNjdH446vlRo3aiatTOtxb6HnyfC3aB566HJbaoST4v/xMvNxsY
         P4Yz9+f0vrc6ZTgCgHPxzy6kAqv4KdmYj7qJ4XKVGbEqqttx0GNQpUR37bJkLhE+iCum
         5A2rfScwWb2Ache6ffhRWJ0oTPhcL3F+gDdhHXJCdtyK9dEUDSoIyjSzuCD0FDPm6hW6
         UZZHXANX0cGG8w1T93qy+At0XKJmHat+kryTxCRiCVP/AWKWy4pAhU0akmpBoj7IHh+z
         cjd+R8rM/G60745uWRMWyMsAr4jM2AA3ftUCvCD5bOIYB9R9orIRpS9Piudgm+pG+3jS
         cy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935765; x=1772540565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yrHPev5XYSZQTvZH8SaHnakXK3hl/tOE+3HyCGJvQlg=;
        b=TCi/cINSf9kVpMvpPuAxJqSwVk7GshjNggQqd8Ug9XiKG3tP0bQgXlkCvdf0vzdGF0
         Ozc+FNmFAufwiTCbxv0Cr2IPm21lJyRcSYCCz4b8m5OvAocwZVmUQaj48OIFqUrYiSqP
         aEmxGNtfwcNH54C5HTVls+W33YeI8pyu8mcUHTJjSvxOHgHror4sZHjy9woa/xhd4mtK
         fSM0BOh8A3xY8p5Ruw9/hYmw7Go+M8TPHkeZxssvXJVWQUM9I+tuefhv5r5trjXqcoqk
         JouCWNTzvZ46w4tW0oQ5/bjOLYbuRnO/2ERngqUY/JIRJEll1Ihn6rnywpYshktt6goi
         P5kA==
X-Forwarded-Encrypted: i=1; AJvYcCXvYYXVqwIzbv0Sg9GpDFg3Qg9Fh5IO5YzKnEzwQSbz2tmXvNXrKGHCnBMVhaagNC+78VUjYA/88xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYGZ8ppsWUm8vzWAINdNb0vxO+rNvqLX8OUD4knCoQb1VOTsc8
	W9dEomoUT1Mtlh/bcnphW4U2zySJBT/f3wAFHtwJ4tZ7wI7HVv05G5bG
X-Gm-Gg: AZuq6aJ09ptsZul8G7Ak9vaBr8kywq7+/8n+mWNMTI0U93bfBJbPpESXxxBx5aSz0fR
	3h3vWjRkcYE5XdNjT/MA5e08teYm5XSykZK1w9vlLNhfe5EYJp+GF1VkMmeBcymK6gdxtldkZxz
	E2RtR/m1s3dVzCjyDmcRTPCuTX+m8dGr3XkyzB5lxtyhTvAq+VC/V/1kUoCLRgej7ppHkbQvRUV
	N/uCRLtNnkoCET3017dYO+82Cl+LziAyCmioSwsbdPm4TQMI1qCWSoUKhRhx8w8wHiiiczzpolm
	SCcE+9nlGlpshORRpCl1Kr2MUVMZ9xiJKf2w61Zk7vKopzvV5HeIxuQFaJFLFTTeUG7rsd0/Oxg
	Il7zWpV7Bi0hDpZKD8jiBNRB3k/ohKJjGW3fB2D1yYlEr7J45b9rBUNiiKNesiwn4GYQe0j8p5m
	KUnNO3DglZ3sf0oO1rhKy0i1y6cOSivy+N4/orFrkfv+czO1NqObK2l9A49c3hlZocW+AR3Z169
	Y/tN+OC1BVYQBNGOuWYHP0n3tpmoP/LPMtj80wXtkDCyOlmCUp8
X-Received: by 2002:a05:600c:154c:b0:483:7631:befd with SMTP id 5b1f17b1804b1-483a95fc285mr120089195e9.7.1771935764255;
        Tue, 24 Feb 2026 04:22:44 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b822c9a5sm29878445e9.2.2026.02.24.04.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:22:42 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: jic23@kernel.org
Cc: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: fix typos found by codespell
Date: Tue, 24 Feb 2026 16:22:30 +0400
Message-ID: <20260224122230.67426-1-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224111744.55378-2-giorgitchankvetadze1997@gmail.com>
References: <20260224111744.55378-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various spelling mistakes in comments and error messages
across drivers/iio/adc/, found by running codespell.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
v2: expand to fix all typos across drivers/iio/adc/ (Andy)

 drivers/iio/adc/ad4030.c           | 2 +-
 drivers/iio/adc/ad4170-4.c         | 6 +++---
 drivers/iio/adc/ad7380.c           | 2 +-
 drivers/iio/adc/ad7793.c           | 2 +-
 drivers/iio/adc/ad7887.c           | 2 +-
 drivers/iio/adc/ad7923.c           | 4 ++--
 drivers/iio/adc/ade9000.c          | 2 +-
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 drivers/iio/adc/at91_adc.c         | 4 ++--
 drivers/iio/adc/fsl-imx25-gcq.c    | 2 +-
 drivers/iio/adc/max1363.c          | 2 +-
 drivers/iio/adc/mcp3564.c          | 2 +-
 drivers/iio/adc/men_z188_adc.c     | 2 +-
 drivers/iio/adc/nau7802.c          | 2 +-
 drivers/iio/adc/npcm_adc.c         | 2 +-
 drivers/iio/adc/pac1921.c          | 2 +-
 drivers/iio/adc/palmas_gpadc.c     | 2 +-
 drivers/iio/adc/rohm-bd79124.c     | 4 ++--
 drivers/iio/adc/spear_adc.c        | 2 +-
 drivers/iio/adc/stm32-adc-core.c   | 2 +-
 drivers/iio/adc/stm32-adc.c        | 2 +-
 drivers/iio/adc/sun20i-gpadc-iio.c | 2 +-
 drivers/iio/adc/twl4030-madc.c     | 2 +-
 drivers/iio/adc/twl6030-gpadc.c    | 2 +-
 24 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index def3e1d01ceb..eebb6f5835ad 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -629,7 +629,7 @@ static int ad4030_conversion(struct iio_dev *indio_dev)
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
index ca411371816f..9f77990a03f9 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1862,7 +1862,7 @@ static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,
 
 	/*
 	 * Starting with a quite low frequency, to allow oversampling x32,
-	 * user is then reponsible to adjust the frequency for the specific case.
+	 * user is then responsible to adjust the frequency for the specific case.
 	 */
 	ret = ad7380_set_sample_freq(st, sample_rate / 32);
 	if (ret)
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index ccf18ce48e34..b6d86c62f24a 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -805,7 +805,7 @@ static int ad7793_probe(struct spi_device *spi)
 
 		vref_mv = ret / 1000;
 	} else {
-		vref_mv = 1170; /* Build-in ref */
+		vref_mv = 1170; /* Built-in ref */
 	}
 
 	st->chip_info =
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
 
diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 5dcc26a08970..4b96651e6cd9 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1549,7 +1549,7 @@ static int ade9000_buffer_postdisable(struct iio_dev *indio_dev)
 
 	ret = regmap_clear_bits(st->regmap, ADE9000_REG_MASK0, interrupts);
 	if (ret) {
-		dev_err(dev, "Post-disable update maks0 fail\n");
+		dev_err(dev, "Post-disable update mask0 fail\n");
 		return ret;
 	}
 
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index aa4ba3f5a506..69bb49434f90 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2507,7 +2507,7 @@ static int at91_adc_suspend(struct device *dev)
 		at91_adc_buffer_postdisable(indio_dev);
 
 	/*
-	 * Do a sofware reset of the ADC before we go to suspend.
+	 * Do a software reset of the ADC before we go to suspend.
 	 * this will ensure that all pins are free from being muxed by the ADC
 	 * and can be used by for other devices.
 	 * Otherwise, ADC will hog them and we can't go to suspend mode.
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 8942d15b3978..6e1930f7c65d 100644
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
 
diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index f8c220f6a7b4..e6268f7ac400 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -47,7 +47,7 @@ struct mx25_gcq_priv {
 	 * of register writes, then a wait for a completion callback,
 	 * and finally a register read, during which userspace could issue
 	 * another read request. This lock protects a read access from
-	 * ocurring before another one has finished.
+	 * occurring before another one has finished.
 	 */
 	struct mutex lock;
 };
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
index fcdf13f49c48..7632dc794ef1 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -349,7 +349,7 @@ struct mcp3564_chip_info {
  * struct mcp3564_state - working data for a ADC device
  * @chip_info:		chip specific data
  * @spi:		SPI device structure
- * @vref_mv:		voltage reference value in miliVolts
+ * @vref_mv:		voltage reference value in milliVolts
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
diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 458544cb8ee4..1a42c7962ec9 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -257,7 +257,7 @@ static int nau7802_read_poll(struct iio_dev *indio_dev,
 	/*
 	 * Because there is actually only one ADC for both channels, we have to
 	 * wait for enough conversions to happen before getting a significant
-	 * value when changing channels and the values are far appart.
+	 * value when changing channels and the values are far apart.
 	 */
 	do {
 		ret = i2c_smbus_read_byte_data(st->client, NAU7802_REG_PUCTRL);
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
diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index a0227b57f238..bce7185953ec 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -856,7 +856,7 @@ static ssize_t pac1921_format_scale_avail(const int (*const scales_tbl)[2],
 /*
  * Read available scales for a specific channel
  *
- * NOTE: using extended info insted of iio.read_avail() because access to
+ * NOTE: using extended info instead of iio.read_avail() because access to
  * current scales must be locked as they depend on shunt resistor which may
  * change runtime. Caller of iio.read_avail() would access the table unlocked
  * instead.
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
2.52.0

