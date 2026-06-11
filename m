Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92D3B8BA1
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209723; cv=none; b=c4jmkX7u+f61OVWVM4a5E04ZgR5AuvTIw3jd1VnqsFdmE4lHlmT91/onW7tLYTV9YCs3qrntIH132VZz75G7Sl0lyyuDtaCn6cM8/ex5hPeR/aVE2UtbEadrPC1RpRSO2ksQ1e9jlPWEijLmDQaP9OkYQEXuCIHoaj5h0JcbNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209723; c=relaxed/simple;
	bh=4HnAtMdWUNCvoRoo/WUM00QgB8V4WEzDcnYVfD453gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4+YamqEcQdlANrQygQQGIvNZ24nJPoPIT4NCs516pI+skiam80J9Xkq5e+ehMVG1fwZIScA6mnL5MDVuvAiNLf8tfkR8HtFTKdmBmAKTLDJMSWABm51msBE3+ynEaQboqzuAmg3RnmsVfcfIa7cmyp9fNdyGVYhHhhPxav7ULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etvBbC2W; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etvBbC2W"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43f5e285111so246866fac.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781209719; x=1781814519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6tN3MWfP0MkuNroim/Hl2ouiUZ+OtnDV/CJmLsD1EY=;
        b=etvBbC2WMUrX6241rKaBV6zs04UknvfGqs5Ze/JR6RVhpGQID4A/WoIlJSOs8MGy4d
         wa148EK78Z+KAO4mNgVI+GwIXLKqkbcsTJd2AZaV2qBUT6DuOLtFb/hajTaXtpZMEOyf
         GikASmQwfuatcr8l2enPlHwQO58WPautyIARqVR9JSgThuUg19+2mbNdMU3rbyNYxKMo
         yHgYiLuucJZDAxr5dqjkvZnp4qKwqfoAmJkQUt0TYA9duasjKmzEWAvTKomEXa6f45Gi
         xQhYFGHponT6wLFwUo5sZp3KXtZBCGVn6YmN5KWwkKTZSMfGVKFUKMmwulNQm/QBgl1a
         BvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209719; x=1781814519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x6tN3MWfP0MkuNroim/Hl2ouiUZ+OtnDV/CJmLsD1EY=;
        b=AQfFYaW/K/WjZM1Yc2KyYm/dH79aRFdZUkaaYCdOci+FMXimsF1yHrVAqj9/G1jz9m
         A3K4mkhwXTf4LJva+vPP0Ti+Egs9w+8R3do2k3K3mFqTrUFOFnG+xYS8KNA0W3iiyxoh
         wg1QMI9/gfUr058M+elMLmOmJMDn/ADJuVYFpSf2vro64DoXSC9Iw5rb/zlQJVZzqEmC
         WOsP/MfwFY7WgrJo4uuqRisbMvRINiGJjmJPUC4eOwfeUc0ezdUuG/iq+7vRvvW0pdi0
         Qyr0CzwiFFEtn0jZhxN1zbmJJMNOx3JLd35IaerfHbZshjp4/bIzqZSwU4scIknOEk0G
         30sg==
X-Gm-Message-State: AOJu0Yy8ORc+m7ylnXRPz7J9xWsa01mUQeZE7R/xhSzU7pCMV9VWxgp2
	SRkE4NkBSZ9F8nkNUPjTp58S/t08fZM52XJy6rVdZgbHUAJGsVPtevE4ZxfIF6ae
X-Gm-Gg: Acq92OEQnnOdDwKIDwEDR/w/9yft7RGYHM1l4Pmdec7vLxfec7kZDYvyjqflTHAJLvs
	aadbiGiIeqThn+DzvgQwix/scAGZ96SZ/Yyi4HLH71bQS/z/SiJyzXCHglK87MBjMmaVnoVAHbm
	I7tkeDBGlAtpgmXBTYf204/2H6Y2VQ7gLLo03pZwxgY9UeCAsOnbho1o3yOTu7LRd3K+hlPShjW
	QR2pkFCajgF075VnVBHSfMSHpK7mV0ia3LCSpQahGwWfqeJPfMiV8/GktnHVx0xmSo1srLz51cE
	uwnAZhX9cZ8mjQc7q5Jl5rYi5z/poByOC4LRzFFWvOxgSQBCaHGJmGufSGIWSS60s0GlHhVZYZ4
	5IJiwM4foDjrhP5ywPR4J6VkBVCOQ98Bl/GBP1cyvYBl9I/yXrP+Di/u54cLlDbWx64Q5TJ8p7c
	XJCPaRwJt/9Pw2p3iK/CQpOw==
X-Received: by 2002:a05:6870:9f01:b0:439:c2da:7dd2 with SMTP id 586e51a60fabf-44241f4fb59mr2666281fac.31.1781209719440;
        Thu, 11 Jun 2026 13:28:39 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44244cd05c9sm1796134fac.18.2026.06.11.13.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:28:39 -0700 (PDT)
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
Subject: [PATCH V12 7/9] iio: imu: inv_icm42607: Add Accelerometer for icm42607
Date: Thu, 11 Jun 2026 15:26:04 -0500
Message-ID: <20260611202607.85376-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611202607.85376-1-macroalpha82@gmail.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  34 ++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 376 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  |  61 +++
 4 files changed, 472 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c

diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index c04953ed42ce..d74b23b1e1be 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
 inv-icm42607-y += inv_icm42607_core.o
+inv-icm42607-y += inv_icm42607_accel.o
 inv-icm42607-y += inv_icm42607_temp.o
 
 obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 53dd23509a53..e236e5aa61cb 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -86,6 +86,17 @@ enum inv_icm42607_filter_bw {
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
 /* Signed so that negative values can signify an invalid condition. */
 struct inv_icm42607_sensor_conf {
 	int mode;
@@ -93,6 +104,7 @@ struct inv_icm42607_sensor_conf {
 	int odr;
 	int filter;
 };
+#define INV_ICM42607_SENSOR_CONF_INIT		{ -1, -1, -1, -1 }
 
 struct inv_icm42607_conf {
 	struct inv_icm42607_sensor_conf gyro;
@@ -117,6 +129,7 @@ struct inv_icm42607_suspended {
  *  @buffer:		data transfer buffer aligned for DMA.
  *  @hw:		Hardware specific data.
  *  @map:		regmap pointer.
+ *  @indio_accel:	accelerometer IIO device.
  *  @vddio_supply:	I/O voltage regulator for the chip.
  *  @suspended:		suspended sensors configuration.
  *  @vddio_en:		I/O voltage status for runtime PM.
@@ -128,6 +141,7 @@ struct inv_icm42607_state {
 	__be16 buffer[3] __aligned(IIO_DMA_MINALIGN);
 	const struct inv_icm42607_hw *hw;
 	struct regmap *map;
+	struct iio_dev *indio_accel;
 	struct regulator *vddio_supply;
 	struct inv_icm42607_suspended suspended;
 	bool vddio_en;
@@ -136,6 +150,16 @@ struct inv_icm42607_state {
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
@@ -365,6 +389,14 @@ extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
+const struct iio_mount_matrix *
+inv_icm42607_get_mount_matrix(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan);
+
+int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
+				struct inv_icm42607_sensor_conf *conf,
+				unsigned int *sleep_ms);
+
 int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
 			       unsigned int *sleep_ms);
 
@@ -372,4 +404,6 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 			    const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
 
+struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
new file mode 100644
index 000000000000..5e260ddad641
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include "inv_icm42607.h"
+#include "inv_icm42607_temp.h"
+
+#define INV_ICM42607_ACCEL_CHAN(_modifier, _index, _ext_info)		\
+{									\
+	.type = IIO_ACCEL,						\
+	.modified = 1,							\
+	.channel2 = _modifier,						\
+	.info_mask_separate =						\
+		BIT(IIO_CHAN_INFO_RAW),					\
+	.info_mask_shared_by_type =					\
+		BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_all =					\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_all_available =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = _index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_BE,					\
+	},								\
+	.ext_info = _ext_info,						\
+}
+
+enum inv_icm42607_accel_scan {
+	INV_ICM42607_ACCEL_SCAN_X,
+	INV_ICM42607_ACCEL_SCAN_Y,
+	INV_ICM42607_ACCEL_SCAN_Z,
+	INV_ICM42607_ACCEL_SCAN_TEMP,
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
+	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
+};
+
+static int inv_icm42607_accel_read_sensor(struct iio_dev *indio_dev,
+					  struct iio_chan_spec const *chan,
+					  s16 *val)
+{
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int reg;
+	__be16 *data;
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM42607_REG_ACCEL_DATA_X1;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM42607_REG_ACCEL_DATA_Y1;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM42607_REG_ACCEL_DATA_Z1;
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
+	/* enable accel sensor */
+	conf.mode = accel_st->power_mode;
+	conf.filter = accel_st->filter;
+	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
+	if (ret)
+		return ret;
+
+	/* read accel register data */
+	data = &st->buffer[0];
+	ret = regmap_bulk_read(st->map, reg, data, sizeof(*data));
+	if (ret)
+		return ret;
+
+	*val = be16_to_cpup(data);
+	if (*val == INV_ICM42607_DATA_INVALID)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const int inv_icm42607_accel_scale_nano[][2] = {
+	[INV_ICM42607_ACCEL_FS_16G] = { 0, 4788403 },
+	[INV_ICM42607_ACCEL_FS_8G] = { 0, 2394202 },
+	[INV_ICM42607_ACCEL_FS_4G] = { 0, 1197101 },
+	[INV_ICM42607_ACCEL_FS_2G] = { 0, 598550 }
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
+	return inv_icm42607_set_accel_conf(st, &conf, NULL);
+}
+
+/* IIO format int + micro , values 0-5 reserved. */
+static const int inv_icm42607_accel_odr[][2] = {
+	[INV_ICM42607_ODR_1_5625HZ_LP] = { 1, 562500 },
+	[INV_ICM42607_ODR_3_125HZ_LP] = { 3, 125000 },
+	[INV_ICM42607_ODR_6_25HZ_LP] = { 6, 250000 },
+	[INV_ICM42607_ODR_12_5HZ] = { 12, 500000 },
+	[INV_ICM42607_ODR_25HZ] = { 25, 0 },
+	[INV_ICM42607_ODR_50HZ] = { 50, 0 },
+	[INV_ICM42607_ODR_100HZ] = { 100, 0 },
+	[INV_ICM42607_ODR_200HZ] = { 200, 0 },
+	[INV_ICM42607_ODR_400HZ] = { 400, 0 },
+	[INV_ICM42607_ODR_800HZ] = { 800, 0 },
+	[INV_ICM42607_ODR_1600HZ] = { 1600, 0 }
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
+	for (i = 5; i < ARRAY_SIZE(inv_icm42607_accel_odr); ++i) {
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
+	for (idx = 5; idx < ARRAY_SIZE(inv_icm42607_accel_odr); ++idx) {
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
+	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
+	if (ret)
+		return ret;
+
+	return 0;
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
+	switch (chan->type) {
+	case IIO_ACCEL:
+		break;
+	case IIO_TEMP:
+		if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+			return inv_icm42607_temp_read_raw(indio_dev, chan,
+							  val, val2, mask);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = inv_icm42607_accel_read_sensor(indio_dev, chan, &data);
+		if (ret)
+			return ret;
+		*val = data;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
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
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
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
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
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
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
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
index 549fe248e600..86ddbf72858c 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -103,6 +103,15 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
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
 static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 				      enum inv_icm42607_sensor_mode gyro,
 				      enum inv_icm42607_sensor_mode accel,
@@ -153,6 +162,53 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 	return 0;
 }
 
+int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
+				struct inv_icm42607_sensor_conf *conf,
+				unsigned int *sleep_ms)
+{
+	struct inv_icm42607_sensor_conf *oldconf = &st->conf.accel;
+	unsigned int val;
+	int ret;
+
+	if (conf->mode < 0)
+		conf->mode = oldconf->mode;
+	if (conf->fs < 0)
+		conf->fs = oldconf->fs;
+	if (conf->odr < 0)
+		conf->odr = oldconf->odr;
+	if (conf->filter < 0)
+		conf->filter = oldconf->filter;
+
+	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
+		val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->fs);
+		val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->odr);
+		ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->fs = conf->fs;
+		oldconf->odr = conf->odr;
+	}
+
+	if (conf->filter != oldconf->filter) {
+		if (conf->mode == INV_ICM42607_SENSOR_MODE_LOW_POWER) {
+			val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_AVG_MASK, conf->filter);
+			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
+						 INV_ICM42607_ACCEL_CONFIG1_AVG_MASK, val);
+		} else {
+			val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK,
+					 conf->filter);
+			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
+						 INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK, val);
+		}
+		if (ret)
+			return ret;
+		oldconf->filter = conf->filter;
+	}
+
+	return inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode,
+					  st->conf.temp_en, sleep_ms);
+}
+
 int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
 			       unsigned int *sleep_ms)
 {
@@ -364,6 +420,11 @@ int inv_icm42607_core_probe(struct regmap *regmap,
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

