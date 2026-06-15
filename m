Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E78D4183B4
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544496; cv=none; b=uApdDFwQKBODJ0JMhNtgle8remrrJgv96c0UX1ZWchaUbzw9GGFZLtPj/Cq+rZzB8Z6PKa0qXXycqCR7k4wfNtYMsUQ2sDSjPP9gZyUbkE0O4CvuIAUitdxpYrYGQFgelfFoEknSfSeFYgEfUsxq9VP36iltxiP5J3WZlEzh/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544496; c=relaxed/simple;
	bh=O0RhG/I16oRqLYOihv7dBqJX3GkjziLMNtLoXequs2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6E2c3Vip45aWujtaFIbFKtZVR8xoFJ3edzfO99riCK6wXkLAf6ae+w1O9qUHrW0b2ibbSpW/tYKDp/+nrz+2CSjvbdh0mBQ6nqOTQ+USCHBYYswAEjs4dFvTOQn3hKQKDzLiDLnmHIFlXlWebwhWvRG6o6JMBbNeUq4ATzBJQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J46GH8vD; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J46GH8vD"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-48677c167b7so1423417b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781544494; x=1782149294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vsn6yN6THg0V/VqKUqeCd36IReXPK449tYlnmJP6sY=;
        b=J46GH8vDHVPiCg6abN1ULLCW0EvExByhdCvq10daW21Aw0Gh3Y4z0E8v/NMJQNA9ct
         AFfJSq4nsHXgofPDZwuF2wH4wmCXLneiTsnMX6v72SPEQFgDWng/ClHW2jdREN8Q/0bZ
         Dzxf1GE4eL3ZfAnlHUYsIhjDTrnQKgh69DJHTbnUHjv0/amFdXIp8uiayohAHyVaJ7v7
         mKQBNB45EPULcgg5TzRpVoVfPYWG/DwcMvtM32u3G3gSlK79tpbLOy/fJ1HE6d9MMcjf
         zBuFJLoLAVHedm8h6czXPtwv5Clgd1KIDJPuejQVDQNJM1WYo4+JYfpVy+KAR2NWaMJ3
         yjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544494; x=1782149294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4vsn6yN6THg0V/VqKUqeCd36IReXPK449tYlnmJP6sY=;
        b=oRPsoLk96ZIGxC/SR64bT6Notcx8RQr+HNPfoPA9CjcYsv8wdgQ5Jms+WsguBl8Qg6
         C5WiyquCTVElHob9jEKs8n0UkJ9JeuX4SNcTEl4lRtnq/7OwSZq3Euvylf9DcHtVoCfR
         cnfqPJWfyLiL2JWELGUDaM8Q0UJAR4XJHRQsTTxoxtlqJouF0DYFUexH37uWrBW4aKwX
         8MYqCHudreusxZqVXoH7Ir/oXCpmISTZ0FZeH4t1Tg9nWZvjjTbxdU6PrQPhxWHigOQx
         EWjrTuq2sGwLvc4Pw8+4HIlPxI7vNILupIRW9RzTnTOVrWN9/IIRoVGe+cNBqde/1mPr
         Bcpw==
X-Gm-Message-State: AOJu0Yw1Y5omUkVIELGHB5aOaII79TVBv+206ubrb96jEkFUF1WyUJ5T
	NQlBihic2RBW9ssxkby0rhOnwnuXQxvzl0pc5pbYUGakQtEOdk5H2QMwUUiUOg5i
X-Gm-Gg: Acq92OH+kdeFS4/rKLzG9Rtv6DTR3/RjcVMkzBH+9YuGwzWeyLqpYX9TuYLw5Aovpqd
	YBbAmFLBhL1ML4jZFsc3/23TgXF4C0pcNLBs7tbx3WVL0REt14rSOUofI5xV/pdvXJskM02OHj6
	QClcgrV5ULzzVyQ9N/5kkiLoOjeHuo7vTDlBEvjJfIGhfrq627mfVNa8zCDWjLqoinTfSCORjfo
	iIp6DBgpLfUtMa3jpa4/qHuzAGihaGQG5paPt5GTyp07hLg8JN2AJ/ntLaHS8ClaZiv1jlmfjCQ
	caz9v5P4Dyix6V/IYDCy0vb482IGlEXrv+mHVEhH9CFvFHpIcv6GgEkGaX58aB/rq45JMfzoFs1
	CgIdQCA8bPPuCuhZFSkO0mnSwz4Xf/FJnli0S6Q25I0XC36wrLTnol9OzyKsW0H70XKDiDsvPu3
	sLlFrNzIKpdO9c6xZZ//JDoA==
X-Received: by 2002:a05:6808:1524:b0:479:ac7d:6d8a with SMTP id 5614622812f47-48741b03b3emr8075236b6e.24.1781544493657;
        Mon, 15 Jun 2026 10:28:13 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f451fe7sm4480033a34.0.2026.06.15.10.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:28:12 -0700 (PDT)
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
Subject: [PATCH V13 6/9] iio: imu: inv_icm42607: Add Temp Support in icm42607
Date: Mon, 15 Jun 2026 12:25:49 -0500
Message-ID: <20260615172554.160910-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615172554.160910-1-macroalpha82@gmail.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  3 +
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 18 +++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 81 +++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 37 +++++++++
 5 files changed, 140 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h

diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index be109102e203..c04953ed42ce 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
 inv-icm42607-y += inv_icm42607_core.o
+inv-icm42607-y += inv_icm42607_temp.o
 
 obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
 inv-icm42607-i2c-y += inv_icm42607_i2c.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 4f4f541027dc..726b836582a2 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -358,6 +358,9 @@ extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
+int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
+			       unsigned int *sleep_ms);
+
 int inv_icm42607_core_probe(struct regmap *regmap,
 			    const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 64f5d263de4f..644cd7f821b9 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -162,6 +162,24 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 	return 0;
 }
 
+int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
+			       unsigned int *sleep_ms)
+{
+	unsigned int val;
+	int ret;
+
+	val = FIELD_PREP(INV_ICM42607_TEMP_CONFIG0_FILTER_MASK,
+			 INV_ICM42607_FILTER_BW_34HZ);
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_TEMP_CONFIG0,
+				 INV_ICM42607_TEMP_CONFIG0_FILTER_MASK, val);
+	if (ret)
+		return ret;
+
+	return inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode,
+					  st->conf.accel.mode, enable,
+					  sleep_ms);
+}
+
 static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
 				 const struct inv_icm42607_conf *conf)
 {
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
new file mode 100644
index 000000000000..9a60e1a478b0
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
@@ -0,0 +1,81 @@
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
+	struct device *dev = regmap_get_device(st->map);
+	u8 raw[2];
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	st->conf.temp_en = true;
+	ret = inv_icm42607_set_temp_conf(st, st->conf.temp_en, NULL);
+	st->conf.temp_en = false;
+	if (ret)
+		return ret;
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
index 000000000000..cb7b460ffb44
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
@@ -0,0 +1,37 @@
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

