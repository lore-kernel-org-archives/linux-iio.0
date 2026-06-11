Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1F40F8EB
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184431; cv=none; b=H/h8AgGALExTX3M8klrcfSdy0ynlpGrMJXyszDIROvWLAA3VAhi3TU9enJgpNlbq6i3krlR5yEvptwBTVsrku+ougsfF9KV6cdaZkF46GP6wOFtfBUuOyKQzQxGh5oWXxdgeYlT4itXGXU95MyCGDjSg9fLHy31S0EB+63mOe/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184431; c=relaxed/simple;
	bh=eRj26Lyzx6fXMSpTPcDyIYHCbt9WMvIkavbrIT2euPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNOQevKl400rb4au5Sy2pe1eqDXXjA/1/UO47XLlgiDrjn9U4NPB89X3hc+9pVwU+af7/EqFliB+VbhUUvAAfs0Q/b+ZXUKsRFtTpbbNepiwMep83vrSumfdIl4THYcjrtnudU8TSFbhwzuzxk95da7vNG5e7FiolzjB0fi1/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9wxvcuS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9wxvcuS"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so2383071a12.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781184427; x=1781789227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhY/1PsVTZ7UokZx9vJ+lV3ZAaPgcfT0eTiG6MjhSNs=;
        b=h9wxvcuSmPwZmGMuuXKVW2wcww2++tqJrwcO7i/L5j2q3JMqMz1shO3/jAuiGLThov
         pzCoAGadth+QHQNx/7AVRtvyW8HZaa6GErofPNYyWn7EJ7JI/S9ssxH2iF0NCpzb4DpV
         6Te0tEjm454oE6YH5O5eCpQOekApsb4/bv3foCAboOnvG28NXZIcTmpflS+i+3Asgbsn
         EPGRuHp+Lles8Vgh7BhD3X3jGRICH11k/v3YBmoQ+9vLWQODDH/XkvazbMWEah8GoWfy
         12ZE1lMbVoqu7sx2Ps/GZu4kp14r0FVyY2+q0q0GNjHRMW/qjKQvJRsDQcYGzwwNtIEr
         1yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781184427; x=1781789227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhY/1PsVTZ7UokZx9vJ+lV3ZAaPgcfT0eTiG6MjhSNs=;
        b=Nhk8/3bTHAPufNHSD/UJsBbjRr2nnqjl6qSdR+pkggluR56ORlf9Xgbfj/cAt6TA9q
         ymKY+uzbm3E84GD1o9nM+oVK/NAQuhiISwGAZLtFaWaP2NEB9Yy1ZyRJ3kifLl4P0xfR
         a9nqro0740QLtq9ofw6KgGwqBNNWTjPKSyQxXnhHSQv2CrSOF88+diZexaidOrjTbkOw
         t/M0j6gPoMqYGmQp90cbtfvuVuf7ZCfyOcPT7/0JE2Ix/d/8NIwefP73PbHNtZuAqSyS
         7IKc8vPZpCjVszSfASz24Qa9A3rRsFkgt/kowVELhNKzQIH6sIply0L5Ld+iWxtdKMR0
         o2Lw==
X-Gm-Message-State: AOJu0YzYlBuKoBkN+H3F2reYb6elr6UYMh7/9+nUQKD5UdF/Q2rEMTCC
	dAwb0BjwvkvB7L3D6FDpZSA4qnzmqiYhJ56ssbnnCnuFlqfan+yS6rxw
X-Gm-Gg: Acq92OGSn/lpPgWi6AKgMTLCYmp/YE7XJo3WCmOinmCpcbIJAT/oH0/XeCzPoghhBVg
	PxS0n9Av2LH5MZBZcXtnYZ6zHaLto7FKaWXs0ywmFSqaMYS69m763G2A8WCJ/sXkCFM+/ZRyQZb
	Kx5dQQX67s5wlnsKsl2KuR1vNErUOs2Je0tYVC21qXq8q1zLXuk09Rd6FYNUZfsUEbVcojKEHq1
	2wFU4YrRm5+uOvRV52m8o4bGQycA2NTIknVXWPyu1PIHOo8nKF9sTiSHWZMPmyEtCX6J2WRjGL6
	Z3J/3ld3FxnX9eTEHhD/2UXplJqIdyEx1wtqXexPnV5fhnFkUgIelNRhS8/KjiqhcawjMBBI7MV
	wYVU2+yTnVNLO5Ime98dQURzRqR6WtS721083DdEy0EGp+hywqrJNk8xKywCow9cxUTqo6EcYK6
	hLDYn1U+J8+Cl/OPHiqwe1di7sEiQSpyJoCZusPIUkl/xO9w5qmyJbkXxWb95gLEnUbUhRvkIW7
	huI
X-Received: by 2002:a17:907:c310:b0:beb:e20b:3f86 with SMTP id a640c23a62f3a-bfc885e724emr129399366b.47.1781184426499;
        Thu, 11 Jun 2026 06:27:06 -0700 (PDT)
Received: from fedora.clients.cmblu.de (p5df027fc.dip0.t-ipconnect.de. [93.240.39.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb1cf077asm65719566b.26.2026.06.11.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:27:06 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	Wadim Mueller <wafgo01@gmail.com>
Subject: [PATCH v4 4/4] iio: flow: add Sensirion SLF3S liquid flow sensor driver
Date: Thu, 11 Jun 2026 15:27:00 +0200
Message-ID: <20260611132700.671322-5-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611132700.671322-1-wafgo01@gmail.com>
References: <20260611132700.671322-1-wafgo01@gmail.com>
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
auto-detected from the product-information register at probe time;
a sensor reporting an unknown sub-type falls back to the variant
named in the device tree, as promised by the fallback compatible.

Each measurement frame returns a 16-bit signed flow value, a
16-bit signed temperature reading and a status word, each
protected by a CRC-8 byte.  The driver exposes the flow rate as
IIO_VOLUMEFLOW and the temperature as IIO_TEMP via the standard
IIO read_raw / read_scale interface.

The volume-flow scale is reported in m^3/s.  As the per-LSB scale
is on the order of 1e-12 m^3/s, it is emitted as a 64-bit
fixed-point value with femto (1e-15) resolution
(IIO_VAL_DECIMAL64_FEMTO) so the small SI value keeps full
precision.  This relies on the IIO_VAL_DECIMAL64_FEMTO format type
added earlier in this series, which extends the IIO_VAL_DECIMAL64
core formatting introduced by Rodrigo Alencar's ADF41513 series.

The active calibration medium can be switched at runtime between
the factory-calibrated water and isopropyl-alcohol modes via the
in_volumeflow_medium sysfs attribute; the sensor starts in water
mode after probe.

The sensor has no low-power state of its own, so system suspend
stops the measurement and disables the vdd supply; resume powers
the sensor back up, waits out the power-up time and restarts the
measurement with the previously active medium, following the
scd30/scd4x precedent.

This driver also creates the drivers/iio/flow/ subdirectory and
the corresponding Kconfig/Makefile glue.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-flow |  21 +
 MAINTAINERS                                  |   1 +
 drivers/iio/Kconfig                          |   1 +
 drivers/iio/Makefile                         |   1 +
 drivers/iio/flow/Kconfig                     |  22 +
 drivers/iio/flow/Makefile                    |   7 +
 drivers/iio/flow/slf3s.c                     | 521 +++++++++++++++++++
 7 files changed, 574 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-flow
 create mode 100644 drivers/iio/flow/Kconfig
 create mode 100644 drivers/iio/flow/Makefile
 create mode 100644 drivers/iio/flow/slf3s.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-flow b/Documentation/ABI/testing/sysfs-bus-iio-flow
new file mode 100644
index 000000000..fece2ecfa
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-flow
@@ -0,0 +1,21 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_medium
+What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_medium
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The calibration medium the flow sensor uses to convert its
+		raw reading into a volumetric flow rate.  Liquid flow sensors
+		are factory-calibrated per medium, so the selected medium has
+		to match the fluid actually flowing through the sensor for the
+		reported flow rate to be correct.
+
+		Reading returns the currently active medium; writing one of the
+		strings listed in in_volumeflow_medium_available selects it.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_medium_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_medium_available
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Space separated list of the calibration media supported by the
+		device, e.g. "water ipa".
diff --git a/MAINTAINERS b/MAINTAINERS
index cdc18a601..222a03b6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24193,6 +24193,7 @@ R:	Maxwell Doose <m32285159@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
+F:	drivers/iio/flow/slf3s.c
 
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
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
index 000000000..e0e1a8e36
--- /dev/null
+++ b/drivers/iio/flow/Kconfig
@@ -0,0 +1,22 @@
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
+	  Say yes here to build support for the Sensirion SLF3S family of
+	  digital liquid-flow sensors (SLF3S-0600F, SLF3S-1300F and
+	  SLF3S-4000B).  The driver reports the volumetric flow rate and the
+	  embedded temperature reading via the standard IIO interface.
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
index 000000000..ed7b89e8e
--- /dev/null
+++ b/drivers/iio/flow/slf3s.c
@@ -0,0 +1,521 @@
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
+#include <linux/cleanup.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
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
+ * @vdd:	supply regulator, disabled while suspended
+ * @variant:	pointer into @slf3s_variants for the detected device
+ * @medium:	currently active calibration medium
+ * @lock:	serialises the multi-step command/response exchanges
+ * @crc_table:	pre-computed CRC-8 lookup table for SLF3S_CRC8_POLY
+ */
+struct slf3s_data {
+	struct i2c_client *client;
+	struct regulator *vdd;
+	const struct slf3s_variant *variant;
+	enum slf3s_medium medium;
+	struct mutex lock; /* serialises command/response exchanges */
+	u8 crc_table[CRC8_TABLE_SIZE];
+};
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
+/* Start continuous measurement and wait until the first sample is valid. */
+static int slf3s_start_meas(struct slf3s_data *sf, enum slf3s_medium medium)
+{
+	const u8 *cmd = (medium == SLF3S_MEDIUM_IPA) ? slf3s_cmd_start_ipa
+						     : slf3s_cmd_start_water;
+	int ret;
+
+	ret = slf3s_send_cmd(sf->client, cmd);
+	if (ret)
+		return ret;
+
+	fsleep(SLF3S_MEAS_START_DELAY_US);
+
+	return 0;
+}
+
+static bool slf3s_crc_valid(const struct slf3s_data *sf, const u8 *block)
+{
+	return crc8(sf->crc_table, block, 2, SLF3S_CRC8_INIT) == block[2];
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
+ * sub-type byte falls back to the variant named in the device tree /
+ * I2C table: the fallback compatible promises that future family
+ * members work as an SLF3S-1300F, so do not reject them.  Without any
+ * match data probe fails since no meaningful scale can be published.
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
+	if (sf->variant) {
+		dev_warn(&client->dev,
+			 "unknown SLF3S sub-type 0x%02x, assuming %s\n",
+			 buf[SLF3S_PRODUCT_SUBTYPE_BYTE], sf->variant->name);
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
+	/*
+	 * A measurement frame is flow, temperature and a signaling-flags
+	 * word, each followed by a CRC byte.  Only flow and temperature are
+	 * used, so the read is stopped after their two words (6 bytes).
+	 */
+	u8 buf[6];
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
+	int ret;
+
+	guard(mutex)(&sf->lock);
+
+	ret = slf3s_send_cmd(sf->client, slf3s_cmd_stop_meas);
+	if (ret)
+		return ret;
+
+	ret = slf3s_start_meas(sf, mode);
+	if (ret) {
+		/*
+		 * Try to restart with the previous medium so the sensor is
+		 * not left idle, which would fail all subsequent reads.
+		 */
+		if (slf3s_start_meas(sf, sf->medium))
+			dev_warn(&sf->client->dev,
+				 "failed to restart measurement, reads will fail until a medium is set\n");
+		return ret;
+	}
+
+	sf->medium = mode;
+
+	return 0;
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
+		scoped_guard(mutex, &sf->lock)
+			ret = slf3s_read_sample(sf, &flow, &temp);
+		if (ret)
+			return ret;
+
+		*val = (chan->type == IIO_VOLUMEFLOW) ? flow : temp;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_VOLUMEFLOW) {
+			/*
+			 * scale_num/scale_den is the flow per LSB in l/s, but
+			 * IIO reports volume flow in m^3/s (1 l = 1e-3 m^3).
+			 * These values are tiny (~1.67e-12 m^3/s for the
+			 * SLF3S-0600F), so emit a 64-bit fixed-point value with
+			 * femto (1e-15) resolution to preserve precision.
+			 * Converting l/s to m^3/s (/ MILLI) and scaling to femto
+			 * (* FEMTO) leaves a net * (FEMTO / MILLI) factor.
+			 */
+			const struct slf3s_variant *v = sf->variant;
+			s64 num = (s64)v->scale_num * FEMTO / MILLI;
+			s64 scale = DIV_S64_ROUND_CLOSEST(num, v->scale_den);
+
+			iio_val_s64_decompose(scale, val, val2);
+
+			return IIO_VAL_DECIMAL64_FEMTO;
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
+static void slf3s_disable_vdd(void *data)
+{
+	struct slf3s_data *sf = data;
+
+	regulator_disable(sf->vdd);
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
+	i2c_set_clientdata(client, indio_dev);
+	sf->variant = i2c_get_match_data(client);
+	sf->medium = SLF3S_MEDIUM_WATER;
+	crc8_populate_msb(sf->crc_table, SLF3S_CRC8_POLY);
+
+	ret = devm_mutex_init(dev, &sf->lock);
+	if (ret)
+		return ret;
+
+	sf->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(sf->vdd))
+		return dev_err_probe(dev, PTR_ERR(sf->vdd),
+				     "failed to get vdd supply\n");
+
+	ret = regulator_enable(sf->vdd);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
+
+	ret = devm_add_action_or_reset(dev, slf3s_disable_vdd, sf);
+	if (ret)
+		return ret;
+
+	fsleep(SLF3S_POWER_UP_DELAY_US);
+
+	/*
+	 * The sensor may still be in continuous measurement mode from a
+	 * previous boot (warm reboot / kexec); in that case it would NACK
+	 * the product-id command below.  Stop it first and ignore the error
+	 * if it was already idle.
+	 */
+	slf3s_send_cmd(client, slf3s_cmd_stop_meas);
+
+	ret = slf3s_detect_variant(sf);
+	if (ret)
+		return dev_err_probe(dev, ret, "product info read failed\n");
+
+	ret = slf3s_start_meas(sf, sf->medium);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to start measurement\n");
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
+/*
+ * The sensor has no low-power state of its own, so stop the measurement
+ * and cut the supply while suspended.  Resume powers it back up, waits
+ * out the power-up time and restarts with the medium that was active
+ * before.
+ */
+static int slf3s_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct slf3s_data *sf = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&sf->lock);
+
+	ret = slf3s_send_cmd(sf->client, slf3s_cmd_stop_meas);
+	if (ret)
+		return ret;
+
+	return regulator_disable(sf->vdd);
+}
+
+static int slf3s_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct slf3s_data *sf = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&sf->lock);
+
+	ret = regulator_enable(sf->vdd);
+	if (ret)
+		return ret;
+
+	fsleep(SLF3S_POWER_UP_DELAY_US);
+
+	return slf3s_start_meas(sf, sf->medium);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(slf3s_pm_ops, slf3s_suspend, slf3s_resume);
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
+		.pm		= pm_sleep_ptr(&slf3s_pm_ops),
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

