Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389163CCFD2
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436992; cv=none; b=nuqq0jeEYXItEaYJHXTFXWd4T8DDIIRzMIYoYSiLI5lLEpaDs2G77StQ9a1nKyG0Q+Tc9KoIMNDXPllKEdYv4LOk83qT7SOSPpeD1CEuaXJGNam7ecdODJBM4O+jKbgYIKQa//jwHVOMOdcvXq/2kxPbcr4WhwRoLU3iTJ2RhAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436992; c=relaxed/simple;
	bh=W7zUZDtGNn20lMvdnvzQKIeaqO3L7T2YvE8j3vlT8QY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g5hGCHsl/hB5sMaq2dzAja88z07TQi60juP75mgRVy28mRY+gfsOqyXTvAuTVAzDnPcIASaR2rhZz4WGnMTNOlpdQT2LFfPNtZqbgkI2X6vwEJ7ZkKrIF8diMp7snys/+ZMODpw/YyCPtovf2zRlpagCvQqJQiUPfxD+4xu0sfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4c8d5/M; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4c8d5/M"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so26385535e9.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 04:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774436985; x=1775041785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVK4wjtaqmG3ZXCPVMVUf5h3phFobdBtD0gg2Af7Zb8=;
        b=C4c8d5/M2ugcwRoA1z33G6uXZCzU5veRhVBJm76WRf5PnE/hT0jYjiznQrtPINUldt
         IRuigQ7weuTbKuv9K2kbYsbN1e2It7c7WMmx52LOk5fcrgB/kLzzZZ22nnpKdaWwX1+f
         6/A7biIOBI0+8Wgwm2vnYpqjiwa/i++Xe0i4OQACLBzddu4RnQvQeV0LgBlaFl214/AW
         CbY7vXfdSHseDpHzJ41k++OQnuO6xjuJHfyejORwGssvwmQdjyjoVO1Nie8DP2KJiPmA
         7aCFabRd5d9ESQskBT5CalNw5HRJJzElqvJh1+i2uEdMK879cqsyA4KyJROLd39rwAFu
         DZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774436985; x=1775041785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVK4wjtaqmG3ZXCPVMVUf5h3phFobdBtD0gg2Af7Zb8=;
        b=TYp+2Mfd/P0HmyDTrfY8/GliVpfeadFD+AgtyAVrxvtBElJMvVBw1PagFKxdgIJHPU
         MOvyTyRyr/3S1Dl0Cqss/zNhrxz1mhBy2j93k4ir9HBMoWRuHhUW4TmaeYG3zLJFTLBU
         dcOAcGqlniGYXoGAcgDnVsn14nEstVhsDLf4XODcssRlsu2d8vog7BIO6snv2g8ezxrZ
         xuZgTR0z6o1EbXng0yW/n2SS5IPDg9E0aVVKlpU7Jto6M6EykHtYipE61nxHDM3oo0I0
         ITSNLRE+biktCis1G15hxixGvQ/m1X/WUFkRrK++GOaWf56uTKTzR4Qx15ryCP40oUyp
         i52A==
X-Forwarded-Encrypted: i=1; AJvYcCVd/wAWkHiIzrSHlrZtJgDA8UPAFts7JFK95sZWZCsPrGrGyTTyyuibKprMTAcOoVNwuSTpOZK9ekM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaTGBs4GSDHbAEsu0e2DPuTjilV2DXDHVZ2TyBrR9wL6h7Mjet
	fzEZu8S1QT5XlAKJP7uH+wTofc1mNn3fLMlMPwqlW4vkdBcj0X5G7lSw
X-Gm-Gg: ATEYQzy9ykxxtFmidBDYFXreLjW1vSOoYl4399Eq8RRlBalUlw248iGS/JhmWEn8qEg
	5NkaxQrV5/dFgjb7m+oN3hHpq+hjt4BKACPqUV9a2TsQl7waLNSPPVYlGuxYX+QcBpmg7Lr7rwN
	N3AipmdKTivvztzgGqTcmSHoRk9NqEn2WjFDMGrFWthIEdW3N3Dl5p4+q4noOgZIkaJqsi9GilT
	GY312pR7AV+8Ran1oKeb1O18anF/DryR1xy4K4VWWuXA/6RuSMSygublBtXmRBRZ9YysCjVlkGW
	f66a28GucZVTGxvKN0XA4tbn9h1ZootR74v4xR75nLuNbUyCTcW+tBz08hRrbfZYAbO85/0kcM6
	lvyMIG0AXNABd+5nGtcJDPwyDqESTBA2dA0JxDTf8K0XzFqG9dr6tNYUOxR8IDWye2f755wNqOh
	6ClLiMP7OqMLUwOKUiTQ0inB8octJjPH6uENl1Cy4cXmoX8veJf1BB
X-Received: by 2002:a05:600c:45d4:b0:487:1114:d42f with SMTP id 5b1f17b1804b1-48715fd4aa6mr45424655e9.1.1774436985034;
        Wed, 25 Mar 2026 04:09:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:28db:f3e8:2f9b:ca58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711701804sm125621605e9.4.2026.03.25.04.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 04:09:44 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: ti-ads8688: use read_avail for available attributes
Date: Wed, 25 Mar 2026 11:09:42 +0000
Message-Id: <20260325110942.65337-1-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the in_voltage_scale_available and in_voltage_offset_available
attributes from legacy IIO_DEVICE_ATTR with custom show functions to the
IIO framework's read_avail callback. This uses the framework's built-in
support for _available attributes, removing the need for manual sysfs
formatting.

Precompute the available scale values at probe time since they depend on
the reference voltage which does not change after initialization.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
Changes in v2:
- Use -BIT() macro instead of -(1 << ...) to avoid potential UB and
  improve readability (Andy Shevchenko)
- Remove trailing comma from offset_avail array (Andy Shevchenko)
- Declare loop counter as unsigned int in for() (Andy Shevchenko, Nuno Sá)
- Keep scale_avail assignment on a single line (Andy Shevchenko, Nuno Sá)

 drivers/iio/adc/ti-ads8688.c | 70 +++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index b0bf46cae..31c43a4cb 100644
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
+	-BIT(ADS8688_REALBITS - 1),
+	0
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
@@ -426,6 +423,11 @@ static int ads8688_probe(struct spi_device *spi)
 
 	st->vref_mv = ret == -ENODEV ? ADS8688_VREF_MV : ret / 1000;
 
+	for (unsigned int i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
+		st->scale_avail[i][0] = 0;
+		st->scale_avail[i][1] = ads8688_range_def[i].scale * st->vref_mv;
+	}
+
 	st->chip_info =	&ads8688_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
 	spi->mode = SPI_MODE_1;
-- 
2.33.0
