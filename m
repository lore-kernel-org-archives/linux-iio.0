Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F46D40DFAC
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894532; cv=none; b=K4IcGS2qMgx1WnDuoFWVJLmtDdPhfcIQh0k39AbmlnCsja5eb/oaZTqc3W0rbfvkKfETpzprzsj1lJLMLDlaAire3mFQeQtAlhzSWo/7bdpnbwTRcSR+Elq7zuKK0NzfY153qB+dUt2QNEb9W67k0iM6nQ0sIg2C85Qi3S0S4D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894532; c=relaxed/simple;
	bh=qxjoJ59UpkSCDNdEt4+xblnSh2F5BOBY9t4J8olZbSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FwTpo8VXbhpq9hNJashFItX5tgfWG4F/w8SX4VCo02/B6OHHoOcCAsvDB0qatlE9V7SVdzOVG/3IH4OQcBeOt24+Nlg85Fr/Zzzx0mBULQ5B+PwdiA+AZznhXbmEq4WMkxIbNnGKK/HEU1e8geonC6rK7ST3H77aYl7dB5RsI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nuga7JsM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nuga7JsM"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b9d3ebed5so3417163f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 11:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894530; x=1775499330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt73G12JWnaoQo/p4ItYAzQvQvslyT2Qx9f64ryfgJ8=;
        b=Nuga7JsMuImi1ueys1KFtyI7y+/rMFmnURJ0GvZ6rsPwGSeTK8x+PVvMfAwvSGsFh2
         5cnGdW107ITiKYdnlSMyS38NtaO5952Y4xn72EDNVU3zYEZWApNj6S1CxzPvZd9tyPZ8
         or5MtCZuQeqhT+aKFprUbBCZllUS8N2Svw3t+XK2Kwu12GkPwAS4X1APilErzzSHCZuL
         HWABRJ5ZEzXSEJN26luZOswCiDxVM7CRXYX4Eqwh8x5qBgu5Urt35+UvuISu9rhBwLIF
         rjwG1wWMhtWHMTJQF4d39J/rx+bajGFae9LeP2LlR70jbjKCZL9Ll4AMkMShoDtEih8z
         Hllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894530; x=1775499330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kt73G12JWnaoQo/p4ItYAzQvQvslyT2Qx9f64ryfgJ8=;
        b=pi62L6/ZKnkn12J7SHDCePAprtWr5QYwWMYxjd99ZViYiaQDgyRmClFj0lFh1xOrus
         Qpcd+BrP6e5ViLxNLNk/byeAgL1+JLRTOkKklDsigl0yBCqoWu3Ix3LzmjnVPl4NfZre
         g+BJ69XjuvqUyz4OvWxF9/tFIDyXZ1ssQ2CfDebO+hKX0TSi1EEbOi62kF+D9ZFgyaRW
         oKIi9eVzjjn4XojwLHE4dK7h3tu3p2K2nV7sq34Cld0DrhNea2hwf7okB5AaZjvjozNp
         hjl5yiqUfbCO7rnngOfijwrc+yYZn6aCGzCbEwPkSX6UzvTEqIigh+lclLu3sUlJrrvt
         ucYg==
X-Gm-Message-State: AOJu0YxU5563PMnJjggnYbdbWVYJFcHA7VZBrGriJC0P9MVDJkLHiUhO
	P+SGQULRDZvXI2uIhrSbor6k5/4sC9ltqY2kJrGEnCTAs/97HR/+b+4T
X-Gm-Gg: ATEYQzwRIhoMpiFI8nl0wp35UHnryyPPR1c/s8fEhkcwLd4CJC6wnrOTSrPf9qvFid+
	SDkvYzlUIiU04t6rtHhaayOwhuaHy95fqp6JvAhABy6a0rl+rQdGxr2tnYRxy3KEgKIR9cIagBY
	rYoy4rw26wyQdUvP4efR4oOtRiCnsxVZmFamZcteuCfI51hr8y0UyMfrOmai2tRtdQhRFPCmUfM
	rt+XmlfW9EjZbnjsLa3EMd0jFVYqi3sqZl2RbzVLMAepSZHRKFsFx580mO2qNYYenLUnndN8r3O
	0xEdCHFyDzN08DCjH6w2Rb40PSSgzQ5f9hm/WI0AmrA6Sj5pqPBli9JE/UhDvKxaflNAR+Espfy
	kYkiWLhmEHft9E2tfP012w9vFhZ/l4d4qlrSZqX3JO405/54deDUgZBQKTvPSL3krWSbb+yzOvU
	9IInjKI/+XmgtwGlw7H7VKFYGGZ3FvOfd7iVtmYZC4yjAjMNv6Cx16sA==
X-Received: by 2002:a05:6000:2884:b0:43b:54c9:85f4 with SMTP id ffacd0b85a97d-43b9eaad5e6mr25164219f8f.39.1774894529473;
        Mon, 30 Mar 2026 11:15:29 -0700 (PDT)
Received: from MacBookPro.localdomain ([2001:8a0:6c9b:a000:3437:41ca:45cc:e6f1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2463dc2sm20940278f8f.23.2026.03.30.11.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:15:29 -0700 (PDT)
From: grondon@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriel Rondon <grondon@gmail.com>
Subject: [PATCH v3] iio: adc: ti-ads8688: use read_avail for available attributes
Date: Mon, 30 Mar 2026 19:15:27 +0100
Message-Id: <20260330181527.65362-1-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Gabriel Rondon <grondon@gmail.com>

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
Changes in v3:
- Revert to -(1 << (ADS8688_REALBITS - 1)) instead of -BIT() to avoid
  overflow warnings reported by kernel test robot (Jonathan Cameron)

Changes in v2:
- Use unsigned int for loop counter declared in for() (Andy Shevchenko,
  Nuno Sa)
- Remove trailing comma from array terminator (Andy Shevchenko)
- Keep scale computation on a single line (Nuno Sa)

 drivers/iio/adc/ti-ads8688.c | 70 ++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index b0bf46cae..ebd2826a7 100644
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

