Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9F83EAC62
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759872; cv=none; b=HWlLW0KHnCS+AwuQ/+8GcY5akd2CHUFdxhPM57D8a76Wrz5Wt4MN7MIeuw6649llE+Tu2Yerj6lYX7SDIx7OGYZ4MewpwpTW+w4oS1m6+AFTHHaf8EP84iT68Z6SU+Z27Zfe2ubg2h44GYIPV48VjhczGBwutG1F2mn6V1FuPJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759872; c=relaxed/simple;
	bh=7djmIHZtBkRcv7htkjXZqeX2umxLe02sXkdmc1bk654=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rA3y1S47po4zFJkN71P8RUC5ZQhSpev7naLKog6Ud4W2KEPrLAPgmpXg4R0joMpA9VA9HSIyk7HhN3GptMR4S1rmmurqI6Us7OLTtPRr9CSpHS3mLPQpCdvnm/MqzukyizwKcubLUbAqKCAucG8NLEKQb6ZM3wv6Fz0IHdEUfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ShxL6HSR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ShxL6HSR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so61574935e9.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773759869; x=1774364669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9Y1ZVb6O9133EguhmkARwym7qmE+zI7GKlFaw+R4F0=;
        b=ShxL6HSRFXMs8438K8p2Zs4pTTa7L0e12XL7mfsgeD0RmU4fDqHbjW2zaZes3Kj0Tn
         1KfKT01rVYHYB6j5yRd91ZCSBYmdCEVo6jGZsPjX0sKtxlyR/HJBEeQY3LCAEeg4rsQR
         +4sVSd3VRsGDAh0ROI7X2tjRvZcEPhz3NfWvXUC/BRpoBc1M0VoPKt645jZSPVbPOQ+s
         4yzztFj2LoUiBBy09dW3C1DKzTw2bU0jW7klFJtCknxBBZrAO47guFyNAUTP+nKH1nC3
         0zk52KeaamsCGWSuGQ/7tobJKnl+c+dB27MbFTOqVFDRWBO1Qw1jgksqfWId0L/IxmJ5
         IEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759869; x=1774364669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U9Y1ZVb6O9133EguhmkARwym7qmE+zI7GKlFaw+R4F0=;
        b=Kytuaykb1bawC5V5VaXEG1xdklX+/f1BGDdslnBMvn1OMqbCZp9m0o9S8uG8lN2p5o
         WnRar9Syv1a5iyrP7Qo4c6Hw2Su7+M+h5PC3g9eXIXyqdgRG5khKYo145arZMQowDnQj
         +H6t/I/V5rjRGmEa30wiUu8bRTje79V06zMipa7GVjN39CyyDBfWSVx04LfaUdijJ533
         4Wr9+nxjq7w+Ug/3y2n9m4nL0I0auG4jcf/Hb9zZ+p1CZzij2NuDwWC66SsW517R9cwS
         ebfh7CuZjJbDdvjt46XjucLgyD9akt8OVbDuB0S6kFIIBfoVEgtTskrRjEoMRJnFdj4h
         +6ew==
X-Forwarded-Encrypted: i=1; AJvYcCVoxDt3Ev080C+DW5/VvwwfN0kltixP0eP4isg/+cQiYkqbJtYRlrXCMTbc4GvkHrRgQsH45o9SVdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywim8dhebmNOoyWOmBEjJzjCZq5FOVtaxqMT/o3iUg8ejeuLUMC
	WWJkyxkliQRPlz2evY8Y+yV3HBXDQncZOzXNbSGpuLrDGX9cC91EaPXIWGMX+nP2Zjk=
X-Gm-Gg: ATEYQzzI2lZD5Pg5Yzf/RATk31gEzZioOwqCTgYdphqVL4l+b8FPNj9zWtLTsFLVftH
	nrk4BBa0gYcHI3OBNwiQrQpT8EY/F8918zsqBGZyjA2Zx+AlbDxtYh/GrDkA1z+1Z46/7NF43qW
	unWyhWeQrJaHnE5XO1+wRZoRgVLg2zN1Sf4tibDtGsRASaCwq2wx8gebgSxPj3Yn4BkT1jA7EA/
	NRQHMS/7Dj1mH4TWmvZuYf1il971MEHY5KCB+99bsCOzJw8v5uX0LIyXaN2+6kl3aOoEa3UzG0r
	J0tryyKA6vy+6GxRAe7GlNK7YeFEGI25jm5FfmWft1T8vjKjE0H7Ab2k4kTO1867JvKsu4v2Bpz
	2vDm0kqGS3Di2RRRi2ygiK5Xny+lb9pO/WnmIYF4usps+9VW1lU1R20JGMmaML7guVpVLNw==
X-Received: by 2002:a05:600c:3f1a:b0:485:481c:e7bb with SMTP id 5b1f17b1804b1-4855670289cmr262580915e9.20.1773759868514;
        Tue, 17 Mar 2026 08:04:28 -0700 (PDT)
Received: from localhost ([151.37.101.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaee04fsm73040235e9.13.2026.03.17.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:04:28 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v8 6/6] iio: imu: st_lsm6dsx: Add support for rotation sensor
Date: Tue, 17 Mar 2026 16:04:26 +0100
Message-Id: <20260317150427.3878450-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260317150316.3878107-1-flavra@baylibre.com>
References: <20260317150316.3878107-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14914; i=flavra@baylibre.com; h=from:subject; bh=7djmIHZtBkRcv7htkjXZqeX2umxLe02sXkdmc1bk654=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpuW16zKetJw0Bnd9G/PEUQ3zaRJ/Mm649i7ERF 4cHOOlBQdWJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCabltegAKCRDt8TtzzpQ2 X8JWC/4v8zBQ03n9AnuKFQfIFCFQX6fQhLlWF6S2tSf5mpCJirgNO1vCvMInjyPZ9KyCJR2bqLa eLIW1tAw+Sgj2F5bm7AOhi+ZYFd9P5v16PbbhNRws+RochiObumOHyqRBqjY0+fbfO2nJ7Of0qH vr/8i/qHDKUfCrbE5bc87GoAeOcBgCMhsO6RxQRTZf8Qjz3skzAIGukzlkxW2aEUFFWR3hvvmng 7+DI9B/eyEDdAIUyqXjNjmjAsR6psY+b7pdIniAxk0vTy7ycdRNICK0oIs3e7mmLjI8UhvN22VQ E4RbGiM27/h13phguOX5l254EAudIyUD2ZgbkbZDDAi5bkEHVod0Llwdi0p0usIB1Rppx+8YZKS omm7CYH+JPgpNwdwhuICPGZeykN3ULRdy8lYJvZ7Ha3PDRku6PCxsARmryE551ISxNgCJm/Z/D6 wnFtxm0zv9PrUrU5acRkrtZlhAmr84llBbIOwmHf4/9qca3s1+ScXX4rQ0c4buR64MeOk=
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
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 235 ++++++++++++++++++
 5 files changed, 325 insertions(+), 7 deletions(-)
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
index 19232146bd61..d5935106a373 100644
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
@@ -586,6 +590,9 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
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
index 450cb5b47346..160cc6551853 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -94,6 +94,26 @@
 
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
 
+/* Raw values from the IMU are 16-bit half-precision floating-point numbers. */
+#define ST_LSM6DSX_CHANNEL_ROT						\
+{									\
+	.type = IIO_ROT,						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_QUATERNION_AXIS,				\
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
index 000000000000..74a2cc5cab12
--- /dev/null
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics st_lsm6dsx IMU sensor fusion
+ *
+ * Copyright 2026 BayLibre, SAS
+ */
+
+#include <linux/cleanup.h>
+#include <linux/errno.h>
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
+		err = st_lsm6dsx_fusion_get_odr_val(settings, odr_mHz, &odr_val);
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

