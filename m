Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03827299927;
	Sun, 19 Apr 2026 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776637975; cv=none; b=dLCcH1ZE3dwuIb4qKeTPxVNKfXjb1vBoh02o8RtSmr8NhdXKnuh1iZpBFeQkEAUGUl1s9teXbDIbsCm22K5K0wtnSRpvVpxqxC2w7msSd4MC9WaciQsKN0zU82TOxKHmECjf5mI+nmsh9MNA7Duusk2SWkB/g/5GIthIYuzNsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776637975; c=relaxed/simple;
	bh=RdrYI8d7MRzIOIffUkJ3BjgaLqK28C4nChlQPSFNH4Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PftIHVOaZX/2CN0nLW9Vh2Hh3Mzw2Q4u/xen3fQomyEsxZ6LvF4X8lcIRQpq3Z9twnoG1Ou+PE4pSKubFd4tSI86JX+bSHe7Wd3Yp7LgH6+iGxU6fCHCb3kxHVXhkZL5MBu3De/gqueNJR/7ZWFMyvR9QyTBUvPHBucilNSfSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=dTBD07f4; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="dTBD07f4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1776637970; x=1776897170;
	bh=gbfBHWjgij5xGXlBJPoqmjo9JkASOqq4KGyWcMZoXZ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dTBD07f4URKxmIrnl03j0/SmV+o/Jig7IN3i4MxyRU3nxlFSDSYEYLN2vPuwpQ0yE
	 20Mna+WfdFwQeKuYyH6ogvabtPbOod4INF2361PZgIw4vymEQRv/yXIirrhE5s+efJ
	 oKoM3yWaiZsOd2T2KyMrbYy1keH4MnJd1NGs9keAjsaf9KNljc4KP4msOPuSb1tMJf
	 E1Gne4rCPerneDzUxyrUnN8c9HWsMLBlSGE3cuDPC196pKed1OQy7IcwrcQ1qqgrPu
	 wvYfWA7RoupoHcfTGuf4AYq8HHmosJQeGFIOEMxzAXgPlGaJW6jJF6Bgbo+tB5UymF
	 +OWszqlO1SuPQ==
Date: Sun, 19 Apr 2026 22:32:43 +0000
To: gregkh@linuxfoundation.org, jic23@kernel.org
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, krzk+dt@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, me@brighamcampbell.com, nuno.sa@analog.com, robh@kernel.org, skhan@linuxfoundation.org, Hardik Phalet <hardik.phalet@gmail.com>, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH v3 3/5] iio: magnetometer: add driver for QST QMC5883P
Message-ID: <20260420-qmc5883p-driver-v3-3-da1e97088f8b@pm.me>
In-Reply-To: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: e9cb1788ddeec0df51519ccee696170b45a0d127
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add an IIO driver for the QST QMC5883P, a 3-axis anisotropic
magneto-resistive (AMR) magnetometer with a 16-bit ADC, communicating
over I2C. There is no existing upstream driver for this device.

The driver supports:
 - Raw magnetic field readings on X, Y and Z axes
 - Four full-scale ranges (+/-2 G, +/-8 G, +/-12 G, +/-30 G) selectable
   via IIO_CHAN_INFO_SCALE
 - Output data rate configurable via IIO_CHAN_INFO_SAMP_FREQ (10, 50,
   100, 200 Hz)
 - vdd-supply regulator management

Regmap with an rbtree cache is used throughout. CTRL_1 and CTRL_2 bit
fields are accessed via regmap_field to avoid read-modify-write races.
The STATUS register is marked precious so regmap never reads it
speculatively and clears the DRDY/OVFL bits unexpectedly.

The probe-time init sequence is: soft reset, wait 300 us for POR
completion, deassert reset, then drop the register cache so subsequent
RMW writes read fresh values from the device. After reset the chip is in
MODE_SUSPEND per datasheet =C2=A76.2.4, and is left there; the first
userspace access will wake it via runtime PM (added in a follow-up
patch).

Cleanup is fully devm-managed via devm_regulator_get_enable() and
devm_iio_device_register().

Oversampling ratio and runtime PM are added in follow-up patches.

Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
---
 MAINTAINERS                         |   1 +
 drivers/iio/magnetometer/Kconfig    |  11 +
 drivers/iio/magnetometer/Makefile   |   2 +
 drivers/iio/magnetometer/qmc5883p.c | 574 ++++++++++++++++++++++++++++++++=
++++
 4 files changed, 588 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d41f6b33d0e5..2fbbe8831a7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21559,6 +21559,7 @@ M:=09Hardik Phalet <hardik.phalet@pm.me>
 L:=09linux-iio@vger.kernel.org
 S:=09Maintained
 F:=09Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883p.y=
aml
+F:=09drivers/iio/magnetometer/qmc5883p.c
=20
 QT1010 MEDIA DRIVER
 L:=09linux-media@vger.kernel.org
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kc=
onfig
index fb313e591e85..333c5e6f231d 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -298,4 +298,15 @@ config YAMAHA_YAS530
 =09  To compile this driver as a module, choose M here: the module
 =09  will be called yamaha-yas.
=20
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
 endmenu
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/M=
akefile
index 5bd227f8c120..ff519a055d77 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -39,3 +39,5 @@ obj-$(CONFIG_SI7210)=09=09=09+=3D si7210.o
 obj-$(CONFIG_TI_TMAG5273)=09=09+=3D tmag5273.o
=20
 obj-$(CONFIG_YAMAHA_YAS530)=09=09+=3D yamaha-yas530.o
+
+obj-$(CONFIG_QMC5883P) +=3D qmc5883p.o
diff --git a/drivers/iio/magnetometer/qmc5883p.c b/drivers/iio/magnetometer=
/qmc5883p.c
new file mode 100644
index 000000000000..e4a76ae7c2cf
--- /dev/null
+++ b/drivers/iio/magnetometer/qmc5883p.c
@@ -0,0 +1,574 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * qmc5883p.c - QMC5883P magnetometer driver
+ *
+ * Copyright 2026 Hardik Phalet <hardik.phalet@pm.me>
+ *
+ * TODO: add triggered buffer support, PM, OSR, DSR
+ *
+ */
+
+#include <linux/array_size.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+#include <linux/unaligned.h>
+
+/*
+ * Register definition
+ */
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
+/*
+ * Value definition
+ */
+#define QMC5883P_MODE_SUSPEND 0x00
+#define QMC5883P_MODE_NORMAL 0x01
+#define QMC5883P_MODE_SINGLE 0x02
+#define QMC5883P_MODE_CONTINUOUS 0x03
+
+/*
+ * Output data rate
+ */
+#define QMC5883P_ODR_10 0x00
+#define QMC5883P_ODR_50 0x01
+#define QMC5883P_ODR_100 0x02
+#define QMC5883P_ODR_200 0x03
+
+/*
+ * Oversampling rate
+ */
+#define QMC5883P_OSR_8 0x00
+#define QMC5883P_OSR_4 0x01
+#define QMC5883P_OSR_2 0x02
+#define QMC5883P_OSR_1 0x03
+
+#define QMC5883P_RNG_30G 0x00
+#define QMC5883P_RNG_12G 0x01
+#define QMC5883P_RNG_08G 0x02
+#define QMC5883P_RNG_02G 0x03
+
+#define QMC5883P_DRDY_POLL_US 1000
+
+#define QMC5883P_CHIP_ID 0x80
+
+#define QMC5883P_STATUS_DRDY BIT(0)
+#define QMC5883P_STATUS_OVFL BIT(1)
+
+struct qmc5883p_rf {
+=09struct regmap_field *osr;
+=09struct regmap_field *odr;
+=09struct regmap_field *mode;
+=09struct regmap_field *rng;
+=09struct regmap_field *sftrst;
+=09struct regmap_field *chip_id;
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
+/*
+ * Scale factors in nT/LSB for IIO_VAL_INT_PLUS_NANO, derived from datashe=
et
+ * Table 2 sensitivities (LSB/G) converted to LSB/T (1 G =3D 1e-4 T):
+ *   sensitivity_T =3D sensitivity_G * 10000
+ *   scale_nT     =3D 1e9 / sensitivity_T
+ *
+ * The 8G and 2G entries truncate 26.666... and 6.666... nT/LSB respective=
ly;
+ * IIO_VAL_INT_PLUS_NANO cannot carry the exact rationals, but the chosen
+ * values match what IIO_VAL_FRACTIONAL would have rendered and therefore
+ * round-trip cleanly through sysfs write back.
+ *
+ * Index matches register value: RNG<1:0> =3D 0b00..0b11
+ */
+static const int qmc5883p_scale[][2] =3D {
+=09[QMC5883P_RNG_30G] =3D { 0, 100 },
+=09[QMC5883P_RNG_12G] =3D { 0, 40 },
+=09[QMC5883P_RNG_08G] =3D { 0, 26 },
+=09[QMC5883P_RNG_02G] =3D { 0, 6 },
+};
+
+static const int qmc5883p_odr[] =3D {
+=09[QMC5883P_ODR_10] =3D 10,
+=09[QMC5883P_ODR_50] =3D 50,
+=09[QMC5883P_ODR_100] =3D 100,
+=09[QMC5883P_ODR_200] =3D 200,
+};
+
+static const struct regmap_range qmc5883p_readable_ranges[] =3D {
+=09regmap_reg_range(QMC5883P_REG_CHIP_ID, QMC5883P_REG_Z_MSB),
+=09regmap_reg_range(QMC5883P_REG_STATUS, QMC5883P_REG_CTRL_2),
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
+=09regmap_reg_range(QMC5883P_REG_CTRL_2, QMC5883P_REG_CTRL_2),
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
+static const struct reg_field qmc5883p_rf_osr =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_1, 4, 5);
+static const struct reg_field qmc5883p_rf_odr =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_1, 2, 3);
+static const struct reg_field qmc5883p_rf_mode =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_1, 0, 1);
+static const struct reg_field qmc5883p_rf_rng =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_2, 2, 3);
+static const struct reg_field qmc5883p_rf_sftrst =3D
+=09REG_FIELD(QMC5883P_REG_CTRL_2, 7, 7);
+static const struct reg_field qmc5883p_rf_chip_id =3D
+=09REG_FIELD(QMC5883P_REG_CHIP_ID, 0, 7);
+
+/*
+ * qmc5883p_get_measure - read all three axes.
+ * Must be called with data->mutex held.
+ */
+static int qmc5883p_get_measure(struct qmc5883p_data *data, s16 *x, s16 *y=
,
+=09=09=09=09s16 *z)
+{
+=09int ret;
+=09u8 reg_data[6];
+=09unsigned int status;
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
+=09=09=09=09       QMC5883P_DRDY_POLL_US,
+=09=09=09=09       150 * (MICRO / MILLI));
+=09if (ret)
+=09=09return ret;
+
+=09if (status & QMC5883P_STATUS_OVFL) {
+=09=09dev_warn_ratelimited(data->dev,
+=09=09=09"data overflow, consider reducing field range\n");
+=09=09ret =3D -ERANGE;
+=09=09return ret;
+=09}
+
+=09ret =3D regmap_bulk_read(data->regmap, QMC5883P_REG_X_LSB, reg_data,
+=09=09=09       ARRAY_SIZE(reg_data));
+=09if (ret)
+=09=09return ret;
+
+=09*x =3D (s16)get_unaligned_le16(&reg_data[0]);
+=09*y =3D (s16)get_unaligned_le16(&reg_data[2]);
+=09*z =3D (s16)get_unaligned_le16(&reg_data[4]);
+
+=09return ret;
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
+=09=09return IIO_VAL_INT_PLUS_NANO;
+
+=09case IIO_CHAN_INFO_SAMP_FREQ:
+=09=09ret =3D regmap_field_read(data->rf.odr, &regval);
+=09=09if (ret < 0)
+=09=09=09return ret;
+=09=09*val =3D qmc5883p_odr[regval];
+=09=09return IIO_VAL_INT;
+=09}
+
+=09return -EINVAL;
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
+static int qmc5883p_write_raw(struct iio_dev *indio_dev,
+=09=09=09      struct iio_chan_spec const *chan, int val,
+=09=09=09      int val2, long mask)
+{
+=09struct qmc5883p_data *data =3D iio_priv(indio_dev);
+=09int ret, restore;
+
+=09guard(mutex)(&data->mutex);
+
+=09ret =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
+=09if (ret)
+=09=09return ret;
+
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SAMP_FREQ:
+=09=09ret =3D qmc5883p_write_odr(data, val);
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
+=09return ret;
+}
+
+/*
+ * qmc5883p_read_avail - expose available values to userspace.
+ *
+ * Creates the _available sysfs attributes automatically:
+ *   in_magn_sampling_frequency_available
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
+=09case IIO_CHAN_INFO_SCALE:
+=09=09*vals =3D (const int *)qmc5883p_scale;
+=09=09*type =3D IIO_VAL_INT_PLUS_NANO;
+=09=09*length =3D ARRAY_SIZE(qmc5883p_scale) * 2;
+=09=09return IIO_AVAIL_LIST;
+
+=09default:
+=09=09return -EINVAL;
+=09}
+}
+
+/*
+ * Tell the IIO core how to parse sysfs writes. Without this, the core
+ * defaults to IIO_VAL_INT_PLUS_MICRO (6 fractional digits), which would
+ * silently truncate nano-scale writes like "0.000000040" to 0.
+ */
+static int qmc5883p_write_raw_get_fmt(struct iio_dev *indio_dev,
+=09=09=09=09      struct iio_chan_spec const *chan,
+=09=09=09=09      long mask)
+{
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SCALE:
+=09=09return IIO_VAL_INT_PLUS_NANO;
+=09case IIO_CHAN_INFO_SAMP_FREQ:
+=09=09return IIO_VAL_INT;
+=09default:
+=09=09return -EINVAL;
+=09}
+}
+
+static const struct iio_info qmc5883p_info =3D {
+=09.read_raw =3D qmc5883p_read_raw,
+=09.write_raw =3D qmc5883p_write_raw,
+=09.write_raw_get_fmt =3D qmc5883p_write_raw_get_fmt,
+=09.read_avail =3D qmc5883p_read_avail,
+};
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
+=09rf->sftrst =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_sftrst)=
;
+=09if (IS_ERR(rf->sftrst))
+=09=09return PTR_ERR(rf->sftrst);
+
+=09rf->chip_id =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_chip_i=
d);
+=09if (IS_ERR(rf->chip_id))
+=09=09return PTR_ERR(rf->chip_id);
+
+=09return 0;
+}
+
+static int qmc5883p_read_chip_id(struct qmc5883p_data *data)
+{
+=09int ret, regval;
+
+=09ret =3D regmap_field_read(data->rf.chip_id, &regval);
+=09if (ret)
+=09=09return dev_err_probe(data->dev, ret,
+=09=09=09=09     "failed to read chip ID\n");
+
+=09if (regval !=3D QMC5883P_CHIP_ID)
+=09=09dev_info(data->dev, "unexpected chip ID %#x, expected %#x\n",
+=09=09=09regval, QMC5883P_CHIP_ID);
+
+=09return 0;
+}
+
+#define QMC5883P_CHAN(ch)                                                 =
\
+=09{                                                                 \
+=09=09.type =3D IIO_MAGN,                                         \
+=09=09.channel2 =3D IIO_MOD_##ch,                                 \
+=09=09.modified =3D 1,                                            \
+=09=09.address =3D AXIS_##ch,                                     \
+=09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |            \
+=09=09=09=09      BIT(IIO_CHAN_INFO_SCALE),           \
+=09=09.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE), \
+=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+=09=09.info_mask_shared_by_type_available =3D                     \
+=09=09=09BIT(IIO_CHAN_INFO_SAMP_FREQ),                     \
+=09}
+
+static const struct iio_chan_spec qmc5883p_channels[] =3D {
+=09QMC5883P_CHAN(X),
+=09QMC5883P_CHAN(Y),
+=09QMC5883P_CHAN(Z),
+};
+
+static int qmc5883p_chip_init(struct qmc5883p_data *data)
+{
+=09int ret;
+
+=09ret =3D regmap_field_write(data->rf.sftrst, 1);
+=09if (ret)
+=09=09return ret;
+
+=09/*
+=09 * The datasheet does not specify a post-reset delay, but POR
+=09 * completion takes up to 250 microseconds. Use 300 microseconds
+=09 * to be safe.
+=09 */
+=09fsleep(300);
+
+=09ret =3D regmap_field_write(data->rf.sftrst, 0);
+=09if (ret)
+=09=09return ret;
+
+=09/*
+=09 * Soft reset restored every register to its default. Drop the cache
+=09 * so subsequent RMW writes read fresh values from the device.
+=09 */
+=09regcache_drop_region(data->regmap, QMC5883P_REG_CHIP_ID,
+=09=09=09     QMC5883P_REG_CTRL_2);
+
+=09/* Chip is now in MODE_SUSPEND per datasheet =C2=A76.2.4. Leave it ther=
e. */
+=09return 0;
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
+=09i2c_set_clientdata(client, indio_dev);
+=09data->dev =3D dev;
+=09data->regmap =3D regmap;
+
+=09mutex_init(&data->mutex);
+
+=09ret =3D qmc5883p_rf_init(data);
+=09if (ret)
+=09=09return dev_err_probe(dev, ret,
+=09=09=09=09     "failed to initialize regmap fields\n");
+
+=09indio_dev->name =3D "qmc5883p";
+=09indio_dev->info =3D &qmc5883p_info;
+=09indio_dev->modes =3D INDIO_DIRECT_MODE;
+=09indio_dev->channels =3D qmc5883p_channels;
+=09indio_dev->num_channels =3D ARRAY_SIZE(qmc5883p_channels);
+
+=09ret =3D devm_regulator_get_enable(dev, "vdd");
+=09if (ret)
+=09=09return dev_err_probe(dev, ret,
+=09=09=09=09     "failed to initialize vdd regulator\n");
+
+=09/* Datasheet specifies up to 50 ms supply ramp + 250 us POR time. */
+=09fsleep(50 * (MICRO / MILLI) + 250);
+
+=09ret =3D qmc5883p_read_chip_id(data);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D qmc5883p_chip_init(data);
+=09if (ret)
+=09=09return dev_err_probe(dev, ret, "failed to initialize chip\n");
+
+=09return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id qmc5883p_of_match[] =3D {
+=09{ .compatible =3D "qstcorp,qmc5883p" },
+=09{ }
+};
+MODULE_DEVICE_TABLE(of, qmc5883p_of_match);
+
+static const struct i2c_device_id qmc5883p_id[] =3D {
+=09{ "qmc5883p", 0 },
+=09{ }
+};
+MODULE_DEVICE_TABLE(i2c, qmc5883p_id);
+
+static struct i2c_driver qmc5883p_driver =3D {
+=09.driver =3D {
+=09=09.name =3D "qmc5883p",
+=09=09.of_match_table =3D qmc5883p_of_match,
+=09},
+=09.probe =3D qmc5883p_probe,
+=09.id_table =3D qmc5883p_id,
+};
+module_i2c_driver(qmc5883p_driver);
+
+MODULE_AUTHOR("Hardik Phalet <hardik.phalet@pm.me>");
+MODULE_DESCRIPTION("QST QMC5883P 3-axis magnetometer driver");
+MODULE_LICENSE("GPL");

--=20
2.53.0

