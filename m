Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE93532F764
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187054; cv=none; b=UL2jCSK7DMuvomMoDMWCT/OTBoWROBqh3ImfmIniXpxjGBBArJ7cA9+pwNpmlEY6V2EiVrYN16WVfOpVXTjdi8xyKwjQvJFK1S7qWiSVsbYkhaOf0THnY9X/a6PGtm4E434QncK6H3XOc7Sf6EC8ksXW+5aXiEYJEWcniJdI9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187054; c=relaxed/simple;
	bh=sAjpVLKmUk4OoxtMq0bwbqesB9SMP3re8LnNPeucrUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPcqdoX6IKfZalgrazfG+TZMzHJFnBTnDEisSOoL4O2GQXOISsohDCrkJZAkLjsqaVY8Wj2j8YKsm3RuhhhLidh+RJ5IFK00gH5ZVOrF2ARRvRpbvNSRzUFSmd1nOoawYDQhYtxJYOFSUgLMUU6YxN9JmfNT8ln531JASX2CU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEL5XS/i; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEL5XS/i"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44e5624c053so801643f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778187051; x=1778791851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpDuQ9cx7QhEzoo/dL48UTCS8RAvLx+lVRlWD78IkCs=;
        b=EEL5XS/i3ctxiBL53z1TTj8y+ZDUfswDDXTkKfaljLI1Tr1z6K7Ho0GS2hVyKDLeDb
         J/o4wTLYyGow20tizcBOc86EuC9JMUh48KrHlV+zsmcmGLakDoYgQCEckS6F6GxfFyQp
         5s7zLb41vT0k+RS2uPe2KmY8NhfX+Imkfoibgi/veH9T7B5rpwHNWnFC0s2hZS6pVS0E
         SfD7eH09oOd+yr3k+N5tdNPUtsQXL2gfOH23QZDhflS9oWvQwMHpLI2SQKHjTtdK6ZV2
         KJKXBb/xE/XrF7HbbjFdC/0qaX6mGa7DhTtyYav/TGCwOS3DmQHYc0OK3la7b63Xr8F5
         wRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778187051; x=1778791851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BpDuQ9cx7QhEzoo/dL48UTCS8RAvLx+lVRlWD78IkCs=;
        b=pKT3x6QyOvbdw0K4HfaUxK/p71q3thcYK4MkYyqPBXdNzDTsqzr9jdx22arA16PhBH
         hrZpd25g4yx+RtcEtc8Q8BYwEGsWavOHp83+1tWV6W4JPl4YAUJe5/OBJo8hGn4mshW7
         4QWHUOyQmydgpru3Wv++KS7oVIJJKe+6R25d3LwmOFLUZ32X7L2KAyPhMyoQxQYb9ZzJ
         whKGnp3WRSnVgbspu3OA2pJbGTvX/O/eSGGz/hlO0IUZVV9LtOCet+Qyr2sB7TooLq2S
         mBS6WYPrdtAe4LNN7TaX8KN+VHRRO8XmggEuw7zhwIVGI8f1polYdYoTp1I1b/mzkyMD
         hRDA==
X-Gm-Message-State: AOJu0YyHlky23OaFu2VS3ysJcIhSndkiqu+AxB0uTO+OvcqYyg1pYGhI
	pX1RvNK8WPTBzG1FMnrvL1TzOQLsmzu5ZVcnU2l8qg4UPIYu5+awPXD/
X-Gm-Gg: Acq92OGlk8WUYhiBRiwpg6/dUCKhbA5Xzu2XBIT24u7OeWcYgJVy/Pk3stf9kv0A1mT
	aqinGz5pmnPjKytcXO4pIiW4usKYYT4c0S2tb+mqAtp9S6yDj+2unYpGZfuS+say75JCbn0VS7W
	EYqpQrCcDeaISGlanzt+1CXOKFjty4XtYe14k665v4IvCo1lNK6G/Nzy2zNT63WSloyOSxVgNGZ
	y3vmnTiFCdakZdMcn6lNw1CSiS2KID9V6x5BTmVu9+mBeJ1cRV/bpwJJmg5dVm+IehLgPgMEDMM
	T2JImehwi0bSa/W3LrOiXkt6ICZSJSgsD5JqREEw36vvBa8/Pu6jFmKgzcgu2lcTgvHumO7MDmh
	wEDKXTvZYG/Nw2SvOLUBQp4f0epgD7tJ6yy8GhGA/gmQpVBstdBCl7RNFXDEDfki1lY6xzTUJWW
	M5pQOcp0ItE8O+vIt3FDYijGrG1lrJMOhRPVCzd01mvtbhaqFXgGE+2HzYYzaM8w0agKcBjlrFV
	CgfEdSk
X-Received: by 2002:a05:6000:26c9:b0:44b:d88e:7ceb with SMTP id ffacd0b85a97d-4515d3dc4e0mr15610341f8f.32.1778187050937;
        Thu, 07 May 2026 13:50:50 -0700 (PDT)
Received: from ai-node.taila4f726.ts.net (89-139-15-25.bb.netvision.net.il. [89.139.15.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454175f59a5sm1401635f8f.32.2026.05.07.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:50:50 -0700 (PDT)
From: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Subject: [PATCH v2 2/2] iio: magnetometer: add driver for MEMSIC MMC5983MA
Date: Thu,  7 May 2026 20:50:32 +0000
Message-ID: <20260507205033.951990-3-vlad.kulikov.c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
References: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the MEMSIC MMC5983MA 3-axis magnetometer. The driver
provides raw magnetic field readings via IIO sysfs with SET/RESET
offset cancellation for each measurement.

Signed-off-by: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
---
 MAINTAINERS                        |   1 +
 drivers/iio/magnetometer/Kconfig   |  11 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/mmc5983.c | 351 +++++++++++++++++++++++++++++
 4 files changed, 364 insertions(+)
 create mode 100644 drivers/iio/magnetometer/mmc5983.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 952fbf3020a4..b1d9d7b586a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17175,6 +17175,7 @@ M:	Vladislav Kulikov <vlad.kulikov.c@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
+F:	drivers/iio/magnetometer/mmc5983.c
 
 MEN A21 WATCHDOG DRIVER
 M:	Johannes Thumshirn <morbidrsa@gmail.com>
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index fb313e591e85..ea2697fb5ab6 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -151,6 +151,17 @@ config MMC5633
 	  To compile this driver as a module, choose M here: the module
 	  will be called mmc5633
 
+config MMC5983
+	tristate "MEMSIC MMC5983 3-axis magnetic sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for the MEMSIC MMC5983 3-axis
+	  magnetic sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mmc5983
+
 config IIO_ST_MAGN_3AXIS
 	tristate "STMicroelectronics magnetometers 3-Axis Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index 5bd227f8c120..7fd9b3fd914e 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
 obj-$(CONFIG_MMC35240)	+= mmc35240.o
 obj-$(CONFIG_MMC5633)	+= mmc5633.o
+obj-$(CONFIG_MMC5983)	+= mmc5983.o
 
 obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
 st_magn-y := st_magn_core.o
diff --git a/drivers/iio/magnetometer/mmc5983.c b/drivers/iio/magnetometer/mmc5983.c
new file mode 100644
index 000000000000..3b06164fad15
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5983.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MMC5983 - MEMSIC 3-axis Magnetic Sensor
+ *
+ * Copyright (c) 2026, Vlad Kulikov <vlad.kulikov.c@gmail.com>
+ *
+ * IIO driver for MMC5983
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#define MMC5983_REG_XOUT0	0x00
+#define MMC5983_REG_XOUT1	0x01
+#define MMC5983_REG_YOUT0	0x02
+#define MMC5983_REG_YOUT1	0x03
+#define MMC5983_REG_ZOUT0	0x04
+#define MMC5983_REG_ZOUT1	0x05
+#define MMC5983_REG_XYZOUT2	0x06
+
+#define MMC5983_REG_STATUS	0x08
+
+#define MMC5983_REG_CTRL0	0x09
+#define MMC5983_REG_CTRL1	0x0A
+#define MMC5983_REG_CTRL2	0x0B
+#define MMC5983_REG_CTRL3	0x0C
+
+#define MMC5983_REG_ID		0x2F
+
+#define MMC5983_PRODUCT_ID	0x30
+
+#define MMC5983_STATUS_MEAS_M_DONE_BIT	BIT(0)
+#define MMC5983_STATUS_OTP_RD_DONE_BIT	BIT(4)
+
+#define MMC5983_CTRL0_TM_M_BIT		BIT(0)
+#define MMC5983_CTRL0_SET_BIT		BIT(3)
+#define MMC5983_CTRL0_RESET_BIT		BIT(4)
+#define MMC5983_CTRL0_OTP_RD_BIT	BIT(6)
+
+#define MMC5983_CTRL1_SW_RST_BIT	BIT(7)
+
+enum mmc5983_axis {
+	MMC5983_AXIS_X,
+	MMC5983_AXIS_Y,
+	MMC5983_AXIS_Z,
+};
+
+struct mmc5983_data {
+	struct regmap *regmap;
+	/* Protects chip access during SET/RESET measurement sequence */
+	struct mutex mutex;
+};
+
+#define MMC5983_CHANNEL(_axis) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_##_axis, \
+	.address = MMC5983_AXIS_##_axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec mmc5983_channels[] = {
+	MMC5983_CHANNEL(X),
+	MMC5983_CHANNEL(Y),
+	MMC5983_CHANNEL(Z),
+};
+
+static int mmc5983_take_measurement(struct mmc5983_data *data, int m[3])
+{
+	unsigned int status;
+	u8 buf[7];
+	int ret;
+
+	ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
+			   MMC5983_CTRL0_TM_M_BIT);
+	if (ret)
+		return ret;
+
+	/*
+	 * Datasheet page 15: measurement time is 8 ms at BW=00 (default,
+	 * slowest setting). Use a 50 ms timeout for margin.
+	 */
+	ret = regmap_read_poll_timeout(data->regmap, MMC5983_REG_STATUS,
+				       status,
+				       status & MMC5983_STATUS_MEAS_M_DONE_BIT,
+				       10000, 50000);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(data->regmap, MMC5983_REG_XOUT0, buf,
+			       sizeof(buf));
+	if (ret)
+		return ret;
+
+	m[0] = (buf[0] << 10) | (buf[1] << 2) | ((buf[6] >> 6) & 0x3);
+	m[1] = (buf[2] << 10) | (buf[3] << 2) | ((buf[6] >> 4) & 0x3);
+	m[2] = (buf[4] << 10) | (buf[5] << 2) | ((buf[6] >> 2) & 0x3);
+
+	return 0;
+}
+
+static int mmc5983_read_raw(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan, int *val,
+			     int *val2, long mask)
+{
+	struct mmc5983_data *data = iio_priv(indio_dev);
+	int m1[3], m2[3];
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&data->mutex);
+
+		ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
+				   MMC5983_CTRL0_SET_BIT);
+		if (ret)
+			return ret;
+
+		/*
+		 * Datasheet page 15: SET/RESET coil pulse is 500 ns.
+		 * Vendor sample code waits 500 us before the next operation.
+		 */
+		fsleep(500);
+
+		ret = mmc5983_take_measurement(data, m1);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
+				   MMC5983_CTRL0_RESET_BIT);
+		if (ret)
+			return ret;
+
+		/*
+		 * Datasheet page 15: SET/RESET coil pulse is 500 ns.
+		 * Vendor sample code waits 500 us before the next operation.
+		 */
+		fsleep(500);
+
+		ret = mmc5983_take_measurement(data, m2);
+		if (ret)
+			return ret;
+
+		*val = (m1[chan->address] - m2[chan->address]) / 2;
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = 61035;
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mmc5983_info = {
+	.read_raw = mmc5983_read_raw,
+};
+
+static bool mmc5983_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5983_REG_CTRL0:
+	case MMC5983_REG_CTRL1:
+	case MMC5983_REG_CTRL2:
+	case MMC5983_REG_CTRL3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5983_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5983_REG_XOUT0:
+	case MMC5983_REG_XOUT1:
+	case MMC5983_REG_YOUT0:
+	case MMC5983_REG_YOUT1:
+	case MMC5983_REG_ZOUT0:
+	case MMC5983_REG_ZOUT1:
+	case MMC5983_REG_XYZOUT2:
+	case MMC5983_REG_STATUS:
+	case MMC5983_REG_CTRL0:
+	case MMC5983_REG_CTRL1:
+	case MMC5983_REG_CTRL2:
+	case MMC5983_REG_CTRL3:
+	case MMC5983_REG_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5983_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5983_REG_XOUT0:
+	case MMC5983_REG_XOUT1:
+	case MMC5983_REG_YOUT0:
+	case MMC5983_REG_YOUT1:
+	case MMC5983_REG_ZOUT0:
+	case MMC5983_REG_ZOUT1:
+	case MMC5983_REG_XYZOUT2:
+	case MMC5983_REG_STATUS:
+	case MMC5983_REG_CTRL0:
+	case MMC5983_REG_CTRL1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config mmc5983_regmap_config = {
+	.name = "mmc5983_regmap",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MMC5983_REG_ID,
+	.writeable_reg = mmc5983_is_writeable_reg,
+	.readable_reg = mmc5983_is_readable_reg,
+	.volatile_reg = mmc5983_is_volatile_reg,
+};
+
+static int mmc5983_init(struct mmc5983_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	struct device *dev = regmap_get_device(regmap);
+	unsigned int reg_id, status;
+	int ret;
+
+	ret = regmap_read(regmap, MMC5983_REG_ID, &reg_id);
+	if (ret)
+		return dev_err_probe(dev, ret, "Error reading product id\n");
+
+	if (reg_id != MMC5983_PRODUCT_ID)
+		dev_info(dev, "unexpected product id 0x%02x\n", reg_id);
+
+	ret = regmap_write(regmap, MMC5983_REG_CTRL1, MMC5983_CTRL1_SW_RST_BIT);
+	if (ret)
+		return ret;
+
+	/* Datasheet page 15: power-on time after SW_RST is 10 ms */
+	fsleep(10000);
+
+	ret = regmap_write(regmap, MMC5983_REG_CTRL0, MMC5983_CTRL0_OTP_RD_BIT);
+	if (ret)
+		return ret;
+
+	/*
+	 * Datasheet page 15: OTP read completes and self-clears. No separate
+	 * OTP refresh timeout is specified, so use the 10 ms power-on time as
+	 * a conservative upper bound.
+	 */
+	ret = regmap_read_poll_timeout(regmap, MMC5983_REG_STATUS, status,
+				       status & MMC5983_STATUS_OTP_RD_DONE_BIT,
+				       1000, 10000);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, MMC5983_REG_CTRL0, MMC5983_CTRL0_SET_BIT);
+	if (ret)
+		return ret;
+
+	/*
+	 * Datasheet page 15: SET/RESET coil pulse is 500 ns.
+	 * Vendor sample code waits 500 us before the next operation.
+	 */
+	fsleep(500);
+
+	ret = regmap_write(regmap, MMC5983_REG_CTRL0, MMC5983_CTRL0_RESET_BIT);
+	if (ret)
+		return ret;
+
+	/*
+	 * Datasheet page 15: SET/RESET coil pulse is 500 ns.
+	 * Vendor sample code waits 500 us before the next operation.
+	 */
+	fsleep(500);
+
+	return 0;
+}
+
+static int mmc5983_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct mmc5983_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	ret = devm_mutex_init(dev, &data->mutex);
+	if (ret)
+		return ret;
+
+	data->regmap = devm_regmap_init_i2c(i2c, &mmc5983_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "failed to allocate register map\n");
+
+	indio_dev->info = &mmc5983_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = "mmc5983";
+	indio_dev->channels = mmc5983_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mmc5983_channels);
+
+	ret = mmc5983_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "mmc5983 chip init failed\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id mmc5983_of_match[] = {
+	{ .compatible = "memsic,mmc5983" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmc5983_of_match);
+
+static const struct i2c_device_id mmc5983_id[] = {
+	{ "mmc5983" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mmc5983_id);
+
+static struct i2c_driver mmc5983_driver = {
+	.driver = {
+		.name = "mmc5983",
+		.of_match_table = mmc5983_of_match,
+	},
+	.probe = mmc5983_probe,
+	.id_table = mmc5983_id,
+};
+module_i2c_driver(mmc5983_driver);
+
+MODULE_AUTHOR("Vladislav Kulikov <vlad.kulikov.c@gmail.com>");
+MODULE_DESCRIPTION("MEMSIC MMC5983 magnetic sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

