Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A033379C57
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980076; cv=none; b=Bi2e8OCnBbH4SeTM8C0Ptlj2o1Ram+bbZXBhQhzg0BATgscEmDdThY2FtluAXvoUwcERqtvgIGb+V7FyNui0Uk+e0GZ2gCErgd1qYjerBX8usVBe/Jc0+N2mT/pyajp3uNooKWzYRWYlbpPRFrS+2D/e2gtnJia0EwLiO0Wv/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980076; c=relaxed/simple;
	bh=tMSxvXFpOEYSlp/s2tdccNVDvdcfgcb0/3D5XRy4V4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/Ert0sCPSzW6i2cvm1Zto5C6FxrP/9LJnz9Tq613Aia7/2xXC5OXe6xhAUZnvwTPpyfZHVCtnK3ORrG1J/bWdNl6+72ivFg5Nf6IdCogYyYXJqqibH+FOGPlyVR82z5Z4a6J6sS1ehpaFIUU4J56NUYCPZdaGMh/F7mx4I5jXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsdpW+Dx; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsdpW+Dx"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4a43c2a126fso1035483b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980072; x=1784584872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bw78mcCK0qvsV0Moo7FrFvBnMJynEpNgleleuVlab3o=;
        b=AsdpW+DxNUUI2+GLw8TD0Y+0qxh504O8B6wcr2rHIU6g1Sfs410JdXi4CzFIlmJhFb
         siKle9pXEhi5Rsq7AIWCKYaJJCp/XgHBXDPJvN8Bn+2656hziOC+y+ZiRtGmsA5S0DC2
         HbDIJ9zOojx5chJib1EOdn69yZpL+91Nwg1PMhjiSDoNYcM1qfhRF774/f4D6wiOB7U3
         HoGp6EcEN9gOlEA/UT6CStG6YAMhY+e6sX/1MEW7LRhxhkjLJGcgUI7ff9gMEnKCBWu0
         5gE9wjL6AZhg8q+7KFXtsAYwqwIW/1IjWCTwlF1/iqjZc3dpyZWggPKn+/FMPt8Osave
         WPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980072; x=1784584872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bw78mcCK0qvsV0Moo7FrFvBnMJynEpNgleleuVlab3o=;
        b=G4p6fRZ+8XR406lMLgDLoxqRnpbyS7hx+hB4os9+b/3iyuqLw55p8fW6Eb8B7s+7+k
         xI2idcte4KfNLc1+do547JRp/mG1zX52pTSql4zUhZtv1SylKPkBrQnB3hkNW6qcGw9d
         LT5uepVo+EtzCd4WbWnUbdTKs9/ggJpUYLGCv0HmKt9mYIVRofBtMmGyhOKBhQtSkHMs
         6FHKuqLCeVzNMkJ1PqozA4IHByoHXDlSljbvUUL+FzKS1T3dDSqX6W8HOhXZPw+3RnIX
         vBJl/gAmEKCVHX7ZFckUoMA2oInBgQmtkJdx13HRxVReAp5gJn2PhpBVf/yJZFFYx4Es
         TvnA==
X-Gm-Message-State: AOJu0YwHDHWUnlEEPuJPe4EHNiuh+N5vIZcDDvNvSbkSmLLMKrs+CT3w
	shK7gCHApng+EOHYTTIZB4tZxZVUYXmfYGpBef9pMcQgfnJabq4ScCNELIPh/g==
X-Gm-Gg: AfdE7cke1gNwDFQnfLWao41Uc0eEN8BtR1Lwdr3KH7wAveDhmXFpDzmalTGRxWJWCo0
	m5nCE69xAvGgtmrW2Ru1yJ5T45FwDAL/fylTDr/fdngMmrLyPjig8qOtc+tUSMXg5gfB6SmcV9u
	Kwg0P6/i5L9bOvXeJiuq1IZVW0Q/aw7tNTGDIvkaK6vGPIX+FtMAvU1nLENv6ZFr/epr95Buqhe
	Dy1wjJjq9zsVnDptZHDpi99B8KZ5FxtRaQmamoZRNdKXqiSRVRtMArn0uJk0BCP5ee6uOojGMWL
	jnnsoE2Fn3VkkPyD3xWk+hKwrcZurV8Dqn1seuWrzoQQxHu16iFYgup9T/D1H6KCYlUtbyibc6G
	a7BgO9idT8UZkTU5ArU0af6e1vp1/STfbCEyFQd9YjLsitHPo7Oe5Tu6CeEfwJjZNR7voyzPj02
	vavl1LFnkVqS0=
X-Received: by 2002:a05:6808:4483:b0:486:5466:e41f with SMTP id 5614622812f47-4a42b0422cfmr7468514b6e.38.1783980072438;
        Mon, 13 Jul 2026 15:01:12 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc82f3csm12939785b6e.3.2026.07.13.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:01:11 -0700 (PDT)
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
Subject: [PATCH v16 07/10] iio: imu: inv_icm42607: Add Accelerometer for icm42607
Date: Mon, 13 Jul 2026 16:58:37 -0500
Message-ID: <20260713215842.69097-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713215842.69097-1-macroalpha82@gmail.com>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add icm42607 accelerometer sensor for icm42607.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42607/Makefile         |   1 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  38 +++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 302 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 187 +++++++++++
 4 files changed, 528 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c

diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index be109102e203..372c6d6bdcec 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
 inv-icm42607-y += inv_icm42607_core.o
+inv-icm42607-y += inv_icm42607_accel.o
 
 obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
 inv-icm42607-i2c-y += inv_icm42607_i2c.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index cb6369cc1bfc..decd7c7baad8 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -88,6 +88,17 @@ enum inv_icm42607_filter_bw {
 	INV_ICM42607_FILTER_BW_NB
 };
 
+/* Low-Power mode sensor data filter (averaging) */
+enum inv_icm42607_filter_avg {
+	INV_ICM42607_FILTER_AVG_2X = 0,
+	INV_ICM42607_FILTER_AVG_4X = 1,
+	INV_ICM42607_FILTER_AVG_8X = 2,
+	INV_ICM42607_FILTER_AVG_16X = 3,
+	INV_ICM42607_FILTER_AVG_32X = 4,
+	INV_ICM42607_FILTER_AVG_64X = 5,
+	/* values 6 and 7 also correspond to 64x. */
+};
+
 /* Temperature sensor data filter (bandwidth) */
 enum inv_icm42607_temp_filter_bw {
 	INV_ICM42607_TEMP_FILTER_BYPASS = 0,
@@ -107,6 +118,7 @@ struct inv_icm42607_sensor_conf {
 	int odr;
 	int filter;
 };
+#define INV_ICM42607_SENSOR_CONF_INIT		{ -1, -1, -1, -1 }
 
 struct inv_icm42607_conf {
 	struct inv_icm42607_sensor_conf gyro;
@@ -130,6 +142,7 @@ struct inv_icm42607_suspended {
  *  @hw:		Hardware specific data.
  *  @lock:		lock for serializing multiple registers access.
  *  @map:		regmap pointer.
+ *  @indio_accel:	accelerometer IIO device.
  *  @vddio_supply:	I/O voltage regulator for the chip.
  *  @vddio_en:		I/O voltage status for runtime PM.
  *  @suspended:		suspended sensors configuration.
@@ -140,6 +153,7 @@ struct inv_icm42607_state {
 	const struct inv_icm42607_hw *hw;
 	struct mutex lock;
 	struct regmap *map;
+	struct iio_dev *indio_accel;
 	struct regulator *vddio_supply;
 	bool vddio_en;
 	struct inv_icm42607_suspended suspended;
@@ -147,6 +161,16 @@ struct inv_icm42607_state {
 	struct iio_mount_matrix orientation;
 };
 
+/**
+ * struct inv_icm42607_sensor_state - sensor state variables
+ * @power_mode:		sensor requested power mode (for common frequencies)
+ * @filter:		sensor filter.
+ */
+struct inv_icm42607_sensor_state {
+	enum inv_icm42607_sensor_mode power_mode;
+	int filter;
+};
+
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
 
 /* Register Map for User Bank 0 */
@@ -375,12 +399,26 @@ extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
+const struct iio_mount_matrix *
+inv_icm42607_get_mount_matrix(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan);
+
 int inv_icm42607_get_pwr_mgmt0(struct inv_icm42607_state *st,
 			       enum inv_icm42607_sensor_mode *gyro,
 			       enum inv_icm42607_sensor_mode *accel);
 
+int inv_icm42607_set_sensor_conf(struct inv_icm42607_state *st,
+				 struct inv_icm42607_sensor_conf *conf,
+				 enum iio_chan_type chan_type);
+
+int inv_icm42607_read_sensor(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     s16 *val);
+
 int inv_icm42607_core_probe(struct regmap *regmap,
 			    const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
 
+struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
new file mode 100644
index 000000000000..7a0c419c0f06
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -0,0 +1,302 @@
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
+#define INV_ICM42607_ACCEL_CHAN(_modifier, _index, _ext_info)			\
+{										\
+	.type = IIO_ACCEL,							\
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
+enum inv_icm42607_accel_scan {
+	INV_ICM42607_ACCEL_SCAN_X,
+	INV_ICM42607_ACCEL_SCAN_Y,
+	INV_ICM42607_ACCEL_SCAN_Z,
+};
+
+static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
+	{ }
+};
+
+static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
+	INV_ICM42607_ACCEL_CHAN(IIO_MOD_X, INV_ICM42607_ACCEL_SCAN_X,
+				inv_icm42607_accel_ext_infos),
+	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42607_ACCEL_SCAN_Y,
+				inv_icm42607_accel_ext_infos),
+	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42607_ACCEL_SCAN_Z,
+				inv_icm42607_accel_ext_infos),
+};
+
+static const int inv_icm42607_accel_scale_nano[][2] = {
+	[INV_ICM42607_ACCEL_FS_16G] = { 0, 4788403 },
+	[INV_ICM42607_ACCEL_FS_8G] = { 0, 2394202 },
+	[INV_ICM42607_ACCEL_FS_4G] = { 0, 1197101 },
+	[INV_ICM42607_ACCEL_FS_2G] = { 0, 598550 },
+};
+
+static int inv_icm42607_accel_read_scale(struct iio_dev *indio_dev,
+					 int *val, int *val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	unsigned int idx;
+
+	guard(mutex)(&st->lock);
+
+	idx = st->conf.accel.fs;
+
+	*val = inv_icm42607_accel_scale_nano[idx][0];
+	*val2 = inv_icm42607_accel_scale_nano[idx][1];
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int inv_icm42607_accel_write_scale(struct iio_dev *indio_dev,
+					  int val, int val2)
+{
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	size_t scales_len = ARRAY_SIZE(inv_icm42607_accel_scale_nano);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	int ret;
+
+	for (idx = 0; idx < scales_len; idx++) {
+		if (val == inv_icm42607_accel_scale_nano[idx][0] &&
+		    val2 == inv_icm42607_accel_scale_nano[idx][1])
+			break;
+	}
+	if (idx >= scales_len)
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
+	return inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);
+}
+
+/* IIO format int + micro , values 0-4 reserved. */
+static const int inv_icm42607_accel_odr[][2] = {
+	[INV_ICM42607_ODR_1600HZ] = { 1600, 0 },
+	[INV_ICM42607_ODR_800HZ] = { 800, 0 },
+	[INV_ICM42607_ODR_400HZ] = { 400, 0 },
+	[INV_ICM42607_ODR_200HZ] = { 200, 0 },
+	[INV_ICM42607_ODR_100HZ] = { 100, 0 },
+	[INV_ICM42607_ODR_50HZ] = { 50, 0 },
+	[INV_ICM42607_ODR_25HZ] = { 25, 0 },
+	[INV_ICM42607_ODR_12_5HZ] = { 12, 500000 },
+	[INV_ICM42607_ODR_6_25HZ_LP] = { 6, 250000 },
+	[INV_ICM42607_ODR_3_125HZ_LP] = { 3, 125000 },
+	[INV_ICM42607_ODR_1_5625HZ_LP] = { 1, 562500 },
+};
+
+static int inv_icm42607_accel_read_odr(struct inv_icm42607_state *st,
+				       int *val, int *val2)
+{
+	unsigned int odr;
+	unsigned int i;
+
+	guard(mutex)(&st->lock);
+
+	odr = st->conf.accel.odr;
+
+	for (i = INV_ICM42607_ODR_1600HZ; i < ARRAY_SIZE(inv_icm42607_accel_odr); i++) {
+		if (i == odr)
+			break;
+	}
+	if (i >= ARRAY_SIZE(inv_icm42607_accel_odr))
+		return -EINVAL;
+
+	*val = inv_icm42607_accel_odr[i][0];
+	*val2 = inv_icm42607_accel_odr[i][1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
+					int val, int val2)
+{
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	int ret;
+
+	for (idx = INV_ICM42607_ODR_1600HZ;
+	     idx < ARRAY_SIZE(inv_icm42607_accel_odr); idx++) {
+		if (val == inv_icm42607_accel_odr[idx][0] &&
+		    val2 == inv_icm42607_accel_odr[idx][1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42607_accel_odr))
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
+	return inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);
+}
+
+static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       int *val, int *val2, long mask)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	s16 data;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = inv_icm42607_read_sensor(indio_dev, chan, &data);
+		if (ret)
+			return ret;
+		*val = data;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
+		return inv_icm42607_accel_read_scale(indio_dev, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42607_accel_read_odr(st, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42607_accel_read_avail(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan,
+					 const int **vals,
+					 int *type, int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
+		*vals = (const int *)inv_icm42607_accel_scale_nano;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(inv_icm42607_accel_scale_nano) * 2;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)inv_icm42607_accel_odr[5];
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = (ARRAY_SIZE(inv_icm42607_accel_odr) - 5) * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42607_accel_write_raw(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					int val, int val2, long mask)
+{
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
+		ret = inv_icm42607_accel_write_scale(indio_dev, val, val2);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42607_accel_write_odr(indio_dev, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42607_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
+						struct iio_chan_spec const *chan,
+						long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info inv_icm42607_accel_info = {
+	.read_raw = inv_icm42607_accel_read_raw,
+	.read_avail = inv_icm42607_accel_read_avail,
+	.write_raw = inv_icm42607_accel_write_raw,
+	.write_raw_get_fmt = inv_icm42607_accel_write_raw_get_fmt,
+};
+
+struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st)
+{
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm42607_sensor_state *accel_st;
+	struct iio_dev *indio_dev;
+	const char *name;
+	int ret;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->hw->name);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*accel_st));
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
+	accel_st = iio_priv(indio_dev);
+
+	accel_st->power_mode = INV_ICM42607_SENSOR_MODE_LOW_NOISE;
+	accel_st->filter = INV_ICM42607_FILTER_BW_73HZ;
+
+	iio_device_set_drvdata(indio_dev, st);
+	indio_dev->name = name;
+	indio_dev->info = &inv_icm42607_accel_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = inv_icm42607_accel_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm42607_accel_channels);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return indio_dev;
+}
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 303a6a0b1b21..45e031cefd4a 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -19,6 +19,7 @@
 #include <linux/time.h>
 #include <linux/timekeeping.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 
 #include "inv_icm42607.h"
 
@@ -106,6 +107,15 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
 
+const struct iio_mount_matrix *
+inv_icm42607_get_mount_matrix(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan)
+{
+	const struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+
+	return &st->orientation;
+}
+
 int inv_icm42607_get_pwr_mgmt0(struct inv_icm42607_state *st,
 			       enum inv_icm42607_sensor_mode *gyro,
 			       enum inv_icm42607_sensor_mode *accel)
@@ -190,6 +200,178 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 	return 0;
 }
 
+/*
+ * Sanity test between old and new config values, and note if we need
+ * to update register config0 or config1.
+ */
+static void inv_icm42607_update_config(struct inv_icm42607_sensor_conf *conf,
+				       struct inv_icm42607_sensor_conf *oldconf,
+				       bool *config0, bool *config1)
+{
+	if (conf->mode < 0)
+		conf->mode = oldconf->mode;
+	if (conf->fs < 0)
+		conf->fs = oldconf->fs;
+	if (conf->odr < 0)
+		conf->odr = oldconf->odr;
+	if (conf->filter < 0)
+		conf->filter = oldconf->filter;
+
+	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr)
+		*config0 = true;
+	else
+		*config0 = false;
+
+	if (conf->filter != oldconf->filter)
+		*config1 = true;
+	else
+		*config1 = false;
+}
+
+int inv_icm42607_set_sensor_conf(struct inv_icm42607_state *st,
+				 struct inv_icm42607_sensor_conf *conf,
+				 enum iio_chan_type chan_type)
+{
+	struct inv_icm42607_sensor_conf *oldconf;
+	unsigned int accel_mode, gyro_mode;
+	bool config0, config1;
+	unsigned int val;
+	int ret;
+
+	switch (chan_type) {
+	case IIO_ACCEL:
+		oldconf = &st->conf.accel;
+		break;
+	case IIO_ANGL_VEL:
+		oldconf = &st->conf.gyro;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Since we are only making one-shot calls today, we can avoid needless
+	 * on/off cycles if we rely on the runtime power management to handle
+	 * shutting off the sensors when not in use. The downside is if we
+	 * enable both sensors then only read from one, we have to wait for
+	 * runtime PM to turn it off. So just keep the mode of the sensor we
+	 * are not actively using to whatever it's already set as.
+	 */
+	ret = inv_icm42607_get_pwr_mgmt0(st, &gyro_mode, &accel_mode);
+	if (ret)
+		return ret;
+
+	inv_icm42607_update_config(conf, oldconf, &config0, &config1);
+
+	if (config0) {
+		if (chan_type == IIO_ANGL_VEL) {
+			val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK, conf->fs);
+			val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK, conf->odr);
+			ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
+		} else {
+			val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->fs);
+			val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->odr);
+			ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
+		}
+		if (ret)
+			return ret;
+
+		oldconf->fs = conf->fs;
+		oldconf->odr = conf->odr;
+	}
+
+	if (config1) {
+		if (chan_type == IIO_ANGL_VEL) {
+			val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK,
+					 conf->filter);
+			ret = regmap_update_bits(st->map, INV_ICM42607_REG_GYRO_CONFIG1,
+						 INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, val);
+		} else {
+			val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK,
+					 conf->filter);
+			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
+						 INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK, val);
+		}
+		if (ret)
+			return ret;
+
+		oldconf->filter = conf->filter;
+	}
+
+	switch (chan_type) {
+	case IIO_ACCEL:
+		return inv_icm42607_set_pwr_mgmt0(st, gyro_mode, conf->mode);
+	case IIO_ANGL_VEL:
+		return inv_icm42607_set_pwr_mgmt0(st, conf->mode, accel_mode);
+	default:
+		return -EINVAL;
+	}
+}
+
+int inv_icm42607_read_sensor(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     s16 *val)
+{
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *sensor_st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int reg;
+	u8 data[2];
+	int ret;
+
+	if ((chan->type != IIO_ANGL_VEL) && (chan->type != IIO_ACCEL))
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		if (chan->type == IIO_ANGL_VEL)
+			reg = INV_ICM42607_REG_GYRO_DATA_X1;
+		else
+			reg = INV_ICM42607_REG_ACCEL_DATA_X1;
+		break;
+	case IIO_MOD_Y:
+		if (chan->type == IIO_ANGL_VEL)
+			reg = INV_ICM42607_REG_GYRO_DATA_Y1;
+		else
+			reg = INV_ICM42607_REG_ACCEL_DATA_Y1;
+		break;
+	case IIO_MOD_Z:
+		if (chan->type == IIO_ANGL_VEL)
+			reg = INV_ICM42607_REG_GYRO_DATA_Z1;
+		else
+			reg = INV_ICM42607_REG_ACCEL_DATA_Z1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	/* enable sensor */
+	conf.mode = sensor_st->power_mode;
+	conf.filter = sensor_st->filter;
+	ret = inv_icm42607_set_sensor_conf(st, &conf, chan->type);
+	if (ret)
+		return ret;
+
+	/* read sensor register data */
+	ret = regmap_bulk_read(st->map, reg, data, sizeof(data));
+	if (ret)
+		return ret;
+
+	*val = get_unaligned_be16(data);
+	if (*val == INV_ICM42607_DATA_INVALID)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int inv_icm42607_set_init_conf(struct inv_icm42607_state *st,
 				      const struct inv_icm42607_conf *conf)
 {
@@ -384,6 +566,11 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
+	/* Initialize IIO device for Accel */
+	st->indio_accel = inv_icm42607_accel_init(st);
+	if (IS_ERR(st->indio_accel))
+		return PTR_ERR(st->indio_accel);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
-- 
2.43.0

