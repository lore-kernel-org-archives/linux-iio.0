Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE93F58D9
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779907391; cv=none; b=pqD8YVzGj0eFwNEZO81DWV8J3NWDCd7hXMG8FiEqq0lxP99wpLChWyxzbGt+Mw+yDD4QaNK/LUVFjLwPbXL3UCByKac4GhrO7oeAwETwUS+pYcYouvfgHbWRV6M3y02lnR9ZrH3YPzFxfTFjzJUIhCH7iurShEIcNhSowggBTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779907391; c=relaxed/simple;
	bh=K5QeEgn9PZGE1hc6uJfVP9MHCcz16m7KWBxjK5Lvqog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAXyxjSXtJ/8CTFHbtXQqYYLnYCgaosFc2O6t7Be7C1jpQti9nCCIax7lHUn4tcioOw27IlqzbL2DAIwekfKfxa6P9D51GUsiN+ASfx1ep79Wy9SxSsk/UJMHQPJBRxqmn/Zbdi4SQoYoCAltr8OHAgR6G+RxUBT675hjB3IU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Za18lits; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za18lits"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso26205535e9.1
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779907387; x=1780512187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4Yh6+PEL/bdnCIB+WuUc2fTFy0+k/cCB2E3bDYhFW4=;
        b=Za18litsWFgI7d9PEE3cXbf31iVFlqCLbFqwC8hRBLM+KQetb+YihPBaC2qMDVr4oJ
         THsX+nhME66AEyrQKPAjP7CGZPcnX4Jr5wu/1yOYmxAZFgThKejtb2L3+5Hc6v65DoCn
         aq1azS3Dg+Pz2OkpfL/xRWZnQSDJ//nGmncXcVM2DQH8H1wyCSxfCzjyA9VF9IiNyELk
         NdPy10zJic6xH5g/1LDJuK1R6rMyc0VAVKo7ucm6DB5IqaNbCdDVz8x0yjvGc4kIBpXQ
         KFYknBs1KjjaGwatvP3H2dSoa/IJ4GidlRD1hpZylkInn00gimeSSetJCkBbz/XFr1e7
         UzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779907387; x=1780512187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z4Yh6+PEL/bdnCIB+WuUc2fTFy0+k/cCB2E3bDYhFW4=;
        b=HNQiUnWnqwq48tVOvwNU9TPhZ+VaU5xV+nf+GJzs2ukS2Rubxl2tb4K3YApmxh7BFJ
         oTOPuGWRuv2laNZRrJGOkBnm7eHRdNSQO6wpDA/IvuSdlk265ryahRDpHbJP+moFSI17
         3zCdRafFCcJpWdOsu56sOT88RMuG2Mg5fDKOmOl+aO3QpZ2JQHUHvv+EQoiOVm61RC+c
         FatZbteYVV6Pf60XP3oGiYZrW4NWtNxzOsYW9skFrB1vK1pKAoXHy1t+twC/00til8XW
         a3UYJBs6zVStUHvWaccFharhVVs3pUal3KfYdeQhApnNgV5KU81m54vHfvFPW6zL1vIA
         dwXw==
X-Forwarded-Encrypted: i=1; AFNElJ9GR74UQVITe/VyhM3CO43SXoQmUnlOAxDMGkvTy/0nYApbETdtWRXlEE3GYohc+uurbrt2njfv/b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHwkZdiUWMXUaX/eTTnvxK+SOQJTg75QlsI7i5qty8PWdAAuJ
	rWVXfCBN4ZG5cI8AGFRp8lbZxwgD1lKeQMHTDwTbTBQ2ZxIWzo1KrO+S
X-Gm-Gg: Acq92OHK5HmUOVwMX4LKe8i4cpxV0xxSJZn1gxeVJCQCHA3N+H4YhtsEfndflXv2BOr
	ZqLZUs2MTP73YXZ5818MgJPmmR8wofkai4qb+my2+hkX/ioTCrV5PsAkNj5vvNK57H3d4b23v28
	qXx2PpvvsrZLDcbL9DBz1t4gPyMdViz2wzUBE+zFOrp4khXwiGa/vrCEgTZRXhF1QSLjdaUj1d2
	DWQxlIdl7Y+/3VHd1KyBoVA1PKirHv7ONPuw+/6ZyWdYiiv9kV9Khl0G9ZPKDzgLenUsnrJcfiU
	SkVaqMLc9NMkyuTIcHsb3vjY14IqGdSlmfQLDi6duySzwWT0COb3FL+1DUQ3VKy7d8V059WaWLc
	zrI17HSjUWVAnkoQ3MjMmHHZ2xSzOoGhIzngJxL+gZp1wW1Hxfo09YpAKVgenE7pGxLy0grjOp6
	gQITxEmmkmaYBvqpA=
X-Received: by 2002:a05:600d:6451:10b0:48f:d5e8:758c with SMTP id 5b1f17b1804b1-490426d1a78mr301377695e9.16.1779907386233;
        Wed, 27 May 2026 11:43:06 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490809ca202sm35312935e9.6.2026.05.27.11.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 11:43:05 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2 3/3] iio: flow: add Sensirion SLF3S liquid flow sensor driver
Date: Wed, 27 May 2026 20:42:54 +0200
Message-ID: <20260527184257.141635-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527184257.141635-1-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
 <20260527184257.141635-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the Sensirion SLF3S family of digital liquid-flow
sensors (SLF3S-0600F, SLF3S-1300F and SLF3S-4000B).  The sensors
communicate over I2C and return a 16-bit signed flow value, a 16-bit
signed temperature reading and a status word - each protected by a
CRC-8 byte - in every measurement frame.

The driver exposes:

  in_volumeflow_raw     - signed raw counts
  in_volumeflow_scale   - litres per second per LSB (per variant)
  in_temp_raw           - signed raw counts
  in_temp_scale         - millidegrees Celsius per LSB

The variant is auto-detected from the product-info word read at
probe time.  All three SLF3S devices are factory-calibrated for both
water and isopropyl alcohol; the calibration medium is selected via
the sensirion,medium device property and defaults to water.

Scale factors are taken from the respective datasheets (Table 16
for SLF3S-0600F, Table 15 for SLF3S-1300F and SLF3S-4000B):

  SLF3S-0600F:  10 (ul/min)^-1  -> 1/600 000 000 (l/s)/LSB
  SLF3S-1300F: 500 (ml/min)^-1  -> 1/30 000 000  (l/s)/LSB
  SLF3S-4000B:  32 (ml/min)^-1  -> 1/1 920 000   (l/s)/LSB

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Andreas Klinger <ak@it-klinger.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-hwmon@vger.kernel.org
Cc: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/Kconfig       |   1 +
 drivers/iio/Makefile      |   1 +
 drivers/iio/flow/Kconfig  |  27 +++
 drivers/iio/flow/Makefile |   7 +
 drivers/iio/flow/slf3s.c  | 345 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 381 insertions(+)
 create mode 100644 drivers/iio/flow/Kconfig
 create mode 100644 drivers/iio/flow/Makefile
 create mode 100644 drivers/iio/flow/slf3s.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 661127aed..652557a5b 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -92,6 +92,7 @@ source "drivers/iio/common/Kconfig"
 source "drivers/iio/dac/Kconfig"
 source "drivers/iio/dummy/Kconfig"
 source "drivers/iio/filter/Kconfig"
+source "drivers/iio/flow/Kconfig"
 source "drivers/iio/frequency/Kconfig"
 source "drivers/iio/gyro/Kconfig"
 source "drivers/iio/health/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index cb80ef837..f03a4100c 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -29,6 +29,7 @@ obj-y += dac/
 obj-y += dummy/
 obj-y += gyro/
 obj-y += filter/
+obj-y += flow/
 obj-y += frequency/
 obj-y += health/
 obj-y += humidity/
diff --git a/drivers/iio/flow/Kconfig b/drivers/iio/flow/Kconfig
new file mode 100644
index 000000000..1eee131ea
--- /dev/null
+++ b/drivers/iio/flow/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Liquid / gas flow sensor drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Flow sensors"
+
+config SENSIRION_SLF3S
+	tristate "Sensirion SLF3S liquid flow sensor"
+	depends on I2C
+	select CRC8
+	help
+	  Say yes here to build support for the Sensirion SLF3S family
+	  of digital liquid-flow sensors:
+
+	    - SLF3S-0600F
+	    - SLF3S-1300F
+	    - SLF3S-4000B
+
+	  The driver reports the volumetric flow rate and the embedded
+	  temperature reading via the standard IIO interface.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called slf3s.
+
+endmenu
diff --git a/drivers/iio/flow/Makefile b/drivers/iio/flow/Makefile
new file mode 100644
index 000000000..3cf4ab95c
--- /dev/null
+++ b/drivers/iio/flow/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for industrial I/O flow sensor drivers
+#
+
+# When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_SENSIRION_SLF3S) += slf3s.o
diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
new file mode 100644
index 000000000..f971a2dc2
--- /dev/null
+++ b/drivers/iio/flow/slf3s.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sensirion SLF3S liquid flow sensor driver.
+ *
+ * Supports the SLF3S-0600F, SLF3S-1300F and SLF3S-4000B liquid-flow
+ * sensors over I2C.  Each measurement frame returns a 16-bit signed
+ * flow value, a 16-bit signed temperature value and a status word,
+ * each protected by a CRC-8 byte.
+ *
+ * Datasheet: https://sensirion.com/products/catalog/SLF3S-0600F/
+ *
+ * Copyright (C) 2026 CMBlu Energy GmbH
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
+
+#define SLF3S_CRC8_POLY			0x31
+#define SLF3S_CRC8_INIT			0xff
+
+#define SLF3S_PRODUCT_ID_LEN		18
+#define SLF3S_PRODUCT_FAMILY_BYTE	1
+#define SLF3S_PRODUCT_SUBTYPE_BYTE	3
+#define SLF3S_PRODUCT_FAMILY_ID		0x03
+
+#define SLF3S_MEAS_LEN			9
+#define SLF3S_MEAS_START_DELAY_US	12000
+
+/*
+ * Temperature LSB equals 1/200 degC.  IIO_TEMP uses milli-degrees,
+ * therefore the scale exposed to userspace is 1000 / 200 = 5.
+ */
+#define SLF3S_TEMP_SCALE_MILLIC		5
+
+static const u8 slf3s_cmd_prep_pid[]	= { 0x36, 0x7c };
+static const u8 slf3s_cmd_read_pid[]	= { 0xe1, 0x02 };
+static const u8 slf3s_cmd_start_water[]	= { 0x36, 0x08 };
+static const u8 slf3s_cmd_start_ipa[]	= { 0x36, 0x15 };
+static const u8 slf3s_cmd_stop_meas[]	= { 0x3f, 0xf9 };
+
+/**
+ * struct slf3s_variant - per-variant calibration constants
+ * @sub_type:	product-info sub-type byte returned by the sensor
+ * @name:	name reported via @iio_dev.name
+ * @scale_num:	flow scale numerator (l/s per LSB)
+ * @scale_den:	flow scale denominator (l/s per LSB)
+ */
+struct slf3s_variant {
+	u8 sub_type;
+	const char *name;
+	int scale_num;
+	int scale_den;
+};
+
+static const struct slf3s_variant slf3s_variants[] = {
+	[0] = {
+		.sub_type	= 0x03,
+		.name		= "slf3s-0600f",
+		.scale_num	= 1,
+		.scale_den	= 600000000,
+	},
+	[1] = {
+		.sub_type	= 0x02,
+		.name		= "slf3s-1300f",
+		.scale_num	= 1,
+		.scale_den	= 30000000,
+	},
+	[2] = {
+		.sub_type	= 0x05,
+		.name		= "slf3s-4000b",
+		.scale_num	= 1,
+		.scale_den	= 1920000,
+	},
+};
+
+/**
+ * struct slf3s_data - per-device state
+ * @client:	I2C client this instance is bound to
+ * @variant:	pointer into @slf3s_variants for the detected device
+ * @crc_table:	pre-computed CRC-8 lookup table for SLF3S_CRC8_POLY
+ */
+struct slf3s_data {
+	struct i2c_client *client;
+	const struct slf3s_variant *variant;
+	u8 crc_table[CRC8_TABLE_SIZE];
+};
+
+static bool slf3s_crc_valid(const struct slf3s_data *sf, const u8 *block)
+{
+	return crc8(sf->crc_table, block, 2, SLF3S_CRC8_INIT) == block[2];
+}
+
+static int slf3s_send_cmd(struct i2c_client *client, const u8 cmd[static 2])
+{
+	int ret = i2c_master_send(client, cmd, 2);
+
+	if (ret == 2)
+		return 0;
+	return ret < 0 ? ret : -EIO;
+}
+
+/*
+ * Read the product-info block and update @sf->variant.  The kernel
+ * trusts the DT compatible (or i2c id_table .data) above all else; the
+ * sub-type byte is a sanity hint.  This means:
+ *
+ *   - bus / CRC failures are real errors and must fail probe;
+ *   - if the caller already picked a variant (specific compatible), the
+ *     PID is logged for diagnostics but mismatches do not fail probe;
+ *   - if the caller has no variant (generic "sensirion,slf3s" fallback),
+ *     the sub-type byte is used to pick one; unknown sub-type fails.
+ */
+static int slf3s_detect_variant(struct slf3s_data *sf)
+{
+	struct i2c_client *client = sf->client;
+	u8 buf[SLF3S_PRODUCT_ID_LEN];
+	int ret;
+
+	ret = slf3s_send_cmd(client, slf3s_cmd_prep_pid);
+	if (ret)
+		return ret;
+
+	ret = slf3s_send_cmd(client, slf3s_cmd_read_pid);
+	if (ret)
+		return ret;
+
+	ret = i2c_master_recv(client, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(buf))
+		return -EIO;
+
+	for (unsigned int i = 0; i < SLF3S_PRODUCT_ID_LEN; i += 3) {
+		if (!slf3s_crc_valid(sf, &buf[i]))
+			return -EIO;
+	}
+
+	if (buf[SLF3S_PRODUCT_FAMILY_BYTE] != SLF3S_PRODUCT_FAMILY_ID)
+		dev_dbg(&client->dev,
+			"unexpected family byte 0x%02x (expected 0x%02x)\n",
+			buf[SLF3S_PRODUCT_FAMILY_BYTE],
+			SLF3S_PRODUCT_FAMILY_ID);
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(slf3s_variants); i++) {
+		if (buf[SLF3S_PRODUCT_SUBTYPE_BYTE] !=
+		    slf3s_variants[i].sub_type)
+			continue;
+
+		if (sf->variant && sf->variant != &slf3s_variants[i])
+			dev_dbg(&client->dev,
+				"DT compatible says %s but sub-type 0x%02x suggests %s\n",
+				sf->variant->name,
+				buf[SLF3S_PRODUCT_SUBTYPE_BYTE],
+				slf3s_variants[i].name);
+		else if (!sf->variant)
+			sf->variant = &slf3s_variants[i];
+		return 0;
+	}
+
+	if (sf->variant) {
+		dev_dbg(&client->dev,
+			"unknown SLF3S sub-type 0x%02x, trusting DT compatible %s\n",
+			buf[SLF3S_PRODUCT_SUBTYPE_BYTE], sf->variant->name);
+		return 0;
+	}
+
+	dev_dbg(&client->dev, "unknown SLF3S sub-type 0x%02x\n",
+		buf[SLF3S_PRODUCT_SUBTYPE_BYTE]);
+	return -ENODEV;
+}
+
+static int slf3s_read_sample(struct slf3s_data *sf, int *flow, int *temp)
+{
+	u8 buf[SLF3S_MEAS_LEN];
+	int ret;
+
+	ret = i2c_master_recv(sf->client, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(buf))
+		return -EIO;
+
+	for (unsigned int i = 0; i < SLF3S_MEAS_LEN; i += 3) {
+		if (!slf3s_crc_valid(sf, &buf[i]))
+			return -EIO;
+	}
+
+	*flow = sign_extend32(get_unaligned_be16(&buf[0]), 15);
+	*temp = sign_extend32(get_unaligned_be16(&buf[3]), 15);
+	return 0;
+}
+
+static const struct iio_chan_spec slf3s_channels[] = {
+	{
+		.type = IIO_VOLUMEFLOW,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int slf3s_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, int *val,
+			  int *val2, long mask)
+{
+	struct slf3s_data *sf = iio_priv(indio_dev);
+	int flow, temp, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = slf3s_read_sample(sf, &flow, &temp);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+
+		*val = (chan->type == IIO_VOLUMEFLOW) ? flow : temp;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_VOLUMEFLOW) {
+			*val = sf->variant->scale_num;
+			*val2 = sf->variant->scale_den;
+			return IIO_VAL_FRACTIONAL;
+		}
+		*val = SLF3S_TEMP_SCALE_MILLIC;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info slf3s_info = {
+	.read_raw = slf3s_read_raw,
+};
+
+static void slf3s_stop_meas(void *data)
+{
+	struct slf3s_data *sf = data;
+
+	slf3s_send_cmd(sf->client, slf3s_cmd_stop_meas);
+}
+
+static int slf3s_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct slf3s_data *sf;
+	const u8 *start_cmd = slf3s_cmd_start_water;
+	const char *medium;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*sf));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	sf = iio_priv(indio_dev);
+	sf->client = client;
+	sf->variant = i2c_get_match_data(client);
+	crc8_populate_msb(sf->crc_table, SLF3S_CRC8_POLY);
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
+
+	ret = slf3s_detect_variant(sf);
+	if (ret)
+		return dev_err_probe(dev, ret, "product info read failed\n");
+
+	ret = device_property_read_string(dev, "sensirion,medium", &medium);
+	if (!ret) {
+		if (!strcmp(medium, "ipa"))
+			start_cmd = slf3s_cmd_start_ipa;
+		else if (strcmp(medium, "water"))
+			return dev_err_probe(dev, -EINVAL,
+					     "unknown sensirion,medium '%s'\n",
+					     medium);
+	}
+
+	ret = slf3s_send_cmd(client, start_cmd);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to start measurement\n");
+
+	fsleep(SLF3S_MEAS_START_DELAY_US);
+
+	ret = devm_add_action_or_reset(dev, slf3s_stop_meas, sf);
+	if (ret)
+		return ret;
+
+	indio_dev->name = sf->variant->name;
+	indio_dev->channels = slf3s_channels;
+	indio_dev->num_channels = ARRAY_SIZE(slf3s_channels);
+	indio_dev->info = &slf3s_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id slf3s_id[] = {
+	{ .name = "slf3s-0600f", .driver_data = (kernel_ulong_t)&slf3s_variants[0] },
+	{ .name = "slf3s-1300f", .driver_data = (kernel_ulong_t)&slf3s_variants[1] },
+	{ .name = "slf3s-4000b", .driver_data = (kernel_ulong_t)&slf3s_variants[2] },
+	{ .name = "slf3s" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, slf3s_id);
+
+static const struct of_device_id slf3s_of_match[] = {
+	{ .compatible = "sensirion,slf3s-0600f", .data = &slf3s_variants[0] },
+	{ .compatible = "sensirion,slf3s-1300f", .data = &slf3s_variants[1] },
+	{ .compatible = "sensirion,slf3s-4000b", .data = &slf3s_variants[2] },
+	{ .compatible = "sensirion,slf3s" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, slf3s_of_match);
+
+static struct i2c_driver slf3s_driver = {
+	.driver = {
+		.name		= "slf3s",
+		.of_match_table	= slf3s_of_match,
+	},
+	.probe		= slf3s_probe,
+	.id_table	= slf3s_id,
+};
+module_i2c_driver(slf3s_driver);
+
+MODULE_AUTHOR("Wadim Mueller <wafgo01@gmail.com>");
+MODULE_DESCRIPTION("Sensirion SLF3S liquid flow sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.52.0

