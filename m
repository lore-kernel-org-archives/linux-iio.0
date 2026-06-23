Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BDD3803C7
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223285; cv=none; b=HbIYX2oY6or8Dk9JtcEH9nj0p19AtwxPnQNPB9s9opDE726mA0CxI6tWD8MF/VfzTX7rx0VdkklrIHeVTdWakPsPKM6DXcQ3J39xd2ef3x7SzHOpkgYUbIDaO5bunJoLvz5gaCXJ2TsVai+mnQbJGT+MXQEsA/+8KHXWoB7MuaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223285; c=relaxed/simple;
	bh=COEs0zGlmyvfL1WDK7LPaKKf8YQw5+Xt+5fp9GrpYJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4dH4SnQh49u0A6C1tlLED1ZUywqKWdDC6HpT8B0Dgk7MqHwY+ShwRgoinNJFZtdlQn2QMbVAH9rWG6lFglW9J8o9/I6LVfYpocgmywo5mhC4Nlmng7PrDJqZKt3GBC/3k2dP3pw7ihJ4vO/0cIx7QipeNLcu6zPFIwRAvxypts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDjyinIP; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDjyinIP"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa6792e7b8so6226846e87.1
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782223281; x=1782828081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4Kr6ONG1qAZjFqWcnu9J9DWVEaikUmnEwblMoi7vvg=;
        b=HDjyinIPu94JLBKH30XBxFFyqVHdxuF8WKLjCb4XaHt25YpauqWb6oa43OiJyrGMYX
         MXwWeHbBd8m6WaHB64od0Re68GKzxuDaXlQVVWYZJuyafBrph24FYXgbCgPn2Tssvy8s
         COWi/XdagYHSFvxi11hXcx1JipqGAeqAyMLRZKXfxJIZCsAChKQrEjGG/UGvp/FNTIwb
         1ZAFgSm9z4kGcJh7xVsibuAZtIOaiuD2JDXtKj2xDAHk6lj35h2RC2T/0ZAZf1uU9hIs
         JOTZhuig0r+ostaObOLJMqD0TIFW1af8vB0cidKgJ3iQQ5eN1f/bc3ReeJYUIk2XVe5T
         l2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782223281; x=1782828081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v4Kr6ONG1qAZjFqWcnu9J9DWVEaikUmnEwblMoi7vvg=;
        b=F5ST2O3k0rJIlZ9kzTwTD+JHl3sHs5z62KXv2ZBsm7MJTxpAt2a9qG5Rzp1KzuEvTV
         H5czvZSzrehBoPTkZ69nEkTEuiG8ko1IT7Fd0cmOScs41j/70VTPeCjICSDaee2+nCSd
         irXGvchYzQ4uesWL3DoIpr8Ym1G6yB1p6+h7D56LPkWw8Z81FCnfXBpgcVMiDVpw66F7
         cpJN4QAHwOgxenomVC7GIA3abPmF9muedTRZlfQioTUGfKiAuBivieVqu5lAGv87OBsI
         lR/WhyWxQuZWdih5G8amuFsLxMBSpHj267f3Vni9QpAPUrTX1BvioBm1uEduzEHGeRLd
         sPeA==
X-Gm-Message-State: AOJu0Yw7jr9l4/qrrgQWa+3TfEZn/x0QtzGwAS5qZpdKol2o2IR9XddU
	RuZbYJYCcgqjgT8cIm0TpKm5X3ROyh3zzT11SaVZXnDwi5k+I+IX54TiY5ZmQiOPi7DiBQ==
X-Gm-Gg: AfdE7cli02K2MfYTHE7D5fTtbRJYzDTnbeYdkivsQ2mcS93OJCe86CTVKKi945viwNM
	P5eN6ngI+ZJ2RMtZEBTYuoj5lB39H4OT/tr0Q8DLoNc6/U5EQ57vh/ELMY/SEMqBfKXUZ4pmOvc
	gizB4v8EgkF8Aox0U4d9wt+rPcLrwpuQrCDQJyQuvfHz/voBZiJhnDuDUbrEuGyP+13+c30Jf8J
	mUQUwn+VG2jxvj+BDPNgZHnhKrbkfU0+2yxlCENhZUjRa1IJ1iEWEBuZhqBSvNfHHJTLXipBDbd
	jLODYWPlQ6ErXaBlE+vHs52VESnWNlGSPWSwy+C5k1MpPjI2B94GGmKHldEod9F99T5XY54rmO4
	JgzYdBbdjQoUY6d88Kt0TItQCDfq5Se5OYXivdnzWZ5w8z12aB92u0okxWwtTwHf8KWHt7GQNjS
	cEj+PINw9/801DPlDifYfxrB6k5s016laZpZVKYtO6cw2cvQ==
X-Received: by 2002:a05:6512:31ca:b0:5ad:484e:f6c6 with SMTP id 2adb3069b0e04-5ae3e5055abmr822453e87.18.1782223278776;
        Tue, 23 Jun 2026 07:01:18 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6958216fsm832663e87.70.2026.06.23.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:01:18 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 1/1] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Tue, 23 Jun 2026 17:01:13 +0300
Message-ID: <20260623140113.12574-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623140113.12574-1-shofiqtest@gmail.com>
References: <20260623140113.12574-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX86150 (Maxim/Analog Devices) integrates two PPG optical channels
(Red/IR LED) and one ECG biopotential channel in a single I2C device.
Data is captured via a 32-entry hardware FIFO with a configurable
almost-full interrupt.

The driver exposes three IIO channels:
  - in_intensity_red_raw   (PPG Red, 19-bit unsigned)
  - in_intensity_ir_raw    (PPG IR, 19-bit unsigned)
  - in_voltage0_raw        (ECG, 18-bit signed)

A hardware trigger is registered when an interrupt GPIO is provided in
the device tree, enabling the IIO triggered buffer path for continuous
low-overhead capture.

FIFO reads use regmap_noinc_read() to burst-read 9 bytes (3 slots x
3 bytes) from the streaming FIFO_DATA register in a single I2C
transaction.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 .../bindings/iio/health/maxim,max86150.yaml   |  67 +++
 drivers/iio/health/Kconfig                    |  23 +
 drivers/iio/health/Makefile                   |   1 +
 drivers/iio/health/max86150.c                 | 512 ++++++++++++++++++
 4 files changed, 603 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
 create mode 100755 drivers/iio/health/max86150.c

diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
new file mode 100755
index 000000000000..1bf10fd1a3d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/health/maxim,max86150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX86150 ECG and PPG Biosensor
+
+maintainers:
+  - Md Shofiqul Islam <shofiqtest@gmail.com>
+
+description: |
+  The MAX86150 is an integrated biosensor SoC that combines:
+    - Two PPG (photoplethysmography) channels: Red LED and IR LED,
+      for heart rate and blood-oxygen saturation (SpO2) measurement.
+    - One ECG (electrocardiogram) channel for biopotential recording.
+
+  The device communicates over I2C at up to 400 kHz and raises an
+  active-low interrupt when the 32-entry hardware FIFO reaches its
+  configurable almost-full threshold.
+
+  Datasheet:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/MAX86150.pdf
+
+properties:
+  compatible:
+    const: maxim,max86150
+
+  reg:
+    maxItems: 1
+    description: I2C device address, always 0x5E.
+
+  interrupts:
+    maxItems: 1
+    description: |
+      Active-low interrupt line.  Asserted when the FIFO almost-full
+      threshold is reached or when a new PPG sample is ready.
+
+  vdd-supply:
+    description: Digital core supply, 1.71 V to 1.89 V.
+
+  leds-supply:
+    description: LED anode supply, 3.0 V to 5.5 V.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        biosensor@5e {
+            compatible = "maxim,max86150";
+            reg = <0x5e>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&vdd_1v8>;
+            leds-supply = <&vdd_3v3>;
+        };
+    };
diff --git a/drivers/iio/health/Kconfig b/drivers/iio/health/Kconfig
index a89f3abf11f4..6496cf55290c 100644
--- a/drivers/iio/health/Kconfig
+++ b/drivers/iio/health/Kconfig
@@ -13,6 +13,7 @@ config AFE4403
 	depends on SPI_MASTER
 	select REGMAP_SPI
 	select IIO_BUFFER
+	select IIO_TRIGGER
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes to choose the Texas Instruments AFE4403
@@ -26,6 +27,7 @@ config AFE4404
 	depends on I2C
 	select REGMAP_I2C
 	select IIO_BUFFER
+	select IIO_TRIGGER
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes to choose the Texas Instruments AFE4404
@@ -39,6 +41,7 @@ config MAX30100
 	depends on I2C
 	select REGMAP_I2C
 	select IIO_BUFFER
+	select IIO_TRIGGER
 	select IIO_KFIFO_BUF
 	help
 	  Say Y here to build I2C interface support for the Maxim
@@ -52,6 +55,7 @@ config MAX30102
 	depends on I2C
 	select REGMAP_I2C
 	select IIO_BUFFER
+	select IIO_TRIGGER
 	select IIO_KFIFO_BUF
 	help
 	  Say Y here to build I2C interface support for the Maxim
@@ -62,4 +66,23 @@ config MAX30102
 
 endmenu
 
+
+config MAX86150
+	tristate "MAX86150 ECG and PPG biosensor"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_I2C
+	help
+	  Say Y here to enable support for the Maxim MAX86150 combined
+	  ECG and photoplethysmography (PPG) biosensor.
+
+	  The driver exposes three IIO channels: two PPG optical channels
+	  (Red and IR LED) for heart rate and SpO2 monitoring, and one
+	  ECG channel for biopotential recording.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called max86150.
+
 endmenu
diff --git a/drivers/iio/health/Makefile b/drivers/iio/health/Makefile
index 910817112258..04fc73c58444 100644
--- a/drivers/iio/health/Makefile
+++ b/drivers/iio/health/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_AFE4403)		+= afe4403.o
 obj-$(CONFIG_AFE4404)		+= afe4404.o
 obj-$(CONFIG_MAX30100)		+= max30100.o
 obj-$(CONFIG_MAX30102)		+= max30102.o
+obj-$(CONFIG_MAX86150)		+= max86150.o
diff --git a/drivers/iio/health/max86150.c b/drivers/iio/health/max86150.c
new file mode 100755
index 000000000000..3cde4af6650b
--- /dev/null
+++ b/drivers/iio/health/max86150.c
@@ -0,0 +1,512 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MAX86150 combined ECG and PPG biosensor driver
+ *
+ * Copyright (C) 2026 Md Shofiqul Islam <shofiqtest@gmail.com>
+ *
+ * The MAX86150 integrates two PPG optical channels (Red/IR LED) and one
+ * ECG biopotential channel in a single I2C device.  Data is captured
+ * through a 32-entry hardware FIFO with a configurable almost-full
+ * interrupt, making it well-suited for continuous monitoring with a
+ * low-power host.
+ *
+ * Datasheet:
+ *   https://www.analog.com/media/en/technical-documentation/data-sheets/MAX86150.pdf
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+/* Register addresses */
+#define MAX86150_REG_INT_STATUS1	0x00
+#define MAX86150_REG_INT_STATUS2	0x01
+#define MAX86150_REG_INT_ENABLE1	0x02
+#define MAX86150_REG_INT_ENABLE2	0x03
+#define MAX86150_REG_FIFO_WR_PTR	0x04
+#define MAX86150_REG_OVF_COUNTER	0x05
+#define MAX86150_REG_FIFO_RD_PTR	0x06
+#define MAX86150_REG_FIFO_DATA		0x07
+#define MAX86150_REG_FIFO_CONFIG	0x08
+#define MAX86150_REG_FIFO_DCTRL1	0x09  /* FD1[3:0]  FD2[7:4] */
+#define MAX86150_REG_FIFO_DCTRL2	0x0A  /* FD3[3:0]  FD4[7:4] */
+#define MAX86150_REG_SYS_CTRL		0x0D
+#define MAX86150_REG_PPG_CONFIG1	0x10
+#define MAX86150_REG_PPG_CONFIG2	0x11
+#define MAX86150_REG_LED1_PA		0x14  /* Red LED pulse amplitude */
+#define MAX86150_REG_LED2_PA		0x15  /* IR LED pulse amplitude  */
+#define MAX86150_REG_ECG_CONFIG1	0x3C
+#define MAX86150_REG_ECG_CONFIG3	0x3E
+#define MAX86150_REG_PART_ID		0xFF
+
+/* Field masks */
+#define MAX86150_PART_ID_VAL		0x1E
+
+/* INT_STATUS1 / INT_ENABLE1 */
+#define MAX86150_INT_A_FULL		BIT(7)  /* FIFO almost full */
+#define MAX86150_INT_PPG_RDY		BIT(6)  /* new PPG sample ready */
+
+/* SYS_CTRL */
+#define MAX86150_SYS_SHDN		BIT(1)
+#define MAX86150_SYS_RESET		BIT(0)
+
+/* FIFO_CONFIG */
+#define MAX86150_FIFO_SMP_AVE		GENMASK(7, 5)
+#define MAX86150_FIFO_ROLLOVER_EN	BIT(4)
+#define MAX86150_FIFO_A_FULL		GENMASK(3, 0)
+
+/* FIFO slot data-type codes */
+#define MAX86150_FD_NONE		0x0
+#define MAX86150_FD_LED1		0x1   /* Red PPG */
+#define MAX86150_FD_LED2		0x2   /* IR PPG  */
+#define MAX86150_FD_ECG			0x9
+#define MAX86150_FIFO_FD1		GENMASK(3, 0)
+#define MAX86150_FIFO_FD2		GENMASK(7, 4)
+#define MAX86150_FIFO_FD3		GENMASK(3, 0)
+#define MAX86150_FIFO_FD4		GENMASK(7, 4)
+
+/* PPG_CONFIG1 */
+#define MAX86150_PPG_ADC_RGE		GENMASK(7, 6)
+#define MAX86150_PPG_SR			GENMASK(5, 1)
+
+/* Geometry */
+#define MAX86150_FIFO_DEPTH		32
+#define MAX86150_BYTES_PER_SLOT		3    /* 24-bit word per slot */
+#define MAX86150_NUM_SLOTS		3    /* Red, IR, ECG */
+#define MAX86150_SAMPLE_BYTES		(MAX86150_NUM_SLOTS * MAX86150_BYTES_PER_SLOT)
+
+/* Default hardware configuration */
+#define MAX86150_LED_PA_DEFAULT		0x3F  /* ~50 mA */
+#define MAX86150_PPG_SR_100HZ		4     /* PPG_SR field value for 100 Hz */
+#define MAX86150_PPG_ADC_RGE_16384	2     /* 16384 nA full scale */
+/* Fire A_FULL when 17 slots remain (32 - 15 = 17 samples in FIFO) */
+#define MAX86150_FIFO_A_FULL_VAL	15
+
+/* Scan element indices */
+enum max86150_scan_idx {
+	MAX86150_IDX_PPG_RED = 0,
+	MAX86150_IDX_PPG_IR  = 1,
+	MAX86150_IDX_ECG     = 2,
+	MAX86150_IDX_TS,
+};
+
+/**
+ * struct max86150_data - driver private state
+ * @regmap: register map for this device
+ * @dev:    parent device (for dev_err logging)
+ * @trig:   IIO hardware trigger backed by the device interrupt line
+ * @buf:    DMA-safe capture buffer: 3 x s32 samples + s64 timestamp.
+ *          __aligned(8) satisfies iio_push_to_buffers_with_timestamp().
+ */
+struct max86150_data {
+	struct regmap		*regmap;
+	struct device		*dev;
+	struct iio_trigger	*trig;
+	s32  buf[4] __aligned(8);
+};
+
+/* IIO channel specification */
+
+static const struct iio_chan_spec max86150_channels[] = {
+	{
+		/* PPG Red LED - optical intensity, 19-bit unsigned */
+		.type               = IIO_INTENSITY,
+		.modified           = 1,
+		.channel2           = IIO_MOD_LIGHT_RED,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index         = MAX86150_IDX_PPG_RED,
+		.scan_type = {
+			.sign        = 'u',
+			.realbits    = 19,
+			.storagebits = 32,
+			.endianness  = IIO_LE,
+		},
+	},
+	{
+		/* PPG IR LED - optical intensity, 19-bit unsigned */
+		.type               = IIO_INTENSITY,
+		.modified           = 1,
+		.channel2           = IIO_MOD_LIGHT_IR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index         = MAX86150_IDX_PPG_IR,
+		.scan_type = {
+			.sign        = 'u',
+			.realbits    = 19,
+			.storagebits = 32,
+			.endianness  = IIO_LE,
+		},
+	},
+	{
+		/* ECG biopotential - voltage, 18-bit signed two's complement */
+		.type               = IIO_VOLTAGE,
+		.channel            = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index         = MAX86150_IDX_ECG,
+		.scan_type = {
+			.sign        = 's',
+			.realbits    = 18,
+			.storagebits = 32,
+			.endianness  = IIO_LE,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(MAX86150_IDX_TS),
+};
+
+/* Regmap configuration */
+
+static const struct regmap_config max86150_regmap_config = {
+	.reg_bits     = 8,
+	.val_bits     = 8,
+	.max_register = MAX86150_REG_PART_ID,
+};
+
+/* FIFO helper */
+
+/**
+ * max86150_read_one_sample - burst-read one complete 3-slot FIFO entry
+ * @data:    driver state
+ * @ppg_red: out - 19-bit PPG Red ADC value (unsigned)
+ * @ppg_ir:  out - 19-bit PPG IR ADC value (unsigned)
+ * @ecg:     out - 18-bit ECG ADC value (sign-extended to s32)
+ *
+ * Each FIFO entry is 9 bytes (3 slots x 3 bytes).  FIFO_DATA is a
+ * streaming register - the address does not auto-increment on each
+ * byte, so regmap_noinc_read() is used instead of regmap_bulk_read().
+ *
+ * Byte layout in the 24-bit FIFO word (MSB first):
+ *   PPG 19-bit unsigned: bits [18:0], top 5 bits are always zero
+ *   ECG 18-bit signed:   bits [17:0], top 6 bits are sign extension
+ */
+static int max86150_read_one_sample(struct max86150_data *data,
+				    u32 *ppg_red, u32 *ppg_ir, s32 *ecg)
+{
+	u8 buf[MAX86150_SAMPLE_BYTES];  /* 9 bytes */
+	int ret;
+
+	ret = regmap_noinc_read(data->regmap, MAX86150_REG_FIFO_DATA,
+				buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	/* Bytes [0..2]: PPG Red - 19-bit value in bits [18:0] */
+	*ppg_red = (u32)(buf[0] & 0x07) << 16 | (u32)buf[1] << 8 | buf[2];
+
+	/* Bytes [3..5]: PPG IR - same format */
+	*ppg_ir  = (u32)(buf[3] & 0x07) << 16 | (u32)buf[4] << 8 | buf[5];
+
+	/* Bytes [6..8]: ECG - 18-bit signed, sign-extend to s32 */
+	*ecg = sign_extend32((u32)(buf[6] & 0x03) << 16 |
+			     (u32)buf[7] << 8 | buf[8], 17);
+
+	return 0;
+}
+
+/* IIO read_raw */
+
+static int max86150_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max86150_data *data = iio_priv(indio_dev);
+	u32 ppg_red, ppg_ir;
+	s32 ecg;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		/*
+		 * Single-shot path: clear the FIFO so we know we are reading
+		 * a sample that arrived after this call, not stale data.
+		 */
+		ret = regmap_write(data->regmap, MAX86150_REG_FIFO_WR_PTR, 0);
+		if (ret)
+			return ret;
+		ret = regmap_write(data->regmap, MAX86150_REG_OVF_COUNTER, 0);
+		if (ret)
+			return ret;
+		ret = regmap_write(data->regmap, MAX86150_REG_FIFO_RD_PTR, 0);
+		if (ret)
+			return ret;
+
+		/* Wait for one complete sample period at 100 Hz (<= 10 ms) */
+		usleep_range(11000, 13000);
+
+		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
+		if (ret)
+			return ret;
+
+		switch (chan->scan_index) {
+		case MAX86150_IDX_PPG_RED:
+			*val = ppg_red;
+			break;
+		case MAX86150_IDX_PPG_IR:
+			*val = ppg_ir;
+			break;
+		case MAX86150_IDX_ECG:
+			*val = ecg;
+			break;
+		default:
+			return -EINVAL;
+		}
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * TODO: return the hardware scale factor based on the
+		 * configured PPG ADC range (PPG_ADC_RGE) and ECG PGA gain
+		 * (ECG_PGA_GAIN).  For PPG, scale is nA/LSB; for ECG, uV/LSB.
+		 */
+		return -EINVAL;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max86150_iio_info = {
+	.read_raw = max86150_read_raw,
+};
+
+/* Triggered buffer */
+
+/**
+ * max86150_trigger_handler - threaded IRQ handler for FIFO almost-full
+ *
+ * Called by the IIO buffer infrastructure when the hardware trigger fires.
+ * Reads INT_STATUS1 to de-assert the interrupt, then drains all available
+ * FIFO samples into the IIO push buffer.
+ */
+static irqreturn_t max86150_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func	*pf   = p;
+	struct iio_dev		*idev = pf->indio_dev;
+	struct max86150_data	*data = iio_priv(idev);
+	unsigned int status, wr_ptr, rd_ptr, available;
+	u32 ppg_red, ppg_ir;
+	s32 ecg;
+	int ret;
+
+	/*
+	 * Reading INT_STATUS1 clears the interrupt.  Do this before touching
+	 * the FIFO so the pin is de-asserted while we drain samples.
+	 */
+	ret = regmap_read(data->regmap, MAX86150_REG_INT_STATUS1, &status);
+	if (ret)
+		goto done;
+
+	ret = regmap_read(data->regmap, MAX86150_REG_FIFO_WR_PTR, &wr_ptr);
+	if (ret)
+		goto done;
+	ret = regmap_read(data->regmap, MAX86150_REG_FIFO_RD_PTR, &rd_ptr);
+	if (ret)
+		goto done;
+
+	/*
+	 * Number of unread samples.  The FIFO is circular with depth 32, so
+	 * wrap with (depth - 1) as mask.
+	 */
+	available = (wr_ptr - rd_ptr) & (MAX86150_FIFO_DEPTH - 1);
+
+	while (available--) {
+		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
+		if (ret)
+			break;
+
+		data->buf[MAX86150_IDX_PPG_RED] = ppg_red;
+		data->buf[MAX86150_IDX_PPG_IR]  = ppg_ir;
+		data->buf[MAX86150_IDX_ECG]     = ecg;
+
+		iio_push_to_buffers_with_timestamp(idev, data->buf,
+						   iio_get_time_ns(idev));
+	}
+
+done:
+	iio_trigger_notify_done(idev->trig);
+	return IRQ_HANDLED;
+}
+
+/* Chip initialisation */
+
+static int max86150_chip_init(struct max86150_data *data)
+{
+	int ret;
+
+	/* Software reset; the bit self-clears within 1 ms */
+	ret = regmap_write(data->regmap, MAX86150_REG_SYS_CTRL,
+			   MAX86150_SYS_RESET);
+	if (ret)
+		return ret;
+	usleep_range(1000, 2000);
+
+	/*
+	 * FIFO: no sample averaging, rollover enabled, assert A_FULL when
+	 * 17 samples are in the FIFO (32 - 15 = 17 available to read).
+	 */
+	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_CONFIG,
+			   MAX86150_FIFO_ROLLOVER_EN |
+			   FIELD_PREP(MAX86150_FIFO_A_FULL,
+				      MAX86150_FIFO_A_FULL_VAL));
+	if (ret)
+		return ret;
+
+	/* Slot 1 = PPG Red (LED1), Slot 2 = PPG IR (LED2) */
+	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_DCTRL1,
+			   FIELD_PREP(MAX86150_FIFO_FD1, MAX86150_FD_LED1) |
+			   FIELD_PREP(MAX86150_FIFO_FD2, MAX86150_FD_LED2));
+	if (ret)
+		return ret;
+
+	/* Slot 3 = ECG, Slot 4 = disabled */
+	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_DCTRL2,
+			   FIELD_PREP(MAX86150_FIFO_FD3, MAX86150_FD_ECG) |
+			   FIELD_PREP(MAX86150_FIFO_FD4, MAX86150_FD_NONE));
+	if (ret)
+		return ret;
+
+	/* PPG: 100 Hz sample rate, 16384 nA ADC full-scale range */
+	ret = regmap_write(data->regmap, MAX86150_REG_PPG_CONFIG1,
+			   FIELD_PREP(MAX86150_PPG_ADC_RGE,
+				      MAX86150_PPG_ADC_RGE_16384) |
+			   FIELD_PREP(MAX86150_PPG_SR,
+				      MAX86150_PPG_SR_100HZ));
+	if (ret)
+		return ret;
+
+	/* LED pulse amplitudes (~50 mA) */
+	ret = regmap_write(data->regmap, MAX86150_REG_LED1_PA,
+			   MAX86150_LED_PA_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_LED2_PA,
+			   MAX86150_LED_PA_DEFAULT);
+	if (ret)
+		return ret;
+
+	/* Enable FIFO almost-full interrupt only */
+	return regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1,
+			    MAX86150_INT_A_FULL);
+}
+
+/* Probe */
+
+static int max86150_probe(struct i2c_client *client)
+{
+	struct iio_dev		*indio_dev;
+	struct max86150_data	*data;
+	unsigned int		 part_id;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data     = iio_priv(indio_dev);
+	data->dev = &client->dev;
+
+	data->regmap = devm_regmap_init_i2c(client, &max86150_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
+				     "Failed to initialise regmap\n");
+
+	ret = regmap_read(data->regmap, MAX86150_REG_PART_ID, &part_id);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Cannot read part ID\n");
+
+	if (part_id != MAX86150_PART_ID_VAL)
+		return dev_err_probe(&client->dev, -ENODEV,
+				     "Unexpected part ID 0x%02x (expected 0x%02x)\n",
+				     part_id, MAX86150_PART_ID_VAL);
+
+	ret = max86150_chip_init(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Chip initialisation failed\n");
+
+	indio_dev->name         = "max86150";
+	indio_dev->channels     = max86150_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max86150_channels);
+	indio_dev->info         = &max86150_iio_info;
+	indio_dev->modes        = INDIO_DIRECT_MODE;
+
+	/*
+	 * If the device tree provides an interrupt, set up a hardware
+	 * trigger so userspace can use the FIFO almost-full signal to
+	 * drive capture without polling.
+	 */
+	if (client->irq > 0) {
+		data->trig = devm_iio_trigger_alloc(&client->dev,
+						    "%s-dev%d",
+						    indio_dev->name,
+						    iio_device_id(indio_dev));
+		if (!data->trig)
+			return -ENOMEM;
+
+		ret = devm_request_irq(&client->dev, client->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				       "max86150", data->trig);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Cannot request IRQ %d\n",
+					     client->irq);
+
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+
+		ret = devm_iio_trigger_register(&client->dev, data->trig);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Cannot register trigger\n");
+
+		indio_dev->trig = iio_trigger_get(data->trig);
+	}
+
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      max86150_trigger_handler,
+					      NULL);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Cannot setup triggered buffer\n");
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+/* I2C driver table */
+
+static const struct i2c_device_id max86150_id[] = {
+	{ "max86150" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max86150_id);
+
+static const struct of_device_id max86150_of_match[] = {
+	{ .compatible = "maxim,max86150" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max86150_of_match);
+
+static struct i2c_driver max86150_driver = {
+	.driver = {
+		.name           = "max86150",
+		.of_match_table = max86150_of_match,
+	},
+	.probe    = max86150_probe,
+	.id_table = max86150_id,
+};
+module_i2c_driver(max86150_driver);
+
+MODULE_AUTHOR("Md Shofiqul Islam <shofiqtest@gmail.com>");
+MODULE_DESCRIPTION("MAX86150 ECG and PPG biosensor driver");
+MODULE_LICENSE("GPL");
-- 
2.51.1

