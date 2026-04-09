Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C532E7162;
	Thu,  9 Apr 2026 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757316; cv=none; b=Rlqgf0ZuPUenegYTlnrXS3oBIjUM9CwCfJQvU+euBpObrJo8OeXqHfYN0bRVEI0fBlKeVWhHxYjOH3uqTO1UP4voV3VIzZP2Yfg7zfIxURfLTs81dXxSTMPDyGEEpv8lhJ9TkhigBVmqyW+HVmulOPJz4lBZWPqICutVKO6VDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757316; c=relaxed/simple;
	bh=5T/eysE6d0kqCniiWVX5XjSib3Cm4HT1jzpM91P03Kg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EN7XoTCqwJbZ89pIw1rfFCdJ4CRFCra5Jh5oEoRbR83VixgMKQIKFKHWzoMOYhbaYkphQn0mOinAXsDqmZbNm1fGg3q58qnt0Y71jCkAba8CzRmfW0KVf/yjHNi/gm597CgU41WKERNIJT5gnJE6QGaFcJIttPDyxOxrZ8NZbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PSQMUGJf; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PSQMUGJf"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775757301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5x/BjQEjIgSdd1OilAcppqxyFmWKPOh83NgoINuOcmc=;
	b=PSQMUGJfoJdLvtP/3QsdSb66uN5P5FghxzD7dX3Oa7m7t6niB5LE4lROEpoNq6C5y6jo8c
	9h1UPtSZAVsagvkw0RMvYHJM6AhTgwyZmIAH2mzstipK+4ig5uG6WCmkaf0kupub3mkvzz
	8IUbjuqHJ8POF1Ps1Gtp5UmCMtSaXp0=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Apr 2026 19:54:48 +0200
Message-Id: <DHOTF8P1AES3.1S6IAZC3X833T@linux.dev>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Brigham Campbell" <me@brighamcampbell.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-staging@lists.linux.dev>, "Luka Gejak" <luka.gejak@linux.dev>
Subject: Re: [PATCH 3/4] staging: iio: magnetometer: Add QST QMC5883P driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luka Gejak" <luka.gejak@linux.dev>
To: "Hardik Phalet" <hardik.phalet@pm.me>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
References: <20260409162308.2590385-1-hardik.phalet@pm.me>
 <20260409162308.2590385-4-hardik.phalet@pm.me>
In-Reply-To: <20260409162308.2590385-4-hardik.phalet@pm.me>
X-Migadu-Flow: FLOW_OUT

On Thu Apr 9, 2026 at 6:24 PM CEST, Hardik Phalet wrote:
> Add an IIO driver for the QST QMC5883P 3-axis magnetometer. The device
> communicates over I2C and is managed via regmap with an rbtree cache.
> Regmap fields are used to access the individual bit fields in CTRL_1 and
> CTRL_2 registers.
>
> The driver supports:
>  - Raw magnetic field readings on X, Y and Z axes
>  - Four full-scale ranges (=C2=B12 G, =C2=B18 G, =C2=B112 G, =C2=B130 G)
>  - Configurable output data rate (10, 50, 100, 200 Hz)
>  - Configurable oversampling ratio (1, 2, 4, 8)
>  - Configurable downsampling ratio (1, 2, 4, 8) via a custom sysfs attr
>  - Runtime PM with a 2 s autosuspend delay
>
> Known limitations tracked in TODO:
>  - No triggered buffer support
>  - No DRDY interrupt support
>  - Self-test register field is unused
>
> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
> ---
>  drivers/staging/iio/Kconfig                 |   1 +
>  drivers/staging/iio/Makefile                |   1 +
>  drivers/staging/iio/magnetometer/Kconfig    |  20 +
>  drivers/staging/iio/magnetometer/Makefile   |   7 +
>  drivers/staging/iio/magnetometer/TODO       |   5 +
>  drivers/staging/iio/magnetometer/qmc5883p.c | 819 ++++++++++++++++++++
>  6 files changed, 853 insertions(+)
>  create mode 100644 drivers/staging/iio/magnetometer/Kconfig
>  create mode 100644 drivers/staging/iio/magnetometer/Makefile
>  create mode 100644 drivers/staging/iio/magnetometer/TODO
>  create mode 100644 drivers/staging/iio/magnetometer/qmc5883p.c
>
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index a60631c1f449..d363e163d248 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -10,5 +10,6 @@ source "drivers/staging/iio/adc/Kconfig"
>  source "drivers/staging/iio/addac/Kconfig"
>  source "drivers/staging/iio/frequency/Kconfig"
>  source "drivers/staging/iio/impedance-analyzer/Kconfig"
> +source "drivers/staging/iio/magnetometer/Kconfig"
> =20
>  endmenu
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index 628583535393..7dcbb75d43f0 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -8,3 +8,4 @@ obj-y +=3D adc/
>  obj-y +=3D addac/
>  obj-y +=3D frequency/
>  obj-y +=3D impedance-analyzer/
> +obj-y +=3D magnetometer/
> diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/i=
io/magnetometer/Kconfig
> new file mode 100644
> index 000000000000..d631da9578a1
> --- /dev/null
> +++ b/drivers/staging/iio/magnetometer/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Magnetometer sensors
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Magnetometer sensors"
> +
> +config QMC5883P
> +	tristate "QMC5883P 3-Axis Magnetometer"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build support for QMC5883P I2C-based
> +	  3-axis magnetometer chip.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called qmc5883p.
> +
> +endmenu
> diff --git a/drivers/staging/iio/magnetometer/Makefile b/drivers/staging/=
iio/magnetometer/Makefile
> new file mode 100644
> index 000000000000..8e650f2e3b02
> --- /dev/null
> +++ b/drivers/staging/iio/magnetometer/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for staging industrial I/O Magnetometer sensor devices
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +obj-$(CONFIG_QMC5883P)	+=3D qmc5883p.o
> diff --git a/drivers/staging/iio/magnetometer/TODO b/drivers/staging/iio/=
magnetometer/TODO
> new file mode 100644
> index 000000000000..6a8084c0dded
> --- /dev/null
> +++ b/drivers/staging/iio/magnetometer/TODO
> @@ -0,0 +1,5 @@
> +TODO
> +=3D=3D=3D=3D
> +- Implement triggered buffer support (iio_triggered_buffer_setup)
> +- Add interrupt (DRDY) support
> +- Implement self-test (selftest regmap field is unused)
> diff --git a/drivers/staging/iio/magnetometer/qmc5883p.c b/drivers/stagin=
g/iio/magnetometer/qmc5883p.c
> new file mode 100644
> index 000000000000..6a71dc47efb9
> --- /dev/null
> +++ b/drivers/staging/iio/magnetometer/qmc5883p.c
> @@ -0,0 +1,819 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * qmc5883p.c - QMC5883P magnetometer driver
> + *
> + * Copyright 2026 Hardik Phalet <hardik.phalet@pm.me>
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/types.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +/* Register definition */
> +#define QMC5883P_REG_CHIP_ID 0x00
> +#define QMC5883P_REG_X_LSB 0x01
> +#define QMC5883P_REG_X_MSB 0x02
> +#define QMC5883P_REG_Y_LSB 0x03
> +#define QMC5883P_REG_Y_MSB 0x04
> +#define QMC5883P_REG_Z_LSB 0x05
> +#define QMC5883P_REG_Z_MSB 0x06
> +#define QMC5883P_REG_STATUS 0x09
> +#define QMC5883P_REG_CTRL_1 0x0A
> +#define QMC5883P_REG_CTRL_2 0x0B
> +
> +/* Value definition */
> +#define QMC5883P_MODE_SUSPEND 0x00
> +#define QMC5883P_MODE_NORMAL 0x01
> +#define QMC5883P_MODE_SINGLE 0x02
> +#define QMC5883P_MODE_CONTINUOUS 0x03
> +
> +/* Output data rate */
> +#define QMC5883P_ODR_10 0x00
> +#define QMC5883P_ODR_50 0x01
> +#define QMC5883P_ODR_100 0x02
> +#define QMC5883P_ODR_200 0x03
> +
> +/* Oversampling rate */
> +#define QMC5883P_OSR_8 0x00
> +#define QMC5883P_OSR_4 0x01
> +#define QMC5883P_OSR_2 0x02
> +#define QMC5883P_OSR_1 0x03
> +
> +/* Downsampling rate */
> +#define QMC5883P_DSR_1 0x00
> +#define QMC5883P_DSR_2 0x01
> +#define QMC5883P_DSR_4 0x02
> +#define QMC5883P_DSR_8 0x03
> +
> +#define QMC5883P_RSTCTRL_SET_RESET \
> +	0x00 /* Set and reset on, i.e. the offset of device is renewed */
> +#define QMC5883P_RSTCTRL_SET_ONLY 0x01 /* Set only on */
> +#define QMC5883P_RSTCTRL_OFF 0x02 /* Set and reset off */
> +
> +#define QMC5883P_RNG_30G 0x00
> +#define QMC5883P_RNG_12G 0x01
> +#define QMC5883P_RNG_08G 0x02
> +#define QMC5883P_RNG_02G 0x03
> +
> +#define QMC5883P_DEFAULT_ODR QMC5883P_ODR_100
> +#define QMC5883P_DEFAULT_OSR QMC5883P_OSR_4
> +#define QMC5883P_DEFAULT_DSR QMC5883P_DSR_4
> +#define QMC5883P_DEFAULT_RNG QMC5883P_RNG_08G
> +
> +#define QMC5883P_DRDY_POLL_US 1000
> +
> +#define QMC5883P_CHIP_ID 0x80
> +
> +#define QMC5883P_STATUS_DRDY BIT(0)
> +#define QMC5883P_STATUS_OVFL BIT(1)
> +
> +/*
> + * Scale factors in T/LSB for IIO_VAL_FRACTIONAL (val/val2), derived fro=
m
> + * datasheet Table 2 sensitivities (LSB/G) converted to LSB/T (1 G =3D 1=
e-4 T):
> + *   sensitivity_T =3D sensitivity_G * 10000
> + *   scale =3D 1 / sensitivity_T
> + *
> + * Index matches register value: RNG<1:0> =3D 0b00..0b11
> + */
> +static const int qmc5883p_scale[][2] =3D {
> +	[QMC5883P_RNG_30G] =3D { 1, 10000000 },
> +	[QMC5883P_RNG_12G] =3D { 1, 25000000 },
> +	[QMC5883P_RNG_08G] =3D { 1, 37500000 },
> +	[QMC5883P_RNG_02G] =3D { 1, 150000000 },
> +};
> +
> +static const int qmc5883p_odr[] =3D {
> +	[QMC5883P_ODR_10] =3D 10,
> +	[QMC5883P_ODR_50] =3D 50,
> +	[QMC5883P_ODR_100] =3D 100,
> +	[QMC5883P_ODR_200] =3D 200,
> +};
> +
> +static const int qmc5883p_osr[] =3D {
> +	[QMC5883P_OSR_1] =3D 1,
> +	[QMC5883P_OSR_2] =3D 2,
> +	[QMC5883P_OSR_4] =3D 4,
> +	[QMC5883P_OSR_8] =3D 8,
> +};
> +
> +static const unsigned int qmc5883p_dsr[] =3D {
> +	[QMC5883P_DSR_1] =3D 1,
> +	[QMC5883P_DSR_2] =3D 2,
> +	[QMC5883P_DSR_4] =3D 4,
> +	[QMC5883P_DSR_8] =3D 8,
> +};
> +
> +struct qmc5883p_rf {
> +	struct regmap_field *osr;
> +	struct regmap_field *dsr;
> +	struct regmap_field *odr;
> +	struct regmap_field *mode;
> +	struct regmap_field *rng;
> +	struct regmap_field *rstctrl;
> +	struct regmap_field *sftrst;
> +	struct regmap_field *selftest;
> +	struct regmap_field *chip_id;
> +};
> +
> +static const struct regmap_range qmc5883p_readable_ranges[] =3D {
> +	regmap_reg_range(QMC5883P_REG_CHIP_ID, QMC5883P_REG_STATUS),
> +	regmap_reg_range(QMC5883P_REG_CTRL_1, QMC5883P_REG_CTRL_2),
> +};
> +
> +static const struct regmap_range qmc5883p_writable_ranges[] =3D {
> +	regmap_reg_range(QMC5883P_REG_CTRL_1, QMC5883P_REG_CTRL_2),
> +};
> +
> +/*
> + * Volatile registers: hardware updates these independently of the drive=
r.
> + * regmap will never serve these from cache.
> + */
> +static const struct regmap_range qmc5883p_volatile_ranges[] =3D {
> +	regmap_reg_range(QMC5883P_REG_X_LSB, QMC5883P_REG_Z_MSB),
> +	regmap_reg_range(QMC5883P_REG_STATUS, QMC5883P_REG_STATUS),
> +};
> +
> +/*
> + * Precious registers: reading has a side effect (clears DRDY/OVFL bits)=
.
> + * regmap will never read these speculatively.
> + */
> +static const struct regmap_range qmc5883p_precious_ranges[] =3D {
> +	regmap_reg_range(QMC5883P_REG_STATUS, QMC5883P_REG_STATUS),
> +};
> +
> +static const struct regmap_access_table qmc5883p_readable_table =3D {
> +	.yes_ranges =3D qmc5883p_readable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(qmc5883p_readable_ranges),
> +};
> +
> +static const struct regmap_access_table qmc5883p_writable_table =3D {
> +	.yes_ranges =3D qmc5883p_writable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(qmc5883p_writable_ranges),
> +};
> +
> +static const struct regmap_access_table qmc5883p_volatile_table =3D {
> +	.yes_ranges =3D qmc5883p_volatile_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(qmc5883p_volatile_ranges),
> +};
> +
> +static const struct regmap_access_table qmc5883p_precious_table =3D {
> +	.yes_ranges =3D qmc5883p_precious_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(qmc5883p_precious_ranges),
> +};
> +
> +static const struct regmap_config qmc5883p_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D 0x0B,
> +	.cache_type =3D REGCACHE_RBTREE,
> +	.rd_table =3D &qmc5883p_readable_table,
> +	.wr_table =3D &qmc5883p_writable_table,
> +	.volatile_table =3D &qmc5883p_volatile_table,
> +	.precious_table =3D &qmc5883p_precious_table,
> +};
> +
> +struct qmc5883p_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct mutex mutex; /* protects regmap and rf field accesses */
> +	struct qmc5883p_rf rf;
> +};
> +
> +enum qmc5883p_channels {
> +	AXIS_X =3D 0,
> +	AXIS_Y,
> +	AXIS_Z,
> +};
> +
> +static const struct reg_field qmc5883p_rf_osr =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 4, 5);
> +static const struct reg_field qmc5883p_rf_dsr =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 6, 7);
> +static const struct reg_field qmc5883p_rf_odr =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 2, 3);
> +static const struct reg_field qmc5883p_rf_mode =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 0, 1);
> +static const struct reg_field qmc5883p_rf_rng =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_2, 2, 3);
> +static const struct reg_field qmc5883p_rf_rstctrl =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_2, 0, 1);
> +static const struct reg_field qmc5883p_rf_sftrst =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_2, 7, 7);
> +static const struct reg_field qmc5883p_rf_selftest =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_2, 6, 6);
> +static const struct reg_field qmc5883p_rf_chip_id =3D
> +	REG_FIELD(QMC5883P_REG_CHIP_ID, 0, 7);
> +
> +static int qmc5883p_rf_init(struct qmc5883p_data *data)
> +{
> +	struct regmap *regmap =3D data->regmap;
> +	struct device *dev =3D data->dev;
> +	struct qmc5883p_rf *rf =3D &data->rf;
> +
> +	rf->osr =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_osr);
> +	if (IS_ERR(rf->osr))
> +		return PTR_ERR(rf->osr);
> +
> +	rf->dsr =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_dsr);
> +	if (IS_ERR(rf->dsr))
> +		return PTR_ERR(rf->dsr);
> +
> +	rf->odr =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_odr);
> +	if (IS_ERR(rf->odr))
> +		return PTR_ERR(rf->odr);
> +
> +	rf->mode =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_mode);
> +	if (IS_ERR(rf->mode))
> +		return PTR_ERR(rf->mode);
> +
> +	rf->rng =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_rng);
> +	if (IS_ERR(rf->rng))
> +		return PTR_ERR(rf->rng);
> +
> +	rf->rstctrl =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_rstctr=
l);
> +	if (IS_ERR(rf->rstctrl))
> +		return PTR_ERR(rf->rstctrl);
> +
> +	rf->sftrst =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_sftrst)=
;
> +	if (IS_ERR(rf->sftrst))
> +		return PTR_ERR(rf->sftrst);
> +
> +	rf->selftest =3D
> +		devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_selftest);
> +	if (IS_ERR(rf->selftest))
> +		return PTR_ERR(rf->selftest);
> +
> +	rf->chip_id =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_chip_i=
d);
> +	if (IS_ERR(rf->chip_id))
> +		return PTR_ERR(rf->chip_id);
> +
> +	return 0;
> +}
> +
> +static int qmc5883p_verify_chip_id(struct qmc5883p_data *data)
> +{
> +	int ret, regval;
> +
> +	ret =3D regmap_field_read(data->rf.chip_id, &regval);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "failed to read chip ID\n");
> +
> +	if (regval !=3D QMC5883P_CHIP_ID)
> +		return dev_err_probe(data->dev, -ENODEV,
> +				     "unexpected chip ID 0x%02x, expected 0x%02x\n",
> +				     regval, QMC5883P_CHIP_ID);
> +	return ret;
> +}
> +
> +static int qmc5883p_chip_init(struct qmc5883p_data *data)
> +{
> +	int ret;
> +
> +	ret =3D regmap_field_write(data->rf.sftrst, 1);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 2000);
> +
> +	ret =3D regmap_field_write(data->rf.sftrst, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_field_write(data->rf.rstctrl, QMC5883P_RSTCTRL_SET_RESET=
);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_field_write(data->rf.rng, QMC5883P_DEFAULT_RNG);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_field_write(data->rf.osr, QMC5883P_DEFAULT_OSR);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_field_write(data->rf.dsr, QMC5883P_DEFAULT_DSR);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_field_write(data->rf.odr, QMC5883P_DEFAULT_ODR);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
> +}
> +
> +/*
> + * qmc5883p_get_measure - read all three axes.
> + * Must be called with data->mutex held.
> + * Handles PM internally: resumes device, reads data, schedules autosusp=
end.
> + */
> +static int qmc5883p_get_measure(struct qmc5883p_data *data, s16 *x, s16 =
*y,
> +				s16 *z)
> +{

...

> +
> +	*x =3D (s16)((reg_data[1] << 8) | reg_data[0]);
> +	*y =3D (s16)((reg_data[3] << 8) | reg_data[2]);
> +	*z =3D (s16)((reg_data[5] << 8) | reg_data[4]);
> +

While functionally correct, the standard kernel idiom for deserializing=20
contiguous byte arrays is to use the unaligned access helpers. Consider=20
including <linux/unaligned.h> at the top of the file and using=20
get_unaligned_le16(). Also since it returns a u16, you must keep the=20
(s16) cast. Something like:
*x =3D (s16)get_unaligned_le16(&reg_data[0]);
*y =3D (s16)get_unaligned_le16(&reg_data[2]);
*z =3D (s16)get_unaligned_le16(&reg_data[4]);

> +out:
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +	return ret;
> +}
> +
> +static int qmc5883p_write_scale(struct qmc5883p_data *data, int val, int=
 val2)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(qmc5883p_scale); i++) {
> +		if (qmc5883p_scale[i][0] =3D=3D val && qmc5883p_scale[i][1] =3D=3D val=
2)
> +			return regmap_field_write(data->rf.rng, i);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int qmc5883p_write_odr(struct qmc5883p_data *data, int val)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(qmc5883p_odr); i++) {
> +		if (qmc5883p_odr[i] =3D=3D val)
> +			return regmap_field_write(data->rf.odr, i);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int qmc5883p_write_osr(struct qmc5883p_data *data, int val)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(qmc5883p_osr); i++) {
> +		if (qmc5883p_osr[i] =3D=3D val)
> +			return regmap_field_write(data->rf.osr, i);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t downsampling_ratio_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct qmc5883p_data *data =3D iio_priv(indio_dev);
> +	unsigned int regval;
> +	int ret;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	ret =3D regmap_field_read(data->rf.dsr, &regval);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", qmc5883p_dsr[regval]);
> +}
> +
> +static ssize_t downsampling_ratio_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{

...

> +	guard(mutex)(&data->mutex);
> +
> +	ret =3D pm_runtime_resume_and_get(dev);

For iio sysfs attributes, the dev pointer belongs to the iio device=20
(&indio_dev->dev), not the i2c parent device where runtime pm was=20
initialized. Calling pm operations on the iio device will lead to pm=20
refcount imbalances and potential kernel warnings. You should use=20
data->dev for all pm_runtime_* calls inside custom sysfs callbacks.=20
Something like ret =3D pm_runtime_resume_and_get(data->dev);

> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D -EINVAL;
> +	for (i =3D 0; i < ARRAY_SIZE(qmc5883p_dsr); i++) {
> +		if (qmc5883p_dsr[i] =3D=3D val) {
> +			ret =3D regmap_field_write(data->rf.dsr, i);
> +			break;
> +		}
> +	}
> +
> +	restore =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
> +	if (restore && !ret)
> +		ret =3D restore;
> +
> +out:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);

You should change these to use data->dev as well.

> +	return ret ? ret : (ssize_t)len;
> +}
> +
> +static int qmc5883p_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	s16 x, y, z;
> +	struct qmc5883p_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +	unsigned int regval;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D qmc5883p_get_measure(data, &x, &y, &z);
> +		if (ret < 0)
> +			return ret;
> +		switch (chan->address) {
> +		case AXIS_X:
> +			*val =3D x;
> +			break;
> +		case AXIS_Y:
> +			*val =3D y;
> +			break;
> +		case AXIS_Z:
> +			*val =3D z;
> +			break;
> +		}
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret =3D regmap_field_read(data->rf.rng, &regval);
> +		if (ret < 0)
> +			return ret;
> +		*val =3D qmc5883p_scale[regval][0];
> +		*val2 =3D qmc5883p_scale[regval][1];
> +		return IIO_VAL_FRACTIONAL;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D regmap_field_read(data->rf.odr, &regval);
> +		if (ret < 0)
> +			return ret;
> +		*val =3D qmc5883p_odr[regval];
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret =3D regmap_field_read(data->rf.osr, &regval);
> +		if (ret < 0)
> +			return ret;
> +		*val =3D qmc5883p_osr[regval];
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int qmc5883p_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct qmc5883p_data *data =3D iio_priv(indio_dev);
> +	int ret, restore;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	ret =3D pm_runtime_resume_and_get(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
> +	if (ret)
> +		goto out;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D qmc5883p_write_odr(data, val);
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret =3D qmc5883p_write_osr(data, val);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret =3D qmc5883p_write_scale(data, val, val2);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	restore =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
> +	if (restore && !ret)
> +		ret =3D restore;
> +
> +out:
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +	return ret;
> +}
> +
> +/*
> + * qmc5883p_read_avail - expose available values to userspace.
> + *
> + * Creates the _available sysfs attributes automatically:
> + *   in_magn_sampling_frequency_available
> + *   in_magn_oversampling_ratio_available
> + *   in_magn_scale_available
> + */
> +static int qmc5883p_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals =3D qmc5883p_odr;
> +		*type =3D IIO_VAL_INT;
> +		*length =3D ARRAY_SIZE(qmc5883p_odr);
> +		return IIO_AVAIL_LIST;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals =3D qmc5883p_osr;
> +		*type =3D IIO_VAL_INT;
> +		*length =3D ARRAY_SIZE(qmc5883p_osr);
> +		return IIO_AVAIL_LIST;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals =3D (const int *)qmc5883p_scale;
> +		*type =3D IIO_VAL_FRACTIONAL;
> +		*length =3D ARRAY_SIZE(qmc5883p_scale) * 2;
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static IIO_DEVICE_ATTR(downsampling_ratio, 0644, downsampling_ratio_show=
,
> +		       downsampling_ratio_store, 0);
> +static IIO_CONST_ATTR(downsampling_ratio_available, "1 2 4 8");
> +
> +static struct attribute *qmc5883p_attributes[] =3D {
> +	&iio_dev_attr_downsampling_ratio.dev_attr.attr,
> +	&iio_const_attr_downsampling_ratio_available.dev_attr.attr, NULL
> +};
> +
> +static const struct attribute_group qmc5883p_attribute_group =3D {
> +	.attrs =3D qmc5883p_attributes,
> +};
> +
> +static const struct iio_info qmc5883p_info =3D {
> +	.attrs =3D &qmc5883p_attribute_group,
> +	.read_raw =3D qmc5883p_read_raw,
> +	.write_raw =3D qmc5883p_write_raw,
> +	.read_avail =3D qmc5883p_read_avail,
> +};
> +
> +static const struct iio_chan_spec qmc5883p_channels[] =3D {
> +	{
> +		.type =3D IIO_MAGN,
> +		.channel2 =3D IIO_MOD_X,
> +		.modified =3D 1,
> +		.address =3D AXIS_X,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type =3D
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_type_available =3D
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +	{
> +		.type =3D IIO_MAGN,
> +		.channel2 =3D IIO_MOD_Y,
> +		.modified =3D 1,
> +		.address =3D AXIS_Y,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type =3D
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_type_available =3D
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +	{
> +		.type =3D IIO_MAGN,
> +		.channel2 =3D IIO_MOD_Z,
> +		.modified =3D 1,
> +		.address =3D AXIS_Z,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type =3D
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_type_available =3D
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +};
> +
> +static void qmc5883p_runtime_pm_disable(void *dev)
> +{
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +}
> +
> +static int qmc5883p_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;

Your dt-binding correctly documents an optional vdd-supply for the=20
2.5V-3.6V rail, but the driver never parses or enables it. If a board=20
physically powers down this regulator during system suspend or relies on
the driver to enable it at boot, the driver will fail. Please add=20
devm_regulator_get_optional() and enable the regulator here. Also, you=20
should ensure that your system resume callbacks correctly re-apply the=20
chip's initialization sequence if power is lost during suspend.

> +	struct qmc5883p_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap =3D devm_regmap_init_i2c(client, &qmc5883p_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "regmap initialization failed\n");
> +
> +	data =3D iio_priv(indio_dev);
> +	data->dev =3D dev;
> +	data->regmap =3D regmap;
> +	mutex_init(&data->mutex);
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret =3D qmc5883p_rf_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to initialize regmap fields\n");
> +
> +	ret =3D qmc5883p_verify_chip_id(data);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D qmc5883p_chip_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize chip\n");
> +
> +	indio_dev->name =3D "qmc5883p";
> +	indio_dev->info =3D &qmc5883p_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D qmc5883p_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(qmc5883p_channels);
> +
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	ret =3D devm_add_action_or_reset(dev,
> +				       (void (*)(void *))qmc5883p_runtime_pm_disable,
> +				       dev);

Casting function pointers like (void (*)(void *)) violates strict kcfi=20
checks, which will cause a kernel panic on modern architectures=20
(like arm64) compiled with cfi enabled. The pm core already provides a=20
safe helper for this. Plese drop your custom qmc5883p_runtime_pm_disable
function and the devm_add_action_or_reset call, and simply use=20
ret =3D devm_pm_runtime_enable(dev);

> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_mark_last_busy(dev);
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);

Because you use devm_iio_device_register(), the iio interface is=20
unregistered automatically during the devres unwinding phase, which=20
happens after your .remove() callback completes. This creates a race=20
window. A concurrent userspace sysfs read/write could trigger a pm=20
resume exactly while or after remove() is putting the chip to sleep. To=20
fix this, create a custom devm action (via devm_add_action_or_reset) to=20
write QMC5883P_MODE_SUSPEND to the chip, and register it before this=20
devm_iio_device_register() call. Because devres unwinds in lifo order,=20
this guarantees the iio interface is fully unregistered before the=20
hardware is suspended.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register IIO device\n");
> +	return 0;
> +}
> +
> +static int qmc5883p_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct qmc5883p_data *data =3D iio_priv(indio_dev);
> +
> +	return regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
> +}
> +
> +static int qmc5883p_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct qmc5883p_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(10000, 11000);
> +	return 0;
> +}
> +
> +static int qmc5883p_runtime_idle(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int qmc5883p_system_suspend(struct device *dev)
> +{
> +	return pm_runtime_force_suspend(dev);
> +}
> +
> +static int qmc5883p_system_resume(struct device *dev)
> +{
> +	return pm_runtime_force_resume(dev);
> +}
> +
> +static void qmc5883p_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> +	struct qmc5883p_data *data =3D iio_priv(indio_dev);
> +
> +	/*
> +	 * Best effort: put device to sleep on removal.
> +	 * Ignore error since we cannot do anything useful with it here.
> +	 * Runtime PM disable is handled by the devm cleanup action registered
> +	 * in probe.
> +	 */
> +	regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
> +}

Once you move the suspend logic into a devm action in probe() (as=20
mentioned above), you can delete this qmc5883p_remove() function and the
.remove hook in the i2c_driver struct entirely.

> +
> +static const struct dev_pm_ops qmc5883p_dev_pm_ops =3D {
> +	SYSTEM_SLEEP_PM_OPS(qmc5883p_system_suspend, qmc5883p_system_resume)
> +	RUNTIME_PM_OPS(qmc5883p_runtime_suspend, qmc5883p_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id qmc5883p_of_match[] =3D {
> +	{ .compatible =3D "qst,qmc5883p" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qmc5883p_of_match);
> +
> +static const struct i2c_device_id qmc5883p_id[] =3D {
> +	{ "qmc5883p", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, qmc5883p_id);
> +
> +static struct i2c_driver qmc5883p_driver =3D {
> +	.driver =3D {
> +		.name =3D "qmc5883p",
> +		.of_match_table =3D qmc5883p_of_match,
> +		.pm =3D pm_ptr(&qmc5883p_dev_pm_ops),
> +	},
> +	.probe =3D qmc5883p_probe,
> +	.remove =3D qmc5883p_remove,
> +	.id_table =3D qmc5883p_id,
> +};
> +module_i2c_driver(qmc5883p_driver);
> +
> +MODULE_AUTHOR("Hardik Phalet <hardik.phalet@pm.me>");
> +MODULE_DESCRIPTION("QMC5883P magnetic sensor driver");
> +MODULE_LICENSE("GPL");

