Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FB391513
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226551; cv=none; b=bjPtxJxEKk39TFDmcNsowu12qHP4vTf4uAZI7cVaRs7qSiLdVHAhDMFW0JvQy+s2QCubUDWMR+lWDuEFBusjqaOOgJiN97cyLxSOd9HWz+jzFSUBZ+79vI8nMypaxQETvrhfV1xXV4OzL1JU7Jw9ejqFiGfz1jWnR31CD3gr1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226551; c=relaxed/simple;
	bh=60QGKCey5R7RKbPdvKzDdEDSIA6Wxcr+O3VHAXD6zoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbGU60vNazOwZc3ktid1GYoVWBWFjZ661MYeLaTZ36ljGh4SWFayqli2dz1ciHz741CGWFqClFPvU9lNGqYXYvJkGlwXBOcTTOgUhLvnfZI5DsGJ31oAqqIdOG3V+teAtQ4X9S35iNX0vY0MOt35qJj33O91HQKuY90/+dr0tJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z35UVc/h; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z35UVc/h"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb34c17b96so4468233a34.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784226548; x=1784831348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=huK+4iSPdfkgl67lIGlfvxQ4rc8RHlrj3WAmWFb8XCw=;
        b=Z35UVc/hDu8Qe5E3L8Mqgh1sFaoLRhmvVFY1jV4vaWO46+/HZp4wDOjS4g2POcH782
         qgvz9DMW2WFhGnvDtyBnfr4ADaxLrgBATZEhgYTufLBMJODVuuP2hX3lDEoonzTZnGYH
         LN6lPF1RaGzVetzISshzFodrvcNoxJ3T8FQ1AK6KunPlk8EjLKk6XK7wDoTRn1hBCF3A
         4jH3Qm5Y9u5GjsFIMzlHhvnz3KIHVVtahkmhHH3oT/Rtx+HhAvX9VhWTgZFvxDG1SLmo
         Sg6SsFSqXhHVJQN7QvpdvRjwwB7XZHn9wvHBTU9C9egdcXBOYiBdjQo0FsdkyWGg6/VC
         5njA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226548; x=1784831348;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=huK+4iSPdfkgl67lIGlfvxQ4rc8RHlrj3WAmWFb8XCw=;
        b=fyOWtMsKo3MtjaOM4+r8QvZiHBJ5VL5oDC3N1q/VwiKN9/6FgrnM3+Vee7hRgO5uhY
         kE5tMEX2pE1i6/nB83CvsWBSmNDCThNTyLyeWaKQxqm7bF3o8EwGNs5DXx1QIGLikzQH
         2GkCc5p14kaln3zPNyjgiX1s55Lh//l97kg3QKj9tDLdKcNKqtP+YpKNMT7DVWJ4ejmQ
         AE25bTUg6DN4rqFHNdnTX+NfK+z6vRZs+s/wPXN+D+0TalCxnxgkLiWpcjvlrYQrazs4
         3EK9GW5jpmUlAnlKvB3pLjGEKV9+wPm6c8se5QHMBPRP8mOrLzQwnzODRyy4WOqzRWXy
         2/iw==
X-Gm-Message-State: AOJu0YzGO0bfMD3YEBckn+fhuX6B3LKd8FuTCRvBaT7JlpH5R7oLdlAF
	qdfnN6lvuTwKsrKGCsB9fvnFWXPnZYVLOAz75OuH1GG+K13QHxvXDil42gCaow==
X-Gm-Gg: AfdE7clAE6jW1NRrYjK8o7LXJPx3CI+ROijxCWxF9/jLvSGTArRsy1C7JsdKv5TCOqD
	hFL2uKABTj1DpOgy7CRPSGl5dWQUmUy2xqCwx/9TvKI6jyp9Rys4G2UQtDtxAC9/uOIBhM2nkyu
	rFqMFxKMKOOq8eeoxkwZIpilqDYOxS158fJe7pzU9hXe5H4LVulA9a2AH2iPosnqKRZBgY55yB+
	xWmr+WfqVtrQ4D7yeNrafxfwUpiCPFA4w1KV/aNC6JnZwHLDgtmVKQoMAZW2VGu6syIMK7CoHHx
	1YUf+jgtvqVCVdBMPXkTSKgabR/6GCofGNeWrrCXUxs9F+/3/9Z/g6sH1KcdGPSusyhN8Va2gIj
	whmLmeJVRiLsDlbjzsW4qFYY65FwWvzq1nR7luSik5fa3baKMSKdSQwkm0UGKEAIRbW19x1seFl
	vj
X-Received: by 2002:a05:6830:4423:b0:7e6:f482:df36 with SMTP id 46e09a7af769-7ec59d4092bmr5510593a34.15.1784226548173;
        Thu, 16 Jul 2026 11:29:08 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f6826sm19939993a34.27.2026.07.16.11.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 11:29:07 -0700 (PDT)
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
Subject: [PATCH V17 8/9] iio: imu: inv_icm42607: Add Temp Support in icm42607
Date: Thu, 16 Jul 2026 13:26:35 -0500
Message-ID: <20260716182637.24310-9-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716182637.24310-1-macroalpha82@gmail.com>
References: <20260716182637.24310-1-macroalpha82@gmail.com>
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
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c |  6 ++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  |  6 ++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 98 +++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 38 +++++++
 5 files changed, 149 insertions(+)
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
index 7bb67f232d19..9a44a180e5cc 100644
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
@@ -186,6 +189,9 @@ static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_TEMP)
+			return inv_icm42607_temp_read_raw(indio_dev, chan,
+							  val, val2, mask);
 		ret = inv_icm42607_read_sensor(indio_dev, chan, &data);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
index 923d47d096bd..fa6e65c7ab6b 100644
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
@@ -183,6 +186,9 @@ static int inv_icm42607_gyro_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_TEMP)
+			return inv_icm42607_temp_read_raw(indio_dev, chan,
+							  val, val2, mask);
 		ret = inv_icm42607_read_sensor(indio_dev, chan, &data);
 		if (ret)
 			return ret;
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

