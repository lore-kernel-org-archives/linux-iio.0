Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196DA37D118
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302999; cv=none; b=YJcKhzN9F7iWcEDiYTeRixnMbhwiNkNgKIjtc66yDL5VdcAPRIa/YAsuaQ2YYSnHebyqQFog3u3PaMomvCfm6gCgFtSMYwlNLaIPVJA/NSw645Irl5uCEL4S8cID/8tzJar8b+DMsqH32bH4xU2scaJSk+F4ld2Z7gkh2Z90zjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302999; c=relaxed/simple;
	bh=Ujo0Ob23N8hrmFPDyXFf8zYPvDVPzGArh3g9JRIWtbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tl9AnCMcTovJfwsp1j0JoYVBANX8S761G9MvNIfGZ/4YsRgUcTTqnW1RqBHiq4BNmCHXU7ie0SRNKY/tdYSCkuwUgVGM86aFdU0xWD+7ZU1pDVMme5qQshcN8OaSuUamgXrcMA+ONePRIURtWubiHu4stcRodrKeZuwhp3lvaXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdV8ebjV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdV8ebjV"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so3886509f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 14:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774302996; x=1774907796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FdniiB3LpgBVWCzDfwMBNKyDPXkUftkwlbzeRzbR+DE=;
        b=ZdV8ebjVmCF11qbGNOKf24WCbfdqltHTfwOLEoChjS73qXBKIMwaqISKg5RHP6MRMY
         KnzPfLUGZjbHPRwVzVfh/w5gYfLN1ZXbMJUkLD1tG0U047Ij5GQLWR8SB5PHyIEKdTJM
         7Mzk8IRhwzxinX7g5j9Jc+cip21+Bkcl8JVhXcIy8XsEvelARo0bzSLXA6FzgKS0Xvk5
         h8NPtgcOAlQsJ0TEQKKwfcBsOEilypmWAY39yqI1ukjHefZlGEg2XHHU5mQjVMz8ldbF
         7fC0abDoDS2O3DjOZHEtvJLX06aeG34FnYHKG3SMTYclPi6I0zcw6+OZwAzEEtQmq1oQ
         RvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774302996; x=1774907796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdniiB3LpgBVWCzDfwMBNKyDPXkUftkwlbzeRzbR+DE=;
        b=YP3vardVb8+CxKSJjbwegtwEoPyn6WsS/BbU82q6/Gn6AaebX/QtiN3+TqKjC0rebz
         LjZssLSzMbC4ndRRhsJgsaq+limTxfFNBTkw9auUy7S9V0s0LhhrgNbtfRx7TSkkuQZz
         /nMTIxx1Yiee4aLLf/mjGGKB8pYKx2COdoI8hrHMnhmdFJeV3ANyISWBdGVxLTuJUP5E
         yzry7afWeAwrEXicxdUXtibwu8Q0WxBEMi8zMQzQjGFq471IR3INzdflAoOmFL5cj+8q
         G1WiTLBI9YDaLu5qqjjWsH2QJlreeXY56FRRmIz3z80Ta1/iocEfi0Xz6jfU3X8oQ563
         bAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFgqz+XpVSwJEgZtPY7dCt5wxqq6N0Fy5vdX2NPahlMWpt/JyQ9sTXr3WtbwY6c2d83DmrGd+EGQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5WckacxASD/P31xxTqNQRUBJzS7nEeSGpQaY2gGRKdnnk22zM
	Xy8sGFp/badxZI403DCmrXsgvJUMzPBGthrQaCoTaOghd4ThIlopPJJ7pv81PsLV6IU=
X-Gm-Gg: ATEYQzxs7s4PAO4xgt8iw/gxs9zS++Zz45b+/8dgLwgkL6PX0/HEhcSKjbKDH+kyOh1
	l6ljIWaKcJXJNNzeXojh89RldbDqMPOPXW7JpS2BFwvL3plxRsHIRGej3Mk/BI+Km0VFktvvDAc
	Jsq3Cia3kDLh47fEEX80ATOYak2OugkUNI+WYcM4pULPzQpu9d7Eu5WxSt8jC4WNAMXap0so/Ew
	jss2Ayu3zRzg2tRUsNrG+rFl83E0ISTa44maET1KW6PEDcmMlB25PpIKbtYVKXwBsBZ1lnNCKG+
	stZYK3UT7S0PZAOYlIUV5ZDc5YGNBX2KHhAXQU67pcHetRg14fDDHcPzKCfHDY1Xrs8kXAVhJDg
	JwyXQXmgIRWyEpSvyJsN0AuRdo5qHJUvy5EBpCqZrJE6vBweGh4mVXrzff9InpVkdxfxb3IPXSY
	egV+aJktVB4y0U6p5fgMr+isRWevWJcNzXRBAkhmirBxz7yqYTzQ8=
X-Received: by 2002:a05:6000:4911:b0:43b:6a49:29fd with SMTP id ffacd0b85a97d-43b805aa9camr1469157f8f.24.1774302996361;
        Mon, 23 Mar 2026 14:56:36 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:e561:a158:b78:a92e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae132sm31597912f8f.6.2026.03.23.14.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:56:35 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads8688: use read_avail for available attributes
Date: Mon, 23 Mar 2026 21:56:33 +0000
Message-Id: <20260323215633.8140-1-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the in_voltage_scale_available and in_voltage_offset_available
attributes from legacy IIO_DEVICE_ATTR with custom show functions to the
IIO framework's read_avail callback. This uses the framework's built-in
support for _available attributes, removing the need for manual sysfs
formatting.

Precompute the available scale values at probe time since they depend on
the reference voltage which does not change after initialization.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/iio/adc/ti-ads8688.c | 73 +++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index b0bf46cae..f37098db9 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -6,7 +6,6 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
@@ -17,7 +16,6 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/iio/sysfs.h>
 
 #define ADS8688_CMD_REG(x)		(x << 8)
 #define ADS8688_CMD_REG_NOOP		0x00
@@ -66,6 +64,7 @@ struct ads8688_state {
 	const struct ads8688_chip_info	*chip_info;
 	struct spi_device		*spi;
 	unsigned int			vref_mv;
+	int				scale_avail[3][2];
 	enum ads8688_range		range[8];
 	union {
 		__be32 d32;
@@ -114,37 +113,9 @@ static const struct ads8688_ranges ads8688_range_def[5] = {
 	}
 };
 
-static ssize_t ads8688_show_scales(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct ads8688_state *st = iio_priv(dev_to_iio_dev(dev));
-
-	return sprintf(buf, "0.%09u 0.%09u 0.%09u\n",
-		       ads8688_range_def[0].scale * st->vref_mv,
-		       ads8688_range_def[1].scale * st->vref_mv,
-		       ads8688_range_def[2].scale * st->vref_mv);
-}
-
-static ssize_t ads8688_show_offsets(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%d %d\n", ads8688_range_def[0].offset,
-		       ads8688_range_def[3].offset);
-}
-
-static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
-		       ads8688_show_scales, NULL, 0);
-static IIO_DEVICE_ATTR(in_voltage_offset_available, S_IRUGO,
-		       ads8688_show_offsets, NULL, 0);
-
-static struct attribute *ads8688_attributes[] = {
-	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
-	&iio_dev_attr_in_voltage_offset_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ads8688_attribute_group = {
-	.attrs = ads8688_attributes,
+static const int ads8688_offset_avail[] = {
+	-(1 << (ADS8688_REALBITS - 1)),
+	0,
 };
 
 #define ADS8688_CHAN(index)					\
@@ -155,6 +126,9 @@ static const struct attribute_group ads8688_attribute_group = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
 			      | BIT(IIO_CHAN_INFO_SCALE)	\
 			      | BIT(IIO_CHAN_INFO_OFFSET),	\
+	.info_mask_shared_by_type_available =			\
+			      BIT(IIO_CHAN_INFO_SCALE)		\
+			      | BIT(IIO_CHAN_INFO_OFFSET),	\
 	.scan_index = index,					\
 	.scan_type = {						\
 		.sign = 'u',					\
@@ -369,11 +343,34 @@ static int ads8688_write_raw_get_fmt(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ads8688_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct ads8688_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)st->scale_avail;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(st->scale_avail) * 2;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OFFSET:
+		*vals = ads8688_offset_avail;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(ads8688_offset_avail);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info ads8688_info = {
 	.read_raw = &ads8688_read_raw,
+	.read_avail = &ads8688_read_avail,
 	.write_raw = &ads8688_write_raw,
 	.write_raw_get_fmt = &ads8688_write_raw_get_fmt,
-	.attrs = &ads8688_attribute_group,
 };
 
 static irqreturn_t ads8688_trigger_handler(int irq, void *p)
@@ -412,7 +409,7 @@ static int ads8688_probe(struct spi_device *spi)
 {
 	struct ads8688_state *st;
 	struct iio_dev *indio_dev;
-	int ret;
+	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
@@ -426,6 +423,12 @@ static int ads8688_probe(struct spi_device *spi)
 
 	st->vref_mv = ret == -ENODEV ? ADS8688_VREF_MV : ret / 1000;
 
+	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
+		st->scale_avail[i][0] = 0;
+		st->scale_avail[i][1] = ads8688_range_def[i].scale *
+					st->vref_mv;
+	}
+
 	st->chip_info =	&ads8688_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
 	spi->mode = SPI_MODE_1;
-- 
2.33.0

