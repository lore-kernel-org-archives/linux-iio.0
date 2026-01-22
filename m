Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE84E3E4E84
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099035; cv=none; b=dVBuf3m8RDKWlYT+fQF+oHCAfK4PXdBd9FC7N8s6xZyDCjGMkf/WUYw+Vd1Zwd7hskX7bBRXlfUcfxgmG4Yd4VSzqVvkfFj1ZW8DUCMIYnqZdPe7ASSNGfV9o7g+DXwXOjXEWatcK1bRU4lTjbhK7NQyhKP7tWWBHjO3D1aOG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099035; c=relaxed/simple;
	bh=gYcpQHVgQnLOgJGtrdVMiTkl/cFBGJOufvAWWbB2Pes=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GPpEC/DTD3NDhhGdSTS1FLEZw5KsI4gDR8oEV3SjT7xUUK8pyybvheN4kbquyaQ7EyjDaq7QM0MnG/gOVJN434T8tjHfSXLkc5Iy5o0Aq4tMgu+wGImturVH9GstHlQqdRpfRZyAZ+SzWhPGw7Z/LHHNyiE1v/leDvWjCMUFCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IVGS6sR1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IVGS6sR1"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43284ed32a0so818363f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 08:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769099022; x=1769703822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1y3j9Rai6zK10EQ6cwCgVv+aGfsaXgppGmnGw7PuFrM=;
        b=IVGS6sR1ewlE/EcvgWO2HY0EKtlfS6tB/u+2i8t1tcuDAhqLbhWt6TB8VoQVLATv0O
         9mIdtUyRCdJPhv563VPOzagPXrCWr9fsPzsYIsk6J+tKRfn1dqOWDZ+CqiKbBu+vnwl4
         pUb5duVBRmV1186e0LiWaidG3pEeBNLhirARpjO3Z4IKu8NJOjPE+QzVgjD3U2ARCAgY
         wksInSYyhrFElo+xU2Kjhb2a8qEDQ6IhY22RZUcZdzRnVz627uFUAVVygpeOic4HumhS
         uzSbPwcA22KfKmJ4pJgcULWAuyIFG0ODEaH/svjOcKuqswvFJyQsk0/Juyd1FpiXeqxF
         /QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099022; x=1769703822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1y3j9Rai6zK10EQ6cwCgVv+aGfsaXgppGmnGw7PuFrM=;
        b=JeHnPp1upnCFNHzbX7QN4S5aGv7r8a+QffjPP2Jt7nnzI9ykSRvWZYHv2Ja2o6HjfC
         G4l+1ORATubGsofwOIELk2kdpJTCFQ7mP2OO+I8xz7J58diiQFuCz+765chd9HoLGVny
         tVKofnFFIyniQcF8rq+eiqs4300m+Cyw9vbiEpf+tz0irTtVC61YcZn+lKosA+GgeDB4
         OM0+lhvuvfD0lhWgpIwuqzQxD7QO90OHCVZwufcjhejvnWk28cEkw+5vsEY3OjOFAFx8
         3juAt0XD1KT8tSLVebYOkU7eYc21/4ceWXMs0onn53/kYZYbAsArUo2DHZzi8NxPsh+Z
         lLpw==
X-Forwarded-Encrypted: i=1; AJvYcCUhBPaU5uNhxNx+sZS6u10XZJyJWjgM6nOux+zeklJDlYveRwA05LXA9KD9zfQruIk89hP9NulKdOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUV/93v2AyISiY7+K5fFU5tG0BO8O9OijaRr6iw2LSsCj5btu
	Okz55kF2zm1eVXiSzQXcojk2RR2Nn2yIs8cie6CdrHoQ0CF21t5rOttTdOha1G+lKTI=
X-Gm-Gg: AZuq6aK6+RL7PNjWVzDl5uFM+3GFseD7Q22RQbP1d8w/rEycDz/FU0gm3Xwfp35eg7m
	8e2YISDEtLsOG+noIyRD7BZ4sfcDbBzxCgJEvvYZMrdr97oLqWlk0mWmKaMpj2wggVepgcTfpgS
	kTw93Ku6KRaYXMASJxta3EemJo5IE1iEBLs9a00pNUtZWrCU7RwZUh17gG2pEwhE8o6H5KZOetr
	MHuUgQXlyO+RQ1lINaxLplZ0Wo7cH/JF//gwQLcmZcGWgyr/bJwxillqf6fqGWGlVFydqTtN0EQ
	W6R4I+TOGpAajO5H+Lx1VT+4giticEw4SIF6rV3zCP1gj11n2auhCKKALHnsgdN3oP/08cY4zll
	lKSX4hr4ra598ic/gY/PhIgSW76CpUclxsPwLJgOH8xLDzr5axHhy4IWLQg==
X-Received: by 2002:a05:6000:208a:b0:431:488:b9b4 with SMTP id ffacd0b85a97d-435b159625amr181049f8f.17.1769099021722;
        Thu, 22 Jan 2026 08:23:41 -0800 (PST)
Received: from localhost ([151.57.192.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435966322a2sm16687710f8f.38.2026.01.22.08.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:23:41 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] iio: imu: st_lsm6dsx: Add support for rotation sensor
Date: Thu, 22 Jan 2026 17:23:35 +0100
Message-Id: <20260122162335.2020006-5-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260122162335.2020006-1-flavra@baylibre.com>
References: <20260122162335.2020006-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15225; i=flavra@baylibre.com; h=from:subject; bh=gYcpQHVgQnLOgJGtrdVMiTkl/cFBGJOufvAWWbB2Pes=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpck7p0Lcu8Mka4mh42gRVUjPN8dEPr1SXLPuXx MlkjShSIOWJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaXJO6QAKCRDt8TtzzpQ2 X0wvDACsA833KE3Gk9v1JR/iMrOrSMuw3QGeHHAKPfbyvGU2dVVeTNZnYHINAuGGDYlAtD4NbBn asyGdYkN+a+SyJ4supZc1vl9rwfbdc4+eWPtQ6e3NjRGRNdUbX9fMs3yzed5BmDTHSvFNrpr7QF aPa3VlRwZAQzr5c7/YvnovHNXVSgWhoWQhT5WTW1/yFeTkQWhWIf6oZf+stHbM2a6D84LGF5Fp/ G9gPTi+6tY32LiTm53bF5lGarK4Oe8Qr1pbCy0WSsgIF36wKemiW+WUMB84Dh/iU0UyreGWlmzY 2VK7HPXr0yMJMR4whfmkbPw7XDEBFaCTBZrU0SfqskFg63B0AWxRri9u4M1Q6jhDqk332H58/0G OMviMfl5pT72cgKK0geJer2dF8NUDpuuEFzE+CeAOlS160dwDXTGL5/naeEipAhaQP9Tefn7MyB IGyrOIlCPBPcADIJvnqYNSbawFBkVmOqk+AP6ugS20nxu+lGQWa6DXQACadUUClqRF5XM=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

Some IMU chips in the LSM6DSX family have sensor fusion features that
combine data from the accelerometer and gyroscope. One of these features
generates rotation vector data and makes it available in the hardware
FIFO as a quaternion (more specifically, the X, Y and Z components of the
quaternion vector, expressed as 16-bit half-precision floating-point
numbers).

Add support for a new sensor instance that allows receiving sensor fusion
data, by defining a new struct st_lsm6dsx_sf_settings (which contains
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
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  26 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  16 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 235 ++++++++++++++++++
 5 files changed, 330 insertions(+), 7 deletions(-)
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
index 07b1773c87bd..4173f670f7af 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -294,6 +294,7 @@ enum st_lsm6dsx_sensor_id {
 	ST_LSM6DSX_ID_EXT0,
 	ST_LSM6DSX_ID_EXT1,
 	ST_LSM6DSX_ID_EXT2,
+	ST_LSM6DSX_ID_SF,
 	ST_LSM6DSX_ID_MAX
 };
 
@@ -301,6 +302,15 @@ enum st_lsm6dsx_ext_sensor_id {
 	ST_LSM6DSX_ID_MAGN,
 };
 
+struct st_lsm6dsx_sf_settings {
+	const struct iio_chan_spec *chan;
+	int chan_len;
+	struct st_lsm6dsx_odr_table_entry odr_table;
+	struct st_lsm6dsx_reg fifo_enable;
+	struct st_lsm6dsx_reg page_mux;
+	struct st_lsm6dsx_reg enable;
+};
+
 /**
  * struct st_lsm6dsx_ext_dev_settings - i2c controller slave settings
  * @i2c_addr: I2c slave address list.
@@ -388,6 +398,7 @@ struct st_lsm6dsx_settings {
 	struct st_lsm6dsx_hw_ts_settings ts_settings;
 	struct st_lsm6dsx_shub_settings shub_settings;
 	struct st_lsm6dsx_event_settings event_settings;
+	struct st_lsm6dsx_sf_settings sf_settings;
 };
 
 enum st_lsm6dsx_fifo_mode {
@@ -510,6 +521,9 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val);
 int st_lsm6dsx_shub_probe(struct st_lsm6dsx_hw *hw, const char *name);
 int st_lsm6dsx_shub_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable);
 int st_lsm6dsx_shub_read_output(struct st_lsm6dsx_hw *hw, u8 *data, int len);
+int st_lsm6dsx_sf_probe(struct st_lsm6dsx_hw *hw, const char *name);
+int st_lsm6dsx_sf_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable);
+int st_lsm6dsx_sf_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable);
 int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable);
 
 static inline int
@@ -564,12 +578,14 @@ st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
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
+	case ST_LSM6DSX_ID_SF:
+		return st_lsm6dsx_sf_set_enable(sensor, enable);
+	default:
+		return st_lsm6dsx_sensor_set_enable(sensor, enable);
+	}
 }
 
 static const
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index ded9a96076e6..3b4fa57bf461 100644
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
+		if (sensor->id == ST_LSM6DSX_ID_SF)
+			return st_lsm6dsx_sf_set_odr(sensor, enable);
 		return 0;
+	}
 
 	batch_reg = &hw->settings->batch[sensor->id];
 	if (batch_reg->addr) {
@@ -580,6 +584,16 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
 	case ST_LSM6DSX_EXT2_TAG:
 		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
 		break;
+	case ST_LSM6DSX_ROT_TAG:
+		/*
+		 * The sensor reports only the {X, Y, Z} elements of the
+		 * quaternion vector; set the W value to 0 (it can be derived
+		 * from the {X, Y, Z} values due to the property that the vector
+		 * is normalized).
+		 */
+		data[ST_LSM6DSX_SAMPLE_SIZE / ST_LSM6DSX_CHAN_SIZE] = 0;
+		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_SF];
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index dc0ae0e488ce..c21163a06a71 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -94,6 +94,24 @@
 
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
 
+/* Raw values from the IMU are 16-bit half-precision floating-point numbers. */
+#define ST_LSM6DSX_CHANNEL_ROT						\
+{									\
+	.type = IIO_ROT,						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_QUATERNION,					\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = 0,						\
+	.scan_type = {							\
+		.sign = 'u',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+		.repeat = 4,						\
+	},								\
+	.ext_info = st_lsm6dsx_ext_info,				\
+}
+
 static const struct iio_event_spec st_lsm6dsx_ev_motion[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -153,6 +171,11 @@ static const struct iio_chan_spec st_lsm6ds0_gyro_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec st_lsm6dsx_sf_channels[] = {
+	ST_LSM6DSX_CHANNEL_ROT,
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
 		.reset = {
@@ -1492,6 +1515,35 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				},
 			},
 		},
+		.sf_settings = {
+			.chan = st_lsm6dsx_sf_channels,
+			.chan_len = ARRAY_SIZE(st_lsm6dsx_sf_channels),
+			.odr_table = {
+				.reg = {
+					.addr = 0x5e,
+					.mask = GENMASK(5, 3),
+				},
+				.odr_avl[0] = {  15000, 0x00 },
+				.odr_avl[1] = {  30000, 0x01 },
+				.odr_avl[2] = {  60000, 0x02 },
+				.odr_avl[3] = { 120000, 0x03 },
+				.odr_avl[4] = { 240000, 0x04 },
+				.odr_avl[5] = { 480000, 0x05 },
+				.odr_len = 6,
+			},
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
 
+	if (hw->settings->sf_settings.chan) {
+		err = st_lsm6dsx_sf_probe(hw, name);
+		if (err)
+			return err;
+	}
+
 	if (hw->irq > 0) {
 		err = st_lsm6dsx_irq_setup(hw);
 		if (err < 0)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
new file mode 100644
index 000000000000..7033aaeba13e
--- /dev/null
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics st_lsm6dsx IMU sensor fusion
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
+st_lsm6dsx_sf_get_odr_val(const struct st_lsm6dsx_sf_settings *settings,
+			  u32 odr, u8 *val)
+{
+	int i;
+
+	for (i = 0; i < settings->odr_table.odr_len; i++) {
+		if (settings->odr_table.odr_avl[i].milli_hz == odr)
+			break;
+	}
+	if (i == settings->odr_table.odr_len)
+		return -EINVAL;
+
+	*val = settings->odr_table.odr_avl[i].val;
+	return 0;
+}
+
+/**
+ * st_lsm6dsx_sf_page_enable - Enable access to sensor fusion configuration
+ * registers.
+ * @hw: Sensor hardware instance.
+ *
+ * Return: 0 on success, negative value on error.
+ */
+static int st_lsm6dsx_sf_page_enable(struct st_lsm6dsx_hw *hw)
+{
+	const struct st_lsm6dsx_reg *mux = &hw->settings->sf_settings.page_mux;
+
+	return regmap_set_bits(hw->regmap, mux->addr, mux->mask);
+}
+
+/**
+ * st_lsm6dsx_sf_page_disable - Disable access to sensor fusion configuration
+ * registers.
+ * @hw: Sensor hardware instance.
+ *
+ * Return: 0 on success, negative value on error.
+ */
+static int st_lsm6dsx_sf_page_disable(struct st_lsm6dsx_hw *hw)
+{
+	const struct st_lsm6dsx_reg *mux = &hw->settings->sf_settings.page_mux;
+
+	return regmap_clear_bits(hw->regmap, mux->addr, mux->mask);
+}
+
+int st_lsm6dsx_sf_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
+{
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	const struct st_lsm6dsx_reg *en_reg;
+	int err;
+
+	guard(mutex)(&hw->page_lock);
+
+	en_reg = &hw->settings->sf_settings.enable;
+	err = st_lsm6dsx_sf_page_enable(hw);
+	if (err)
+		return err;
+
+	err = regmap_assign_bits(hw->regmap, en_reg->addr, en_reg->mask, enable);
+	if (err) {
+		st_lsm6dsx_sf_page_disable(hw);
+		return err;
+	}
+
+	return st_lsm6dsx_sf_page_disable(hw);
+}
+
+int st_lsm6dsx_sf_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable)
+{
+	const struct st_lsm6dsx_sf_settings *settings;
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	u8 data;
+	int err;
+
+	guard(mutex)(&hw->page_lock);
+
+	err = st_lsm6dsx_sf_page_enable(hw);
+	if (err)
+		return err;
+
+	settings = &hw->settings->sf_settings;
+	if (enable) {
+		const struct st_lsm6dsx_reg *reg = &settings->odr_table.reg;
+		u8 odr_val;
+
+		st_lsm6dsx_sf_get_odr_val(settings, sensor->hwfifo_odr_mHz,
+					  &odr_val);
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
+	return st_lsm6dsx_sf_page_disable(hw);
+
+out:
+	st_lsm6dsx_sf_page_disable(hw);
+
+	return err;
+}
+
+static int st_lsm6dsx_sf_read_raw(struct iio_dev *iio_dev,
+				  struct iio_chan_spec const *ch,
+				  int *val, int *val2, long mask)
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
+static int st_lsm6dsx_sf_write_raw(struct iio_dev *iio_dev,
+				   struct iio_chan_spec const *chan,
+				   int val, int val2, long mask)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+	const struct st_lsm6dsx_sf_settings *settings;
+	int err;
+
+	settings = &sensor->hw->settings->sf_settings;
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		u32 odr_mHz = val * MILLI + val2 * (MILLI / MICRO);
+		u8 odr_val;
+
+		/* check that the requested frequency is supported */
+		err = st_lsm6dsx_sf_get_odr_val(settings, odr_mHz, &odr_val);
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
+static ssize_t st_lsm6dsx_sf_sampling_freq_avail(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_to_iio_dev(dev));
+	const struct st_lsm6dsx_sf_settings *settings;
+	int len = 0;
+
+	settings = &sensor->hw->settings->sf_settings;
+	for (unsigned int i = 0; i < settings->odr_table.odr_len; i++) {
+		u32 val = settings->odr_table.odr_avl[i].milli_hz;
+
+		len += sysfs_emit_at(buf, len, "%lu.%03lu ", val / MILLI,
+				     val % MILLI);
+	}
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sf_sampling_freq_avail);
+static struct attribute *st_lsm6dsx_sf_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group st_lsm6dsx_sf_attribute_group = {
+	.attrs = st_lsm6dsx_sf_attributes,
+};
+
+static const struct iio_info st_lsm6dsx_sf_info = {
+	.attrs = &st_lsm6dsx_sf_attribute_group,
+	.read_raw = st_lsm6dsx_sf_read_raw,
+	.write_raw = st_lsm6dsx_sf_write_raw,
+	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
+};
+
+int st_lsm6dsx_sf_probe(struct st_lsm6dsx_hw *hw, const char *name)
+{
+	const struct st_lsm6dsx_sf_settings *settings;
+	struct st_lsm6dsx_sensor *sensor;
+	struct iio_dev *iio_dev;
+
+	iio_dev = devm_iio_device_alloc(hw->dev, sizeof(*sensor));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	settings = &hw->settings->sf_settings;
+	sensor = iio_priv(iio_dev);
+	sensor->id = ST_LSM6DSX_ID_SF;
+	sensor->hw = hw;
+	sensor->hwfifo_odr_mHz = settings->odr_table.odr_avl[0].milli_hz;
+	sensor->watermark = 1;
+	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->info = &st_lsm6dsx_sf_info;
+	iio_dev->channels = settings->chan;
+	iio_dev->num_channels = settings->chan_len;
+	if (snprintf(sensor->name, sizeof(sensor->name), "%s_sf", name) >=
+	    sizeof(sensor->name))
+		return -E2BIG;
+	iio_dev->name = sensor->name;
+
+	/*
+	 *  Put the IIO device pointer in the iio_devs array so that the caller
+	 *  can set up a buffer and register this IIO device.
+	 */
+	hw->iio_devs[ST_LSM6DSX_ID_SF] = iio_dev;
+
+	return 0;
+}
-- 
2.39.5

