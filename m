Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880A3E0C5D
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751868; cv=none; b=ZEj2bh4mSiAIlJ56qjSY2gkFf9mkbG9h7ikE2ocQX3i+fb34bYDh7PP9VoNJtCCoLRGa/APrlBfegQ8Kpy6sT0uVZ/j16uKCggG74s+SAba5Ukwsg1WZQr0hSdf6d1FZFYMnNNpvb78rC7W+syEqrS8z8QbImufVFovbr6Oa5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751868; c=relaxed/simple;
	bh=ofaoZ3GwpVGeJ3+m9GvD3udQNMOTWqfUz/k2VYDH73o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZLA8BW25ibCjn9s1QLEGrNSLXVRgEanDX4hWbEtGZmE36e5UtEbadIilzvqkr31fyKeQmoN6q63wnH8VZJxaXr8BaC0S9lAw5viD4Q13BVsvi7gXwTIvvpTpv8a2OVHlVDFp0Sl+S1YjlcZrp8QrpihOfvnqTxkc6DwDXdqkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=XNUSL4rc; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="XNUSL4rc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775751862; x=1776011062;
	bh=3G5wMUA8Y/1GpMxnYDFBKiEoksHmdkGe6qqFMVlJNww=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XNUSL4rcWProRZZZGBHk8yTcn7TsYO5DFl7dRHdm65TNGFSJSbM0Uz8s7qSWoadI2
	 D7CcML8K0haMy2hQsAbSlcMC19fbZ5T5cGdQU7ne/Y38H5N2/1RQ01QyHcQuq0aB0N
	 /AT9Ya9EHcKQmjsRNAbCYWSL8dWHkTBEZmvBY05BXFKtbxcISvUurdhpfIefcDOmJf
	 a3xuotJvuXrrjCOqpXqYGIozYG+ThRYyu7+ulU+lMbCkAadP+aU9XB/tdGLAF0Zpco
	 xatWo4Z9QeQP04HwTLvcdE0Zj24WiOJVR5eDAqCd9aAslMirZNmFo7gSGlReGOpQzh
	 0gUGRgaTL11Og==
Date: Thu, 09 Apr 2026 16:24:17 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH 3/4] staging: iio: magnetometer: Add QST QMC5883P driver
Message-ID: <20260409162308.2590385-4-hardik.phalet@pm.me>
In-Reply-To: <20260409162308.2590385-1-hardik.phalet@pm.me>
References: <20260409162308.2590385-1-hardik.phalet@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: dcac24137a995ea1ba17e170cc1c80436327ce72
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add an IIO driver for the QST QMC5883P 3-axis magnetometer. The device
communicates over I2C and is managed via regmap with an rbtree cache.
Regmap fields are used to access the individual bit fields in CTRL_1 and
CTRL_2 registers.

The driver supports:
 - Raw magnetic field readings on X, Y and Z axes
 - Four full-scale ranges (=C2=B12 G, =C2=B18 G, =C2=B112 G, =C2=B130 G)
 - Configurable output data rate (10, 50, 100, 200 Hz)
 - Configurable oversampling ratio (1, 2, 4, 8)
 - Configurable downsampling ratio (1, 2, 4, 8) via a custom sysfs attr
 - Runtime PM with a 2 s autosuspend delay

Known limitations tracked in TODO:
 - No triggered buffer support
 - No DRDY interrupt support
 - Self-test register field is unused

Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
---
 drivers/staging/iio/Kconfig                 |   1 +
 drivers/staging/iio/Makefile                |   1 +
 drivers/staging/iio/magnetometer/Kconfig    |  20 +
 drivers/staging/iio/magnetometer/Makefile   |   7 +
 drivers/staging/iio/magnetometer/TODO       |   5 +
 drivers/staging/iio/magnetometer/qmc5883p.c | 819 ++++++++++++++++++++
 6 files changed, 853 insertions(+)
 create mode 100644 drivers/staging/iio/magnetometer/Kconfig
 create mode 100644 drivers/staging/iio/magnetometer/Makefile
 create mode 100644 drivers/staging/iio/magnetometer/TODO
 create mode 100644 drivers/staging/iio/magnetometer/qmc5883p.c

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index a60631c1f449..d363e163d248 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -10,5 +10,6 @@ source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
 source "drivers/staging/iio/impedance-analyzer/Kconfig"
+source "drivers/staging/iio/magnetometer/Kconfig"
=20
 endmenu
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 628583535393..7dcbb75d43f0 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -8,3 +8,4 @@ obj-y +=3D adc/
 obj-y +=3D addac/
 obj-y +=3D frequency/
 obj-y +=3D impedance-analyzer/
+obj-y +=3D magnetometer/
diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio=
/magnetometer/Kconfig
new file mode 100644
index 000000000000..d631da9578a1
--- /dev/null
+++ b/drivers/staging/iio/magnetometer/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Magnetometer sensors
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Magnetometer sensors"
+
+config QMC5883P
+=09tristate "QMC5883P 3-Axis Magnetometer"
+=09depends on I2C
+=09select REGMAP_I2C
+=09help
+=09  Say yes here to build support for QMC5883P I2C-based
+=09  3-axis magnetometer chip.
+
+=09  To compile this driver as a module, choose M here: the
+=09  module will be called qmc5883p.
+
+endmenu
diff --git a/drivers/staging/iio/magnetometer/Makefile b/drivers/staging/ii=
o/magnetometer/Makefile
new file mode 100644
index 000000000000..8e650f2e3b02
--- /dev/null
+++ b/drivers/staging/iio/magnetometer/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for staging industrial I/O Magnetometer sensor devices
+#
+# When adding new entries keep the list in alphabetical order
+
+obj-$(CONFIG_QMC5883P)=09+=3D qmc5883p.o
diff --git a/drivers/staging/iio/magnetometer/TODO b/drivers/staging/iio/ma=
gnetometer/TODO
new file mode 100644
index 000000000000..6a8084c0dded
--- /dev/null
+++ b/drivers/staging/iio/magnetometer/TODO
@@ -0,0 +1,5 @@
+TODO
+=3D=3D=3D=3D
+- Implement triggered buffer support (iio_triggered_buffer_setup)
+- Add interrupt (DRDY) support
+- Implement self-test (selftest regmap field is unused)
diff --git a/drivers/staging/iio/magnetometer/qmc5883p.c b/drivers/staging/=
iio/magnetometer/qmc5883p.c
new file mode 100644
index 000000000000..6a71dc47efb9
--- /dev/null
+++ b/drivers/staging/iio/magnetometer/qmc5883p.c
@@ -0,0 +1,819 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * qmc5883p.c - QMC5883P magnetometer driver
+ *
+ * Copyright 2026 Hardik Phalet <hardik.phalet@pm.me>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+/* Register definition */
+#define QMC5883P_REG_CHIP_ID 0x00
+#define QMC5883P_REG_X_LSB 0x01
+#define QMC5883P_REG_X_MSB 0x02
+#define QMC5883P_REG_Y_LSB 0x03
+#define QMC5883P_REG_Y_MSB 0x04
+#define QMC5883P_REG_Z_LSB 0x05
+#define QMC5883P_REG_Z_MSB 0x06
+#define QMC5883P_REG_STATUS 0x09
+#define QMC5883P_REG_CTRL_1 0x0A
+#define QMC5883P_REG_CTRL_2 0x0B
+
+/* Value definition */
+#define QMC5883P_MODE_SUSPEND 0x00
+#define QMC5883P_MODE_NORMAL 0x01
+#define QMC5883P_MODE_SINGLE 0x02
+#define QMC5883P_MODE_CONTINUOUS 0x03
+
+/* Output data rate */
+#define QMC5883P_ODR_10 0x00
+#define QMC5883P_ODR_50 0x01
+#define QMC5883P_ODR_100 0x02
+#define QMC5883P_ODR_200 0x03
+
+/* Oversampling rate */
+#define QMC5883P_OSR_8 0x00
+#define QMC5883P_OSR_4 0x01
+#define QMC5883P_OSR_2 0x02
+#define QMC5883P_OSR_1 0x03
+
+/* Downsampling rate */
+#define QMC5883P_DSR_1 0x00
+#define QMC5883P_DSR_2 0x01
+#define QMC5883P_DSR_4 0x02
+#define QMC5883P_DSR_8 0x03
+
+#define QMC5883P_RSTCTRL_SET_RESET \
+=090x00 /* Set and reset on, i.e. the offset of device is renewed */
+#define QMC5883P_RSTCTRL_SET_ONLY 0x01 /* Set only on */
+#define QMC5883P_RSTCTRL_OFF 0x02 /* Set and reset off */
+
+#define QMC5883P_RNG_30G 0x00
+#define QMC5883P_RNG_12G 0x01
+#define QMC5883P_RNG_08G 0x02
+#define QMC5883P_RNG_02G 0x03
+
+#define QMC5883P_DEFAULT_ODR QMC5883P_ODR_100
+#define QMC5883P_DEFAULT_OSR QMC5883P_OSR_4
+#define QMC5883P_DEFAULT_DSR QMC5883P_DSR_4
+#define QMC5883P_DEFAULT_RNG QMC5883P_RNG_08G
+
+#define QMC5883P_DRDY_POLL_US 1000
+
+#define QMC5883P_CHIP_ID 0x80
+
+#define QMC5883P_STATUS_DRDY BIT(0)
+#define QMC5883P_STATUS_OVFL BIT(1)
+
+/*
+ * Scale factors in T/LSB for IIO_VAL_FRACTIONAL (val/val2), derived from
+ * datasheet Table 2 sensitivities (LSB/G) converted to LSB/T (1 G =3D 1e-=
4 T):
+ *   sensitivity_T =3D sensitivity_G * 10000
+ *   scale =3D 1 / sensitivity_T
+ *
+ * Index matches register value: RNG<1:0> =3D 0b00..0b11
+ */
+static const int qmc5883p_scale[][2] =3D {
+=09[QMC5883P_RNG_30G] =3D { 1, 10000000 },
+=09[QMC5883P_RNG_12G] =3D { 1, 25000000 },
+=09[QMC5883P_RNG_08G] =3D { 1, 37500000 },
+=09[QMC5883P_RNG_02G] =3D { 1, 150000000 },
+};
+
+static const int qmc5883p_odr[] =3D {
+=09[QMC5883P_ODR_10] =3D 10,
+=09[QMC5883P_ODR_50] =3D 50,
+=09[QMC5883P_ODR_100] =3D 100,
+=09[QMC5883P_ODR_200] =3D 200,
+};
+
+static const int qmc5883p_osr[] =3D {
+=09[QMC5883P_OSR_1] =3D 1,
+=09[QMC5883P_OSR_2] =3D 2,
+=09[QMC5883P_OSR_4] =3D 4,
+=09[QMC5883P_OSR_8] =3D 8,
+};
+
+static const unsigned int qmc5883p_dsr[] =3D {
+=09[QMC5883P_DSR_1] =3D 1,
+=09[QMC5883P_DSR_2] =3D 2,
+=09[QMC5883P_DSR_4] =3D 4,
+=09[QMC5883P_DSR_8] =3D 8,
+};
+
+struct qmc5883p_rf {
+=09struct regmap_field *osr;
+=09struct regmap_field *dsr;
+=09struct regmap_field *odr;
+=09struct regmap_field *mode;
+=09struct regmap_field *rng;
+=09struct regmap_field *rstctrl;
+=09struct regmap_field *sftrst;
+=09struct regmap_field *selftest;
+=09struct regmap_field *chip_id;
+};
+
+static const struct regmap_range qmc5883p_readable_ranges[] =3D {
+=09regmap_reg_range(QMC5883P_REG_CHIP_ID, QMC5883P_REG_STATUS),
+=09regmap_reg_range(QMC5883P_REG_CTRL_1, QMC5883P_REG_CTRL_2),
+};
+
+static const struct regmap_range qmc5883p_writable_ranges[] =3D {
+=09regmap_reg_range(QMC5883P_REG_CTRL_1, QMC5883P_REG_CTRL_2),
+};
+
+/*
+ * Volatile registers: hardware updates these independently of the driver.
+ * regmap will never serve these from cache.
+ */
+static const struct regmap_range qmc5883p_volatile_ranges[] =3D {
+=09regmap_reg_range(QMC5883P_REG_X_LSB, QMC5883P_REG_Z_MSB),
+=09regmap_reg_range(QMC5883P_REG_STATUS, QMC5883P_REG_STATUS),
+};
+
+/*
+ * Precious registers: reading has a side effect (clears DRDY/OVFL bits).
+ * regmap will never read these speculatively.
+ */
+static const struct regmap_range qmc5883p_precious_ranges[] =3D {
+=09regmap_reg_range(QMC5883P_REG_STATUS, QMC5883P_REG_STATUS),
+};
+
+static const struct regmap_access_table qmc5883p_readable_table =3D {
+=09.yes_ranges =3D qmc5883p_readable_ranges,
+=09.n_yes_ranges =3D ARRAY_SIZE(qmc5883p_readable_ranges),
+};
+
+static const struct regmap_access_table qmc5883p_writable_table =3D {
+=09.yes_ranges =3D qmc5883p_writable_ranges,
+=09.n_yes_ranges =3D ARRAY_SIZE(qmc5883p_writable_ranges),
+};
+
+static const struct regmap_access_table qmc5883p_volatile_table =3D {
+=09.yes_ranges =3D qmc5883p_volatile_ranges,
+=09.n_yes_ranges =3D ARRAY_SIZE(qmc5883p_volatile_ranges),
+};
+
+static const struct regmap_access_table qmc5883p_precious_table =3D {
+=09.yes_ranges =3D qmc5883p_precious_ranges,
+=09.n_yes_ranges =3D ARRAY_SIZE(qmc5883p_precious_ranges),
+};
+
+static const struct regmap_config qmc5883p_regmap_config =3D {
+=09.reg_bits =3D 8,
+=09.val_bits =3D 8,
+=09.max_register =3D 0x0B,
+=09.cache_type =3D REGCACHE_RBTREE,
+=09.rd_table =3D &qmc5883p_readable_table,
+=09.wr_table =3D &qmc5883p_writable_table,
+=09.volatile_table =3D &qmc5883p_volatile_table,
+=09.precious_table =3D &qmc5883p_precious_table,
+};
+
+struct qmc5883p_data {
+=09struct device *dev;
+=09struct regmap *regmap;
+=09struct mutex mutex; /* protects regmap and rf field accesses */
+=09struct qmc5883p_rf rf;
+};
+
+enum qmc5883p_channels {
+=09AXIS_X =3D 0,
+=09AXIS_Y,
+=09AXIS_Z,
+};
+
+static const struct reg_field qmc5883p_rf_osr =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_1, 4, 5);
+static const struct reg_field qmc5883p_rf_dsr =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_1, 6, 7);
+static const struct reg_field qmc5883p_rf_odr =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_1, 2, 3);
+static const struct reg_field qmc5883p_rf_mode =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_1, 0, 1);
+static const struct reg_field qmc5883p_rf_rng =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_2, 2, 3);
+static const struct reg_field qmc5883p_rf_rstctrl =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_2, 0, 1);
+static const struct reg_field qmc5883p_rf_sftrst =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_2, 7, 7);
+static const struct reg_field qmc5883p_rf_selftest =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_2, 6, 6);
+static const struct reg_field qmc5883p_rf_chip_id =3D
+=09REG_FIELD(QMC5883P_REG_CHIP_ID, 0, 7);
+
+static int qmc5883p_rf_init(struct qmc5883p_data *data)
+{
+=09struct regmap *regmap =3D data->regmap;
+=09struct device *dev =3D data->dev;
+=09struct qmc5883p_rf *rf =3D &data->rf;
+
+=09rf->osr =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_osr);
+=09if (IS_ERR(rf->osr))
+=09=09return PTR_ERR(rf->osr);
+
+=09rf->dsr =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_dsr);
+=09if (IS_ERR(rf->dsr))
+=09=09return PTR_ERR(rf->dsr);
+
+=09rf->odr =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_odr);
+=09if (IS_ERR(rf->odr))
+=09=09return PTR_ERR(rf->odr);
+
+=09rf->mode =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_mode);
+=09if (IS_ERR(rf->mode))
+=09=09return PTR_ERR(rf->mode);
+
+=09rf->rng =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_rng);
+=09if (IS_ERR(rf->rng))
+=09=09return PTR_ERR(rf->rng);
+
+=09rf->rstctrl =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_rstctr=
l);
+=09if (IS_ERR(rf->rstctrl))
+=09=09return PTR_ERR(rf->rstctrl);
+
+=09rf->sftrst =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_sftrst)=
;
+=09if (IS_ERR(rf->sftrst))
+=09=09return PTR_ERR(rf->sftrst);
+
+=09rf->selftest =3D
+=09=09devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_selftest);
+=09if (IS_ERR(rf->selftest))
+=09=09return PTR_ERR(rf->selftest);
+
+=09rf->chip_id =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_chip_i=
d);
+=09if (IS_ERR(rf->chip_id))
+=09=09return PTR_ERR(rf->chip_id);
+
+=09return 0;
+}
+
+static int qmc5883p_verify_chip_id(struct qmc5883p_data *data)
+{
+=09int ret, regval;
+
+=09ret =3D regmap_field_read(data->rf.chip_id, &regval);
+=09if (ret)
+=09=09return dev_err_probe(data->dev, ret,
+=09=09=09=09     "failed to read chip ID\n");
+
+=09if (regval !=3D QMC5883P_CHIP_ID)
+=09=09return dev_err_probe(data->dev, -ENODEV,
+=09=09=09=09     "unexpected chip ID 0x%02x, expected 0x%02x\n",
+=09=09=09=09     regval, QMC5883P_CHIP_ID);
+=09return ret;
+}
+
+static int qmc5883p_chip_init(struct qmc5883p_data *data)
+{
+=09int ret;
+
+=09ret =3D regmap_field_write(data->rf.sftrst, 1);
+=09if (ret)
+=09=09return ret;
+
+=09usleep_range(1000, 2000);
+
+=09ret =3D regmap_field_write(data->rf.sftrst, 0);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D regmap_field_write(data->rf.rstctrl, QMC5883P_RSTCTRL_SET_RESET=
);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D regmap_field_write(data->rf.rng, QMC5883P_DEFAULT_RNG);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D regmap_field_write(data->rf.osr, QMC5883P_DEFAULT_OSR);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D regmap_field_write(data->rf.dsr, QMC5883P_DEFAULT_DSR);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D regmap_field_write(data->rf.odr, QMC5883P_DEFAULT_ODR);
+=09if (ret)
+=09=09return ret;
+
+=09return regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
+}
+
+/*
+ * qmc5883p_get_measure - read all three axes.
+ * Must be called with data->mutex held.
+ * Handles PM internally: resumes device, reads data, schedules autosuspen=
d.
+ */
+static int qmc5883p_get_measure(struct qmc5883p_data *data, s16 *x, s16 *y=
,
+=09=09=09=09s16 *z)
+{
+=09int ret;
+=09u8 reg_data[6];
+=09unsigned int status;
+
+=09ret =3D pm_runtime_resume_and_get(data->dev);
+=09if (ret < 0)
+=09=09return ret;
+
+=09/*
+=09 * Poll the status register until DRDY is set or timeout.
+=09 * Read the whole register in one shot so that OVFL is captured from
+=09 * the same read: reading 0x09 clears both DRDY and OVFL, so a second
+=09 * read would always see OVFL=3D0.
+=09 * At ODR=3D10Hz one period is 100ms; use 150ms as a safe upper bound.
+=09 */
+=09ret =3D regmap_read_poll_timeout(data->regmap, QMC5883P_REG_STATUS,
+=09=09=09=09       status, status & QMC5883P_STATUS_DRDY,
+=09=09=09=09       QMC5883P_DRDY_POLL_US, 150000);
+=09if (ret)
+=09=09goto out;
+
+=09if (status & QMC5883P_STATUS_OVFL) {
+=09=09dev_warn_ratelimited(data->dev,
+=09=09=09=09     "data overflow, consider reducing field range\n");
+=09=09ret =3D -ERANGE;
+=09=09goto out;
+=09}
+
+=09ret =3D regmap_bulk_read(data->regmap, QMC5883P_REG_X_LSB, reg_data,
+=09=09=09       ARRAY_SIZE(reg_data));
+=09if (ret)
+=09=09goto out;
+
+=09*x =3D (s16)((reg_data[1] << 8) | reg_data[0]);
+=09*y =3D (s16)((reg_data[3] << 8) | reg_data[2]);
+=09*z =3D (s16)((reg_data[5] << 8) | reg_data[4]);
+
+out:
+=09pm_runtime_mark_last_busy(data->dev);
+=09pm_runtime_put_autosuspend(data->dev);
+=09return ret;
+}
+
+static int qmc5883p_write_scale(struct qmc5883p_data *data, int val, int v=
al2)
+{
+=09int i;
+
+=09for (i =3D 0; i < ARRAY_SIZE(qmc5883p_scale); i++) {
+=09=09if (qmc5883p_scale[i][0] =3D=3D val && qmc5883p_scale[i][1] =3D=3D v=
al2)
+=09=09=09return regmap_field_write(data->rf.rng, i);
+=09}
+
+=09return -EINVAL;
+}
+
+static int qmc5883p_write_odr(struct qmc5883p_data *data, int val)
+{
+=09int i;
+
+=09for (i =3D 0; i < ARRAY_SIZE(qmc5883p_odr); i++) {
+=09=09if (qmc5883p_odr[i] =3D=3D val)
+=09=09=09return regmap_field_write(data->rf.odr, i);
+=09}
+
+=09return -EINVAL;
+}
+
+static int qmc5883p_write_osr(struct qmc5883p_data *data, int val)
+{
+=09int i;
+
+=09for (i =3D 0; i < ARRAY_SIZE(qmc5883p_osr); i++) {
+=09=09if (qmc5883p_osr[i] =3D=3D val)
+=09=09=09return regmap_field_write(data->rf.osr, i);
+=09}
+
+=09return -EINVAL;
+}
+
+static ssize_t downsampling_ratio_show(struct device *dev,
+=09=09=09=09       struct device_attribute *attr, char *buf)
+{
+=09struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+=09struct qmc5883p_data *data =3D iio_priv(indio_dev);
+=09unsigned int regval;
+=09int ret;
+
+=09guard(mutex)(&data->mutex);
+
+=09ret =3D regmap_field_read(data->rf.dsr, &regval);
+=09if (ret)
+=09=09return ret;
+
+=09return sysfs_emit(buf, "%u\n", qmc5883p_dsr[regval]);
+}
+
+static ssize_t downsampling_ratio_store(struct device *dev,
+=09=09=09=09=09struct device_attribute *attr,
+=09=09=09=09=09const char *buf, size_t len)
+{
+=09struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+=09struct qmc5883p_data *data =3D iio_priv(indio_dev);
+=09unsigned int val;
+=09int i, ret, restore;
+
+=09ret =3D kstrtouint(buf, 10, &val);
+=09if (ret)
+=09=09return ret;
+
+=09guard(mutex)(&data->mutex);
+
+=09ret =3D pm_runtime_resume_and_get(dev);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
+=09if (ret)
+=09=09goto out;
+
+=09ret =3D -EINVAL;
+=09for (i =3D 0; i < ARRAY_SIZE(qmc5883p_dsr); i++) {
+=09=09if (qmc5883p_dsr[i] =3D=3D val) {
+=09=09=09ret =3D regmap_field_write(data->rf.dsr, i);
+=09=09=09break;
+=09=09}
+=09}
+
+=09restore =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
+=09if (restore && !ret)
+=09=09ret =3D restore;
+
+out:
+=09pm_runtime_mark_last_busy(dev);
+=09pm_runtime_put_autosuspend(dev);
+=09return ret ? ret : (ssize_t)len;
+}
+
+static int qmc5883p_read_raw(struct iio_dev *indio_dev,
+=09=09=09     const struct iio_chan_spec *chan, int *val,
+=09=09=09     int *val2, long mask)
+{
+=09s16 x, y, z;
+=09struct qmc5883p_data *data =3D iio_priv(indio_dev);
+=09int ret;
+=09unsigned int regval;
+
+=09guard(mutex)(&data->mutex);
+
+=09switch (mask) {
+=09case IIO_CHAN_INFO_RAW:
+=09=09ret =3D qmc5883p_get_measure(data, &x, &y, &z);
+=09=09if (ret < 0)
+=09=09=09return ret;
+=09=09switch (chan->address) {
+=09=09case AXIS_X:
+=09=09=09*val =3D x;
+=09=09=09break;
+=09=09case AXIS_Y:
+=09=09=09*val =3D y;
+=09=09=09break;
+=09=09case AXIS_Z:
+=09=09=09*val =3D z;
+=09=09=09break;
+=09=09}
+=09=09return IIO_VAL_INT;
+
+=09case IIO_CHAN_INFO_SCALE:
+=09=09ret =3D regmap_field_read(data->rf.rng, &regval);
+=09=09if (ret < 0)
+=09=09=09return ret;
+=09=09*val =3D qmc5883p_scale[regval][0];
+=09=09*val2 =3D qmc5883p_scale[regval][1];
+=09=09return IIO_VAL_FRACTIONAL;
+
+=09case IIO_CHAN_INFO_SAMP_FREQ:
+=09=09ret =3D regmap_field_read(data->rf.odr, &regval);
+=09=09if (ret < 0)
+=09=09=09return ret;
+=09=09*val =3D qmc5883p_odr[regval];
+=09=09return IIO_VAL_INT;
+
+=09case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+=09=09ret =3D regmap_field_read(data->rf.osr, &regval);
+=09=09if (ret < 0)
+=09=09=09return ret;
+=09=09*val =3D qmc5883p_osr[regval];
+=09=09return IIO_VAL_INT;
+=09}
+
+=09return -EINVAL;
+}
+
+static int qmc5883p_write_raw(struct iio_dev *indio_dev,
+=09=09=09      struct iio_chan_spec const *chan, int val,
+=09=09=09      int val2, long mask)
+{
+=09struct qmc5883p_data *data =3D iio_priv(indio_dev);
+=09int ret, restore;
+
+=09guard(mutex)(&data->mutex);
+
+=09ret =3D pm_runtime_resume_and_get(data->dev);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
+=09if (ret)
+=09=09goto out;
+
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SAMP_FREQ:
+=09=09ret =3D qmc5883p_write_odr(data, val);
+=09=09break;
+=09case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+=09=09ret =3D qmc5883p_write_osr(data, val);
+=09=09break;
+=09case IIO_CHAN_INFO_SCALE:
+=09=09ret =3D qmc5883p_write_scale(data, val, val2);
+=09=09break;
+=09default:
+=09=09ret =3D -EINVAL;
+=09=09break;
+=09}
+
+=09restore =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
+=09if (restore && !ret)
+=09=09ret =3D restore;
+
+out:
+=09pm_runtime_mark_last_busy(data->dev);
+=09pm_runtime_put_autosuspend(data->dev);
+=09return ret;
+}
+
+/*
+ * qmc5883p_read_avail - expose available values to userspace.
+ *
+ * Creates the _available sysfs attributes automatically:
+ *   in_magn_sampling_frequency_available
+ *   in_magn_oversampling_ratio_available
+ *   in_magn_scale_available
+ */
+static int qmc5883p_read_avail(struct iio_dev *indio_dev,
+=09=09=09       struct iio_chan_spec const *chan,
+=09=09=09       const int **vals, int *type, int *length,
+=09=09=09       long mask)
+{
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SAMP_FREQ:
+=09=09*vals =3D qmc5883p_odr;
+=09=09*type =3D IIO_VAL_INT;
+=09=09*length =3D ARRAY_SIZE(qmc5883p_odr);
+=09=09return IIO_AVAIL_LIST;
+
+=09case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+=09=09*vals =3D qmc5883p_osr;
+=09=09*type =3D IIO_VAL_INT;
+=09=09*length =3D ARRAY_SIZE(qmc5883p_osr);
+=09=09return IIO_AVAIL_LIST;
+
+=09case IIO_CHAN_INFO_SCALE:
+=09=09*vals =3D (const int *)qmc5883p_scale;
+=09=09*type =3D IIO_VAL_FRACTIONAL;
+=09=09*length =3D ARRAY_SIZE(qmc5883p_scale) * 2;
+=09=09return IIO_AVAIL_LIST;
+
+=09default:
+=09=09return -EINVAL;
+=09}
+}
+
+static IIO_DEVICE_ATTR(downsampling_ratio, 0644, downsampling_ratio_show,
+=09=09       downsampling_ratio_store, 0);
+static IIO_CONST_ATTR(downsampling_ratio_available, "1 2 4 8");
+
+static struct attribute *qmc5883p_attributes[] =3D {
+=09&iio_dev_attr_downsampling_ratio.dev_attr.attr,
+=09&iio_const_attr_downsampling_ratio_available.dev_attr.attr, NULL
+};
+
+static const struct attribute_group qmc5883p_attribute_group =3D {
+=09.attrs =3D qmc5883p_attributes,
+};
+
+static const struct iio_info qmc5883p_info =3D {
+=09.attrs =3D &qmc5883p_attribute_group,
+=09.read_raw =3D qmc5883p_read_raw,
+=09.write_raw =3D qmc5883p_write_raw,
+=09.read_avail =3D qmc5883p_read_avail,
+};
+
+static const struct iio_chan_spec qmc5883p_channels[] =3D {
+=09{
+=09=09.type =3D IIO_MAGN,
+=09=09.channel2 =3D IIO_MOD_X,
+=09=09.modified =3D 1,
+=09=09.address =3D AXIS_X,
+=09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+=09=09=09=09      BIT(IIO_CHAN_INFO_SCALE),
+=09=09.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
+=09=09.info_mask_shared_by_type =3D
+=09=09=09BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+=09=09=09BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+=09=09.info_mask_shared_by_type_available =3D
+=09=09=09BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+=09=09=09BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+=09},
+=09{
+=09=09.type =3D IIO_MAGN,
+=09=09.channel2 =3D IIO_MOD_Y,
+=09=09.modified =3D 1,
+=09=09.address =3D AXIS_Y,
+=09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+=09=09=09=09      BIT(IIO_CHAN_INFO_SCALE),
+=09=09.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
+=09=09.info_mask_shared_by_type =3D
+=09=09=09BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+=09=09=09BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+=09=09.info_mask_shared_by_type_available =3D
+=09=09=09BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+=09=09=09BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+=09},
+=09{
+=09=09.type =3D IIO_MAGN,
+=09=09.channel2 =3D IIO_MOD_Z,
+=09=09.modified =3D 1,
+=09=09.address =3D AXIS_Z,
+=09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+=09=09=09=09      BIT(IIO_CHAN_INFO_SCALE),
+=09=09.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
+=09=09.info_mask_shared_by_type =3D
+=09=09=09BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+=09=09=09BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+=09=09.info_mask_shared_by_type_available =3D
+=09=09=09BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+=09=09=09BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+=09},
+};
+
+static void qmc5883p_runtime_pm_disable(void *dev)
+{
+=09pm_runtime_disable(dev);
+=09pm_runtime_set_suspended(dev);
+}
+
+static int qmc5883p_probe(struct i2c_client *client)
+{
+=09struct device *dev =3D &client->dev;
+=09struct qmc5883p_data *data;
+=09struct iio_dev *indio_dev;
+=09struct regmap *regmap;
+=09int ret;
+
+=09indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
+=09if (!indio_dev)
+=09=09return -ENOMEM;
+
+=09regmap =3D devm_regmap_init_i2c(client, &qmc5883p_regmap_config);
+=09if (IS_ERR(regmap))
+=09=09return dev_err_probe(dev, PTR_ERR(regmap),
+=09=09=09=09     "regmap initialization failed\n");
+
+=09data =3D iio_priv(indio_dev);
+=09data->dev =3D dev;
+=09data->regmap =3D regmap;
+=09mutex_init(&data->mutex);
+
+=09i2c_set_clientdata(client, indio_dev);
+
+=09ret =3D qmc5883p_rf_init(data);
+=09if (ret)
+=09=09return dev_err_probe(dev, ret,
+=09=09=09=09     "failed to initialize regmap fields\n");
+
+=09ret =3D qmc5883p_verify_chip_id(data);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D qmc5883p_chip_init(data);
+=09if (ret)
+=09=09return dev_err_probe(dev, ret, "failed to initialize chip\n");
+
+=09indio_dev->name =3D "qmc5883p";
+=09indio_dev->info =3D &qmc5883p_info;
+=09indio_dev->modes =3D INDIO_DIRECT_MODE;
+=09indio_dev->channels =3D qmc5883p_channels;
+=09indio_dev->num_channels =3D ARRAY_SIZE(qmc5883p_channels);
+
+=09pm_runtime_set_autosuspend_delay(dev, 2000);
+=09pm_runtime_use_autosuspend(dev);
+
+=09pm_runtime_set_active(dev);
+=09pm_runtime_enable(dev);
+
+=09ret =3D devm_add_action_or_reset(dev,
+=09=09=09=09       (void (*)(void *))qmc5883p_runtime_pm_disable,
+=09=09=09=09       dev);
+=09if (ret)
+=09=09return ret;
+
+=09pm_runtime_mark_last_busy(dev);
+
+=09ret =3D devm_iio_device_register(dev, indio_dev);
+=09if (ret)
+=09=09return dev_err_probe(dev, ret,
+=09=09=09=09     "failed to register IIO device\n");
+=09return 0;
+}
+
+static int qmc5883p_runtime_suspend(struct device *dev)
+{
+=09struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+=09struct qmc5883p_data *data =3D iio_priv(indio_dev);
+
+=09return regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
+}
+
+static int qmc5883p_runtime_resume(struct device *dev)
+{
+=09struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+=09struct qmc5883p_data *data =3D iio_priv(indio_dev);
+=09int ret;
+
+=09ret =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
+=09if (ret)
+=09=09return ret;
+
+=09usleep_range(10000, 11000);
+=09return 0;
+}
+
+static int qmc5883p_runtime_idle(struct device *dev)
+{
+=09return 0;
+}
+
+static int qmc5883p_system_suspend(struct device *dev)
+{
+=09return pm_runtime_force_suspend(dev);
+}
+
+static int qmc5883p_system_resume(struct device *dev)
+{
+=09return pm_runtime_force_resume(dev);
+}
+
+static void qmc5883p_remove(struct i2c_client *client)
+{
+=09struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+=09struct qmc5883p_data *data =3D iio_priv(indio_dev);
+
+=09/*
+=09 * Best effort: put device to sleep on removal.
+=09 * Ignore error since we cannot do anything useful with it here.
+=09 * Runtime PM disable is handled by the devm cleanup action registered
+=09 * in probe.
+=09 */
+=09regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
+}
+
+static const struct dev_pm_ops qmc5883p_dev_pm_ops =3D {
+=09SYSTEM_SLEEP_PM_OPS(qmc5883p_system_suspend, qmc5883p_system_resume)
+=09RUNTIME_PM_OPS(qmc5883p_runtime_suspend, qmc5883p_runtime_resume, NULL)
+};
+
+static const struct of_device_id qmc5883p_of_match[] =3D {
+=09{ .compatible =3D "qst,qmc5883p" },
+=09{}
+};
+MODULE_DEVICE_TABLE(of, qmc5883p_of_match);
+
+static const struct i2c_device_id qmc5883p_id[] =3D {
+=09{ "qmc5883p", 0 },
+=09{},
+};
+MODULE_DEVICE_TABLE(i2c, qmc5883p_id);
+
+static struct i2c_driver qmc5883p_driver =3D {
+=09.driver =3D {
+=09=09.name =3D "qmc5883p",
+=09=09.of_match_table =3D qmc5883p_of_match,
+=09=09.pm =3D pm_ptr(&qmc5883p_dev_pm_ops),
+=09},
+=09.probe =3D qmc5883p_probe,
+=09.remove =3D qmc5883p_remove,
+=09.id_table =3D qmc5883p_id,
+};
+module_i2c_driver(qmc5883p_driver);
+
+MODULE_AUTHOR("Hardik Phalet <hardik.phalet@pm.me>");
+MODULE_DESCRIPTION("QMC5883P magnetic sensor driver");
+MODULE_LICENSE("GPL");
--=20
2.53.0


