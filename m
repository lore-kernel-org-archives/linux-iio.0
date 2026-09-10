Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4113CBE7A
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022315; cv=none; b=PXoyE+6nx5ZCmrBCSP8LzrrVGEgXWmnztNyHmgAJ0cviEC6fCK2E/T77YQRN42Xgrr+amDYH52QpxwKu0wBmXQ8UpZlkxMN8PeWAnQ7jSE+9R1+zrB2xF7RB287Ip8Vg3RFnCIBKJMTXfgt7Ims/5DU7y5uz6IZj5YBuGE/mxug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022315; c=relaxed/simple;
	bh=bjNSDc28hHWXvcVX35AaDBlg4rfbeHeLTtUyF8ssjTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThPJ+7dFGKUPEeR7l36AIvMQA5SoItSug/XWTtz5epJNEsRdrwvCUrQSOKHjrCXr8Rsn/x9dcgUOJP1ylocrNCtrHCFSATSt4DgKEg7nrtMfyb0X6aN5RaA7o9gi3ulcBRzHUfR8lODF7ij7tDs5ddxYdXDOY1z04mMIYOyLjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/KNbG2k; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/KNbG2k"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aa8e6bdso1825866d50.1
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 23:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789022311; x=1789627111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ncn44ITRBd+HRnqWrq6QWCDEXG0oUGnfioDpZgtbeso=;
        b=b/KNbG2k6HAtndFBcECyqjH5WMi7lQ5EgFUaUUmEmdr/LHR4XDfKorKBJR04c/3gxX
         s5J0ulsH1NcZajYyWF7rBf+RUxUWXb2GQqNRgrH3VPsNZMfhd65/SEnSAThwgbPsI0xe
         qDDoGEE71SIDIczLrPssngSUW6k9RvD/vJwWi0UkIUh/brwKm8pTyely20XMW50c4ACF
         u1n4fq4nDQsSZ4v7/3qfQXJjbpVdhPDcltokte9z+C6VgyDuP1NEI1wNIm3kqIs7Arsi
         CBNIvD8VccMxLAWawWmfHVUvPrKyGmmpOyyq8AMGT8nnVdIHWwNp7jIiudQq+k1spW6L
         +nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022311; x=1789627111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ncn44ITRBd+HRnqWrq6QWCDEXG0oUGnfioDpZgtbeso=;
        b=fRbCiH6JmFzzqOvg2gyd4GmYJXPLdXeeBGbdcITK6T8qbGw7nUsMTV2yRA5rSDaPJI
         k+tBELra4qe+S36XkgVMBbcON7sg35hzxkG9lHL6GYFvpvEYRXrcYr84r8EH/yr5hHIL
         czndTJZa05lHQ4V2FDk7oZioltJnX+ro8dsmUTd3Xchk8bEYMHY7dILDfhZ7wi4Zjhhs
         syI3WW876WG68F6cm8FS6CeyrytivwbmnmTr+MFRfj0q20Ot33qacllHxGdKVwaAheg6
         vz/gQpHWQq1dixqaGpRCo+QSM0M11TaceIYQfpFJ+Ma04Vws2TMlW9pFzFR9QblFQien
         VWdA==
X-Forwarded-Encrypted: i=1; AKwUvBy0Mm4XBD3oi3R3LgMklyZMpgsIE3gZPdVDGRp0N0y7wshLSFyyk1jTUCNa0L1GSylY5RFWyEHfS14=@vger.kernel.org
X-Gm-Message-State: AFuF++kir1/zXYGIYIbLPrl5In2IrRHIUO7IdHWMMDuzf/9xwWbIZzdZ
	idtGZ1WLUwWl+mSalphR5cR7xZIOvGYQbrvkcnjG1SDox4Mg6BVmqhsk
X-Gm-Gg: AYBFou2tXGovUmSfK5nd88Hub0PQwosDJH7VD5sFRyV6LV5tt3LZcvjBBLmOKys0cA5
	41DktrjlUTUmEEB3iP/qjrVOqmvHmp0Suyxq55eG9dsqJ5ypKTul5s/eU97s9LD37mj1KGNUzS6
	3+c6u/FruGl6ei7W7Lxmc2DeKh2Kv8szelGxw/c66KgLapmoKo6IuX/ZzI7TvafScEX+UnUuqnZ
	qRwhnFqgc718B18iUcRe/kykFSG0K0E8/QUZhTLV12Dd/ZC/47ByqWL/aJiXpJxHsIdg1RJKpNI
	9/7CcMFNhRIDS1Ebwpr5IWq0tUOAHT2C55csKZiTsxbyy424NUKQxi3wbqVPYZgiGoimk5qO5fL
	BwHlJgI/imlF6Q3QV3zrM70O/jMxuZAnx4QEuKeVMqLUQVgssdoi511gJG6eZwhZNQRVjz/no44
	INUEKKqBw5UDHHaiDe3uFULYg/7yoAbaWGDIj+DSXrwDCDUASMpLvuWA==
X-Received: by 2002:a05:690e:4881:20b0:66e:4677:71e3 with SMTP id 956f58d0204a3-6711364bc1dmr715819d50.0.1789022310642;
        Wed, 09 Sep 2026 23:38:30 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::1e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48f1646sm13517200d50.9.2026.09.09.23.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:38:29 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: [PATCH v3 2/2] iio: light: add AS7343 multi-spectral sensor driver
Date: Wed,  9 Sep 2026 23:38:13 -0700
Message-ID: <20260910063813.56419-3-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910063813.56419-1-marcus.yu.56@gmail.com>
References: <20260910063813.56419-1-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a driver for the AMS AS7343 14-channel multi-spectral
sensor with I2C interface.

The driver exposes 12 spectral channels (11 visible + 1 near-infrared)
via the IIO sysfs interface. Each channel's raw data is provided as a
16-bit little-endian unsigned integer.

Basic power management (suspend/resume) is supported. Note that power
management is designed in such a way that we only stop spectrual
measurements when susepended and do not power off.

More complex features such as auto-suspend, interrupts, and
configurable gain/integration time will be added in future patches.

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
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
 drivers/iio/light/as7343.c | 397 +++++++++++++++++++++++++++++++++++++
 4 files changed, 410 insertions(+)
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
index 000000000000..8982cd6ec5d8
--- /dev/null
+++ b/drivers/iio/light/as7343.c
@@ -0,0 +1,397 @@
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
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
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
+/* AS7343 registers */
+#define AS7343_ID	    0x5a
+
+#define AS7343_ENABLE	    0x80
+#define AS7343_ENABLE_PON   BIT(0)
+#define AS7343_ENABLE_SP_EN BIT(1)
+
+/*
+ * Integration time is calculated as (ATIME + 1) * ((ASTEP + 1) * 2.78us).
+ * Setting a 30 * 1.67ms = 50.1ms integration test as the default for now.
+ */
+#define AS7343_ATIME			   0x81
+#define AS7343_ATIME_VAL		   29 /* (29 + 1) = 30 steps */
+#define AS7343_ASTEP			   0xd4
+#define AS7343_ASTEP_VAL		   599 /* 1.67ms step size */
+
+#define AS7343_CFG0			   0xbf
+#define AS7343_CFG0_REG_BANK		   BIT(4)
+
+#define AS7343_CFG1			   0xc6
+#define AS7343_CFG1_AGAIN		   GENMASK(4, 0)
+#define AS7343_CFG1_AGAIN_X0_5		   0
+#define AS7343_CFG1_AGAIN_X1		   1
+#define AS7343_CFG1_AGAIN_X2		   2
+#define AS7343_CFG1_AGAIN_X4		   3
+#define AS7343_CFG1_AGAIN_X8		   4
+#define AS7343_CFG1_AGAIN_X16		   5
+#define AS7343_CFG1_AGAIN_X32		   6
+#define AS7343_CFG1_AGAIN_X64		   7
+#define AS7343_CFG1_AGAIN_X128		   8
+#define AS7343_CFG1_AGAIN_X256		   9
+#define AS7343_CFG1_AGAIN_X512		   10
+#define AS7343_CFG1_AGAIN_X1024		   11
+#define AS7343_CFG1_AGAIN_X2048		   12
+
+#define AS7343_CFG20			   0xd6
+#define AS7343_CFG20_AUTO_SMUX		   GENMASK(6, 5)
+#define AS7343_CFG20_AUTO_SMUX_READOUT_ALL 3 /* all-channel readout */
+
+#define AS7343_ASTATUS			   0x94
+
+/* AS7343 data registers */
+#define AS7343_DATA_FZ	0x95
+#define AS7343_DATA_FY	0x97
+#define AS7343_DATA_FXL 0x99
+#define AS7343_DATA_NIR 0x9b
+#define AS7343_DATA_F2	0xa1
+#define AS7343_DATA_F3	0xa3
+#define AS7343_DATA_F4	0xa5
+#define AS7343_DATA_F6	0xa7
+#define AS7343_DATA_F1	0xad
+#define AS7343_DATA_F7	0xaf
+#define AS7343_DATA_F8	0xb1
+#define AS7343_DATA_F5	0xb3
+#define AS7343_MAX	0xff
+
+/* AS7343 channel indices. MUST match data register order above. */
+#define AS7343_CHAN_IDX_FZ  0
+#define AS7343_CHAN_IDX_FY  1
+#define AS7343_CHAN_IDX_FXL 2
+#define AS7343_CHAN_IDX_NIR 3
+#define AS7343_CHAN_IDX_F2  4
+#define AS7343_CHAN_IDX_F3  5
+#define AS7343_CHAN_IDX_F4  6
+#define AS7343_CHAN_IDX_F6  7
+#define AS7343_CHAN_IDX_F1  8
+#define AS7343_CHAN_IDX_F7  9
+#define AS7343_CHAN_IDX_F8  10
+#define AS7343_CHAN_IDX_F5  11
+
+#define AS7343_CHAN(_chan)                                    \
+	{                                                     \
+		.type = IIO_INTENSITY,                        \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+		.address = AS7343_DATA_##_chan,               \
+		.indexed = 1,                                 \
+		.channel = AS7343_CHAN_IDX_##_chan,           \
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
+	struct mutex mutex;
+};
+
+static int as7343_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct as7343_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+	unsigned int unused;
+	__le16 result;
+
+	ret = pm_runtime_resume_and_get(dev);
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
+		ret = regmap_read(data->regmap, AS7343_ASTATUS, &unused);
+		if (ret)
+			break;
+
+		ret = regmap_bulk_read(data->regmap, chan->address, &result, 2);
+		if (ret)
+			break;
+
+		*val = le16_to_cpu(result);
+		ret = IIO_VAL_INT;
+		break;
+	}
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	pm_runtime_put(dev);
+	return ret;
+}
+
+static const char *as7343_channel_label(struct iio_chan_spec const *chan)
+{
+	switch (chan->channel) {
+	case AS7343_CHAN_IDX_FZ:
+		return "FZ";
+	case AS7343_CHAN_IDX_FY:
+		return "FY";
+	case AS7343_CHAN_IDX_FXL:
+		return "FXL";
+	case AS7343_CHAN_IDX_NIR:
+		return "NIR";
+	case AS7343_CHAN_IDX_F2:
+		return "F2";
+	case AS7343_CHAN_IDX_F3:
+		return "F3";
+	case AS7343_CHAN_IDX_F4:
+		return "F4";
+	case AS7343_CHAN_IDX_F6:
+		return "F6";
+	case AS7343_CHAN_IDX_F1:
+		return "F1";
+	case AS7343_CHAN_IDX_F7:
+		return "F7";
+	case AS7343_CHAN_IDX_F8:
+		return "F8";
+	case AS7343_CHAN_IDX_F5:
+		return "F5";
+	default:
+		return NULL;
+	}
+}
+
+static int as7343_read_label(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, char *label)
+{
+	const char *name;
+
+	name = as7343_channel_label(chan);
+	if (!name)
+		return -EINVAL;
+
+	return sysfs_emit(label, "%s\n", name);
+}
+
+static const struct iio_info as7343_info = {
+	.read_raw = as7343_read_raw,
+	.read_label = as7343_read_label,
+};
+
+static const struct regmap_config as7343_regmap_config = {
+	.name = "as7343",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AS7343_MAX,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int as7343_setup_device(struct device *dev, struct as7343_data *data)
+{
+	unsigned int val;
+	__le16 step;
+	int ret;
+
+	/* Power on */
+	ret = regmap_set_bits(data->regmap, AS7343_ENABLE, AS7343_ENABLE_PON);
+	if (ret)
+		return ret;
+
+	/* Need to set REG_BANK to 1 before we can access ID */
+	ret = regmap_set_bits(data->regmap, AS7343_CFG0, AS7343_CFG0_REG_BANK);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, AS7343_ID, &val);
+	if (ret)
+		return ret;
+
+	if (val != 0x81)
+		dev_info(dev, "Unknown device ID: %x\n", val);
+
+	ret = regmap_clear_bits(data->regmap, AS7343_CFG0,
+				AS7343_CFG0_REG_BANK);
+	if (ret)
+		return ret;
+
+	/* Configure the SMUX to readout all channels */
+	ret = regmap_update_bits(
+		data->regmap, AS7343_CFG20, AS7343_CFG20_AUTO_SMUX,
+		FIELD_PREP(AS7343_CFG20_AUTO_SMUX,
+			   AS7343_CFG20_AUTO_SMUX_READOUT_ALL));
+	if (ret)
+		return ret;
+
+	/* Set 50.1ms integration time and x256 gain for now */
+	step = cpu_to_le16(AS7343_ASTEP_VAL);
+	ret = regmap_bulk_write(data->regmap, AS7343_ASTEP, &step, 2);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, AS7343_ATIME, AS7343_ATIME_VAL);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, AS7343_CFG1, AS7343_CFG1_AGAIN,
+				  FIELD_PREP(AS7343_CFG1_AGAIN,
+					     AS7343_CFG1_AGAIN_X256));
+}
+
+static int as7343_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct as7343_data *data = iio_priv(indio_dev);
+
+	return regmap_clear_bits(data->regmap, AS7343_ENABLE,
+				 AS7343_ENABLE_SP_EN);
+}
+
+static int as7343_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct as7343_data *data = iio_priv(indio_dev);
+
+	return regmap_set_bits(data->regmap, AS7343_ENABLE,
+			       AS7343_ENABLE_SP_EN);
+}
+
+static void as7343_suspend_action(void *data)
+{
+	as7343_suspend(data);
+}
+
+static int as7343_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct as7343_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(client, &as7343_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->regmap = regmap;
+	mutex_init(&data->mutex);
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
+	ret = regmap_set_bits(data->regmap, AS7343_ENABLE, AS7343_ENABLE_SP_EN);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(as7343_pm_ops, as7343_suspend, as7343_resume,
+				 NULL);
+
+static const struct of_device_id as7343_of_match[] = {
+	{ .compatible = "ams,as7343" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, as7343_of_match);
+
+static const struct i2c_device_id as7343_id[] = {
+	{ .name = "as7343" },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, as7343_id);
+
+static struct i2c_driver as7343_driver = {
+	.driver = {
+		.name           = "as7343",
+		.of_match_table = as7343_of_match,
+		.pm             = pm_ptr(&as7343_pm_ops),
+	},
+	.probe      = as7343_probe,
+	.id_table   = as7343_id,
+};
+module_i2c_driver(as7343_driver);
+
+MODULE_AUTHOR("Chang Yu <marcus.yu.56@gmail.com>");
+MODULE_DESCRIPTION("AS7343 14 Channel Multi-Spectral Sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.55.0

