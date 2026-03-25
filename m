Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18935AC37
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420416; cv=none; b=ODHbH7DZ5KCBbJf7ctcj5u58qIx1JvoA/YCh6Z2sBT7lY+9mj2WxbbOoPWOjqCXKCoRjhs6tM3BmESZhKdw99miP6VChlaxsoHCt7sZ2j7YJffW+9tE59rin0r7e9Sa4/NFn8O60fI8Y9aoyLJ3hY4Ldapu6PUMvplX5qcS+PqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420416; c=relaxed/simple;
	bh=BM9NtnBmtRE16sQR9Mt07bfy0Xk9ULa0eV14ZxTiNOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Avd0OOLRnhAkpjjj6IJoGe9xITykbF0/1nFLaiVjYw4l3mwoAT8J23f78fd36kZESu1j2kaKPn+jGzfTnq4LwuMho2jFi3NJa2XFD1kO3/H9gli/W8KFwXuUXCYCadWifF8N4b3PWdED8u8MdyT/To4UmM5DYmw+AAEwfPU51UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so267348a91.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 23:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420411; x=1775025211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnscgcKvyUJ6G0BjSmVfmwSJQtdMI8GpRj+zzhI3JmE=;
        b=OM2bK9/AzQYaQLtmphd26JC6WNC4BKFWiRmD0JETWHbj3TXfiC/SKwmxR80QaAe2m/
         mX6N/iVQ7hP6/D+/Cp/m2Q1BdEejXmSxNvOu7CENKtd1XEWmcEy1p5SjZKLmRyCVbi8L
         oUUyQ3EuZq7GElrJN9WiCVwAxnNqk9qO850075b7gKgPLaX1wj89W/6HVOJfdWGkLG62
         PN/w8PTLwdFHDTtsF6pn3t6YCpK8NdqW1CNv/rL8b/GKwOOad1OiwDl7y/Q+MoMmZAeh
         /lBqQpWcuRyzD3yauU/5WbZDKtQQuFJYi3omlxO3EDxQYMU7uApk77sAildPnPcd5Z+c
         BeHA==
X-Gm-Message-State: AOJu0YyuXksJ9hcxn/icxU7kQ10coEfUSXsl8buR04jIBcEjfwFkDAg2
	vMdF86CrS6CDNreODWhb2jlOasixxw6PiTiQWnAp8/B+rtRrwFL/mPQOVvkF2w==
X-Gm-Gg: ATEYQzz2Cyo5jfplkOinUOKTlWeG5Xtflu2YwB8zbK9Su6bu/DhciuKJcVPo0/UTpZO
	sf4c8nRjIorAIc9pN2TUdFXyLir90UxTLIK+63y4P3+1OGLHiIpa8HJAcOd1JD6M35hxG9Hj+yw
	+KUA+CdytBGQyqBkfegPVTIoDhxw/xU4Xf2AVEU3+JBOjuupJICgRL65rG8ePN3Aq4lAoPtE5Jl
	VX90/hv7yzwvdQTvRjH/YYJfAaaQGpbM0OAjlCXbTN/Ogsw0Bd7nEjMu55USE8tYRLM+wRfcFQe
	YaQ6h30mKFsjUZ17VzsxJaJP53mZaxe+glnImHU502tPJcrzoScnX3vlYQU+reJyE1SpZGE+K1E
	+aHToOzp45XtuEIZRZpfBrpYRtcFeYO0fR1F1CJipXxeBHQvnmxkQ0doYiCSgLwtYpYabvB7one
	ZFgujQWoWWrlDr25360y8vHLq2QmtXfO+JuLDfpwtpcCJ83fOVQJIWel1szMw+1CN81Z6ekiOhc
	y352hCOtluc1Zci+Q==
X-Received: by 2002:a17:90a:d408:b0:35b:939c:e859 with SMTP id 98e67ed59e1d1-35c008d3cb6mr5186113a91.12.1774420411239;
        Tue, 24 Mar 2026 23:33:31 -0700 (PDT)
Received: from archlinux ([103.135.252.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0e954ba9sm526854a91.5.2026.03.24.23.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 23:33:30 -0700 (PDT)
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
	Siratul Islam <email@sirat.me>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v7 2/2] iio: proximity: add driver for ST VL53L1X ToF sensor
Date: Wed, 25 Mar 2026 12:32:23 +0600
Message-ID: <20260325063254.18062-3-email@sirat.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325063254.18062-1-email@sirat.me>
References: <20260325063254.18062-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the STMicroelectronics VL53L1X Time-of-Flight
ranging sensor with I2C interface.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Siratul Islam <email@sirat.me>
---
 MAINTAINERS                         |   1 +
 drivers/iio/proximity/Kconfig       |  15 +
 drivers/iio/proximity/Makefile      |   1 +
 drivers/iio/proximity/vl53l1x-i2c.c | 795 ++++++++++++++++++++++++++++
 4 files changed, 812 insertions(+)
 create mode 100644 drivers/iio/proximity/vl53l1x-i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a142a97be4cb..50531a87bf2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25098,6 +25098,7 @@ M:	Siratul Islam <email@sirat.me>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
+F:	drivers/iio/proximity/vl53l1x-i2c.c
 
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 6070974c2c85..bb77fad2a1b3 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -244,6 +244,21 @@ config VL53L0X_I2C
 	  To compile this driver as a module, choose M here: the
 	  module will be called vl53l0x-i2c.
 
+config VL53L1X_I2C
+	tristate "STMicroelectronics VL53L1X ToF ranger sensor (I2C)"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_I2C
+	select RESET_CONTROLLER
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
index 000000000000..085bff04f5d9
--- /dev/null
+++ b/drivers/iio/proximity/vl53l1x-i2c.c
@@ -0,0 +1,795 @@
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
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define VL53L1X_REG_SOFT_RESET						0x0000
+#define VL53L1X_REG_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND		0x0008
+#define VL53L1X_REG_VHV_CONFIG__INIT					0x000B
+#define VL53L1X_REG_GPIO_HV_MUX__CTRL					0x0030
+#define VL53L1X_REG_GPIO__TIO_HV_STATUS					0x0031
+#define VL53L1X_REG_SYSTEM__INTERRUPT_CONFIG_GPIO			0x0046
+#define VL53L1X_REG_PHASECAL_CONFIG__TIMEOUT_MACROP			0x004B
+#define VL53L1X_REG_RANGE_CONFIG__TIMEOUT_MACROP_A			0x005E
+#define VL53L1X_REG_RANGE_CONFIG__VCSEL_PERIOD_A			0x0060
+#define VL53L1X_REG_RANGE_CONFIG__TIMEOUT_MACROP_B			0x0061
+#define VL53L1X_REG_RANGE_CONFIG__VCSEL_PERIOD_B			0x0063
+#define VL53L1X_REG_RANGE_CONFIG__VALID_PHASE_HIGH			0x0069
+#define VL53L1X_REG_SYSTEM__INTERMEASUREMENT_PERIOD			0x006C
+#define VL53L1X_REG_SD_CONFIG__WOI_SD0					0x0078
+#define VL53L1X_REG_SD_CONFIG__WOI_SD1					0x0079
+#define VL53L1X_REG_SD_CONFIG__INITIAL_PHASE_SD0			0x007A
+#define VL53L1X_REG_SD_CONFIG__INITIAL_PHASE_SD1			0x007B
+#define VL53L1X_REG_SYSTEM__INTERRUPT_CLEAR				0x0086
+#define VL53L1X_REG_SYSTEM__MODE_START					0x0087
+#define VL53L1X_REG_RESULT__RANGE_STATUS				0x0089
+#define VL53L1X_REG_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0	0x0096
+#define VL53L1X_REG_RESULT__OSC_CALIBRATE_VAL				0x00DE
+#define VL53L1X_REG_FIRMWARE__SYSTEM_STATUS				0x00E5
+#define VL53L1X_REG_IDENTIFICATION__MODEL_ID				0x010F
+#define VL53L1X_REG_DEFAULT_CONFIG					0x002D
+
+#define VL53L1X_MODEL_ID_VAL		0xEACC
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
+#define VL53L1X_OSC_CALIBRATE_MASK	GENMASK(9, 0)
+
+/* Inter-measurement period uses PLL divider with 1.075 oscillator correction */
+static const struct u32_fract vl53l1x_osc_correction = {
+	.numerator = 1075,
+	.denominator = 1000,
+};
+
+enum vl53l1x_distance_mode {
+	VL53L1X_SHORT,
+	VL53L1X_LONG,
+};
+
+struct vl53l1x_data {
+	struct regmap *regmap;
+	struct completion completion;
+	struct regulator *vdd_supply;
+	struct reset_control *xshut_reset;
+	enum vl53l1x_distance_mode distance_mode;
+	u8 gpio_polarity;
+	int irq;
+};
+
+static const struct regmap_range vl53l1x_volatile_ranges[] = {
+	regmap_reg_range(VL53L1X_REG_GPIO__TIO_HV_STATUS,
+			 VL53L1X_REG_GPIO__TIO_HV_STATUS),
+	regmap_reg_range(VL53L1X_REG_RESULT__RANGE_STATUS,
+			 VL53L1X_REG_RESULT__RANGE_STATUS),
+	regmap_reg_range(VL53L1X_REG_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
+			 VL53L1X_REG_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0 + 1),
+	regmap_reg_range(VL53L1X_REG_RESULT__OSC_CALIBRATE_VAL,
+			 VL53L1X_REG_RESULT__OSC_CALIBRATE_VAL + 1),
+	regmap_reg_range(VL53L1X_REG_FIRMWARE__SYSTEM_STATUS,
+			 VL53L1X_REG_FIRMWARE__SYSTEM_STATUS),
+};
+
+static const struct regmap_access_table vl53l1x_volatile_table = {
+	.yes_ranges = vl53l1x_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(vl53l1x_volatile_ranges),
+};
+
+static const struct regmap_range vl53l1x_write_only_ranges[] = {
+	regmap_reg_range(VL53L1X_REG_SOFT_RESET, VL53L1X_REG_SOFT_RESET),
+	regmap_reg_range(VL53L1X_REG_SYSTEM__INTERRUPT_CLEAR,
+			 VL53L1X_REG_SYSTEM__MODE_START),
+};
+
+static const struct regmap_access_table vl53l1x_readable_table = {
+	.no_ranges = vl53l1x_write_only_ranges,
+	.n_no_ranges = ARRAY_SIZE(vl53l1x_write_only_ranges),
+};
+
+static const struct regmap_config vl53l1x_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	/* MODEL_ID is 16-bit. +1 covers the second byte at 0x0110 */
+	.max_register = VL53L1X_REG_IDENTIFICATION__MODEL_ID + 1,
+	.cache_type = REGCACHE_MAPLE,
+	.volatile_table = &vl53l1x_volatile_table,
+	.rd_table = &vl53l1x_readable_table,
+};
+
+static int vl53l1x_read_u16(struct vl53l1x_data *data, u16 reg, u16 *val)
+{
+	__be16 buf;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, reg, &buf, sizeof(buf));
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
+	return regmap_bulk_write(data->regmap, reg, &buf, sizeof(buf));
+}
+
+static int vl53l1x_write_u32(struct vl53l1x_data *data, u16 reg, u32 val)
+{
+	__be32 buf = cpu_to_be32(val);
+
+	return regmap_bulk_write(data->regmap, reg, &buf, sizeof(buf));
+}
+
+static int vl53l1x_clear_irq(struct vl53l1x_data *data)
+{
+	return regmap_write(data->regmap, VL53L1X_REG_SYSTEM__INTERRUPT_CLEAR, 0x01);
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
+	return regmap_write(data->regmap, VL53L1X_REG_SYSTEM__MODE_START,
+			    VL53L1X_MODE_START_TIMED);
+}
+
+static int vl53l1x_stop_ranging(struct vl53l1x_data *data)
+{
+	return regmap_write(data->regmap, VL53L1X_REG_SYSTEM__MODE_START,
+			    VL53L1X_MODE_START_STOP);
+}
+
+/*
+ * Default configuration blob from ST's VL53L1X Ultra Lite Driver
+ * (STSW-IMG009).
+ */
+static const u8 vl53l1x_default_config[] = {
+	0x00, 0x00, 0x00, 0x01, 0x02, 0x00, 0x02, 0x08,	/* reg 0x2d..0x34 */
+	0x00, 0x08, 0x10, 0x01, 0x01, 0x00, 0x00, 0x00,	/* reg 0x35..0x3c */
+	0x00, 0xFF, 0x00, 0x0F, 0x00, 0x00, 0x00, 0x00,	/* reg 0x3d..0x44 */
+	0x00, 0x20, 0x0B, 0x00, 0x00, 0x02, 0x0A, 0x21,	/* reg 0x45..0x4c */
+	0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0xC8,	/* reg 0x4d..0x54 */
+	0x00, 0x00, 0x38, 0xFF, 0x01, 0x00, 0x08, 0x00,	/* reg 0x55..0x5c */
+	0x00, 0x01, 0xCC, 0x0F, 0x01, 0xF1, 0x0D, 0x01,	/* reg 0x5d..0x64 */
+	0x68, 0x00, 0x80, 0x08, 0xB8, 0x00, 0x00, 0x00,	/* reg 0x65..0x6c */
+	0x00, 0x0F, 0x89, 0x00, 0x00, 0x00, 0x00, 0x00,	/* reg 0x6d..0x74 */
+	0x00, 0x00, 0x01, 0x0F, 0x0D, 0x0E, 0x0E, 0x00,	/* reg 0x75..0x7c */
+	0x00, 0x02, 0xC7, 0xFF, 0x9B, 0x00, 0x00, 0x00,	/* reg 0x7d..0x84 */
+	0x01, 0x00, 0x00,				/* reg 0x85..0x87 */
+};
+
+static int vl53l1x_chip_init(struct vl53l1x_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int val;
+	u16 model_id;
+	int ret;
+
+	if (!data->xshut_reset) {
+		ret = regmap_write(data->regmap, VL53L1X_REG_SOFT_RESET, 0x00);
+		if (ret)
+			return ret;
+		fsleep(100); /* conservative reset pulse, no spec */
+
+		ret = regmap_write(data->regmap, VL53L1X_REG_SOFT_RESET, 0x01);
+		if (ret)
+			return ret;
+		fsleep(1000); /* conservative boot wait, no spec */
+	}
+
+	ret = regmap_read_poll_timeout(data->regmap,
+				       VL53L1X_REG_FIRMWARE__SYSTEM_STATUS, val,
+				       val & BIT(0),
+				       1 * USEC_PER_MSEC,
+				       100 * USEC_PER_MSEC);
+	if (ret)
+		return dev_err_probe(dev, ret, "firmware boot timeout\n");
+
+	ret = vl53l1x_read_u16(data, VL53L1X_REG_IDENTIFICATION__MODEL_ID,
+			       &model_id);
+	if (ret)
+		return ret;
+
+	if (model_id != VL53L1X_MODEL_ID_VAL)
+		dev_info(dev, "unknown model id: 0x%04x, continuing\n", model_id);
+
+	ret = regmap_bulk_write(data->regmap, VL53L1X_REG_DEFAULT_CONFIG,
+				vl53l1x_default_config,
+				sizeof(vl53l1x_default_config));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, VL53L1X_REG_GPIO_HV_MUX__CTRL, &val);
+	if (ret)
+		return ret;
+	data->gpio_polarity = !!(val & VL53L1X_GPIO_HV_MUX_POLARITY);
+
+	/* Initial ranging cycle for VHV calibration */
+	ret = vl53l1x_start_ranging(data);
+	if (ret)
+		return ret;
+
+	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
+	ret = regmap_read_poll_timeout(data->regmap,
+				       VL53L1X_REG_GPIO__TIO_HV_STATUS, val,
+				       (val & 1) != data->gpio_polarity,
+				       1 * USEC_PER_MSEC,
+				       1000 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
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
+			   VL53L1X_REG_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND,
+			   VL53L1X_VHV_LOOP_BOUND_TWO);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, VL53L1X_REG_VHV_CONFIG__INIT, 0x00);
+}
+
+static const struct reg_sequence vl53l1x_mode_short[] = {
+	{ VL53L1X_REG_PHASECAL_CONFIG__TIMEOUT_MACROP,		0x14 },
+	{ VL53L1X_REG_RANGE_CONFIG__VCSEL_PERIOD_A,		0x07 },
+	{ VL53L1X_REG_RANGE_CONFIG__VCSEL_PERIOD_B,		0x05 },
+	{ VL53L1X_REG_RANGE_CONFIG__VALID_PHASE_HIGH,		0x38 },
+	{ VL53L1X_REG_SD_CONFIG__WOI_SD0,			0x07 },
+	{ VL53L1X_REG_SD_CONFIG__WOI_SD1,			0x05 },
+	{ VL53L1X_REG_SD_CONFIG__INITIAL_PHASE_SD0,		0x06 },
+	{ VL53L1X_REG_SD_CONFIG__INITIAL_PHASE_SD1,		0x06 },
+};
+
+static const struct reg_sequence vl53l1x_mode_long[] = {
+	{ VL53L1X_REG_PHASECAL_CONFIG__TIMEOUT_MACROP,		0x0A },
+	{ VL53L1X_REG_RANGE_CONFIG__VCSEL_PERIOD_A,		0x0F },
+	{ VL53L1X_REG_RANGE_CONFIG__VCSEL_PERIOD_B,		0x0D },
+	{ VL53L1X_REG_RANGE_CONFIG__VALID_PHASE_HIGH,		0xB8 },
+	{ VL53L1X_REG_SD_CONFIG__WOI_SD0,			0x0F },
+	{ VL53L1X_REG_SD_CONFIG__WOI_SD1,			0x0D },
+	{ VL53L1X_REG_SD_CONFIG__INITIAL_PHASE_SD0,		0x0E },
+	{ VL53L1X_REG_SD_CONFIG__INITIAL_PHASE_SD1,		0x0E },
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
+ * values from ST's VL53L1X Ultra Lite Driver.
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
+	ret = vl53l1x_write_u16(data, VL53L1X_REG_RANGE_CONFIG__TIMEOUT_MACROP_A,
+				timeout_a);
+	if (ret)
+		return ret;
+
+	return vl53l1x_write_u16(data, VL53L1X_REG_RANGE_CONFIG__TIMEOUT_MACROP_B,
+				 timeout_b);
+}
+
+static int vl53l1x_set_inter_measurement_ms(struct vl53l1x_data *data,
+					    u16 period_ms)
+{
+	u16 osc_calibrate_val;
+	u16 clock_pll;
+	u32 inter_meas;
+	int ret;
+
+	ret = vl53l1x_read_u16(data, VL53L1X_REG_RESULT__OSC_CALIBRATE_VAL,
+			       &osc_calibrate_val);
+	if (ret)
+		return ret;
+
+	clock_pll = osc_calibrate_val & VL53L1X_OSC_CALIBRATE_MASK;
+	inter_meas = (clock_pll * period_ms * vl53l1x_osc_correction.numerator) /
+		     vl53l1x_osc_correction.denominator;
+
+	return vl53l1x_write_u32(data,
+				 VL53L1X_REG_SYSTEM__INTERMEASUREMENT_PERIOD,
+				 inter_meas);
+}
+
+static int vl53l1x_read_proximity(struct vl53l1x_data *data, int *val)
+{
+	unsigned int range_status;
+	u16 distance;
+	int ret;
+
+	if (data->irq) {
+		reinit_completion(&data->completion);
+
+		ret = vl53l1x_clear_irq(data);
+		if (ret)
+			return ret;
+
+		if (!wait_for_completion_timeout(&data->completion, HZ))
+			return -ETIMEDOUT;
+	} else {
+		unsigned int rdy;
+
+		/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
+		ret = regmap_read_poll_timeout(data->regmap,
+					       VL53L1X_REG_GPIO__TIO_HV_STATUS, rdy,
+					       (rdy & 1) != data->gpio_polarity,
+					       1 * USEC_PER_MSEC,
+					       1000 * USEC_PER_MSEC);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(data->regmap, VL53L1X_REG_RESULT__RANGE_STATUS,
+			  &range_status);
+	if (ret)
+		goto clear_irq;
+
+	if (FIELD_GET(VL53L1X_RANGE_STATUS_MASK, range_status) !=
+	    VL53L1X_RANGE_STATUS_VALID) {
+		ret = -EIO;
+		goto clear_irq;
+	}
+
+	ret = vl53l1x_read_u16(data,
+			       VL53L1X_REG_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
+			       &distance);
+	if (ret)
+		goto clear_irq;
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
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
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
+	} scan = { };
+	unsigned int range_status;
+	int ret;
+
+	ret = regmap_read(data->regmap, VL53L1X_REG_RESULT__RANGE_STATUS,
+			  &range_status);
+	if (ret)
+		goto notify_and_clear_irq;
+	if (FIELD_GET(VL53L1X_RANGE_STATUS_MASK, range_status) !=
+		      VL53L1X_RANGE_STATUS_VALID)
+		goto notify_and_clear_irq;
+
+	ret = vl53l1x_read_u16(data,
+			       VL53L1X_REG_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
+			       &scan.distance);
+	if (ret)
+		goto notify_and_clear_irq;
+
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
+
+notify_and_clear_irq:
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
+static const struct iio_trigger_ops vl53l1x_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static void vl53l1x_stop_ranging_action(void *priv)
+{
+	vl53l1x_stop_ranging(priv);
+}
+
+static void vl53l1x_power_off(void *priv)
+{
+	struct vl53l1x_data *data = priv;
+
+	reset_control_assert(data->xshut_reset);
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
+	ret = reset_control_deassert(data->xshut_reset);
+	if (ret) {
+		regulator_disable(data->vdd_supply);
+		return ret;
+	}
+	/*
+	 * 1.2 ms max boot duration.
+	 * Datasheet Section 3.6 "Power up and boot sequence".
+	 */
+	fsleep(1200);
+
+	return 0;
+}
+
+static int vl53l1x_configure_irq(struct device *dev, int irq,
+				 struct iio_dev *indio_dev)
+{
+	struct vl53l1x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = devm_request_irq(dev, irq, vl53l1x_irq_handler, IRQF_NO_THREAD,
+			       indio_dev->name, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, VL53L1X_REG_SYSTEM__INTERRUPT_CONFIG_GPIO,
+			   VL53L1X_INT_NEW_SAMPLE_READY);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to configure IRQ\n");
+
+	return 0;
+}
+
+static int vl53l1x_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct vl53l1x_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
+				     I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->irq = client->irq;
+
+	data->regmap = devm_regmap_init_i2c(client, &vl53l1x_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "regmap initialization failed\n");
+
+	data->vdd_supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(data->vdd_supply))
+		return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
+				     "Unable to get VDD regulator\n");
+
+	/*
+	 * XSHUT held low puts the chip in hardware standby. All register
+	 * state is lost on de-assert so this is functionally a reset.
+	 */
+	data->xshut_reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(data->xshut_reset))
+		return dev_err_probe(dev, PTR_ERR(data->xshut_reset),
+				     "Cannot get reset control\n");
+
+	ret = vl53l1x_power_on(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to power on the chip\n");
+
+	ret = devm_add_action_or_reset(dev, vl53l1x_power_off, data);
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
+	/* 50 ms timing budget (per ST Ultra Lite Driver) */
+	ret = vl53l1x_set_timing_budget(data, 50);
+	if (ret)
+		return ret;
+
+	/* 50 ms inter-measurement period (per ST Ultra Lite Driver) */
+	ret = vl53l1x_set_inter_measurement_ms(data, 50);
+	if (ret)
+		return ret;
+
+	/*
+	 * The hardware only supports "autonomous" continuous ranging mode.
+	 * Start ranging here and leave it running for the lifetime of
+	 * the device. Both direct reads and the buffer path rely on this.
+	 */
+	ret = vl53l1x_start_ranging(data);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, vl53l1x_stop_ranging_action, data);
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
+		trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+					      iio_device_id(indio_dev));
+		if (!trig)
+			return -ENOMEM;
+
+		trig->ops = &vl53l1x_trigger_ops;
+		iio_trigger_set_drvdata(trig, indio_dev);
+		ret = devm_iio_trigger_register(dev, trig);
+		if (ret)
+			return ret;
+
+		indio_dev->trig = iio_trigger_get(trig);
+
+		ret = vl53l1x_configure_irq(dev, client->irq, indio_dev);
+		if (ret)
+			return ret;
+
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+						      &vl53l1x_trigger_handler,
+						      NULL);
+		if (ret)
+			return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
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

