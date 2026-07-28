Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE8477296
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279495; cv=none; b=puAoTM3sTF2eQywFXouguEHAirDxRVfE7t4Tnzs69Tc6kr1hG4qqWJXcUufM7PUORGHkmMWfaTc5Y9jhk1W+Me8OmHd/YlWWlzuBRPhfeF3ZEB+qq64K9lGBdMnz14cBt+137xOmHK4YQQofGeLb2hg1jpV7709eKjeRm/ZK46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279495; c=relaxed/simple;
	bh=7u5nfRaEoePPHwCS2EiICdExKY8kTNAu1/9unsTItP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDJB6p2MORN2lISwoSagxtL5JMsqV3W3A/KPZH94Qv1rYUNrbNRpdZv8Fif0TYzt5CqjjSltzl4D1Is2wRNuPgKlgoX1c2aO7CAJQIea4U3unc+mZyFsaY7i8Vn/GfrNBYmwc7NyUDmXxQAmjKrA466/y2fiBPBxbVs+FnXqc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWOEMTNy; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWOEMTNy"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-45837e52d8aso141886fac.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 15:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785279491; x=1785884291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iTMd5o5HUJcrWjDSObBECVdlERAKwedx93RsL6pudJI=;
        b=gWOEMTNy0lBF/0FARS2X4O2AzVn8L3NPl8nwMLwUqbe95Nv1y4WQVKNy+g3Ue53xcE
         V0DoUwzEbh6eVT0cbp+j5Ui/x2ZDrqF3oNKhS7WqN810YgR+FkB+8htaIpG/EFQLboz7
         GAAW0g+ikP3Su/9eNQ+IuynF3f7Ug1S5fW8KuLPFggulJgy895PoCLhHQhoTYa/bYyMg
         0yIGJmY+8O8MjOCxne1VBQdK6D2vKjJvPXbkodiBD/Whc4rI1k9/8C0Yr15miBgqI/4M
         4oztsWdHIbS831iRSsaf23X85vBFbRJlpfAwV91nb0jx6hIwHvEyq/S30EBDeYCvlUb2
         1y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279491; x=1785884291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iTMd5o5HUJcrWjDSObBECVdlERAKwedx93RsL6pudJI=;
        b=UheRJdtxvmFOFRiUwyCqphe+AAMYZVdhumNUdfqwlywBUHBzSSDwh9RfhUJYSCvvKS
         WbkAwRWjZ+Otp4qJfXjPbj+z9qnhgCTOI8XCVSG1c4VIEXO7GOgw6XDng1p7dWp+GeEs
         gdxxzYC8KdM2GeChBkLlsHgc8yZuAG+a/0ocTeSbpL2Dq0SaKkWkQB6MijDJQxtSE9Y9
         AI41dMsj+2TCSUguKIUi5zl2tUQ4/gpz+TKS6gXzdvqpHG6Qd/LppsyR3+ZzhU1pZBUR
         tapEPxIhCLkH/PKK4xDcdCsOmNs0rzE1cxMtQiHZ0mWrj4e9z3eebFQURsQlIPq6b2pl
         1rMw==
X-Gm-Message-State: AOJu0YzmtoDRqJ39RP0yi/w8c8teuHUhVksT/ROTQgB17JS6kIL/U7aa
	+ezZHuUNMdcv0BctG0Bdb/8yZ8n3o0mlkZEj/ffYOBBlBjU2vKN5g/Qlj8M7Tg==
X-Gm-Gg: AR+sD1280E+VyJ2zAwlZ+NScrqCj2xrjdgnWDvOo/dsUIFIi7aYp3jxp9FS++NYFlUw
	LWHMY0HVIvWcsCXOCBKY/MIxMcFgmDWu9ro6eJsr3nNEPrvlkJJNINo6EahuP8ZOO01NQnlPF1I
	NvTqYTWw2ujS4DJmqjqCxOCw3CTI+oTK7eqRuaFF6lRtJBPJe/o/xjzEku0cANq1vrCkcFjMM6H
	wXtY2GQbSNKuq9bqO8Aal10hqRDUvBC5YOrzRYKndQnG6s+8NrOoE433JesAKTD0zJ7OM7rwZRe
	/QknS3/l6p6A3VXFffPQJ3hpOHOb2Fnjmu1WOWKm+xGdF/6Ma/3R1kePQyQeyTze8UCrLf4DtXK
	R1to/HD3S4/TZlWGH2EY0lm3/AhpRiLAk0EbNpINPUtRA1Y1eIrOumgGubqRScPsU+3DISyQXde
	gj8UhKQI/D+ibB1cIPvb4TwBIm4PhZnHtD2BG5VZ1o0RFhl0qouYUjL7lN3xMU0/2LM/fvkbXgN
	KMqEuD1Gv/3EhZH1dg=
X-Received: by 2002:a05:6870:b022:b0:448:558c:d8b3 with SMTP id 586e51a60fabf-4586ce57aa9mr2399746fac.41.1785279491253;
        Tue, 28 Jul 2026 15:58:11 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9162:e42b:cb94:2d55])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4588646ade0sm990277fac.5.2026.07.28.15.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:58:10 -0700 (PDT)
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
Subject: [PATCH V21 6/9] iio: imu: inv_icm42607: Add Accelerometer for icm42607
Date: Tue, 28 Jul 2026 17:55:37 -0500
Message-ID: <20260728225542.174825-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728225542.174825-1-macroalpha82@gmail.com>
References: <20260728225542.174825-1-macroalpha82@gmail.com>
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
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 308 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 232 ++++++++++++-
 4 files changed, 576 insertions(+), 3 deletions(-)
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
index 61927a6c2663..fd3e57ee4f14 100644
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
@@ -125,6 +137,7 @@ struct inv_icm42607_hw {
  *  @hw:		Hardware specific data.
  *  @lock:		lock for serializing multiple registers access.
  *  @map:		regmap pointer.
+ *  @indio_accel:	accelerometer IIO device.
  *  @vddio_supply:	I/O voltage regulator for the chip.
  *  @vddio_en:		I/O voltage status for runtime PM.
  *  @conf:		chip sensors configurations.
@@ -134,12 +147,23 @@ struct inv_icm42607_state {
 	const struct inv_icm42607_hw *hw;
 	struct mutex lock;
 	struct regmap *map;
+	struct iio_dev *indio_accel;
 	struct regulator *vddio_supply;
 	bool vddio_en;
 	struct inv_icm42607_conf conf;
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
@@ -368,12 +392,26 @@ extern const struct inv_icm42607_hw inv_icm42607_hw_data;
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
index 000000000000..f563c7708420
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -0,0 +1,308 @@
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
+	if (i == ARRAY_SIZE(inv_icm42607_accel_odr))
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
+	if (idx == ARRAY_SIZE(inv_icm42607_accel_odr))
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
+	switch (chan->type) {
+	case IIO_ACCEL:
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
+		*vals = (const int *)inv_icm42607_accel_odr[INV_ICM42607_ODR_1600HZ];
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = (ARRAY_SIZE(inv_icm42607_accel_odr) -
+			   INV_ICM42607_ODR_1600HZ) * 2;
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
+
+	accel_st = iio_priv(indio_dev);
+	accel_st->power_mode = INV_ICM42607_SENSOR_MODE_LOW_NOISE;
+	accel_st->filter = INV_ICM42607_FILTER_BW_73HZ;
+
+	indio_dev->name = name;
+	indio_dev->info = &inv_icm42607_accel_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = inv_icm42607_accel_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm42607_accel_channels);
+	iio_device_set_drvdata(indio_dev, st);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return indio_dev;
+}
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index af301bde3f17..68e84597241a 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -19,6 +19,8 @@
 #include <linux/timekeeping.h>
 #include <linux/types.h>
 
+#include <asm/byteorder.h>
+
 #include "inv_icm42607.h"
 
 static bool inv_icm42607_is_readable_reg(struct device *dev, unsigned int reg)
@@ -104,6 +106,49 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
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
+static u32 inv_icm42607_odr_to_period_us(enum inv_icm42607_odr odr)
+{
+	static const u32 odr_periods[INV_ICM42607_ODR_NB] = {
+		/* Reserved values */
+		0, 0, 0, 0, 0,
+		/* 1600Hz */
+		625,
+		/* 800Hz */
+		1250,
+		/* 400Hz */
+		2500,
+		/* 200Hz */
+		5000,
+		/* 100 Hz */
+		10000,
+		/* 50Hz */
+		20000,
+		/* 25Hz */
+		40000,
+		/* 12.5Hz */
+		80000,
+		/* 6.25Hz */
+		160000,
+		/* 3.125Hz */
+		320000,
+		/* 1.5625Hz */
+		640000,
+	};
+
+	odr = clamp(odr, INV_ICM42607_ODR_1600HZ, INV_ICM42607_ODR_1_5625HZ_LP);
+
+	return odr_periods[odr];
+}
+
 int inv_icm42607_get_pwr_mgmt0(struct inv_icm42607_state *st,
 			       enum inv_icm42607_sensor_mode *gyro,
 			       enum inv_icm42607_sensor_mode *accel)
@@ -126,7 +171,7 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 				      enum inv_icm42607_sensor_mode accel)
 {
 	enum inv_icm42607_sensor_mode oldaccel, oldgyro;
-	unsigned int sleepval_us;
+	unsigned int sleepval_us, odr_us;
 	unsigned int val;
 	s64 disable_wait;
 	int ret;
@@ -163,22 +208,30 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 	 * If a state change occurs from off to on, sleep for the startup time
 	 * of the sensor. Since more than one sensor can be transitioned from
 	 * off to on, select the maximum time from each of the sensors changing
-	 * from off to on. The startup time for the temp sensor is considerably
+	 * from off to on. Also account for the time it takes for the first
+	 * sample to be ready by looking up the odr value and adding it to the
+	 * sleep time. The startup time for the temp sensor is considerably
 	 * smaller than the startup time for the other sensors and one or more
 	 * are required to be on for the temp sensor to function, so any start
 	 * delay should be enough.
 	 */
 	sleepval_us = 0;
-	if (accel && !oldaccel)
+	odr_us = 0;
+	if (accel && !oldaccel) {
 		sleepval_us = max(sleepval_us, INV_ICM42607_ACCEL_STARTUP_TIME_US);
+		odr_us = max(odr_us, inv_icm42607_odr_to_period_us(st->conf.accel.odr));
+	}
 
 	if (gyro && !oldgyro) {
 		sleepval_us = max(sleepval_us, INV_ICM42607_GYRO_STARTUP_TIME_US);
+		odr_us = max(odr_us, inv_icm42607_odr_to_period_us(st->conf.gyro.odr));
 		/* Track the earliest we can turn off the gyroscope. */
 		st->conf.gyro_stop = ktime_add_us(ktime_get(),
 						  INV_ICM42607_GYRO_STOP_TIME_US);
 	}
 
+	sleepval_us += odr_us;
+
 	/*
 	 * Only sleep if sleepval_us is greater than 0 in case some platforms
 	 * have issues with a 0 delay. The 0 delay can happen if one or both
@@ -190,6 +243,174 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
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
+	*config0 = (conf->fs != oldconf->fs) || (conf->odr != oldconf->odr);
+
+	*config1 = (conf->filter != oldconf->filter);
+}
+
+int inv_icm42607_set_sensor_conf(struct inv_icm42607_state *st,
+				 struct inv_icm42607_sensor_conf *conf,
+				 enum iio_chan_type chan_type)
+{
+	enum inv_icm42607_sensor_mode accel_mode, gyro_mode;
+	struct inv_icm42607_sensor_conf *oldconf;
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
+	oldconf->mode = conf->mode;
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
+	__be16 data;
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
+	ret = regmap_bulk_read(st->map, reg, &data, sizeof(data));
+	if (ret)
+		return ret;
+
+	*val = be16_to_cpu(data);
+	if (*val == INV_ICM42607_DATA_INVALID)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int inv_icm42607_set_init_conf(struct inv_icm42607_state *st,
 				      const struct inv_icm42607_conf *conf)
 {
@@ -409,6 +630,11 @@ int inv_icm42607_core_probe(struct regmap *regmap,
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

