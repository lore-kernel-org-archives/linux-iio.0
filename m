Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0457357D18
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780174510; cv=none; b=PE2QLGQfMsA50ETcDZTVE6UAtZjS2AzECVF0bzqjSoIYsL91t9x+vBkSRBqexk31lNoQeOT7bVamva6J9XDgRYOsfXXzKffTq9lxQncbjHx6S1nJ4Web/KOyrEpAxv7I0eaIOEy1cU2gYsj5F0xpZGLMP1DD+2Zx92sYeW4c008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780174510; c=relaxed/simple;
	bh=uTRMtYQA+s0MhtyxEJpZLkWNUZft06Eg5SmnngQ+MN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrDZ9K7RdJ92Fzr9jQcc3ioH6+mWtKg+8xwZX3M6EwVxXAgI2LkfDJsvvDLTFJux9DI7n/NaV/LplPH5rRgPCpud3rmJ1RWtiTjYfwLCbXE/GBq5fZDkyJISd2mD/pAInGJow61H46+fQIeDzXTanVtYjtgLrPR+yuUkHsi67qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En1y/Ybi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En1y/Ybi"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a7682635so973815e9.3
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 13:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780174507; x=1780779307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/r91x18F44nECj79mEs4JTmbgxq8t6M9pdhsna8uxc=;
        b=En1y/Ybi6mqcSPz7zuM3fwJ/67+ky1qdfZE1Ply1oyndppN3DOpadzG3oUN+IrOZnu
         taGf/6CAQgfW3wxeFX325Ba997ldIpXhIxkHCUQfjjCb52wQ6ZENmq3xobKIhonMMfV9
         peiDG2LZm4FIJpp0EmkKpwyTLkTHykChtm/igXxEWIxQP2wGo01L9WAP1RELD/hHYTOg
         dEUfz3Tt14FYETu0angRBvvJHbps561B9XddJxKaoknqUhHHU0Gv2kvHpiluxtH89U1x
         c5RTS1AuSRpESC4GNebYvJRat1uSR+mNCedn+p27SAGL5w0CoCECDHIr7LgqflG4gXG6
         CnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780174507; x=1780779307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g/r91x18F44nECj79mEs4JTmbgxq8t6M9pdhsna8uxc=;
        b=m9JuzslGK2nmv9L9bgFPjTuNP6+3rXTZnvE5dp0k2QMsKYR2xjUqrLY6W8KDckcHG8
         PAlGJxFgjdzD4Bf6drql/WLjawm3Q19jhCQmYXqb5FSN4SuLxnh93hGzGceY2Zjvrzyd
         0k7/ieSfdc0rXXm9Sed17rAg2lXzZ0/U+nJVIiti1LA1AbP/4jzWjlL3JP99bRDfXjUP
         Oat/E20Mz5RuQRbGsZdtnziBN+/tzGnRKX3jCdXfY3oarUl2Xsu0JCkWzakalvb0qHLh
         HtakPnIGisbvv6EoO/bWZCBYzbJm4dKnFUMK6LdSTa8aI3wlEVTEthdX4WVncXW6crkD
         0JGg==
X-Forwarded-Encrypted: i=1; AFNElJ/CGhzVia/ySdibXGxk1rL47ce9dJUDeLzpcG6GpqwAhx/32lQMCDqdYqIIEH5NPG/Uzgdfy27WNPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz72jiC6faXPtiykhDarnIhlOh32nt6OPe1EVQ24Hofcr/gOPDY
	g1ft6Az+fOQi/FQI2UirwUMQ9hvArujSxeRW0n9/1nNPuy+KDcAFN0g8
X-Gm-Gg: Acq92OED3Zg0R+y5+yeTjViP4Slu4RSzf7AZ1jTLSukqMYPLTpUoAatZ4OyMmiddFWI
	1+p1/ZOComcgB4C7NEP3muGCM6tQ+7L/UXkX1E9zoMUMSgghNWfnWqwsOMsOmmJmrmvXYSwmg5O
	SUs0cTCqR17C9QyZwIf1LPto4+pHqK+wfmWAqHYy1sDaey0uOltn2zcsmlqImHSqnrdxBGjdZyI
	iF4w5sgY3HhzGtR0hssLJL1sooeoyWSnKVwi7WYGcvHnZ91k1D0yYoVaGv7crpBQndSnW/0X2Wq
	/LuUqJpxsaZJhvvP70/scCDgjpt83IqMogEvi8k8iYhtZbfq2TV5/C9fJbyq7YhOP4aeZRk3EE8
	GBUFt9ozbLiB+/qDLu4SsD66ZEnqnrJZQHkkdEKhJhipFTw05glodSYn+L+vKfQhgq5e54P2rGM
	5KehktiDQy8udOT3s=
X-Received: by 2002:a05:600c:8b57:b0:490:3c15:7146 with SMTP id 5b1f17b1804b1-490a5013670mr53129565e9.19.1780174507013;
        Sat, 30 May 2026 13:55:07 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cab0e94sm132288225e9.12.2026.05.30.13.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:55:06 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] iio: flow: add Sensirion SLF3S liquid flow sensor driver
Date: Sat, 30 May 2026 22:54:32 +0200
Message-ID: <20260530205435.37326-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260530205435.37326-1-wafgo01@gmail.com>
References: <20260530205435.37326-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the Sensirion SLF3S family of digital
liquid-flow sensors on I2C.  Currently supported variants are
SLF3S-0600F, SLF3S-1300F and SLF3S-4000B; they share the same
register map and differ only in flow-scale factor and calibrated
measurement range.  The variant (and therefore the scale) is
auto-detected from the product-information register at probe time.

Each measurement frame returns a 16-bit signed flow value, a
16-bit signed temperature reading and a status word, each
protected by a CRC-8 byte.  The driver exposes the flow rate as
IIO_VOLUMEFLOW and the temperature as IIO_TEMP via the standard
IIO read_raw / read_scale interface.

The active calibration medium can be switched at runtime between
the factory-calibrated water and isopropyl-alcohol modes via the
in_volumeflow_medium sysfs attribute; the sensor starts in water
mode after probe.

This driver also creates the drivers/iio/flow/ subdirectory and
the corresponding Kconfig/Makefile glue.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 drivers/iio/Kconfig       |   1 +
 drivers/iio/Makefile      |   1 +
 drivers/iio/flow/Kconfig  |  27 +++
 drivers/iio/flow/Makefile |   7 +
 drivers/iio/flow/slf3s.c  | 406 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 442 insertions(+)
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
index 000000000..497a56f59
--- /dev/null
+++ b/drivers/iio/flow/slf3s.c
@@ -0,0 +1,406 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sensirion SLF3S liquid flow sensor driver.
+ *
+ * Supports the SLF3S-0600F, SLF3S-1300F and SLF3S-4000B liquid-flow
+ * sensors over I2C.  Each measurement frame returns a 16-bit signed
+ * flow value, a 16-bit signed temperature value and a status word,
+ * each protected by a CRC-8 byte.
+ *
+ * The active calibration medium (water or isopropyl alcohol) is
+ * runtime-switchable via the in_volumeflow_medium sysfs attribute and
+ * defaults to water.
+ *
+ * Datasheet: https://sensirion.com/products/catalog/SLF3S-0600F/
+ *
+ * Copyright (C) 2026 CMBlu Energy GmbH
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
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
+/* Datasheet section 2.2: tPU = 25 ms max from power-on to first cmd. */
+#define SLF3S_POWER_UP_DELAY_US		(25 * USEC_PER_MSEC)
+/* Datasheet section 2.2: tw = 60 ms typical until first valid sample. */
+#define SLF3S_MEAS_START_DELAY_US	(60 * USEC_PER_MSEC)
+
+static const u8 slf3s_cmd_prep_pid[]	= { 0x36, 0x7c };
+static const u8 slf3s_cmd_read_pid[]	= { 0xe1, 0x02 };
+static const u8 slf3s_cmd_start_water[]	= { 0x36, 0x08 };
+static const u8 slf3s_cmd_start_ipa[]	= { 0x36, 0x15 };
+static const u8 slf3s_cmd_stop_meas[]	= { 0x3f, 0xf9 };
+
+enum slf3s_medium {
+	SLF3S_MEDIUM_WATER,
+	SLF3S_MEDIUM_IPA,
+};
+
+static const char * const slf3s_medium_modes[] = {
+	[SLF3S_MEDIUM_WATER]	= "water",
+	[SLF3S_MEDIUM_IPA]	= "ipa",
+};
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
+		.scale_den	= 600 * MICRO,
+	},
+	[1] = {
+		.sub_type	= 0x02,
+		.name		= "slf3s-1300f",
+		.scale_num	= 1,
+		.scale_den	= 30 * MICRO,
+	},
+	[2] = {
+		.sub_type	= 0x05,
+		.name		= "slf3s-4000b",
+		.scale_num	= 1,
+		.scale_den	= 1920 * MILLI,
+	},
+};
+
+/**
+ * struct slf3s_data - per-device state
+ * @client:	I2C client this instance is bound to
+ * @variant:	pointer into @slf3s_variants for the detected device
+ * @medium:	currently active calibration medium
+ * @crc_table:	pre-computed CRC-8 lookup table for SLF3S_CRC8_POLY
+ */
+struct slf3s_data {
+	struct i2c_client *client;
+	const struct slf3s_variant *variant;
+	enum slf3s_medium medium;
+	u8 crc_table[CRC8_TABLE_SIZE];
+};
+
+static bool slf3s_crc_valid(const struct slf3s_data *sf, const u8 *block)
+{
+	return crc8(sf->crc_table, block, 2, SLF3S_CRC8_INIT) == block[2];
+}
+
+static int slf3s_send_cmd(struct i2c_client *client, const u8 cmd[at_least 2])
+{
+	int ret = i2c_master_send(client, cmd, 2);
+
+	if (ret == 2)
+		return 0;
+
+	return ret < 0 ? ret : -EIO;
+}
+
+/*
+ * Read the product-info block and pick the matching variant.  The
+ * sub-type byte returned by the sensor is the source of truth; a
+ * DT-supplied compatible only seeds an initial guess and is overridden
+ * on mismatch (with an informational message so misconfigured device
+ * trees are easy to spot).
+ *
+ * Bus / CRC failures are real errors and fail probe.  An unknown
+ * sub-type byte fails probe too: we cannot publish a meaningful scale
+ * without a matching entry in slf3s_variants[].
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
+		dev_info(&client->dev,
+			 "unexpected family byte 0x%02x (expected 0x%02x)\n",
+			 buf[SLF3S_PRODUCT_FAMILY_BYTE],
+			 SLF3S_PRODUCT_FAMILY_ID);
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(slf3s_variants); i++) {
+		if (buf[SLF3S_PRODUCT_SUBTYPE_BYTE] !=
+		    slf3s_variants[i].sub_type)
+			continue;
+
+		if (sf->variant && sf->variant != &slf3s_variants[i])
+			dev_info(&client->dev,
+				 "DT compatible says %s but sensor reports %s; using %s\n",
+				 sf->variant->name,
+				 slf3s_variants[i].name,
+				 slf3s_variants[i].name);
+
+		sf->variant = &slf3s_variants[i];
+
+		return 0;
+	}
+
+	dev_err(&client->dev, "unknown SLF3S sub-type 0x%02x\n",
+		buf[SLF3S_PRODUCT_SUBTYPE_BYTE]);
+
+	return -ENODEV;
+}
+
+static int slf3s_read_sample(struct slf3s_data *sf, int *flow, int *temp)
+{
+	u8 buf[9];
+	int ret;
+
+	ret = i2c_master_recv(sf->client, buf, ARRAY_SIZE(buf));
+	if (ret < 0)
+		return ret;
+	if (ret != ARRAY_SIZE(buf))
+		return -EIO;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(buf); i += 3) {
+		if (!slf3s_crc_valid(sf, &buf[i]))
+			return -EIO;
+	}
+
+	*flow = sign_extend32(get_unaligned_be16(&buf[0]), 15);
+	*temp = sign_extend32(get_unaligned_be16(&buf[3]), 15);
+
+	return 0;
+}
+
+static int slf3s_get_medium(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan)
+{
+	struct slf3s_data *sf = iio_priv(indio_dev);
+
+	return sf->medium;
+}
+
+static int slf3s_set_medium(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan, unsigned int mode)
+{
+	struct slf3s_data *sf = iio_priv(indio_dev);
+	const u8 *start_cmd;
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = slf3s_send_cmd(sf->client, slf3s_cmd_stop_meas);
+	if (ret)
+		goto out;
+
+	start_cmd = (mode == SLF3S_MEDIUM_IPA) ? slf3s_cmd_start_ipa
+					       : slf3s_cmd_start_water;
+
+	ret = slf3s_send_cmd(sf->client, start_cmd);
+	if (ret)
+		goto out;
+
+	fsleep(SLF3S_MEAS_START_DELAY_US);
+	sf->medium = mode;
+out:
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static const struct iio_enum slf3s_medium_enum = {
+	.items		= slf3s_medium_modes,
+	.num_items	= ARRAY_SIZE(slf3s_medium_modes),
+	.get		= slf3s_get_medium,
+	.set		= slf3s_set_medium,
+};
+
+static const struct iio_chan_spec_ext_info slf3s_ext_info[] = {
+	IIO_ENUM("medium", IIO_SHARED_BY_TYPE, &slf3s_medium_enum),
+	IIO_ENUM_AVAILABLE("medium", IIO_SHARED_BY_TYPE, &slf3s_medium_enum),
+	{ }
+};
+
+static const struct iio_chan_spec slf3s_channels[] = {
+	{
+		.type = IIO_VOLUMEFLOW,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.ext_info = slf3s_ext_info,
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
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_VOLUMEFLOW) {
+			*val = sf->variant->scale_num;
+			*val2 = sf->variant->scale_den;
+
+			return IIO_VAL_FRACTIONAL;
+		}
+		/* Temperature LSB = 1/200 degC; IIO_TEMP wants milli-degC. */
+		*val = 1000 / 200;
+
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
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*sf));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	sf = iio_priv(indio_dev);
+	sf->client = client;
+	sf->variant = i2c_get_match_data(client);
+	sf->medium = SLF3S_MEDIUM_WATER;
+	crc8_populate_msb(sf->crc_table, SLF3S_CRC8_POLY);
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
+
+	fsleep(SLF3S_POWER_UP_DELAY_US);
+
+	ret = slf3s_detect_variant(sf);
+	if (ret)
+		return dev_err_probe(dev, ret, "product info read failed\n");
+
+	ret = slf3s_send_cmd(client, slf3s_cmd_start_water);
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
+	{ .name = "slf3s-0600f",
+	  .driver_data = (kernel_ulong_t)&slf3s_variants[0] },
+	{ .name = "slf3s-1300f",
+	  .driver_data = (kernel_ulong_t)&slf3s_variants[1] },
+	{ .name = "slf3s-4000b",
+	  .driver_data = (kernel_ulong_t)&slf3s_variants[2] },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, slf3s_id);
+
+static const struct of_device_id slf3s_of_match[] = {
+	{ .compatible = "sensirion,slf3s-0600f", .data = &slf3s_variants[0] },
+	{ .compatible = "sensirion,slf3s-1300f", .data = &slf3s_variants[1] },
+	{ .compatible = "sensirion,slf3s-4000b", .data = &slf3s_variants[2] },
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

