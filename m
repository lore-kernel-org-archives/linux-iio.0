Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6093D8113
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342093; cv=none; b=pSxDjKEDtL4CA0BUa5tym+MfNOhDBNQCH9G5Y/BdVbE+NQ7h/tvAI3lkje0BE9Bt2zQLJLE0ZHo77AGkoVDDGqMU+38f7VOmC2+0XBFUIc6o/9zftbHSq5NejM3A53fRY+TXuJKnB6iIo2HMFPNIiBd2VaVfmqRX29JLZLF/dd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342093; c=relaxed/simple;
	bh=M1bR74SI0tPTaMhcE4VEei67wFggtRphkmaDhDzfPG4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqbxhkcCGMcm0New5C3tT3pyos0CidmSXlWpnaEs98ec7ypjcCp+Rq6Bl88UtyvxEgi5NzcUDliiFcbeoi7cceipjYOe5w25zIaHZJtZlfN/L6BlYmEDN6xrU7ppTBAYZMNxaPNwrhAnHXIvfGDGHgbOjrea20leCox+g0Wq4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uKWVMSYb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uKWVMSYb"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b94a19fdso3413849f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774342089; x=1774946889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Hd4/1E+XbufIZzEkLmBvSNQOVRMbBwqb3I3G56EJbg=;
        b=uKWVMSYbdZTj+1irmUO3gFhc/WP2SdvtdQnwwM3SAxfar9q0/SmVFGBL59usHqBMYu
         ZOLk5tWyYjgGA6xC2r7vr+W9tsAi3Ln4DzhEPWguNRt/kbYzhGessUZ5FL738+emil62
         EOpK18b96j3DKcb9e9ARAJVPQ2cdAFySWW9NzmLLAnf6Eoi+tK/q+P+/upEaouGPti8j
         EDAn3qt9c80zNVaZcZh/F57wMuepMIy6rMocDD/+5/CWeWWnQbTMh6vLVfsXTgr5/NdQ
         wm9rzLaTC4VmY0W1xsG2p29WbOECcDMg56viIBdVsz3q9tcMYmideSQNhNDbamykkPiq
         L6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342089; x=1774946889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Hd4/1E+XbufIZzEkLmBvSNQOVRMbBwqb3I3G56EJbg=;
        b=YMgRWPoKn7dL89IDkNCWoj/oMDpqzIHFym8SXpoUn4sTEWeWJOMLldVph5OfPca9fe
         QYvMCntDXp2jAjFjcwMu9bJSuEDNeXfO/ySACD1zJciob9wkeP6B71WeCuvxxMoTcWSs
         jjm7ulCHM/FgscSy0x+F+fnFuiNPIRaWcuAbj+MiM1SKocCQzmasx8Qy2flc1cPXihok
         ZwZ1GniXmvLE2nGnezc/PlqIBO9bq/POfy9PuErSMBNUdLstPHySU8d+G40XQcexOH6h
         a0xCsXL0NbrgLe0Pbk4Dy2X7z7tYiJREwMw4M3brZpwsJ1tbXUWozsOuFpK1HRZ+EAdL
         mIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbkwUJqSYw5fQoR+OEZWJb1tAiGlbCgTGBji9RnBoyyy7P4Q6RKoYJWxs152unf31KyXnvbATHGY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Wwesb2RjEAlAb9UcdjTdNBC6TqYxH78cCBFw5gOB0DenbFmu
	qW6zHhYM5Cxt9wmaSV1mxuotDQr7jxl4nfzopQiPjmZGyts43HujpC6RVzJSPqJhkDxRJQtgWXk
	sYkTsvgA=
X-Gm-Gg: ATEYQzzM3RyQozjIusYIBJSCbY1Vj4jrakT0ww/KSYQZAHkGn9HrwogYClnHww5B7cr
	XvTMApEjQKFFZ0E/ZSza8EcvbAKICc1CAecgZihvr7ABspHqxvCMygEM1/r+m3wDs6XHQDPQicQ
	CsEJW1ixOuUZgRVAS8uVkX1vHYMa4V/GmMLITfWOCm0A9onctQaVkcwZX3+FN3dJxl0A2CLB+l3
	0TBS+LzoQCKB7W+TyR2Rz5F/5Ngd8kg5Rmgm9+V0rHwLgeC+3kIfkOOvNAwW2/Ja7T5kAdveLa2
	6R4juscsVMcgfHHZor2TPsop0qD4iCXgmAwtDrTIeZWTuNzYodyPT7PQnncyjkdXWCU5rkXOcYl
	FHqeJAzHL7+otf2VY4ApI1X6uLjX8sUgoRPG4kJbYd561Fyu5WhI6t62FP6+14TcH0wE=
X-Received: by 2002:a05:6000:608:b0:43b:436d:781b with SMTP id ffacd0b85a97d-43b64270a9amr22082536f8f.40.1774342089335;
        Tue, 24 Mar 2026 01:48:09 -0700 (PDT)
Received: from localhost ([151.43.230.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm36761005f8f.8.2026.03.24.01.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:48:09 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v9 6/6] iio: imu: st_lsm6dsx: Add support for rotation sensor
Date: Tue, 24 Mar 2026 09:48:07 +0100
Message-Id: <20260324084808.654118-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260324084655.653781-1-flavra@baylibre.com>
References: <20260324084655.653781-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15155; i=flavra@baylibre.com; h=from:subject; bh=M1bR74SI0tPTaMhcE4VEei67wFggtRphkmaDhDzfPG4=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpwk/HMAsJ2gfTF3gpX6MPW8rgNZenxrT3ZNQOE M6V9WzNFk+JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCacJPxwAKCRDt8TtzzpQ2 X+C/DACE2rA47CuZVHL4L4T/agSifz+mrBuwbRbp25Q2sBYXIHQViQlViVC5V5CAHM6oAsHtneC ysb/H/aiHdtKeqzjPJsz3stNXqDpmn/xaq5zwqeCb9ntzhBF/l40y2juaVkW6Oxsqfv5YYeF+LH UEthpaMr5L4gkM87EOQrHu3fxsvo2rNq6tgFOJ4eNQcPI3FYetgbDSsWya/VluQYUbnDfMkKtAI Eb0WgME5XEpbG8+NfcBRAQmSTVRw19aJr7LqmZVTF7Yqov1Qsr+pqkeb5vHcb2g5uzcOeepnvm8 GVmBhihOYkC57wtdWU3Ab8ZnSZt8BJ2OyGS20Lc1XzUGZ6dSZaSPUppgH+2byNJj6ZLBCfBvmpr nU6e8/ofHrAhbllL9hfzJiflf2vwYXX3OWwOINvDg9js2hSAVZqrF2EO2IDzpVa2YvX3xk3PXnf w8kEVP938XaNKm1TufPFBO136xxSKexlUBuWmDBxUpEk7HMnuKUVy3KRfZXu3w913y2IU=
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

Tested on LSM6DSV16X.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  28 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   9 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 243 ++++++++++++++++++
 5 files changed, 333 insertions(+), 7 deletions(-)
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
index 450cb5b47346..630e2cae6f19 100644
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
+		.format = IIO_SCAN_FORMAT_FLOAT,			\
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
index 000000000000..9fb3e19e4a55
--- /dev/null
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
@@ -0,0 +1,243 @@
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
+static int st_lsm6dsx_fusion_set_odr_locked(struct st_lsm6dsx_sensor *sensor,
+					    bool enable)
+{
+	const struct st_lsm6dsx_fusion_settings *settings;
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	int err;
+
+	settings = &hw->settings->fusion_settings;
+	if (enable) {
+		const struct st_lsm6dsx_reg *reg = &settings->odr_reg;
+		u8 odr_val;
+		u8 data;
+
+		st_lsm6dsx_fusion_get_odr_val(settings, sensor->hwfifo_odr_mHz,
+					      &odr_val);
+		data = ST_LSM6DSX_SHIFT_VAL(odr_val, reg->mask);
+		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+					 data);
+		if (err)
+			return err;
+	}
+
+	return regmap_assign_bits(hw->regmap, settings->fifo_enable.addr,
+				  settings->fifo_enable.mask, enable);
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
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	int err;
+
+	guard(mutex)(&hw->page_lock);
+
+	err = st_lsm6dsx_fusion_page_enable(hw);
+	if (err)
+		return err;
+
+	err = st_lsm6dsx_fusion_set_odr_locked(sensor, enable);
+	if (err) {
+		st_lsm6dsx_fusion_page_disable(hw);
+		return err;
+	}
+
+	return st_lsm6dsx_fusion_page_disable(hw);
+
+out:
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
+	 * Put the IIO device pointer in the iio_devs array so that the caller
+	 * can set up a buffer and register this IIO device.
+	 */
+	hw->iio_devs[ST_LSM6DSX_ID_FUSION] = iio_dev;
+
+	return 0;
+}
-- 
2.39.5

