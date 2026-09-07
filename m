Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA540BCBB
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814859; cv=none; b=YfaIItNekY0vBGSFzFMBKcaA6wX2iYufuXLFl+tpVXvmy9Qhvn9awcPtrMCGDfQBiHU2uvgJgol/a9HPY7Vbti9OEDmwTR9tIWMp5z8zd5G6c8o+9AaYKPoiDEFJJhetL9xDfU6fv1K3au/L866/KEigqudl4AaOIvBf12klgs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814859; c=relaxed/simple;
	bh=ccze0jL5wUSyawpDA++nf/vL2kTqZ68wKlR79o1mNbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQxs93eQldU/EYrPUvNmnzMM1YbPpU3xgwjT0W94Cn/rCQNHKb0d69ufxq2266pBl5b5f7v3NWpybvvwbB29huo5qlXawWPeO418SW8InukCgltI67xQ9+6BiFj4cCIKhenD3fGqEho3xnllpc1jw1fJnYHSz1DDaKzx+Jccfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BelQZOFy; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BelQZOFy"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dbcb505578so37488387b3.3
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788814855; x=1789419655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7rH8a/3SZZAFRvaRNDsd7d/w4Gg4tRvrphTeTE7xNaI=;
        b=BelQZOFyhy/SE5M1BNMR8p8ILbJV23Xyr79I4JF86Ipfem9HHNAMOoeWrXE0vsjX35
         LEIcfOda3ryReuTOs1LVrg2nHbEpI80B9Ig2WLJltZAmBSPCFjRPQToqNlvOmdRkCG1t
         g6LsR6MPGh3Q2rnd2PveH2NZYuDS1n+nnoYPXPKaCM4nwt/mbEGW7ouaGD98+mCEbuba
         ZEXYfZF9Ix291uqWhUPcNIxJwNrmjV7XVKyJ+WtB6fM7344MDalu5WunINQTPxtLzmAZ
         YSJv7qNWCtfzQDw3+WK0TvZ/iCzaOzx8GOlm7IVfCqLrYVTYJu6h52R4Djp8qK/hO++M
         alVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814855; x=1789419655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7rH8a/3SZZAFRvaRNDsd7d/w4Gg4tRvrphTeTE7xNaI=;
        b=Sj6IsaHF3aHTy2ed2Y1sIekDwnUV8vlHvHdr1+JWnErLugc587Dzv6OrJpOmzJp0rW
         mAUy0/7MZg2sVTyNP6heg3ZzR0mpn6kJQ/+foH9UulxocqXe0Z5vgbKFrCWmRcxT84bQ
         HPcNs+cUf+GtPCLvELQDHh8x8f7kqTCxm+mhgkXJuJ44Qnx67tz/+P0lzl046/tcuNKw
         REAihqMUvMOFdScXEJeoz7w9bnUw1xNBr7mFHM1lH2NH9IoP1iOH99a9L2NCIyQBLTaB
         o+jKij1ma0avYvIMAAz/UT+0mYS+8LcEaciHDKenwCK3a36PCimpM00IYaikqdonvF50
         OIqw==
X-Forwarded-Encrypted: i=1; AKwUvByVzny//jI5YqvzdQ7ZThaSsI+aVtVgcBe3Kd1CdSTQ1XXfz9IRZh5agCWzqbbap7oPTHWVXOFkFt8=@vger.kernel.org
X-Gm-Message-State: AFuF++lrD9sH6ZlKd+MNc0HMLmJJDXak3//SqxKk6F1jjB4W1iwlyLRh
	6GW3/dH7rjaBHIgK1mEhCSk1GN0IRcROp7c9WYlB26OlQypEyMGQkoYJ
X-Gm-Gg: AYBFou0y+7E/5jWVOp4MemMd0OJaBUV8KbPE8f7h+Zr2he+WKeekzzDcxotMA5KkL0l
	+P6WRhtCPGrB96MNWdHDJtNmLYLeKaIta5C2+HPlXU7rH8itUq0fMLawF6kJNIYOrCxV9svUogm
	e0JBrc7WTkjN9VZJSx2gvvTPU8gstHaul6sOzp7Ac2I4DNl1JYdQRipsprQ1BTz8dsFEdMSGLs2
	xC1zs8/veDekXCNG4Bo0UzJb8knN5FBnQajgfWr/6xk/uZVe438Mj8fE2ZeQxH3w1HwidpXxRGo
	7voHU2/XuscEb8xVZ5sz7AwwnvsUIbdVZ+nGd0Oe7Nw5IThLcy1qrDlrMgNZ1CElGuwvWAoH7mC
	9RNuJIRrXratgiqD190hipD9BSmoNGcHngZjKbNbSU7TuOaHhbshHLqWih3eRG7/1r7q9rCBArw
	wEXGRtgq1kV+1biWkwas8rAU4XUCbn9l+zp7p1gVMkkxg=
X-Received: by 2002:a05:690c:9:b0:87c:9141:749e with SMTP id 00721157ae682-87c914177fcmr8760837b3.3.1788814854933;
        Mon, 07 Sep 2026 14:00:54 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::1e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b720e57sm77609007b3.40.2026.09.07.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:00:54 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Yu <marcus.yu.56@gmail.com>,
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
Subject: [PATCH v2 2/2] iio: light: add AS7343 multi-spectral sensor driver
Date: Mon,  7 Sep 2026 14:00:42 -0700
Message-ID: <20260907210042.32552-3-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907210042.32552-1-marcus.yu.56@gmail.com>
References: <20260907210042.32552-1-marcus.yu.56@gmail.com>
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

Basic power management (suspend/resume) is supported. More complex
features such as auto-suspend, interrupts, and configurable
gain/integration time will be added in future patches.

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
Changes in v2:
  - Adjust the default gain to x256 and integration time to 50.1ms as
  recommended by the datasheet.
  - Use read_label instead of .extend
  - Remove all unused scan_index related constants.
  - Add missing calls to pm_runtime_* methods in probe.
  - Fix various code style issues

 MAINTAINERS                |   1 +
 drivers/iio/light/Kconfig  |  11 ++
 drivers/iio/light/Makefile |   1 +
 drivers/iio/light/as7343.c | 372 +++++++++++++++++++++++++++++++++++++
 4 files changed, 385 insertions(+)
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
index 000000000000..f8ee0f2e7392
--- /dev/null
+++ b/drivers/iio/light/as7343.c
@@ -0,0 +1,372 @@
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
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
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
+};
+
+static int as7343_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct as7343_data *data = iio_priv(indio_dev);
+	int ret;
+	unsigned int unused;
+	u16 result;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		/*
+		 * Reading ASTATUS latches all data registers to this read.
+		 * We don't care about the returned saturation/gain status for
+		 * now.
+		 */
+		ret = regmap_read(data->regmap, AS7343_ASTATUS, &unused);
+		if (ret)
+			return ret;
+
+		ret = regmap_bulk_read(data->regmap, chan->address, &result, 2);
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
+	u16 step;
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
+	ret = regmap_update_bits(data->regmap, AS7343_CFG1, AS7343_CFG1_AGAIN,
+				 FIELD_PREP(AS7343_CFG1_AGAIN,
+					    AS7343_CFG1_AGAIN_X256));
+	if (ret)
+		return ret;
+
+	/* Start measurements */
+	return regmap_set_bits(data->regmap, AS7343_ENABLE,
+			       AS7343_ENABLE_SP_EN);
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
+
+	indio_dev->name = "as7343";
+	indio_dev->info = &as7343_info;
+	indio_dev->channels = as7343_channels;
+	indio_dev->num_channels = ARRAY_SIZE(as7343_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_regulator_get_enable(&client->dev, "vdd");
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
+		.pm             = pm_sleep_ptr(&as7343_pm_ops),
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

