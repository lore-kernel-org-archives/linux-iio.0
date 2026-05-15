Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF892868A7
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850174; cv=none; b=HB7JmxFXvRiZ0X6bei/I4WtI2+Pcn6OhD9C+bdpOagTpqo9QhvfsIJL7jNB0aRR0u1ah0Lf/jXGmMOc1pCZ9XjlzoIQNje7wnNdkxwH4x2picLYTE2yFdRiUh8tJilPgveUk0WieAfuvefF8wlViX0KpdrQJLsQRm+qUyRZhfv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850174; c=relaxed/simple;
	bh=EeA/vUh7C0/+ELGMkbZBkzC0BMRLq69Lsjmi+1BRq3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osYWzKR+qUvQXqkDvLu/ZHdlUou47F41UVsilWtv4mOsPKHzZEpvxUzhSYqRN24KQoPsBChXi06H5GKkDPjRXo86b4L66r1C8eZiohpVdlFx7PYON9qir1f/Z6y4UBFFxqsGWFIbIi0PAcrhQtJj8VGp4MU6QHxummi6ztFtpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esSAe0Eo; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esSAe0Eo"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4042fe53946so3658705fac.3
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 06:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778850171; x=1779454971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSwQMKp6cTbd724odlq54Y6BC05CIQdahw26cMleTdw=;
        b=esSAe0EohzJYjjsrkWuYX1aqGh2yLWTuNVcWUVi10Dv0JFX2FQejElC/eQ5JF23BKv
         Hq/5xeXIF+o/yZQEojby4BP99nAOFmtQ79bvhFh2rDyZ+6nr5/uU2eEQ+8TyjkFx36gY
         Mm/7RRZXtEqVuNmKFWA+KoMyciaLJRpx8gDX9x5X9ec/6wXRzn1uz4g4HFRFxgVNkDyw
         LstS/nFU16YwYndsRarMx0812Mg/WLTJw9Tpfzunse8V6Fju8T5nqSgLVG9o9HFE0Gn4
         89dGnDyw0Jbx9GC2WXPA5uUXYo+VrYu+470AMwlRLwoCiKwj2ud9A2Da1zlr1Cnilr2u
         UsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850171; x=1779454971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eSwQMKp6cTbd724odlq54Y6BC05CIQdahw26cMleTdw=;
        b=K+sEGb0f/fOoAO/sn2iknwHS0zShnT67yku3mn+YIHXSaO6VPkG8vloLOxsQZtoOmo
         4w7a6EAzI1Xlni/XEdRWC12khYzsFry6+tSHBOjVAF03ywRl+R8TIOBD1jAdQ0wOfslu
         aZsvxSIuFknFqCfkZekdqGjryea547yNqupLdfQrn9bnZRySfy0D9AecK64C6lQxKtuj
         mlSwIC7k0taciOYTuahuDw01oyjoHfgs4E7Xs+Cls8FvLJRr3zCSHaSBO5mRd5UQG7CG
         MdDwMWqfucAjaYe2IROp1fQYjiEt6YDmdpXMBhCS3x++wymAmGwJ8zHFtOwbAqYiQ7m4
         YeHg==
X-Gm-Message-State: AOJu0YyotX2Zb4MBdrqALnT/9h0QXTKveajNqP9EJWJr5I6qJH+CZb7E
	UrWO6J3edQ/J4Fu1oqWOAhVLwgNtn41a2dBYZSo5xv25MCrMay6cv5dbyu3Ekb8U
X-Gm-Gg: Acq92OGfhnZWb0HoycAwG8jlhKo0Wm/0DldDQZK4iEdGVy7Y9ikeZ4/ShRjsUkA2VsA
	YSMshe828AEX3TPXSdhQxcRXBZaXyDD5kgPU598n6vp1L+p6NWAMJl/hOYiFbxBOHJaWB2f6OJu
	1uCeylCrDIYskJAQZiluOXsOCo8Jv7PTQ33IctLWN/JsRF4+wXbbPDWImL1ggV8Bz8QkzDvogyJ
	jVIwt8DgIEYb0koQOs3NsR/bPJRHC3GZnSP6TUge8+l+6KOBiEJKp5SDF3KNDYif/HP1A/qO3EZ
	gXLiZDekEf1xdJDaCUXFLQSgwuBN77xCJPvXsH7p17Z038LJzWBexPoNe9EFc/HCFgQIWnPddGq
	ldJRanZhbLMKOpW47oPhZTIEENgc6zDvjEumN3sDQhjEV5pCYKmDVZP+tgFnfMso5bMZyYLclc1
	seUWtGQelaM7MaThm3i6A3Sx+3+kgYErwfQLMBFAS8f04isUmPzDA8
X-Received: by 2002:a05:6870:c248:b0:42f:ba47:36f5 with SMTP id 586e51a60fabf-43a2dd1ce28mr2345144fac.17.1778850170536;
        Fri, 15 May 2026 06:02:50 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:8c2e:6a8e:445a:9169])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc53f2acsm4155822fac.14.2026.05.15.06.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:02:50 -0700 (PDT)
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
Subject: [PATCH V7 10/11] iio: imu: inv_icm42607: Add Gyroscope to icm42607
Date: Fri, 15 May 2026 08:00:15 -0500
Message-ID: <20260515130018.237378-11-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515130018.237378-1-macroalpha82@gmail.com>
References: <20260515130018.237378-1-macroalpha82@gmail.com>
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |   9 +
 .../imu/inv_icm42607/inv_icm42607_buffer.c    |  26 +-
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  |  56 +-
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 545 ++++++++++++++++++
 5 files changed, 633 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c

diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index e908d77c4219..fc66e580fe99 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
 inv-icm42607-y += inv_icm42607_core.o
+inv-icm42607-y += inv_icm42607_gyro.o
 inv-icm42607-y += inv_icm42607_accel.o
 inv-icm42607-y += inv_icm42607_buffer.o
 inv-icm42607-y += inv_icm42607_temp.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 16f7929d3d0e..158a0385f0b9 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -158,6 +158,7 @@ struct inv_icm42607_state {
 	struct iio_dev *indio_gyro;
 	struct iio_dev *indio_accel;
 	struct {
+		s64 gyro;
 		s64 accel;
 	} timestamp;
 	struct inv_icm42607_apex apex;
@@ -428,6 +429,10 @@ int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
 				struct inv_icm42607_sensor_conf *conf,
 				unsigned int *sleep_ms);
 
+int inv_icm42607_set_gyro_conf(struct inv_icm42607_state *st,
+			       struct inv_icm42607_sensor_conf *conf,
+			       unsigned int *sleep_ms);
+
 int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
 			       unsigned int *sleep_ms);
 
@@ -437,6 +442,10 @@ int inv_icm42607_disable_wom(struct inv_icm42607_state *st);
 int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
 
+struct iio_dev *inv_icm42607_gyro_init(struct inv_icm42607_state *st);
+
+int inv_icm42607_gyro_parse_fifo(struct iio_dev *indio_dev);
+
 struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st);
 
 int inv_icm42607_accel_parse_fifo(struct iio_dev *indio_dev);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
index 4371f428cc3f..771120fa8ebf 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
@@ -384,7 +384,9 @@ static int inv_icm42607_buffer_postdisable(struct iio_dev *indio_dev)
 		goto out_unlock;
 
 	conf.mode = INV_ICM42607_SENSOR_MODE_OFF;
-	if (sensor != INV_ICM42607_SENSOR_GYRO)
+	if (sensor == INV_ICM42607_SENSOR_GYRO)
+		ret = inv_icm42607_set_gyro_conf(st, &conf, &sleep_sensor);
+	else
 		ret = inv_icm42607_set_accel_conf(st, &conf, &sleep_sensor);
 	if (ret)
 		goto out_unlock;
@@ -476,6 +478,7 @@ int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
 
 int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st)
 {
+	struct inv_icm42607_sensor_state *gyro_st = iio_priv(st->indio_gyro);
 	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct inv_sensors_timestamp *ts;
 	int ret;
@@ -483,6 +486,16 @@ int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st)
 	if (st->fifo.nb.total == 0)
 		return 0;
 
+	/* handle gyroscope timestamp and FIFO data parsing */
+	if (st->fifo.nb.gyro > 0) {
+		ts = &gyro_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_gyro,
+						st->timestamp.gyro);
+		ret = inv_icm42607_gyro_parse_fifo(st->indio_gyro);
+		if (ret)
+			return ret;
+	}
+
 	/* handle accelerometer timestamp and FIFO data parsing */
 	if (st->fifo.nb.accel > 0) {
 		ts = &accel_st->ts;
@@ -499,9 +512,10 @@ int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st)
 int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
 				     unsigned int count)
 {
+	struct inv_icm42607_sensor_state *gyro_st = iio_priv(st->indio_gyro);
 	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct inv_sensors_timestamp *ts;
-	s64 accel_ts;
+	s64 gyro_ts, accel_ts;
 	int ret;
 
 	accel_ts = iio_get_time_ns(st->indio_accel);
@@ -513,6 +527,14 @@ int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
 	if (st->fifo.nb.total == 0)
 		return 0;
 
+	if (st->fifo.nb.gyro > 0) {
+		ts = &gyro_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
+		ret = inv_icm42607_gyro_parse_fifo(st->indio_gyro);
+		if (ret)
+			return ret;
+	}
+
 	if (st->fifo.nb.accel > 0) {
 		ts = &accel_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 8ab8b5f739f2..9a0e1e106b38 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -272,6 +272,49 @@ int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
 					  st->conf.temp_en, sleep_ms);
 }
 
+int inv_icm42607_set_gyro_conf(struct inv_icm42607_state *st,
+			       struct inv_icm42607_sensor_conf *conf,
+			       unsigned int *sleep_ms)
+{
+	struct inv_icm42607_sensor_conf *oldconf = &st->conf.gyro;
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
+		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK,
+				 conf->fs);
+		val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK,
+				  conf->odr);
+		ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->fs = conf->fs;
+		oldconf->odr = conf->odr;
+	}
+
+	if (conf->filter != oldconf->filter) {
+		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK,
+				 conf->filter);
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_GYRO_CONFIG1,
+					 INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, val);
+		if (ret)
+			return ret;
+		oldconf->filter = conf->filter;
+	}
+
+	return inv_icm42607_set_pwr_mgmt0(st, conf->mode, st->conf.accel.mode,
+					  st->conf.temp_en, sleep_ms);
+}
+
 int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
 			       unsigned int *sleep_ms)
 {
@@ -448,6 +491,7 @@ static irqreturn_t inv_icm42607_irq_timestamp(int irq, void *_data)
 {
 	struct inv_icm42607_state *st = _data;
 
+	st->timestamp.gyro = iio_get_time_ns(st->indio_gyro);
 	st->timestamp.accel = iio_get_time_ns(st->indio_accel);
 
 	return IRQ_WAKE_THREAD;
@@ -656,6 +700,11 @@ int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw
 	if (IS_ERR(st->indio_accel))
 		return PTR_ERR(st->indio_accel);
 
+	/* Initialize IIO device for Gyro */
+	st->indio_gyro = inv_icm42607_gyro_init(st);
+	if (IS_ERR(st->indio_gyro))
+		return PTR_ERR(st->indio_gyro);
+
 	/* Initialize interrupt handling */
 	ret = inv_icm42607_irq_init(st, irq, irq_type, open_drain);
 	if (ret)
@@ -675,6 +724,7 @@ static int inv_icm42607_suspend(struct device *dev)
 
 	guard(mutex)(&st->lock);
 
+	st->suspended.gyro = st->conf.gyro.mode;
 	st->suspended.accel = st->conf.accel.mode;
 	st->suspended.temp = st->conf.temp_en;
 	if (pm_runtime_suspended(dev))
@@ -724,6 +774,7 @@ static int inv_icm42607_suspend(struct device *dev)
 static int inv_icm42607_resume(struct device *dev)
 {
 	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	struct inv_icm42607_sensor_state *gyro_st = iio_priv(st->indio_gyro);
 	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct device *accel_dev;
 	bool wakeup;
@@ -747,8 +798,8 @@ static int inv_icm42607_resume(struct device *dev)
 			return ret;
 	}
 
-	/* restore sensors state, noting gyro still not yet supported.  */
-	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
+	/* restore sensors state */
+	ret = inv_icm42607_set_pwr_mgmt0(st, st->suspended.gyro,
 					 st->suspended.accel,
 					 st->suspended.temp, NULL);
 	if (ret)
@@ -762,6 +813,7 @@ static int inv_icm42607_resume(struct device *dev)
 	}
 
 	if (st->fifo.on) {
+		inv_sensors_timestamp_reset(&gyro_st->ts);
 		inv_sensors_timestamp_reset(&accel_st->ts);
 		ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
 				   INV_ICM42607_FIFO_CONFIG1_MODE);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
new file mode 100644
index 000000000000..5a5fd13ba64e
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/math64.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include "inv_icm42607.h"
+#include "inv_icm42607_temp.h"
+#include "inv_icm42607_buffer.h"
+
+#define INV_ICM42607_GYRO_CHAN(_modifier, _index, _ext_info)	\
+{								\
+	.type = IIO_ANGL_VEL,					\
+	.modified = 1,						\
+	.channel2 = _modifier,					\
+	.info_mask_separate =					\
+		BIT(IIO_CHAN_INFO_RAW),				\
+	.info_mask_shared_by_type =				\
+		BIT(IIO_CHAN_INFO_SCALE),			\
+	.info_mask_shared_by_all =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.scan_index = _index,					\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_BE,				\
+	},							\
+	.ext_info = _ext_info,					\
+}
+
+enum inv_icm42607_gyro_scan {
+	INV_ICM42607_GYRO_SCAN_X,
+	INV_ICM42607_GYRO_SCAN_Y,
+	INV_ICM42607_GYRO_SCAN_Z,
+	INV_ICM42607_GYRO_SCAN_TEMP,
+	INV_ICM42607_GYRO_SCAN_TIMESTAMP,
+};
+
+static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
+	{ },
+};
+
+static const struct iio_chan_spec inv_icm42607_gyro_channels[] = {
+	INV_ICM42607_GYRO_CHAN(IIO_MOD_X, INV_ICM42607_GYRO_SCAN_X,
+			       inv_icm42607_gyro_ext_infos),
+	INV_ICM42607_GYRO_CHAN(IIO_MOD_Y, INV_ICM42607_GYRO_SCAN_Y,
+			       inv_icm42607_gyro_ext_infos),
+	INV_ICM42607_GYRO_CHAN(IIO_MOD_Z, INV_ICM42607_GYRO_SCAN_Z,
+			       inv_icm42607_gyro_ext_infos),
+	INV_ICM42607_TEMP_CHAN(INV_ICM42607_GYRO_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42607_GYRO_SCAN_TIMESTAMP),
+};
+
+/*
+ * IIO buffer data: size must be a power of 2 and timestamp aligned
+ * 16 bytes: 6 bytes angular velocity, 2 bytes temperature, 8 bytes timestamp
+ */
+struct inv_icm42607_gyro_buffer {
+	struct inv_icm42607_fifo_sensor_data gyro;
+	s16 temp;
+	aligned_s64 timestamp;
+};
+
+#define INV_ICM42607_SCAN_MASK_GYRO_3AXIS				\
+	(BIT(INV_ICM42607_GYRO_SCAN_X) |				\
+	 BIT(INV_ICM42607_GYRO_SCAN_Y) |				\
+	 BIT(INV_ICM42607_GYRO_SCAN_Z))
+
+#define INV_ICM42607_SCAN_MASK_TEMP	BIT(INV_ICM42607_GYRO_SCAN_TEMP)
+
+static const unsigned long inv_icm42607_gyro_scan_masks[] = {
+	INV_ICM42607_SCAN_MASK_GYRO_3AXIS,
+	INV_ICM42607_SCAN_MASK_TEMP,
+	INV_ICM42607_SCAN_MASK_GYRO_3AXIS | INV_ICM42607_SCAN_MASK_TEMP,
+	0
+};
+
+/* enable gyroscope sensor and FIFO write */
+static int inv_icm42607_gyro_update_scan_mode(struct iio_dev *indio_dev,
+					      const unsigned long *scan_mask)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	unsigned int fifo_en = 0;
+	unsigned int sleep_gyro = 0;
+	unsigned int sleep_temp = 0;
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
+	if (*scan_mask & INV_ICM42607_SCAN_MASK_GYRO_3AXIS) {
+		/* enable gyro sensor */
+		conf.mode = INV_ICM42607_SENSOR_MODE_LOW_NOISE;
+		ret = inv_icm42607_set_gyro_conf(st, &conf, &sleep_gyro);
+		if (ret)
+			goto out_unlock;
+		fifo_en |= INV_ICM42607_SENSOR_GYRO;
+	}
+
+	/* update data FIFO write */
+	ret = inv_icm42607_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	/* sleep maximum required time */
+	msleep(max(sleep_gyro, sleep_temp));
+	return ret;
+}
+
+static int inv_icm42607_gyro_read_sensor(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan,
+					 s16 *val)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	unsigned int reg;
+	__be16 *data;
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM42607_REG_GYRO_DATA_X1;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM42607_REG_GYRO_DATA_Y1;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM42607_REG_GYRO_DATA_Z1;
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
+	/* enable gyro sensor */
+	conf.mode = gyro_st->power_mode;
+	ret = inv_icm42607_set_gyro_conf(st, &conf, NULL);
+	if (ret)
+		return ret;
+
+	/* read gyro register data */
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
+
+	for (idx = 0; idx < scales_len; idx++) {
+		if (val == inv_icm42607_gyro_scale_nano[idx][0] &&
+		    val2 == inv_icm42607_gyro_scale_nano[idx][1])
+			break;
+	}
+	if (idx >= scales_len)
+		return -EINVAL;
+
+	conf.fs = idx;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	guard(mutex)(&st->lock);
+
+	return inv_icm42607_set_gyro_conf(st, &conf, NULL);
+}
+
+static const int inv_icm42607_gyro_odr[][2] = {
+	[INV_ICM42607_ODR_12_5HZ] = { 12, 500000 },
+	[INV_ICM42607_ODR_25HZ] = { 25, 0 },
+	[INV_ICM42607_ODR_50HZ] = { 50, 0 },
+	[INV_ICM42607_ODR_100HZ] = { 100, 0 },
+	[INV_ICM42607_ODR_200HZ] = { 200, 0 },
+	[INV_ICM42607_ODR_400HZ] = { 400, 0 },
+	[INV_ICM42607_ODR_800HZ] = { 800, 0 },
+	[INV_ICM42607_ODR_1600HZ] = { 1600, 0 },
+};
+
+static int inv_icm42607_gyro_read_odr(struct inv_icm42607_state *st,
+				      int *val, int *val2)
+{
+	unsigned int odr;
+	unsigned int i;
+
+	odr = st->conf.gyro.odr;
+
+	for (i = 5; i < ARRAY_SIZE(inv_icm42607_gyro_odr); ++i) {
+		if (i == odr)
+			break;
+	}
+	if (i >= ARRAY_SIZE(inv_icm42607_gyro_odr))
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
+	struct inv_icm42607_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &gyro_st->ts;
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 5; idx < ARRAY_SIZE(inv_icm42607_gyro_odr); ++idx) {
+		if (val == inv_icm42607_gyro_odr[idx][0] &&
+		    val2 == inv_icm42607_gyro_odr[idx][1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42607_gyro_odr))
+		return -EINVAL;
+
+	conf.odr = idx;
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
+	ret = inv_icm42607_set_gyro_conf(st, &conf, NULL);
+	if (ret)
+		return ret;
+	inv_icm42607_buffer_update_fifo_period(st);
+	inv_icm42607_buffer_update_watermark(st);
+
+	return 0;
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
+		ret = inv_icm42607_gyro_read_sensor(indio_dev, chan, &data);
+		iio_device_release_direct(indio_dev);
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
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)inv_icm42607_gyro_scale_nano;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(inv_icm42607_gyro_scale_nano) * 2;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)inv_icm42607_gyro_odr;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(inv_icm42607_gyro_odr) * 2;
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
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm42607_gyro_write_scale(indio_dev, val, val2);
+		iio_device_release_direct(indio_dev);
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
+	if (chan->type != IIO_ANGL_VEL)
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
+static int inv_icm42607_gyro_hwfifo_set_watermark(struct iio_dev *indio_dev,
+						  unsigned int val)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+
+	guard(mutex)(&st->lock);
+
+	st->fifo.watermark.gyro = val;
+	return inv_icm42607_buffer_update_watermark(st);
+}
+
+static int inv_icm42607_gyro_hwfifo_flush(struct iio_dev *indio_dev,
+					  unsigned int count)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	int ret;
+
+	if (count == 0)
+		return 0;
+
+	/* Make sure we don't try to count more than the buffer can hold. */
+	count = min(count, sizeof(st->fifo.data));
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	ret = inv_icm42607_buffer_hwfifo_flush(st, count);
+	if (ret)
+		return ret;
+
+	return st->fifo.nb.gyro;
+}
+
+static const struct iio_info inv_icm42607_gyro_info = {
+	.read_raw = inv_icm42607_gyro_read_raw,
+	.read_avail = inv_icm42607_gyro_read_avail,
+	.write_raw = inv_icm42607_gyro_write_raw,
+	.write_raw_get_fmt = inv_icm42607_gyro_write_raw_get_fmt,
+	.update_scan_mode = inv_icm42607_gyro_update_scan_mode,
+	.hwfifo_set_watermark = inv_icm42607_gyro_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = inv_icm42607_gyro_hwfifo_flush,
+};
+
+struct iio_dev *inv_icm42607_gyro_init(struct inv_icm42607_state *st)
+{
+	struct device *dev = regmap_get_device(st->map);
+	const char *name;
+	struct inv_icm42607_sensor_state *gyro_st;
+	struct inv_sensors_timestamp_chip ts_chip;
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
+	gyro_st = iio_priv(indio_dev);
+
+	gyro_st->power_mode = INV_ICM42607_SENSOR_MODE_LOW_NOISE;
+
+	/*
+	 * clock period is 32kHz (31250ns)
+	 * jitter is +/- 2% (20 per mille)
+	 */
+	ts_chip.clock_period = 31250;
+	ts_chip.jitter = 20;
+	ts_chip.init_period = inv_icm42607_odr_to_period(st->conf.gyro.odr);
+	inv_sensors_timestamp_init(&gyro_st->ts, &ts_chip);
+
+	iio_device_set_drvdata(indio_dev, st);
+	indio_dev->name = name;
+	indio_dev->info = &inv_icm42607_gyro_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = inv_icm42607_gyro_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm42607_gyro_channels);
+	indio_dev->available_scan_masks = inv_icm42607_gyro_scan_masks;
+	indio_dev->setup_ops = &inv_icm42607_buffer_ops;
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
+	return indio_dev;
+}
+
+int inv_icm42607_gyro_parse_fifo(struct iio_dev *indio_dev)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &gyro_st->ts;
+	ssize_t i, size;
+	unsigned int no;
+	const void *accel, *gyro, *timestamp;
+	const s8 *temp;
+	unsigned int odr;
+	s64 ts_val;
+	struct inv_icm42607_gyro_buffer buffer = { };
+
+	/* parse all fifo packets */
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
+		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
+				&accel, &gyro, &temp, &timestamp, &odr);
+		/* quit if error or FIFO is empty */
+		if (size <= 0)
+			return size;
+
+		/* If the packet size could cause us to overflow, return. */
+		if (i + size <= st->fifo.count)
+			return -EIO;
+
+		/* skip packet if no gyro data or data is invalid */
+		if (gyro == NULL || !inv_icm42607_fifo_is_data_valid(gyro))
+			continue;
+
+		/* update odr */
+		if (odr & INV_ICM42607_SENSOR_GYRO)
+			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
+							st->fifo.nb.total, no);
+
+		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
+		/* convert 8 bits FIFO temperature in high resolution format */
+		buffer.temp = temp ? (*temp * 64) : 0;
+		ts_val = inv_sensors_timestamp_pop(ts);
+		iio_push_to_buffers_with_ts(indio_dev, &buffer,
+					    sizeof(buffer), ts_val);
+	}
+
+	return 0;
+}
-- 
2.43.0

