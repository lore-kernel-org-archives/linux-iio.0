Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA9314B82
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772970004; cv=none; b=ar2t+Wx/NsYc9tz2V5znK2NV4p9Tj9XMPoQTmZJC/OaifSjHWNHMXjal9a9S1GKOOdJLrxmXjP8qvXZhKNirl6ePLgCAhWm3mTDE70ZYrjWBLJpkP+6FVsNS/PJEKXcBszjLBlxAxTALynBJch0vlsX7uYAsboEAzMFRVDWju2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772970004; c=relaxed/simple;
	bh=V6GGjstbBh5cSAk4Q/pJtLbkbV08TUYGkGG3XNQtH10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laIfWY2r9qbDBrSKBNkxxgnN8PUlG3PtuC7TDgYwDKWyrSUh1v2cg4TsijJSwyVsqgg7kG97VdJsZPPr7/OZcqeKlQDiSumoaVICxWtgngQSu5oPzey/O2lCV/CaV0JCBjl2kALjmaCw8Qu0hFz0q2BEeI1QMpr2XQzEDpVqDik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829b8b6c4d0so1030154b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 04:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772970002; x=1773574802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+I7de+6lOsZ+v8mCR5kjAYqGiDcxa7XoVP7Hm3raBM=;
        b=qNFjQo1PkKBsQnoVRrR3RdQ4Y7L2/KNoisCdunpoRrQyzuvhr1YX3r5y5cx2w69kPj
         a7IIsr0R9V3SZrblS6uKniUTHPsmcACYdCqIv9WYlq35LSVBiMASiGMw07QrNnaGQOaV
         k5+U0emoT4gISj4fOoCs1x0Bryi/uBpYBQrdbYU8OSvA+fXtAzIi+AHC7U3A14ja0Wg5
         aQDYfBtgnrSdLlMJ6at5dWeAcUrTfrqDdq/C7hrTePAW2CovyGPBeeBNbSlUANKEMSCy
         RQ5r7/p5mwcFH4taUhwEC+sp8Ul+0aMlwG1SETtnvaeqfIsgdhRaOjQ6bE8SIltMajyg
         Yd2A==
X-Gm-Message-State: AOJu0YxxDIZIqG/Kw74/wbwFXw3BbdeO4Qa8uQPBnSaqe3b51m50XvE7
	8IIRvRJRTMlsUykBlWmTLPOPHFjRlINLtCuHN5tsdcouP91cBuprZArVMMc1C1+6AzinOA==
X-Gm-Gg: ATEYQzylZyvh52vqsUZ2X8ywq0+xzN9LjwQ4S16gdudXAfTDIHf0UiTQy7AG64a2WSl
	MZ3GicJ3XyNJ75x6tH8UDWliIwIcs4Oh0Hdw9Wo9M398r+Xe5URDCgKXyRY1/vHOCid5t0Ojwp5
	Fw6r9WQxckRwU9QOJi3kf8uKC8R55bNAQZ+iJEkpn3HKbHY5luZICxsKg5lyTnrComCGaytFJG5
	sLxKDnEPgMT/CSoxq9KXgmgYAysY9Ms/MH58Oxkbu4HP07gmLQtz84UVTFs55tTgrsYtj99ji4q
	QJ0P0PWobuf0/F+f1lmd3+9vvhJ9U7s4XKIBmXZivabkoQsZg2AVyOgRK2gsQvY7uBFGD+sVjEd
	lflkd6X6XVT39mzlGgHJK6D+1r9dEgRCuvTNMCze5ECbPSfYtC1youtsZAxcZJ6JOubXYi/z0zI
	K9+/ZEGQ1v6P65Trum
X-Received: by 2002:a05:6a00:2e23:b0:81d:dd3a:b8fa with SMTP id d2e1a72fcca58-829a30c1ffamr7372574b3a.50.1772970001877;
        Sun, 08 Mar 2026 04:40:01 -0700 (PDT)
Received: from archlinux ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48d372esm7063721b3a.61.2026.03.08.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 04:40:01 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH v2 2/2] iio: proximity: add driver for ST VL53L1X ToF sensor
Date: Sun,  8 Mar 2026 17:37:28 +0600
Message-ID: <20260308113728.40860-3-email@sirat.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308113728.40860-1-email@sirat.me>
References: <20260308113728.40860-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the STMicroelectronics VL53L1X Time-of-Flight
ranging sensor with I2C interface.

Signed-off-by: Siratul Islam <email@sirat.me>
---
 MAINTAINERS                         |   1 +
 drivers/iio/proximity/Kconfig       |  14 +
 drivers/iio/proximity/Makefile      |   1 +
 drivers/iio/proximity/vl53l1x-i2c.c | 871 ++++++++++++++++++++++++++++
 4 files changed, 887 insertions(+)
 create mode 100644 drivers/iio/proximity/vl53l1x-i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 01c8e6bac322..cb8ee607fda1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25098,6 +25098,7 @@ M:	Siratul Islam <email@sirat.me>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
+F:	drivers/iio/proximity/vl53l1x-i2c.c
 
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 6070974c2c85..3b0fdeb03ecd 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -244,6 +244,20 @@ config VL53L0X_I2C
 	  To compile this driver as a module, choose M here: the
 	  module will be called vl53l0x-i2c.
 
+config VL53L1X_I2C
+	tristate "STMicroelectronics VL53L1X ToF ranger sensor (I2C)"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_I2C
+	help
+	  Say Y here to build a driver for STMicroelectronics VL53L1X
+	  ToF ranger sensors with i2c interface.
+	  This driver can be used to measure the distance of objects.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called vl53l1x-i2c.
+
 config AW96103
 	tristate "AW96103/AW96105 Awinic proximity sensor"
 	select REGMAP_I2C
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index 152034d38c49..4352833dd8a4 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -23,5 +23,6 @@ obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
 obj-$(CONFIG_SX9500)		+= sx9500.o
 obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
 obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
+obj-$(CONFIG_VL53L1X_I2C)	+= vl53l1x-i2c.o
 obj-$(CONFIG_AW96103)		+= aw96103.o
 
diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
new file mode 100644
index 000000000000..3ebcaf37f502
--- /dev/null
+++ b/drivers/iio/proximity/vl53l1x-i2c.c
@@ -0,0 +1,871 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Support for ST VL53L1X FlightSense ToF Ranging Sensor on a i2c bus.
+ *
+ * Copyright (C) 2026 Siratul Islam <email@sirat.me>
+ *
+ * Datasheet available at
+ * <https://www.st.com/resource/en/datasheet/vl53l1x.pdf>
+ *
+ * Default 7-bit i2c slave address 0x29.
+ *
+ * The VL53L1X requires a firmware configuration blob to be loaded at boot.
+ * Register values for the default configuration are taken from
+ * ST's VL53L1X Ultra Lite Driver (STSW-IMG009).
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define VL53L1X_SOFT_RESET					0x0000
+#define VL53L1X_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND		0x0008
+#define VL53L1X_VHV_CONFIG__INIT				0x000B
+#define VL53L1X_GPIO_HV_MUX__CTRL				0x0030
+#define VL53L1X_GPIO__TIO_HV_STATUS				0x0031
+#define VL53L1X_SYSTEM__INTERRUPT_CONFIG_GPIO			0x0046
+#define VL53L1X_PHASECAL_CONFIG__TIMEOUT_MACROP			0x004B
+#define VL53L1X_RANGE_CONFIG__TIMEOUT_MACROP_A			0x005E
+#define VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_A			0x0060
+#define VL53L1X_RANGE_CONFIG__TIMEOUT_MACROP_B			0x0061
+#define VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_B			0x0063
+#define VL53L1X_RANGE_CONFIG__VALID_PHASE_HIGH			0x0069
+#define VL53L1X_SYSTEM__INTERMEASUREMENT_PERIOD			0x006C
+#define VL53L1X_SD_CONFIG__WOI_SD0				0x0078
+#define VL53L1X_SD_CONFIG__WOI_SD1				0x0079
+#define VL53L1X_SD_CONFIG__INITIAL_PHASE_SD0			0x007A
+#define VL53L1X_SD_CONFIG__INITIAL_PHASE_SD1			0x007B
+#define VL53L1X_SYSTEM__INTERRUPT_CLEAR				0x0086
+#define VL53L1X_SYSTEM__MODE_START				0x0087
+#define VL53L1X_RESULT__RANGE_STATUS				0x0089
+#define VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0	0x0096
+#define VL53L1X_RESULT__OSC_CALIBRATE_VAL			0x00DE
+#define VL53L1X_FIRMWARE__SYSTEM_STATUS				0x00E5
+#define VL53L1X_IDENTIFICATION__MODEL_ID			0x010F
+
+#define VL53L1X_MODEL_ID_VAL		0xEACC
+
+#define VL53L1X_DEFAULT_CONFIG_ADDR	0x2D
+
+#define VL53L1X_MODE_START_TIMED	0x40
+#define VL53L1X_MODE_START_STOP		0x00
+
+#define VL53L1X_INT_NEW_SAMPLE_READY	0x02
+
+#define VL53L1X_GPIO_HV_MUX_POLARITY	BIT(4)
+
+#define VL53L1X_VHV_LOOP_BOUND_TWO	0x09
+
+#define VL53L1X_RANGE_STATUS_MASK	GENMASK(4, 0)
+#define VL53L1X_RANGE_STATUS_VALID	9
+
+/* Inter-measurement period uses PLL divider with 1.075 oscillator correction */
+#define VL53L1X_OSC_CALIBRATE_MASK	GENMASK(9, 0)
+#define VL53L1X_OSC_CORRECTION_FACTOR	1075
+#define VL53L1X_OSC_CORRECTION_DIVISOR	1000
+
+enum vl53l1x_distance_mode {
+	VL53L1X_SHORT,
+	VL53L1X_LONG,
+};
+
+struct vl53l1x_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct completion completion;
+	struct regulator *vdd_supply;
+	struct gpio_desc *xshut_gpio;
+	enum vl53l1x_distance_mode distance_mode;
+	u16 osc_calibrate_val;
+	u8 gpio_polarity;
+};
+
+static const struct regmap_config vl53l1x_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+};
+
+static int vl53l1x_read_u16(struct vl53l1x_data *data, u16 reg, u16 *val)
+{
+	__be16 buf;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, reg, &buf, 2);
+	if (ret)
+		return ret;
+
+	*val = be16_to_cpu(buf);
+	return 0;
+}
+
+static int vl53l1x_write_u16(struct vl53l1x_data *data, u16 reg, u16 val)
+{
+	__be16 buf = cpu_to_be16(val);
+
+	return regmap_bulk_write(data->regmap, reg, &buf, 2);
+}
+
+static int vl53l1x_write_u32(struct vl53l1x_data *data, u16 reg, u32 val)
+{
+	__be32 buf = cpu_to_be32(val);
+
+	return regmap_bulk_write(data->regmap, reg, &buf, 4);
+}
+
+static int vl53l1x_clear_irq(struct vl53l1x_data *data)
+{
+	return regmap_write(data->regmap, VL53L1X_SYSTEM__INTERRUPT_CLEAR,
+			    0x01);
+}
+
+static int vl53l1x_start_ranging(struct vl53l1x_data *data)
+{
+	int ret;
+
+	ret = vl53l1x_clear_irq(data);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, VL53L1X_SYSTEM__MODE_START,
+			    VL53L1X_MODE_START_TIMED);
+}
+
+static int vl53l1x_stop_ranging(struct vl53l1x_data *data)
+{
+	return regmap_write(data->regmap, VL53L1X_SYSTEM__MODE_START,
+			    VL53L1X_MODE_START_STOP);
+}
+
+static int vl53l1x_data_ready(struct vl53l1x_data *data, bool *ready)
+{
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(data->regmap, VL53L1X_GPIO__TIO_HV_STATUS, &status);
+	if (ret)
+		return ret;
+
+	*ready = (status & 0x01) == (!data->gpio_polarity);
+	return 0;
+}
+
+/*
+ * Default configuration blob from ST's VL53L1X ULD (STSW-IMG009).
+ */
+static const u8 vl53l1x_default_config[] = {
+	0x00, /* 0x2D */
+	0x00, /* 0x2E */
+	0x00, /* 0x2F */
+	0x01, /* 0x30 */
+	0x02, /* 0x31 */
+	0x00, /* 0x32 */
+	0x02, /* 0x33 */
+	0x08, /* 0x34 */
+	0x00, /* 0x35 */
+	0x08, /* 0x36 */
+	0x10, /* 0x37 */
+	0x01, /* 0x38 */
+	0x01, /* 0x39 */
+	0x00, /* 0x3A */
+	0x00, /* 0x3B */
+	0x00, /* 0x3C */
+	0x00, /* 0x3D */
+	0xFF, /* 0x3E */
+	0x00, /* 0x3F */
+	0x0F, /* 0x40 */
+	0x00, /* 0x41 */
+	0x00, /* 0x42 */
+	0x00, /* 0x43 */
+	0x00, /* 0x44 */
+	0x00, /* 0x45 */
+	0x20, /* 0x46 */
+	0x0B, /* 0x47 */
+	0x00, /* 0x48 */
+	0x00, /* 0x49 */
+	0x02, /* 0x4A */
+	0x0A, /* 0x4B */
+	0x21, /* 0x4C */
+	0x00, /* 0x4D */
+	0x00, /* 0x4E */
+	0x05, /* 0x4F */
+	0x00, /* 0x50 */
+	0x00, /* 0x51 */
+	0x00, /* 0x52 */
+	0x00, /* 0x53 */
+	0xC8, /* 0x54 */
+	0x00, /* 0x55 */
+	0x00, /* 0x56 */
+	0x38, /* 0x57 */
+	0xFF, /* 0x58 */
+	0x01, /* 0x59 */
+	0x00, /* 0x5A */
+	0x08, /* 0x5B */
+	0x00, /* 0x5C */
+	0x00, /* 0x5D */
+	0x01, /* 0x5E */
+	0xCC, /* 0x5F */
+	0x0F, /* 0x60 */
+	0x01, /* 0x61 */
+	0xF1, /* 0x62 */
+	0x0D, /* 0x63 */
+	0x01, /* 0x64 */
+	0x68, /* 0x65 */
+	0x00, /* 0x66 */
+	0x80, /* 0x67 */
+	0x08, /* 0x68 */
+	0xB8, /* 0x69 */
+	0x00, /* 0x6A */
+	0x00, /* 0x6B */
+	0x00, /* 0x6C */
+	0x00, /* 0x6D */
+	0x0F, /* 0x6E */
+	0x89, /* 0x6F */
+	0x00, /* 0x70 */
+	0x00, /* 0x71 */
+	0x00, /* 0x72 */
+	0x00, /* 0x73 */
+	0x00, /* 0x74 */
+	0x00, /* 0x75 */
+	0x00, /* 0x76 */
+	0x01, /* 0x77 */
+	0x0F, /* 0x78 */
+	0x0D, /* 0x79 */
+	0x0E, /* 0x7A */
+	0x0E, /* 0x7B */
+	0x00, /* 0x7C */
+	0x00, /* 0x7D */
+	0x02, /* 0x7E */
+	0xC7, /* 0x7F */
+	0xFF, /* 0x80 */
+	0x9B, /* 0x81 */
+	0x00, /* 0x82 */
+	0x00, /* 0x83 */
+	0x00, /* 0x84 */
+	0x01, /* 0x85 */
+	0x00, /* 0x86 */
+	0x00, /* 0x87 */
+};
+
+static int vl53l1x_chip_init(struct vl53l1x_data *data)
+{
+	struct device *dev = &data->client->dev;
+	unsigned int val;
+	u16 model_id;
+	int tries = 1000;
+	bool ready;
+	int ret;
+
+	if (!data->xshut_gpio) {
+		ret = regmap_write(data->regmap, VL53L1X_SOFT_RESET, 0x00);
+		if (ret)
+			return ret;
+		fsleep(100); /* conservative reset pulse, no spec */
+
+		ret = regmap_write(data->regmap, VL53L1X_SOFT_RESET, 0x01);
+		if (ret)
+			return ret;
+		fsleep(1000); /* conservative boot wait, no spec */
+	}
+
+	ret = regmap_read_poll_timeout(data->regmap,
+				       VL53L1X_FIRMWARE__SYSTEM_STATUS, val,
+				       val & BIT(0), 1000, 100000);
+	if (ret) {
+		dev_err(dev, "firmware boot timeout\n");
+		return ret;
+	}
+
+	ret = vl53l1x_read_u16(data, VL53L1X_IDENTIFICATION__MODEL_ID,
+			       &model_id);
+	if (ret)
+		return ret;
+
+	if (model_id != VL53L1X_MODEL_ID_VAL)
+		dev_info(dev, "unknown model id: 0x%04x, continuing\n", model_id);
+
+	ret = vl53l1x_read_u16(data, VL53L1X_RESULT__OSC_CALIBRATE_VAL,
+			       &data->osc_calibrate_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_write(data->regmap, VL53L1X_DEFAULT_CONFIG_ADDR,
+				vl53l1x_default_config,
+				sizeof(vl53l1x_default_config));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, VL53L1X_GPIO_HV_MUX__CTRL, &val);
+	if (ret)
+		return ret;
+	data->gpio_polarity = !!(val & VL53L1X_GPIO_HV_MUX_POLARITY);
+
+	/* Initial ranging cycle for VHV calibration */
+	ret = vl53l1x_start_ranging(data);
+	if (ret)
+		return ret;
+
+	do {
+		ret = vl53l1x_data_ready(data, &ready);
+		if (ret)
+			return ret;
+		if (ready)
+			break;
+		/* 1ms poll, 1s timeout covers max timing budgets (per ST ULD) */
+		fsleep(1000);
+	} while (--tries);
+
+	if (!tries)
+		return -ETIMEDOUT;
+
+	ret = vl53l1x_clear_irq(data);
+	if (ret)
+		return ret;
+
+	ret = vl53l1x_stop_ranging(data);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap,
+			   VL53L1X_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND,
+			   VL53L1X_VHV_LOOP_BOUND_TWO);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, VL53L1X_VHV_CONFIG__INIT, 0x00);
+}
+
+static const struct reg_sequence vl53l1x_mode_short[] = {
+	{ VL53L1X_PHASECAL_CONFIG__TIMEOUT_MACROP,	0x14 },
+	{ VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_A,		0x07 },
+	{ VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_B,		0x05 },
+	{ VL53L1X_RANGE_CONFIG__VALID_PHASE_HIGH,	0x38 },
+	{ VL53L1X_SD_CONFIG__WOI_SD0,			0x07 },
+	{ VL53L1X_SD_CONFIG__WOI_SD1,			0x05 },
+	{ VL53L1X_SD_CONFIG__INITIAL_PHASE_SD0,		6 },
+	{ VL53L1X_SD_CONFIG__INITIAL_PHASE_SD1,		6 },
+};
+
+static const struct reg_sequence vl53l1x_mode_long[] = {
+	{ VL53L1X_PHASECAL_CONFIG__TIMEOUT_MACROP,	0x0A },
+	{ VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_A,		0x0F },
+	{ VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_B,		0x0D },
+	{ VL53L1X_RANGE_CONFIG__VALID_PHASE_HIGH,	0xB8 },
+	{ VL53L1X_SD_CONFIG__WOI_SD0,			0x0F },
+	{ VL53L1X_SD_CONFIG__WOI_SD1,			0x0D },
+	{ VL53L1X_SD_CONFIG__INITIAL_PHASE_SD0,		14 },
+	{ VL53L1X_SD_CONFIG__INITIAL_PHASE_SD1,		14 },
+};
+
+static const struct {
+	const struct reg_sequence *regs;
+	size_t num_regs;
+} vl53l1x_mode_configs[] = {
+	[VL53L1X_SHORT] = { vl53l1x_mode_short, ARRAY_SIZE(vl53l1x_mode_short) },
+	[VL53L1X_LONG]  = { vl53l1x_mode_long, ARRAY_SIZE(vl53l1x_mode_long) },
+};
+
+static int vl53l1x_set_distance_mode(struct vl53l1x_data *data,
+				     enum vl53l1x_distance_mode mode)
+{
+	int ret;
+
+	if (mode >= ARRAY_SIZE(vl53l1x_mode_configs))
+		return -EINVAL;
+
+	ret = regmap_multi_reg_write(data->regmap,
+				     vl53l1x_mode_configs[mode].regs,
+				     vl53l1x_mode_configs[mode].num_regs);
+	if (ret)
+		return ret;
+
+	data->distance_mode = mode;
+	return 0;
+}
+
+/*
+ * The timing budget controls how long the sensor spends collecting
+ * a single range measurement. Pre-computed TIMEOUT_MACROP register
+ * values from ST's VL53L1X ULD.
+ */
+static int vl53l1x_set_timing_budget(struct vl53l1x_data *data, u16 budget_ms)
+{
+	u16 timeout_a, timeout_b;
+	int ret;
+
+	switch (data->distance_mode) {
+	case VL53L1X_SHORT:
+		switch (budget_ms) {
+		case 15:
+			timeout_a = 0x001D;
+			timeout_b = 0x0027;
+			break;
+		case 20:
+			timeout_a = 0x0051;
+			timeout_b = 0x006E;
+			break;
+		case 33:
+			timeout_a = 0x00D6;
+			timeout_b = 0x006E;
+			break;
+		case 50:
+			timeout_a = 0x01AE;
+			timeout_b = 0x01E8;
+			break;
+		case 100:
+			timeout_a = 0x02E1;
+			timeout_b = 0x0388;
+			break;
+		case 200:
+			timeout_a = 0x03E1;
+			timeout_b = 0x0496;
+			break;
+		case 500:
+			timeout_a = 0x0591;
+			timeout_b = 0x05C1;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case VL53L1X_LONG:
+		switch (budget_ms) {
+		case 20:
+			timeout_a = 0x001E;
+			timeout_b = 0x0022;
+			break;
+		case 33:
+			timeout_a = 0x0060;
+			timeout_b = 0x006E;
+			break;
+		case 50:
+			timeout_a = 0x00AD;
+			timeout_b = 0x00C6;
+			break;
+		case 100:
+			timeout_a = 0x01CC;
+			timeout_b = 0x01EA;
+			break;
+		case 200:
+			timeout_a = 0x02D9;
+			timeout_b = 0x02F8;
+			break;
+		case 500:
+			timeout_a = 0x048F;
+			timeout_b = 0x04A4;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = vl53l1x_write_u16(data, VL53L1X_RANGE_CONFIG__TIMEOUT_MACROP_A,
+				timeout_a);
+	if (ret)
+		return ret;
+
+	return vl53l1x_write_u16(data, VL53L1X_RANGE_CONFIG__TIMEOUT_MACROP_B,
+				 timeout_b);
+}
+
+static int vl53l1x_set_inter_measurement_ms(struct vl53l1x_data *data,
+					    u16 period_ms)
+{
+	u16 clock_pll = data->osc_calibrate_val & VL53L1X_OSC_CALIBRATE_MASK;
+	u32 inter_meas;
+
+	inter_meas = (u32)clock_pll * (u32)period_ms;
+	inter_meas = (inter_meas * VL53L1X_OSC_CORRECTION_FACTOR) /
+		     VL53L1X_OSC_CORRECTION_DIVISOR;
+
+	return vl53l1x_write_u32(data, VL53L1X_SYSTEM__INTERMEASUREMENT_PERIOD,
+				 inter_meas);
+}
+
+static int vl53l1x_read_proximity(struct vl53l1x_data *data, int *val)
+{
+	unsigned long time_left;
+	unsigned int range_status;
+	u16 distance;
+	int tries = 1000;
+	bool ready;
+	int ret;
+
+	if (data->client->irq) {
+		reinit_completion(&data->completion);
+
+		ret = vl53l1x_clear_irq(data);
+		if (ret)
+			return ret;
+
+		time_left = wait_for_completion_timeout(&data->completion, HZ);
+		if (time_left == 0)
+			return -ETIMEDOUT;
+	} else {
+		do {
+			ret = vl53l1x_data_ready(data, &ready);
+			if (ret)
+				return ret;
+
+			if (ready)
+				break;
+			/* 1ms poll, 1s timeout covers max timing budgets (per ST ULD) */
+			fsleep(1000);
+		} while (--tries);
+
+		if (!tries)
+			return -ETIMEDOUT;
+	}
+
+	ret = regmap_read(data->regmap, VL53L1X_RESULT__RANGE_STATUS,
+			  &range_status);
+	if (ret)
+		goto clear_irq;
+
+	if (FIELD_GET(VL53L1X_RANGE_STATUS_MASK, range_status) != VL53L1X_RANGE_STATUS_VALID) {
+		ret = -EIO;
+		goto clear_irq;
+	}
+
+	ret = vl53l1x_read_u16(data,
+			       VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
+			       &distance);
+	if (ret)
+		goto clear_irq;
+
+	dev_dbg(&data->client->dev, "distance=%u\n", distance);
+
+	*val = distance;
+
+clear_irq:
+	vl53l1x_clear_irq(data);
+	return ret;
+}
+
+static const struct iio_chan_spec vl53l1x_channels[] = {
+	{
+		.type = IIO_DISTANCE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static int vl53l1x_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan, int *val,
+			    int *val2, long mask)
+{
+	struct vl53l1x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_DISTANCE)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = vl53l1x_read_proximity(data, val);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info vl53l1x_info = {
+	.read_raw = vl53l1x_read_raw,
+	.validate_trigger = iio_validate_own_trigger,
+};
+
+static irqreturn_t vl53l1x_trigger_handler(int irq, void *priv)
+{
+	struct iio_poll_func *pf = priv;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct vl53l1x_data *data = iio_priv(indio_dev);
+	struct {
+		u16 distance;
+		aligned_s64 timestamp;
+	} scan = {};
+	unsigned int range_status;
+	int ret;
+
+	ret = regmap_read(data->regmap, VL53L1X_RESULT__RANGE_STATUS,
+			  &range_status);
+	if (ret || FIELD_GET(VL53L1X_RANGE_STATUS_MASK, range_status) !=
+			   VL53L1X_RANGE_STATUS_VALID)
+		goto done;
+
+	ret = vl53l1x_read_u16(data,
+			       VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
+			       &scan.distance);
+	if (ret)
+		goto done;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
+					   iio_get_time_ns(indio_dev));
+
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+	vl53l1x_clear_irq(data);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t vl53l1x_irq_handler(int irq, void *priv)
+{
+	struct iio_dev *indio_dev = priv;
+	struct vl53l1x_data *data = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll(indio_dev->trig);
+	else
+		complete(&data->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int vl53l1x_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct vl53l1x_data *data = iio_priv(indio_dev);
+
+	return vl53l1x_start_ranging(data);
+}
+
+static int vl53l1x_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct vl53l1x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = vl53l1x_stop_ranging(data);
+	if (ret)
+		return ret;
+
+	reinit_completion(&data->completion);
+	wait_for_completion_timeout(&data->completion, HZ / 10);
+
+	return vl53l1x_clear_irq(data);
+}
+
+static const struct iio_buffer_setup_ops vl53l1x_buffer_setup_ops = {
+	.postenable = &vl53l1x_buffer_postenable,
+	.predisable = &vl53l1x_buffer_predisable,
+};
+
+static const struct iio_trigger_ops vl53l1x_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static void vl53l1x_stop_ranging_action(void *_data)
+{
+	vl53l1x_stop_ranging(_data);
+}
+
+static void vl53l1x_power_off(void *_data)
+{
+	struct vl53l1x_data *data = _data;
+
+	gpiod_set_value_cansleep(data->xshut_gpio, 1);
+	regulator_disable(data->vdd_supply);
+}
+
+static int vl53l1x_power_on(struct vl53l1x_data *data)
+{
+	int ret;
+
+	ret = regulator_enable(data->vdd_supply);
+	if (ret)
+		return ret;
+
+	gpiod_set_value_cansleep(data->xshut_gpio, 0);
+	fsleep(1200); /* 1.2 ms max boot duration per VL53L1X datasheet */
+
+	return 0;
+}
+
+static int vl53l1x_configure_irq(struct i2c_client *client,
+				 struct iio_dev *indio_dev)
+{
+	struct vl53l1x_data *data = iio_priv(indio_dev);
+	int irq_flags = irq_get_trigger_type(client->irq);
+	int ret;
+
+	ret = devm_request_irq(&client->dev, client->irq, vl53l1x_irq_handler,
+			       irq_flags | IRQF_NO_THREAD,
+			       indio_dev->name, indio_dev);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to request IRQ\n");
+
+	ret = regmap_write(data->regmap, VL53L1X_SYSTEM__INTERRUPT_CONFIG_GPIO,
+			   VL53L1X_INT_NEW_SAMPLE_READY);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to configure IRQ\n");
+
+	return 0;
+}
+
+static int vl53l1x_probe(struct i2c_client *client)
+{
+	struct vl53l1x_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
+				     I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EOPNOTSUPP;
+
+	data->regmap = devm_regmap_init_i2c(client, &vl53l1x_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
+				     "regmap initialization failed\n");
+
+	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_supply))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
+				     "Unable to get VDD regulator\n");
+
+	data->xshut_gpio =
+		devm_gpiod_get_optional(&client->dev, "xshut", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->xshut_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(data->xshut_gpio),
+				     "Cannot get xshut GPIO\n");
+
+	ret = vl53l1x_power_on(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to power on the chip\n");
+
+	ret = devm_add_action_or_reset(&client->dev, vl53l1x_power_off, data);
+	if (ret)
+		return ret;
+
+	ret = vl53l1x_chip_init(data);
+	if (ret)
+		return ret;
+
+	ret = vl53l1x_set_distance_mode(data, VL53L1X_LONG);
+	if (ret)
+		return ret;
+
+	ret = vl53l1x_set_timing_budget(data, 50);
+	if (ret)
+		return ret;
+
+	ret = vl53l1x_set_inter_measurement_ms(data, 50);
+	if (ret)
+		return ret;
+
+	ret = vl53l1x_start_ranging(data);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&client->dev,
+				       vl53l1x_stop_ranging_action, data);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "vl53l1x";
+	indio_dev->info = &vl53l1x_info;
+	indio_dev->channels = vl53l1x_channels;
+	indio_dev->num_channels = ARRAY_SIZE(vl53l1x_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	if (client->irq) {
+		struct iio_trigger *trig;
+
+		init_completion(&data->completion);
+
+		trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
+					      indio_dev->name,
+					      iio_device_id(indio_dev));
+		if (!trig)
+			return -ENOMEM;
+
+		trig->ops = &vl53l1x_trigger_ops;
+		iio_trigger_set_drvdata(trig, indio_dev);
+		ret = devm_iio_trigger_register(&client->dev, trig);
+		if (ret)
+			return ret;
+
+		indio_dev->trig = iio_trigger_get(trig);
+
+		ret = vl53l1x_configure_irq(client, indio_dev);
+		if (ret)
+			return ret;
+
+		ret = devm_iio_triggered_buffer_setup(&client->dev,
+						      indio_dev, NULL,
+						      &vl53l1x_trigger_handler,
+						      &vl53l1x_buffer_setup_ops);
+		if (ret)
+			return ret;
+	}
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id vl53l1x_id[] = {
+	{ "vl53l1x" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, vl53l1x_id);
+
+static const struct of_device_id st_vl53l1x_dt_match[] = {
+	{ .compatible = "st,vl53l1x" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, st_vl53l1x_dt_match);
+
+static struct i2c_driver vl53l1x_driver = {
+	.driver = {
+		.name = "vl53l1x-i2c",
+		.of_match_table = st_vl53l1x_dt_match,
+	},
+	.probe = vl53l1x_probe,
+	.id_table = vl53l1x_id,
+};
+module_i2c_driver(vl53l1x_driver);
+
+MODULE_AUTHOR("Siratul Islam <email@sirat.me>");
+MODULE_DESCRIPTION("ST VL53L1X ToF ranging sensor driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.53.0

