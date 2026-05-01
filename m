Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E637474E
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673668; cv=none; b=C/Bj+ntn3lLXaF9casTGZdc3YhaIJJTzbn/qUeTieizlgQmJSNHii2Db8HgCTCSxfzq8lPZXLIZgRc6BO/ZHtoaLYFrKqbodt/FOlpT5gvhDwZqZ5NajxbkBXZKliLKKVH5nHlplH9ooJAcjcjyz2DJuweZ3dhWpY6QpwHus85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673668; c=relaxed/simple;
	bh=kYIsPYLohAYdJ9TxQx/FTeTG0bzw2jgNo640eeaOlMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axPwOsiCUXKaFRc2DNO7DEsoJvzcgZLAYpta3psLAyChsaXUgGJb9JJ4R+oesgICSxZqxdV5zEm9agq1c2lsa/G/zW20RS0Ls0NAV3S7h5BfS+GBw9o1k2vqKNVSUiI8jHGusc+w1Qg6Z2BjMmYpN+VWzifz9G/RLbEJFF380Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJ58cqSr; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJ58cqSr"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7de431da8fbso2137054a34.1
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777673665; x=1778278465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49vBJkFKrYjNF+Ui2HurqLTrIqD9YJ6DJuMi5GITR14=;
        b=qJ58cqSru8EavaxEjPZ/gcvAJdLUMwrpnp4U45jD4abDz3DEYFlFZcQqntWxdDgU/d
         jhKHo2oKcMGw8LYVJHhn2URv2Neh42G1kvCRGigOWDnFd0HqW5IphVsi+ZXX8LbZn0tV
         hBlba3w82N2eBSnI8fcQxoUxvfltXZ6rnCjPXq//YzW9R8P4L2c8suT+qEhBWqq3Mw+J
         5rLlTLkjBVsGKSK5ZVoO4z8yaE91Z8BK7b+b1aE/BZOrNdFy6TtLVshv3JcCi3d9bvbg
         j/4uhIX37kZ7kM5QmwqfJVYThbEwfU2ph5+iF+pNq4VMGYbqeUD03hTx/hOmGpUe9N/L
         0+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673665; x=1778278465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=49vBJkFKrYjNF+Ui2HurqLTrIqD9YJ6DJuMi5GITR14=;
        b=YUXNfGg48+RNOVzNiPhLAZtOLk29n090JheQ+cnCM4hS4pFlI0u5x4pRyHAqrVB2JN
         MQPkJaABxwldzppitphicXi83l8zytLxjUhxiVao1GZoDkyb+BBy4d7t1j2VIIeR/B9s
         TM6donaYudIw2u9cU6qmD3RwU8oUPsXkHWU+RJh3aaG+mJ0ZjLNzqjaVlU2q/BmY+/O1
         eLi/ZYhH6j1jDy6ikwwW8/MFWd7KKUAXXypYf78wLhxSqpU7zhh2C9If5LgjMV12w6WM
         vT0XYeuOz3oJB5PX9D19iI4o74Fg+1sQ/HWQO1ncbezanCXyu62s89KQxpedG//ELwIW
         CxwA==
X-Gm-Message-State: AOJu0YyzHIqvClvgOEtp6atsQlWub1r4/Vm8hVVL0LhQkfIhnf0Rx8Xq
	i0RgBFa8VFRcfehhF4Mi05iAT42KQAoIkwXFfP2Esq+kKe0WqshgBVJuT8g55g==
X-Gm-Gg: AeBDiesRyAgZxnc3Z/V++k01cz2348namhC0DqF+LfF0kV39CWTnDXxMcHBl4ZRtpDm
	nZ+MaRzWTIcpfAzfTpr8MprYdtSf9SPo7itBA1+vu59oME4hruzswoRiIAyXlQWwq0Oe2uPBrQp
	USpzhgh0DKXf1S8oEuf4+eXYJMalJPrsKF24hm23vf4eCzjCXFyxXVWAXR4ar46T2wIZ1mHnAQ2
	ftYI7y0tPpAq2Ihx8LDnbT815uTSPYCEA+YxhnXwWnijp/HZ3U31TxAzF89iPNT6jeJT52jWmtq
	APyZwynh0GFl23iAPDriYfU9eblimzzWn4suDMjX38dDygFVKc9XWy6/fbQCk7CCjC0WRXN+ZOi
	Nd+DyMaLSxL0pXQ7rtlbEpwz5fbUCqhfTlqgOn30oOgSEkoKPE1k2uBCUgauGsd/WY9liXFJCVt
	AjPKu1FmeiyBXj5Vko46YswfWYD9ucDOg=
X-Received: by 2002:a05:6830:91c:b0:7dc:18e:b5a4 with SMTP id 46e09a7af769-7dee1330b14mr929768a34.11.1777673665418;
        Fri, 01 May 2026 15:14:25 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded51a9612sm1827337a34.26.2026.05.01.15.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:14:25 -0700 (PDT)
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
Subject: [PATCH V4 05/10] iio: imu: inv_icm42607: Add Buffer support for icm42607
Date: Fri,  1 May 2026 17:11:44 -0500
Message-ID: <20260501221152.194251-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501221152.194251-1-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add all FIFO parsing and reading functions to support
inv_icm42607 hardware.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42607/Makefile         |   1 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |   4 +
 .../imu/inv_icm42607/inv_icm42607_buffer.c    | 489 ++++++++++++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.h    | 101 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  |  26 +
 5 files changed, 621 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h

diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index be109102e203..3c9d08509793 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
 inv-icm42607-y += inv_icm42607_core.o
+inv-icm42607-y += inv_icm42607_buffer.o
 
 obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
 inv-icm42607-i2c-y += inv_icm42607_i2c.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 7facc114adc5..fd860685d0ad 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -15,6 +15,8 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include "inv_icm42607_buffer.h"
+
 enum inv_icm42607_chip {
 	INV_CHIP_INVALID,
 	INV_CHIP_ICM42607P,
@@ -140,6 +142,7 @@ struct inv_icm42607_apex {
  *  @indio_accel:	accelerometer IIO device.
  *  @timestamp:         interrupt timestamps.
  *  @apex:		APEX (Advanced Pedometer and Event detection) management
+ *  @fifo:		FIFO management structure.
  *  @buffer:		data transfer buffer aligned for DMA.
  */
 struct inv_icm42607_state {
@@ -159,6 +162,7 @@ struct inv_icm42607_state {
 		s64 accel;
 	} timestamp;
 	struct inv_icm42607_apex apex;
+	struct inv_icm42607_fifo fifo;
 	__be16 buffer[3] __aligned(IIO_DMA_MINALIGN);
 };
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
new file mode 100644
index 000000000000..5c67f6a37520
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
+
+#include "inv_icm42607.h"
+#include "inv_icm42607_buffer.h"
+
+/* FIFO header: 1 byte */
+#define INV_ICM42607_FIFO_HEADER_MSG		BIT(7)
+#define INV_ICM42607_FIFO_HEADER_ACCEL		BIT(6)
+#define INV_ICM42607_FIFO_HEADER_GYRO		BIT(5)
+#define INV_ICM42607_FIFO_HEADER_TMST_FSYNC	GENMASK(3, 2)
+#define INV_ICM42607_FIFO_HEADER_ODR_ACCEL	BIT(1)
+#define INV_ICM42607_FIFO_HEADER_ODR_GYRO	BIT(0)
+
+struct inv_icm42607_fifo_1sensor_packet {
+	u8 header;
+	struct inv_icm42607_fifo_sensor_data data;
+	s8 temp;
+} __packed;
+#define INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE		8
+
+struct inv_icm42607_fifo_2sensors_packet {
+	u8 header;
+	struct inv_icm42607_fifo_sensor_data accel;
+	struct inv_icm42607_fifo_sensor_data gyro;
+	s8 temp;
+	__be16 timestamp;
+} __packed;
+#define INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE		16
+
+ssize_t inv_icm42607_fifo_decode_packet(const void *packet, const void **accel,
+					const void **gyro, const int8_t **temp,
+					const void **timestamp, unsigned int *odr)
+{
+	const struct inv_icm42607_fifo_1sensor_packet *pack1 = packet;
+	const struct inv_icm42607_fifo_2sensors_packet *pack2 = packet;
+	u8 header = *((const u8 *)packet);
+
+	/* FIFO empty */
+	if (header & INV_ICM42607_FIFO_HEADER_MSG) {
+		*accel = NULL;
+		*gyro = NULL;
+		*temp = NULL;
+		*timestamp = NULL;
+		*odr = 0;
+		return 0;
+	}
+
+	/* handle odr flags */
+	*odr = 0;
+	if (header & INV_ICM42607_FIFO_HEADER_ODR_GYRO)
+		*odr |= INV_ICM42607_SENSOR_GYRO;
+	if (header & INV_ICM42607_FIFO_HEADER_ODR_ACCEL)
+		*odr |= INV_ICM42607_SENSOR_ACCEL;
+
+	/* accel + gyro */
+	if ((header & INV_ICM42607_FIFO_HEADER_ACCEL) &&
+	    (header & INV_ICM42607_FIFO_HEADER_GYRO)) {
+		*accel = &pack2->accel;
+		*gyro = &pack2->gyro;
+		*temp = &pack2->temp;
+		*timestamp = &pack2->timestamp;
+		return INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE;
+		}
+
+	/* accel only */
+	if (header & INV_ICM42607_FIFO_HEADER_ACCEL) {
+		*accel = &pack1->data;
+		*gyro = NULL;
+		*temp = &pack1->temp;
+		*timestamp = NULL;
+		return INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE;
+	}
+
+	/* gyro only */
+	if (header & INV_ICM42607_FIFO_HEADER_GYRO) {
+		*accel = NULL;
+		*gyro = &pack1->data;
+		*temp = &pack1->temp;
+		*timestamp = NULL;
+		return INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE;
+	}
+
+	/* invalid packet if here */
+	return -EINVAL;
+}
+
+void inv_icm42607_buffer_update_fifo_period(struct inv_icm42607_state *st)
+{
+	u32 period_gyro, period_accel;
+
+	if (st->fifo.en & INV_ICM42607_SENSOR_GYRO)
+		period_gyro = inv_icm42607_odr_to_period(st->conf.gyro.odr);
+	else
+		period_gyro = U32_MAX;
+
+	if (st->fifo.en & INV_ICM42607_SENSOR_ACCEL)
+		period_accel = inv_icm42607_odr_to_period(st->conf.accel.odr);
+	else
+		period_accel = U32_MAX;
+
+	st->fifo.period = min(period_gyro, period_accel);
+}
+
+int inv_icm42607_buffer_set_fifo_en(struct inv_icm42607_state *st,
+				    unsigned int fifo_en)
+{
+	unsigned int val;
+	int ret;
+
+	/* update FIFO EN bits for accel and gyro */
+	val = 0;
+	if (fifo_en & INV_ICM42607_SENSOR_GYRO)
+		val |= INV_ICM42607_FIFO_CONFIG1_MODE;
+	if (fifo_en & INV_ICM42607_SENSOR_ACCEL)
+		val |= INV_ICM42607_FIFO_CONFIG1_MODE;
+	if (fifo_en & INV_ICM42607_SENSOR_TEMP)
+		val |= INV_ICM42607_FIFO_CONFIG1_MODE;
+
+	ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1, val);
+	if (ret)
+		return ret;
+
+	st->fifo.en = fifo_en;
+	inv_icm42607_buffer_update_fifo_period(st);
+
+	return 0;
+}
+
+static size_t inv_icm42607_get_packet_size(unsigned int fifo_en)
+{
+	size_t packet_size;
+
+	if ((fifo_en & INV_ICM42607_SENSOR_GYRO) &&
+	    (fifo_en & INV_ICM42607_SENSOR_ACCEL))
+		packet_size = INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE;
+	else
+		packet_size = INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE;
+
+	return packet_size;
+}
+
+static unsigned int inv_icm42607_wm_truncate(unsigned int watermark,
+					     size_t packet_size)
+{
+	size_t wm_size;
+
+	wm_size = watermark * packet_size;
+	if (wm_size > INV_ICM42607_FIFO_WATERMARK_MAX)
+		wm_size = INV_ICM42607_FIFO_WATERMARK_MAX;
+
+	return wm_size / packet_size;
+}
+
+/**
+ * inv_icm42607_buffer_update_watermark - update watermark FIFO threshold
+ * @st:	driver internal state
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int inv_icm42607_buffer_update_watermark(struct inv_icm42607_state *st)
+{
+	size_t packet_size, wm_size;
+	unsigned int wm_gyro, wm_accel, watermark;
+	u32 period_gyro, period_accel;
+	u32 latency_gyro, latency_accel, latency;
+	bool restore;
+	__le16 raw_wm;
+	int ret;
+
+	packet_size = inv_icm42607_get_packet_size(st->fifo.en);
+
+	/* compute sensors latency, depending on sensor watermark and odr */
+	wm_gyro = inv_icm42607_wm_truncate(st->fifo.watermark.gyro, packet_size);
+	wm_accel = inv_icm42607_wm_truncate(st->fifo.watermark.accel, packet_size);
+	/* use us for odr to avoid overflow using 32 bits values */
+	period_gyro = inv_icm42607_odr_to_period(st->conf.gyro.odr) / 1000UL;
+	period_accel = inv_icm42607_odr_to_period(st->conf.accel.odr) / 1000UL;
+	latency_gyro = period_gyro * wm_gyro;
+	latency_accel = period_accel * wm_accel;
+
+	/* 0 value for watermark means that the sensor is turned off */
+	if (wm_gyro == 0 && wm_accel == 0)
+		return 0;
+
+	if (latency_gyro == 0) {
+		watermark = wm_accel;
+		st->fifo.watermark.eff_accel = wm_accel;
+	} else if (latency_accel == 0) {
+		watermark = wm_gyro;
+		st->fifo.watermark.eff_gyro = wm_gyro;
+	} else {
+		/* compute the smallest latency that is a multiple of both */
+		if (latency_gyro <= latency_accel)
+			latency = latency_gyro - (latency_accel % latency_gyro);
+		else
+			latency = latency_accel - (latency_gyro % latency_accel);
+		/* all this works because periods are multiple of each others */
+		watermark = latency / min(period_gyro, period_accel);
+		if (watermark < 1)
+			watermark = 1;
+		/* update effective watermark */
+		st->fifo.watermark.eff_gyro = latency / period_gyro;
+		if (st->fifo.watermark.eff_gyro < 1)
+			st->fifo.watermark.eff_gyro = 1;
+		st->fifo.watermark.eff_accel = latency / period_accel;
+		if (st->fifo.watermark.eff_accel < 1)
+			st->fifo.watermark.eff_accel = 1;
+	}
+
+	/* compute watermark value in bytes */
+	wm_size = watermark * packet_size;
+
+	/* changing FIFO watermark requires to turn off watermark interrupt */
+	ret = regmap_update_bits_check(st->map, INV_ICM42607_REG_INT_SOURCE0,
+				       INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
+				       0, &restore);
+	if (ret)
+		return ret;
+
+	raw_wm = INV_ICM42607_FIFO_WATERMARK_VAL(wm_size);
+	memcpy(st->buffer, &raw_wm, sizeof(raw_wm));
+	ret = regmap_bulk_write(st->map, INV_ICM42607_REG_FIFO_CONFIG2,
+				st->buffer, sizeof(raw_wm));
+	if (ret)
+		return ret;
+
+	/* restore watermark interrupt */
+	if (restore) {
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
+					 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
+					 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int inv_icm42607_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm42607_sensor_state *sensor_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &sensor_st->ts;
+
+	pm_runtime_get_sync(dev);
+
+	guard(mutex)(&st->lock);
+	inv_sensors_timestamp_reset(ts);
+
+	return 0;
+}
+
+/*
+ * update_scan_mode callback is turning sensors on and setting data FIFO enable
+ * bits.
+ */
+static int inv_icm42607_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	/* exit if FIFO is already on */
+	if (st->fifo.on) {
+		st->fifo.on++;
+		return 0;
+	}
+
+	/* set FIFO threshold interrupt */
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
+				 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
+				 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);
+	if (ret)
+		return ret;
+
+	/* flush FIFO data */
+	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
+			   INV_ICM42607_SIGNAL_PATH_RESET_FIFO_FLUSH);
+	if (ret)
+		return ret;
+
+	/* set FIFO in streaming mode */
+	ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
+			   INV_ICM42607_FIFO_CONFIG1_MODE);
+	if (ret)
+		return ret;
+
+	/* workaround: first read of FIFO count after reset is always 0 */
+	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_FIFO_COUNTH, st->buffer, 2);
+	if (ret)
+		return ret;
+
+	st->fifo.on++;
+
+	return 0;
+}
+
+static int inv_icm42607_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	if (st->fifo.on > 1) {
+		st->fifo.on--;
+		return 0;
+	}
+
+	/* set FIFO in bypass mode */
+	ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
+			   INV_ICM42607_FIFO_CONFIG1_BYPASS);
+	if (ret)
+		return ret;
+
+	/* flush FIFO data */
+	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
+			   INV_ICM42607_SIGNAL_PATH_RESET_FIFO_FLUSH);
+	if (ret)
+		return ret;
+
+	/* disable FIFO threshold interrupt */
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
+				 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN, 0);
+	if (ret)
+		return ret;
+
+	st->fifo.on--;
+
+	return 0;
+}
+
+static int inv_icm42607_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int sensor;
+	unsigned int *watermark;
+	unsigned int sleep_temp = 0;
+	unsigned int sleep_sensor = 0;
+	unsigned int sleep;
+	int ret;
+
+	if (indio_dev == st->indio_gyro) {
+		sensor = INV_ICM42607_SENSOR_GYRO;
+		watermark = &st->fifo.watermark.gyro;
+	} else if (indio_dev == st->indio_accel) {
+		sensor = INV_ICM42607_SENSOR_ACCEL;
+		watermark = &st->fifo.watermark.accel;
+	} else {
+		return -EINVAL;
+	}
+
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42607_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
+	if (ret)
+		goto out_unlock;
+
+	*watermark = 0;
+	ret = inv_icm42607_buffer_update_watermark(st);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	mutex_unlock(&st->lock);
+
+	/* sleep maximum required time */
+	sleep = max(sleep_sensor, sleep_temp);
+	if (sleep)
+		msleep(sleep);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+const struct iio_buffer_setup_ops inv_icm42607_buffer_ops = {
+	.preenable = inv_icm42607_buffer_preenable,
+	.postenable = inv_icm42607_buffer_postenable,
+	.predisable = inv_icm42607_buffer_predisable,
+	.postdisable = inv_icm42607_buffer_postdisable,
+};
+
+int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
+				  unsigned int max)
+{
+	size_t max_count;
+	__be16 *raw_fifo_count;
+	ssize_t i, size;
+	const void *accel, *gyro, *timestamp;
+	const s8 *temp;
+	unsigned int odr;
+	int ret;
+
+	/* reset all samples counters */
+	st->fifo.count = 0;
+	st->fifo.nb.gyro = 0;
+	st->fifo.nb.accel = 0;
+	st->fifo.nb.total = 0;
+
+	/* compute maximum FIFO read size */
+	if (max == 0)
+		max_count = sizeof(st->fifo.data);
+	else
+		max_count = max * inv_icm42607_get_packet_size(st->fifo.en);
+
+	/* read FIFO count value */
+	raw_fifo_count = (__be16 *)st->buffer;
+	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_FIFO_COUNTH,
+			       raw_fifo_count, sizeof(*raw_fifo_count));
+	if (ret)
+		return ret;
+	st->fifo.count = be16_to_cpup(raw_fifo_count);
+
+	/* check and clamp FIFO count value */
+	if (st->fifo.count == 0)
+		return 0;
+	if (st->fifo.count > max_count)
+		st->fifo.count = max_count;
+
+	/* read all FIFO data in internal buffer */
+	ret = regmap_noinc_read(st->map, INV_ICM42607_REG_FIFO_DATA,
+				st->fifo.data, st->fifo.count);
+	if (ret)
+		return ret;
+
+	/* compute number of samples for each sensor */
+	for (i = 0; i < st->fifo.count; i += size) {
+		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
+				&accel, &gyro, &temp, &timestamp, &odr);
+		if (size <= 0)
+			break;
+		if (gyro != NULL && inv_icm42607_fifo_is_data_valid(gyro))
+			st->fifo.nb.gyro++;
+		if (accel != NULL && inv_icm42607_fifo_is_data_valid(accel))
+			st->fifo.nb.accel++;
+		st->fifo.nb.total++;
+	}
+
+	return 0;
+}
+
+int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
+				     unsigned int count)
+{
+	s64 gyro_ts, accel_ts;
+	int ret;
+
+	gyro_ts = iio_get_time_ns(st->indio_gyro);
+	accel_ts = iio_get_time_ns(st->indio_accel);
+
+	ret = inv_icm42607_buffer_fifo_read(st, count);
+
+	return ret;
+}
+
+int inv_icm42607_buffer_init(struct inv_icm42607_state *st)
+{
+	int ret;
+
+	st->fifo.watermark.eff_gyro = 1;
+	st->fifo.watermark.eff_accel = 1;
+
+	/* Configure FIFO_COUNT format in bytes and big endian */
+	ret = regmap_set_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
+			      INV_ICM42607_INTF_CONFIG0_FIFO_COUNT_ENDIAN);
+	if (ret)
+		return ret;
+
+	/* Initialize FIFO in bypass mode */
+	return regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
+			    INV_ICM42607_FIFO_CONFIG1_BYPASS);
+}
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
new file mode 100644
index 000000000000..2df49e795ad1
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#ifndef INV_ICM42607_BUFFER_H_
+#define INV_ICM42607_BUFFER_H_
+
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+
+struct inv_icm42607_state;
+
+#define INV_ICM42607_SENSOR_GYRO	BIT(0)
+#define INV_ICM42607_SENSOR_ACCEL	BIT(1)
+#define INV_ICM42607_SENSOR_TEMP	BIT(2)
+
+/**
+ * struct inv_icm42607_fifo - FIFO state variables
+ * @on:		reference counter for FIFO on.
+ * @en:		bits field of INV_ICM42607_SENSOR_* for FIFO EN bits.
+ * @period:	FIFO internal period.
+ * @watermark:	watermark configuration values for accel and gyro.
+ * @count:	number of bytes in the FIFO data buffer.
+ * @nb:		gyro, accel and total samples in the FIFO data buffer.
+ * @data:	FIFO data buffer aligned for DMA (2kB + 32 bytes of read cache).
+ */
+struct inv_icm42607_fifo {
+	unsigned int on;
+	unsigned int en;
+	u32 period;
+	struct {
+		unsigned int gyro;
+		unsigned int accel;
+		unsigned int eff_gyro;
+		unsigned int eff_accel;
+	} watermark;
+	size_t count;
+	struct {
+		size_t gyro;
+		size_t accel;
+		size_t total;
+	} nb;
+	u8 data[2080] __aligned(IIO_DMA_MINALIGN);
+};
+
+/* FIFO data packet */
+struct inv_icm42607_fifo_sensor_data {
+	__be16 x;
+	__be16 y;
+	__be16 z;
+};
+
+#define INV_ICM42607_FIFO_DATA_INVALID		-32768
+
+static inline s16 inv_icm42607_fifo_get_sensor_data(__be16 d)
+{
+	return be16_to_cpu(d);
+}
+
+static inline bool
+inv_icm42607_fifo_is_data_valid(const struct inv_icm42607_fifo_sensor_data *s)
+{
+	s16 x, y, z;
+
+	x = inv_icm42607_fifo_get_sensor_data(s->x);
+	y = inv_icm42607_fifo_get_sensor_data(s->y);
+	z = inv_icm42607_fifo_get_sensor_data(s->z);
+
+	if (x == INV_ICM42607_FIFO_DATA_INVALID &&
+		y == INV_ICM42607_FIFO_DATA_INVALID &&
+		z == INV_ICM42607_FIFO_DATA_INVALID)
+		return false;
+
+	return true;
+}
+
+ssize_t inv_icm42607_fifo_decode_packet(const void *packet, const void **accel,
+					const void **gyro, const s8 **temp,
+					const void **timestamp, unsigned int *odr);
+
+extern const struct iio_buffer_setup_ops inv_icm42607_buffer_ops;
+
+int inv_icm42607_buffer_init(struct inv_icm42607_state *st);
+
+void inv_icm42607_buffer_update_fifo_period(struct inv_icm42607_state *st);
+
+int inv_icm42607_buffer_set_fifo_en(struct inv_icm42607_state *st,
+				    unsigned int fifo_en);
+
+int inv_icm42607_buffer_update_watermark(struct inv_icm42607_state *st);
+
+int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
+				  unsigned int max);
+
+int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st);
+
+int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
+				     unsigned int count);
+
+#endif
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index af3784040b7a..7b9c05df820a 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 
 #include "inv_icm42607.h"
+#include "inv_icm42607_buffer.h"
 
 static const struct regmap_range_cfg inv_icm42607_regmap_ranges[] = {
 	{
@@ -163,6 +164,7 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 	return 0;
 }
 
+
 int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
@@ -370,6 +372,11 @@ int inv_icm42607_core_probe(struct regmap *regmap, int chip,
 	if (ret)
 		return ret;
 
+	/* Initialize buffer/FIFO handling */
+	ret = inv_icm42607_buffer_init(st);
+	if (ret)
+		return ret;
+
 	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret)
 		return ret;
@@ -401,6 +408,13 @@ static int inv_icm42607_suspend(struct device *dev)
 	if (pm_runtime_suspended(dev))
 		return 0;
 
+	if (st->fifo.on) {
+		ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
+				   INV_ICM42607_FIFO_CONFIG1_BYPASS);
+		if (ret)
+			return ret;
+	}
+
 	/* keep chip on and wake-up capable if APEX and wakeup on */
 	accel_dev = &st->indio_accel->dev;
 	wakeup = st->apex.on && device_may_wakeup(accel_dev);
@@ -432,6 +446,8 @@ static int inv_icm42607_suspend(struct device *dev)
 static int inv_icm42607_resume(struct device *dev)
 {
 	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	struct inv_icm42607_sensor_state *gyro_st = iio_priv(st->indio_gyro);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct device *accel_dev;
 	bool wakeup;
 	int ret;
@@ -458,6 +474,16 @@ static int inv_icm42607_resume(struct device *dev)
 	ret = inv_icm42607_set_pwr_mgmt0(st, st->suspended.gyro,
 					 st->suspended.accel,
 					 st->suspended.temp, NULL);
+	if (ret)
+		return ret;
+
+	if (st->fifo.on) {
+		inv_sensors_timestamp_reset(&gyro_st->ts);
+		inv_sensors_timestamp_reset(&accel_st->ts);
+		ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
+				   INV_ICM42607_FIFO_CONFIG1_MODE);
+	}
+
 	return ret;
 }
 
-- 
2.43.0

