Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2C309EE9
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230166; cv=none; b=MJuwp9FSmWxcWR5rRJKJ293qIoWw6tq79GrWEjjMdqmAfp5DgXyDoV74HCzM20nETL4AcZB+/qu+UZ0wPbqmoyyXM0Sp+jTKkgDd5IUDOBRjXxkm04aE5BwKvhPJYy5ghl6mV5Jw+ZV/COH+v1Q45ai2sAfALRgr7NuW/PJVIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230166; c=relaxed/simple;
	bh=mxUdnzzsCVuNVIYemCDsAwuM5RWsbH1YgJkLBXQSk0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3t9Jst+YUFZGsrMoHEYQGyB2w/Dy+DULVg0iJX5Bnwr/QevDoIWGELqk7chBFOkgzp+4mD0vwvWK51hjJHfxuJGl0n/R/lRrkfpSdZN0d2ialYtmq19If10G0BsL7OHihYzzZhpBR+tSz48Y61wbc7o4n7esi1JZH9vzf1vcNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9mdmG2R; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9mdmG2R"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5ad5e719157so3187770e87.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782230163; x=1782834963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfGz1hE8KQci/4uLrnVwupySrmKVwzTPFAetB+8QHSQ=;
        b=p9mdmG2R2vnj8Naw7XF0vVrYT5lsH5gifs5Sq01oHXQ0DjNqCdbjyD6nG40ZHj1hQ3
         xl8ClXpSfo/5o3kVVapJF+HjUBFQLo7r//C1tC1dL3wAlQw5so9wGgqj0c7QMAsdVmXo
         zrRsN1lHRid1MgVBfKL7TTdyPQg3dxewFYvmrHbOKeyTZM974whzG1CkkMRCJdSJ8dIX
         47tsbCiKq11ck1aeEFWCArNbFIb//kf341+sGX5qn0GqF/E+31BX9dFwxcHeaH2Yet1j
         w8IEp3c7CnpUUCdGjrxqVS4dX3nmyj2O8y/GdeKb6Ht0ZFD4wwiy0DuMohmKeTpHXy1O
         DbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230163; x=1782834963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CfGz1hE8KQci/4uLrnVwupySrmKVwzTPFAetB+8QHSQ=;
        b=j3DZrQS7CnFKqBXIOetZPDJrph72TlJejTGabBAtdf62db+kOu24A061mWkY/vzn6L
         YjANVWyYmzpwhl/rQiQF/Ir66I6vqinKM8sjfEu8sXZWBu0UyIoIVb4rr2bXPAPksKP+
         HF4CMOMPTWzneaUKH97z5bBriuRsAxact603lQRBN0MGdAgjraYiCkWQaxdml9m8G656
         2MsxN+8Ya+r50i2kLcLIsqZga6PVbUWNXvDK47tXwmaP8zo/j1pnRYnrkRmKosCuH0ZD
         CkeQ3Ybakh28S5jHZE75yn43ocRo8BPRV9fIjmrXqMIGxHztkvjqflJm13Tn7yIg/xzU
         zKPg==
X-Gm-Message-State: AOJu0YxvTD/qfp+7gfVfw48hTVImASEzNnt5RF+V3Nk1agz2VvLWWBLX
	0xKzQKLpECI2KRPoMFLy1LJ8dCORUnTK25Q6fLNHF2SwkfCjMzcvyZ5lvUAF8lHrif02pw==
X-Gm-Gg: AfdE7cnBwc7byVGIcMa0+Z7vF6kYUGrvQmLWbaFN/fqyBx95nhWRS2K2CbTNBuinpFy
	fcXMMGn2EWJLDdkfT2+fY4FFL2g0/3VUFHcEgy80l7UAMSzwo3fk7zkB32YuY3NrptfiF6vT7NB
	XTfuzPKSwHnvXQqYnS0lV+Q4qcIVtf187s3wVFsT8JFAgEv34cFkj7TIg5BoXdHWX3hssbXmpJV
	5TnxjNqXBZTIh+1PPJoXN8THM6eZ0kKA4TOspFAX1KjSLIcAaOrjDi7JTjDvx463gVqgz/QPN5O
	VsLxkZwEqHOlnz7OYP406W8+139tBlfPxPZTJZRiUVPBORADkY8vpy1DbVY5oAH1O7rPvK8MDg7
	x08FoMYMw+kOEFLBSwSA8jTJFNOY0JMtRmbWfZcJwzun98mIT3vdOo+uSHuax1zOCGGws4t7+DM
	AVjc+3JKNSTNNyVPs/weU7lBDDwG7QyY9ReyCJkFNVDoXXkQ==
X-Received: by 2002:a05:6512:4607:b0:5ad:7395:292f with SMTP id 2adb3069b0e04-5ad73952a88mr1127495e87.36.1782230162415;
        Tue, 23 Jun 2026 08:56:02 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a6a2sm908946e87.46.2026.06.23.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:56:01 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 2/3] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Tue, 23 Jun 2026 18:55:55 +0300
Message-ID: <20260623155556.13701-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623155556.13701-1-shofiqtest@gmail.com>
References: <20260623140113.12574-1-shofiqtest@gmail.com>
 <20260623155556.13701-1-shofiqtest@gmail.com>
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
low-overhead capture.  The trigger enable/disable is driven by the
set_trigger_state callback to prevent the interrupt line from asserting
before the handler is ready.

FIFO reads use regmap_noinc_read() to burst-read 9 bytes (3 slots x
3 bytes) from the streaming FIFO_DATA register in a single I2C
transaction.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/health/Kconfig    |  23 ++
 drivers/iio/health/Makefile   |   1 +
 drivers/iio/health/max86150.c | 612 ++++++++++++++++++++++++++++++++++
 3 files changed, 636 insertions(+)
 create mode 100755 drivers/iio/health/max86150.c

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
index 000000000000..70c51ccb4672
--- /dev/null
+++ b/drivers/iio/health/max86150.c
@@ -0,0 +1,612 @@
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
+ * @buf:    DMA-safe capture buffer sized for worst-case (all 3 channels
+ *          active): 3 x s32 (12 bytes) + 4-byte pad + s64 timestamp = 24
+ *          bytes.  __aligned(8) satisfies iio_push_to_buffers_with_timestamp().
+ */
+struct max86150_data {
+	struct regmap		*regmap;
+	struct device		*dev;
+	struct iio_trigger	*trig;
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
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
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
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
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
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
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
+		 * Claim direct mode to prevent concurrent sysfs reads from
+		 * corrupting the FIFO pointers while a triggered buffer
+		 * capture is active.
+		 */
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		/*
+		 * Single-shot path: reset FIFO pointers so the next sample
+		 * read is one that arrived after this call.
+		 */
+		ret = regmap_write(data->regmap, MAX86150_REG_FIFO_WR_PTR, 0);
+		if (!ret)
+			ret = regmap_write(data->regmap,
+					   MAX86150_REG_OVF_COUNTER, 0);
+		if (!ret)
+			ret = regmap_write(data->regmap,
+					   MAX86150_REG_FIFO_RD_PTR, 0);
+		if (ret) {
+			iio_device_release_direct(indio_dev);
+			return ret;
+		}
+
+		/* Wait for one complete sample period at 100 Hz (<= 10 ms) */
+		usleep_range(11000, 13000);
+
+		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
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
+/* Trigger */
+
+/*
+ * Enable or disable the FIFO almost-full interrupt when the IIO triggered
+ * buffer is started or stopped.  Keeping the interrupt masked until capture
+ * is active prevents a pre-existing FIFO fill from asserting the line before
+ * the handler is ready to clear it.
+ */
+static int max86150_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct max86150_data *data = iio_priv(indio_dev);
+	unsigned int mask = state ? MAX86150_INT_A_FULL : 0;
+
+	return regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1, mask);
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
+	unsigned int status, wr_ptr, rd_ptr, ovf, available;
+	u32 ppg_red, ppg_ir;
+	s32 ecg;
+	int ret, j;
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
+	 * Read OVF_COUNTER to distinguish a full FIFO from an empty one:
+	 * both produce wr_ptr == rd_ptr after the pointers wrap around.
+	 * If OVF_COUNTER is non-zero the FIFO has saturated; treat all 32
+	 * slots as available so we drain the entire FIFO and clear the
+	 * interrupt condition.
+	 */
+	ret = regmap_read(data->regmap, MAX86150_REG_OVF_COUNTER, &ovf);
+	if (ret)
+		goto done;
+
+	if (ovf > 0)
+		available = MAX86150_FIFO_DEPTH;
+	else
+		available = (wr_ptr - rd_ptr) & (MAX86150_FIFO_DEPTH - 1);
+
+	while (available--) {
+		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
+		if (ret)
+			break;
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
+		iio_push_to_buffers_with_timestamp(idev, data->buf,
+						   iio_get_time_ns(idev));
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
+	return regmap_write(data->regmap, MAX86150_REG_LED2_PA,
+			    MAX86150_LED_PA_DEFAULT);
+	/*
+	 * Do NOT enable the A_FULL interrupt here.  It is enabled and
+	 * disabled via max86150_set_trigger_state() when the IIO triggered
+	 * buffer is started and stopped, which prevents the edge-triggered
+	 * interrupt line from asserting before the handler is registered.
+	 */
+}
+
+static void max86150_trigger_put(void *trig)
+{
+	iio_trigger_put(trig);
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
+	 * Enable power supplies before any I2C access.  Both are optional
+	 * in the device tree (devm_regulator_get_enable returns 0 when the
+	 * supply is not described), but must be present and stable on real
+	 * hardware before the first register read.
+	 */
+	ret = devm_regulator_get_enable(&client->dev, "vdd");
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to get/enable vdd supply\n");
+
+	ret = devm_regulator_get_enable(&client->dev, "leds");
+	if (ret)
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
+		 * iio_trigger_generic_data_rdy_poll is a hard-IRQ handler
+		 * that calls iio_trigger_poll() and returns IRQ_HANDLED.
+		 * No IRQF_ONESHOT is needed for this edge-triggered line.
+		 */
+		ret = devm_request_irq(&client->dev, client->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_TRIGGER_FALLING,
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
+
+		indio_dev->trig = iio_trigger_get(data->trig);
+		ret = devm_add_action_or_reset(&client->dev,
+					       max86150_trigger_put,
+					       data->trig);
+		if (ret)
+			return ret;
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

