Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F583905E3
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236775; cv=none; b=itQ+xjC1VTGvqRKFDUSafqMnbV2kf5W/Vb7eUBt/0vfqTKZdUVxVkYm60+0COs9e+YLAWSVmn3aaRpfBu9/0n9ifAD7wv3YFs/LaQJ/Neg0tZBLrE2rGLFypT++hn1bkDahYrHa4o0iGtrPqKfmLw7HML6EZZnJn9OFg1dIkd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236775; c=relaxed/simple;
	bh=3YNADFqsPWolVd5jf5VTLmqLHcYbhyfWziGwpw7E/+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=to5PVxFHmjjLoBAlC2R6ODqqHi2wAzbLlbDvoscy/lMwTUQmWog1+F4YFCD1IdNcQ+Uhj7gSnt0zADBppouJ5rKdlkpSoOJiWCa4bWNQdDiHvmtoM5FdUWyCr7pP0ERrG2u6EqwhN9MyrHMndu8X3IA/wRspK9EkpADQGjZ5O6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp5ZW2Tu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp5ZW2Tu"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-396775c26e0so605661fa.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782236769; x=1782841569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jf4DMQLU/tGi5HNTNrPRVqVt92/yi+jSK8UBFEqTq3Q=;
        b=hp5ZW2TuQ07w8lEICyR7hxv3ehWFv+QV3bimTRTBfK339NlOvNNQt1OTRyN36afX6I
         mi19OWYnPLQ2dQBuvPnLHYIwjLfvFPwrUExBFQtIjffSHXaBz10YhT6iYn0+Rh/wzZgX
         xFjt9xn9VAkxuoJ+/LwQnKnZx6bAYL2VkQL0MZtMs1AB+Ma1W4+6pYXUJsCMm6NodVWV
         YhteWy4SO4XBxxmRaBypdIUJzr4HKA95IsBTg2CYHOZ6SDWeRelTL2m03GWfcLuZjGxk
         EltYtFeFAKV4QQPhcp+lNZEtfNHhGjZgfSLsJvtavFC2oza6FaRhuLTdvDbNXHDSzaip
         IVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782236769; x=1782841569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jf4DMQLU/tGi5HNTNrPRVqVt92/yi+jSK8UBFEqTq3Q=;
        b=HG7nlMxsdG0KiZv+9AWZ0SK4gE1PM+YJNSRw79VzusnaG/pR517pWnGt8LyZmN1MGe
         PNFvmCL/1KlmRUYyxj8WiCoOyF3L9iqt+fTzrhHtAaB1qMpA9gkP/uqmFiMrFALF2kE7
         X9rY1y8BGkHHY7zDRFmwmiaOLhUhyGACu7XwZ0aF3qi6lZHKG3OZGGpsac1b8QAmgNKW
         KzgULzjfDgy9rEjXjDetT2BZPn5gx1jTpijSV0gEqTwr5YDnEr8sW3vwhEZBNPRLgWqy
         +05jSOzHd264sjyhsZkuOJ0SECKHKmedYtOIyBg5weTQ5JKQ2mU44zzICa0n1drd+u1w
         Nvcw==
X-Gm-Message-State: AOJu0Yyg9m6Zdd147uMqtkcwvtwqyUeGlbRx9XhiT+qOiC9BzL2Nr2GN
	Wi/6eG1lzI8hT7SUsJeor6Ef9SquGmlWjOeX4as0yIDeuX9/03EAXDnxH02N2beu+qWU+w==
X-Gm-Gg: AfdE7ckBwNaToNiVrJd8BkR5cMygKVefT23D6behs+GvZH4NFbMXGltGg1thngTScQh
	6FX60Dhr9e1XiaL/jHxBa7PWbcvevjDQLjvKajuRfKzttZHWr3lrpSfc/+0SVZ0GY6Hv5g297i2
	z44udtmtPv2Yv6mlGJ65k5ydYlog1HC3xY/IXlmfvlYp2JGKY7OG4RURgpwwK/pEudjS9fqdWGS
	q8+QGhDnCY9Kubcq0kM6o2QFpHSZmuxq6iexVwZcZ8GvU9reCrZfD5S/PXh1DivIPdmOb9of5ik
	h+T6biJzPxraEaQ6HQLpZp8Zl+kNZW6rd3w2Bg8UJl0n1Sco6C6npyOqnf8wAkskV+HrlC0LN5/
	EnFFy8ek8oK/v3LVlc2z5j5hr2zKh4OTe27gQ1TP9fGsG8F7QYUhWhInu+yn6njlHwJi0PXmyfg
	729BTB2va+55JSsCx6brICRo9sARiuBjJiEPybH+3sXLaTm1S9wHWFkq3F
X-Received: by 2002:a05:651c:154d:b0:399:83a4:4f22 with SMTP id 38308e7fff4ca-39a251b92demr10659811fa.12.1782236768394;
        Tue, 23 Jun 2026 10:46:08 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999afc7005sm27198651fa.13.2026.06.23.10.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:46:07 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v4 2/3] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Tue, 23 Jun 2026 20:45:59 +0300
Message-ID: <20260623174600.17100-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623174600.17100-1-shofiqtest@gmail.com>
References: <20260623155556.13701-1-shofiqtest@gmail.com>
 <20260623174600.17100-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX86150 (Maxim/Analog Devices) combines two PPG optical channels
(Red/IR LED) and one ECG biopotential channel in a single I2C device with
a 32-entry hardware FIFO.

Driver features:
 - Three IIO channels: in_intensityred_raw, in_intensityir_raw,
   in_voltage0_raw
 - Triggered buffer path driven by the FIFO almost-full interrupt;
   set_trigger_state enables/disables the interrupt only while the buffer
   is active and FIFO is flushed before capture starts
 - validate_trigger = iio_trigger_validate_own_device prevents
   incompatible external triggers from being attached
 - IRQ trigger type taken from irq_get_trigger_type() to honour DT
   configuration; falls back to falling-edge if unspecified
 - fifo_raw burst-read buffer is heap-allocated in struct max86150_data
   and aligned to ARCH_DMA_MINALIGN to satisfy DMA mapping requirements
   of I2C host controllers that use DMA for burst reads
 - SYS_SHDN asserted at end of chip_init so LED drivers draw no current
   when capture is inactive; set_trigger_state() and read_raw() wake and
   sleep the device on demand
 - Per-sample timestamps anchored to the A_FULL IRQ capture time: the
   sample at index (A_FULL_SAMPLES - 1) maps to pf->timestamp, samples
   accumulated after the IRQ receive future timestamps, eliminating
   load-dependent jitter
 - FIFO empty vs exactly-full disambiguation: when wr_ptr == rd_ptr with
   OVF_COUNTER == 0, the A_FULL status bit distinguishes a pointer
   wrap-around (full) from a genuinely empty FIFO
 - devm_regulator_get_enable_optional() for the two optional supplies;
   -ENODEV is treated as success (supply absent, not an error)
 - Powerdown devm action disables interrupts and asserts SYS_SHDN

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/health/Kconfig    |  23 ++
 drivers/iio/health/Makefile   |   1 +
 drivers/iio/health/max86150.c | 677 ++++++++++++++++++++++++++++++++++
 3 files changed, 701 insertions(+)
 create mode 100644 drivers/iio/health/max86150.c

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
new file mode 100644
index 000000000000..0140c93bd4ec
--- /dev/null
+++ b/drivers/iio/health/max86150.c
@@ -0,0 +1,677 @@
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
+#include <linux/irq.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
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
+/* Samples present in the FIFO when the A_FULL interrupt fires */
+#define MAX86150_A_FULL_SAMPLES		(MAX86150_FIFO_DEPTH - MAX86150_FIFO_A_FULL_VAL)
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
+ * @regmap:           register map for this device
+ * @dev:              parent device (for dev_err logging)
+ * @trig:             IIO hardware trigger backed by the device interrupt line
+ * @sample_period_ns: sample period in nanoseconds (set from configured rate)
+ * @fifo_raw:         DMA-safe buffer for regmap_noinc_read() FIFO bursts;
+ *                    must be in struct (heap) not on the stack to satisfy
+ *                    DMA mapping requirements of some I2C host controllers
+ * @buf:              IIO push buffer sized for worst-case (all 3 channels
+ *                    active): 3 x s32 (12 bytes) + 4-byte pad + s64
+ *                    timestamp = 24 bytes.  __aligned(8) satisfies
+ *                    iio_push_to_buffers_with_timestamp().
+ */
+struct max86150_data {
+	struct regmap		*regmap;
+	struct device		*dev;
+	struct iio_trigger	*trig;
+	u32			 sample_period_ns;
+	u8			 fifo_raw[MAX86150_SAMPLE_BYTES] __aligned(ARCH_DMA_MINALIGN);
+	s32 buf[6] __aligned(8);
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
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_index         = MAX86150_IDX_PPG_RED,
+		.scan_type = {
+			.sign        = 'u',
+			.realbits    = 19,
+			.storagebits = 32,
+			.endianness  = IIO_CPU,
+		},
+	},
+	{
+		/* PPG IR LED - optical intensity, 19-bit unsigned */
+		.type               = IIO_INTENSITY,
+		.modified           = 1,
+		.channel2           = IIO_MOD_LIGHT_IR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_index         = MAX86150_IDX_PPG_IR,
+		.scan_type = {
+			.sign        = 'u',
+			.realbits    = 19,
+			.storagebits = 32,
+			.endianness  = IIO_CPU,
+		},
+	},
+	{
+		/* ECG biopotential - voltage, 18-bit signed two's complement */
+		.type               = IIO_VOLTAGE,
+		.channel            = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_index         = MAX86150_IDX_ECG,
+		.scan_type = {
+			.sign        = 's',
+			.realbits    = 18,
+			.storagebits = 32,
+			.endianness  = IIO_CPU,
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
+	int ret;
+
+	/*
+	 * Use data->fifo_raw (heap memory) not a local array so the buffer is
+	 * DMA-mappable for I2C host controllers that use DMA for burst reads.
+	 */
+	ret = regmap_noinc_read(data->regmap, MAX86150_REG_FIFO_DATA,
+				data->fifo_raw, sizeof(data->fifo_raw));
+	if (ret)
+		return ret;
+
+	/* Bytes [0..2]: PPG Red - 19-bit value in bits [18:0] */
+	*ppg_red = (u32)(data->fifo_raw[0] & 0x07) << 16 |
+		   (u32)data->fifo_raw[1] << 8 | data->fifo_raw[2];
+
+	/* Bytes [3..5]: PPG IR - same format */
+	*ppg_ir  = (u32)(data->fifo_raw[3] & 0x07) << 16 |
+		   (u32)data->fifo_raw[4] << 8 | data->fifo_raw[5];
+
+	/* Bytes [6..8]: ECG - 18-bit signed, sign-extend to s32 */
+	*ecg = sign_extend32((u32)(data->fifo_raw[6] & 0x03) << 16 |
+			     (u32)data->fifo_raw[7] << 8 | data->fifo_raw[8], 17);
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
+		 * Claim direct mode to prevent concurrent sysfs reads from
+		 * corrupting the FIFO pointers while a triggered buffer
+		 * capture is active.
+		 */
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		/*
+		 * Single-shot path: wake the device, flush stale FIFO data,
+		 * wait one sample period, read, then return to shutdown so
+		 * the LEDs are not drawing current when idle.
+		 */
+		ret = regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
+					 MAX86150_SYS_SHDN, 0);
+		if (!ret)
+			ret = regmap_write(data->regmap,
+					   MAX86150_REG_FIFO_WR_PTR, 0);
+		if (!ret)
+			ret = regmap_write(data->regmap,
+					   MAX86150_REG_OVF_COUNTER, 0);
+		if (!ret)
+			ret = regmap_write(data->regmap,
+					   MAX86150_REG_FIFO_RD_PTR, 0);
+		if (ret) {
+			regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
+					   MAX86150_SYS_SHDN, MAX86150_SYS_SHDN);
+			iio_device_release_direct(indio_dev);
+			return ret;
+		}
+
+		/* Wait for one complete sample period at 100 Hz (<= 10 ms) */
+		usleep_range(11000, 13000);
+
+		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
+		regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
+				   MAX86150_SYS_SHDN, MAX86150_SYS_SHDN);
+		iio_device_release_direct(indio_dev);
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
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max86150_iio_info = {
+	.read_raw         = max86150_read_raw,
+	.validate_trigger = iio_trigger_validate_own_device,
+};
+
+/* Trigger */
+
+/*
+ * Control device power and the FIFO almost-full interrupt when the IIO
+ * triggered buffer is started (state=true) or stopped (state=false).
+ *
+ * On start: wake from shutdown, flush stale FIFO data so the first
+ * samples pushed to userspace are from after buffer enable, then
+ * unmask the A_FULL interrupt.
+ *
+ * On stop: mask the interrupt, then return to shutdown so the LED
+ * drivers do not draw current while capture is inactive.
+ */
+static int max86150_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct max86150_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (!state) {
+		ret = regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1, 0);
+		regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
+				   MAX86150_SYS_SHDN, MAX86150_SYS_SHDN);
+		return ret;
+	}
+
+	ret = regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
+				 MAX86150_SYS_SHDN, 0);
+	if (!ret)
+		ret = regmap_write(data->regmap, MAX86150_REG_FIFO_WR_PTR, 0);
+	if (!ret)
+		ret = regmap_write(data->regmap, MAX86150_REG_OVF_COUNTER, 0);
+	if (!ret)
+		ret = regmap_write(data->regmap, MAX86150_REG_FIFO_RD_PTR, 0);
+	if (!ret)
+		ret = regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1,
+				   MAX86150_INT_A_FULL);
+	if (ret)
+		regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
+				   MAX86150_SYS_SHDN, MAX86150_SYS_SHDN);
+	return ret;
+}
+
+static const struct iio_trigger_ops max86150_trigger_ops = {
+	.set_trigger_state = max86150_set_trigger_state,
+};
+
+/* Triggered buffer */
+
+/**
+ * max86150_trigger_handler - threaded IRQ handler for FIFO almost-full
+ *
+ * Called by the IIO buffer infrastructure when the hardware trigger fires.
+ * Reads INT_STATUS1 to de-assert the interrupt, then drains all available
+ * FIFO samples into the IIO push buffer, packing only the channels that
+ * are currently enabled in active_scan_mask.
+ */
+static irqreturn_t max86150_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func	*pf   = p;
+	struct iio_dev		*idev = pf->indio_dev;
+	struct max86150_data	*data = iio_priv(idev);
+	unsigned int status, wr_ptr, rd_ptr, ovf;
+	u32 ppg_red, ppg_ir;
+	s32 ecg;
+	int ret, n_avail, i, j;
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
+	 * OVF_COUNTER: if non-zero the FIFO overflowed; drain all 32 slots.
+	 * When wr_ptr == rd_ptr with no overflow the FIFO could be empty OR
+	 * hold exactly MAX86150_FIFO_DEPTH entries (pointer wrap-around).
+	 * Use the A_FULL status bit to disambiguate: if the IRQ fired for
+	 * A_FULL but the computed count is zero, the FIFO wrapped to full.
+	 */
+	ret = regmap_read(data->regmap, MAX86150_REG_OVF_COUNTER, &ovf);
+	if (ret)
+		goto done;
+
+	if (ovf > 0) {
+		n_avail = MAX86150_FIFO_DEPTH;
+	} else {
+		n_avail = (wr_ptr - rd_ptr) & (MAX86150_FIFO_DEPTH - 1);
+		if (n_avail == 0 && (status & MAX86150_INT_A_FULL))
+			n_avail = MAX86150_FIFO_DEPTH;
+	}
+
+	/*
+	 * Anchor timestamps to the A_FULL IRQ capture time: sample index
+	 * (MAX86150_A_FULL_SAMPLES - 1) corresponds to pf->timestamp.
+	 * Samples that accumulated between the IRQ and handler execution
+	 * receive timestamps in the future relative to the IRQ, eliminating
+	 * load-dependent jitter in multi-sample drains.
+	 */
+	for (i = 0; i < n_avail; i++) {
+		s64 ts = pf->timestamp +
+			 (s64)(i - (MAX86150_A_FULL_SAMPLES - 1)) *
+			 data->sample_period_ns;
+
+		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
+		if (ret)
+			break;
+
+		/*
+		 * Zero the entire buffer before packing so padding bytes
+		 * between enabled channels do not leak previous sample data
+		 * to userspace when fewer than 3 channels are active.
+		 */
+		memset(data->buf, 0, sizeof(data->buf));
+
+		/*
+		 * Pack only active channels at consecutive positions [0..j-1].
+		 * iio_push_to_buffers_with_timestamp() uses scan_bytes (which
+		 * accounts for the active channel count) to place the timestamp,
+		 * so static indexing would misplace it when fewer than 3
+		 * channels are enabled.
+		 */
+		j = 0;
+		if (test_bit(MAX86150_IDX_PPG_RED, idev->active_scan_mask))
+			data->buf[j++] = ppg_red;
+		if (test_bit(MAX86150_IDX_PPG_IR, idev->active_scan_mask))
+			data->buf[j++] = ppg_ir;
+		if (test_bit(MAX86150_IDX_ECG, idev->active_scan_mask))
+			data->buf[j++] = ecg;
+
+		iio_push_to_buffers_with_timestamp(idev, data->buf, ts);
+	}
+
+done:
+	iio_trigger_notify_done(idev->trig);
+	return IRQ_HANDLED;
+}
+
+/* Chip initialisation / teardown */
+
+static void max86150_powerdown(void *arg)
+{
+	struct max86150_data *data = arg;
+
+	regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1, 0);
+	regmap_write(data->regmap, MAX86150_REG_SYS_CTRL, MAX86150_SYS_SHDN);
+}
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
+	/*
+	 * Record sample period for timestamp reconstruction in the trigger
+	 * handler.  The PPG_SR field is fixed to 100 Hz in this driver.
+	 */
+	data->sample_period_ns = 10000000; /* 100 Hz = 10 ms */
+
+	/*
+	 * Assert SYS_SHDN so the LED drivers do not draw current while
+	 * the driver is bound but no capture is active.
+	 * set_trigger_state() clears SHDN when the IIO buffer is enabled
+	 * and re-asserts it when disabled.  read_raw() wakes and sleeps
+	 * the device around each single-shot read.
+	 */
+	return regmap_write(data->regmap, MAX86150_REG_SYS_CTRL,
+			    MAX86150_SYS_SHDN);
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
+	data      = iio_priv(indio_dev);
+	data->dev = &client->dev;
+
+	/*
+	 * Enable power supplies before any I2C access.  Both supplies are
+	 * optional in the device tree; use _optional variant so probing
+	 * succeeds on boards that power the device from fixed rails with no
+	 * DT regulator node.
+	 */
+	ret = devm_regulator_get_enable_optional(&client->dev, "vdd");
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to get/enable vdd supply\n");
+
+	ret = devm_regulator_get_enable_optional(&client->dev, "leds");
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to get/enable leds supply\n");
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
+	ret = devm_add_action_or_reset(&client->dev, max86150_powerdown, data);
+	if (ret)
+		return ret;
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
+		unsigned long irq_trig;
+
+		data->trig = devm_iio_trigger_alloc(&client->dev,
+						    "%s-dev%d",
+						    indio_dev->name,
+						    iio_device_id(indio_dev));
+		if (!data->trig)
+			return -ENOMEM;
+
+		data->trig->ops = &max86150_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+
+		/*
+		 * Honour the interrupt trigger type from the device tree.
+		 * Fall back to falling-edge if the DT does not specify one.
+		 */
+		irq_trig = irq_get_trigger_type(client->irq);
+		if (!irq_trig)
+			irq_trig = IRQF_TRIGGER_FALLING;
+
+		ret = devm_request_irq(&client->dev, client->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       irq_trig,
+				       "max86150", data->trig);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Cannot request IRQ %d\n",
+					     client->irq);
+
+		ret = devm_iio_trigger_register(&client->dev, data->trig);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Cannot register trigger\n");
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

