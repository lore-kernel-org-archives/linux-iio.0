Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E592868A7
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850171; cv=none; b=THl2nszJnar8uP+nyXQfnFZRd3GSkl69X55SLg9fRA7yONC7iu1rD2e3ffUPPC3RwbPBbrqAQaCAnswejFzGHyLF2MKkyn56QZ/bxyxxGaPKJxySnslmQub3pCEKQVniWR+gH+jnPJ1JJGALnbdA2wZ0wtfcavoCtr9u3g5zuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850171; c=relaxed/simple;
	bh=BeVsv9ZZ1V3ysW8iEF71Q7WwuLMpbh+fNotyJHuEAJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKA6rXXWve/5ig2pFfE17hl9TYWibHGrKgVRF4eeNLAbEEfbIWhpN09wqpW8WpZdysOrbxFXyk6xsouKkn5TgmtRJ7nrArZUaqsuzxWv2cdQzTnkSv8rohSY5QT239Y4CNHP+8AYVoMQua/YVRvmpvw5ZZbwqfcDYj4BRS28El8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzj42ztP; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzj42ztP"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43a1004f686so814186fac.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 06:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778850167; x=1779454967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGjUkkZxksixHvBLlYzllO6TjHAMCKDuDS6ZoW0fEyQ=;
        b=kzj42ztPkRqD1ZYGUpC8s3uySAW4a9RNuZmnH+jA90M/JfufjKZfZj+kLcyxF2eYpa
         OC3SyH0gXjDDvEM+Kc9ID0mh4s1UBEreB6H8o58ltXoTrzhLw/QYDY4fAPbROCkw86mO
         rT/Cg9Kc1GQyOhewryT0Omtkfx9GHzf2MJ/ML5nPOF+g2xEfJHRyeHz8r5KDwkYGP4dN
         ChFOdyLtSY3AWOSlj3ZGGg0XO4ltd2DAAeIq6FCZptMJcq0DSIJPjfvLYadFfv2sYHU+
         n4S4JsJLDbuX25E161xFhtGsZq7sVUTFvHdiM6h6t4yDV2n0Lx4uoo7iqGNWylDTHwhF
         zMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850167; x=1779454967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGjUkkZxksixHvBLlYzllO6TjHAMCKDuDS6ZoW0fEyQ=;
        b=T2L3n9DJLx9rz5LTsnwSPLZVAyKsR/cLwfH/APYPmONmE6q8c8X/Crda9d4F2Gz3Ss
         6ayAhppciub2VyekqxidGr715nRreXqBVaM4NH3fXuj1pxCEbUonZSJZptFunHIDUmo7
         M8gHT9od3q0fYS4YORvnPsT5SaRt1B/qTg5tXtfYbLGJMDfghB7MzUmMZDna9TeYZOi2
         qTj2LfPVjnHpO0i+fYvVFhptbZ/xKk+R+41o1uauEyfXYrl+u+me84zDhbJQTBKIql/5
         wvIG5kit63lzxbFfHhMUWqVEyLrYCEKRFVjNjKRrsTEzhy2laqxZQ/qNZ1VpBHIerdZX
         LRag==
X-Gm-Message-State: AOJu0YwBBE4pYfNMWkr1lhLd3+DvSwFUq4Je39m9R0tJC0qN2qhVSsui
	1WH/5jLe8kSP7rfWv7O5gGywcjh45HsRO+Jq6s1R8B+x6fR2izI4szGIdDwi7W8b
X-Gm-Gg: Acq92OGiMrLS2j015K1FtAMbE7+PYybdDyHh0Fv6nOtePL01IBt5rNJmFgCmX5eG9Bg
	pD3fd/ajfIJs876tx+2i0wgT3amvxchKNmTy9qZhD3ewQpjTPVm05sb7IOPBR2mgLg4XRKPDFCm
	QFw5TohcF+zql2hbPMsilTcEgsUcWYJS5p3LH8xT0NusGVhCoFZkY7FQ4liTSSMBk1mwkAsomfn
	WILJla9rbSQSfGqk/ZQktHKBTHgUr6oYP0yHeNSF+l9AJhbC/C27M4DRqhCRSxpIhf9mDHW/5Co
	Z+H6uvjusDmiy32QAABNzEmRPBTTJiwrwx3B2xuP8AwEfp3dLWuwatJo5MnWvqg9LxPwt9+DPHm
	qYjTYcfGvBsc4srAG+EZwYBi/Lfd+9i1WUpVVFOt268FkzwnMC56WPVYusxQRBxlMlsHzC0tmCV
	uTl1f2McqiWt1ZK0JRF3qqIgCl+X9gMxBxm3SKeGdk+w==
X-Received: by 2002:a05:6871:b21:b0:42f:cd67:2b84 with SMTP id 586e51a60fabf-43a2d9cb7damr2521540fac.9.1778850166801;
        Fri, 15 May 2026 06:02:46 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:8c2e:6a8e:445a:9169])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc53f2acsm4155822fac.14.2026.05.15.06.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:02:46 -0700 (PDT)
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
Subject: [PATCH V7 06/11] iio: imu: inv_icm42607: Add Buffer support for icm42607
Date: Fri, 15 May 2026 08:00:11 -0500
Message-ID: <20260515130018.237378-7-macroalpha82@gmail.com>
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

Add all FIFO parsing and reading functions to support
inv_icm42607 hardware.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42607/Makefile         |   1 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  27 +
 .../imu/inv_icm42607/inv_icm42607_buffer.c    | 483 ++++++++++++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.h    |  93 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  |  54 +-
 5 files changed, 657 insertions(+), 1 deletion(-)
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
index 5f37999e39a5..b00ee6a4d451 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -14,6 +14,10 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include <linux/iio/common/inv_sensors_timestamp.h>
+
+#include "inv_icm42607_buffer.h"
+
 /* serial bus slew rates */
 enum inv_icm42607_slew_rate {
 	INV_ICM42607_SLEW_RATE_20_60NS,
@@ -84,6 +88,7 @@ struct inv_icm42607_sensor_conf {
 	int odr;
 	int filter;
 };
+#define INV_ICM42607_SENSOR_CONF_INIT		{-1, -1, -1, -1}
 
 struct inv_icm42607_conf {
 	struct inv_icm42607_sensor_conf gyro;
@@ -114,6 +119,10 @@ struct inv_icm42607_suspended {
  *  @orientation:	sensor chip orientation relative to main hardware.
  *  @conf:		chip sensors configurations.
  *  @suspended:		suspended sensors configuration.
+ *  @indio_gyro:	gyroscope IIO device.
+ *  @indio_accel:	accelerometer IIO device.
+ *  @fifo:		FIFO management structure.
+ *  @buffer:		data transfer buffer aligned for DMA.
  */
 struct inv_icm42607_state {
 	struct mutex lock;
@@ -125,6 +134,22 @@ struct inv_icm42607_state {
 	struct iio_mount_matrix orientation;
 	struct inv_icm42607_conf conf;
 	struct inv_icm42607_suspended suspended;
+	struct iio_dev *indio_gyro;
+	struct iio_dev *indio_accel;
+	struct inv_icm42607_fifo fifo;
+	__be16 buffer[3] __aligned(IIO_DMA_MINALIGN);
+};
+
+/**
+ * struct inv_icm42607_sensor_state - sensor state variables
+ * @power_mode:		sensor requested power mode (for common frequencies)
+ * @filter:		sensor filter.
+ * @ts:			timestamp module states.
+ */
+struct inv_icm42607_sensor_state {
+	enum inv_icm42607_sensor_mode power_mode;
+	int filter;
+	struct inv_sensors_timestamp ts;
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
@@ -352,6 +377,8 @@ extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
+u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr);
+
 int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
new file mode 100644
index 000000000000..74e5213d9267
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/common/inv_sensors_timestamp.h>
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
+
+struct inv_icm42607_fifo_2sensors_packet {
+	u8 header;
+	struct inv_icm42607_fifo_sensor_data accel;
+	struct inv_icm42607_fifo_sensor_data gyro;
+	s8 temp;
+	__be16 timestamp;
+} __packed;
+
+ssize_t inv_icm42607_fifo_decode_packet(const void *packet, const void **accel,
+					const void **gyro, const int8_t **temp,
+					const void **timestamp)
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
+		return 0;
+	}
+
+	/* accel + gyro */
+	if ((header & INV_ICM42607_FIFO_HEADER_ACCEL) &&
+	    (header & INV_ICM42607_FIFO_HEADER_GYRO)) {
+		*accel = &pack2->accel;
+		*gyro = &pack2->gyro;
+		*temp = &pack2->temp;
+		*timestamp = &pack2->timestamp;
+		return INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE;
+	}
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
+	wm_size = min(wm_size, INV_ICM42607_FIFO_WATERMARK_MAX);
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
+	const struct device *dev = regmap_get_device(st->map);
+	unsigned int wm_gyro, wm_accel, watermark;
+	u32 latency_gyro, latency_accel, latency;
+	u32 period_gyro, period_accel;
+	size_t packet_size, wm_size;
+	__le16 raw_wm;
+	bool restore;
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
+		watermark = max(watermark, 1);
+		/* update effective watermark */
+		st->fifo.watermark.eff_gyro = max(latency / period_gyro, 1);
+		st->fifo.watermark.eff_accel = max(latency / period_accel, 1);
+	}
+
+	/* changing FIFO watermark requires to turn off watermark interrupt */
+	ret = regmap_update_bits_check(st->map, INV_ICM42607_REG_INT_SOURCE0,
+				       INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
+				       0, &restore);
+	if (ret)
+		return ret;
+
+	/* compute watermark value in bytes */
+	wm_size = watermark * packet_size;
+	raw_wm = INV_ICM42607_FIFO_WATERMARK_VAL(wm_size);
+	memcpy(st->buffer, &raw_wm, sizeof(raw_wm));
+	ret = regmap_bulk_write(st->map, INV_ICM42607_REG_FIFO_CONFIG2,
+				st->buffer, sizeof(raw_wm));
+	if (ret) {
+		dev_err(dev, "Unable to change watermark value: %d\n", ret);
+		if (restore)
+			regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
+					   INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
+					   INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);
+		return ret;
+	}
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
+	struct inv_icm42607_sensor_state *sensor_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &sensor_st->ts;
+	struct device *dev = regmap_get_device(st->map);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
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
+	ret = regmap_set_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
+			      INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);
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
+	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_FIFO_COUNTH,
+			       st->buffer, sizeof(__be16));
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
+	/*
+	 * FIFO should only be 1 at this point, so explicitly set it to 0
+	 * instead of decrementing it.
+	 */
+	st->fifo.on = 0;
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
+	const void *accel, *gyro, *timestamp;
+	size_t i, max_count;
+	const s8 *temp;
+	ssize_t size;
+	int ret;
+
+	guard(mutex)(&st->lock);
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
+		max_count = min((max * inv_icm42607_get_packet_size(st->fifo.en)),
+				sizeof(st->fifo.data));
+
+	/* read FIFO count value */
+	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_FIFO_COUNTH,
+			       st->buffer, sizeof(u8) * 2);
+	if (ret)
+		return ret;
+	st->fifo.count = be16_to_cpup(st->buffer);
+
+	/* check and clamp FIFO count value */
+	if (st->fifo.count == 0)
+		return 0;
+
+	st->fifo.count = min(st->fifo.count, max_count);
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
+				&accel, &gyro, &temp, &timestamp);
+		/* Make sure the size is at least 1 valid packet. */
+		if (size < INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE)
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
+	int ret;
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
index 000000000000..b77deb66f8bd
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#ifndef INV_ICM42607_BUFFER_H_
+#define INV_ICM42607_BUFFER_H_
+
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
+static inline bool
+inv_icm42607_fifo_is_data_valid(const struct inv_icm42607_fifo_sensor_data *s)
+{
+	s16 x, y, z;
+
+	x = be16_to_cpu(s->x);
+	y = be16_to_cpu(s->y);
+	z = be16_to_cpu(s->z);
+
+	if (x == INV_ICM42607_FIFO_DATA_INVALID &&
+	    y == INV_ICM42607_FIFO_DATA_INVALID &&
+	    z == INV_ICM42607_FIFO_DATA_INVALID)
+		return false;
+
+	return true;
+}
+
+ssize_t inv_icm42607_fifo_decode_packet(const void *packet, const void **accel,
+					const void **gyro, const s8 **temp,
+					const void **timestamp);
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
+int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
+				     unsigned int count);
+
+#endif
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index e27ad0319a12..d5885fc3f7da 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -15,6 +15,7 @@
 #include <linux/regulator/consumer.h>
 
 #include "inv_icm42607.h"
+#include "inv_icm42607_buffer.h"
 
 static bool inv_icm42607_is_volatile_reg(struct device *dev, unsigned int reg)
 {
@@ -73,6 +74,40 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
 
+u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr)
+{
+	static const u32 odr_periods[INV_ICM42607_ODR_NB] = {
+		/* Reserved values */
+		0, 0, 0, 0, 0,
+		/* 1600Hz */
+		625000,
+		/* 800Hz */
+		1250000,
+		/* 400Hz */
+		2500000,
+		/* 200Hz */
+		5000000,
+		/* 100 Hz */
+		10000000,
+		/* 50Hz */
+		20000000,
+		/* 25Hz */
+		40000000,
+		/* 12.5Hz */
+		80000000,
+		/* 6.25Hz */
+		160000000,
+		/* 3.125Hz */
+		320000000,
+		/* 1.5625Hz */
+		640000000,
+	};
+
+	odr = clamp(odr, INV_ICM42607_ODR_1600HZ, INV_ICM42607_ODR_1_5625HZ_LP);
+
+	return odr_periods[odr];
+}
+
 static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 				      enum inv_icm42607_sensor_mode gyro,
 				      enum inv_icm42607_sensor_mode accel,
@@ -333,6 +368,11 @@ int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw
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
@@ -354,6 +394,13 @@ static int inv_icm42607_suspend(struct device *dev)
 	if (pm_runtime_suspended(dev))
 		return 0;
 
+	if (st->fifo.on) {
+		ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
+				   INV_ICM42607_FIFO_CONFIG1_BYPASS);
+		if (ret)
+			return ret;
+	}
+
 	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
 					 INV_ICM42607_SENSOR_MODE_OFF,
 					 false, NULL);
@@ -378,7 +425,12 @@ static int inv_icm42607_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	/* Nothing else to restore at this time. */
+	if (st->fifo.on) {
+		ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
+				   INV_ICM42607_FIFO_CONFIG1_MODE);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.43.0

