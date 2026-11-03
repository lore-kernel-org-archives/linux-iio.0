Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716687;
	b=Yo7zuXE14m9TQdS79SD/zYhPDDZwbO3lh3PPwsAEn7lQH3dcpZuFl6RIPFLBy99zz/7K
	 J5TFfbWTjbJWYqtJz3wMnVGrJTMLEHp2szE8Yb108Ho+k6mF1k2wr3AR+bINaDNhhu0U1
	 vh/h4RDbR3/+5zwlyIh+fypvnaR7edNwfOnWkawlyVrMssY+ORK/EPt8tAmt0j6Euhdgj
	 UlgrBHXzKd843c8Tq4m/YtHEgeokhBdpDqfqY/2t925RdixA2jppD0AZMgFxyx8UpyxIO
	 CYJhBH7XxBaD30icIxJKnpt+giEeinn7rQ9m7AAqw13CSmeJFYGKOu4BEkYFCERKHyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716687;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=wsXPzLDTPBpT1BMxVd2gGryzSlplLsKjop0eeSLKUq8=;
	b=ZX/34WnfJrG1DXvrMr1bLubZli7XzqvlvunuW06Pu7V91Q2qbRYR4ejVPBa4pw0g0H2G
	 Bcyxe5VF+j+Dho/SGF/pNRRHo4xmaxUEEj2rSSl5UYz2GPoZd+Yq1Vp44Cx73VLekLIhz
	 7hcYirBVywvL4A0NKudjovFRsn9j3sxXFvRJs+J34JW6sB3n48lV8kMd1Y3YaXSZHL4/O
	 /fkIFG68DOMD0vdxoH6x7QH38yOt0GO1c7LMtL+uJPj1pERtfb11eW85EvAU8U75HQtv0
	 GRIxk6QuPQ31CAhRX34rUy4vQlUI4huZVP9H104nbi20+37/yrd92DUGzxGQn4aWnvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=YgE4i4BA;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E6606D831;
	Tue,  3 Nov 2026 14:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 575E6606D831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=YgE4i4BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793716687; x=1825252687;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ZI1AJY0FX/j00jP7kcQrIox8wjrcqCq/TddN+RnpSzs=;
  b=YgE4i4BASngI+dnbgJagcKZtqUvcXBKdIo1xg4pfpyy1hje0nFaH70Ih
   8oml7LVxPKuiz9eBRRlTh3giifurFyzVULIppHT4VOcCGV9jY/50xNeVe
   2ef2a2vuDXyNuP6JYtimnN13wuimtjVBpP4TvRXw3yXsjrhKLBBtMybEu
   sKR/TShpX+aq7zhGJAXwRw8v/mc0KPQ+fbirbFEeKTMQv0c+kE1MOswAz
   lOp0G+0o8Cp+b7ngai/QkjO00CG/8khNwHF3lIJh9I4DbD/jFsGQabPMW
   G05d1Lj9JdcR+8ro4D26azIW27TaxpMJI3hJGffJqL1Qcxj16QrwnhpKV
   A==;
X-CSE-ConnectionGUID: J0/XNsnYQfGBKNs7axm/dg==
X-CSE-MsgGUID: Q6vEu7f+RNikpPrMmoii7Q==
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="297372638"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2026 07:38:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Nov 2026 07:38:04 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 3 Nov 2026 07:38:01 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Tue, 3 Nov 2026 16:37:15 +0200
Subject: [PATCH v5 5/5] iio: adc: add support for PAC1711
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261103-pac1711-v5-5-71c20101a52e@microchip.com>
References: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
In-Reply-To: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Marius Cristea <marius.cristea@microchip.com>,
	Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793716664; l=42058;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=ZI1AJY0FX/j00jP7kcQrIox8wjrcqCq/TddN+RnpSzs=;
 b=gDqqV4x15AmDp1kTAK3p2VFq9Unfvlwz9Olessta1EPWEnUFXJAYUJcUW1zgraDnZyxi0Zo2z
 M86tCAzblkrA0IoBHxU02qBkr5SwenmiXh+AqXu8wbKOup/w5SIbJ8l
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
 MAINTAINERS               |    1 +
 drivers/iio/adc/Kconfig   |   11 +
 drivers/iio/adc/Makefile  |    1 +
 drivers/iio/adc/pac1711.c | 1233 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1246 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ebba9b0b3f834576b422b96283f9a3cc79405c3a..1b2c69a4456a3e155277b1e8593e618e2862d714 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17894,6 +17894,7 @@ M:	Ariana Lazar <ariana.lazar@microchip.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
+F:	drivers/iio/adc/pac1711.c
 
 MICROCHIP PAC1921 POWER/CURRENT MONITOR DRIVER
 M:	Matteo Martelli <matteomartelli3@gmail.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 415e519ad4eb48c136174e7faf35a1fe6d46d80a..8b51e0165d5ae6f732a05bdaee4085e8f71673d2 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1320,6 +1320,17 @@ config NXP_SAR_ADC
 	  This driver can also be built as a module. If so, the module will be
 	  called nxp_sar_adc.
 
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
index dcec0abb03b73b994382d7de335670f4cf2d14b3..33487568f0c138033a482ac9b01b274790d1e469 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -114,6 +114,7 @@ obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_NCT7201) += nct7201.o
 obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
 obj-$(CONFIG_NXP_SAR_ADC) += nxp-sar-adc.o
+obj-$(CONFIG_PAC1711) += pac1711.o
 obj-$(CONFIG_PAC1921) += pac1921.o
 obj-$(CONFIG_PAC1934) += pac1934.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
diff --git a/drivers/iio/adc/pac1711.c b/drivers/iio/adc/pac1711.c
new file mode 100644
index 0000000000000000000000000000000000000000..6adc37a7ba0be882397a15b749bd9b1a657a96d6
--- /dev/null
+++ b/drivers/iio/adc/pac1711.c
@@ -0,0 +1,1233 @@
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
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/jiffies.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/math64.h>
+#include <linux/mutex.h>
+#include <linux/overflow.h>
+#include <linux/property.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+#include <linux/workqueue.h>
+#include <asm/byteorder.h>
+
+#include <linux/iio/iio.h>
+
+/*
+ * Maximum accumulation time should be 1,165 hours at 1,024 sps
+ * till PAC1711 accumulation registers starts to saturate
+ */
+#define PAC1711_MAX_RFSH_LIMIT_MS	(60 * MSEC_PER_SEC)
+/* 50msec is the timeout for validity of the cached registers */
+#define PAC1711_MIN_POLLING_TIME_MS	50
+
+#define PAC1711_VOLTAGE_MILLIVOLTS_MAX	(42 * MILLI)
+#define PAC1721_VOLTAGE_MILLIVOLTS_MAX	(9 * MILLI)
+
+/* Full FSR power is multiplied by 10^9 to ensure precise scale calculation. */
+#define PAC1711_PRODUCT_VOLTAGE_PV_FSR	(4200ULL * NANO)
+#define PAC1721_PRODUCT_VOLTAGE_PV_FSR	(900ULL * NANO)
+
+/* PAC1711/PAC1811 VBUS FSR: 42V and 21V */
+#define PAC1711_VBUS_FSR_UV		(42 * MICRO)
+#define PAC1711_VBUS_FSR_HALF_UV	(21 * MICRO)
+
+/* PAC1721/PAC1821 VBUS FSR: 9V and 4.5V */
+#define PAC1721_VBUS_FSR_UV		(9 * MICRO)
+#define PAC1721_VBUS_FSR_HALF_UV	(4500 * MILLI)
+
+/* VSENSE FSR: 100mV and 50mV */
+#define PAC1711_VSENSE_FSR_UV		(100 * MILLI)
+#define PAC1711_VSENSE_FSR_HALF_UV	(50 * MILLI)
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
+static const char * const pac1711_acc_sources[] = {
+	[PAC1711_ACCMODE_VPOWER] = PAC1711_ACC_ENERGY_STR,
+	[PAC1711_ACCMODE_VSENSE] = PAC1711_ACC_CHARGE_STR,
+};
+
+static const int pac1711_vbus_range_tbl[2][3][2] = {
+	[PAC1711_VOLTAGE_RANGE_IDX] = {
+		[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, PAC1711_VBUS_FSR_UV },
+		[PAC1711_FULL_RANGE_BIPOLAR]  = { -(int)PAC1711_VBUS_FSR_UV, PAC1711_VBUS_FSR_UV },
+		[PAC1711_HALF_RANGE_BIPOLAR]  = { -(int)PAC1711_VBUS_FSR_HALF_UV,
+						  PAC1711_VBUS_FSR_HALF_UV },
+	},
+	[PAC1721_VOLTAGE_RANGE_IDX] = {
+		[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, PAC1721_VBUS_FSR_UV },
+		[PAC1711_FULL_RANGE_BIPOLAR]  = { -(int)PAC1721_VBUS_FSR_UV, PAC1721_VBUS_FSR_UV },
+		[PAC1711_HALF_RANGE_BIPOLAR]  = { -(int)PAC1721_VBUS_FSR_HALF_UV,
+						  PAC1721_VBUS_FSR_HALF_UV },
+	},
+};
+
+static const int pac1711_vsense_range_tbl[3][2] = {
+	[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, PAC1711_VSENSE_FSR_UV },
+	[PAC1711_FULL_RANGE_BIPOLAR] = { -(int)PAC1711_VSENSE_FSR_UV, PAC1711_VSENSE_FSR_UV },
+	[PAC1711_HALF_RANGE_BIPOLAR] = { -(int)PAC1711_VSENSE_FSR_HALF_UV,
+					 PAC1711_VSENSE_FSR_HALF_UV },
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
+static const int pac1711_samp_rate_map_tbl[] = {
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
+ * @voltage_pv_fsr: Maximum power-product value for FSR
+ * @voltage_millivolts_max: Scale maximum for millivolts
+ * @name: chip's name
+ * @voltage_range_idx: Voltage range based on part number
+ * @has_16bit_resolution: true if device is part of the PAC18x1 family
+ */
+struct pac1711_features {
+	u64 voltage_pv_fsr;
+	int voltage_millivolts_max;
+	const char *name;
+	u8 voltage_range_idx;
+	bool has_16bit_resolution;
+};
+
+static const struct pac1711_features pac1711_chip_features = {
+	.name = "pac1711",
+	.has_16bit_resolution = false,
+	.voltage_range_idx = PAC1711_VOLTAGE_RANGE_IDX,
+	.voltage_pv_fsr = PAC1711_PRODUCT_VOLTAGE_PV_FSR,
+	.voltage_millivolts_max = PAC1711_VOLTAGE_MILLIVOLTS_MAX,
+};
+
+static const struct pac1711_features pac1721_chip_features = {
+	.name = "pac1721",
+	.has_16bit_resolution = false,
+	.voltage_range_idx = PAC1721_VOLTAGE_RANGE_IDX,
+	.voltage_pv_fsr = PAC1721_PRODUCT_VOLTAGE_PV_FSR,
+	.voltage_millivolts_max = PAC1721_VOLTAGE_MILLIVOLTS_MAX,
+};
+
+static const struct pac1711_features pac1811_chip_features = {
+	.name = "pac1811",
+	.has_16bit_resolution = true,
+	.voltage_range_idx = PAC1711_VOLTAGE_RANGE_IDX,
+	.voltage_pv_fsr = PAC1711_PRODUCT_VOLTAGE_PV_FSR,
+	.voltage_millivolts_max = PAC1711_VOLTAGE_MILLIVOLTS_MAX,
+};
+
+static const struct pac1711_features pac1821_chip_features = {
+	.name = "pac1821",
+	.has_16bit_resolution = true,
+	.voltage_range_idx = PAC1721_VOLTAGE_RANGE_IDX,
+	.voltage_pv_fsr = PAC1721_PRODUCT_VOLTAGE_PV_FSR,
+	.voltage_millivolts_max = PAC1721_VOLTAGE_MILLIVOLTS_MAX,
+};
+
+/**
+ * struct pac1711_reg_data - data from the registers
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
+struct pac1711_reg_data {
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
+ * @features:			device features pointer
+ * @client:			the I2C client attached to the device
+ * @work_chip_refresh:		work queue used for refresh commands
+ * @lock:			synchronize access to driver's state members
+ * @shunt:			shunt resistor value
+ * @vbus_mode:			Full Scale Range (FSR) mode for VBus
+ * @vsense_mode:		Full Scale Range (FSR) mode for VSense
+ * @accumulation_mode:		accumulation mode for hardware accumulator
+ * @sample_rate_idx:		sampling frequency index
+ * @enable_acc:			true means that accumulation channel is enabled
+ */
+struct pac1711_chip_info {
+	struct pac1711_reg_data		chip_reg_data;
+	struct iio_info			iio_info;
+	const struct pac1711_features	*features;
+	struct i2c_client		*client;
+	struct delayed_work		work_chip_refresh;
+	/* Prevents concurrent writes into control, voltage measurement or accumulator registers. */
+	struct mutex			lock;
+	u32				shunt;
+	u8				vbus_mode;
+	u8				vsense_mode;
+	u8				accumulation_mode;
+	u8				sample_rate_idx;
+	bool				enable_acc;
+};
+
+static int pac1711_send_refresh(struct pac1711_chip_info *info, u32 wait_time)
+{
+	struct i2c_client *client = info->client;
+	int ret;
+
+	/* Writing a REFRESH or a REFRESH_V command */
+	ret = i2c_smbus_write_byte(client, PAC1711_REFRESH_REG_ADDR);
+	if (ret) {
+		dev_err(&client->dev, "%s - cannot send Refresh cmd (0x%02X)\n",
+			__func__, PAC1711_REFRESH_REG_ADDR);
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
+static int pac1711_reg_snapshot_locked(struct pac1711_chip_info *info, u32 wait_time)
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
+	ret = pac1711_send_refresh(info, wait_time);
+	if (ret < 0) {
+		dev_err(dev, "cannot send refresh\n");
+		return ret;
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
+		info->chip_reg_data.vacc = get_unaligned_be56(offset_reg_data_p);
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
+static int pac1711_reg_snapshot(struct pac1711_chip_info *info, bool *refreshed)
+{
+	u32 wait_time;
+	int ret;
+
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
+	wait_time = (1024 * 1000) / pac1711_samp_rate_map_tbl[info->sample_rate_idx];
+
+	/* A hardware refresh will happen */
+	ret = pac1711_reg_snapshot_locked(info, wait_time);
+	if (!ret && refreshed)
+		*refreshed = true;
+
+	return ret;
+}
+
+static int pac1711_retrieve_data(struct pac1711_chip_info *info)
+{
+	bool refreshed = false;
+	int ret;
+
+	/*
+	 * Restart the background timer to begin a new accumulation window if an
+	 * actual hardware refresh took place.
+	 */
+	ret = pac1711_reg_snapshot(info, &refreshed);
+	if (ret < 0)
+		return ret;
+
+	if (refreshed)
+		mod_delayed_work(system_percpu_wq, &info->work_chip_refresh,
+				 msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
+
+	return 0;
+}
+
+static int pac1711_get_samp_rate_idx(u32 new_samp_rate)
+{
+	for (unsigned int cnt = 0; cnt < ARRAY_SIZE(pac1711_samp_rate_map_tbl); cnt++)
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
+	guard(mutex)(&info->lock);
+
+	return sysfs_emit(buf, "%u\n", info->shunt);
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
+	guard(mutex)(&info->lock);
+
+	if (val == info->enable_acc)
+		return 0;
+
+	/*
+	 * Force a hardware refresh to zero out the internal accumulators
+	 * and start a new measurement window, as the chip accumulates
+	 * continuously in the background.
+	 */
+	if (val) {
+		sample_rate = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
+		wait_time = (1024 * 1000) / sample_rate;
+		ret = pac1711_send_refresh(info, wait_time);
+	} else {
+		info->chip_reg_data.acc_val = 0;
+		info->chip_reg_data.vacc = 0;
+		info->chip_reg_data.acc_count = 0;
+	}
+
+	if (!ret)
+		info->enable_acc = val;
+
+	if (ret)
+		dev_err(dev, "failed to reset accumulator: %d\n", ret);
+
+	return ret;
+}
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
+	guard(mutex)(&info->lock);
+
+	info->shunt = sh_val;
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
+#define PAC1711_VBUS_CHANNEL(_index, _address) {				\
+	.type = IIO_VOLTAGE,							\
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
+	.ext_info = pac1711_ext_info,						\
+}
+
+#define PAC1711_ACC_CHANNEL(_index, _address, _type) {				\
+	.type = (_type),							\
+	.address = (_address),							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	|			\
+			      BIT(IIO_CHAN_INFO_SCALE)	|			\
+			      BIT(IIO_CHAN_INFO_ENABLE),			\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.ext_info = pac1711_ext_info,						\
+}
+
+static int pac1711_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	int ret, shift;
+	u64 tmp = 0;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = pac1711_retrieve_data(info);
+		if (ret)
+			return ret;
+
+		switch (chan->type) {
+		case IIO_VOLTAGE: {
+			guard(mutex)(&info->lock);
+			*val = info->chip_reg_data.vbus;
+			return IIO_VAL_INT;
+		}
+		case IIO_CURRENT: {
+			guard(mutex)(&info->lock);
+			*val = info->chip_reg_data.vsense;
+			return IIO_VAL_INT;
+		}
+		case IIO_POWER: {
+			guard(mutex)(&info->lock);
+			iio_fill_val_int_64(info->chip_reg_data.vpower, val, val2);
+			return IIO_VAL_INT_64;
+		}
+		case IIO_ENERGY:
+		case IIO_CHARGE: {
+			guard(mutex)(&info->lock);
+			iio_fill_val_int_64(info->chip_reg_data.acc_val, val, val2);
+			return IIO_VAL_INT_64;
+		}
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE: {
+		u32 shunt;
+
+		guard(mutex)(&info->lock);
+		shunt = info->shunt;
+
+		switch (chan->address) {
+		case PAC1711_VBUS_REG_ADDR:
+			*val = info->features->voltage_millivolts_max;
+			*val2 = (info->vbus_mode == PAC1711_FULL_RANGE_BIPOLAR) ? 15 : 16;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case PAC1711_VSENSE_REG_ADDR:
+			/*
+			 * Currents - scale for mA - depends on the channel's shunt value
+			 * (100mV * 1000000) / (2^16 * shunt(uohm))
+			 */
+			*val = 1526;
+			*val2 = shunt;
+
+			if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
+				*val = *val << 1;
+
+			return IIO_VAL_FRACTIONAL;
+		case PAC1711_VPOWER_REG_ADDR:
+		case PAC1711_VACC_REG_ADDR:
+			if (chan->type == IIO_CHARGE) {
+				/*
+				 * Coulomb counter scale:
+				 * 16-bit resolution: (100mV * NANO) / 2^16
+				 * 12-bit resolution: (100mV * NANO) / 2^12
+				 */
+				u64 ref = info->features->has_16bit_resolution ?
+						  1525878906250ULL : 24414062500000ULL;
+
+				if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
+					ref = ref << 1;
+
+				ref = div_u64(ref, shunt);
+				*val2 = do_div(ref, 1 * NANO);
+				*val = ref;
+
+				return IIO_VAL_INT_PLUS_NANO;
+			}
+
+			/*
+			 * Power - uW - it will use the combined scale
+			 * for current and voltage
+			 * current(mA) * voltage(mV) = power (uW)
+			 */
+			tmp = info->features->voltage_pv_fsr;
+			do_div(tmp, shunt);
+
+			if (chan->type == IIO_ENERGY)
+				*val2 = info->features->has_16bit_resolution ? 32 : 24;
+			else
+				*val2 = 32;
+
+			if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
+				*val2 -= 1;
+
+			if (info->vbus_mode == PAC1711_FULL_RANGE_BIPOLAR)
+				*val2 -= 1;
+
+			shift = fls64(tmp) - 31;
+			if (shift > 0) {
+				tmp >>= shift;
+				*val2 -= shift;
+			}
+
+			*val = (int)tmp;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
+	}
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&info->lock);
+		*val = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_ENABLE:  {
+		guard(mutex)(&info->lock);
+		*val = info->enable_acc;
+		return IIO_VAL_INT;
+	}
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
+	int new_idx, ret, refresh_time;
+	s32 old_samp_rate;
+	__be16 val_be16;
+	u32 wait_time;
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
+			val_be16 = cpu_to_be16(val_u16);
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
+			refresh_time = msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS) + 1;
+			info->chip_reg_data.jiffies_tstamp = jiffies - refresh_time;
+			wait_time = (1024 * 1000) / old_samp_rate;
+
+			/*
+			 * We must wait for cycle completion before updating the
+			 * sample rate value.
+			 */
+			ret = pac1711_reg_snapshot_locked(info, wait_time);
+			if (ret) {
+				dev_err(dev, "%s - cannot snapshot ctrl and measurement regs\n",
+					__func__);
+				return ret;
+			}
+		}
+
+		return 0;
+	case IIO_CHAN_INFO_ENABLE:
+		return pac1711_set_acc_enable(info, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static void pac1711_work_periodic_refresh(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct pac1711_chip_info *info = container_of(dwork, struct pac1711_chip_info,
+						      work_chip_refresh);
+	struct device *dev = &info->client->dev;
+	int ret;
+
+	dev_dbg(dev, "%s - Periodic refresh\n", __func__);
+
+	/* Do a REFRESH, then read */
+	ret = pac1711_reg_snapshot(info, NULL);
+	if (ret)
+		dev_err(dev, "Refresh failed: %d\n", ret);
+
+	schedule_delayed_work(&info->work_chip_refresh,
+			      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
+}
+
+static const struct pac1711_features *pac1711_get_features_from_id(u8 id)
+{
+	switch (id) {
+	case PAC1711_PRODUCT_ID_1711:
+		return &pac1711_chip_features;
+	case PAC1711_PRODUCT_ID_1721:
+		return &pac1721_chip_features;
+	case PAC1711_PRODUCT_ID_1811:
+		return &pac1811_chip_features;
+	case PAC1711_PRODUCT_ID_1821:
+		return &pac1821_chip_features;
+	default:
+		return NULL;
+	}
+}
+
+static int pac1711_chip_identify(struct iio_dev *indio_dev, struct pac1711_chip_info *info)
+{
+	struct i2c_client *client = info->client;
+	struct device *dev = &client->dev;
+	u8 chip_rev_info[3] = { };
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_PID_REG_ADDR,
+					    sizeof(chip_rev_info), chip_rev_info);
+	if (ret != sizeof(chip_rev_info)) {
+		ret = ret < 0 ? ret : -EIO;
+		return dev_err_probe(dev, ret, "product ID not recognized\n");
+	}
+
+	info->features = pac1711_get_features_from_id(chip_rev_info[0]);
+	if (!info->features)
+		return -ENODEV;
+
+	indio_dev->name = info->features->name;
+
+	return 0;
+}
+
+static int pac1711_check_range(s32 *vals, bool is_vbus, unsigned int voltage_range_idx)
+{
+	int num_ranges = ARRAY_SIZE(pac1711_vbus_range_tbl[PAC1711_VOLTAGE_RANGE_IDX]);
+	const int (*ranges)[3][2];
+
+	if (is_vbus) {
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
+	} else {
+		ranges = &pac1711_vsense_range_tbl;
+	}
+
+	for (unsigned int i = 0; i < num_ranges; i++) {
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
+	u32 raw_vals[2];
+	s32 vals[2];
+	int ret;
+
+	if (is_vbus)
+		prop_name = "microchip,vbus-input-range-microvolt";
+	else
+		prop_name = "microchip,vsense-input-range-microvolt";
+
+	if (device_property_present(dev, prop_name)) {
+		ret = device_property_read_u32_array(dev, prop_name, raw_vals, 2);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Cannot read %s property\n", prop_name);
+
+		/*
+		 * For bipolar FSR the lower limit is a negative number. Since
+		 * firmware properties are read as u32 arrays, cast them to
+		 * s32 is required to correctly handle these signed values.
+		 */
+		vals[0] = (s32)raw_vals[0];
+		vals[1] = (s32)raw_vals[1];
+		ret = pac1711_check_range(vals, is_vbus, info->features->voltage_range_idx);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Invalid value %d, %d for prop %s\n",
+					     vals[0], vals[1], prop_name);
+	} else {
+		ret = PAC1711_FULL_RANGE_UNIPOLAR;
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
+	int ret;
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
+	if (device_property_present(dev, "microchip,accumulation-source")) {
+		ret = device_property_match_property_string(dev, "microchip,accumulation-source",
+							    pac1711_acc_sources,
+							    ARRAY_SIZE(pac1711_acc_sources));
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Invalid accumulation-source value\n");
+
+		info->accumulation_mode = ret;
+	} else {
+		info->accumulation_mode = PAC1711_ACCMODE_VPOWER;
+	}
+
+	dev_dbg(dev, "Accumulation source set to: %s\n",
+		pac1711_acc_sources[info->accumulation_mode]);
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
+static const struct iio_chan_spec pac1711_energy_chan_spec[] = {
+	PAC1711_VBUS_CHANNEL(0, PAC1711_VBUS_REG_ADDR),
+	PAC1711_VSENSE_CHANNEL(0, PAC1711_VSENSE_REG_ADDR),
+	PAC1711_VPOWER_CHANNEL(0, PAC1711_VPOWER_REG_ADDR),
+	PAC1711_ACC_CHANNEL(0, PAC1711_VACC_REG_ADDR, IIO_ENERGY)
+};
+
+static const struct iio_chan_spec pac1711_charge_chan_spec[] = {
+	PAC1711_VBUS_CHANNEL(0, PAC1711_VBUS_REG_ADDR),
+	PAC1711_VSENSE_CHANNEL(0, PAC1711_VSENSE_REG_ADDR),
+	PAC1711_VPOWER_CHANNEL(0, PAC1711_VPOWER_REG_ADDR),
+	PAC1711_ACC_CHANNEL(0, PAC1711_VACC_REG_ADDR, IIO_CHARGE)
+};
+
+static int pac1711_setup_channels(struct iio_dev *indio_dev, struct pac1711_chip_info *info)
+{
+	switch (info->accumulation_mode) {
+	case PAC1711_ACCMODE_VPOWER:
+		indio_dev->channels = pac1711_energy_chan_spec;
+		indio_dev->num_channels = ARRAY_SIZE(pac1711_energy_chan_spec);
+		return 0;
+	case PAC1711_ACCMODE_VSENSE:
+		indio_dev->channels = pac1711_charge_chan_spec;
+		indio_dev->num_channels = ARRAY_SIZE(pac1711_charge_chan_spec);
+		return 0;
+	default:
+		return -EINVAL;
+	}
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
+	struct device *dev = &client->dev;
+	struct pac1711_chip_info *info;
+	struct iio_dev *indio_dev;
+	u32 wait_time;
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
+		info->features = i2c_get_match_data(client);
+		if (!info->features)
+			return -EINVAL;
+
+		indio_dev->name = info->features->name;
+	} else if (ret) {
+		return dev_err_probe(&client->dev, ret, "Failed to identify chip\n");
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
+
+	ret = pac1711_setup_channels(indio_dev, info);
+	if (ret)
+		return dev_err_probe(dev, ret, "Invalid channel configuration\n");
+
+	/* Read what has been accumulated in the chip so far and reset the accumulators. */
+	wait_time = (1024 * 1000) / pac1711_samp_rate_map_tbl[info->sample_rate_idx];
+	scoped_guard(mutex, &info->lock) {
+		ret = pac1711_reg_snapshot_locked(info, wait_time);
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
+module_i2c_driver(pac1711_driver);
+
+MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
+MODULE_DESCRIPTION("IIO driver for PAC1711 DC Power Monitor with Accumulator");
+MODULE_LICENSE("GPL");

-- 
2.43.0

