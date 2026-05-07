Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC633F0AB1
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158080; cv=none; b=YAWeyme8hgxivmCZILfkXeeKsuVN++aDThHyzITQ9/ZLBLIonwA0UTh0bw2uFSU1u3k6y31XOJRYOKdzxP5XwLzXuAlz7JE4RCLTEabnxqW0TyJuSQMeUS0Z3g/X9Nt7JcfvFGvep6KJvleXN7d5GvdzfkBPeP6vNQkEIeu2F7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158080; c=relaxed/simple;
	bh=Anx9QugTARumJ1WE+UrXpMmZgh4JKcxWcMqwLIrUaN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfegMN4hvme6KuB3qZ5ydMtTuNZXsYDQGO+otudbN3OuhmOLxWDaw8D/jr8284fQvHuGl5Hxvcoicidp/6AmPnbzjl25SA4aGxU1WEXsKPM4E3tv7bpdczkWZDMRYxXCSyvOUzUGvse6p3UVibz7RtziHreoycGCSpoOaheWLdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/EhPgVK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/EhPgVK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891b0786beso5858585e9.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778158074; x=1778762874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn4SpmJIU0OpLzyWEeMQ1mLxfCWK8uSQNJG4IsAoFDI=;
        b=b/EhPgVKc0drXRSmOZ1Ufbh4TB+ApVkZJePVFsEcby90HEJLn/QR1qXx33jL5QUBsK
         WEzUbDemTQHijK8TEwBZNv9fdPBVGX5aPYEGgjD63LdI7iizA/QxP9Qc3nKUmhG70lai
         cRxVQxatfIo9ElJv/KPvixpkdhr54c8JSIQ/qto8H8UcGZmJodF02KeLnA9upRgKfp0r
         HA9KCAgkDXKf9x3IsKfp4jz9JTcPWZpSc0iAoZdDXcXZkN+OoQWDkZWrSz7EZsSX04dm
         f+geXRZuzHP+mlVS8qw6Uf9XTrxUWsYrdH9QuN3+Ej3pi+5lp8UgNIkkZHsDPhAwE5tn
         HtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158074; x=1778762874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cn4SpmJIU0OpLzyWEeMQ1mLxfCWK8uSQNJG4IsAoFDI=;
        b=i8QSrwUiSfcYfx6D0lCowPHJj6wuR4ZulCScORAOJfbBHudCahCArJBxynfJL/s1+D
         jECV/3GPE16AhSk5c30wJU6s4XSf2AO+RyVoQ0YFWu4fPqY5uJ3QLWtzUDMKzEnkuNJX
         saeA73yCXKqfiu9/FUpv/YafsOlMbSCQnxVoEWnF3pUY2w9SWCLhcJe7C/Vu+2iMTIWL
         O1pYAw8tyAkh2+gZ8hocGkLiGCwIoZtnEtTKTkNgPbjMlsKup+yETlnsufqaXTf9M9Wl
         IUaex7Xvu+ctojc0UvwrM5td6XYjX0vGnZmH3omNPs1G9OYXxcKDg7UUYBDERtL2UcKD
         WiEQ==
X-Gm-Message-State: AOJu0YzTAG9lvfOwcvi1VFB+SyunaCvuEzTFt4iJtPhfJt0W4SPJHBin
	T8w1zmy7Mmw7gObejnlmd7W5fiMaZ098MiRuOj+hNCCnx6jDJ3tWuPv2
X-Gm-Gg: AeBDiesq2g3+ZGkSHXUBKT8A8DnOdRZFoXuphU1J8ADVhmm5Dj1UmuaaEVZzcwOwrA+
	vtBtXdbdk41tmTIbvBes4ni9UJd1Vz30BPosUpUe8NiVbsJcSAw9s+pzrJQymB0vft95MvTiqfq
	Ap7iA45REdulNdQP3VLqPaVCKSGaGG50PVFW8TH76OnmzirHGQ9gHf+ljbD9Gk5Jqu6UsWLWu5+
	diwoU/dAEnbxba9EkeIJhKBNDILBpOcvPLlkusjtmqG9ldbfsHIu4NLlosJ/+6JMnhFSju+9Hos
	/64JiE+qqYtFqmwkl1JflPODjjoLyviRfnmcE4oItrfwjx3sSrb8G+1FQzukNag2eV42CbIGavp
	1I8bWq2ZbG34mLpF4ixiHsQE/xRYkNmXuvA3IS0itc2b5M2eduWdrVdLZdneZRNrVdnbe5PLpoW
	R6fJRtMnJIIpNRPtVt1G14Pv2ImZqRKIg2yKLVNYvSAQSmFWAOU38TMQBemPEVggEgyxEnolcoI
	EtM/G0IqIIBmNGSjVU=
X-Received: by 2002:a05:600c:8115:b0:48a:9540:1a3a with SMTP id 5b1f17b1804b1-48e51e196f9mr124231955e9.8.1778158073724;
        Thu, 07 May 2026 05:47:53 -0700 (PDT)
Received: from ai-node.taila4f726.ts.net (89-139-15-25.bb.netvision.net.il. [89.139.15.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538b6e9bsm209228145e9.10.2026.05.07.05.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:47:53 -0700 (PDT)
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
Subject: [PATCH 2/3] iio: magnetometer: add driver for MEMSIC MMC5983MA
Date: Thu,  7 May 2026 12:47:23 +0000
Message-ID: <20260507124724.813043-3-vlad.kulikov.c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507124724.813043-1-vlad.kulikov.c@gmail.com>
References: <20260507124724.813043-1-vlad.kulikov.c@gmail.com>
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
 drivers/iio/magnetometer/Kconfig   |  11 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/mmc5983.c | 330 +++++++++++++++++++++++++++++
 3 files changed, 342 insertions(+)
 create mode 100644 drivers/iio/magnetometer/mmc5983.c

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
index 000000000000..7f2f5133a472
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5983.c
@@ -0,0 +1,330 @@
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
+	MMC5983_AXIS_Z
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
+	MMC5983_CHANNEL(Z)
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
+	ret = regmap_read_poll_timeout(data->regmap, MMC5983_REG_STATUS,
+				       status,
+				       status & MMC5983_STATUS_MEAS_M_DONE_BIT,
+				       5000, 50000);
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
+	int ret = -EBUSY;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
+					   MMC5983_CTRL0_SET_BIT);
+			if (ret)
+				break;
+
+			fsleep(500);
+
+			ret = mmc5983_take_measurement(data, m1);
+			if (ret)
+				break;
+
+			ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
+					   MMC5983_CTRL0_RESET_BIT);
+			if (ret)
+				break;
+
+			fsleep(500);
+
+			ret = mmc5983_take_measurement(data, m2);
+			if (ret)
+				break;
+
+			*val = (m1[chan->address] - m2[chan->address]) / 2;
+			ret = IIO_VAL_INT;
+		}
+		return ret;
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
+	.read_raw = mmc5983_read_raw
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
+	unsigned int reg_id, status;
+	int ret;
+
+	ret = regmap_read(data->regmap, MMC5983_REG_ID, &reg_id);
+	if (ret)
+		return dev_err_probe(regmap_get_device(data->regmap), ret,
+				     "Error reading product id\n");
+
+	if (reg_id != MMC5983_PRODUCT_ID)
+		return dev_err_probe(regmap_get_device(data->regmap), -ENODEV,
+				     "wrong product id 0x%02x\n", reg_id);
+
+	ret = regmap_write(data->regmap, MMC5983_REG_CTRL1,
+			   MMC5983_CTRL1_SW_RST_BIT);
+	if (ret)
+		return ret;
+
+	fsleep(10000);
+
+	ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
+			   MMC5983_CTRL0_OTP_RD_BIT);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(data->regmap, MMC5983_REG_STATUS,
+				       status,
+				       status & MMC5983_STATUS_OTP_RD_DONE_BIT,
+				       1000, 10000);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
+			   MMC5983_CTRL0_SET_BIT);
+	if (ret)
+		return ret;
+
+	fsleep(500);
+
+	ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
+			   MMC5983_CTRL0_RESET_BIT);
+	if (ret)
+		return ret;
+
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
+	indio_dev->name = i2c->name;
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

