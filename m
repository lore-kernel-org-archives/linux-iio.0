Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3519328B75
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778440232; cv=none; b=ZwNULdSDCmzAiqXmMazM40w85Li83189ZXBEHFEnfI+jiul8XGgDIHwJnJEV8BUQbeWKFXxXjq/eJhZHGf8qEG3lUUGi6CZgeEfsMCFcMt74oyvtYW5Sx/KkJtgnqkzN4yKBOltCv8Q9Z/ijjVcpJcnMpK/cbDG23RWVdEoHKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778440232; c=relaxed/simple;
	bh=vzSsKGshhUbpMOZOIwtoF22JmWWhGHoJPNpEsPY0288=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHcBMtIsrAqUJyD3RjJ/+LKphTxsdfLrso0Eyr1Owbaxh3yLzsmwe7PCscdB6p6MP6CJSXwW/ZrpN+BiuRVxHX3TpD9CXEMQfapSCJucH/qQvzr9Bo0ZgNWkqtYyMN1CzJwmoC0/0F5vhv7BEASnsmZLoY6wjjFBOjfi+lb4Z4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BON2zEC+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BON2zEC+"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso1479438a12.3
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778440230; x=1779045030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IabnayRaO+hNjLcbI/uyI/ECM9I5btvQAktpmQXZKn8=;
        b=BON2zEC+VFWkX9oTS/jve6ZXyVA6bSl/S3d69L1/U++w6oxlwEhIXepE2Bwp2WEKms
         vyb1wUdX2ccHDsqqoKkSy3KBLOS+bluGSm8OVP6vl9oBpusopw7vXmIB99NrxCZDSQOt
         qLNaTZwHTFR/VAT7aVIyMwMdI80wYD2YkDDH0ytyAGShUPdWQIarvENPHssyzarMK1fV
         6GxGp1u4thj8ccKhdmi+wcJmD9taS7rM3c1f7bwponMf4/fQLdA2c+MQG0R3xT2q0rWP
         31a6pvPp/Xm82+gkRx+x9SsfyNoAMxjcUgpeLkeamKnBgqIZ0T8ENX9cx4BQzeuo2njO
         IJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778440230; x=1779045030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IabnayRaO+hNjLcbI/uyI/ECM9I5btvQAktpmQXZKn8=;
        b=sPwSjkuKNIrG7Cfz9Pb/M9gn0IzpkWxZTMb+tu5OxSnl3QRucDosBniJdmFVx8r/qN
         qn4Vvoi8MaldK6T6geba8Vfq4Dk6CraANxbKsxeZvMCSXKWbHLSVQnJLsiKhLLWwupp6
         C56NEEt4174PQnvkB+QOsc7eMJZhZDq9Uxef8JxaLrqrHSFBoxGQparGLxR7PJPscvQu
         eFpmWlWyTNehJDqCeZxIpM2ovgI+8KN4piqFc1XziamEAz+9xc80rhPruXoU38F62YSu
         mfB9mUIEWeOobihEOneYcKERe60a/u9e86XzqiD8MgAE/1K7fT7VlVtgdMpDlLOR4+DO
         y+Tg==
X-Forwarded-Encrypted: i=1; AFNElJ9ie+bp8iaLAEie2VfwnHo4DFFDVJZCpo2puG7TgYvwdbkJgMyFKbU+fBPfbFq//ye49nORCtmTt3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCWs9OYBFY5LKsZVvZ6ajusr2JBJJhAcQteQMPAk8d+DcuZpcP
	lIHkhOiwm3CFRNKScIdEVtT1X4sc8/X2A1QlvNRp9/zD3foz/jSgKJ4=
X-Gm-Gg: Acq92OE+H1vZygYLIAPZC7PYKuQ9fvRqd+KDZOAAsGzmNTgGC9aJXQpnTBKedb6//Vl
	TG4ne9P/CO6PMHfc0NaZwcKQlyiNG2cGnX4Eb6Kba6jlBPhFu8q4vifNJWiTJu0sx4caAQg0d78
	YnHmDMaYARkKBLuHQHIQSjOIw66MWYvOiT0ZGWnJHpQRzo3sH6eTIkDjcs6NZol58TbbKNJ2XJm
	8Ngsp4OT84zjevErFgFDityRLaJbDJz6l/Sll7mfMhEwCY+ZmvzywCnIFtCozbGYhQ7sFbybRv8
	5Ks09BRYRrHhVTDU8B9ZffeBNEjoLvWpjszJWXgeVSwk7Is/TfjZOA0NFMZNeFaMHp8dAn6JuSy
	CQtW8JvVqaeUpc6kZE5jXj5jjnHetCw5smnJXzeQ7M+cNb1zHJNKbk6mpLlmCXYo7zEcJxtfiaQ
	Is+10J4v/JHPjT1PM84+THQSgpP/Xt+kFkoSV9Wl4KRPBPSy0cV+I+uQxdP2f7hQf2
X-Received: by 2002:a17:903:2cb:b0:2ba:9587:25c3 with SMTP id d9443c01a7336-2ba9587276emr204732545ad.1.1778440230017;
        Sun, 10 May 2026 12:10:30 -0700 (PDT)
Received: from localhost.localdomain ([103.76.103.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1c5466bsm81817305ad.0.2026.05.10.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:10:29 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [RFC PATCH 2/2] iio: magnetometer: add support for Melexis MLX90393
Date: Mon, 11 May 2026 00:40:10 +0530
Message-Id: <20260510191010.155380-3-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260510191010.155380-1-nikhilgtr@gmail.com>
References: <20260510191010.155380-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Industrial I/O subsystem support for the Melexis
MLX90393 3-axis magnetometer and temperature sensor.

The driver currently supports:

raw magnetic field measurements
raw temperature measurements
configurable gain/scale selection
configurable oversampling ratio
direct mode operation

The MLX90393 supports both I2C and SPI interfaces. This
initial implementation adds support for the I2C interface.

The driver is structured around a shared sensor core with
a small transport abstraction layer to simplify future SPI
support without duplicating sensor logic.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/magnetometer/Kconfig         |  10 +
 drivers/iio/magnetometer/Makefile        |   2 +
 drivers/iio/magnetometer/mlx90393.h      |  76 +++
 drivers/iio/magnetometer/mlx90393_core.c | 724 +++++++++++++++++++++++
 drivers/iio/magnetometer/mlx90393_i2c.c  |  71 +++
 5 files changed, 883 insertions(+)
 create mode 100644 drivers/iio/magnetometer/mlx90393.h
 create mode 100644 drivers/iio/magnetometer/mlx90393_core.c
 create mode 100644 drivers/iio/magnetometer/mlx90393_i2c.c

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 3debf1320ad1..e6b74e7e3317 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -128,6 +128,16 @@ config HID_SENSOR_MAGNETOMETER_3D
 	  Say yes here to build support for the HID SENSOR
 	  Magnetometer 3D.
 
+config MLX90393
+	tristate "MELEXIS MLX90393 3-axis magnetometer sensor"
+	depends on I2C
+	help
+	  Say yes here to build support for the MELEXIS MLX90393 3-axis
+	  magnetometer.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mlx90393.
+
 config MMC35240
 	tristate "MEMSIC MMC35240 3-axis magnetic sensor"
 	select REGMAP_I2C
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index 9297723a97d8..542c89d38a59 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -14,6 +14,8 @@ obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
 
 obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
+obj-$(CONFIG_MLX90393)		+= mlx90393_core.o
+obj-$(CONFIG_MLX90393)		+= mlx90393_i2c.o
 obj-$(CONFIG_MMC35240)	+= mmc35240.o
 
 obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
diff --git a/drivers/iio/magnetometer/mlx90393.h b/drivers/iio/magnetometer/mlx90393.h
new file mode 100644
index 000000000000..f3e04aed67de
--- /dev/null
+++ b/drivers/iio/magnetometer/mlx90393.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MLX90393 magnetometer & temperature sensor driver
+ *
+ * Copyright (c) 2026 Nikhil Gautam <nikhilgtr@gmail.com>
+ */
+
+#ifndef MLX90393_H
+#define MLX90393_H
+
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/types.h>
+
+#define MLX90393_AXIS_MAX		2
+#define MLX90393_GAIN_MAX		8
+#define MLX90393_RES_MAX		4
+#define MLX90393_OSR2_MAX		4
+#define MLX90393_OSR_MAX		4
+
+#define MLX90393_CMD_MASK	GENMASK(7, 4)
+
+/* Commands */
+#define MLX90393_CMD_SB		0x10
+#define MLX90393_CMD_SW		0x20
+#define MLX90393_CMD_SM		0x30
+#define MLX90393_CMD_RM         0x40
+#define MLX90393_CMD_RR         0x50
+#define MLX90393_CMD_WR         0x60
+#define MLX90393_CMD_EX         0x80
+#define MLX90393_CMD_HR         0xD0
+#define MLX90393_CMD_HS         0xE0
+#define MLX90393_CMD_RT         0xF0
+
+#define MLX90393_MEASURE_Z	BIT(0)
+#define MLX90393_MEASURE_Y	BIT(1)
+#define MLX90393_MEASURE_X	BIT(2)
+#define MLX90393_MEASURE_TEMP	BIT(3)
+
+#define MLX90393_MEASURE_ALL \
+	(MLX90393_MEASURE_TEMP | MLX90393_MEASURE_X | \
+	MLX90393_MEASURE_Y | MLX90393_MEASURE_Z)
+
+#define MLX90393_NUM_CHANNELS	4
+
+#define MLX90393_STATUS_RESP	GENMASK(1, 0)
+#define MLX90393_STATUS_RT	BIT(2)
+#define MLX90393_STATUS_ERROR	BIT(4)
+
+#define MLX90393_REG_CONF1	0x00
+#define MLX90393_REG_CONF2	0x01
+#define MLX90393_REG_CONF3	0x02
+#define MLX90393_REG_CONF4	0x03
+
+#define MLX90393_CONF1_GAIN_SEL		GENMASK(6, 4)
+#define MLX90393_CONF1_HALLCONF		GENMASK(3, 0)
+
+#define MLX90393_CONF3_OSR		GENMASK(1, 0)
+#define MLX90393_CONF3_DIG_FILT		GENMASK(4, 2)
+#define MLX90393_CONF3_RES_X		GENMASK(6, 5)
+#define MLX90393_CONF3_RES_Y		GENMASK(8, 7)
+#define MLX90393_CONF3_RES_Z		GENMASK(10, 9)
+#define MLX90393_CONF3_OSR2		GENMASK(12, 11)
+
+struct mlx90393_transfer_ops {
+	int (*xfer)(void *context,
+		    const u8 *tx, int tx_len,
+		    u8 *rx, int rx_len);
+};
+
+int mlx90393_core_probe(struct device *dev,
+			const struct mlx90393_transfer_ops *ops,
+			void *context);
+
+#endif
diff --git a/drivers/iio/magnetometer/mlx90393_core.c b/drivers/iio/magnetometer/mlx90393_core.c
new file mode 100644
index 000000000000..c79f2b8c20d8
--- /dev/null
+++ b/drivers/iio/magnetometer/mlx90393_core.c
@@ -0,0 +1,724 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MLX90393 magnetometer & temperature sensor driver
+ *
+ * Copyright (c) 2026 Nikhil Gautam <nikhilgtr@gmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+
+#include "mlx90393.h"
+
+struct mlx90393_data {
+	struct device *dev;
+	struct mutex lock;
+	void *bus_context;
+	const struct mlx90393_transfer_ops *ops;
+	u8 gain_sel;
+	u8 hallconf;
+
+	u8 res_xy;
+	u8 res_z;
+
+	u8 dig_filt;
+	u8 osr;
+	u8 osr2;
+};
+
+enum mlx90393_channels {
+	MLX90393_CHAN_X,
+	MLX90393_CHAN_Y,
+	MLX90393_CHAN_Z,
+	MLX90393_CHAN_TEMP,
+};
+
+enum mlx90393_axis_type {
+	MLX90393_AXIS_TYPE_XY,
+	MLX90393_AXIS_TYPE_Z,
+};
+
+/* Datasheet: Table no.17 */
+static const int mlx90393_scale_table[MLX90393_AXIS_MAX]
+				[MLX90393_GAIN_MAX]
+				[MLX90393_RES_MAX] = {
+	/* XY axis */
+	{
+		{751, 1502, 3004, 6009},
+		{601, 1202, 2403, 4840},
+		{451, 901, 1803, 3605},
+		{376, 751, 1502, 3004},
+		{300, 601, 1202, 2403},
+		{250, 501, 1001, 2003},
+		{200, 401, 801, 1602},
+		{150, 300, 601, 1202},
+	},
+	/* Z axis */
+	{
+		{1210, 2420, 4840, 9680},
+		{968, 1936, 3872, 7744},
+		{726, 1452, 2904, 5808},
+		{605, 1210, 2420, 4840},
+		{484, 968, 1936, 3872},
+		{403, 807, 1613, 3227},
+		{323, 645, 1291, 2581},
+		{242, 484, 968, 1936},
+	}
+};
+
+static const int mlx90393_osr2_avail[MLX90393_OSR2_MAX] = {
+	0, 1, 2, 3,
+};
+
+static const int mlx90393_osr_avail[MLX90393_OSR_MAX] = {
+	1, 2, 4, 8,
+};
+
+#define MLX90393_CHAN(idx, axis, addr) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel = idx, \
+	.address = addr, \
+	.channel2 = IIO_MOD_##axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+		BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
+	.info_mask_separate_available = \
+		BIT(IIO_CHAN_INFO_SCALE),  \
+	.info_mask_shared_by_type_available = \
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+}
+
+static const struct iio_chan_spec mlx90393_channels[] = {
+	MLX90393_CHAN(0, X, MLX90393_CHAN_X),
+	MLX90393_CHAN(1, Y, MLX90393_CHAN_Y),
+	MLX90393_CHAN(2, Z, MLX90393_CHAN_Z),
+	{
+		.type = IIO_TEMP,
+		.address = MLX90393_CHAN_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_OFFSET) |
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_separate_available =
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+/*
+ * Calculate total conversion time in microseconds.
+ *
+ * Formula derived from datasheet timing equations.
+ */
+
+static int mlx90393_get_tconv_us(struct mlx90393_data *data)
+{
+	const int osr = data->osr;
+	const int osr2 = data->osr2;
+	const int df = data->dig_filt;
+
+	int tconvm;
+	int tconvt;
+
+	int m = 3; /* X,Y,Z */
+
+	/*
+	 * Datasheet:
+	 *
+	 * TCONVM =
+	 * 67 + 64 * 2^OSR * (2 + 2^DIG_FILT)
+	 */
+	tconvm = 67 +
+		(64 * BIT(osr) *
+		 (2 + BIT(df)));
+
+	/*
+	 * Datasheet:
+	 *
+	 * TCONVT =
+	 * 67 + 192 * 2^OSR2
+	 */
+	tconvt = 67 +
+		(192 * BIT(osr2));
+	/*
+	 * Total conversion time:
+	 * TSTBY + TACTIVE + m * TCONVM +
+	 * TCONVT + TCONV_END
+	 */
+	return 220 +
+		360 +
+		(m * tconvm) +
+		tconvt +
+		100;
+}
+
+static int mlx90393_xfer(struct mlx90393_data *data,
+			 const u8 *tx, int tx_len,
+			 u8 *rx, int rx_len)
+{
+	return data->ops->xfer(data->bus_context,
+			tx, tx_len,
+			rx, rx_len);
+}
+
+static int mlx90393_check_status(u8 cmd, u8 status)
+{
+	/* Always validate error bit */
+	if (status & MLX90393_STATUS_ERROR)
+		return -EIO;
+
+	switch (cmd & MLX90393_CMD_MASK) {
+	case MLX90393_CMD_RM:
+		/*
+		 * D1:D0 indicates response availability
+		 * 00 means invalid/no measurement
+		 */
+		if ((status & MLX90393_STATUS_RESP) == 0)
+			return -EIO;
+		break;
+
+	case MLX90393_CMD_RT:
+		/* Reset acknowledge */
+		if (!(status & MLX90393_STATUS_RT))
+			return -EIO;
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mlx90393_write_cmd(struct mlx90393_data *data,
+			      u8 cmd)
+{
+	u8 status;
+	int ret;
+
+	ret = mlx90393_xfer(data, &cmd, 1,
+			    &status, 1);
+	if (ret)
+		return ret;
+
+	return mlx90393_check_status(cmd, status);
+}
+
+static int mlx90393_read_cmd(struct mlx90393_data *data,
+			     u8 cmd,
+			     u8 *rx, int rx_len)
+{
+	int ret;
+
+	ret = mlx90393_xfer(data, &cmd, 1,
+			    rx, rx_len);
+	if (ret)
+		return ret;
+
+	return mlx90393_check_status(cmd, rx[0]);
+}
+
+static int mlx90393_read_reg(struct mlx90393_data *data,
+			     u8 reg, u16 *val)
+{
+	u8 tx[2];
+	u8 rx[3];
+	int ret;
+
+	tx[0] = MLX90393_CMD_RR;
+	/* Register address is encoded in bits [7:2] */
+	tx[1] = reg << 2;
+
+	ret = mlx90393_xfer(data,
+			    tx, sizeof(tx),
+			    rx, sizeof(rx));
+	if (ret)
+		return ret;
+
+	ret = mlx90393_check_status(tx[0], rx[0]);
+	if (ret)
+		return ret;
+
+	*val = get_unaligned_be16(&rx[1]);
+
+	return 0;
+}
+
+static int mlx90393_write_reg(struct mlx90393_data *data,
+			      u8 reg, u16 val)
+{
+	u8 tx[4];
+	u8 status;
+	int ret;
+
+	tx[0] = MLX90393_CMD_WR;
+	put_unaligned_be16(val, &tx[1]);
+	/* Register address is encoded in bits [7:2] */
+	tx[3] = reg << 2;
+
+	ret = mlx90393_xfer(data,
+			    tx, sizeof(tx),
+			    &status, 1);
+	if (ret)
+		return ret;
+
+	return mlx90393_check_status(tx[0], status);
+}
+
+static int mlx90393_update_bits(struct mlx90393_data *data,
+				u8 reg_addr,
+				u16 mask, u16 val)
+{
+	u16 reg;
+	int ret;
+
+	ret = mlx90393_read_reg(data, reg_addr, &reg);
+	if (ret)
+		return ret;
+
+	reg &= ~mask;
+	reg |= (val << __ffs(mask)) & mask;
+
+	return mlx90393_write_reg(data, reg_addr, reg);
+}
+
+static int mlx90393_read_measurement(struct mlx90393_data *data,
+				     enum mlx90393_channels chan, int *val)
+{
+	u8 cmd;
+	u8 rx[9];
+	int ret;
+	int tconv_us = mlx90393_get_tconv_us(data);
+
+	/* Start measurement */
+	cmd = MLX90393_CMD_SM | MLX90393_MEASURE_ALL;
+
+	ret = mlx90393_write_cmd(data, cmd);
+	if (ret)
+		return ret;
+
+	/* Wait conversion */
+	usleep_range(tconv_us, tconv_us + 1000);
+
+	/* Read measurement */
+	cmd = MLX90393_CMD_RM | MLX90393_MEASURE_ALL;
+
+	ret = mlx90393_read_cmd(data, cmd, rx, sizeof(rx));
+	if (ret)
+		return ret;
+	/*
+	 * Measurement response layout:
+	 * [status][temp][x][y][z]
+	 */
+
+	switch (chan) {
+	case MLX90393_CHAN_TEMP:
+		*val = get_unaligned_be16(&rx[1]);
+		break;
+
+	case MLX90393_CHAN_X:
+		*val = sign_extend32(get_unaligned_be16(&rx[3]), 15);
+		break;
+
+	case MLX90393_CHAN_Y:
+		*val = sign_extend32(get_unaligned_be16(&rx[5]), 15);
+		break;
+
+	case MLX90393_CHAN_Z:
+		*val = sign_extend32(get_unaligned_be16(&rx[7]), 15);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mlx90393_get_scale(struct mlx90393_data *data,
+			      const struct iio_chan_spec *chan,
+			      int *val, int *val2)
+{
+	enum mlx90393_axis_type axis;
+	u8 res;
+
+	if (chan->channel2 == IIO_MOD_Z) {
+		axis = MLX90393_AXIS_TYPE_Z;
+		res = data->res_z;
+	} else {
+		axis = MLX90393_AXIS_TYPE_XY;
+		res = data->res_xy;
+	}
+
+	/*
+	 * Convert:
+	 * µT × 1000 → nT
+	 */
+	*val = 0;
+	*val2 = mlx90393_scale_table[axis][data->gain_sel][res];
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int mlx90393_find_scale(struct mlx90393_data *data,
+			       bool z_axis,
+			       int val, int val2,
+			       int *gain)
+{
+	int i;
+	u8 res;
+	enum mlx90393_axis_type axis;
+
+	axis = z_axis ? MLX90393_AXIS_TYPE_Z :
+		MLX90393_AXIS_TYPE_XY;
+
+	res = z_axis ? data->res_z : data->res_xy;
+
+	if (val != 0)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(mlx90393_scale_table[0]); i++) {
+		if (mlx90393_scale_table[axis][i][res]
+				== val2) {
+			*gain = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int mlx90393_set_scale(struct mlx90393_data *data,
+			      const struct iio_chan_spec *chan,
+			      int val, int val2)
+{
+	bool z_axis;
+	int gain;
+	int ret;
+
+	z_axis = chan->channel2 == IIO_MOD_Z;
+
+	ret = mlx90393_find_scale(data, z_axis,
+				  val, val2,
+				  &gain);
+	if (ret)
+		return ret;
+
+	ret = mlx90393_update_bits(data,
+				   MLX90393_REG_CONF1,
+				   MLX90393_CONF1_GAIN_SEL,
+				   gain);
+	if (ret)
+		return ret;
+
+	data->gain_sel = gain;
+
+	return 0;
+}
+
+static int mlx90393_get_osr(struct mlx90393_data *data, int *val)
+{
+	*val = mlx90393_osr_avail[data->osr];
+
+	return IIO_VAL_INT;
+}
+
+static int mlx90393_find_osr(int val, int *osr)
+{
+	int i;
+
+	for (i = 0; i < MLX90393_OSR_MAX;  i++) {
+		if (mlx90393_osr_avail[i] == val) {
+			*osr = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int mlx90393_get_temp_osr2(struct mlx90393_data *data, int *val)
+{
+	*val = mlx90393_osr2_avail[data->osr2];
+	return IIO_VAL_INT;
+}
+
+static int mlx90393_set_osr(struct mlx90393_data *data, int val)
+{
+	int osr;
+	int ret;
+
+	ret = mlx90393_find_osr(val, &osr);
+	if (ret)
+		return ret;
+
+	if (osr == data->osr)
+		return 0;
+
+	ret = mlx90393_update_bits(data, MLX90393_REG_CONF3,
+				   MLX90393_CONF3_OSR,
+				   osr);
+	if (ret)
+		return ret;
+
+	data->osr = osr;
+	return 0;
+}
+
+static int mlx90393_set_temp_osr2(struct mlx90393_data *data, int val)
+{
+	int ret;
+
+	if (val < 0 || val >= MLX90393_OSR2_MAX)
+		return -EINVAL;
+
+	if (val == data->osr2)
+		return 0;
+
+	ret = mlx90393_update_bits(data, MLX90393_REG_CONF3,
+				   MLX90393_CONF3_OSR2,
+				   val);
+	if (ret)
+		return ret;
+
+	data->osr2 = val;
+
+	return 0;
+}
+
+static int mlx90393_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mlx90393_write_raw(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      int val, int val2,
+			      long mask)
+{
+	struct mlx90393_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		mutex_lock(&data->lock);
+		ret = mlx90393_set_scale(data, chan, val, val2);
+		mutex_unlock(&data->lock);
+		return ret;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		mutex_lock(&data->lock);
+		if (chan->type == IIO_TEMP)
+			ret = mlx90393_set_temp_osr2(data, val);
+		else if (chan->type == IIO_MAGN)
+			ret = mlx90393_set_osr(data, val);
+		else
+			ret = -EINVAL;
+		mutex_unlock(&data->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mlx90393_read_raw(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan,
+			     int *val, int *val2, long mask)
+{
+	struct mlx90393_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&data->lock);
+		ret = mlx90393_read_measurement(data, chan->address, val);
+		mutex_unlock(&data->lock);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_MAGN:
+			return mlx90393_get_scale(data, chan, val, val2);
+
+		case IIO_TEMP:
+			/* Datasheet: 22124 millidegC/LSB */
+			*val = 0;
+			*val2 = 22124;
+			return IIO_VAL_INT_PLUS_MICRO;
+
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			/* Datasheet: temperature offset */
+			*val = -45114;
+			return IIO_VAL_INT;
+		}
+		return -EINVAL;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		if (chan->type == IIO_TEMP)
+			return mlx90393_get_temp_osr2(data, val);
+		if (chan->type == IIO_MAGN)
+			return mlx90393_get_osr(data, val);
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mlx90393_read_avail(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       const int **vals,
+			       int *type,
+			       int *length,
+			       long mask)
+{
+	struct mlx90393_data *data = iio_priv(indio_dev);
+
+	static int scale_avail[MLX90393_GAIN_MAX][MLX90393_AXIS_MAX];
+	enum mlx90393_axis_type axis;
+	int i;
+	u8 res;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		axis = chan->channel2 == IIO_MOD_Z;
+		res = axis ? data->res_z : data->res_xy;
+
+		for (i = 0; i < MLX90393_GAIN_MAX; i++) {
+			scale_avail[i][0] = 0;
+			scale_avail[i][1] =
+				mlx90393_scale_table[axis][i][res];
+		}
+
+		*vals = &scale_avail[0][0];
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = MLX90393_GAIN_MAX * MLX90393_AXIS_MAX;
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		if (chan->type == IIO_TEMP) {
+			*vals = mlx90393_osr2_avail;
+			*type = IIO_VAL_INT;
+			*length = MLX90393_OSR2_MAX;
+		} else {
+			*vals = mlx90393_osr_avail;
+			*type = IIO_VAL_INT;
+			*length = MLX90393_OSR_MAX;
+		}
+
+		break;
+	default:
+		return -EINVAL;
+	}
+	return IIO_AVAIL_LIST;
+}
+
+static const struct iio_info mlx90393_info = {
+	.read_raw = mlx90393_read_raw,
+	.write_raw = mlx90393_write_raw,
+	.read_avail = mlx90393_read_avail,
+	.write_raw_get_fmt = mlx90393_write_raw_get_fmt,
+};
+
+static int mlx90393_init(struct mlx90393_data *data)
+{
+	int ret;
+	u8 cmd;
+	u16 reg;
+
+	/* Exit mode */
+	cmd = MLX90393_CMD_EX;
+	ret = mlx90393_write_cmd(data, cmd);
+	if (ret)
+		return ret;
+
+	usleep_range(1000, 1500);
+
+	/* Reset device */
+	cmd = MLX90393_CMD_RT;
+	ret = mlx90393_write_cmd(data, cmd);
+	if (ret)
+		return ret;
+
+	/* Wait for device to reset */
+	usleep_range(5000, 6000);
+
+	ret = mlx90393_read_reg(data, MLX90393_REG_CONF1, &reg);
+	if (ret)
+		return ret;
+
+	data->gain_sel = FIELD_GET(MLX90393_CONF1_GAIN_SEL, reg);
+	data->hallconf = FIELD_GET(MLX90393_CONF1_HALLCONF, reg);
+
+	ret = mlx90393_read_reg(data, MLX90393_REG_CONF3, &reg);
+	if (ret)
+		return ret;
+
+	data->res_xy = FIELD_GET(MLX90393_CONF3_RES_X, reg);
+	data->res_z = FIELD_GET(MLX90393_CONF3_RES_Z, reg);
+	data->dig_filt = FIELD_GET(MLX90393_CONF3_DIG_FILT, reg);
+	data->osr = FIELD_GET(MLX90393_CONF3_OSR, reg);
+	data->osr2 = FIELD_GET(MLX90393_CONF3_OSR2, reg);
+
+	return 0;
+}
+
+int mlx90393_core_probe(struct device *dev,
+			const struct mlx90393_transfer_ops *ops,
+			void *context)
+{
+	struct iio_dev *indio_dev;
+	struct mlx90393_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	mutex_init(&data->lock);
+
+	data->dev = dev;
+	data->ops = ops;
+	data->bus_context = context;
+
+	indio_dev->name = "mlx90393";
+	indio_dev->info = &mlx90393_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mlx90393_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mlx90393_channels);
+
+	ret = mlx90393_init(data);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to initialize device\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_GPL(mlx90393_core_probe);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nikhil Gautam <nikhilgtr@gmail.com>");
+MODULE_DESCRIPTION("MLX90393 magnetometer sensor driver");
diff --git a/drivers/iio/magnetometer/mlx90393_i2c.c b/drivers/iio/magnetometer/mlx90393_i2c.c
new file mode 100644
index 000000000000..09d533a96907
--- /dev/null
+++ b/drivers/iio/magnetometer/mlx90393_i2c.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/i2c.h>
+
+#include "mlx90393.h"
+
+/*
+ * MLX90393 commands use repeated-start transfers where
+ * every command is followed by a status/data response.
+ */
+static int mlx90393_i2c_xfer(void *context,
+			     const u8 *tx, int tx_len,
+			     u8 *rx, int rx_len)
+{
+	struct i2c_client *client = context;
+	int ret;
+	struct i2c_msg msgs[2];
+
+	msgs[0].addr = client->addr;
+	msgs[0].flags = 0;
+	msgs[0].len = tx_len;
+	msgs[0].buf = (u8 *)tx;
+
+	msgs[1].addr = client->addr;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len = rx_len;
+	msgs[1].buf = rx;
+
+	ret = i2c_transfer(client->adapter, msgs, 2);
+	if (ret != 2)
+		return ret < 0 ? ret : -EIO;
+
+	return 0;
+}
+
+static const struct mlx90393_transfer_ops mlx90393_i2c_ops = {
+	.xfer = mlx90393_i2c_xfer,
+};
+
+static int mlx90393_i2c_probe(struct i2c_client *client)
+{
+	return mlx90393_core_probe(&client->dev,
+				  &mlx90393_i2c_ops,
+				  client);
+}
+
+static const struct i2c_device_id mlx90393_id[] = {
+	{ "mlx90393", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mlx90393_id);
+
+static const struct of_device_id mlx90393_of_match[] = {
+	{ .compatible = "melexis,mlx90393" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mlx90393_of_match);
+
+static struct i2c_driver mlx90393_i2c_driver = {
+	.driver = {
+		.name = "mlx90393",
+		.of_match_table = mlx90393_of_match,
+	},
+	.probe = mlx90393_i2c_probe,
+};
+
+module_i2c_driver(mlx90393_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nikhil Gautam <nikhilgtr@gmail.com>");
+MODULE_DESCRIPTION("MLX90393 magnetometer sensor driver");
-- 
2.39.5

