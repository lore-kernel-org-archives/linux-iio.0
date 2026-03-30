Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7030F7EB
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900874; cv=none; b=c9R9RF1v7XUMrof6FSGxSz8M1m2qTCajUSxSg3GvFwnndPctt51fEkoLrAy15CPipNBtVhzUybVDg04yTs+8qIIvk9pNNoJpp9TfuwY8cgL/1XtoyIPP+GD5kkkmE3BoGNETv5ow1HiC3GarAISfyDcrRkHOwJ+Ghtn2nsKg/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900874; c=relaxed/simple;
	bh=sQ3Ys+skBZBCiQr2gzrNYiHmvo8EfWgkYzC+8r+BHwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SixcA4LerYFNtMRE33lJPGYj00CwSBil9q9fZ0t8eWOTxXZALBv8vi4W8W8VvGRrhz5xihRgBjqZj3hZFITBAdR2oAo/2TEBQMbhM6VY+sFU5HwqGI7al+R977490x/+kBNIkOsMF13074gc20aVWuFCdcZmqF/ykB2ROp+JSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGrZqulQ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGrZqulQ"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so4756374a34.2
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774900871; x=1775505671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJPnbDCqMzkmHaq3Z+UcszsCH/DpSGHy3tor1UegfKE=;
        b=cGrZqulQUCQ1bfg2GnNBIqTvSdAH03y4pDfPxtph4qKON19B/MpRnPDxqK/wHk3I+N
         74m4PIaectbWNW+UtwnDUkI+ADek+ZU0caG9o3aO6AL3fM+Qv7TYiaipaEQGkJhm48gS
         mKyiWvNhXVhYcy+ON1iF7Isogmh85YQxCnvzebE2/1kx3Mz1EriPYVeRYp6nBJS2sMvm
         bx8oVG7vi+YOywYiO3tnDzZsRK0dCb3tXXBm0ssnhM5YkocaoZNh0raWl+w/mezgqKgI
         jijBtPqH7BqE8Eh48/ATt7opY7ZG5tZdBUa3FG60BJRzhmwbxL6TDADTcOF5q9qwEHJ1
         J7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774900871; x=1775505671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJPnbDCqMzkmHaq3Z+UcszsCH/DpSGHy3tor1UegfKE=;
        b=DCQdRmhXomdt7n7ya3qOVmLzY/3iz6XTv2s6sJWycC8iuKUBVdmGhhazGLhf/Tqi2Q
         Nv2fepwkz2LDp7/jOJ8J2nHqSnznCa0XYuxaotIQ9eEhY+lraO03IYNhJsXTZCdZKc1j
         FC43bg/KWFvPLnrfZeC6ydrYyW7ibiSjSWj6hwgJEfowVBm2qXMtzM2UfKwO8XSQGyva
         paYer2k91CGFcIxsBhj2YHhjHC8eaXiQtviBibHJNjEAuH2o2b6cXLSw9X6XkeiIAo9a
         3+fjvor7bdczIschqmoZdErj5Yar6O/+WP52K+P83EqcDPogDYK31yIFtDfwE8FLAqzu
         2HXA==
X-Gm-Message-State: AOJu0YwFE/wOSPk+nS6m90eXpXVh7d1IQn0OgA7X3ShKjauEY559Ultf
	rHDpTM+XUhUW1bCH0tbvEopip4bhHcflyKEXK0y5HEw39d4eYHohLaUlrWre+a1w
X-Gm-Gg: ATEYQzxOoxIwj5f40bab0MA0XdFsBUaYhUAZCIkDQs3O9CDgX/zwv4eEElcJMf/Hvgy
	9IngQUDzYbFjRhko3cd5LGocKcoCqJbIYXv2Iiboo2C2bkS4m5prfTOlDdJx53VsBOwQV18pqy3
	B/dTV+6Am8DcHGVtnhFtygugLOO3dfjMLs9c7MPcHN4DyDPfJLKm/ciLGstzgqYuz7oQO78GydQ
	TOk7nucYcXqE16BmtuPlaUF0N8nCeY4gLpW5MXm4y1lVtYcGt4nS2dM14iQgD1XRai1mgW144BE
	XfFd/B61TnIebSs0tRb+UEedkba8xmWMdm1786IHfiS81T5mTxBVAt7aul5WgxTMELIDh3GSZ/H
	IO3tolrqJHPhoGmD7HAWbhBWYAkRLUHglKW4Z1O18nkjmMrlgyaMD0c6hKSD3b7ZqyxG3/mSp7G
	nDNRGJLFMzgrWTGrNA3N4a
X-Received: by 2002:a05:6830:82f7:b0:7d7:cce6:504d with SMTP id 46e09a7af769-7d9fadc98afmr8663284a34.11.1774900870860;
        Mon, 30 Mar 2026 13:01:10 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336353sm6601068a34.2.2026.03.30.13.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:01:10 -0700 (PDT)
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
Subject: [PATCH V3 6/9] iio: imu: inv_icm42607: Add Accelerometer for icm42607
Date: Mon, 30 Mar 2026 14:58:50 -0500
Message-ID: <20260330195853.392877-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330195853.392877-1-macroalpha82@gmail.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  12 +
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 725 ++++++++++++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.c    |  49 +-
 .../imu/inv_icm42607/inv_icm42607_buffer.h    |   2 +
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  |  60 ++
 5 files changed, 847 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 086848c8fd3b..56bb09e2c304 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -431,8 +431,16 @@ typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 extern const struct regmap_config inv_icm42607_regmap_config;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
+const struct iio_mount_matrix *
+inv_icm42607_get_mount_matrix(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan);
+
 u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr);
 
+int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
+				struct inv_icm42607_sensor_conf *conf,
+				unsigned int *sleep_ms);
+
 int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
 			       unsigned int *sleep_ms);
 
@@ -442,4 +450,8 @@ int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 int inv_icm42607_core_probe(struct regmap *regmap, int chip,
 			    inv_icm42607_bus_setup bus_setup);
 
+struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st);
+
+int inv_icm42607_accel_parse_fifo(struct iio_dev *indio_dev);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
new file mode 100644
index 000000000000..58754af31100
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -0,0 +1,725 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/units.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+
+#include "inv_icm42607.h"
+#include "inv_icm42607_temp.h"
+#include "inv_icm42607_buffer.h"
+
+#define INV_ICM42607_ACCEL_CHAN(_modifier, _index, _ext_info)		\
+{									\
+	.type = IIO_ACCEL,						\
+	.modified = 1,							\
+	.channel2 = _modifier,						\
+	.info_mask_separate =						\
+		BIT(IIO_CHAN_INFO_RAW) |				\
+		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
+	.info_mask_shared_by_type =					\
+		BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
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
+#define INV_ICM42607_ACCEL_EVENT_CHAN(_modifier, _events, _events_nb)	\
+	{								\
+		.type = IIO_ACCEL,					\
+		.modified = 1,						\
+		.channel2 = _modifier,					\
+		.event_spec = _events,					\
+		.num_event_specs = _events_nb,				\
+		.scan_index = -1,					\
+	}
+
+enum inv_icm42607_accel_scan {
+	INV_ICM42607_ACCEL_SCAN_X,
+	INV_ICM42607_ACCEL_SCAN_Y,
+	INV_ICM42607_ACCEL_SCAN_Z,
+	INV_ICM42607_ACCEL_SCAN_TEMP,
+	INV_ICM42607_ACCEL_SCAN_TIMESTAMP,
+};
+
+static const char * const inv_icm42607_accel_power_mode_items[] = {
+	"low-noise",
+	"low-power",
+};
+
+static const int inv_icm42607_accel_power_mode_values[] = {
+	INV_ICM42607_SENSOR_MODE_LOW_NOISE,
+	INV_ICM42607_SENSOR_MODE_LOW_POWER,
+};
+static const int inv_icm42607_accel_filter_values[] = {
+	INV_ICM42607_FILTER_BW_25HZ,
+	INV_ICM42607_FILTER_AVG_16X,
+};
+
+static int inv_icm42607_accel_power_mode_set(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan,
+					     unsigned int idx)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	int power_mode, filter;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	if (idx >= ARRAY_SIZE(inv_icm42607_accel_power_mode_values))
+		return -EINVAL;
+
+	power_mode = inv_icm42607_accel_power_mode_values[idx];
+	filter = inv_icm42607_accel_filter_values[idx];
+
+	guard(mutex)(&st->lock);
+
+	/* cannot change if accel sensor is on */
+	if (st->conf.accel.mode != INV_ICM42607_SENSOR_MODE_OFF)
+		return -EBUSY;
+
+	/* prevent change if power mode is not supported by the ODR */
+	switch (power_mode) {
+	case INV_ICM42607_SENSOR_MODE_LOW_NOISE:
+		if (st->conf.accel.odr >= INV_ICM42607_ODR_6_25HZ_LP)
+			return -EPERM;
+		break;
+	case INV_ICM42607_SENSOR_MODE_LOW_POWER:
+	default:
+		if (st->conf.accel.odr <= INV_ICM42607_ODR_800HZ)
+			return -EPERM;
+		break;
+	}
+
+	accel_st->power_mode = power_mode;
+	accel_st->filter = filter;
+
+	return 0;
+}
+
+static int inv_icm42607_accel_power_mode_get(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	unsigned int idx;
+	int power_mode;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	/* if sensor is on, returns actual power mode and not configured one */
+	switch (st->conf.accel.mode) {
+	case INV_ICM42607_SENSOR_MODE_LOW_POWER:
+	case INV_ICM42607_SENSOR_MODE_LOW_NOISE:
+		power_mode = st->conf.accel.mode;
+		break;
+	default:
+		power_mode = accel_st->power_mode;
+		break;
+	}
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm42607_accel_power_mode_values); ++idx) {
+		if (power_mode == inv_icm42607_accel_power_mode_values[idx])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42607_accel_power_mode_values))
+		return -EINVAL;
+
+	return idx;
+}
+
+static const struct iio_enum inv_icm42607_accel_power_mode_enum = {
+	.items = inv_icm42607_accel_power_mode_items,
+	.num_items = ARRAY_SIZE(inv_icm42607_accel_power_mode_items),
+	.set = inv_icm42607_accel_power_mode_set,
+	.get = inv_icm42607_accel_power_mode_get,
+};
+
+static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
+	IIO_ENUM_AVAILABLE("power_mode", IIO_SHARED_BY_TYPE,
+			   &inv_icm42607_accel_power_mode_enum),
+	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE,
+		 &inv_icm42607_accel_power_mode_enum),
+	{ },
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
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42607_ACCEL_SCAN_TIMESTAMP),
+};
+
+static const struct iio_event_spec inv_icm42607_motion_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
+/*
+ * IIO buffer data: size must be a power of 2 and timestamp aligned
+ * 16 bytes: 6 bytes acceleration, 2 bytes temperature, 8 bytes timestamp
+ */
+struct inv_icm42607_accel_buffer {
+	struct inv_icm42607_fifo_sensor_data accel;
+	s16 temp;
+	aligned_s64 timestamp;
+};
+
+#define INV_ICM42607_SCAN_MASK_ACCEL_3AXIS				\
+	(BIT(INV_ICM42607_ACCEL_SCAN_X) |				\
+	 BIT(INV_ICM42607_ACCEL_SCAN_Y) |				\
+	 BIT(INV_ICM42607_ACCEL_SCAN_Z))
+
+#define INV_ICM42607_SCAN_MASK_TEMP	BIT(INV_ICM42607_ACCEL_SCAN_TEMP)
+
+static const unsigned long inv_icm42607_accel_scan_masks[] = {
+	/* 3-axis accel + temperature */
+	INV_ICM42607_SCAN_MASK_ACCEL_3AXIS | INV_ICM42607_SCAN_MASK_TEMP,
+	0,
+};
+
+/* enable accelerometer sensor and FIFO write */
+static int inv_icm42607_accel_update_scan_mode(struct iio_dev *indio_dev,
+					       const unsigned long *scan_mask)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	unsigned int fifo_en = 0;
+	unsigned int sleep_temp = 0;
+	unsigned int sleep_accel = 0;
+	unsigned int sleep;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	if (*scan_mask & INV_ICM42607_SCAN_MASK_TEMP) {
+		/* enable temp sensor */
+		ret = inv_icm42607_set_temp_conf(st, true, &sleep_temp);
+		if (ret)
+			goto out_unlock;
+		fifo_en |= INV_ICM42607_SENSOR_TEMP;
+	}
+
+	if (*scan_mask & INV_ICM42607_SCAN_MASK_ACCEL_3AXIS) {
+		/* enable accel sensor */
+		conf.mode = accel_st->power_mode;
+		conf.filter = accel_st->filter;
+		ret = inv_icm42607_set_accel_conf(st, &conf, &sleep_accel);
+		if (ret)
+			goto out_unlock;
+		fifo_en |= INV_ICM42607_SENSOR_ACCEL;
+	}
+
+	/* update data FIFO write */
+	ret = inv_icm42607_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	/* sleep maximum required time */
+	sleep = max(sleep_accel, sleep_temp);
+	if (sleep)
+		msleep(sleep);
+	return ret;
+}
+
+static int inv_icm42607_accel_read_sensor(struct iio_dev *indio_dev,
+					  struct iio_chan_spec const *chan,
+					  s16 *val)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
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
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
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
+	data = (__be16 *)&st->buffer[0];
+	ret = regmap_bulk_read(st->map, reg, data, sizeof(*data));
+	if (ret)
+		return ret;
+
+	*val = (int16_t)be16_to_cpup(data);
+	if (*val == INV_ICM42607_DATA_INVALID)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+/* IIO format int + nano */
+static const int inv_icm42607_accel_scale[] = {
+	/* +/- 16G => 0.004788403 m/s-2 */
+	[2 * INV_ICM42607_ACCEL_FS_16G] = 0,
+	[2 * INV_ICM42607_ACCEL_FS_16G + 1] = 4788403,
+	/* +/- 8G => 0.002394202 m/s-2 */
+	[2 * INV_ICM42607_ACCEL_FS_8G] = 0,
+	[2 * INV_ICM42607_ACCEL_FS_8G + 1] = 2394202,
+	/* +/- 4G => 0.001197101 m/s-2 */
+	[2 * INV_ICM42607_ACCEL_FS_4G] = 0,
+	[2 * INV_ICM42607_ACCEL_FS_4G + 1] = 1197101,
+	/* +/- 2G => 0.000598550 m/s-2 */
+	[2 * INV_ICM42607_ACCEL_FS_2G] = 0,
+	[2 * INV_ICM42607_ACCEL_FS_2G + 1] = 598550,
+};
+
+static int inv_icm42607_accel_read_scale(struct iio_dev *indio_dev,
+					 int *val, int *val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	unsigned int idx;
+
+	idx = st->conf.accel.fs;
+
+	*val = accel_st->scales[2 * idx];
+	*val2 = accel_st->scales[2 * idx + 1];
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int inv_icm42607_accel_write_scale(struct iio_dev *indio_dev,
+					  int val, int val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < accel_st->scales_len; idx += 2) {
+		if (val == accel_st->scales[idx] &&
+		    val2 == accel_st->scales[idx + 1])
+			break;
+	}
+	if (idx >= accel_st->scales_len)
+		return -EINVAL;
+
+	conf.fs = idx / 2;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
+
+	return ret;
+}
+
+/* IIO format int + micro */
+static const int inv_icm42607_accel_odr[] = {
+	/* 1.5625Hz */
+	1, 562500,
+	/* 3.125Hz */
+	3, 125000,
+	/* 6.25Hz */
+	6, 250000,
+	/* 12.5Hz */
+	12, 500000,
+	/* 25Hz */
+	25, 0,
+	/* 50Hz */
+	50, 0,
+	/* 100Hz */
+	100, 0,
+	/* 200Hz */
+	200, 0,
+	/* 400Hz */
+	400, 0,
+	/* 800Hz */
+	800, 0,
+	/* 1600Hz */
+	1600, 0,
+};
+
+static const int inv_icm42607_accel_odr_conv[] = {
+	INV_ICM42607_ODR_1_5625HZ_LP,
+	INV_ICM42607_ODR_3_125HZ_LP,
+	INV_ICM42607_ODR_6_25HZ_LP,
+	INV_ICM42607_ODR_12_5HZ,
+	INV_ICM42607_ODR_25HZ,
+	INV_ICM42607_ODR_50HZ,
+	INV_ICM42607_ODR_100HZ,
+	INV_ICM42607_ODR_200HZ,
+	INV_ICM42607_ODR_400HZ,
+	INV_ICM42607_ODR_800HZ,
+	INV_ICM42607_ODR_1600HZ,
+};
+
+static int inv_icm42607_accel_read_odr(struct inv_icm42607_state *st,
+				       int *val, int *val2)
+{
+	unsigned int odr;
+	unsigned int i;
+
+	odr = st->conf.accel.odr;
+
+	for (i = 0; i < ARRAY_SIZE(inv_icm42607_accel_odr_conv); ++i) {
+		if (inv_icm42607_accel_odr_conv[i] == odr)
+			break;
+	}
+	if (i >= ARRAY_SIZE(inv_icm42607_accel_odr_conv))
+		return -EINVAL;
+
+	*val = inv_icm42607_accel_odr[2 * i];
+	*val2 = inv_icm42607_accel_odr[2 * i + 1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
+					int val, int val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &accel_st->ts;
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm42607_accel_odr); idx += 2) {
+		if (val == inv_icm42607_accel_odr[idx] &&
+			val2 == inv_icm42607_accel_odr[idx + 1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42607_accel_odr))
+		return -EINVAL;
+
+	conf.odr = inv_icm42607_accel_odr_conv[idx / 2];
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_sensors_timestamp_update_odr(ts, inv_icm42607_odr_to_period(conf.odr),
+					       iio_buffer_enabled(indio_dev));
+	if (ret)
+		return ret;
+
+	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
+	if (ret)
+		return ret;
+
+	inv_icm42607_buffer_update_fifo_period(st);
+	inv_icm42607_buffer_update_watermark(st);
+
+	return ret;
+}
+
+/*
+ * Calibration bias values, IIO range format int + micro.
+ * Not actually supported in the ICM-42607P registers.
+ */
+static int inv_icm42607_accel_write_calibbias(struct inv_icm42607_state *st,
+					      struct iio_chan_spec const *chan,
+					      int val, int val2)
+{
+	/* Not actually supported in the ICM-42607P registers */
+	return -EOPNOTSUPP;
+}
+
+static int inv_icm42607_accel_read_calibbias(struct inv_icm42607_state *st,
+					     struct iio_chan_spec const *chan,
+					     int *val, int *val2)
+{
+	/* Not actually supported in the ICM-42607P registers */
+	return -EOPNOTSUPP;
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
+		return inv_icm42607_temp_read_raw(indio_dev, chan, val, val2, mask);
+	default:
+		return -EINVAL;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm42607_accel_read_sensor(indio_dev, chan, &data);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		*val = data;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return inv_icm42607_accel_read_scale(indio_dev, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42607_accel_read_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_accel_read_calibbias(st, chan, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42607_accel_write_raw(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					int val, int val2, long mask)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm42607_accel_write_scale(indio_dev, val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42607_accel_write_odr(indio_dev, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm42607_accel_write_calibbias(st, chan, val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
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
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42607_accel_hwfifo_set_watermark(struct iio_dev *indio_dev,
+						   unsigned int val)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+
+	guard(mutex)(&st->lock);
+
+	st->fifo.watermark.accel = val;
+	return inv_icm42607_buffer_update_watermark(st);
+}
+
+static int inv_icm42607_accel_hwfifo_flush(struct iio_dev *indio_dev,
+					   unsigned int count)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (count == 0)
+		return 0;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_icm42607_buffer_hwfifo_flush(st, count);
+	if (ret)
+		return ret;
+
+	return st->fifo.nb.accel;
+}
+
+static const struct iio_info inv_icm42607_accel_info = {
+	.read_raw = inv_icm42607_accel_read_raw,
+	.write_raw = inv_icm42607_accel_write_raw,
+	.write_raw_get_fmt = inv_icm42607_accel_write_raw_get_fmt,
+	.debugfs_reg_access = inv_icm42607_debugfs_reg,
+	.update_scan_mode = inv_icm42607_accel_update_scan_mode,
+	.hwfifo_set_watermark = inv_icm42607_accel_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = inv_icm42607_accel_hwfifo_flush,
+};
+
+struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st)
+{
+	struct device *dev = regmap_get_device(st->map);
+	const char *name;
+	struct inv_icm42607_sensor_state *accel_st;
+	struct inv_sensors_timestamp_chip ts_chip;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->name);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*accel_st));
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
+	accel_st = iio_priv(indio_dev);
+
+	accel_st->scales = inv_icm42607_accel_scale;
+	accel_st->scales_len = ARRAY_SIZE(inv_icm42607_accel_scale);
+	accel_st->power_mode = INV_ICM42607_SENSOR_MODE_LOW_POWER;
+	accel_st->filter = INV_ICM42607_FILTER_AVG_16X;
+
+	/*
+	 * clock period is 32kHz (31250ns)
+	 * jitter is +/- 2% (20 per mille)
+	 */
+	ts_chip.clock_period = 31250;
+	ts_chip.jitter = 20;
+	ts_chip.init_period = inv_icm42607_odr_to_period(st->conf.accel.odr);
+	inv_sensors_timestamp_init(&accel_st->ts, &ts_chip);
+
+	iio_device_set_drvdata(indio_dev, st);
+	indio_dev->name = name;
+	indio_dev->info = &inv_icm42607_accel_info;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	indio_dev->channels = inv_icm42607_accel_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm42607_accel_channels);
+	indio_dev->available_scan_masks = inv_icm42607_accel_scan_masks;
+
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
+					  &inv_icm42607_buffer_ops);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* accel events are wakeup capable */
+	ret = devm_device_init_wakeup(&indio_dev->dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return indio_dev;
+}
+
+int inv_icm42607_accel_parse_fifo(struct iio_dev *indio_dev)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &accel_st->ts;
+	ssize_t i, size;
+	unsigned int no;
+	const void *accel, *gyro, *timestamp;
+	const int8_t *temp;
+	unsigned int odr;
+	int64_t ts_val;
+	struct inv_icm42607_accel_buffer buffer = { };
+
+	/* parse all fifo packets */
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
+		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
+				&accel, &gyro, &temp, &timestamp, &odr);
+		/* quit if error or FIFO is empty */
+		if (size <= 0)
+			return size;
+
+		/* skip packet if no accel data or data is invalid */
+		if (accel == NULL || !inv_icm42607_fifo_is_data_valid(accel))
+			continue;
+
+		/* update odr */
+		if (odr & INV_ICM42607_SENSOR_ACCEL) {
+			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
+							st->fifo.nb.total, no);
+		}
+
+		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
+		/* convert 8 bits FIFO temperature in high resolution format */
+		buffer.temp = temp ? (*temp * 64) : 0;
+		ts_val = inv_sensors_timestamp_pop(ts);
+		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
+	}
+
+	return 0;
+}
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
index 4f5f199586fc..b086068e56ce 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
@@ -356,6 +356,7 @@ static int inv_icm42607_buffer_postdisable(struct iio_dev *indio_dev)
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
 	unsigned int sleep_temp = 0;
 	unsigned int sleep_sensor = 0;
 	unsigned int sleep;
@@ -382,6 +383,15 @@ static int inv_icm42607_buffer_postdisable(struct iio_dev *indio_dev)
 	if (ret)
 		goto out_unlock;
 
+	conf.mode = INV_ICM42607_SENSOR_MODE_OFF;
+	ret = inv_icm42607_set_accel_conf(st, &conf, &sleep_sensor);
+	if (ret)
+		goto out_unlock;
+
+	/* if FIFO is off, turn temperature off */
+	if (!st->fifo.on)
+		ret = inv_icm42607_set_temp_conf(st, false, &sleep_temp);
+
 out_unlock:
 	mutex_unlock(&st->lock);
 
@@ -461,9 +471,33 @@ int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
 	return 0;
 }
 
+int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st)
+{
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
+	struct inv_sensors_timestamp *ts;
+	int ret;
+
+	if (st->fifo.nb.total == 0)
+		return 0;
+
+	/* handle accelerometer timestamp and FIFO data parsing */
+	if (st->fifo.nb.accel > 0) {
+		ts = &accel_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_accel,
+						st->timestamp.accel);
+		ret = inv_icm42607_accel_parse_fifo(st->indio_accel);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
 				     unsigned int count)
 {
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
+	struct inv_sensors_timestamp *ts;
 	s64 gyro_ts, accel_ts;
 	int ret;
 
@@ -471,8 +505,21 @@ int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
 	accel_ts = iio_get_time_ns(st->indio_accel);
 
 	ret = inv_icm42607_buffer_fifo_read(st, count);
+	if (ret)
+		return ret;
 
-	return ret;
+	if (st->fifo.nb.total == 0)
+		return 0;
+
+	if (st->fifo.nb.accel > 0) {
+		ts = &accel_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
+		ret = inv_icm42607_accel_parse_fifo(st->indio_accel);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 int inv_icm42607_buffer_init(struct inv_icm42607_state *st)
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
index 64a66c00a861..6d8d7fa7bd13 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
@@ -92,6 +92,8 @@ int inv_icm42607_buffer_update_watermark(struct inv_icm42607_state *st);
 int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
 				  unsigned int max);
 
+int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st);
+
 int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
 				     unsigned int count);
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 735a262dc103..62a1371b0c4a 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -76,6 +76,15 @@ static const struct inv_icm42607_hw inv_icm42607_hw[INV_CHIP_NB] = {
 	},
 };
 
+const struct iio_mount_matrix *
+inv_icm42607_get_mount_matrix(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan)
+{
+	const struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+
+	return &st->orientation;
+}
+
 u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr)
 {
 	static u32 odr_periods[INV_ICM42607_ODR_NB] = {
@@ -164,6 +173,52 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
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
+		val = INV_ICM42607_ACCEL_CONFIG0_FS_SEL(conf->fs) |
+		INV_ICM42607_ACCEL_CONFIG0_ODR(conf->odr);
+		ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->fs = conf->fs;
+		oldconf->odr = conf->odr;
+	}
+
+	if (conf->filter != oldconf->filter) {
+		if (conf->mode == INV_ICM42607_SENSOR_MODE_LOW_POWER) {
+			val = INV_ICM42607_ACCEL_CONFIG1_AVG(conf->filter);
+			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
+						 INV_ICM42607_ACCEL_CONFIG1_AVG_MASK, val);
+		} else {
+			val = INV_ICM42607_ACCEL_CONFIG1_FILTER(conf->filter);
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
@@ -396,6 +451,11 @@ int inv_icm42607_core_probe(struct regmap *regmap, int chip,
 	if (ret)
 		return ret;
 
+	/* Initialize IIO device for Accel */
+	st->indio_accel = inv_icm42607_accel_init(st);
+	if (IS_ERR(st->indio_accel))
+		return PTR_ERR(st->indio_accel);
+
 	/* Setup runtime power management */
 	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret)
-- 
2.43.0

