Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5895D38C2D4
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784319108; cv=none; b=NMWE5pB0unj9AOIATCbAQnkJKwYpL1db0NEv9YUSlYAPDXRMA4+5uZAWB7PkGdKl9QX+8HuCg8598adJ5MJFl44Ia4KVtbsBcf1Nt8GH4Sj5WDBpQqGjfBGfoqPJdhKOuln0wsmAWJ8emd0RCy0gqbSaMPmgOV0A8U/Pb3UnGNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784319108; c=relaxed/simple;
	bh=bzY8FMbFb6Wlf2n1YK3u7w6allCEAwegwWtc+K6OgH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eI4Mp0J5i8iZNZOqobMOAFUtH1QKvdlYb3L8c18WENqgbgk9Ez2Vhm/uoBU2jHZvyP9eYiNnvefBBOxI2IRdqdUwvHAFdy3SgyYfwgqCLXqr+1Vl5JwoaV3JRyGMT5MMIdpdJhHPAr3+YvXT1R+T5EQGJWxoZ7VyL3vQd0/5SSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6QcSx3R; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6QcSx3R"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso7810874e87.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784319103; x=1784923903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YaAy4S5NDbwFfa0CjmghucFyX0/TubQ3Uq9q8Lp9tdM=;
        b=Y6QcSx3RdEx3q7MaquqWNFVKMc3dI2vEd3ByawIFH6TNqsmtBd71iyNCv2KHE3rJr+
         8pHgNGA906KS1LFEp+B3Z19QRgFV2KgBLsG2ZwLKWrY3Iq8R+B0F1jPfijBhCBqoqIVf
         bK7CK1+YTVHVJhxUSUrfDpSB2TtjQlhaxfiq6gRA2t0spT47Y4Xa7YrT1ba9Ht2ZxCYv
         O/LDwYrne3YS/a8P+TkZcsmZfVaVq1OSY4xTa8yQAu9A1VZWyW8HdfVJ6JAnW1Wm9zmd
         zJ4A4XKq1AS92ZFCPVNvLZcDjFhVqMO67E35eQR0yGCgNGXP0sni6jVmx8s52HjlQykS
         hm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784319103; x=1784923903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YaAy4S5NDbwFfa0CjmghucFyX0/TubQ3Uq9q8Lp9tdM=;
        b=VKayjN/ORjT52k3SJX7NiHM6HpJd6/asaOpn7bhyq0J47IHrGGK/Y9KmHHdk9H7C9K
         qn846zHBvYMo6i253yoHFiL0wiiZ18hJvMZEKKkF88tCafepBqUzHz/H4lVFsthlnsvs
         V54LD6VA8YKSdF1QrvHeJ+8Rk+I7Wru5jJ8vixXhoDdtwXJ3XR51TZFoFUaNxbyfKTCm
         +m0XZwkn9UV7MlSO638bNutBs9kbd7VQqQ8G+Sk0frN3llro6xu3d+GQeK2GemyevYNe
         GMRjlQ5ECZfHQCqBOS8lhzGSxX8xb/dgbQsdyTdzzvDBWtrWCY3CGb3rGHuFG0xmmBel
         ewNA==
X-Gm-Message-State: AOJu0Yy9Fb4raGHIO7saSIVVix0F9w5mSKMjcDRuJQ7YR+QN1yfPL4Pv
	7cYT/tAaU+JDD18hr0XnhrFB/iFcFeFqNHhf86fu2zH3zgQSIzDifxKHywU9H6iecdpauw==
X-Gm-Gg: AfdE7ck+xh7etSLF1I0J9qXkBJh2SnR1rI3+Gz12sw4qK401/jihIQ9yUtrfDyhuyjl
	vOuiqHt6nv5DvouYk/vMVWIPGwHdQBeWgf9mJGDzGBS3RbAh7JqYC5QmV5ia/5LvRl9oTWXZ5qo
	6eR3bfdtzZsGcEMB6bzgjd78HXLnotMkmesTvJAm7jHkZilzB1rj2AZ6W91mFq1yF2SbjXHRoYO
	xKHU3TWGoUOThP59IrlwqmRwU2qG+Fk6H5qgai6PYnwT5vU2CjDohrTb5ltCCcHWcZAIKdFkHb2
	UktUQ9fdhsPh88gdrjxbUurxQwasThrLDmdGnQni61owwRdPSgSQ+4IQq5BVq3Q21p5yeYwvHAZ
	Pvftqo/3tRMnfIviorGKtVcM6P7eZY4bcT1KI0H0ZcizuZKic3/+TJJhzWoOsIWU8wP+WnxJg6+
	93AkyZRgH8vovdkMGd15pjZTq5dEcvdEiF2HMl7+gg7A==
X-Received: by 2002:a05:6512:a86:b0:5ae:b13d:e715 with SMTP id 2adb3069b0e04-5b28f998ceemr987217e87.31.1784319103076;
        Fri, 17 Jul 2026 13:11:43 -0700 (PDT)
Received: from Shofiq.home (87-92-108-63.bb.dnainternet.fi. [87.92.108.63])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291da7bafsm571257e87.33.2026.07.17.13.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:11:42 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	jic23@kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@intel.com,
	u.kleine-koenig@baylibre.com,
	joshua.crofts1@gmail.com,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	linux@analog.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/2] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Fri, 17 Jul 2026 23:11:37 +0300
Message-ID: <20260717201138.1078019-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260717201138.1078019-1-shofiqtest@gmail.com>
References: <20260717201138.1078019-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new IIO driver for the Analog Devices MAX86150 integrated
biosensor, which combines two PPG optical channels (Red/IR LED) and
one ECG biopotential channel in a single I2C device.

The device has a 32-entry hardware FIFO with a configurable almost-full
interrupt. The driver uses the standard IIO hardware-trigger and
triggered-buffer framework: a hard-irq handler reads and clears
INT_STATUS1 to de-assert the line before calling iio_trigger_poll(),
and the threaded trigger handler drains the FIFO and pushes samples,
with timestamps back-calculated from the interrupt arrival time by one
sample_period_ns per step. Relying on the trigger core's own
attach/detach synchronization avoids the need for an explicit
iio_buffer_enabled() guard or synchronize_irq() in the interrupt path.

Key implementation details:
- Part ID register (0xFF) verified against 0x1E on probe; mismatched
  devices are rejected with -ENODEV so the driver cannot bind to the
  wrong hardware
- Stale A_FULL and PPG_RDY status bits are cleared before arming the
  interrupt or polling for a sample, so a previously-latched flag
  cannot fire the handler against garbage state
- 24-bit FIFO words decoded directly from the raw byte buffer
- regmap_set_bits() / regmap_clear_bits() for single-direction writes
- Device remains in shutdown between captures to suppress LED current
- vdd, avdd, vref and leds regulators required per the datasheet power
  tree
- iio_get_time_ns() used for timestamps so they respect the IIO
  device's configured clock source
- A_FULL status bit used to detect FIFO exactly full (wr_ptr == rd_ptr
  with OVF_COUNTER == 0) so valid samples are not silently dropped
- No IRQ trigger-type override: the device has no register to
  reconfigure interrupt polarity or type, so IRQF_ONESHOT with
  whatever type firmware provides is sufficient

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 MAINTAINERS                   |   1 +
 drivers/iio/health/Kconfig    |  13 +
 drivers/iio/health/Makefile   |   1 +
 drivers/iio/health/max86150.c | 691 ++++++++++++++++++++++++++++++++++
 4 files changed, 706 insertions(+)
 create mode 100644 drivers/iio/health/max86150.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 189385966de82..5e266c03bda6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15710,6 +15710,7 @@ M:	Md Shofiqul Islam <shofiqtest@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
+F:	drivers/iio/health/max86150.c
 
 MAX9286 QUAD GMSL DESERIALIZER DRIVER
 M:	Jacopo Mondi <jacopo+renesas@jmondi.org>
diff --git a/drivers/iio/health/Kconfig b/drivers/iio/health/Kconfig
index a89f3abf11f4a..7438cdfe4238f 100644
--- a/drivers/iio/health/Kconfig
+++ b/drivers/iio/health/Kconfig
@@ -62,4 +62,17 @@ config MAX30102
 
 endmenu
 
+config MAX86150
+	tristate "MAX86150 ECG and PPG biosensor"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_I2C
+	help
+	  Say Y here to enable support for the Maxim MAX86150 combined
+	  ECG and photoplethysmography (PPG) biosensor.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called max86150.
+
 endmenu
diff --git a/drivers/iio/health/Makefile b/drivers/iio/health/Makefile
index 9108171122588..04fc73c584449 100644
--- a/drivers/iio/health/Makefile
+++ b/drivers/iio/health/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_AFE4403)		+= afe4403.o
 obj-$(CONFIG_AFE4404)		+= afe4404.o
 obj-$(CONFIG_MAX30100)		+= max30100.o
 obj-$(CONFIG_MAX30102)		+= max30102.o
+obj-$(CONFIG_MAX86150)		+= max86150.o
diff --git a/drivers/iio/health/max86150.c b/drivers/iio/health/max86150.c
new file mode 100644
index 0000000000000..47d96570a95fc
--- /dev/null
+++ b/drivers/iio/health/max86150.c
@@ -0,0 +1,691 @@
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
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define MAX86150_REG_INT_STATUS1	0x00
+#define MAX86150_REG_INT_STATUS2	0x01
+#define MAX86150_REG_INT_ENABLE1	0x02
+#define MAX86150_REG_INT_ENABLE2	0x03
+#define MAX86150_REG_FIFO_WR_PTR	0x04
+#define MAX86150_REG_OVF_COUNTER	0x05
+#define MAX86150_REG_FIFO_RD_PTR	0x06
+#define MAX86150_REG_FIFO_DATA		0x07
+#define MAX86150_REG_FIFO_CONFIG	0x08
+#define MAX86150_REG_FIFO_DCTRL1	0x09
+#define MAX86150_REG_FIFO_DCTRL2	0x0A
+#define MAX86150_REG_SYS_CTRL		0x0D
+#define MAX86150_REG_PPG_CONFIG1	0x10
+#define MAX86150_REG_PPG_CONFIG2	0x11
+#define MAX86150_REG_LED1_PA		0x14
+#define MAX86150_REG_LED2_PA		0x15
+#define MAX86150_REG_ECG_CONFIG1	0x3C
+#define MAX86150_REG_ECG_CONFIG3	0x3E
+#define MAX86150_REG_PART_ID		0xFF
+
+#define MAX86150_PART_ID_VAL		0x1E
+
+#define MAX86150_INT_A_FULL		BIT(7)
+#define MAX86150_INT_PPG_RDY		BIT(6)
+
+#define MAX86150_SYS_SHDN		BIT(1)
+#define MAX86150_SYS_RESET		BIT(0)
+
+#define MAX86150_FIFO_SMP_AVE		GENMASK(7, 5)
+#define MAX86150_FIFO_ROLLOVER_EN	BIT(4)
+#define MAX86150_FIFO_A_FULL		GENMASK(3, 0)
+
+#define MAX86150_FD_NONE		0x0
+#define MAX86150_FD_LED1		0x1
+#define MAX86150_FD_LED2		0x2
+#define MAX86150_FD_ECG			0x9
+#define MAX86150_FIFO_FD1		GENMASK(3, 0)
+#define MAX86150_FIFO_FD2		GENMASK(7, 4)
+#define MAX86150_FIFO_FD3		GENMASK(3, 0)
+#define MAX86150_FIFO_FD4		GENMASK(7, 4)
+
+#define MAX86150_PPG_ADC_RGE		GENMASK(7, 6)
+#define MAX86150_PPG_SR			GENMASK(5, 1)
+
+/* PPG ADC full-scale range (ADC_RGE field of PPG_CONFIG1) */
+#define MAX86150_PPG_ADC_RGE_4096	0	/* 4096 nA */
+#define MAX86150_PPG_ADC_RGE_8192	1	/* 8192 nA */
+#define MAX86150_PPG_ADC_RGE_16384	2	/* 16384 nA */
+#define MAX86150_PPG_ADC_RGE_32768	3	/* 32768 nA */
+
+/* PPG sample rate (SR field of PPG_CONFIG1) - single-pulse variants */
+#define MAX86150_PPG_SR_SP_10HZ		0
+#define MAX86150_PPG_SR_SP_20HZ		1
+#define MAX86150_PPG_SR_SP_50HZ		2
+#define MAX86150_PPG_SR_SP_84HZ		3
+#define MAX86150_PPG_SR_SP_100HZ	4
+#define MAX86150_PPG_SR_SP_200HZ	5
+#define MAX86150_PPG_SR_SP_400HZ	6
+#define MAX86150_PPG_SR_SP_800HZ	7
+#define MAX86150_PPG_SR_SP_1000HZ	8
+#define MAX86150_PPG_SR_SP_1600HZ	9
+#define MAX86150_PPG_SR_SP_3200HZ	10
+/* Double-pulse variants (two LED pulses averaged per sample) */
+#define MAX86150_PPG_SR_DP_10HZ		11
+#define MAX86150_PPG_SR_DP_20HZ		12
+#define MAX86150_PPG_SR_DP_50HZ		13
+#define MAX86150_PPG_SR_DP_84HZ		14
+#define MAX86150_PPG_SR_DP_100HZ	15
+#define MAX86150_PPG_SR_DP_200HZ	16
+#define MAX86150_PPG_SR_DP_400HZ	17
+#define MAX86150_PPG_SR_DP_800HZ	18
+#define MAX86150_PPG_SR_DP_1000HZ	19
+#define MAX86150_PPG_SR_DP_1600HZ	20
+#define MAX86150_PPG_SR_DP_3200HZ	21
+
+/* LED pulse amplitude: 0x00 = 0 mA, step ~0.8 mA, 0x3F ~= 50 mA, 0xFF ~= 200 mA */
+
+#define MAX86150_FIFO_DEPTH		32
+#define MAX86150_BYTES_PER_SLOT		3
+#define MAX86150_NUM_SLOTS		3
+#define MAX86150_SAMPLE_BYTES		(MAX86150_NUM_SLOTS * MAX86150_BYTES_PER_SLOT)
+
+/* Samples available in the FIFO when the A_FULL interrupt fires */
+#define MAX86150_FIFO_A_FULL_SAMPLES	17
+
+#define MAX86150_LED_PA_DEFAULT		0x3F
+
+enum max86150_scan_idx {
+	MAX86150_IDX_PPG_RED,
+	MAX86150_IDX_PPG_IR,
+	MAX86150_IDX_ECG,
+	MAX86150_IDX_TS,
+};
+
+/**
+ * struct max86150_data - driver private state
+ * @regmap:           register map for this device
+ * @trig:             IIO hardware trigger backed by the device interrupt line
+ * @sample_period_ns: sample period in nanoseconds (set from configured rate)
+ * @fifo_raw:         scratch buffer for regmap_noinc_read() FIFO bursts; kept
+ *                    in struct (heap) rather than on the stack, since stack
+ *                    memory isn't guaranteed DMA-safe (e.g. CONFIG_VMAP_STACK)
+ *                    and some I2C host controllers DMA the read buffer
+ * @scan:             IIO push buffer; channels[] packed per active_scan_mask,
+ *                    with a trailing aligned_s64 slot for the timestamp
+ */
+struct max86150_data {
+	struct regmap		*regmap;
+	struct iio_trigger	*trig;
+	u32			 sample_period_ns;
+	u8			 fifo_raw[MAX86150_SAMPLE_BYTES];
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(s32, scan, MAX86150_NUM_SLOTS);
+};
+
+static const struct iio_chan_spec max86150_channels[] = {
+	{
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
+static const struct regmap_config max86150_regmap_config = {
+	.reg_bits     = 8,
+	.val_bits     = 8,
+	.max_register = MAX86150_REG_PART_ID,
+};
+
+static int max86150_read_one_sample(struct max86150_data *data,
+				    u32 *ppg_red, u32 *ppg_ir, s32 *ecg)
+{
+	int ret;
+
+	ret = regmap_noinc_read(data->regmap, MAX86150_REG_FIFO_DATA,
+				data->fifo_raw, MAX86150_SAMPLE_BYTES);
+	if (ret)
+		return ret;
+
+	*ppg_red = (data->fifo_raw[0] & 0x07) << 16 |
+		    data->fifo_raw[1] << 8 | data->fifo_raw[2];
+	*ppg_ir  = (data->fifo_raw[3] & 0x07) << 16 |
+		    data->fifo_raw[4] << 8 | data->fifo_raw[5];
+	*ecg = sign_extend32((data->fifo_raw[6] & 0x03) << 16 |
+			      data->fifo_raw[7] << 8 | data->fifo_raw[8], 17);
+	return 0;
+}
+
+/*
+ * Take the device out of shutdown, reset the FIFO pointers, wait for the
+ * first PPG sample, and read it back.  Always returns the device to
+ * shutdown before returning, whether or not the read succeeded.
+ */
+static int max86150_do_read_raw(struct max86150_data *data,
+				u32 *ppg_red, u32 *ppg_ir, s32 *ecg)
+{
+	unsigned int ppg_rdy_status;
+	int ret;
+
+	ret = regmap_clear_bits(data->regmap, MAX86150_REG_SYS_CTRL,
+				MAX86150_SYS_SHDN);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_WR_PTR, 0);
+	if (ret)
+		goto out_shdn;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_OVF_COUNTER, 0);
+	if (ret)
+		goto out_shdn;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_RD_PTR, 0);
+	if (ret)
+		goto out_shdn;
+
+	/*
+	 * Clear stale PPG_RDY from a previous session; reading
+	 * INT_STATUS1 de-asserts any pending flags so the poll
+	 * below waits for a genuinely new sample.
+	 */
+	ret = regmap_read(data->regmap, MAX86150_REG_INT_STATUS1,
+			  &ppg_rdy_status);
+	if (ret)
+		goto out_shdn;
+
+	/*
+	 * Poll PPG_RDY rather than sleeping a fixed interval — the
+	 * internal oscillator may start slower than nominal.  25 ms
+	 * covers more than two 100 Hz sample periods.
+	 */
+	ret = regmap_read_poll_timeout(data->regmap,
+				       MAX86150_REG_INT_STATUS1,
+				       ppg_rdy_status,
+				       ppg_rdy_status & MAX86150_INT_PPG_RDY,
+				       1000, 25000);
+	if (ret)
+		goto out_shdn;
+
+	ret = max86150_read_one_sample(data, ppg_red, ppg_ir, ecg);
+
+out_shdn:
+	regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL, MAX86150_SYS_SHDN);
+	return ret;
+}
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
+	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		ret = max86150_do_read_raw(data, &ppg_red, &ppg_ir, &ecg);
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
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max86150_iio_info = {
+	.read_raw         = max86150_read_raw,
+	.validate_trigger = iio_validate_own_trigger,
+};
+
+static int max86150_trigger_disable(struct max86150_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1, 0);
+	if (ret)
+		return ret;
+	return regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL,
+			       MAX86150_SYS_SHDN);
+}
+
+static int max86150_trigger_enable(struct max86150_data *data)
+{
+	unsigned int dummy;
+	int ret;
+
+	ret = regmap_clear_bits(data->regmap, MAX86150_REG_SYS_CTRL,
+				MAX86150_SYS_SHDN);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_WR_PTR, 0);
+	if (ret)
+		goto err_shdn;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_OVF_COUNTER, 0);
+	if (ret)
+		goto err_shdn;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_RD_PTR, 0);
+	if (ret)
+		goto err_shdn;
+
+	/*
+	 * Clear a stale A_FULL latched from before this trigger was enabled;
+	 * otherwise arming INT_ENABLE1 below fires the handler immediately
+	 * against a FIFO state that was never actually seen as full.
+	 */
+	ret = regmap_read(data->regmap, MAX86150_REG_INT_STATUS1, &dummy);
+	if (ret)
+		goto err_shdn;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1,
+			   MAX86150_INT_A_FULL);
+	if (ret)
+		goto err_shdn;
+	return 0;
+
+err_shdn:
+	regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL, MAX86150_SYS_SHDN);
+	return ret;
+}
+
+static int max86150_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct max86150_data *data = iio_priv(indio_dev);
+
+	if (state)
+		return max86150_trigger_enable(data);
+	return max86150_trigger_disable(data);
+}
+
+static const struct iio_trigger_ops max86150_trigger_ops = {
+	.set_trigger_state = max86150_set_trigger_state,
+	.validate_device   = iio_trigger_validate_own_device,
+};
+
+/*
+ * Threaded IRQ handler: reads and clears INT_STATUS1 to de-assert the
+ * hardware interrupt line BEFORE iio_trigger_poll() re-enables it.  This
+ * prevents an IRQ storm on level-triggered lines where the line would
+ * remain asserted until max86150_trigger_handler() ran later in its own
+ * kthread — after IRQF_ONESHOT had already unmasked the IRQ.
+ */
+static irqreturn_t max86150_irq_handler(int irq, void *private)
+{
+	struct iio_trigger *trig = private;
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct max86150_data *data = iio_priv(indio_dev);
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(data->regmap, MAX86150_REG_INT_STATUS1, &status);
+	if (ret || !(status & MAX86150_INT_A_FULL))
+		return IRQ_NONE;
+
+	iio_trigger_poll(trig);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t max86150_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *idev = pf->indio_dev;
+	struct max86150_data *data = iio_priv(idev);
+	unsigned int wr_ptr, rd_ptr, ovf, n_avail;
+	u32 ppg_red, ppg_ir;
+	s32 ecg;
+	s64 t_drain = 0;
+	int ret;
+
+	/*
+	 * INT_STATUS1 was already read (and the interrupt de-asserted) by
+	 * max86150_irq_handler().  Read only the FIFO pointers here.
+	 */
+	ret = regmap_read(data->regmap, MAX86150_REG_FIFO_WR_PTR, &wr_ptr);
+	if (ret)
+		goto done;
+	ret = regmap_read(data->regmap, MAX86150_REG_FIFO_RD_PTR, &rd_ptr);
+	if (ret)
+		goto done;
+	ret = regmap_read(data->regmap, MAX86150_REG_OVF_COUNTER, &ovf);
+	if (ret)
+		goto done;
+
+	if (ovf > 0) {
+		n_avail = MAX86150_FIFO_DEPTH;
+		t_drain = iio_get_time_ns(idev);
+	} else {
+		n_avail = (wr_ptr - rd_ptr) & (MAX86150_FIFO_DEPTH - 1);
+		/*
+		 * wr_ptr == rd_ptr with no overflow means either empty or
+		 * exactly 32 slots filled (pointer wrapped).  Since this
+		 * handler is only called when A_FULL fired, the FIFO must
+		 * be full — treat as 32 available.
+		 */
+		if (n_avail == 0)
+			n_avail = MAX86150_FIFO_DEPTH;
+	}
+
+	for (unsigned int i = 0; i < n_avail; i++) {
+		unsigned int j = 0;
+		s64 ts;
+
+		if (ovf > 0)
+			ts = t_drain -
+			     (s64)(n_avail - 1 - i) * data->sample_period_ns;
+		else
+			ts = pf->timestamp +
+			     ((s64)i - (MAX86150_FIFO_A_FULL_SAMPLES - 1)) *
+			     data->sample_period_ns;
+
+		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
+		if (ret)
+			break;
+
+		memset(data->scan, 0, sizeof(data->scan));
+
+		if (test_bit(MAX86150_IDX_PPG_RED, idev->active_scan_mask))
+			data->scan[j++] = ppg_red;
+		if (test_bit(MAX86150_IDX_PPG_IR, idev->active_scan_mask))
+			data->scan[j++] = ppg_ir;
+		if (test_bit(MAX86150_IDX_ECG, idev->active_scan_mask))
+			data->scan[j++] = ecg;
+
+		iio_push_to_buffers_with_timestamp(idev, data->scan, ts);
+	}
+
+done:
+	iio_trigger_notify_done(idev->trig);
+	return IRQ_HANDLED;
+}
+
+static void max86150_powerdown(void *arg)
+{
+	struct max86150_data *data = arg;
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1, 0);
+	if (ret)
+		dev_warn(dev, "Failed to disable interrupts: %d\n", ret);
+
+	ret = regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL,
+			      MAX86150_SYS_SHDN);
+	if (ret)
+		dev_warn(dev, "Failed to shut down device: %d\n", ret);
+}
+
+static int max86150_chip_init(struct max86150_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_SYS_CTRL,
+			   MAX86150_SYS_RESET);
+	if (ret)
+		return ret;
+
+	/* SYS_RESET self-clears within 1 ms (datasheet SYS_CTRL register) */
+	fsleep(10 * USEC_PER_MSEC);
+
+	/*
+	 * FIFO_A_FULL holds (FIFO depth - samples available), i.e. how many
+	 * free slots remain when the interrupt should fire.
+	 */
+	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_CONFIG,
+			   MAX86150_FIFO_ROLLOVER_EN |
+			   FIELD_PREP(MAX86150_FIFO_A_FULL,
+				      MAX86150_FIFO_DEPTH -
+				      MAX86150_FIFO_A_FULL_SAMPLES));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_DCTRL1,
+			   FIELD_PREP(MAX86150_FIFO_FD1, MAX86150_FD_LED1) |
+			   FIELD_PREP(MAX86150_FIFO_FD2, MAX86150_FD_LED2));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_DCTRL2,
+			   FIELD_PREP(MAX86150_FIFO_FD3, MAX86150_FD_ECG) |
+			   FIELD_PREP(MAX86150_FIFO_FD4, MAX86150_FD_NONE));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, MAX86150_REG_PPG_CONFIG1,
+			   FIELD_PREP(MAX86150_PPG_ADC_RGE,
+				      MAX86150_PPG_ADC_RGE_16384) |
+			   FIELD_PREP(MAX86150_PPG_SR,
+				      MAX86150_PPG_SR_SP_100HZ));
+	if (ret)
+		return ret;
+
+	data->sample_period_ns = 10000000; /* matches MAX86150_PPG_SR_SP_100HZ above */
+
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
+	return regmap_write(data->regmap, MAX86150_REG_SYS_CTRL,
+			    MAX86150_SYS_SHDN);
+}
+
+static int max86150_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct max86150_data *data;
+	unsigned int part_id;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable vdd supply\n");
+
+	ret = devm_regulator_get_enable(dev, "avdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable avdd supply\n");
+
+	ret = devm_regulator_get_enable(dev, "vref");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable vref supply\n");
+
+	ret = devm_regulator_get_enable(dev, "leds");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable leds supply\n");
+
+	data->regmap = devm_regmap_init_i2c(client, &max86150_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "Failed to init regmap\n");
+
+	ret = regmap_read(data->regmap, MAX86150_REG_PART_ID, &part_id);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot read part ID\n");
+
+	if (part_id != MAX86150_PART_ID_VAL)
+		return dev_err_probe(dev, -ENODEV,
+				     "Unexpected part ID 0x%02x (expected 0x%02x)\n",
+				     part_id, MAX86150_PART_ID_VAL);
+
+	ret = max86150_chip_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Chip initialisation failed\n");
+
+	ret = devm_add_action_or_reset(dev, max86150_powerdown, data);
+	if (ret)
+		return ret;
+
+	indio_dev->name         = "max86150";
+	indio_dev->channels     = max86150_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max86150_channels);
+	indio_dev->info         = &max86150_iio_info;
+	indio_dev->modes        = INDIO_DIRECT_MODE;
+
+	if (client->irq > 0) {
+		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						    indio_dev->name,
+						    iio_device_id(indio_dev));
+		if (!data->trig)
+			return -ENOMEM;
+
+		data->trig->ops = &max86150_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+
+		/*
+		 * The device only ever drives an active-low interrupt line;
+		 * there is no register to reconfigure its polarity or type,
+		 * so the trigger type from firmware needs no help here.
+		 */
+		ret = devm_request_threaded_irq(dev, client->irq,
+						NULL,
+						max86150_irq_handler,
+						IRQF_ONESHOT,
+						"max86150", data->trig);
+		if (ret)
+			return ret;
+
+		ret = devm_iio_trigger_register(dev, data->trig);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to register trigger\n");
+	}
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      max86150_trigger_handler,
+					      NULL);
+	if (ret)
+		return ret;
+
+	/*
+	 * Set the default trigger AFTER buffer setup succeeds.  Setting it
+	 * before would leak the iio_trigger_get() reference if buffer setup
+	 * failed: INDIO_BUFFER_TRIGGERED is not set on that path so
+	 * iio_device_release() skips iio_trigger_put().
+	 */
+	if (data->trig)
+		indio_dev->trig = iio_trigger_get(data->trig);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id max86150_id[] = {
+	{ "max86150" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max86150_id);
+
+static const struct of_device_id max86150_of_match[] = {
+	{ .compatible = "adi,max86150" },
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

