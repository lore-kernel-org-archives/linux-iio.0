Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303E4756CB
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279496; cv=none; b=eK4uGDuizNnFnB+alPsYJggkNieG6iCoVY+0rtvFxs5iLGF2gC1rEWsUoBNTKEVyAjR1Nc4w7r8XruzCVRLkqCOMrQ9AhW0hx+/2qBmzEx2xn1NhEtw362RacwF2wGHTPCCGwocuZkMK0NlTWu1/vM2j9X9jj9Bf+R4kkuaXerg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279496; c=relaxed/simple;
	bh=D6sJHlEYiwJlYgjs8rVMwlNjixgsqo8hneitLOi2kwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDl6+uTF2muYCalwmeqvKw4euDApLgPggSxggQVCp+pyydy9+NaAo+ye8ko/at0DIG53UA4NrNcuMngyKJ15NQctpgDZNAHFHiqHM2sLaM6KOXN4Ot+hHb8zVIh1I4Aq4gHbhUTvQxcReijC02YFa1KZ1bGzcVbcmLvI1IDua58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKBcg8pE; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKBcg8pE"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4563ac048f4so199096fac.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 15:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785279493; x=1785884293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=50F5mRgpqPvmKKjCLRrhJ9L7gJbpklm0K6az4nkvCb8=;
        b=TKBcg8pE2nBFxKT0GjnOmftJsTOpkKohKgn5x86zJFEue6nYzFZ276nj37vnamx7fI
         OQdBrU03W1itnimDznSwPM4Nrcxy9820z5bPKRfVi0WouPdA5aGLpyzkFYaCqSkEJrFG
         6CtTmr9OzIXNlAc2GlyouC1qQb34O/08+xlkL32NKGxgdjJ/3c7UL4KHdlUM9h32reuG
         Q/wB8CKiYyuA0uNwfuUlLuQT0rP8VTe/+/satVB7ouGXNMLzSmd9z7GBT4rCeYulV7bs
         UlyjVMdeuR/obGmKWRrdscsvxTqhTIUKYnk6BmVXQp9Rs0j9qqE2dVadIY8BXygXeVUY
         qOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279493; x=1785884293;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=50F5mRgpqPvmKKjCLRrhJ9L7gJbpklm0K6az4nkvCb8=;
        b=BoTd7M/ZGESlGpUHMvjbKJsysnNZj2Hj5bylrOfgrGJw1fzR0Gy4lYxvSNOivfMOsV
         jxbMJXiCe8ZfI1rSmYz7yaZQ85NI8wYOe3N/YV+LxdNsxt4WydsZpFU4s3rbX+JQaqLY
         Yd6FssmRPDO74JiN8gwarjH/PkN+QjvhisztEyNeaQKED07g9iVKtX7dOGrn3dw+XScg
         /lZG/FFeavXDK249PibX/irk9o7sHeDCSysZJ7IaN7CApXeXW9hPv2N93cyb/VtqZvAI
         vOJLPSv8OsGQzfxklQE325IgsPTK5omPn/y4jRmkpKCO/B6MTw6iBGeucN285Jk2Brmf
         bQUg==
X-Gm-Message-State: AOJu0YxaZjClVayfLjKkSQ+WN2aIR9VFrNqytP8Y2jvg+VZfehsB1eGv
	kkDm3dDXdkRTp8jySv3ny/Vaivgq6NKaaMkHB4jmHaX5aodjsIe+fXeFmO7Obw==
X-Gm-Gg: AR+sD11BtXnTvbLbXqcXz+l1y/8S8M6gg8sW27JV56Q1HX6AJtAq/F9sfhHIX3kRzCe
	HbqJ+2ZfEyApOEyvM35nY6T5GYiHEiFx3spMNrI+ayC+ZYkZCj9J8Gd9tKC8FHpl4GbtccyQuke
	7gLD7wv3HVwNQdUjg4PXrj+53Gc/Nh+I9EMaP2LC24V/xMUUy6cRR913DpGf1XA2bCMUGt08zyr
	3OvJTXpUiqfSyMRql3XDPtzzTlxUOmHjawJoCpSrIjq9A9QI8MDPeR0DTqIdFIqY9+JTL/VOqt3
	BmWBpHIg3h+jjKUQSNCSZz9eNKGeJH1v9tDgNNmDQuOQtW6SsIANzFz3RezfP//PCGYHij54bp1
	hXVIy674BGhdwz4PgqbzO7yyzaH0qp9byMKxQ+QAhpDZQRe9FzZJ6JpqxJQRG+aQybT+p46G0Ra
	7MUtY/lraS93dvpimX+2v9aWo337baMeH1TRk3OKx/L6OQlDKxSjIb4Lww3MHLLVWjcCZ6u2kju
	7Zbx4Bt
X-Received: by 2002:a05:6870:f107:b0:456:4c93:a7f8 with SMTP id 586e51a60fabf-4586cc3051cmr2315297fac.6.1785279492907;
        Tue, 28 Jul 2026 15:58:12 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9162:e42b:cb94:2d55])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4588646ade0sm990277fac.5.2026.07.28.15.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:58:12 -0700 (PDT)
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
Subject: [PATCH V21 8/9] iio: imu: inv_icm42607: Add Temp Support in icm42607
Date: Tue, 28 Jul 2026 17:55:39 -0500
Message-ID: <20260728225542.174825-9-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728225542.174825-1-macroalpha82@gmail.com>
References: <20260728225542.174825-1-macroalpha82@gmail.com>
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
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 99 +++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 38 +++++++
 5 files changed, 154 insertions(+)
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
index f563c7708420..0b3f035c2da0 100644
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
@@ -187,6 +190,11 @@ static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
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
index b68d4d6f5c3f..5b4683c2dd1e 100644
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
@@ -184,6 +187,11 @@ static int inv_icm42607_gyro_read_raw(struct iio_dev *indio_dev,
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
index 000000000000..53f0484c0845
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/bitfield.h>
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

