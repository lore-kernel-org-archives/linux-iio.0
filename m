Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795240531;
	b=PM6rBjX9os70zSFERNPpTLZP13LIkg2CXDE6Yr4WxWfUT/+2J4NEzUGUtBlTvOdVNlHv
	 pn2r1THIy861g/C94ZQBkaB5hsSt9c1kKhXGfj1TEpmzgXJtVVrXfWERRlX8jb/tee7rM
	 qPrtdmYn8LcrAxS25tTgRuaIiNTrw+wzqB5QvLTXdsyf/S+BdqUBaoLn5F/4Mwn6oMZ7A
	 /Lk9hmTdFy7K6ZtRY2hz/OMpF0Q9oJgNV/tB36kynyH/SBbjbd160UjP5Vh8Kni0DGbM2
	 SCtww4ga0fQI6lNCzW+SczN61uBJwqPZJdRgWfcO6txhUmlkH8xcSOivTpSkVPB87gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795240531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=C788pxG0ox5C3xBPAXG7B21vCNUBW+mM8w6RKxauNW4=;
	b=ebusQ37WFDPttYxyIXQRPf5lBM2UcxoBLcYaPOtc1CydpQxYu2u8KTiqgToOm2ZLc64F
	 tQIlUE8uG5lyglDiFKg94twD2qv0OFwmxP52QRIsCfUphXNGm1WVyRhxhBWWFlUe4AVCl
	 +o4HcvCL/Iiq6ptznK9aSB4LgpKMkoyvL0SXm3jg9umNbWomcxyrOr7vPCrCbV2HBsw5t
	 DarTt8n4LxA1Gu65vxcOS0BbQBvzFvs7S+JHRYPgjxwCeAZcF3VbliXjVoxUnq4q9DwXF
	 zl70uhZdA/wydx/y3MNPtYh5k5l/xbR4cAGeChDcgv0MNqHMdhzPK8SVTzlg8z3Dwxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqnazHpz;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE3606A696
	for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 05:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85EE3606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqnazHpz
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3869f03af6aso141947eec.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 21:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795240530; x=1795845330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C788pxG0ox5C3xBPAXG7B21vCNUBW+mM8w6RKxauNW4=;
        b=LqnazHpzWYQtn8eDR2IVXTOTfgTIYrDjm2KcZxmDElI14xLrZrF6OEsa8o8rkM9RmQ
         xCBv7gBjiXEs8GURcK7WBECLyM+hoVwx62cwaisas7ZI55VffBEuEgtBkU/9cTKlWzoO
         mVZWdpS0DMsna9SHjKlEgFgUq3866Mh0ToxaE18tIKzawubWkI4Hb67WLnD8ldf4bSvE
         VGTaatlnYPb0bv5ABwj6JsIC9QofLPlwPp1NM6/P5qqaD6Cw0XQiTwkgIIWjV2iYcYZS
         /R6kW4aBnBDl9ocqGnOtFeSFP6VUq25nnblOFF1Mnc0NKvWmE7g0XSyDGZmEitVxjR7c
         A4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795240530; x=1795845330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C788pxG0ox5C3xBPAXG7B21vCNUBW+mM8w6RKxauNW4=;
        b=EipJOLQbBeWq7xBq50/YBBvGoqKPTkr/9grmWIUT2Li4GOg2ady1F40ZyNPcpE3v05
         05WOVg0n2Qhm27MHhfofXiazd5/ujwSyH7/tZAici2iik9x3P9nzkFRpQWO3gFhKzSmp
         y8qJ4hNc0wV2BTlrKghyQr1AdWdgo94J343Vn9JVwZa6T2tFYGS8FvVy8nQsBHcST9Fe
         DwUEpiR7cMoyw6cpDcwF4nHo7j3Qxv7dRLHQ2dEPHuEra7gRotFwV+P6h6x5G36nYtef
         9Bwl7f5+uWsEfZFgyYNqsxgTrDBr1yukYcMQ33o6/D/ALoCWlZexfb2d5gVe325s0Cj1
         PY1w==
X-Forwarded-Encrypted: i=1; AL+hErGxBWiKR7Me+yu+USbz8pnZk7fsVXWyhitcxKLNOpamAWeRJ24sPrg7rXiZLXv11o4RBqTihT8fUA4=@vger.kernel.org
X-Gm-Message-State: APuU4Z82mxCHLQaRk89VblwVZJCTAhLSUQiu8dEhhaliiSbDAfZSWME2
	Dbctu8QMLyUuflmuC+1TCnGHhTiy3XSPLMBppsSTMSh5ipDy323DoDid
X-Gm-Gg: AZFdTZfeoW0Qm/43QRHBobQCDdUfPyg/M46hliLqiQyont+fxQgrbRv3g+W3tKiGvNc
	NYmIqBj5x6KObWTmzRtqHxdugszgIyWlNCNY0kwecVxQ1McY4pqfmjQjsaA891hozB/Olch3qYM
	NMDT97PXB+NbUsZgYju+FAQoAsuMZnJONyskcezVFr3T9Gv5LNBfr0XHjPup7g7ZglpKuE/Gh9z
	Cnc15KGKGAyiFOtRaL7URnmXRHkG1Bb9o4m/WSdce1Tfd7+YoHb8IZDtWwxGO571jb2+s9Zuuxe
	rs4AT9z7dX5YVbAyynuLjNLVCPmqvYgsaRBQRbypYmultm1wvDhLNiA86PH7poI6oqPN3TNEyCw
	bmvCC2De35iLmdzcX3urz1P9Snatimqb/C5FnOJjpwW22wR5QPnGoheTVbvLkfws32lmcYoyHQC
	cQ387gpodzGWnlQcXffZA8I/94RDzE61zAHZRZ8OPtfAAPs1xAXDNyLOhop5R2YwyuyVytaQ26O
	XM91a9yiAeRpbB/P3KYcC7rWcktT9FDtFmj/MgIrNeFdn95SQ06Ni0i8zg/t6Fbcu4ZmGciqpW6
	5w8Y9gfhnbxn7fE+vtY0qLQ7yOJDBIo=
X-Received: by 2002:a05:7301:5098:b0:381:5fe2:a079 with SMTP id 5a478bee46e88-3856c6b010amr5365176eec.1.1795240529420;
        Fri, 20 Nov 2026 21:55:29 -0800 (PST)
Received: from [127.0.1.1] ([2405:201:201e:8863:a72d:7d80:d674:e22b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm14423662eec.21.2026.11.20.21.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 21:55:29 -0800 (PST)
From: Viral Patel <viral8854@gmail.com>
Date: Sat, 21 Nov 2026 11:25:11 +0530
Subject: [PATCH v2 2/2] iio: magnetometer: add Infineon TLE493D-W2B6 driver
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-tle493d-v2-2-92d7e57cec89@gmail.com>
References: <20261121-tle493d-v2-0-92d7e57cec89@gmail.com>
In-Reply-To: <20261121-tle493d-v2-0-92d7e57cec89@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dixit Parmar <dixitparmar19@gmail.com>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Viral Patel <viral8854@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795240513; l=20796;
 i=viral8854@gmail.com; s=20261014; h=from:subject:message-id;
 bh=zbSAs+6I4te8HSppSS+6TqYbP1JcrO2VhzqoJjp+pUQ=;
 b=0ulmmfs20+O9zfbuIs40KIie2mK3TVQQ5m8GPe5Lp92/B7VoSPUrRUkq2zfayuHsxmrUOb5tj
 kw/t5vG3SpyCivrjDXoF3sd+vzc0qWLswy0tYhkj7bX/KT0co8PWmwp
X-Developer-Key: i=viral8854@gmail.com; a=ed25519;
 pk=UC+UDB53t70pTK4wncXf3tfh0hsYMCqpxYnTaKX3MYA=

Add a driver for the Infineon TLE493D-W2B6, a 3D Hall effect magnetic
sensor with 12-bit resolution per axis and an integrated temperature
sensor, accessed over I2C.

The sensor is run in master-controlled mode. Each measurement rewrites
the Config register with the "trigger after write" bits set in the
register address byte, which starts a single conversion, and then polls
registers 0x00 to 0x06 until Diag reports a completed conversion with a
new frame counter. Results with a fuse parity error, test mode flag or
bad bus parity are rejected. FP and CP are recomputed on every write of
MOD1 and Config, as a wrong FP makes the sensor release the bus until it
is reset.

The /INT output shares a pin with SCL, so the interrupt is disabled and
so is clock stretching. The sensor's reset sequence is four SMBus Quick
commands, so it is sent during probe only if the adapter supports
I2C_FUNC_SMBUS_QUICK.

Raw I2C transfers are used rather than regmap: once PR is set a plain
read always starts at register 0x00, and the register address byte of a
write carries trigger bits.

The X, Y and Z channels and the temperature channel are available
through sysfs and through a triggered buffer with a software timestamp.
Wake-up, self-test, low-power and fast modes, sampling frequency control
and the short range are not supported yet.

This is not added to the tlv493d driver: apart from the X/Y/Z bit
packing, the two parts differ in write format, read protocol after
reset, register map and parity scheme.

Based on the TLE493D-W2B6 User Manual v1.11 and Datasheet v1.2. The
user manual is provided by Infineon after a free registration:
https://www.infineon.com/gated/infineon-tle493d-w2b6-usermanual-en_dc6d4e62-cde1-4d4b-87bb-c3368e25e35c

Datasheet: https://www.infineon.com/assets/row/public/documents/30/49/infineon-tle493d-w2b6-datasheet-en.pdf
Signed-off-by: Viral Patel <viral8854@gmail.com>
---
 MAINTAINERS                        |   1 +
 drivers/iio/magnetometer/Kconfig   |  13 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/tle493d.c | 572 +++++++++++++++++++++++++++++++++++++
 4 files changed, 587 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3004f683e78..043988d9175a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13122,6 +13122,7 @@ M:	Viral Patel <viral8854@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
+F:	drivers/iio/magnetometer/tle493d.c
 
 INFINEON TLV493D Driver
 M:	Dixit Parmar <dixitparmar19@gmail.com>
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index d359003b248e..bc26fc4d78e2 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -196,6 +196,19 @@ config IIO_ST_MAGN_SPI_3AXIS
 	  To compile this driver as a module, choose M here. The module
 	  will be called st_magn_spi.
 
+config INFINEON_TLE493D
+	tristate "Infineon TLE493D-W2B6 3D Magnetic Sensor"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here to add support for the Infineon TLE493D-W2B6 3D
+	  magnetic sensor.
+
+	  This driver can also be compiled as a module.
+	  To compile this driver as a module, choose M here: the module
+	  will be called tle493d.
+
 config INFINEON_TLV493D
 	tristate "Infineon TLV493D Low-Power 3D Magnetic Sensor"
 	depends on I2C
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index 8f2205975c1b..31df6a49459c 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -25,6 +25,7 @@ st_magn-$(CONFIG_IIO_BUFFER) += st_magn_buffer.o
 obj-$(CONFIG_IIO_ST_MAGN_I2C_3AXIS) += st_magn_i2c.o
 obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) += st_magn_spi.o
 
+obj-$(CONFIG_INFINEON_TLE493D)		+= tle493d.o
 obj-$(CONFIG_INFINEON_TLV493D)		+= tlv493d.o
 
 obj-$(CONFIG_QMC5883L)			+= qmc5883l.o
diff --git a/drivers/iio/magnetometer/tle493d.c b/drivers/iio/magnetometer/tle493d.c
new file mode 100644
index 000000000000..62b7e7ea7ec0
--- /dev/null
+++ b/drivers/iio/magnetometer/tle493d.c
@@ -0,0 +1,572 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the Infineon TLE493D-W2B6 3D Magnetic Sensor
+ *
+ * Copyright (C) 2026 Viral Patel <viral8854@gmail.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/iopoll.h>
+#include <linux/irqreturn.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+/*
+ * The sensor is accessed with raw I2C transfers instead of regmap: once PR
+ * is set, a plain read always starts at register 0x00, and the register
+ * address byte of a write also carries trigger bits that start an ADC
+ * conversion. Neither fits the regmap I2C model.
+ */
+
+#define TLE493D_REG_BX		0x00
+#define TLE493D_REG_BY		0x01
+#define TLE493D_REG_BZ		0x02
+#define TLE493D_REG_TEMP	0x03
+#define TLE493D_REG_BX2		0x04
+#define TLE493D_REG_TEMP2	0x05
+#define TLE493D_REG_DIAG	0x06
+#define TLE493D_REG_XL		0x07
+#define TLE493D_REG_WU		0x0d
+#define TLE493D_REG_TMODE	0x0e
+#define TLE493D_REG_TPHASE	0x0f
+#define TLE493D_REG_CONFIG	0x10
+#define TLE493D_REG_MOD1	0x11
+#define TLE493D_REG_MOD2	0x13
+#define TLE493D_REG_VER		0x16
+#define TLE493D_NUM_REGS	0x17
+
+/* Measurement result and Diag, registers 0x00 to 0x06 */
+#define TLE493D_DATA_LEN	7
+
+#define TLE493D_BX2_X_LSB	GENMASK(7, 4)
+#define TLE493D_BX2_Y_LSB	GENMASK(3, 0)
+#define TLE493D_TEMP2_TEMP_LSB	GENMASK(7, 6)
+#define TLE493D_TEMP2_ID	GENMASK(5, 4)
+#define TLE493D_TEMP2_Z_LSB	GENMASK(3, 0)
+
+#define TLE493D_DIAG_P		BIT(7)
+#define TLE493D_DIAG_FF		BIT(6)
+#define TLE493D_DIAG_T		BIT(4)
+#define TLE493D_DIAG_PD3	BIT(3)
+#define TLE493D_DIAG_PD0	BIT(2)
+#define TLE493D_DIAG_FRM	GENMASK(1, 0)
+
+#define TLE493D_WU_WA		BIT(7)
+#define TLE493D_TMODE_TST	GENMASK(7, 6)
+#define TLE493D_TPHASE_PH	GENMASK(7, 6)
+
+#define TLE493D_CONFIG_CP	BIT(0)
+
+#define TLE493D_MOD1_FP		BIT(7)
+#define TLE493D_MOD1_IICADR	GENMASK(6, 5)
+#define TLE493D_MOD1_PR		BIT(4)
+#define TLE493D_MOD1_CA		BIT(3)
+#define TLE493D_MOD1_INT	BIT(2)
+#define TLE493D_MOD1_MODE	GENMASK(1, 0)
+#define TLE493D_MOD1_MODE_MASTER	1
+
+#define TLE493D_MOD2_PRD	GENMASK(7, 5)
+
+#define TLE493D_VER_HWV		GENMASK(3, 0)
+#define TLE493D_VER_HWV_B21	9
+
+/* Register address byte of a write frame */
+#define TLE493D_ADDR_TRIG	GENMASK(7, 5)
+#define TLE493D_ADDR_TRIG_WRITE	1
+#define TLE493D_ADDR_REG	GENMASK(4, 0)
+
+#define TLE493D_RESET_DELAY_US	30
+/* A full range conversion takes about 175 us */
+#define TLE493D_POLL_US		100
+#define TLE493D_TIMEOUT_US	1000
+
+enum tle493d_channels {
+	TLE493D_AXIS_X,
+	TLE493D_AXIS_Y,
+	TLE493D_AXIS_Z,
+	TLE493D_TEMPERATURE,
+};
+
+/*
+ * I2C addresses selected by IICadr = 0 to 3, i.e. the defaults of variants
+ * A0 to A3. These are 7-bit addresses; the user manual lists them in 8-bit
+ * form as 0x6A, 0x44, 0xF0 and 0x88.
+ */
+static const u8 tle493d_i2c_addrs[] = { 0x35, 0x22, 0x78, 0x44 };
+
+struct tle493d_data {
+	struct i2c_client *client;
+	/* Serialises measurements and protects the register cache */
+	struct mutex lock;
+	u8 regs[TLE493D_NUM_REGS];
+};
+
+/* FP makes MOD1 together with MOD2.PRD odd parity */
+static u8 tle493d_mod1_fp(u8 mod1, u8 mod2)
+{
+	unsigned int ones;
+
+	mod1 &= ~TLE493D_MOD1_FP;
+	ones = hweight8(mod1) + hweight8(mod2 & TLE493D_MOD2_PRD);
+	if (!(ones & 1))
+		mod1 |= TLE493D_MOD1_FP;
+
+	return mod1;
+}
+
+/* CP makes registers 0x07 to 0x10 odd parity, ignoring WA, TST and PH */
+static u8 tle493d_config_cp(const u8 *regs, u8 config)
+{
+	unsigned int ones = 0;
+	unsigned int i;
+
+	for (i = TLE493D_REG_XL; i < TLE493D_REG_WU; i++)
+		ones += hweight8(regs[i]);
+	ones += hweight8(regs[TLE493D_REG_WU] & ~TLE493D_WU_WA);
+	ones += hweight8(regs[TLE493D_REG_TMODE] & ~TLE493D_TMODE_TST);
+	ones += hweight8(regs[TLE493D_REG_TPHASE] & ~TLE493D_TPHASE_PH);
+
+	config &= ~TLE493D_CONFIG_CP;
+	ones += hweight8(config);
+	if (!(ones & 1))
+		config |= TLE493D_CONFIG_CP;
+
+	return config;
+}
+
+/* Registers 0x00 to 0x05 together with the P bit have odd parity */
+static bool tle493d_data_parity_ok(const u8 *buf)
+{
+	unsigned int ones = hweight8(buf[TLE493D_REG_DIAG] & TLE493D_DIAG_P);
+	unsigned int i;
+
+	for (i = TLE493D_REG_BX; i < TLE493D_REG_DIAG; i++)
+		ones += hweight8(buf[i]);
+
+	return ones & 1;
+}
+
+static int tle493d_read(struct tle493d_data *data, u8 *buf, int len)
+{
+	int ret;
+
+	ret = i2c_master_recv(data->client, buf, len);
+	if (ret < 0)
+		return ret;
+	if (ret != len)
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * Write one register, updating its parity bit first. Only MOD1 and Config
+ * are written by this driver. The sensor drops off the bus until reset if
+ * MOD1 is written with a wrong FP.
+ */
+static int tle493d_write(struct tle493d_data *data, u8 reg, u8 val, u8 trig)
+{
+	u8 buf[2];
+	int ret;
+
+	switch (reg) {
+	case TLE493D_REG_MOD1:
+		val = tle493d_mod1_fp(val, data->regs[TLE493D_REG_MOD2]);
+		break;
+	case TLE493D_REG_CONFIG:
+		val = tle493d_config_cp(data->regs, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	buf[0] = FIELD_PREP(TLE493D_ADDR_TRIG, trig) |
+		 FIELD_PREP(TLE493D_ADDR_REG, reg);
+	buf[1] = val;
+
+	ret = i2c_master_send(data->client, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(buf))
+		return -EIO;
+
+	data->regs[reg] = val;
+
+	return 0;
+}
+
+static bool tle493d_conversion_done(const u8 *buf, u8 last_frm)
+{
+	u8 diag = buf[TLE493D_REG_DIAG];
+
+	return FIELD_GET(TLE493D_DIAG_PD0, diag) &&
+	       FIELD_GET(TLE493D_DIAG_PD3, diag) &&
+	       FIELD_GET(TLE493D_DIAG_FRM, diag) != last_frm;
+}
+
+static int tle493d_measure(struct tle493d_data *data, u8 *buf)
+{
+	u8 last_frm = FIELD_GET(TLE493D_DIAG_FRM, data->regs[TLE493D_REG_DIAG]);
+	u8 diag;
+	int ret, err;
+
+	/* Rewriting Config with the write trigger starts a single conversion */
+	ret = tle493d_write(data, TLE493D_REG_CONFIG,
+			    data->regs[TLE493D_REG_CONFIG], TLE493D_ADDR_TRIG_WRITE);
+	if (ret)
+		return ret;
+
+	ret = read_poll_timeout(tle493d_read, err,
+				err || tle493d_conversion_done(buf, last_frm),
+				TLE493D_POLL_US, TLE493D_TIMEOUT_US, true,
+				data, buf, TLE493D_DATA_LEN);
+	if (ret)
+		return ret;
+	if (err)
+		return err;
+
+	/*
+	 * Cache Diag before checking for errors: its frame counter is what the
+	 * next measurement compares against, so a rejected frame must not be
+	 * seen as new again.
+	 */
+	diag = buf[TLE493D_REG_DIAG];
+	data->regs[TLE493D_REG_DIAG] = diag;
+
+	if (!FIELD_GET(TLE493D_DIAG_FF, diag) || FIELD_GET(TLE493D_DIAG_T, diag) ||
+	    !tle493d_data_parity_ok(buf))
+		return -EIO;
+
+	return 0;
+}
+
+static int tle493d_get_channel_data(const u8 *buf, unsigned int ch)
+{
+	u32 val;
+
+	switch (ch) {
+	case TLE493D_AXIS_X:
+		val = buf[TLE493D_REG_BX] << 4 |
+		      FIELD_GET(TLE493D_BX2_X_LSB, buf[TLE493D_REG_BX2]);
+		return sign_extend32(val, 11);
+	case TLE493D_AXIS_Y:
+		val = buf[TLE493D_REG_BY] << 4 |
+		      FIELD_GET(TLE493D_BX2_Y_LSB, buf[TLE493D_REG_BX2]);
+		return sign_extend32(val, 11);
+	case TLE493D_AXIS_Z:
+		val = buf[TLE493D_REG_BZ] << 4 |
+		      FIELD_GET(TLE493D_TEMP2_Z_LSB, buf[TLE493D_REG_TEMP2]);
+		return sign_extend32(val, 11);
+	case TLE493D_TEMPERATURE:
+		/* 12-bit value whose two LSBs are always zero */
+		return buf[TLE493D_REG_TEMP] << 4 |
+		       FIELD_GET(TLE493D_TEMP2_TEMP_LSB, buf[TLE493D_REG_TEMP2]) << 2;
+	default:
+		return 0;
+	}
+}
+
+static int tle493d_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan, int *val,
+			    int *val2, long mask)
+{
+	struct tle493d_data *data = iio_priv(indio_dev);
+	u8 buf[TLE493D_DATA_LEN];
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&data->lock);
+
+		ret = tle493d_measure(data, buf);
+		if (ret)
+			return ret;
+
+		*val = tle493d_get_channel_data(buf, chan->address);
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_MAGN:
+			/* 7.7 LSB/mT in full range, i.e. 10 / 7.7 Gauss per LSB */
+			*val = 100;
+			*val2 = 77;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_TEMP:
+			/* 0.24 K per LSB of the 12-bit value */
+			*val = 240;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			/*
+			 * The 12-bit value is 1180 at 25 degC:
+			 * offset = -1180 + 25000 / 240 = -6455 / 6
+			 */
+			*val = -6455;
+			*val2 = 6;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t tle493d_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct tle493d_data *data = iio_priv(indio_dev);
+	u8 buf[TLE493D_DATA_LEN];
+	struct {
+		s16 magn[3];
+		u16 temp;
+		aligned_s64 timestamp;
+	} scan = { };
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = tle493d_measure(data, buf);
+	mutex_unlock(&data->lock);
+	if (ret)
+		goto out;
+
+	scan.magn[0] = tle493d_get_channel_data(buf, TLE493D_AXIS_X);
+	scan.magn[1] = tle493d_get_channel_data(buf, TLE493D_AXIS_Y);
+	scan.magn[2] = tle493d_get_channel_data(buf, TLE493D_AXIS_Z);
+	scan.temp = tle493d_get_channel_data(buf, TLE493D_TEMPERATURE);
+
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+#define TLE493D_AXIS_CHANNEL(axis)					\
+	{								\
+		.type = IIO_MAGN,					\
+		.modified = 1,						\
+		.channel2 = IIO_MOD_##axis,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.address = TLE493D_AXIS_##axis,				\
+		.scan_index = TLE493D_AXIS_##axis,			\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 12,					\
+			.storagebits = 16,				\
+			.endianness = IIO_CPU,				\
+		},							\
+	}
+
+static const struct iio_chan_spec tle493d_channels[] = {
+	TLE493D_AXIS_CHANNEL(X),
+	TLE493D_AXIS_CHANNEL(Y),
+	TLE493D_AXIS_CHANNEL(Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.address = TLE493D_TEMPERATURE,
+		.scan_index = TLE493D_TEMPERATURE,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static const unsigned long tle493d_scan_masks[] = { GENMASK(3, 0), 0 };
+
+static const struct iio_info tle493d_info = {
+	.read_raw = tle493d_read_raw,
+};
+
+/*
+ * The reset sequence is four separate frames whose first bytes are 0xff,
+ * 0xff, 0x00 and 0x00, i.e. SMBus Quick reads from address 0x7f followed by
+ * Quick writes to address 0x00, the general call address. Adapters without
+ * Quick support cannot send it, so the reset is skipped on those.
+ */
+static void tle493d_reset(struct tle493d_data *data)
+{
+	struct i2c_adapter *adap = data->client->adapter;
+	static const struct {
+		u16 addr;
+		char read_write;
+	} frames[] = {
+		{ 0x7f, I2C_SMBUS_READ },
+		{ 0x7f, I2C_SMBUS_READ },
+		{ 0x00, I2C_SMBUS_WRITE },
+		{ 0x00, I2C_SMBUS_WRITE },
+	};
+
+	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_QUICK)) {
+		dev_dbg(&data->client->dev, "adapter cannot send the reset sequence\n");
+		return;
+	}
+
+	/* The reset frames are not acknowledged, so ignore the return values */
+	for (unsigned int i = 0; i < ARRAY_SIZE(frames); i++)
+		i2c_smbus_xfer(adap, frames[i].addr, 0, frames[i].read_write, 0,
+			       I2C_SMBUS_QUICK, NULL);
+
+	fsleep(TLE493D_RESET_DELAY_US);
+}
+
+static int tle493d_init(struct tle493d_data *data, unsigned int iicadr)
+{
+	struct device *dev = &data->client->dev;
+	unsigned int hwv, id;
+	u8 mod1;
+	int ret;
+
+	/*
+	 * After reset the sensor uses a 2-byte read protocol which plain I2C
+	 * reads cannot handle, so MOD1 has to be written before any read. MOD2
+	 * is not known yet and FP is computed with its reset value, PRD = 0.
+	 * Clock stretching and the interrupt are disabled because /INT shares
+	 * the SCL pin.
+	 *
+	 * Every MOD1 write also sets IICadr, which selects the address the
+	 * sensor responds on, so it must match the address the device is
+	 * already on or the sensor moves to another address.
+	 */
+	mod1 = FIELD_PREP(TLE493D_MOD1_IICADR, iicadr) | TLE493D_MOD1_PR |
+	       TLE493D_MOD1_CA | TLE493D_MOD1_INT |
+	       FIELD_PREP(TLE493D_MOD1_MODE, TLE493D_MOD1_MODE_MASTER);
+	ret = tle493d_write(data, TLE493D_REG_MOD1, mod1, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to write MOD1\n");
+
+	ret = tle493d_read(data, data->regs, TLE493D_NUM_REGS);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read registers\n");
+
+	hwv = FIELD_GET(TLE493D_VER_HWV, data->regs[TLE493D_REG_VER]);
+	if (hwv != TLE493D_VER_HWV_B21)
+		dev_info(dev, "unknown hardware version %u\n", hwv);
+
+	id = FIELD_GET(TLE493D_TEMP2_ID, data->regs[TLE493D_REG_TEMP2]);
+	if (id != iicadr)
+		dev_info(dev, "unexpected ID %u, expected %u\n", id, iicadr);
+
+	/*
+	 * Full range, temperature and Bz enabled, no trigger via Config. This
+	 * also sets a valid CP, which is not the case after reset.
+	 */
+	ret = tle493d_write(data, TLE493D_REG_CONFIG, 0, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to write Config\n");
+
+	return 0;
+}
+
+static int tle493d_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct tle493d_data *data;
+	struct iio_dev *indio_dev;
+	unsigned int iicadr;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return dev_err_probe(dev, -EOPNOTSUPP, "plain I2C transfers not supported\n");
+
+	/* MOD1 writes need the IICadr value matching the current address */
+	for (iicadr = 0; iicadr < ARRAY_SIZE(tle493d_i2c_addrs); iicadr++) {
+		if (client->addr == tle493d_i2c_addrs[iicadr])
+			break;
+	}
+	if (iicadr == ARRAY_SIZE(tle493d_i2c_addrs))
+		return dev_err_probe(dev, -EINVAL, "unsupported I2C address 0x%02x\n",
+				     client->addr);
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable vdd regulator\n");
+
+	tle493d_reset(data);
+
+	ret = tle493d_init(data, iicadr);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "tle493d";
+	indio_dev->info = &tle493d_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = tle493d_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tle493d_channels);
+	indio_dev->available_scan_masks = tle493d_scan_masks;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      tle493d_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set up triggered buffer\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id tle493d_id[] = {
+	{ .name = "tle493d-w2b6" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tle493d_id);
+
+static const struct of_device_id tle493d_of_match[] = {
+	{ .compatible = "infineon,tle493d-w2b6" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tle493d_of_match);
+
+static struct i2c_driver tle493d_driver = {
+	.driver = {
+		.name = "tle493d",
+		.of_match_table = tle493d_of_match,
+	},
+	.probe = tle493d_probe,
+	.id_table = tle493d_id,
+};
+module_i2c_driver(tle493d_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Infineon TLE493D-W2B6 3D Magnetic Sensor driver");
+MODULE_AUTHOR("Viral Patel <viral8854@gmail.com>");

-- 
2.43.0

