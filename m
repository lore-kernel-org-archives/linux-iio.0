Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F678381B1F
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611638; cv=none; b=LFAZOHpLf/VuAABcaOv77ZPyi2WxvkfuKXDMyRsTwG5sgnGQsKsZ+ZqNvrWgcUB3qqi5t12eqwvNj0UjQctAstdqR1rFBqNWKU/+9ed+yPVtlEsFYHfK5zLC3UUj71TZs8EtJQAA5aCRpVWLd5RCQkkQGI5gnZtFMiUFgxzEoQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611638; c=relaxed/simple;
	bh=vq9hgjVkw2IyLSqx6GRLPbeo5mI6UrCm37fIG5RQhm8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ah/pkeDM2sEuNuKCoU0iK7EwfbihxtwYINC9tM6K7I6iFtWixsddfzfB9v5U4HUyWgYZPnERrZZKO9bSYn8nNNVNxbCwSNJuyZk411iWjrRqhwiBvpml9y5ECDpOQeW7MNOw0UVivN+jQ/y1PY0KlUbW1N2srnL3EtonwfxRCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c9rvcz3j; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c9rvcz3j"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439baf33150so2122268f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 00:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772611634; x=1773216434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UT6cdOv3Men3B4zGxXHfbrc8cEBi1PBjJmQzjY2m3Xk=;
        b=c9rvcz3jwp7h2R8Ef1bNLd//JXIe5cgEqNDF4/w8GoeHkvyonny+PoczDnn26n3O40
         H2XHxUoTyVli7jdh+DWnR4hVH720++Fy+UwBxOYH5U4yEOQlMhSP9NeCz0JpwNe8D3MB
         sIyt6+C/w9WuSQ4hu75oJAYo1hHOLV2AobGZqoe18S5xcMg90UI7hSXCoToN02jJHkTj
         7vrjZG9vG+yflQVAxLZzZGWc5R+130c7Xg92lJr3aF/XKvS5cbGvvRNcolh+Ek0GIvQD
         pUAF1B2zgKlDhDyX2py4IaaamX4eI7+DyL3AgO5G+IT2MO14hCS7pWrJAa7pV78yShFP
         e4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611634; x=1773216434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UT6cdOv3Men3B4zGxXHfbrc8cEBi1PBjJmQzjY2m3Xk=;
        b=oAQ6GKMSLZepZ4HVdpR7kTFTpQcXd8FA7oOa59T5cZBmt6WSnvVWEJbDKH3LSCW7gd
         wlmoE4u2qzM0ZlGU26hP6CeR/dWAMsVrutMI43uY3o+uACJuMlc1w6z/dxUweLWz/9Kl
         56Scfmuw+oHRceDnMDCyOSFNaL39E0biu3S4PPlwOdVyuzaGjW8c0hfZi6NChfe5i8gi
         Ytjc0AD3ECU62zXQlY26kDquCD7l0bMpfSmapJW579i/BF75UnwjcN2X+69DYi+IP3T6
         ekj9izYwnuCWJtf2jWF4o/ndZt+FZB35eURjJV9OzGCQhc0wvMkH4z/9KS6mpGGTnB7b
         lyCw==
X-Forwarded-Encrypted: i=1; AJvYcCVTNGglLcSTLwfiVF/GIv5hFBMIpFrFcJMTvpoOw0QVEvyGQDvSGv0pBdFp//wbWrNKilML4SlYolc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9PW9uzHE6K35ZAZTRhSoRUGY6/CtJ7XknWUsgQSmmJS1WWlM
	s1qBxzoWkXSEXM44/JHaRS1aYo8ift63udtTlhpOsvyRaoeX08UXoao2kA6XH9B3Ma8=
X-Gm-Gg: ATEYQzzxgU1fyLmW4IR4qQkMP8tl80SblhryC5tHih+wZ+k/uLTxEu1oOdt+xemRwaK
	7A5/8vlLfA0oBm0P6ix3DAOvOVLdac5K9wiRV/258wymZnYbP2hwEqElTGpmpbmt/bWjv2rggHJ
	7Wa4IwbNcIItknVevP7haz4ZxVvFkvHfWCKLqjomkdHj5wdBaQMIU++alR1pU3gC3+0dRcqY2xz
	PKCGaMjTCScWcgQ1nFA6SE1m7OzMuDq3ATJsmk72sXUJWKE1NwIAICeIxQLHwBYv/QZ3g9sp0Lg
	G0Nm4hqdzL4q7M2rZKUzB1h11m1SO0NWFquQmXKIROmeYM1eOZNDmeqkZBwi2arphUcAPqBa0ip
	aFGijPBSYluxQqX54uTfcjQD7Zxm/x1w+lau44LopwKolgA6F7mY24aDyeEiTIYqzeDwL
X-Received: by 2002:a05:6000:2912:b0:439:c39e:d9ed with SMTP id ffacd0b85a97d-439c8a8e098mr1453492f8f.17.1772611633678;
        Wed, 04 Mar 2026 00:07:13 -0800 (PST)
Received: from localhost ([151.19.177.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60e40fsm40367359f8f.7.2026.03.04.00.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:07:13 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v7 6/6] iio: imu: st_lsm6dsx: Add support for rotation sensor
Date: Wed,  4 Mar 2026 09:07:11 +0100
Message-Id: <20260304080712.2844514-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260304080519.2844101-1-flavra@baylibre.com>
References: <20260304080519.2844101-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14873; i=flavra@baylibre.com; h=from:subject; bh=vq9hgjVkw2IyLSqx6GRLPbeo5mI6UrCm37fIG5RQhm8=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpp+gv9l7zZLzZav5eJOxXnTSHPrcEbvtcEZVPW O4XQG8Ont6JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaafoLwAKCRDt8TtzzpQ2 Xy7aC/wI8cdvSbN0E9LbiZH9w03uP6LuP8oiFhmlAc7w0vPeZIEL27D7BGK6wOMb0uq7Jp3CD0P Oa1Il7nKukR85F6PGIjDOO8NhRC4O66t+98VBwUB0qqATxY0caVsAilIGAeUkSOG5Ne/fpzVu3P Pb1qI942Y8A6tgxuHc4IUoKv/tKQuIGXmtssTx8a10Jz9noNMg871/MtmgATNBphvmzzuYeCAvb p1z+sOyR7JpDyZusnePvvlTrh9CwmURwbaHA82ZWu3hNp/I1m5YDv3nLGVXY4WwEX/zadm+CAxb bbqf2Ri1J2KKMwzA1QhBIN/iqp43fpBrT1S3JprIEdysrmnjm72X5yJFzmhAo2chbubdj4AJidk jLT/izZv6ELK1/SS2pnbAlTCdoPxPP1DY9MJhzKlsRGFQB5159BhYxn8TARkddkxEDBOfozEqh7 P4GjKac8W+8QWPasPHUBTB7Z2aka+bNylx1fICButxwz5lyHdI+u020O1i32Hpo7IrYK0=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

Some IMU chips in the LSM6DSX family have sensor fusion features that
combine data from the accelerometer and gyroscope. One of these features
generates rotation vector data and makes it available in the hardware
FIFO as a quaternion (more specifically, the X, Y and Z components of the
quaternion vector, expressed as 16-bit half-precision floating-point
numbers).

Add support for a new sensor instance that allows receiving sensor fusion
data, by defining a new struct st_lsm6dsx_fusion_settings (which contains
chip-specific details for the sensor fusion functionality), and adding this
struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
logic to initialize an additional IIO device if this struct is populated
for the hardware type being probed.
Note: a new IIO device is being defined (as opposed to adding channels to
an existing device) because the rate at which sensor fusion data is
generated may not match the data rate from any of the existing devices.

Tested on LSMDSV16X.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  28 ++-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   9 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 234 ++++++++++++++++++
 5 files changed, 324 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm6dsx/Makefile
index 57cbcd67d64f..19a488254de3 100644
--- a/drivers/iio/imu/st_lsm6dsx/Makefile
+++ b/drivers/iio/imu/st_lsm6dsx/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 st_lsm6dsx-y := st_lsm6dsx_core.o st_lsm6dsx_buffer.o \
-		st_lsm6dsx_shub.o
+		st_lsm6dsx_shub.o st_lsm6dsx_fusion.o
 
 obj-$(CONFIG_IIO_ST_LSM6DSX) += st_lsm6dsx.o
 obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) += st_lsm6dsx_i2c.o
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 07b1773c87bd..767aadfe7061 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -294,6 +294,7 @@ enum st_lsm6dsx_sensor_id {
 	ST_LSM6DSX_ID_EXT0,
 	ST_LSM6DSX_ID_EXT1,
 	ST_LSM6DSX_ID_EXT2,
+	ST_LSM6DSX_ID_FUSION,
 	ST_LSM6DSX_ID_MAX
 };
 
@@ -301,6 +302,17 @@ enum st_lsm6dsx_ext_sensor_id {
 	ST_LSM6DSX_ID_MAGN,
 };
 
+struct st_lsm6dsx_fusion_settings {
+	const struct iio_chan_spec *chan;
+	int chan_len;
+	struct st_lsm6dsx_reg odr_reg;
+	int odr_hz[ST_LSM6DSX_ODR_LIST_SIZE];
+	int odr_len;
+	struct st_lsm6dsx_reg fifo_enable;
+	struct st_lsm6dsx_reg page_mux;
+	struct st_lsm6dsx_reg enable;
+};
+
 /**
  * struct st_lsm6dsx_ext_dev_settings - i2c controller slave settings
  * @i2c_addr: I2c slave address list.
@@ -388,6 +400,7 @@ struct st_lsm6dsx_settings {
 	struct st_lsm6dsx_hw_ts_settings ts_settings;
 	struct st_lsm6dsx_shub_settings shub_settings;
 	struct st_lsm6dsx_event_settings event_settings;
+	struct st_lsm6dsx_fusion_settings fusion_settings;
 };
 
 enum st_lsm6dsx_fifo_mode {
@@ -510,6 +523,9 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val);
 int st_lsm6dsx_shub_probe(struct st_lsm6dsx_hw *hw, const char *name);
 int st_lsm6dsx_shub_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable);
 int st_lsm6dsx_shub_read_output(struct st_lsm6dsx_hw *hw, u8 *data, int len);
+int st_lsm6dsx_fusion_probe(struct st_lsm6dsx_hw *hw, const char *name);
+int st_lsm6dsx_fusion_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable);
+int st_lsm6dsx_fusion_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable);
 int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable);
 
 static inline int
@@ -564,12 +580,14 @@ st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
 static inline int
 st_lsm6dsx_device_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
 {
-	if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
-	    sensor->id == ST_LSM6DSX_ID_EXT1 ||
-	    sensor->id == ST_LSM6DSX_ID_EXT2)
+	switch (sensor->id) {
+	case ST_LSM6DSX_ID_EXT0 ... ST_LSM6DSX_ID_EXT2:
 		return st_lsm6dsx_shub_set_enable(sensor, enable);
-
-	return st_lsm6dsx_sensor_set_enable(sensor, enable);
+	case ST_LSM6DSX_ID_FUSION:
+		return st_lsm6dsx_fusion_set_enable(sensor, enable);
+	default:
+		return st_lsm6dsx_sensor_set_enable(sensor, enable);
+	}
 }
 
 static const
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index a6ee2da5a06c..67f2ba0ff642 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -88,6 +88,7 @@ enum st_lsm6dsx_fifo_tag {
 	ST_LSM6DSX_EXT0_TAG = 0x0f,
 	ST_LSM6DSX_EXT1_TAG = 0x10,
 	ST_LSM6DSX_EXT2_TAG = 0x11,
+	ST_LSM6DSX_ROT_TAG = 0x13,
 };
 
 static const
@@ -226,8 +227,11 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 	u8 data;
 
 	/* Only internal sensors have a FIFO ODR configuration register. */
-	if (sensor->id >= ARRAY_SIZE(hw->settings->batch))
+	if (sensor->id >= ARRAY_SIZE(hw->settings->batch)) {
+		if (sensor->id == ST_LSM6DSX_ID_FUSION)
+			return st_lsm6dsx_fusion_set_odr(sensor, enable);
 		return 0;
+	}
 
 	batch_reg = &hw->settings->batch[sensor->id];
 	if (batch_reg->addr) {
@@ -578,6 +582,9 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
 	case ST_LSM6DSX_EXT2_TAG:
 		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
 		break;
+	case ST_LSM6DSX_ROT_TAG:
+		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_FUSION];
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 450cb5b47346..763ac9dfe5b1 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -94,6 +94,26 @@
 
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
 
+/* Raw values from the IMU are 16-bit half-precision floating-point numbers. */
+#define ST_LSM6DSX_CHANNEL_ROT						\
+{									\
+	.type = IIO_ROT,						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_PARTIAL_QUATERNION,				\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.info_mask_shared_by_all_available =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = 0,						\
+	.scan_type = {							\
+		.format = 'f',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+		.repeat = 3,						\
+	},								\
+	.ext_info = st_lsm6dsx_ext_info,				\
+}
+
 static const struct iio_event_spec st_lsm6dsx_ev_motion[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -153,6 +173,11 @@ static const struct iio_chan_spec st_lsm6ds0_gyro_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec st_lsm6dsx_fusion_channels[] = {
+	ST_LSM6DSX_CHANNEL_ROT,
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
 		.reset = {
@@ -1492,6 +1517,33 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				},
 			},
 		},
+		.fusion_settings = {
+			.chan = st_lsm6dsx_fusion_channels,
+			.chan_len = ARRAY_SIZE(st_lsm6dsx_fusion_channels),
+			.odr_reg = {
+				.addr = 0x5e,
+				.mask = GENMASK(5, 3),
+			},
+			.odr_hz[0] = 15,
+			.odr_hz[1] = 30,
+			.odr_hz[2] = 60,
+			.odr_hz[3] = 120,
+			.odr_hz[4] = 240,
+			.odr_hz[5] = 480,
+			.odr_len = 6,
+			.fifo_enable = {
+				.addr = 0x44,
+				.mask = BIT(1),
+			},
+			.page_mux = {
+				.addr = 0x01,
+				.mask = BIT(7),
+			},
+			.enable = {
+				.addr = 0x04,
+				.mask = BIT(1),
+			},
+		},
 	},
 	{
 		.reset = {
@@ -2899,6 +2951,12 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
+	if (hw->settings->fusion_settings.chan) {
+		err = st_lsm6dsx_fusion_probe(hw, name);
+		if (err)
+			return err;
+	}
+
 	if (hw->irq > 0) {
 		err = st_lsm6dsx_irq_setup(hw);
 		if (err < 0)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
new file mode 100644
index 000000000000..38a99ca9bd7b
--- /dev/null
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics st_lsm6dsx IMU sensor fusion
+ *
+ * Copyright 2026 BayLibre, SAS
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/sprintf.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include "st_lsm6dsx.h"
+
+static int
+st_lsm6dsx_fusion_get_odr_val(const struct st_lsm6dsx_fusion_settings *settings,
+			      u32 odr_mHz, u8 *val)
+{
+	int odr_hz = odr_mHz / MILLI;
+	int i;
+
+	for (i = 0; i < settings->odr_len; i++) {
+		if (settings->odr_hz[i] == odr_hz)
+			break;
+	}
+	if (i == settings->odr_len)
+		return -EINVAL;
+
+	*val = i;
+	return 0;
+}
+
+/**
+ * st_lsm6dsx_fusion_page_enable - Enable access to sensor fusion configuration
+ * registers.
+ * @hw: Sensor hardware instance.
+ *
+ * Return: 0 on success, negative value on error.
+ */
+static int st_lsm6dsx_fusion_page_enable(struct st_lsm6dsx_hw *hw)
+{
+	const struct st_lsm6dsx_reg *mux;
+
+	mux = &hw->settings->fusion_settings.page_mux;
+
+	return regmap_set_bits(hw->regmap, mux->addr, mux->mask);
+}
+
+/**
+ * st_lsm6dsx_fusion_page_disable - Disable access to sensor fusion
+ * configuration registers.
+ * @hw: Sensor hardware instance.
+ *
+ * Return: 0 on success, negative value on error.
+ */
+static int st_lsm6dsx_fusion_page_disable(struct st_lsm6dsx_hw *hw)
+{
+	const struct st_lsm6dsx_reg *mux;
+
+	mux = &hw->settings->fusion_settings.page_mux;
+
+	return regmap_clear_bits(hw->regmap, mux->addr, mux->mask);
+}
+
+int st_lsm6dsx_fusion_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
+{
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	const struct st_lsm6dsx_reg *en_reg;
+	int err;
+
+	guard(mutex)(&hw->page_lock);
+
+	en_reg = &hw->settings->fusion_settings.enable;
+	err = st_lsm6dsx_fusion_page_enable(hw);
+	if (err)
+		return err;
+
+	err = regmap_assign_bits(hw->regmap, en_reg->addr, en_reg->mask, enable);
+	if (err) {
+		st_lsm6dsx_fusion_page_disable(hw);
+		return err;
+	}
+
+	return st_lsm6dsx_fusion_page_disable(hw);
+}
+
+int st_lsm6dsx_fusion_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable)
+{
+	const struct st_lsm6dsx_fusion_settings *settings;
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	u8 data;
+	int err;
+
+	guard(mutex)(&hw->page_lock);
+
+	err = st_lsm6dsx_fusion_page_enable(hw);
+	if (err)
+		return err;
+
+	settings = &hw->settings->fusion_settings;
+	if (enable) {
+		const struct st_lsm6dsx_reg *reg = &settings->odr_reg;
+		u8 odr_val;
+
+		st_lsm6dsx_fusion_get_odr_val(settings, sensor->hwfifo_odr_mHz,
+					      &odr_val);
+		data = ST_LSM6DSX_SHIFT_VAL(odr_val, reg->mask);
+		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+					 data);
+		if (err)
+			goto out;
+	}
+
+	err = regmap_assign_bits(hw->regmap, settings->fifo_enable.addr,
+				 settings->fifo_enable.mask, enable);
+	if (err)
+		goto out;
+
+	return st_lsm6dsx_fusion_page_disable(hw);
+
+out:
+	st_lsm6dsx_fusion_page_disable(hw);
+
+	return err;
+}
+
+static int st_lsm6dsx_fusion_read_raw(struct iio_dev *iio_dev,
+				      struct iio_chan_spec const *ch,
+				      int *val, int *val2, long mask)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = sensor->hwfifo_odr_mHz / MILLI;
+		*val2 = (sensor->hwfifo_odr_mHz % MILLI) * (MICRO / MILLI);
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int st_lsm6dsx_fusion_write_raw(struct iio_dev *iio_dev,
+				       struct iio_chan_spec const *chan,
+				       int val, int val2, long mask)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+	const struct st_lsm6dsx_fusion_settings *settings;
+	int err;
+
+	settings = &sensor->hw->settings->fusion_settings;
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		u32 odr_mHz = val * MILLI + val2 * (MILLI / MICRO);
+		u8 odr_val;
+
+		/* check that the requested frequency is supported */
+		err = st_lsm6dsx_fusion_get_odr_val(settings, odr_mHz,
+						    &odr_val);
+		if (err)
+			return err;
+
+		sensor->hwfifo_odr_mHz = odr_mHz;
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int st_lsm6dsx_fusion_read_avail(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					const int **vals, int *type,
+					int *length, long mask)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(indio_dev);
+	const struct st_lsm6dsx_fusion_settings *settings;
+
+	settings = &sensor->hw->settings->fusion_settings;
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = settings->odr_hz;
+		*type = IIO_VAL_INT;
+		*length = settings->odr_len;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info st_lsm6dsx_fusion_info = {
+	.read_raw = st_lsm6dsx_fusion_read_raw,
+	.read_avail = st_lsm6dsx_fusion_read_avail,
+	.write_raw = st_lsm6dsx_fusion_write_raw,
+	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
+};
+
+int st_lsm6dsx_fusion_probe(struct st_lsm6dsx_hw *hw, const char *name)
+{
+	const struct st_lsm6dsx_fusion_settings *settings;
+	struct st_lsm6dsx_sensor *sensor;
+	struct iio_dev *iio_dev;
+	int ret;
+
+	iio_dev = devm_iio_device_alloc(hw->dev, sizeof(*sensor));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	settings = &hw->settings->fusion_settings;
+	sensor = iio_priv(iio_dev);
+	sensor->id = ST_LSM6DSX_ID_FUSION;
+	sensor->hw = hw;
+	sensor->hwfifo_odr_mHz = settings->odr_hz[0] * MILLI;
+	sensor->watermark = 1;
+	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->info = &st_lsm6dsx_fusion_info;
+	iio_dev->channels = settings->chan;
+	iio_dev->num_channels = settings->chan_len;
+	ret = snprintf(sensor->name, sizeof(sensor->name), "%s_fusion", name);
+	if (ret >= sizeof(sensor->name))
+		return -E2BIG;
+	iio_dev->name = sensor->name;
+
+	/*
+	 *  Put the IIO device pointer in the iio_devs array so that the caller
+	 *  can set up a buffer and register this IIO device.
+	 */
+	hw->iio_devs[ST_LSM6DSX_ID_FUSION] = iio_dev;
+
+	return 0;
+}
-- 
2.39.5

