Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7433AD8C
	for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177170; cv=none; b=Uuiynlw6Tb8pySb1wgtCA/2Zu4LbXy7TcBgrdrL/7kgej1lpaq6tWiezi5hlZu04L0CJESrLEwbb8K4BQv9gSVg83SGQje9y5xJCRLqU4XlJFAbtc9CYnXQkdK4dVQwBgeuZabJaZvT6G7KZnisjHZzojDvFMLFNw6AR9J9tVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177170; c=relaxed/simple;
	bh=8OtqLe66+NEuG7Yx+8+7Kyq0wh4Cr4Y5ElYEMeB3DMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuZPUB4+RCSUgutmikVwHmj3uRW/guF6xYX52aM5j4XfsqA9beUuw/DxfpyJd4Izu2+SdkMchMpK49ON7cuYP/7bQSc/svj13OhPZdeKa0mduKoCv+YAey+55QoK8kcOx3Bv1srdo2baTNQggGrU2VwjDF58cKEPL5qrf1yUgvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJQUpcpD; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJQUpcpD"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcbso4502887b3.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 18:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789177166; x=1789781966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XyftgBY0+kyMqLFDkHTF7KAvRP+zK/ZBLZAuhbZ2ajk=;
        b=GJQUpcpDG4wcpogwqQqfStk3BBB1KpYRx0dGKY4t7VQtyGaF135/D2IU0s1sDcbnqP
         1pHvvUjrtpy5jF5xXGkZTp5mK6rXMYBtMGadne5eEFKQAQMk3A2tPF96p7PhzxtO5hfo
         ETSkSI6HQ7Er91vWuOvl/AHomPydw30I1T93VCg8JFcBVTjhGgaYWGJvwqifMGEQUE1a
         BKfOoj0dDkZnprR/YhB+yun5wFFem4g/smn1cRuQ2XYnt1/X2LX63Okcl5dLNJLY5oLr
         UUCb/dDQpUMxjJEHwEyHBhi0aYRLYtI+f2nkxQYoYp5Dt037+xkD2btXDGDnrHelBVk2
         vqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789177166; x=1789781966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XyftgBY0+kyMqLFDkHTF7KAvRP+zK/ZBLZAuhbZ2ajk=;
        b=dofONXxdFoFhbhZjPsh5ZZLGKEknMA6eMTdRIOypNdf12ZgNS+TTry1FCPspDEuOmU
         AAo9OVCAAvjk3dNJmgsqYEB4g11ZSYeQm9mTaFniXU77h73Lc8WbMIiN6wW1oINLC6ah
         mWa1k/GVVyR3pKBaqkCKFFyXXWnVoZtdmXvTtMvcGWt7jwBoX/H4pGE2VwUrHdLb5hRy
         B5PvLcq0xfNhhsNZ8U3q5f8jZBu5QErHGzp2Ss2hSS0AsNxLJRb3h6RzK/pqecWyWNQe
         ef6/NnOEa2NviqEGpFtR4eM5KW0+/WaBATanqB/ffofV0ydiqWb32CTGLTYeeglK2222
         bptQ==
X-Forwarded-Encrypted: i=1; AKwUvByiqjveDJTXEFF5mrJskzZBCqOXQHTNixNl3SgcdyngeKGc2dnVi0LqrwKmGISkBC0seAUilixdt6U=@vger.kernel.org
X-Gm-Message-State: AFuF++l0mVgmyY7QNAbUWQGtbvPoL8DfE2IBCxQVH31rdtLBNXyWY2S3
	eFB+oB9mV6nMf28sjYnvPrydJOpmiyQpZjjXBqVrt/4VyWDxM0sBL554
X-Gm-Gg: AYBFou0dbFj4o2xIhJGXPRSrKJhX+8AKWvBBdiJoMsABnq9wE9bTUmKiZE4Vg8sEfxR
	JXGr2ir/WTGDipar2K/4chL+/9TEg4i4jrrTdOZP1HdYfScy81fatLZNAdja4whXL98a1kaZItT
	Dj5zvbHIX6BxMHdSlIPZUCgCpzsmxrKFae60GD+VrNk0aQH6wpjbnQ/yHUWyqI/U5u42nzGEXAu
	MEHdwSqpv2eIkes2D481peWN9znUGYhq2ZToDGXz38gfVSVSpXbt2Lbz/ZZZ/l3cnP9Rac367yy
	VPUVjAldI2YPC0lBQmrFjwdev/RF93HzqX2nRaUXrXmDo58rsFiGBpUCLQMJe9gnZsEON+DIgc2
	FGkCnYC7Ry1+4+glRF+6kuxhVtoHi2FUmZc8463MRHFH9Khexy8NiB69mKx+1mREcuz1+Bkyt6T
	mApuSMYYROcBvBvppixdkJIyi+/1DL+8xKTsZT66nOAKt+jZg/xmQ8FQ==
X-Received: by 2002:a05:690c:f03:b0:81f:2403:9e70 with SMTP id 00721157ae682-884b26e9b52mr27558997b3.19.1789177166440;
        Fri, 11 Sep 2026 18:39:26 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-884878de7b7sm17996697b3.29.2026.09.11.18.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 18:39:25 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] iio: light: add AS7343 multi-spectral sensor driver
Date: Fri, 11 Sep 2026 18:39:12 -0700
Message-ID: <20260912013912.51887-3-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912013912.51887-1-marcus.yu.56@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the AMS AS7343 14-channel multi-spectral sensor.

The AS7343 is a 14-channel spectral sensor featuring 11 visible
channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
flicker detection channel.

The driver exposes 12 spectral channels (11 visible light and 1
near-infrared) via sysfs. Runtime PM is implemented to stop
measurements when the device is suspended or torn down. Power is
never cut (PON=1 always) to preserve register values.

Future patches will add configurable gain and integration time,
interrupt support, buffered reads, VIS channel, and flicker
detection.

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
Changes in v4:
 - Use REGCACHE_MAPLE and add volatile register table.
 - Use PM_RUNTIME_ACQUIRE* when resuming.
 - Use a static array for labels.
 - Various code style fixes.

Changes in v3:
 - Hold a mutex before reading measurements.
 - Add pm_runtime_resume_and_get before reading measurements.
 - Only start measurements after suspend action has been successfully
   registered
 - Check the return value of regmap_read when verifying device ID.

Changes in v2:
 - Adjust the default gain to x256 and integration time to 50.1ms as
 recommended by the datasheet.
 - Use read_label instead of .extend
 - Remove all unused scan_index related constants.
 - Add missing calls to pm_runtime_* methods in probe.
 - Fix various code style issues

 MAINTAINERS                |   1 +
 drivers/iio/light/Kconfig  |  11 +
 drivers/iio/light/Makefile |   1 +
 drivers/iio/light/as7343.c | 434 +++++++++++++++++++++++++++++++++++++
 4 files changed, 447 insertions(+)
 create mode 100644 drivers/iio/light/as7343.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cf4e1635053..236102b3c28e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1435,6 +1435,7 @@ M:	Chang Yu <marcus.yu.56@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
+F:	drivers/iio/light/as7343.c
 
 AMT (Automatic Multicast Tunneling)
 M:	Taehee Yoo <ap420073@gmail.com>
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index ef36824f312f..edbeeba9d873 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -149,6 +149,17 @@ config AS73211
 	 This driver can also be built as a module.  If so, the module
 	 will be called as73211.
 
+config AS7343
+	tristate "AMS AS7343 14-Channel Multi-Spectral Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	 Say Y here to build support for the AMS AS7343 14-channel
+	 multi-spectral sensor.
+
+	 To compile this driver as a module, choose M here: the module will
+	 be called as7343.
+
 config BH1745
 	tristate "ROHM BH1745 colour sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 64e354c49ed8..5d0d33802519 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_APDS9306)		+= apds9306.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
 obj-$(CONFIG_APDS9999)		+= apds9999.o
 obj-$(CONFIG_AS73211)		+= as73211.o
+obj-$(CONFIG_AS7343)		+= as7343.o
 obj-$(CONFIG_BH1745)		+= bh1745.o
 obj-$(CONFIG_BH1750)		+= bh1750.o
 obj-$(CONFIG_BH1780)		+= bh1780.o
diff --git a/drivers/iio/light/as7343.c b/drivers/iio/light/as7343.c
new file mode 100644
index 000000000000..9ea6a44c35b9
--- /dev/null
+++ b/drivers/iio/light/as7343.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Support for AMS AS7343 14-channel multi-spectral sensor.
+ * (7-bit I2C slave address 0x39)
+ *
+ * Based on the work of:
+ *   Christian Eggers <ceggers@arri.de> (AS73211 driver)
+ *
+ * Copyright (c) 2026 Chang Yu <marcus.yu.56@gmail.com>
+ *
+ * Datasheets:
+ *   https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
+ *
+ * TODO:
+ *   - Autosuspend
+ *   - Support for configurable gain and integration time
+ *   - Interrupt support
+ *   - Add support for reading the VIS channel
+ *   - Flicker detection
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+#include <linux/iio/iio.h>
+
+#define AS7343_ID				0x5a
+
+/* AS7343 config registers */
+#define AS7343_ENABLE				0x80
+#define AS7343_ENABLE_PON			BIT(0)
+#define AS7343_ENABLE_SP_EN			BIT(1)
+
+/*
+ * Integration time is calculated as (ATIME + 1) * ((ASTEP + 1) * 2.78us).
+ * Setting a 30 * 1.67ms = 50.1ms integration time as the default for now.
+ */
+#define AS7343_ATIME				0x81
+#define AS7343_ATIME_VAL			29 /* (29 + 1) = 30 steps */
+#define AS7343_ASTEP				0xd4
+#define AS7343_ASTEP_VAL			599 /* 1.67ms step size */
+
+#define AS7343_CFG0				0xbf
+#define AS7343_CFG0_REG_BANK			BIT(4)
+
+#define AS7343_CFG1				0xc6
+#define AS7343_CFG1_AGAIN			GENMASK(4, 0)
+#define AS7343_CFG1_AGAIN_X0_5			0
+#define AS7343_CFG1_AGAIN_X1			1
+#define AS7343_CFG1_AGAIN_X2			2
+#define AS7343_CFG1_AGAIN_X4			3
+#define AS7343_CFG1_AGAIN_X8			4
+#define AS7343_CFG1_AGAIN_X16			5
+#define AS7343_CFG1_AGAIN_X32			6
+#define AS7343_CFG1_AGAIN_X64			7
+#define AS7343_CFG1_AGAIN_X128			8
+#define AS7343_CFG1_AGAIN_X256			9
+#define AS7343_CFG1_AGAIN_X512			10
+#define AS7343_CFG1_AGAIN_X1024			11
+#define AS7343_CFG1_AGAIN_X2048			12
+
+#define AS7343_CFG20				0xd6
+#define AS7343_CFG20_AUTO_SMUX			GENMASK(6, 5)
+#define AS7343_CFG20_AUTO_SMUX_READOUT_ALL	3 /* all-channel readout */
+
+#define AS7343_CONTROL				0xfa
+
+/* AS7343 status registers */
+#define AS7343_STATUS2				0x90
+#define AS7343_STATUS3				0x91
+#define AS7343_STATUS				0x93
+#define AS7343_ASTATUS				0x94
+#define AS7343_STATUS5				0xbb
+#define AS7343_STATUS4				0xbc
+#define AS7343_FD_STATUS			0xe3
+
+/* AS7343 spectral data registers */
+#define AS7343_DATA_FZ		0x95
+#define AS7343_DATA_FY		0x97
+#define AS7343_DATA_FXL		0x99
+#define AS7343_DATA_NIR		0x9b
+#define AS7343_DATA_F2		0xa1
+#define AS7343_DATA_F3		0xa3
+#define AS7343_DATA_F4		0xa5
+#define AS7343_DATA_F6		0xa7
+#define AS7343_DATA_F1		0xad
+#define AS7343_DATA_F7		0xaf
+#define AS7343_DATA_F8		0xb1
+#define AS7343_DATA_F5		0xb3
+#define AS7343_DATA_FD_L	0xb7
+#define AS7343_DATA_FD_H	0xb8
+
+/* AS7343 FIFO buffer data registers */
+#define AS7343_FIFO_LVL		0xfd
+#define AS7343_FDATA_L		0xfe
+#define AS7343_FDATA_H		0xff
+
+/* AS7343 channel indices. MUST match data register order above. */
+#define AS7343_CHAN_IDX_FZ	0
+#define AS7343_CHAN_IDX_FY	1
+#define AS7343_CHAN_IDX_FXL	2
+#define AS7343_CHAN_IDX_NIR	3
+#define AS7343_CHAN_IDX_F2	4
+#define AS7343_CHAN_IDX_F3	5
+#define AS7343_CHAN_IDX_F4	6
+#define AS7343_CHAN_IDX_F6	7
+#define AS7343_CHAN_IDX_F1	8
+#define AS7343_CHAN_IDX_F7	9
+#define AS7343_CHAN_IDX_F8	10
+#define AS7343_CHAN_IDX_F5	11
+
+#define AS7343_CHAN(_chan)					\
+	{							\
+		.type = IIO_INTENSITY,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+		.address = AS7343_DATA_##_chan,			\
+		.indexed = 1,					\
+		.channel = AS7343_CHAN_IDX_##_chan,		\
+	}
+
+static const struct iio_chan_spec as7343_channels[] = {
+	AS7343_CHAN(FZ), AS7343_CHAN(FY), AS7343_CHAN(FXL), AS7343_CHAN(NIR),
+	AS7343_CHAN(F2), AS7343_CHAN(F3), AS7343_CHAN(F4),  AS7343_CHAN(F6),
+	AS7343_CHAN(F1), AS7343_CHAN(F7), AS7343_CHAN(F8),  AS7343_CHAN(F5),
+};
+
+struct as7343_data {
+	struct regmap *regmap;
+	/* Ensures reads don't stomp on each other */
+	struct mutex mutex;
+};
+
+static int as7343_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct as7343_data *data = iio_priv(indio_dev);
+	unsigned int unused;
+	struct regmap *map;
+	struct device *dev;
+	__le16 result;
+	int ret;
+
+	map = data->regmap;
+	dev = regmap_get_device(map);
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		/* Wait until integration time passes for all 3 cycles. */
+		msleep(160);
+
+		/*
+		 * Reading ASTATUS latches all data registers to this read.
+		 * We don't care about the returned saturation/gain status for
+		 * now.
+		 */
+		guard(mutex)(&data->mutex);
+		ret = regmap_read(map, AS7343_ASTATUS, &unused);
+		if (ret)
+			return ret;
+
+		ret = regmap_bulk_read(map, chan->address,
+				       &result, sizeof(result));
+		if (ret)
+			return ret;
+
+		*val = le16_to_cpu(result);
+		return IIO_VAL_INT;
+	}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Channel names and wavelength ranges as defined in the datasheet
+ * (Figure 7, "AS7343 Optical Channel Summary"). Values are the
+ * minimum and maximum peak wavelength in nanometers.
+ *
+ * F1:  395-415 nm
+ * F2:  415-435 nm
+ * FZ:  440-460 nm
+ * F3:  465-485 nm
+ * F4:  505-525 nm
+ * FY:  545-565 nm
+ * F5:  540-560 nm
+ * FXL: 590-610 nm
+ * F6:  630-650 nm
+ * F7:  680-700 nm
+ * F8:  735-755 nm
+ * NIR: 845-865 nm
+ */
+static const char * const as7343_channel_labels[] = {
+	[AS7343_CHAN_IDX_F1] = "F1",
+	[AS7343_CHAN_IDX_F2] = "F2",
+	[AS7343_CHAN_IDX_FZ] = "FZ",
+	[AS7343_CHAN_IDX_F3] = "F3",
+	[AS7343_CHAN_IDX_F4] = "F4",
+	[AS7343_CHAN_IDX_FY] = "FY",
+	[AS7343_CHAN_IDX_F5] = "F5",
+	[AS7343_CHAN_IDX_FXL] = "FXL",
+	[AS7343_CHAN_IDX_F6] = "F6",
+	[AS7343_CHAN_IDX_F7] = "F7",
+	[AS7343_CHAN_IDX_F8] = "F8",
+	[AS7343_CHAN_IDX_NIR] = "NIR",
+};
+
+static int as7343_read_label(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, char *label)
+{
+	int channel = chan->channel;
+
+	if (channel >= ARRAY_SIZE(as7343_channel_labels))
+		return -EINVAL;
+
+	return sysfs_emit(label, "%s\n", as7343_channel_labels[channel]);
+}
+
+static const struct iio_info as7343_info = {
+	.read_raw = as7343_read_raw,
+	.read_label = as7343_read_label,
+};
+
+static const struct regmap_range as7343_volatile_ranges[] = {
+	regmap_reg_range(AS7343_ENABLE, AS7343_ENABLE),
+	regmap_reg_range(AS7343_STATUS2, AS7343_DATA_FD_H),
+	regmap_reg_range(AS7343_STATUS5, AS7343_STATUS4),
+	regmap_reg_range(AS7343_FD_STATUS, AS7343_FD_STATUS),
+	regmap_reg_range(AS7343_CONTROL, AS7343_CONTROL),
+	regmap_reg_range(AS7343_FIFO_LVL, AS7343_FDATA_H),
+};
+
+static const struct regmap_access_table as7343_volatile_table = {
+	.yes_ranges = as7343_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(as7343_volatile_ranges),
+};
+
+static const struct regmap_config as7343_regmap_config = {
+	.name = "as7343",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AS7343_FDATA_H,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.cache_type = REGCACHE_MAPLE,
+	.volatile_table = &as7343_volatile_table,
+};
+
+static int as7343_setup_device(struct device *dev, struct as7343_data *data)
+{
+	struct regmap *map = data->regmap;
+	unsigned int val;
+	__le16 step;
+	int ret;
+
+	/* Power on */
+	ret = regmap_set_bits(map, AS7343_ENABLE, AS7343_ENABLE_PON);
+	if (ret)
+		return ret;
+
+	/* Need to set REG_BANK to 1 before we can access ID */
+	ret = regmap_set_bits(map, AS7343_CFG0, AS7343_CFG0_REG_BANK);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(map, AS7343_ID, &val);
+	if (ret)
+		return ret;
+
+	if (val != 0x81)
+		dev_info(dev, "Unknown device ID: %x\n", val);
+
+	ret = regmap_clear_bits(map, AS7343_CFG0, AS7343_CFG0_REG_BANK);
+	if (ret)
+		return ret;
+
+	/* Configure the SMUX to readout all channels */
+	ret = regmap_update_bits(map, AS7343_CFG20, AS7343_CFG20_AUTO_SMUX,
+				 FIELD_PREP(AS7343_CFG20_AUTO_SMUX,
+					    AS7343_CFG20_AUTO_SMUX_READOUT_ALL));
+	if (ret)
+		return ret;
+
+	/* Set 50.1ms integration time and x256 gain for now */
+	step = cpu_to_le16(AS7343_ASTEP_VAL);
+	ret = regmap_bulk_write(map, AS7343_ASTEP, &step, sizeof(step));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(map, AS7343_ATIME, AS7343_ATIME_VAL);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(map, AS7343_CFG1, AS7343_CFG1_AGAIN,
+				  FIELD_PREP(AS7343_CFG1_AGAIN,
+					     AS7343_CFG1_AGAIN_X256));
+}
+
+static int as7343_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct as7343_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
+
+	return regmap_clear_bits(map, AS7343_ENABLE, AS7343_ENABLE_SP_EN);
+}
+
+static int as7343_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct as7343_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
+
+	return regmap_set_bits(map, AS7343_ENABLE, AS7343_ENABLE_SP_EN);
+}
+
+static void as7343_suspend_action(void *data)
+{
+	struct device *dev = data;
+
+	as7343_suspend(dev);
+}
+
+static int as7343_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct as7343_data *data;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	regmap = devm_regmap_init_i2c(client, &as7343_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	data = iio_priv(indio_dev);
+	data->regmap = regmap;
+
+	ret = devm_mutex_init(dev, &data->mutex);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "as7343";
+	indio_dev->info = &as7343_info;
+	indio_dev->channels = as7343_channels;
+	indio_dev->num_channels = ARRAY_SIZE(as7343_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return ret;
+
+	ret = as7343_setup_device(dev, data);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, as7343_suspend_action, dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to add suspend action\n");
+
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to activate PM runtime\n");
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable PM runtime\n");
+
+	/* Start measurements */
+	ret = regmap_set_bits(regmap, AS7343_ENABLE, AS7343_ENABLE_SP_EN);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(as7343_pm_ops,
+				 as7343_suspend, as7343_resume, NULL);
+
+static const struct of_device_id as7343_of_match[] = {
+	{ .compatible = "ams,as7343" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, as7343_of_match);
+
+static const struct i2c_device_id as7343_id[] = {
+	{ .name = "as7343" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, as7343_id);
+
+static struct i2c_driver as7343_driver = {
+	.driver = {
+		.name = "as7343",
+		.of_match_table = as7343_of_match,
+		.pm = pm_ptr(&as7343_pm_ops),
+	},
+	.probe = as7343_probe,
+	.id_table = as7343_id,
+};
+module_i2c_driver(as7343_driver);
+
+MODULE_AUTHOR("Chang Yu <marcus.yu.56@gmail.com>");
+MODULE_DESCRIPTION("AS7343 14 Channel Multi-Spectral Sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.55.0

