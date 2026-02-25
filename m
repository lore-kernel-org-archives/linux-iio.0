Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287B3921C2
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014700; cv=none; b=G8rZP233ptEJ1vqC4nho7ZYX5TkxqFViH2+hC8yuBt2bLhekmlkd9xuRgou3vyKhtoDW1dmgeM9hNuJySXdnBOoj5KfscM3hQYI6d06pqXnYZESkfNZOijUIHnlJNkUfnYGiQXO9jBohyiAcmgdTYecLTcLjztL/kYXQIe3GtDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014700; c=relaxed/simple;
	bh=7Xc5iR2r3mSsEKkkNfZiPqHLw/poBRd/FgOqBlPCoYM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GneDudClIJ7BxKA1haO76hs/hFxDq/di2mjx8aCrqU6IAIiMqh2czrldDEIyUS7+BdT2uoVRa1ZzRmTmofvA8sh6c8GW83LU0WQAunqwbRDxOAtKXkJnvpDsaie5hbc1FFUwNtXVF0dEM2+pz6CuXHM9Ym3kkcFAkLBOQNc+5v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GT7X5QXW; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GT7X5QXW"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4398d9a12c6so672233f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 02:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772014696; x=1772619496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28QWOw1vn6hlB7Z/6wxJ6t4X6YR/ayXcRdrKzUQeF9o=;
        b=GT7X5QXWa9aaRXkCw6DlWWuRH949YDLVBb4wN5K8sZ3NXKhcVlDb/S9qKOYnGSxMSl
         6+19mu2N0q5SdEykI3MJOV6RKtHNRB+kECApy3c9+Dv7FxkZYxR+Ed3dV7Cn3A7I4iLV
         +VrnQ2F6LAocyJtxDywZZJyN1d1Nr8X3tnX/wAEBY8HoWLKr/YD6TtdtTZb4yohRYcuO
         yMSfORIDhVoZgCINwzJvCMz4+AZCtspOCHJys9hcs0cJ8JWYZJPaVGitVhsWtbEtWBCZ
         fCxs10BP28F4jX6iWCXt6Wd9CwArfH3ASQ9wGn15EKtJTe0eVtO3vHzG84gvDHYCsIQ/
         v6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014696; x=1772619496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=28QWOw1vn6hlB7Z/6wxJ6t4X6YR/ayXcRdrKzUQeF9o=;
        b=HbJITaOSLPFEguXnQEsmmlPXW604HX5S+i0Y0XHL8kyorZ4XGftJQAEkcChDoiY8cR
         CIeqPNT/ePx3DOtw6D1q9K3gnD4iSlW3poYhMRPETL2tXQmbaHQFERXE8j28zfy77cPh
         6JPomAIgMZqZnrrAU1cew3yCwsV5lEQuMwMR3CK4mzMPf6MsBmuAF1mP4muJQxTdjKwI
         bi/9sGwU4nKCBTG3eooIfRTnouizMISor/5MW7MVFTF+6QJCUAMJeQOqgVzeMXyVPHWA
         ZmVgH1iNaV+1IERQQVmN1WEgOgHdBtVw+sTYWAMjkGeMjYcw39OBcCyBTh9IMwL4bl/l
         976g==
X-Forwarded-Encrypted: i=1; AJvYcCWsBbzCgysTZnwlbJ8wk3Lfm+9l9TUg8+VaJN4/wyY50anIJCuyaMinjDUQsRi4NAaHrtAOsNYvfnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz768Os6HW3wsExd/yTJQmxZk+LSxQlZZhCWL10vtYAwaQ+JRPH
	H2UqpLQlGeJ4Pgtr58/Y1CkEG0kpIqOiWG929WKyjMW9z3XN1sT7TfLp2Hm6gh+T6BA=
X-Gm-Gg: ATEYQzzUgNPUOf8OzdO5Y9Ggc4Y9mDOw4HB+8u8A6Yz1OVXiCn/jFhGIva5JJfN5Dl3
	msZ09dYRr77h0QnaeZvX0JxO3VGHZjJ37Dm2HeP8wXEwk9uXRhFCf3L3cKShqu9rOBnnsUt5sSV
	LNKHJeF6esZcNVHKDiIolARDNaNyB+Q4oYMR6Gy5bVtCmm7FkNbnq9TIUbvg5mosOw+b+dSFDrX
	L6bpLKiZfqd+/LjUH7z9vvedobB/wK0JGZnFzaKSkTh2r5104glTDD4k3pzNP3ymd5/Gy+Fx9Fs
	/AP5hX1Dvgr52ggXl/oN3IwFn6JpaM5zwsXlbgzW5x8aCKyQs+0JHP3MN+t9jqov7oD1+MVFM5D
	EWqj6crGRCbRHEv5OVnc14NEok6kv+82Gw6qhyZd4o0yWjk1eNbZmZsXhwcGM35DF5kMCJLGF9O
	PoPZBE
X-Received: by 2002:a05:6000:25c3:b0:439:936b:bfe7 with SMTP id ffacd0b85a97d-439936bc280mr419489f8f.45.1772014696210;
        Wed, 25 Feb 2026 02:18:16 -0800 (PST)
Received: from localhost ([151.35.220.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43987f3ed03sm12516439f8f.16.2026.02.25.02.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:18:15 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/7] iio: imu: st_lsm6dsx: Add support for rotation sensor
Date: Wed, 25 Feb 2026 11:18:13 +0100
Message-Id: <20260225101814.2368431-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260225100421.2366864-1-flavra@baylibre.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17523; i=flavra@baylibre.com; h=from:subject; bh=7Xc5iR2r3mSsEKkkNfZiPqHLw/poBRd/FgOqBlPCoYM=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpnsxlPLZSbXdNj1LvL64OwyXTo2r/OxPgCDMri bvowPGzMfiJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaZ7MZQAKCRDt8TtzzpQ2 X+NWDACW7lTBTCvvFwKhCA2RlAr7pb8OFZ/y5KGWBv03crK7V2IlVjAyF2KrO6KdELlPX54rAg1 FoAURtaErUREbtM3rbKGdZK+1jmrZzbrJ1QYF3NbRDOUY1/AMhcFkUEMFXBYrDxZPywK6/xjtZv U9gXByh72FyHyL17h/oTZFmjJms9g3M+uRrNbn3Kr1Y/F0cu+oDbbZEbdmFsAasnw4P49ZUDILR 0wD5KxZypndfG7o9KNxSDUZxlRY68iTCV9YcZFC9kJ9ADXrCEPQOAZvE9aED1Z6dXYDWrtmLnT1 pk4jBl7mKbcPAhUr7T8dcA+G+/HJS2R/9z5aa3Q1tzrI1gQUdrPsxA/Wctqj4QnA9QSTU0HJql5 RF8/AJ6+SxjXcC61weg8FT46jcnxB7/M3m44vJOS0i7CxxaxG+JtOJtk1WysOI/nlRMgwDQ0wZH YQtji/SZTRgck6MCZsA4yQbCNzueavHP+U5ru+1IjYw7++dB/OtXFLNwd4bZotR5ZpnpI=
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
 Documentation/iio/index.rst                   |   1 +
 Documentation/iio/st_lsm6dsx.rst              |  44 ++++
 drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  26 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   9 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 235 ++++++++++++++++++
 7 files changed, 368 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/iio/st_lsm6dsx.rst
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index ba3e609c6a13..4e2ebe64f97f 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -39,3 +39,4 @@ Industrial I/O Kernel Drivers
    bno055
    ep93xx_adc
    opt4060
+   st_lsm6dsx
diff --git a/Documentation/iio/st_lsm6dsx.rst b/Documentation/iio/st_lsm6dsx.rst
new file mode 100644
index 000000000000..7f11a0b7e5c0
--- /dev/null
+++ b/Documentation/iio/st_lsm6dsx.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=================
+ST LSM6DSX driver
+=================
+
+Device driver for STMicroelectronics LSM6DSx, LSM9DS1, ASM330, and ISM330 series
+of 6-axis inertial measurement units. The core module is called ``st_lsm6dsx``,
+and the transport-specific modules are called ``st_lsm6dsx_i2c``,
+``st_lsm6dsx_spi``, and ``st_lsm6dsx_i3c``.
+
+IIO devices
+===========
+
+This driver instantiates multiple IIO devices:
+
+* accelerometer (IIO_ACCEL channel)
+* gyroscope (IIO_ANGL_VEL channel)
+* (optionally) magnetometer (IIO_MAGN channel), if the device has a secondary
+  I2C interface connected to a slave sensor device (sensor hub functionality)
+* (optionally) sensor fusion (IIO_CUSTOM channel), which combines acceleration
+  and angular velocity data
+
+Sensor Fusion
+-------------
+
+Some chips supported by this driver implement an internal algorithm that takes
+input data from the accelerometer and gyroscope, and calculates the device
+orientation in 3D space, which is then made available in the hardware FIFO.
+Orientation is expressed in the form of a 4-dimensional quaternion vector, whose
+components are typically represented in an array as ``[x, y, z, w]``.
+The sensor device outputs the ``[x, y, z]`` components of the quaternion,
+expressed as half-precision (16-bit) floating-point numbers.
+
+The ``z`` component is not output by the device, but its value can be derived
+from the rest of the data, due to the following constraints:
+
+* the quaternion vector is normalized, i.e. :math:`x^2 + y^2 + z^2 + w^2 = 1`
+* the rotation angle :math:`\theta` remains within
+  :math:`[-180^\circ, 180^\circ]`, i.e. the ``w`` component is non-negative:
+  :math:`w = \cos(\theta/2) \geq 0`
+
+These constraints allow the ``w`` value to be calculated from the other
+components: :math:`w = \sqrt{1 - (x^2 + y^2 + z^2)}`.
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
index 39d23b9e677c..2cd849ef0c9a 100644
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
index a6ee2da5a06c..6b9371423f2d 100644
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
@@ -578,6 +582,9 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
 	case ST_LSM6DSX_EXT2_TAG:
 		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
 		break;
+	case ST_LSM6DSX_ROT_TAG:
+		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_SF];
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 450cb5b47346..5b336b62eb60 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -94,6 +94,24 @@
 
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
 
+/* Raw values from the IMU are 16-bit half-precision floating-point numbers. */
+#define ST_LSM6DSX_CHANNEL_ROT						\
+{									\
+	.type = IIO_CUSTOM,						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_QUATERNION,					\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
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

