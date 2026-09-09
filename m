Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8ED55198D;
	Wed,  9 Sep 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956636; cv=none; b=An3Vbr8XllzBCMTycNpHLr/77oN9FMc1ZmeGV6Oo8DM5jH0CT+d+nI39WRexY3P5LpNr490Zn1j5vonrusphxeZa+N2QirPtoFC1SKgPWT7/hh7nVkKlg6290LLR8Vpb25lRDbNfCI7+sELlWLBYcoTbvS/28sOoSUhyaoI+3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956636; c=relaxed/simple;
	bh=u+GnjFY3U8NUXcqmZAN8UGPM80rm5EswB1d6RGyLcnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JlXPe2pAGgozt62NzdYdjHEEcjqOwu8pXo9zggDq1X/eXL13IAEH+DrqogdPQHCvWYxbf7CnCl1mjmKwTC15VOYRJ70XPNfRjqhzwnVWsxK/BwBbEPv565o1MdDu+FtE30sDmoHJUuSJAbWePb5gVZHvOkwoLpRe1mJuLTfAZuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lTecHj9M; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lTecHj9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788956632; x=1820492632;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=u+GnjFY3U8NUXcqmZAN8UGPM80rm5EswB1d6RGyLcnA=;
  b=lTecHj9MbadAzJW+zJzXkZ84hQUKCXjnPOTu9U6nleFxfEbpHZLmjY4H
   2WxLCU4rAtsQL3C4DRO7TEE6QLagfpmozP3eMthDt4xVQj/c8YSq9HH+B
   quBJa0Ay/ATitY6PcVHuzWSTs2Xed9OpoSM1imPxGhNdWq0MFiNbXbK5n
   7jFFq0XS67Wfs7Qj6MEorBhd0cpPlWl5adrrDBdlEIJU45AXhGk/QgzX+
   u9niOjm1YbroTtUFKU3EJT9S0K/JTuCEHTyNOse003ThyeL15Z/MUHe/f
   pVMhE1sIyXVQKL96G349Nw0uDtSGvmN60b4nYjhBE8BZr9LE46X26eUbW
   g==;
X-CSE-ConnectionGUID: 0wLm5B2vRrC2ZZcwWuZlFw==
X-CSE-MsgGUID: 3S4a/m0dQA2X1yLwAgnT4w==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="230463706"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 05:23:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 9 Sep 2026 05:23:45 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 05:23:42 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 9 Sep 2026 15:23:35 +0300
Subject: [PATCH v3 2/2] iio: adc: add support for PAC1711
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-pac1711-v3-2-dff81003b82f@microchip.com>
References: <20260909-pac1711-v3-0-dff81003b82f@microchip.com>
In-Reply-To: <20260909-pac1711-v3-0-dff81003b82f@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788956615; l=45407;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=u+GnjFY3U8NUXcqmZAN8UGPM80rm5EswB1d6RGyLcnA=;
 b=TL0V9rW+qBtYL6QxXNjiweHOGlbTc/3AmBlxnUizeidE4UVkOrqz52jSe6+mf6rTtqjOjjjYi
 0xKOETzEE/SDt1D6FNO1/iaoKF5/OM2hINsWkbNiobgWKMo7CBELNf1
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the iio driver for Microchip PAC1711, PAC1721, PAC1811 and
PAC1821 single-channel power monitors with accumulator. The PAC1711 and
PAC1721 devices use 12-bit resolution for voltage and current measurements
and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
resolution and use 32 bits for power calculations. The 56-bit accumulator
register accumulates power (energy) or current (Coulomb counter).

PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
PAC1721 and PAC1821.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-pac1711          |   24 +
 MAINTAINERS                                        |    2 +
 drivers/iio/adc/Kconfig                            |   11 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/pac1711.c                          | 1304 ++++++++++++++++++++
 5 files changed, 1342 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
new file mode 100644
index 0000000000000000000000000000000000000000..679b331e455624f493d7c326843cbbe4a129e924
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
@@ -0,0 +1,24 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_coulomb_counter_raw
+KernelVersion:	7.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to read the accumulated voltage
+		measured on the shunt resistor (Coulomb counter). Units
+		after application of scale are milliCoulombs. X is the IIO index
+		of the device.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_coulomb_counter_scale
+KernelVersion:	7.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If known for a device, scale to be applied to
+		in_coulomb_counter_raw in order to obtain the measured
+		value in milliCoulombs. X is the IIO index of the device.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_coulomb_counter_en
+KernelVersion:	7.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, is used to enable digital
+		accumulation of VSENSE measurements. X is the IIO index of
+		the device.
diff --git a/MAINTAINERS b/MAINTAINERS
index 399da37f79fd9768f29cc60aa5384a1ba9fe8afc..c41cb5878e62297d14e5b9710a6f1210b6bd8ea1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16341,7 +16341,9 @@ MICROCHIP PAC1711 POWER/CURRENT MONITOR DRIVER
 M:	Ariana Lazar <ariana.lazar@microchip.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
+F:	Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
 F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
+F:	drivers/iio/adc/pac1711.c
 
 MICROCHIP PAC1921 POWER/CURRENT MONITOR DRIVER
 M:	Matteo Martelli <matteomartelli3@gmail.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ea3ba139739281de82848e25fd2b6ca479a939dc..bc4d606132089515a4d6b01f0602ce7ff4f872c8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1125,6 +1125,17 @@ config NPCM_ADC
 	  This driver can also be built as a module. If so, the module
 	  will be called npcm_adc.
 
+config PAC1711
+	tristate "Microchip Technology PAC1711 driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Microchip Technology's PAC1711,
+	  PAC1721, PAC1811 and PAC1821 Single-Channel Power Monitors with
+	  Accumulator.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pac1711.
+
 config PAC1921
 	tristate "Microchip Technology PAC1921 driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 09ae6edb26504991f011def6618efc3f4cf4df4c..d039a23cde02d442b161730ad2c939c7d035a4c6 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_NCT7201) += nct7201.o
 obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
+obj-$(CONFIG_PAC1711) += pac1711.o
 obj-$(CONFIG_PAC1921) += pac1921.o
 obj-$(CONFIG_PAC1934) += pac1934.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
diff --git a/drivers/iio/adc/pac1711.c b/drivers/iio/adc/pac1711.c
new file mode 100644
index 0000000000000000000000000000000000000000..f23d08205952f9eda16bf88826a740120de55988
--- /dev/null
+++ b/drivers/iio/adc/pac1711.c
@@ -0,0 +1,1304 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for PAC1711 Single-Channel DC Power/Energy Monitor
+ *
+ * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Ariana Lazar <ariana.lazar@microchip.com>
+ *
+ * Datasheet links:
+ * [PAC1711]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1711-Data-Sheet-DS20007058.pdf
+ * [PAC1721]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1721-Single-Channel-Power-Monitor-with-Accumulator-DS20007088.pdf
+ * [PAC1811]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC1811-Data-Sheet-DS20007066.pdf
+ * [PAC1821]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC1821-Data-Sheet-DS20007097.pdf
+ */
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/byteorder/generic.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/math64.h>
+#include <linux/mutex.h>
+#include <linux/overflow.h>
+#include <linux/property.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+#include <linux/workqueue.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/*
+ * Maximum accumulation time should be 1,165 hours at 1,024 sps
+ * till PAC1711 accumulation registers starts to saturate
+ */
+#define PAC1711_MAX_RFSH_LIMIT_MS	60000
+/* 50msec is the timeout for validity of the cached registers */
+#define PAC1711_MIN_POLLING_TIME_MS	50
+/*
+ * 1000usec is the minimum wait time for normal conversions when sample
+ * rate doesn't change
+ */
+#define PAC1711_MIN_UPDATE_WAIT_TIME_US	1000
+
+/* 42000mV */
+#define PAC1711_VOLTAGE_MILLIVOLTS_MAX	42000
+#define PAC1721_VOLTAGE_MILLIVOLTS_MAX	9000
+
+/* Maximum power-product value - 42 V * 0.1 V */
+#define PAC1711_PRODUCT_VOLTAGE_PV_FSR	(4200ULL * NANO)
+#define PAC1721_PRODUCT_VOLTAGE_PV_FSR	(900ULL * NANO)
+
+/* I2C address map */
+#define PAC1711_REFRESH_REG_ADDR	0x00
+
+/* Writable register, but needs refresh */
+#define PAC1711_CTRL_REG_ADDR		0x01
+#define PAC1711_CTRL_SAMPLE_MODE_MASK		GENMASK(15, 12)
+#define PAC1711_CTRL_ACC_MODE_MASK		GENMASK(3, 2)
+#define PAC1711_ACC_COUNT_REG_ADDR	0x02
+#define PAC1711_VACC_REG_ADDR		0x03
+#define PAC1711_VBUS_REG_ADDR		0x04
+#define PAC1711_VSENSE_REG_ADDR		0x05
+#define PAC1711_VPOWER_REG_ADDR		0x08
+
+/* Saves the settings that were active prior to the most recent refresh (any) command */
+#define PAC1711_CTRL_LAT_REG_ADDR	0x0F
+#define PAC1711_NEG_PWR_FSR_REG_ADDR	0x13
+#define PAC1711_NEG_PWR_FSR_VS_MASK		GENMASK(3, 2)
+#define PAC1711_NEG_PWR_FSR_VB_MASK		GENMASK(1, 0)
+#define PAC1711_SLOW_REG_ADDR		0x16
+
+/* Read-only register which stores currently active settings. */
+#define PAC1711_CTRL_ACT_REG_ADDR	0x17
+
+#define PAC1711_PID_REG_ADDR		0xFD
+
+/* Dimension of each register in bytes */
+#define PAC1711_ACC_REG_LEN		4
+#define PAC1711_VACC_REG_LEN		7
+#define PAC1711_VBUS_SENSE_REG_LEN	2
+
+/*
+ * The sum of the measurement registers' dimensions in bytes - from ACC_COUNT to
+ * VPOWER in datasheet register description.
+ */
+#define PAC1711_MEAS_REG_SNAPSHOT_LEN	23
+
+#define PAC1711_ACC_ENERGY_STR		"energy"
+#define PAC1711_ACC_CHARGE_STR		"charge"
+
+#define PAC1711_PRODUCT_ID_1711		0x80
+#define PAC1711_PRODUCT_ID_1721		0x81
+#define PAC1711_PRODUCT_ID_1811		0x84
+#define PAC1711_PRODUCT_ID_1821		0x85
+
+#define PAC1711_DEV_ATTR(name)		(&iio_dev_attr_##name.dev_attr.attr)
+
+enum {
+	PAC1711_ACCMODE_VPOWER = 0,
+	PAC1711_ACCMODE_VSENSE = 1,
+};
+
+enum {
+	PAC1711_FULL_RANGE_UNIPOLAR = 0,
+	PAC1711_FULL_RANGE_BIPOLAR = 1,
+	PAC1711_HALF_RANGE_BIPOLAR = 2,
+};
+
+enum {
+	PAC1711_VOLTAGE_RANGE_IDX = 0,
+	PAC1721_VOLTAGE_RANGE_IDX = 1,
+};
+
+static const int pac1711_vbus_range_tbl[2][3][2] = {
+	[PAC1711_VOLTAGE_RANGE_IDX] = {
+		[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, 42000000 },
+		[PAC1711_FULL_RANGE_BIPOLAR]  = { -42000000, 42000000 },
+		[PAC1711_HALF_RANGE_BIPOLAR]  = { -21000000, 21000000 },
+	},
+	[PAC1721_VOLTAGE_RANGE_IDX] = {
+		[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, 9000000 },
+		[PAC1711_FULL_RANGE_BIPOLAR]  = { -9000000, 9000000 },
+		[PAC1711_HALF_RANGE_BIPOLAR]  = { -4500000, 4500000 },
+	},
+};
+
+static const int pac1711_vsense_range_tbl[3][2] = {
+	[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, 100000 },
+	[PAC1711_FULL_RANGE_BIPOLAR] = { -100000, 100000 },
+	[PAC1711_HALF_RANGE_BIPOLAR] = { -50000, 50000 },
+};
+
+enum {
+	PAC1711_SAMP_8192SPS = 0,
+	PAC1711_SAMP_4096SPS = 1,
+	PAC1711_SAMP_1024SPS = 2,
+	PAC1711_SAMP_256SPS = 3,
+	PAC1711_SAMP_64SPS = 4,
+	PAC1711_SAMP_8SPS = 5,
+};
+
+static const unsigned int pac1711_samp_rate_map_tbl[] = {
+	[PAC1711_SAMP_8192SPS] = 8192,
+	[PAC1711_SAMP_4096SPS] = 4096,
+	[PAC1711_SAMP_1024SPS] = 1024, /* Default */
+	[PAC1711_SAMP_256SPS] = 256,
+	[PAC1711_SAMP_64SPS] = 64,
+	[PAC1711_SAMP_8SPS] = 8,
+};
+
+static const unsigned int pac1711_shift_map_tbl[] = {
+	[PAC1711_SAMP_8192SPS] = 13,
+	[PAC1711_SAMP_4096SPS] = 12,
+	[PAC1711_SAMP_1024SPS] = 10,
+	[PAC1711_SAMP_256SPS] = 8,
+	[PAC1711_SAMP_64SPS] = 6,
+	[PAC1711_SAMP_8SPS] = 3,
+};
+
+/**
+ * struct pac1711_features - features of a pac1711 instance
+ * @name: chip's name
+ * @prod_id: hardware ID
+ */
+struct pac1711_features {
+	const char *name;
+	u8 prod_id;
+};
+
+static const struct pac1711_features pac1711_chip_features = {
+	.name = "pac1711",
+	.prod_id = PAC1711_PRODUCT_ID_1711,
+};
+
+static const struct pac1711_features pac1721_chip_features = {
+	.name = "pac1721",
+	.prod_id = PAC1711_PRODUCT_ID_1721,
+};
+
+static const struct pac1711_features pac1811_chip_features = {
+	.name = "pac1811",
+	.prod_id = PAC1711_PRODUCT_ID_1811,
+};
+
+static const struct pac1711_features pac1821_chip_features = {
+	.name = "pac1821",
+	.prod_id = PAC1711_PRODUCT_ID_1821,
+};
+
+/**
+ * struct reg_data - data from the registers
+ * @vacc:		accumulated vpower or vsense value
+ * @acc_val:		accumulated values per second
+ * @vpower:		vpower registers
+ * @vsense:		vsense registers
+ * @vbus:		vbus registers
+ * @acc_count:		the acc_count register
+ * @jiffies_tstamp:	timestamp
+ * @ctrl_act_reg:	the ctrl_act register
+ * @ctrl_lat_reg:	the ctrl_lat register
+ * @meas_regs:		snapshot of raw measurements registers
+ */
+struct reg_data {
+	s64		vacc;
+	s64		acc_val;
+	s64		vpower;
+	s32		vsense;
+	s32		vbus;
+	u32		acc_count;
+	unsigned long	jiffies_tstamp;
+	u16		ctrl_act_reg;
+	u16		ctrl_lat_reg;
+	u8		meas_regs[PAC1711_MEAS_REG_SNAPSHOT_LEN];
+};
+
+/**
+ * struct pac1711_chip_info - information about the chip
+ * @chip_reg_data:		measurement/control/accumulator output device registers
+ * @iio_info:			device information
+ * @client:			the I2C client attached to the device
+ * @work_chip_refresh:		work queue used for refresh commands
+ * @lock:			synchronize access to driver's state members
+ * @shunt:			shunt resistor value
+ * @vbus_mode:			Full Scale Range (FSR) mode for VBus
+ * @vsense_mode:		Full Scale Range (FSR) mode for VSense
+ * @accumulation_mode:		accumulation mode for hardware accumulator
+ * @sample_rate_idx:		sampling frequency index
+ * @chip_variant:		chip variant
+ * @voltage_range_idx:		Voltage range based on part number
+ * @enable_acc:			true means that accumulation channel is enabled
+ * @has_16bit_resolution:	true if device is part of the PAC18x1 family
+ */
+struct pac1711_chip_info {
+	struct reg_data		chip_reg_data;
+	struct iio_info		iio_info;
+	struct i2c_client	*client;
+	struct delayed_work	work_chip_refresh;
+	/* Prevents concurrent writes into control, voltage measurement or accumulator registers. */
+	struct mutex		lock;
+	u32			shunt;
+	u8			vbus_mode;
+	u8			vsense_mode;
+	u8			accumulation_mode;
+	u8			sample_rate_idx;
+	u8			chip_variant;
+	u8			voltage_range_idx;
+	bool			enable_acc;
+	bool			has_16bit_resolution;
+};
+
+static inline u64 pac1711_get_unaligned_be56(u8 *p)
+{
+	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
+		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
+}
+
+static int pac1711_send_refresh(struct pac1711_chip_info *info, u8 refresh_cmd,
+				u32 wait_time)
+{
+	struct i2c_client *client = info->client;
+	int ret;
+
+	/* Writing a REFRESH or a REFRESH_V command */
+	ret = i2c_smbus_write_byte(client, refresh_cmd);
+	if (ret) {
+		dev_err(&client->dev, "%s - cannot send Refresh cmd (0x%02X)\n",
+			__func__, refresh_cmd);
+		return ret;
+	}
+
+	/* Register data retrieval timestamp */
+	info->chip_reg_data.jiffies_tstamp = jiffies;
+
+	/* Wait till the data is available */
+	fsleep(wait_time);
+
+	return 0;
+}
+
+static int pac1711_reg_snapshot_locked(struct pac1711_chip_info *info, bool do_refresh,
+				       u8 refresh_cmd, u32 wait_time)
+{
+	struct i2c_client *client = info->client;
+	struct device *dev = &client->dev;
+	u8 *offset_reg_data_p;
+	bool is_bipolar;
+	__be16 val_be16;
+	u16 val_u16;
+	s64 inc = 0;
+	int ret;
+
+	/* Force a snapshot of the internal accumulator and measurements into the registers. */
+	if (do_refresh) {
+		ret = pac1711_send_refresh(info, refresh_cmd, wait_time);
+		if (ret < 0) {
+			dev_err(dev, "cannot send refresh\n");
+			return ret;
+		}
+	}
+
+	/* Read the ctrl/status registers for this snapshot */
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_ACT_REG_ADDR,
+					    sizeof(val_be16), (u8 *)&val_be16);
+	if (ret != sizeof(val_be16)) {
+		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
+			__func__, PAC1711_CTRL_ACT_REG_ADDR);
+		return ret < 0 ? ret : -EIO;
+	}
+
+	info->chip_reg_data.ctrl_act_reg = be16_to_cpu(val_be16);
+
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_LAT_REG_ADDR,
+					    sizeof(val_be16), (u8 *)&val_be16);
+	if (ret != sizeof(val_be16)) {
+		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
+			__func__, PAC1711_CTRL_LAT_REG_ADDR);
+		return ret < 0 ? ret : -EIO;
+	}
+
+	info->chip_reg_data.ctrl_lat_reg = be16_to_cpu(val_be16);
+
+	/* Read the data registers */
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_ACC_COUNT_REG_ADDR,
+					    PAC1711_MEAS_REG_SNAPSHOT_LEN,
+					    (u8 *)info->chip_reg_data.meas_regs);
+	if (ret != PAC1711_MEAS_REG_SNAPSHOT_LEN) {
+		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
+			__func__, PAC1711_ACC_COUNT_REG_ADDR);
+		return ret < 0 ? ret : -EIO;
+	}
+
+	offset_reg_data_p = &info->chip_reg_data.meas_regs[0];
+	info->chip_reg_data.acc_count = get_unaligned_be32(offset_reg_data_p);
+	offset_reg_data_p += PAC1711_ACC_REG_LEN;
+
+	/* skip if the energy/charge accumulation is disabled */
+	if (info->enable_acc) {
+		info->chip_reg_data.vacc = pac1711_get_unaligned_be56(offset_reg_data_p);
+		is_bipolar = false;
+
+		switch (info->accumulation_mode) {
+		case PAC1711_ACCMODE_VPOWER:
+			if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR ||
+			    info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+				is_bipolar = true;
+			break;
+		case PAC1711_ACCMODE_VSENSE:
+			if (info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+				is_bipolar = true;
+			break;
+		}
+
+		if (is_bipolar)
+			info->chip_reg_data.vacc = sign_extend64(info->chip_reg_data.vacc, 55);
+
+		/*
+		 * Integrate the accumulated power or current over
+		 * the elapsed interval.
+		 */
+		val_u16 = FIELD_GET(PAC1711_CTRL_SAMPLE_MODE_MASK,
+				    info->chip_reg_data.ctrl_lat_reg);
+
+		if (val_u16 <= PAC1711_SAMP_8SPS) {
+			inc = info->chip_reg_data.vacc >> pac1711_shift_map_tbl[val_u16];
+		} else {
+			dev_err(dev, "Invalid sample rate index: %d!\n", val_u16);
+			return -EINVAL;
+		}
+
+		/* Handle 64-bit overflow by saturating at limits. */
+		if (check_add_overflow(info->chip_reg_data.acc_val, inc,
+				       &info->chip_reg_data.acc_val)) {
+			if (inc < 0)
+				info->chip_reg_data.acc_val = S64_MIN;
+			else
+				info->chip_reg_data.acc_val = S64_MAX;
+
+			dev_err(dev, "Accumulator Overflow detected!\n");
+		}
+	}
+
+	offset_reg_data_p += PAC1711_VACC_REG_LEN;
+
+	/* VBUS */
+	info->chip_reg_data.vbus = get_unaligned_be16(offset_reg_data_p);
+
+	if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+		info->chip_reg_data.vbus = sign_extend32(info->chip_reg_data.vbus, 15);
+
+	offset_reg_data_p += PAC1711_VBUS_SENSE_REG_LEN;
+
+	/* VSENSE */
+	info->chip_reg_data.vsense = get_unaligned_be16(offset_reg_data_p);
+
+	if (info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+		info->chip_reg_data.vsense = sign_extend32(info->chip_reg_data.vsense, 15);
+
+	/* Skip VBUS_AVG and VSENSE_AVG registers */
+	offset_reg_data_p += PAC1711_VBUS_SENSE_REG_LEN * 3;
+
+	/* VPOWER */
+	info->chip_reg_data.vpower = get_unaligned_be32(offset_reg_data_p);
+
+	if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR ||
+	    info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+		info->chip_reg_data.vpower = sign_extend64(info->chip_reg_data.vpower, 31);
+
+	return 0;
+}
+
+static int pac1711_reg_snapshot(struct pac1711_chip_info *info, bool do_refresh,
+				u8 refresh_cmd, u32 wait_time, bool *refreshed)
+{
+	guard(mutex)(&info->lock);
+
+	/* No hardware refresh is needed */
+	if (refreshed)
+		*refreshed = false;
+
+	/* Return early if the minimum polling time hasn't elapsed */
+	if (!time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
+			msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS)))
+		return 0;
+
+	/* A hardware refresh will happen */
+	if (refreshed)
+		*refreshed = true;
+
+	return pac1711_reg_snapshot_locked(info, do_refresh, refresh_cmd, wait_time);
+}
+
+static int pac1711_retrieve_data(struct pac1711_chip_info *info, u32 wait_time)
+{
+	bool refreshed = false;
+	int ret;
+
+	/*
+	 * Restart the background timer to begin a new accumulation window if an
+	 * actual hardware refresh took place.
+	 */
+	ret = pac1711_reg_snapshot(info, true, PAC1711_REFRESH_REG_ADDR, wait_time, &refreshed);
+	if (ret < 0)
+		return ret;
+
+	if (refreshed) {
+		cancel_delayed_work_sync(&info->work_chip_refresh);
+		schedule_delayed_work(&info->work_chip_refresh,
+				      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
+	}
+
+	return 0;
+}
+
+static int pac1711_get_samp_rate_idx(u32 new_samp_rate)
+{
+	int cnt;
+
+	for (cnt = 0; cnt < ARRAY_SIZE(pac1711_samp_rate_map_tbl); cnt++)
+		if (new_samp_rate == pac1711_samp_rate_map_tbl[cnt])
+			return cnt;
+
+	return -EINVAL;
+}
+
+static ssize_t pac1711_read_shunt_resistor(struct iio_dev *indio_dev, uintptr_t private,
+					   const struct iio_chan_spec *ch, char *buf)
+{
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%u\n", info->shunt);
+}
+
+static ssize_t pac1711_in_enable_acc_show(struct device *dev, struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", info->enable_acc);
+}
+
+static int pac1711_set_acc_enable(struct pac1711_chip_info *info, int val)
+{
+	struct i2c_client *client = info->client;
+	struct device *dev = &client->dev;
+	u32 wait_time, sample_rate;
+	int ret = 0;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	scoped_guard(mutex, &info->lock) {
+		if (val == info->enable_acc)
+			return 0;
+	}
+
+	cancel_delayed_work_sync(&info->work_chip_refresh);
+
+	scoped_guard(mutex, &info->lock) {
+		if (val == info->enable_acc)
+			return 0;
+
+		/*
+		 * Force a hardware refresh to zero out the internal accumulators
+		 * and start a new measurement window, as the chip accumulates
+		 * continuously in the background.
+		 */
+		if (val) {
+			sample_rate = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
+			wait_time = (1024 * 1000) / sample_rate;
+			ret = pac1711_send_refresh(info, PAC1711_REFRESH_REG_ADDR, wait_time);
+		} else {
+			info->chip_reg_data.acc_val = 0;
+			info->chip_reg_data.vacc = 0;
+			info->chip_reg_data.acc_count = 0;
+		}
+
+		info->enable_acc = val;
+	}
+
+	schedule_delayed_work(&info->work_chip_refresh,
+			      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
+
+	if (ret)
+		dev_err(dev, "failed to reset accumulator: %d\n", ret);
+
+	return ret;
+}
+
+static ssize_t pac1711_in_enable_acc_store(struct device *dev, struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	ret = pac1711_set_acc_enable(info, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t pac1711_in_coulomb_counter_raw_show(struct device *dev,
+						   struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	int ret;
+
+	ret = pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%lld\n", info->chip_reg_data.acc_val);
+}
+
+static ssize_t pac1711_in_coulomb_counter_scale_show(struct device *dev,
+						     struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	u64 val_int, ref;
+	unsigned int val_nano;
+
+	if (info->has_16bit_resolution)
+		/*
+		 * Calculate the scale for accumulated current/Coulomb counter
+		 * (100mV * 1000000) / (2^16 * shunt(uOhm)) - depends on the channel's shunt value
+		 */
+		ref = (u64)1525878906250ULL;
+	else
+		/* (100mV * 1000000) / (2^12 * shunt(uOhm)) */
+		ref = (u64)24414062500000ULL;
+
+	if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
+		ref = ref << 1;
+
+	/*
+	 * Display fractional result as integer part and remainder:
+	 * (100mV * 1M * 1G) / 2^(12 or 16))
+	 */
+	val_int = div_u64(ref, info->shunt);
+	val_nano = do_div(val_int, 1 * NANO);
+
+	return sysfs_emit(buf, "%lld.%09u\n", val_int, val_nano);
+}
+
+static IIO_DEVICE_ATTR(in_coulomb_counter_raw, 0444,
+		       pac1711_in_coulomb_counter_raw_show, NULL, 0);
+
+static IIO_DEVICE_ATTR(in_coulomb_counter_scale, 0444,
+		       pac1711_in_coulomb_counter_scale_show, NULL, 0);
+
+static IIO_DEVICE_ATTR(in_coulomb_counter_en, 0644,
+		       pac1711_in_enable_acc_show, pac1711_in_enable_acc_store, 0);
+
+static struct attribute *pac1711_coulomb_counter_attr[] = {
+	PAC1711_DEV_ATTR(in_coulomb_counter_raw),
+	PAC1711_DEV_ATTR(in_coulomb_counter_scale),
+	PAC1711_DEV_ATTR(in_coulomb_counter_en),
+	NULL
+};
+
+static const struct attribute_group pac1711_coulomb_counter_group = {
+	.attrs = pac1711_coulomb_counter_attr,
+};
+
+/*
+ * The value of the shunt resistor may be known only at runtime and set by a client
+ * application. This attribute allows to set its value in micro-ohms. Y is the channel
+ * number. The value is used to calculate current, power and accumulated energy or
+ * Coulomb counter.
+ */
+static ssize_t pac1711_write_shunt_resistor(struct iio_dev *indio_dev, uintptr_t private,
+					    const struct iio_chan_spec *ch, const char *buf,
+					    size_t len)
+{
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	struct device *dev = &info->client->dev;
+	unsigned int sh_val;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &sh_val);
+	if (ret) {
+		dev_err(dev, "Shunt value is not valid\n");
+		return ret;
+	}
+
+	if (sh_val == 0)
+		return -EINVAL;
+
+	scoped_guard(mutex, &info->lock)
+		info->shunt = sh_val;
+
+	return len;
+}
+
+static const struct iio_chan_spec_ext_info pac1711_ext_info[] = {
+	{
+		.name = "in_shunt_resistor",
+		.read = pac1711_read_shunt_resistor,
+		.write = pac1711_write_shunt_resistor,
+		.shared = IIO_SHARED_BY_ALL,
+	},
+	{ }
+};
+
+#define TO_PAC1711_CHIP_INFO(d) container_of(d, struct pac1711_chip_info, work_chip_refresh)
+
+#define PAC1711_VBUS_CHANNEL(_index, _address) {				\
+	.type = IIO_VOLTAGE,							\
+	.address = (_address),							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+}
+
+#define PAC1711_VSENSE_CHANNEL(_index, _address) {				\
+	.type = IIO_CURRENT,							\
+	.address = (_address),							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.ext_info = pac1711_ext_info,						\
+}
+
+#define PAC1711_VPOWER_CHANNEL(_index, _address) {				\
+	.type = IIO_POWER,							\
+	.address = (_address),							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+}
+
+#define PAC1711_ACC_CHANNEL(_index, _address) {				\
+	.type = IIO_ENERGY,							\
+	.address = (_address),							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	|			\
+			      BIT(IIO_CHAN_INFO_SCALE)	|			\
+			      BIT(IIO_CHAN_INFO_ENABLE),			\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+}
+
+static int pac1711_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	int ret;
+	u64 tmp = 0;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
+		if (ret)
+			return ret;
+
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = info->chip_reg_data.vbus;
+			return IIO_VAL_INT;
+		case IIO_CURRENT:
+			*val = info->chip_reg_data.vsense;
+			return IIO_VAL_INT;
+		case IIO_POWER:
+			*val = (u32)info->chip_reg_data.vpower;
+			*val2 = (u32)(info->chip_reg_data.vpower >> 32);
+			return IIO_VAL_INT_64;
+		case IIO_ENERGY:
+			*val = (u32)info->chip_reg_data.acc_val;
+			*val2 = (u32)(info->chip_reg_data.acc_val >> 32);
+			return IIO_VAL_INT_64;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->address) {
+		case PAC1711_VBUS_REG_ADDR:
+			/* Voltages - scale for millivolts */
+			switch (info->chip_variant) {
+			case PAC1711_PRODUCT_ID_1711:
+			case PAC1711_PRODUCT_ID_1811:
+				*val = PAC1711_VOLTAGE_MILLIVOLTS_MAX;
+				break;
+			case PAC1711_PRODUCT_ID_1721:
+			case PAC1711_PRODUCT_ID_1821:
+				*val = PAC1721_VOLTAGE_MILLIVOLTS_MAX;
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			*val2 = (info->vbus_mode == PAC1711_FULL_RANGE_BIPOLAR) ? 15 : 16;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case PAC1711_VSENSE_REG_ADDR:
+			/*
+			 * Currents - scale for mA - depends on the channel's shunt value
+			 * (100mV * 1000000) / (2^16 * shunt(uohm))
+			 */
+			*val = 1526;
+			*val2 = info->shunt;
+
+			if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
+				*val = *val << 1;
+
+			return IIO_VAL_FRACTIONAL;
+		case PAC1711_VPOWER_REG_ADDR:
+		case PAC1711_VACC_REG_ADDR:
+			/*
+			 * Power - uW - it will use the combined scale
+			 * for current and voltage
+			 * current(mA) * voltage(mV) = power (uW)
+			 */
+			switch (info->chip_variant) {
+			case PAC1711_PRODUCT_ID_1711:
+			case PAC1711_PRODUCT_ID_1811:
+				tmp = PAC1711_PRODUCT_VOLTAGE_PV_FSR;
+				break;
+			case PAC1711_PRODUCT_ID_1721:
+			case PAC1711_PRODUCT_ID_1821:
+				tmp = PAC1721_PRODUCT_VOLTAGE_PV_FSR;
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			do_div(tmp, info->shunt);
+			*val = (int)tmp;
+
+			if (chan->type == IIO_ENERGY)
+				*val2 = info->has_16bit_resolution ? 32 : 24;
+			else
+				*val2 = 32;
+
+			if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
+				*val2 -= 1;
+
+			if (info->vbus_mode == PAC1711_FULL_RANGE_BIPOLAR)
+				*val2 -= 1;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		scoped_guard(mutex, &info->lock) {
+			*val = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
+		}
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_ENABLE:
+		*val = info->enable_acc;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int pac1711_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	struct device *dev = &info->client->dev;
+	s32 old_samp_rate;
+	int new_idx, ret, refresh_time;
+	__be16 val_be16;
+	u16 val_u16;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		scoped_guard(mutex, &info->lock) {
+			old_samp_rate = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
+			new_idx = pac1711_get_samp_rate_idx(val);
+			if (new_idx < 0)
+				return new_idx;
+
+			ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_ACT_REG_ADDR,
+							    sizeof(val_u16), (u8 *)&val_be16);
+			if (ret != sizeof(val_u16)) {
+				dev_err(&client->dev, "cannot read regs from 0x%02X\n",
+					PAC1711_CTRL_ACT_REG_ADDR);
+				return ret < 0 ? ret : -EIO;
+			}
+
+			val_u16 = be16_to_cpu(val_be16);
+			FIELD_MODIFY(PAC1711_CTRL_SAMPLE_MODE_MASK, &val_u16, new_idx);
+			ret = i2c_smbus_write_i2c_block_data(client, PAC1711_CTRL_REG_ADDR,
+							     sizeof(val_be16), (u8 *)&val_be16);
+			if (ret) {
+				dev_err(dev, "Failed to configure sampling mode in 0x%02X\n",
+					PAC1711_CTRL_ACT_REG_ADDR);
+				return ret;
+			}
+
+			info->sample_rate_idx = new_idx;
+			info->chip_reg_data.ctrl_act_reg = val_u16;
+
+			/* Force register snapshot and timestamp update with a refresh. */
+			refresh_time = msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS) - 1;
+			info->chip_reg_data.jiffies_tstamp -= refresh_time;
+		}
+
+		ret = pac1711_retrieve_data(info, ((1024 * 1000) / old_samp_rate));
+		if (ret) {
+			dev_err(dev, "%s - cannot snapshot ctrl and measurement regs\n", __func__);
+			return ret;
+		}
+
+		return 0;
+	case IIO_CHAN_INFO_ENABLE:
+		if (chan->type != IIO_ENERGY)
+			return -EINVAL;
+
+		return pac1711_set_acc_enable(info, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static void pac1711_work_periodic_refresh(struct work_struct *work)
+{
+	struct pac1711_chip_info *info = TO_PAC1711_CHIP_INFO((struct delayed_work *)work);
+	struct device *dev = &info->client->dev;
+
+	dev_dbg(dev, "%s - Periodic refresh\n", __func__);
+
+	/* Do a REFRESH, then read */
+	pac1711_reg_snapshot(info, true, PAC1711_REFRESH_REG_ADDR,
+			     PAC1711_MIN_UPDATE_WAIT_TIME_US, NULL);
+
+	schedule_delayed_work(&info->work_chip_refresh,
+			      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
+}
+
+static int pac1711_init_variant(struct iio_dev *indio_dev, struct pac1711_chip_info *info)
+{
+	switch (info->chip_variant) {
+	case PAC1711_PRODUCT_ID_1711:
+		info->has_16bit_resolution = false;
+		info->voltage_range_idx = PAC1711_VOLTAGE_RANGE_IDX;
+		indio_dev->name = pac1711_chip_features.name;
+		return 0;
+	case PAC1711_PRODUCT_ID_1721:
+		info->has_16bit_resolution = false;
+		info->voltage_range_idx = PAC1721_VOLTAGE_RANGE_IDX;
+		indio_dev->name = pac1721_chip_features.name;
+		return 0;
+	case PAC1711_PRODUCT_ID_1811:
+		info->has_16bit_resolution = true;
+		info->voltage_range_idx = PAC1711_VOLTAGE_RANGE_IDX;
+		indio_dev->name = pac1811_chip_features.name;
+		return 0;
+	case PAC1711_PRODUCT_ID_1821:
+		info->has_16bit_resolution = true;
+		info->voltage_range_idx = PAC1721_VOLTAGE_RANGE_IDX;
+		indio_dev->name = pac1821_chip_features.name;
+		return 0;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int pac1711_chip_identify(struct iio_dev *indio_dev, struct pac1711_chip_info *info)
+{
+	struct i2c_client *client = info->client;
+	struct device *dev = &client->dev;
+	u8 chip_rev_info[3] = { 0 };
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_PID_REG_ADDR,
+					    sizeof(chip_rev_info), chip_rev_info);
+	if (ret != sizeof(chip_rev_info)) {
+		ret = ret < 0 ? ret : -EIO;
+		dev_err(dev, "product ID (0x%02X, 0x%02X, 0x%02X) not recognized %d\n",
+			chip_rev_info[0], chip_rev_info[1], chip_rev_info[2], ret);
+		return ret;
+	}
+
+	info->chip_variant = chip_rev_info[0];
+
+	return pac1711_init_variant(indio_dev, info);
+}
+
+static int pac1711_check_range(struct device *dev, s32 *vals, bool is_vbus,
+			       unsigned int voltage_range_idx)
+{
+	int num_ranges = ARRAY_SIZE(pac1711_vbus_range_tbl[PAC1711_VOLTAGE_RANGE_IDX]);
+	const int (*ranges)[3][2];
+	int i;
+
+	if (is_vbus)
+		switch (voltage_range_idx) {
+		case PAC1711_VOLTAGE_RANGE_IDX:
+			ranges = &pac1711_vbus_range_tbl[PAC1711_VOLTAGE_RANGE_IDX];
+			break;
+		case PAC1721_VOLTAGE_RANGE_IDX:
+			ranges = &pac1711_vbus_range_tbl[PAC1721_VOLTAGE_RANGE_IDX];
+			break;
+		default:
+			return -EINVAL;
+		}
+	else
+		ranges = &pac1711_vsense_range_tbl;
+
+	for (i = 0; i < num_ranges; i++) {
+		if (vals[0] == (*ranges)[i][0] && vals[1] == (*ranges)[i][1])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int pac1711_init_vbus_vsense_ranges(struct pac1711_chip_info *info, bool is_vbus)
+{
+	struct i2c_client *client = info->client;
+	struct device *dev = &client->dev;
+	const char *prop_name;
+	u32 vals[2];
+	int ret;
+
+	if (is_vbus)
+		prop_name = "microchip,vbus-input-range-microvolt";
+	else
+		prop_name = "microchip,vsense-input-range-microvolt";
+
+	ret = device_property_read_u32_array(dev, prop_name, vals, 2);
+	if (ret) {
+		dev_dbg(dev, "%s property error %X\n", prop_name, ret);
+		/* Set default range to PAC1711_FULL_RANGE_UNIPOLAR */
+		ret = PAC1711_FULL_RANGE_UNIPOLAR;
+	} else {
+		ret = pac1711_check_range(dev, (s32 *)vals, is_vbus, info->voltage_range_idx);
+		if (ret < 0)
+			return dev_err_probe(dev, -EINVAL, "Invalid value %d, %d for prop %s\n",
+					     vals[0], vals[1], prop_name);
+	}
+
+	if (is_vbus)
+		info->vbus_mode = ret;
+	else
+		info->vsense_mode = ret;
+
+	return 0;
+}
+
+static int pac1711_parse_fw(struct i2c_client *client, struct pac1711_chip_info *info)
+{
+	struct device *dev = &client->dev;
+	const char *temp;
+	int ret = 0;
+
+	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms", &info->shunt);
+	if (ret)
+		return dev_err_probe(dev, ret, "Shunt resistor property error\n");
+
+	if (!info->shunt)
+		return dev_err_probe(dev, -EINVAL, "Invalid value for shunt resistor\n");
+
+	ret = pac1711_init_vbus_vsense_ranges(info, true);
+	if (ret)
+		return ret;
+
+	ret = pac1711_init_vbus_vsense_ranges(info, false);
+	if (ret)
+		return ret;
+
+	ret = device_property_read_string(dev, "microchip,accumulation-source", &temp);
+	if (ret) {
+		info->accumulation_mode = PAC1711_ACCMODE_VPOWER;
+		return 0;
+	}
+
+	if (!strcmp(temp, PAC1711_ACC_ENERGY_STR))
+		info->accumulation_mode = PAC1711_ACCMODE_VPOWER;
+	else if (!strcmp(temp, PAC1711_ACC_CHARGE_STR))
+		info->accumulation_mode = PAC1711_ACCMODE_VSENSE;
+	else
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid accumulation-source value %s\n", temp);
+
+	dev_dbg(dev, "Accumulation source set to: %s\n", temp);
+
+	return 0;
+}
+
+static void pac1711_cancel_delayed_work(void *dwork)
+{
+	cancel_delayed_work_sync(dwork);
+}
+
+static int pac1711_chip_configure(struct pac1711_chip_info *info)
+{
+	struct i2c_client *client = info->client;
+	struct device *dev = &client->dev;
+	u32 post_refresh_wait;
+	__be16 val_be16;
+	u32 wait_time;
+	u16 val_u16;
+	u8 val_u8;
+	int ret;
+
+	/*
+	 * The current/voltage can be measured unidirectional, bidirectional or half FSR
+	 * no SLOW triggered REFRESH, clear POR
+	 */
+	val_u8 = FIELD_PREP(PAC1711_NEG_PWR_FSR_VS_MASK, info->vsense_mode) |
+		FIELD_PREP(PAC1711_NEG_PWR_FSR_VB_MASK, info->vbus_mode);
+
+	ret = i2c_smbus_write_byte_data(client, PAC1711_NEG_PWR_FSR_REG_ADDR, val_u8);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n",
+				     PAC1711_NEG_PWR_FSR_REG_ADDR);
+
+	ret = i2c_smbus_write_byte_data(client, PAC1711_SLOW_REG_ADDR, 0);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n", PAC1711_SLOW_REG_ADDR);
+
+	/* Get sampling rate from PAC */
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_REG_ADDR,
+					    sizeof(val_u16), (u8 *)&val_be16);
+	if (ret != sizeof(val_u16))
+		return dev_err_probe(dev, ret < 0 ? ret : -EIO,
+				     "cannot read 0x%02X reg\n", PAC1711_CTRL_REG_ADDR);
+
+	val_u16 = be16_to_cpu(val_be16);
+	info->sample_rate_idx = FIELD_GET(PAC1711_CTRL_SAMPLE_MODE_MASK, val_u16);
+	if (info->sample_rate_idx >= ARRAY_SIZE(pac1711_samp_rate_map_tbl)) {
+		/*
+		 * Use default sample rate in case the chip is configured with an sample
+		 * rate unsupported by the driver. The Control Register is updated.
+		 */
+		info->sample_rate_idx = PAC1711_SAMP_1024SPS;
+		FIELD_MODIFY(PAC1711_CTRL_SAMPLE_MODE_MASK, &val_u16, info->sample_rate_idx);
+	}
+
+	/* Configure the accumulation mode */
+	FIELD_MODIFY(PAC1711_CTRL_ACC_MODE_MASK, &val_u16, info->accumulation_mode);
+	val_be16 = cpu_to_be16(val_u16);
+	ret = i2c_smbus_write_i2c_block_data(client, PAC1711_CTRL_REG_ADDR,
+					     sizeof(val_be16), (u8 *)&val_be16);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n", PAC1711_CTRL_REG_ADDR);
+
+	/*
+	 * Sending a REFRESH to the chip, so the new settings take place
+	 * as well as resetting the accumulators
+	 */
+	ret = i2c_smbus_write_byte(client, PAC1711_REFRESH_REG_ADDR);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n",
+				     PAC1711_REFRESH_REG_ADDR);
+
+	if (info->sample_rate_idx < ARRAY_SIZE(pac1711_samp_rate_map_tbl) &&
+	    pac1711_samp_rate_map_tbl[info->sample_rate_idx] > 0)
+		post_refresh_wait = 1000000 / pac1711_samp_rate_map_tbl[info->sample_rate_idx];
+	else
+		post_refresh_wait = 1000;
+
+	fsleep(post_refresh_wait);
+
+	/*
+	 * Get the current (in the chip) sampling speed and compute the
+	 * required timeout based on its value the timeout is 1/sampling_speed
+	 * wait the maximum amount of time to be on the safe side - the
+	 * maximum wait time is for 8sps
+	 */
+	wait_time = ((1024 * 1000) / pac1711_samp_rate_map_tbl[info->sample_rate_idx]);
+	fsleep(wait_time);
+
+	/*
+	 * VACC and ACC_COUNT registers increment continuously in hardware and do not
+	 * roll over, so without a periodic Refresh (any) command before the worst-case
+	 * overflow time is reached, the accumulated data would be silently lost.
+	 *
+	 * A periodic refresh works regardless of board pin configuration, while
+	 * A0/A1 pins are optional (shared with SLOW/GPIO functions and may not be
+	 * wired as ALERT on every board).
+	 */
+	INIT_DELAYED_WORK(&info->work_chip_refresh, pac1711_work_periodic_refresh);
+	/* Setup the latest moment for reading the regs before saturation */
+	schedule_delayed_work(&info->work_chip_refresh,
+			      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
+
+	return devm_add_action_or_reset(&client->dev, pac1711_cancel_delayed_work,
+					&info->work_chip_refresh);
+}
+
+static const struct iio_chan_spec pac1711_chan_spec[] = {
+	PAC1711_VBUS_CHANNEL(0, PAC1711_VBUS_REG_ADDR),
+	PAC1711_VSENSE_CHANNEL(0, PAC1711_VSENSE_REG_ADDR),
+	PAC1711_VPOWER_CHANNEL(0, PAC1711_VPOWER_REG_ADDR),
+	PAC1711_ACC_CHANNEL(0, PAC1711_VACC_REG_ADDR)
+};
+
+static int pac1711_prep_custom_attributes(struct iio_dev *indio_dev,
+					  struct pac1711_chip_info *info)
+{
+	switch (info->accumulation_mode) {
+	case PAC1711_ACCMODE_VPOWER:
+		indio_dev->num_channels = ARRAY_SIZE(pac1711_chan_spec);
+		break;
+	case PAC1711_ACCMODE_VSENSE:
+		indio_dev->num_channels = ARRAY_SIZE(pac1711_chan_spec) - 1;
+		info->iio_info.attrs = &pac1711_coulomb_counter_group;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int pac1711_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *channel,
+			      const int **vals, int *type, int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT;
+		*vals = pac1711_samp_rate_map_tbl;
+		*length = ARRAY_SIZE(pac1711_samp_rate_map_tbl);
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info pac1711_info = {
+	.read_raw = pac1711_read_raw,
+	.write_raw = pac1711_write_raw,
+	.read_avail = pac1711_read_avail,
+};
+
+static int pac1711_probe(struct i2c_client *client)
+{
+	const struct pac1711_features *chip;
+	struct device *dev = &client->dev;
+	struct pac1711_chip_info *info;
+	struct iio_dev *indio_dev;
+	int ret, err;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+	info->client = client;
+
+	ret = pac1711_chip_identify(indio_dev, info);
+	if (ret == -ENODEV) {
+		/*
+		 * If it fails to identify the hardware based on internal
+		 * registers, use compatible from devicetree.
+		 */
+		chip = i2c_get_match_data(client);
+		if (!chip)
+			return -EINVAL;
+
+		info->chip_variant = chip->prod_id;
+		ret = pac1711_init_variant(indio_dev, info);
+		if (ret)
+			return ret;
+	} else if (ret) {
+		return ret;
+	}
+
+	/* Always start with accumulation channels enabled. */
+	info->enable_acc = true;
+
+	err = pac1711_parse_fw(client, info);
+	if (err)
+		return dev_err_probe(dev, err, "Error parsing devicetree data\n");
+
+	ret = devm_mutex_init(dev, &info->lock);
+	if (ret)
+		return ret;
+
+	ret = pac1711_chip_configure(info);
+	if (ret)
+		return ret;
+
+	info->iio_info = pac1711_info;
+	indio_dev->info = &info->iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = pac1711_chan_spec;
+
+	ret = pac1711_prep_custom_attributes(indio_dev, info);
+	if (ret)
+		return dev_err_probe(dev, ret, "Can't configure custom attributes\n");
+
+	/* Read what has been accumulated in the chip so far and reset the accumulators. */
+	scoped_guard(mutex, &info->lock) {
+		ret = pac1711_reg_snapshot_locked(info, true, PAC1711_REFRESH_REG_ADDR,
+						  PAC1711_MIN_UPDATE_WAIT_TIME_US);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Can't register IIO device\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id pac1711_id[] = {
+	{ .name = "pac1711", .driver_data = (kernel_ulong_t)&pac1711_chip_features },
+	{ .name = "pac1721", .driver_data = (kernel_ulong_t)&pac1721_chip_features },
+	{ .name = "pac1811", .driver_data = (kernel_ulong_t)&pac1811_chip_features },
+	{ .name = "pac1821", .driver_data = (kernel_ulong_t)&pac1821_chip_features },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pac1711_id);
+
+static const struct of_device_id pac1711_of_match[] = {
+	{ .compatible = "microchip,pac1711", .data = &pac1711_chip_features },
+	{ .compatible = "microchip,pac1721", .data = &pac1721_chip_features },
+	{ .compatible = "microchip,pac1811", .data = &pac1811_chip_features },
+	{ .compatible = "microchip,pac1821", .data = &pac1821_chip_features },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pac1711_of_match);
+
+static struct i2c_driver pac1711_driver = {
+	.driver	 = {
+		.name = "pac1711",
+		.of_match_table = pac1711_of_match,
+	},
+	.probe = pac1711_probe,
+	.id_table = pac1711_id,
+};
+
+module_i2c_driver(pac1711_driver);
+
+MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
+MODULE_DESCRIPTION("IIO driver for PAC1711 DC Power Monitor with Accumulator");
+MODULE_LICENSE("GPL");

-- 
2.43.0

