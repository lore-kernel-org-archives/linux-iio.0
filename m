Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD373FE37D
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490502; cv=none; b=ojtDFQSXIR9oqtK71LIdXlTW89hmms/IkbRDsLHqkxcXLZna7pSJ72hIFEWohzoPsTABKMeMHskaSNHCYuSExdKxVNCNV9JQYnzc0HLzG2MJef6p5NKJhl3gR6XRMsscOXzfUaXKsVQb2cPSiyGNRD7rbw45UAv61/HvBjiETtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490502; c=relaxed/simple;
	bh=3mR4WEjZkRFBQBYoDDO3BPIisK5yXLh/TdfWdHPpSlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4xubsduOuX+Dr7x7yCUi00DhNlInn8n+fnr4FfWHTfrosk86JoXOkannWr04eTb4inZxXFb0p2S+XrXjA1jmhwccdSdPi1KO6r9+5fac0Zx6CBN6rkZP9IiYsxEzJR8Qo9hAAPpdybwsR1+Qfi56dNIxsuDqXAP3ksotBIDHK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEVPcTN0; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEVPcTN0"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e951b9524fso801435a34.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782490499; x=1783095299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqlMNu9ucxE29yqblO0AosyEbXcZc6A6cLTxUWeXrHc=;
        b=aEVPcTN02drvbWi5FS+oTysIpN61VvmUwUol+IqHL3Uqq+fvrZMiKkcy8Fvnl//I/h
         fujWNt28MZm1LdwOiWejs63IRMleh1Q5hGPGRnr047Al1VMXDbBpVR+OHElzPe1++Ofp
         oTkik5qpmFZGgylh7sv7gZ3b6PSlscA2EVDoXbd/216gX1ja+acE194GaNGVqEBUOhha
         KMZ4H3j4ihGezW6getoOT4uXQm/hjJA+ouXsekC7u0ilptlcMWkQH++IIiipOve/ZsCb
         YYmpWulJggxfRHWWi/VvmyReIbI3EZHhby5v9ynTl1D2O4lRDymqR4eD5Co7Ta3+Oo0B
         b7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782490499; x=1783095299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IqlMNu9ucxE29yqblO0AosyEbXcZc6A6cLTxUWeXrHc=;
        b=DihSeqUlNDTWtceUcC8NxYsYgFCBDybbL3a/TZ32KRGgUM1cinm6hMX/8G1MFZzOGe
         9XK9oPTMvbrHcHs7WGL64M59GhLNXkuHFVqJgBG4EMb30bho3rxjE+6OZ09/42WVq0+F
         UGLdGJj77qWRMD/W2itaVEZ/cNzM63DGWR3Rf7KldKyj2krsWiexaQWsQ96S7wC/yzW3
         mEgxlUMuwD/GvlKTGlGJDgVdSAQyz2PAD3TDZIgtgH/TfbBfSkuVmN80AsJXNUZM0EoY
         Tk5YpkuwdHWDc0VizLUTSZvtPuNWnrg0yAf7ODxp9yOfpUp/O+ts+hxevg9hlxVIIIWp
         ZI4Q==
X-Gm-Message-State: AOJu0Yzh8Ss99bUbtCK1TnFQKW+qLWL/WjnbCT1pGtcemKe04JyhVh9q
	pmdCMtNg1NSuUMz+8MuVJOXbfP+ZhrDOpRFaArWj5vY0gVkhvn3brrUqdpdweMNg
X-Gm-Gg: AfdE7cl45hkjMJ6GAkjOyy/RYeUj5rmIhGA75L3vUfAiaTVOJPbCZYSOmfk0mAKcZ3Q
	gIBHRPXcBTdRj/rAHmpx8f87IT+yrtkxt2qaL2Hi99npWpNmwktvuQDpRjqTdSvuX+MECTNfcA/
	LEuod6NI45SDOygUQ+E9hgOJLGKjNl0znWlM4mUg+x2UvpTDz/0mw725m627FrOWmdSg92++cKK
	EGPJwyS4yyGgKn91fjKKI/27eP+rXYbCmJvpxl2sT8vKShcA2xfMssx9yiiyJaEYKQE0o57vNNo
	MtoHIw/EvpLG6Jx9MjDejaHnA+/JfBP/ZGDymok+ZlLuOc+/nZ2aDx21Qtua7z0gs9gyfGrAmEm
	jh6cF552pb0oxkcINsesOSvd3C4Mrzz67s21dhD8yNXWiqLzIu4U26FmFkBcqOx8zgpjj8bWvd7
	/VGeO00rlrjnI=
X-Received: by 2002:a05:6830:378a:b0:7e9:b4d1:78af with SMTP id 46e09a7af769-7e9b4d17abfmr777046a34.29.1782490499518;
        Fri, 26 Jun 2026 09:14:59 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa579235sm1970211a34.1.2026.06.26.09.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:14:59 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V15 8/9] iio: imu: inv_icm42607: Add Temp Support in icm42607
Date: Fri, 26 Jun 2026 11:12:29 -0500
Message-ID: <20260626161230.93069-9-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626161230.93069-1-macroalpha82@gmail.com>
References: <20260626161230.93069-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add functions for reading temperature sensor data.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42607/Makefile         |  1 +
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c |  8 ++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  |  8 ++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 98 +++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 38 +++++++
 5 files changed, 153 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h

diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index 8e73385c8f4b..7b907e019601 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
 inv-icm42607-y += inv_icm42607_core.o
 inv-icm42607-y += inv_icm42607_gyro.o
 inv-icm42607-y += inv_icm42607_accel.o
+inv-icm42607-y += inv_icm42607_temp.o
 
 obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
 inv-icm42607-i2c-y += inv_icm42607_i2c.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index 8ef9fdae1bc8..5ff6756b9515 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 
 #include "inv_icm42607.h"
+#include "inv_icm42607_temp.h"
 
 #define INV_ICM42607_ACCEL_CHAN(_modifier, _index, _ext_info)			\
 {										\
@@ -40,6 +41,7 @@ enum inv_icm42607_accel_scan {
 	INV_ICM42607_ACCEL_SCAN_X,
 	INV_ICM42607_ACCEL_SCAN_Y,
 	INV_ICM42607_ACCEL_SCAN_Z,
+	INV_ICM42607_ACCEL_SCAN_TEMP,
 };
 
 static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
@@ -54,6 +56,7 @@ static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
 				inv_icm42607_accel_ext_infos),
 	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42607_ACCEL_SCAN_Z,
 				inv_icm42607_accel_ext_infos),
+	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
 };
 
 static const int inv_icm42607_accel_scale_nano[][2] = {
@@ -186,6 +189,11 @@ static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
 	switch (chan->type) {
 	case IIO_ACCEL:
 		break;
+	case IIO_TEMP:
+		if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+			return inv_icm42607_temp_read_raw(indio_dev, chan,
+							  val, val2, mask);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
index c7215b3826ad..4e5db5e19e9f 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 
 #include "inv_icm42607.h"
+#include "inv_icm42607_temp.h"
 
 #define INV_ICM42607_GYRO_CHAN(_modifier, _index, _ext_info)			\
 {										\
@@ -40,6 +41,7 @@ enum inv_icm42607_gyro_scan {
 	INV_ICM42607_GYRO_SCAN_X,
 	INV_ICM42607_GYRO_SCAN_Y,
 	INV_ICM42607_GYRO_SCAN_Z,
+	INV_ICM42607_GYRO_SCAN_TEMP,
 };
 
 static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
@@ -54,6 +56,7 @@ static const struct iio_chan_spec inv_icm42607_gyro_channels[] = {
 			       inv_icm42607_gyro_ext_infos),
 	INV_ICM42607_GYRO_CHAN(IIO_MOD_Z, INV_ICM42607_GYRO_SCAN_Z,
 			       inv_icm42607_gyro_ext_infos),
+	INV_ICM42607_TEMP_CHAN(INV_ICM42607_GYRO_SCAN_TEMP),
 };
 
 static const int inv_icm42607_gyro_scale_nano[][2] = {
@@ -182,6 +185,11 @@ static int inv_icm42607_gyro_read_raw(struct iio_dev *indio_dev,
 	switch (chan->type) {
 	case IIO_ANGL_VEL:
 		break;
+	case IIO_TEMP:
+		if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+			return inv_icm42607_temp_read_raw(indio_dev, chan,
+							  val, val2, mask);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
new file mode 100644
index 000000000000..8681ef2b49e2
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include "inv_icm42607.h"
+#include "inv_icm42607_temp.h"
+
+static int inv_icm42607_temp_read(struct inv_icm42607_state *st, s16 *temp)
+{
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	struct device *dev = regmap_get_device(st->map);
+	int ret, gyro_mode, accel_mode;
+	unsigned int val;
+	u8 raw[2];
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	/*
+	 * Check if both the gyro and accel are off and if so, enable one
+	 * of them. The temp sensor cannot be read if both the gyro and
+	 * accel sensor are off. Prefer to enable the accel over the gyro
+	 * as the datasheet says the gyro uses 5x more power and it has
+	 * a minimum run time of 45ms.
+	 */
+	ret = regmap_read(st->map, INV_ICM42607_REG_PWR_MGMT0, &val);
+	if (ret)
+		return ret;
+
+	accel_mode = FIELD_GET(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, val);
+	gyro_mode = FIELD_GET(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, val);
+	if (!gyro_mode && !accel_mode) {
+		/* enable accel sensor */
+		conf.mode = INV_ICM42607_SENSOR_MODE_LOW_NOISE;
+		ret = inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_TEMP_DATA1,
+			       raw, sizeof(raw));
+	if (ret)
+		return ret;
+
+	*temp = get_unaligned_be16(raw);
+	if (*temp == INV_ICM42607_DATA_INVALID)
+		return -EINVAL;
+
+	return 0;
+}
+
+int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	s16 temp;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = inv_icm42607_temp_read(st, &temp);
+		if (ret)
+			return ret;
+		*val = temp;
+		return IIO_VAL_INT;
+	/*
+	 * T°C = (temp / 128) + 25
+	 * Tm°C = 1000 * ((temp * 100 / 12800) + 25)
+	 * scale: 100000 / 12800 ~= 7.8125
+	 * offset: 3200
+	 */
+	case IIO_CHAN_INFO_SCALE:
+		*val = 7;
+		*val2 = 812500000;
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 3200;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
new file mode 100644
index 000000000000..18499b4d0b94
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#ifndef INV_ICM42607_TEMP_H_
+#define INV_ICM42607_TEMP_H_
+
+#include <linux/bitops.h>
+
+struct iio_dev;
+struct iio_chan_spec;
+
+#define INV_ICM42607_TEMP_CHAN(_index)				\
+{								\
+	.type = IIO_TEMP,					\
+	.info_mask_separate =					\
+		BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_OFFSET) |			\
+		BIT(IIO_CHAN_INFO_SCALE),			\
+	.info_mask_shared_by_all =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_all_available =			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.scan_index = _index,					\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_BE,				\
+	},							\
+}
+
+int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask);
+
+#endif
-- 
2.43.0

