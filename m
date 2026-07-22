Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B463D649F
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734945; cv=none; b=oSGfuKmJ+JZfChfT1Xx0o6djdXuZK/oAtwggM54Imt5AmHcyB+oN+o6uAj0hlirUsAawHtuKrH0Hacp9xmjpmLBwclj6qHxHgUzPIwJwiWxBf8+vXeXjXw79mgM/pznmQqpvLvxkBliyoHLXc2+JnkyhOdZIo+I+Lq89sADSsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734945; c=relaxed/simple;
	bh=jBz+PaQnk8toVFMhN/aQDIXYs2zUaXnPrWOk75EcK4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqLhWIBEo9j2xWhXLhhdVLuGe5Ftjv4e1KnijFWHTZXbxvdXzjZdpBMFekm0H/Syr0ABT/pKh7LbDhVXhrKbSzl7+xZipsdRql/PSGu5swSFwwqJ8pAOoKWiOBVbeI5lq+u98KeHJXiit/PjohxnogihLOfL8l5IN13udtk75vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnE8Sqzp; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnE8Sqzp"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ee33eb05efso506057a34.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784734940; x=1785339740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bfpXOUqhZs6QAVJ7VXUvh6DZfRf+XCI9BVIn3ptYerM=;
        b=KnE8SqzptC284kKSOsZx/8Re/P6Vka8zYQNoqge5Twd575YTvhKYLHjG5/ua08lfzl
         ZXAZGWca5BRrDvfyDDU0iLO/3yhQeDZSuFuAjrs+mgmR7QBeiu1i69PCoYG0P/62Cpk1
         tRcprLgRaaB5MrJaoFYGCb2AD6ahALJad8vcsHweYYUJSgHcCi0579vucM5PvgKWBm95
         JohR/QjnR4CYejOJzY4DeAVRmxa/D3o8+Z+52VSLyD7P1skFHoL3I+cMXcKpj8vc4Nrn
         VLZniwNAChhVNrlw7szke5Jk9I13gOyJp0ymoBicMod+7t0cDxj6gwp3ZTmjv76iAqpt
         c9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784734940; x=1785339740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bfpXOUqhZs6QAVJ7VXUvh6DZfRf+XCI9BVIn3ptYerM=;
        b=bBrX8btzaqq1FzLdkXihU2TFfV24CkEMfz4DOO6UaggwFOFLfdT0N7DtEJqYijN+p0
         yjtJB9pSphrRgbuxZigrTVi54DFI5Ltlb03ORQBeFXPNifTFUyUJ1Fg26uxTaXE1li+1
         2cqqBpnUYjt07yyzELbPEWYCBF+S+nu5iw3AEOzKR503KhLOorpD+4F0P1D9ALaXNomq
         6CVbzpkCbBF0Cu6/UNvJiJCaY5oJ1BElsxExXLXXzNuAsLozEwZ9GHZFUObVxjYJJOFL
         XbYEhDhTks7TLfsJk1ETCItCOHuzMqGA/mk/VzKn0DvF3+hdDBx3v4wcq1yQlXby6Ibm
         m6Fg==
X-Gm-Message-State: AOJu0Yw0Z+1VSrD+JMS6UEoAdsawAQ49Mh5CS8dw2dAcgUR/OqbzR3ci
	5McscKvw3jcNCReY5fAU+fXwha9fU0Bnl/WcKX6zXs+lGh+MtpdYgNwHKHouYg==
X-Gm-Gg: AR+sD10eInwajKaMwvYZyTCfFNI0VT12oZ9y0NQm40MnwC0zhK/3A8j7GYRDPtVztXD
	baYJueGqaLXQf6AjqwQoHBRW6AlK0n4r2xWHDvZ/IOAgpfDDCQ7JRf4CjLtbwynZOv/VGwbURA+
	2YHPXxH3B5AloehLyYBv6T84zAZ9tTBdrn3bF1nPGVhBADIAWt+oFBaJ2wWL3zlD0vftHiwI0Wo
	V7w7OlbsTZW5MqSJxDQneWepkh3Urm/8b60odf+BoofjVsfgH+Xjczmuz+YSJk8MOIy5cLo4TCp
	0fQW6d417SSO8XFoRYkdeupWNEmH8XgZA/KZN7AdBuWxDwFeijqFtXgxS1RnWq47b4wV6bo9LBN
	aB97YC54O/AWqPxhAOWWrAq84C6tweEVIY9FZRsJ5yrE+8/Ws27vTFeTixnXJw5vI5yCdtONJBm
	YF
X-Received: by 2002:a05:6820:1992:b0:6a3:7af2:90ef with SMTP id 006d021491bc7-6a536691614mr11887276eaf.6.1784734939828;
        Wed, 22 Jul 2026 08:42:19 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aac3a494d4sm1300804eaf.3.2026.07.22.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:42:19 -0700 (PDT)
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
Subject: [PATCH V19 7/9] iio: imu: inv_icm42607: Add Gyroscope to icm42607
Date: Wed, 22 Jul 2026 10:39:38 -0500
Message-ID: <20260722153942.144387-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722153942.144387-1-macroalpha82@gmail.com>
References: <20260722153942.144387-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add gyroscope functions to the icm42607 driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42607/Makefile         |   1 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |   4 +
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  |   5 +
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 305 ++++++++++++++++++
 4 files changed, 315 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c

diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index 372c6d6bdcec..8e73385c8f4b 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
 inv-icm42607-y += inv_icm42607_core.o
+inv-icm42607-y += inv_icm42607_gyro.o
 inv-icm42607-y += inv_icm42607_accel.o
 
 obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 14cf3cb63dea..42afb9824d8e 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -138,6 +138,7 @@ struct inv_icm42607_hw {
  *  @lock:		lock for serializing multiple registers access.
  *  @map:		regmap pointer.
  *  @indio_accel:	accelerometer IIO device.
+ *  @indio_gyro:	gyroscope IIO device.
  *  @vddio_supply:	I/O voltage regulator for the chip.
  *  @vddio_en:		I/O voltage status for runtime PM.
  *  @conf:		chip sensors configurations.
@@ -148,6 +149,7 @@ struct inv_icm42607_state {
 	struct mutex lock;
 	struct regmap *map;
 	struct iio_dev *indio_accel;
+	struct iio_dev *indio_gyro;
 	struct regulator *vddio_supply;
 	bool vddio_en;
 	struct inv_icm42607_conf conf;
@@ -414,6 +416,8 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 			    const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
 
+struct iio_dev *inv_icm42607_gyro_init(struct inv_icm42607_state *st);
+
 struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st);
 
 #endif
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index c1648f5c3538..85ffd7a44273 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -580,6 +580,11 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	if (IS_ERR(st->indio_accel))
 		return PTR_ERR(st->indio_accel);
 
+	/* Initialize IIO device for Gyro */
+	st->indio_gyro = inv_icm42607_gyro_init(st);
+	if (IS_ERR(st->indio_gyro))
+		return PTR_ERR(st->indio_gyro);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
new file mode 100644
index 000000000000..b68d4d6f5c3f
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include "inv_icm42607.h"
+
+#define INV_ICM42607_GYRO_CHAN(_modifier, _index, _ext_info)			\
+{										\
+	.type = IIO_ANGL_VEL,							\
+	.modified = 1,								\
+	.channel2 = _modifier,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = _index,							\
+	.scan_type = {								\
+		.sign = 's',							\
+		.realbits = 16,							\
+		.storagebits = 16,						\
+		.endianness = IIO_BE,						\
+	},									\
+	.ext_info = _ext_info,							\
+}
+
+enum inv_icm42607_gyro_scan {
+	INV_ICM42607_GYRO_SCAN_X,
+	INV_ICM42607_GYRO_SCAN_Y,
+	INV_ICM42607_GYRO_SCAN_Z,
+};
+
+static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
+	{ }
+};
+
+static const struct iio_chan_spec inv_icm42607_gyro_channels[] = {
+	INV_ICM42607_GYRO_CHAN(IIO_MOD_X, INV_ICM42607_GYRO_SCAN_X,
+			       inv_icm42607_gyro_ext_infos),
+	INV_ICM42607_GYRO_CHAN(IIO_MOD_Y, INV_ICM42607_GYRO_SCAN_Y,
+			       inv_icm42607_gyro_ext_infos),
+	INV_ICM42607_GYRO_CHAN(IIO_MOD_Z, INV_ICM42607_GYRO_SCAN_Z,
+			       inv_icm42607_gyro_ext_infos),
+};
+
+static const int inv_icm42607_gyro_scale_nano[][2] = {
+	[INV_ICM42607_GYRO_FS_2000DPS] = { 0, 1065264 },
+	[INV_ICM42607_GYRO_FS_1000DPS] = { 0, 532632 },
+	[INV_ICM42607_GYRO_FS_500DPS] = { 0, 266316 },
+	[INV_ICM42607_GYRO_FS_250DPS] = { 0, 133158 },
+};
+
+static int inv_icm42607_gyro_read_scale(struct iio_dev *indio_dev,
+					int *val, int *val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	unsigned int idx;
+
+	guard(mutex)(&st->lock);
+
+	idx = st->conf.gyro.fs;
+
+	*val = inv_icm42607_gyro_scale_nano[idx][0];
+	*val2 = inv_icm42607_gyro_scale_nano[idx][1];
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int inv_icm42607_gyro_write_scale(struct iio_dev *indio_dev,
+					 int val, int val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	size_t scales_len = ARRAY_SIZE(inv_icm42607_gyro_scale_nano);
+	int ret;
+
+	for (idx = 0; idx < scales_len; idx++) {
+		if (val == inv_icm42607_gyro_scale_nano[idx][0] &&
+		    val2 == inv_icm42607_gyro_scale_nano[idx][1])
+			break;
+	}
+	if (idx == scales_len)
+		return -EINVAL;
+
+	conf.fs = idx;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	return inv_icm42607_set_sensor_conf(st, &conf, IIO_ANGL_VEL);
+}
+
+/* IIO format int + micro , values 0-4 reserved. */
+static const int inv_icm42607_gyro_odr[][2] = {
+	[INV_ICM42607_ODR_1600HZ] = { 1600, 0 },
+	[INV_ICM42607_ODR_800HZ] = { 800, 0 },
+	[INV_ICM42607_ODR_400HZ] = { 400, 0 },
+	[INV_ICM42607_ODR_200HZ] = { 200, 0 },
+	[INV_ICM42607_ODR_100HZ] = { 100, 0 },
+	[INV_ICM42607_ODR_50HZ] = { 50, 0 },
+	[INV_ICM42607_ODR_25HZ] = { 25, 0 },
+	[INV_ICM42607_ODR_12_5HZ] = { 12, 500000 },
+};
+
+static int inv_icm42607_gyro_read_odr(struct inv_icm42607_state *st,
+				      int *val, int *val2)
+{
+	unsigned int odr;
+	unsigned int i;
+
+	guard(mutex)(&st->lock);
+
+	odr = st->conf.gyro.odr;
+
+	for (i = INV_ICM42607_ODR_1600HZ; i < ARRAY_SIZE(inv_icm42607_gyro_odr); i++) {
+		if (i == odr)
+			break;
+	}
+	if (i == ARRAY_SIZE(inv_icm42607_gyro_odr))
+		return -EINVAL;
+
+	*val = inv_icm42607_gyro_odr[i][0];
+	*val2 = inv_icm42607_gyro_odr[i][1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm42607_gyro_write_odr(struct iio_dev *indio_dev,
+				       int val, int val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = INV_ICM42607_ODR_1600HZ;
+	     idx < ARRAY_SIZE(inv_icm42607_gyro_odr); idx++) {
+		if (val == inv_icm42607_gyro_odr[idx][0] &&
+		    val2 == inv_icm42607_gyro_odr[idx][1])
+			break;
+	}
+	if (idx == ARRAY_SIZE(inv_icm42607_gyro_odr))
+		return -EINVAL;
+
+	conf.odr = idx;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	return inv_icm42607_set_sensor_conf(st, &conf, IIO_ANGL_VEL);
+}
+
+static int inv_icm42607_gyro_read_raw(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      int *val, int *val2, long mask)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	s16 data;
+	int ret;
+
+	switch (chan->type) {
+	case IIO_ANGL_VEL:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = inv_icm42607_read_sensor(indio_dev, chan, &data);
+		if (ret)
+			return ret;
+		*val = data;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return inv_icm42607_gyro_read_scale(indio_dev, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42607_gyro_read_odr(st, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42607_gyro_read_avail(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					const int **vals,
+					int *type, int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_ANGL_VEL)
+			return -EINVAL;
+		*vals = (const int *)inv_icm42607_gyro_scale_nano;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(inv_icm42607_gyro_scale_nano) * 2;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)inv_icm42607_gyro_odr[INV_ICM42607_ODR_1600HZ];
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = (ARRAY_SIZE(inv_icm42607_gyro_odr) -
+			   INV_ICM42607_ODR_1600HZ) * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42607_gyro_write_raw(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       int val, int val2, long mask)
+{
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_ANGL_VEL)
+			return -EINVAL;
+		ret = inv_icm42607_gyro_write_scale(indio_dev, val, val2);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42607_gyro_write_odr(indio_dev, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42607_gyro_write_raw_get_fmt(struct iio_dev *indio_dev,
+					       struct iio_chan_spec const *chan,
+					       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_ANGL_VEL)
+			return -EINVAL;
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info inv_icm42607_gyro_info = {
+	.read_raw = inv_icm42607_gyro_read_raw,
+	.read_avail = inv_icm42607_gyro_read_avail,
+	.write_raw = inv_icm42607_gyro_write_raw,
+	.write_raw_get_fmt = inv_icm42607_gyro_write_raw_get_fmt,
+};
+
+struct iio_dev *inv_icm42607_gyro_init(struct inv_icm42607_state *st)
+{
+	struct device *dev = regmap_get_device(st->map);
+	const char *name;
+	struct inv_icm42607_sensor_state *gyro_st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->hw->name);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*gyro_st));
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
+
+	gyro_st = iio_priv(indio_dev);
+	gyro_st->power_mode = INV_ICM42607_SENSOR_MODE_LOW_NOISE;
+	gyro_st->filter = INV_ICM42607_FILTER_BW_73HZ;
+
+	indio_dev->name = name;
+	indio_dev->info = &inv_icm42607_gyro_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = inv_icm42607_gyro_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm42607_gyro_channels);
+	iio_device_set_drvdata(indio_dev, st);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return indio_dev;
+}
-- 
2.43.0

