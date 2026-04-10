Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE537D10B
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851330; cv=none; b=nYnaxai+i4DK/kUqdMGfEtGli0aWTX6x9xFcuqgAZammz41dtlqaA3QthehXDtk0bBuaofwyZA7e6vB59V2vCL95mTurFFNZVwIm0jGO2amCAP4I8crNpLHsVsvPlvd9dKhcMsn/vPc4OVWvjH3mxDeodKjdWK0BB9elKV5uEx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851330; c=relaxed/simple;
	bh=RvZ3YAoUNhixzuGTARY+FiRjGRME/8jkDwSdLXXRiSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkHc22sYd2MNVDMLSIOj85gHtML4+mt3slH/k/GUyzluFqKdGzyO9o8dWt8CUE7MC+u8t88Il9vnvhUIrs4AVhKWZQi5Xidyy8UG6/B44ACnJRFhTd1KR9i1y7yg9P6dYQuXS/odAnmyeTqryKC4UDtOHlQw5jV/v77t0AS0imA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=HaanGteV; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="HaanGteV"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d86eb7c854so1263517a34.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775851326; x=1776456126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEWPEFhAKbhq2RkfJmTCRrcM+bspd2z8dvhELvCegP0=;
        b=HaanGteVAcqz5dcpJvxPyV9nAXyuw8TgoIK2KPiTJ4sQZqd+3vnngCFDDQGLZfBIdk
         mWDogetnZkr4OHn0kto8SRKYXfxjNxOEetK+2kPQFAy/J+Aixu7fIGFfd4TBf3+ivmoW
         iQYvktH24EMldeKc/RWS4BAq7ZN88aTuzMdyClSwOTfeUY1uklaIanwfU6o/Ga5z969a
         zhv46IaTlkDhQXBBTm2MEmNQi4KkSMJ51z5eXa1VCoM9pPPfBmTgLgfmDVt19QREnjzg
         cCuKXpkp5UEMIBleOdsaUaaw14ij16agAkzWKzoGdaf9iAQL/VqNRvpVQ0a+5RYs7uO0
         61hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775851326; x=1776456126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEWPEFhAKbhq2RkfJmTCRrcM+bspd2z8dvhELvCegP0=;
        b=SQS4HEjyhJ86IYWukjWeatCyPEokMRD+y2GMoEbVDKEVmL5o2rgu8LhcX9/YOqrqHA
         RVmLrMQv+e8Vbff/A8GmFrKP6cLCo14kaFE1w5qibwxNliRdH/Z5KR9f7U74JkXJuTJC
         Yo2GrMQ6Wz5ARH7P7gOXcUeoU2eCd5sBGAo3wqsfDXb6wJPnF6Q36rd8d3kMQ0GImKg8
         2yYQ3XOPmgBAOLe3H2Qp0bFfkUfFiEmdMZ2e6CtF0m5SIlxPYzhQTQap2vW2X5b/bxmR
         AUZdIiu6319zwbtLoQ8cqhUZXXeuJz+/ddGf6LMYHp2wNEOK3SuwZvhNC2gzipvtj9xx
         6E2g==
X-Forwarded-Encrypted: i=1; AJvYcCVs9EmCjbsfWNj+CLMPzV87SkF1UKxwnf60eTkcPzTWWfoRGZPheRR+lyYYbntFeCclGnf8k+0Eils=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHlDSVO5H8UUauC1Z0stTXI53xE4Mu2an47YrYyhAHx3K4D1v
	g5ScO0tzmHGTRxHXOVWPKNLSpukakMWJf/kcn+z3R1ltpva5N5MmAqtjmAzMi+G+Frw=
X-Gm-Gg: AeBDievre8WM5RNzWqdFs3ojJJ/+VsIGkJwhoxRmCew2Oyim1SBPPpFekQPXeZxX1rB
	v9Qb0DLvTvMn0a9MX5ipwBAq6qpjdrJui30Ko23qMMs8RmLX8QRuWvzdje4wnMueCCwhu+xvE4C
	ufsItIMmxAu1390GDecaZ5x62Lrf/L7mbG4bK3mEBMhbdopRQ/BJxJiJDgNMVJdz6jtsbDD5bEl
	ZXeqK47Sma+JnsaWuEkmBzQZljgCjRX/3qLmIHl0ChuqVmW219OE2r++505EsYIufN6E0wOSN1i
	TtmFsloSoFA8t5sJa5C7dyF+kf8e1tkd0FVEm4220AvooczIRN/QjjsUEXKYSVFBK+teX98davx
	8N28++sNYgXXkqDWlMNanxHwzn0s63IL20rK4ghLJB/Hw29t5pytR4bIA9EWuevrN4kjUCfaUsx
	VUW8v9+XwLmgUNCbRewIzmxviRG3Nfv/JrsD1OrGKxBktQfkUg8mwVwq0WuptFfDRReycjWDppA
	w==
X-Received: by 2002:a05:6830:b83:b0:7d7:faad:e35d with SMTP id 46e09a7af769-7dc27db33acmr3084744a34.14.1775851325614;
        Fri, 10 Apr 2026 13:02:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26905041sm2644467a34.14.2026.04.10.13.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 13:02:05 -0700 (PDT)
Message-ID: <736964f9-1e93-47e7-80ca-1a89f239a353@baylibre.com>
Date: Fri, 10 Apr 2026 15:02:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] staging: iio: magnetometer: Add QST QMC5883P
 driver
To: Hardik Phalet <hardik.phalet@pm.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Brigham Campbell
 <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20260409210639.3197576-1-hardik.phalet@pm.me>
 <20260409210639.3197576-4-hardik.phalet@pm.me>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260409210639.3197576-4-hardik.phalet@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/26 4:07 PM, Hardik Phalet wrote:
> Add an IIO driver for the QST QMC5883P, a 3-axis anisotropic
> magneto-resistive (AMR) magnetometer with a 16-bit ADC, communicating
> over I2C. There is no existing upstream driver for this device.
> 
> The driver supports:
>  - Raw magnetic field readings on X, Y, and Z axes
>  - Four full-scale ranges (+/-2 G, +/-8 G, +/-12 G, +/-30 G)
>  - Configurable output data rate (10, 50, 100, 200 Hz)
>  - Configurable oversampling ratio (1, 2, 4, 8)
>  - Configurable downsampling ratio (1, 2, 4, 8) via a custom sysfs
>    attribute
>  - Optional vdd-supply regulator management
>  - Runtime PM with a 2 s autosuspend delay
>  - System suspend/resume with full chip reinitialisation and regmap
>    cache resync to handle regulator power-loss

This is a little bit much to review all in one patch. Could be nice
to split out power management to a separate patch.

Oversampling/downsampling could be split to a separate patch or two
as well.

> 
> Regmap with an rbtree cache is used throughout. CTRL_1 and CTRL_2
> bit fields are accessed via regmap_field to avoid read-modify-write
> races. The STATUS register is marked precious so regmap never reads
> it speculatively and clears the DRDY/OVFL bits unexpectedly.
> 
> 
> The probe-time init sequence is: soft reset, wait 1 ms, deassert
> reset, configure SET/RESET control, apply default ODR/OSR/DSR/RNG,
> enter normal mode. This ordering was determined empirically on
> hardware to produce reliable, non-zero axis readings.
> 
> Cleanup is fully devm-managed: devm_pm_runtime_enable() handles
> runtime PM teardown, and a devm action registered before
> devm_iio_device_register() puts the chip to sleep on removal,
> ensuring the IIO interface is unregistered before the hardware is
> suspended.
> 
> The driver is placed under drivers/staging/iio/magnetometer/ with a
> TODO file tracking the remaining work before it can graduate:
>  - Triggered buffer support (iio_triggered_buffer_setup)
>  - DRDY interrupt support
>  - Self-test implementation
> 
> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
> ---
>  drivers/staging/iio/Kconfig                 |   1 +
>  drivers/staging/iio/Makefile                |   1 +
>  drivers/staging/iio/magnetometer/Kconfig    |  20 +
>  drivers/st
> aging/iio/magnetometer/Makefile   |   7 +
>  drivers/staging/iio/magnetometer/TODO       |   5 +
>  drivers/staging/iio/magnetometer/qmc5883p.c | 830 ++++++++++++++++++++
>  6 files changed, 864 insertions(+)
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
>  
>  endmenu
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index 62
> 8583535393..7dcbb75d43f0 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -8,3 +8,4 @@ obj-y += adc/
>  obj-y += addac/
>  obj-y += frequency/
>  obj-y += impedance-analyzer/
> +obj-y += magnetometer/
> diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio/magnetometer/Kconfig
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
> diff --git a/drivers/staging/iio/magnetometer/Ma
> kefile b/drivers/staging/iio/magnetometer/Makefile
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
> +obj-$(CONFIG_QMC5883P)	+= qmc5883p.o
> diff --git a/drivers/staging/iio/magnetometer/TODO b/drivers/staging/iio/magnetometer/TODO
> new file mode 100644
> index 000000000000..6a8084c0dded
> --- /dev/null
> +++ b/drivers/staging/iio/magnetometer/TODO
> @@ -0,0 +1,5 @@
> +TODO
> +====
> +- Implement triggered buffer support (iio_triggered_buffer_setup)
> +- Add interrupt (DRDY) support
> +- Implement self-test (selftest regmap field is unused)
> diff --git a/drivers/staging/iio/magnetometer/qmc5883p.c b/drivers/staging/iio/magnetometer/qmc5883p.c
> new file mode 100644
> index 000000000000..d9758f1e0f4d
> --- /dev/null
> +++ b/drivers/
> staging/iio/magnetometer/qmc5883p.c
> @@ -0,0 +1,830 @@
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
> +#include <linux/regulator/consumer.h>
> +#include <linux/unaligned.h>
> +
> +/* Register definition */
> +#define QMC5883P_REG_CHIP_ID 0x00
> +#define QMC5883P_REG_X_LSB 0x01
> +#define QMC5883P_REG_X_MSB 0x02
> +#define QMC5883P_REG_Y_LSB 0x03
> +#define QMC5883P_REG_Y_MSB 0x04
> +#define QMC58
> 83P_REG_Z_LSB 0x05

Were you manually editing the patch?

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
> +#define QMC5883P_RSTCTRL_OFF 0x02 /* Set 
> and reset off */

Or maybe you mail client mangled the patch? These wraps are
happening in many places.

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
> + * Scale factors in T/LSB for IIO_VAL_FRACTIONAL (val/val2), derived from
> + * datasheet Table 2 sensitivities (LSB/G) converted to LSB/T (1 G = 1e-4 T):
> + *   sensitivity_T = sensitivity_G * 10000
> + *   scale = 1 / sensitivity_T
> + *
> + * Index matches register value: RNG<1:0> = 0b00..0b11
> + */
> +static const int qmc5883p_scale[][2] = {
> +	[QMC5883P_RNG_30G] = { 1, 10000000 },
> +	[QMC5883P_RNG_12G] = { 1, 25000000 },
> +	[QMC5883P_RNG_08G] = { 1, 37500000 },
> +	[QMC5883P_RNG_02G] = { 1, 15
> 0000000 },
> +};
> +
> +static const int qmc5883p_odr[] = {
> +	[QMC5883P_ODR_10] = 10,
> +	[QMC5883P_ODR_50] = 50,
> +	[QMC5883P_ODR_100] = 100,
> +	[QMC5883P_ODR_200] = 200,
> +};
> +
> +static const int qmc5883p_osr[] = {
> +	[QMC5883P_OSR_1] = 1,
> +	[QMC5883P_OSR_2] = 2,
> +	[QMC5883P_OSR_4] = 4,
> +	[QMC5883P_OSR_8] = 8,
> +};
> +
> +static const unsigned int qmc5883p_dsr[] = {
> +	[QMC5883P_DSR_1] = 1,
> +	[QMC5883P_DSR_2] = 2,
> +	[QMC5883P_DSR_4] = 4,
> +	[QMC5883P_DSR_8] = 8,
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
> +static const struct regmap_range qmc5883p_readable_ranges[] = {
> +	regmap_reg_range(QMC5883P_REG_CHIP_ID, QMC5883P_REG_STATUS),
> +	regmap_reg_range(QMC5883P_REG_CTRL_1, QMC5883P_REG_CTRL_2),
> +};
> +
> +static con
> st struct regmap_range qmc5883p_writable_ranges[] = {
> +	regmap_reg_range(QMC5883P_REG_CTRL_1, QMC5883P_REG_CTRL_2),
> +};
> +
> +/*
> + * Volatile registers: hardware updates these independently of the driver.
> + * regmap will never serve these from cache.
> + */
> +static const struct regmap_range qmc5883p_volatile_ranges[] = {
> +	regmap_reg_range(QMC5883P_REG_X_LSB, QMC5883P_REG_Z_MSB),
> +	regmap_reg_range(QMC5883P_REG_STATUS, QMC5883P_REG_STATUS),
> +};
> +
> +/*
> + * Precious registers: reading has a side effect (clears DRDY/OVFL bits).
> + * regmap will never read these speculatively.
> + */
> +static const struct regmap_range qmc5883p_precious_ranges[] = {
> +	regmap_reg_range(QMC5883P_REG_STATUS, QMC5883P_REG_STATUS),
> +};
> +
> +static const struct regmap_access_table qmc5883p_readable_table = {
> +	.yes_ranges = qmc5883p_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(qmc5883p_readable_ranges),
> +};
> +
> +static const struct regmap_access_table qmc5883p_writable_table = {
> +	.yes_ranges = qmc5
> 883p_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(qmc5883p_writable_ranges),
> +};
> +
> +static const struct regmap_access_table qmc5883p_volatile_table = {
> +	.yes_ranges = qmc5883p_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(qmc5883p_volatile_ranges),
> +};
> +
> +static const struct regmap_access_table qmc5883p_precious_table = {
> +	.yes_ranges = qmc5883p_precious_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(qmc5883p_precious_ranges),
> +};
> +
> +static const struct regmap_config qmc5883p_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x0B,
> +	.cache_type = REGCACHE_RBTREE,
> +	.rd_table = &qmc5883p_readable_table,
> +	.wr_table = &qmc5883p_writable_table,
> +	.volatile_table = &qmc5883p_volatile_table,
> +	.precious_table = &qmc5883p_precious_table,
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
> +	AXIS_X = 0
> ,
> +	AXIS_Y,
> +	AXIS_Z,
> +};
> +
> +static const struct reg_field qmc5883p_rf_osr =
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 4, 5);
> +static const struct reg_field qmc5883p_rf_dsr =
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 6, 7);
> +static const struct reg_field qmc5883p_rf_odr =
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 2, 3);
> +static const struct reg_field qmc5883p_rf_mode =
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 0, 1);
> +static const struct reg_field qmc5883p_rf_rng =
> +	REG_FIELD(QMC5883P_REG_CTRL_2, 2, 3);
> +static const struct reg_field qmc5883p_rf_rstctrl =
> +	REG_FIELD(QMC5883P_REG_CTRL_2, 0, 1);
> +static const struct reg_field qmc5883p_rf_sftrst =
> +	REG_FIELD(QMC5883P_REG_CTRL_2, 7, 7);
> +static const struct reg_field qmc5883p_rf_selftest =
> +	REG_FIELD(QMC5883P_REG_CTRL_2, 6, 6);
> +static const struct reg_field qmc5883p_rf_chip_id =
> +	REG_FIELD(QMC5883P_REG_CHIP_ID, 0, 7);
> +
> +static int qmc5883p_rf_init(struct qmc5883p_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = d
> ata->dev;
> +	struct qmc5883p_rf *rf = &data->rf;
> +
> +	rf->osr = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_osr);
> +	if (IS_ERR(rf->osr))
> +		return PTR_ERR(rf->osr);
> +
> +	rf->dsr = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_dsr);
> +	if (IS_ERR(rf->dsr))
> +		return PTR_ERR(rf->dsr);
> +
> +	rf->odr = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_odr);
> +	if (IS_ERR(rf->odr))
> +		return PTR_ERR(rf->odr);
> +
> +	rf->mode = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_mode);
> +	if (IS_ERR(rf->mode))
> +		return PTR_ERR(rf->mode);
> +
> +	rf->rng = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_rng);
> +	if (IS_ERR(rf->rng))
> +		return PTR_ERR(rf->rng);
> +
> +	rf->rstctrl = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_rstctrl);
> +	if (IS_ERR(rf->rstctrl))
> +		return PTR_ERR(rf->rstctrl);
> +
> +	rf->sftrst = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_sftrst);
> +	if (IS_ERR(rf->sftrst))
> +		return PTR_ERR(rf->sftrst);
> +
> +	rf->selftest =
> +		devm_regmap_field_alloc(de
> v, regmap, qmc5883p_rf_selftest);
> +	if (IS_ERR(rf->selftest))
> +		return PTR_ERR(rf->selftest);
> +
> +	rf->chip_id = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_chip_id);
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
> +	ret = regmap_field_read(data->rf.chip_id, &regval);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "failed to read chip ID\n");
> +
> +	if (regval != QMC5883P_CHIP_ID)
> +		return dev_err_probe(data->dev, -ENODEV,

We don't consider ID match an error. It has happened too many times
that there is a compatible part with a different ID. This can just
be dev_info() and return success.

> +				     "unexpected chip ID 0x%02x, expected 0x%02x\n",
> +				     regval, QMC5883P_CHIP_ID);
> +	return ret;
> +}
> +
> +static int qmc5883p_chip_init(struct qmc5883p_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_field_write(data->rf.sftrst, 1);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 2000);

Use fsleep() instead and add a comment explaining why this specific duration
was selected.

> +
> +	ret = regmap_field_write(data->rf.sftrst, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_write
> (data->rf.rstctrl, QMC5883P_RSTCTRL_SET_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_write(data->rf.rng, QMC5883P_DEFAULT_RNG);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_write(data->rf.osr, QMC5883P_DEFAULT_OSR);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_write(data->rf.dsr, QMC5883P_DEFAULT_DSR);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_write(data->rf.odr, QMC5883P_DEFAULT_ODR);
> +	if (ret)
> +		return ret;

Since we just reset the chip, why do we need to set everything to a
new default instead of using the chip's default? If there is a good
reason, add a comment, otherwise we can leave this out.

> +
> +	return regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);

Does this start sampling? Seems like it could be out of place here.

> +}
> +
> +/*
> + * qmc5883p_get_measure - read all three axes.
> + * Must be called with data->mutex held.
> + * Handles PM internally: resumes device, reads data, schedules autosuspend.
> + */
> +static int qmc5883p_get_measure(struct qmc5883p_data *data, s16 *x, s16 *y,
> +				s16 *z)
> +{
> +	int ret;
> +	u8 reg_data[6];
> +	unsigned int status;
> +
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Poll the status register until DR
> DY is set or timeout.
> +	 * Read the whole register in one shot so that OVFL is captured from
> +	 * the same read: reading 0x09 clears both DRDY and OVFL, so a second
> +	 * read would always see OVFL=0.
> +	 * At ODR=10Hz one period is 100ms; use 150ms as a safe upper bound.
> +	 */
> +	ret = regmap_read_poll_timeout(data->regmap, QMC5883P_REG_STATUS,
> +				       status, status & QMC5883P_STATUS_DRDY,
> +				       QMC5883P_DRDY_POLL_US, 150000);

Numbers with lots of 0s are easier to read as 150 * (MICRO / MILLI).

> +	if (ret)
> +		goto out;
> +
> +	if (status & QMC5883P_STATUS_OVFL) {
> +		dev_warn_ratelimited(data->dev,
> +				     "data overflow, consider reducing field range\n");
> +		ret = -ERANGE;
> +		goto out;
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, QMC5883P_REG_X_LSB, reg_data,
> +			       ARRAY_SIZE(reg_data));
> +	if (ret)
> +		goto out;
> +
> +	*x = (s16)get_unaligned_le16(&reg_data[0]);
> +	*y = (s16)get_unaligned_le16(&reg_data[2]);
> +	*z = (s16)get_unaligned_le16(&reg_data[4]);
> +
> +out:
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_
> autosuspend(data->dev);
> +	return ret;
> +}
> +
> +static int qmc5883p_write_scale(struct qmc5883p_data *data, int val, int val2)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(qmc5883p_scale); i++) {
> +		if (qmc5883p_scale[i][0] == val && qmc5883p_scale[i][1] == val2)
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
> +	for (i = 0; i < ARRAY_SIZE(qmc5883p_odr); i++) {
> +		if (qmc5883p_odr[i] == val)
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
> +	for (i = 0; i < ARRAY_SIZE(qmc5883p_osr); i++) {
> +		if (qmc5883p_osr[i] == val)
> +			return regmap_field_write(data->rf.osr, i);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t downsampling_ratio_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio
> _dev = dev_get_drvdata(dev);
> +	struct qmc5883p_data *data = iio_priv(indio_dev);
> +	unsigned int regval;
> +	int ret;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	ret = regmap_field_read(data->rf.dsr, &regval);
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
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct qmc5883p_data *data = iio_priv(indio_dev);
> +	unsigned int val;
> +	int i, ret, restore;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
> +	if (ret)
> +		goto out;
> +
> +	ret = -EINVAL;
> +	for (i = 0; i < ARRAY_SIZE(qmc5883p_dsr); i++) {
> +		if (qmc5883p_dsr[i] == val) {
> +			ret = regmap_field_wr
> ite(data->rf.dsr, i);
> +			break;
> +		}
> +	}
> +
> +	restore = regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
> +	if (restore && !ret)
> +		ret = restore;
> +
> +out:
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +	return ret ? ret : (ssize_t)len;
> +}
> +
> +static int qmc5883p_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	s16 x, y, z;
> +	struct qmc5883p_data *data = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int regval;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = qmc5883p_get_measure(data, &x, &y, &z);
> +		if (ret < 0)
> +			return ret;
> +		switch (chan->address) {
> +		case AXIS_X:
> +			*val = x;
> +			break;
> +		case AXIS_Y:
> +			*val = y;
> +			break;
> +		case AXIS_Z:
> +			*val = z;
> +			break;
> +		}
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regmap_field_read(data->rf.rng, &regval);
> +		if (
> ret < 0)
> +			return ret;
> +		*val = qmc5883p_scale[regval][0];
> +		*val2 = qmc5883p_scale[regval][1];
> +		return IIO_VAL_FRACTIONAL;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_field_read(data->rf.odr, &regval);
> +		if (ret < 0)
> +			return ret;
> +		*val = qmc5883p_odr[regval];
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = regmap_field_read(data->rf.osr, &regval);
> +		if (ret < 0)
> +			return ret;
> +		*val = qmc5883p_osr[regval];
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
> +	struct qmc5883p_data *data = iio_priv(indio_dev);
> +	int ret, restore;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
> +	if (ret)
> +		goto out;
> +
> +	switch (mask) {
> +	case IIO_
> CHAN_INFO_SAMP_FREQ:
> +		ret = qmc5883p_write_odr(data, val);
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = qmc5883p_write_osr(data, val);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = qmc5883p_write_scale(data, val, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	restore = regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
> +	if (restore && !ret)
> +		ret = restore;
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
> 
> 
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = qmc5883p_odr;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(qmc5883p_odr);
> +		return IIO_AVAIL_LIST;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = qmc5883p_osr;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(qmc5883p_osr);
> +		return IIO_AVAIL_LIST;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (const int *)qmc5883p_scale;
> +		*type = IIO_VAL_FRACTIONAL;
> +		*length = ARRAY_SIZE(qmc5883p_scale) * 2;
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static IIO_DEVICE_ATTR(downsampling_ratio, 0644, downsampling_ratio_show,
> +		       downsampling_ratio_store, 0);
> +static IIO_CONST_ATTR(downsampling_ratio_available, "1 2 4 8");

As mentioned in the cover letter, we'd like to know more about what
this actually does. If there is a good reason it doesn't fit with
any existing filter attribute, then we'll need a patch to document
the sysfs ABI as well.

> +
> +static struct attribute *qmc5883p_attributes[] = {
> +	&iio_dev_attr_downsampling_ratio.dev_attr.attr,
> +	&iio_const_attr_downsampling_ratio_available.dev_attr.attr, NULL
> +};
> +
> +static const struct attribute_group qmc5883p_attribute_group = {
> +	.attrs = qmc5883p_attribu
> tes,
> +};
> +
> +static const struct iio_info qmc5883p_info = {
> +	.attrs = &qmc5883p_attribute_group,
> +	.read_raw = qmc5883p_read_raw,
> +	.write_raw = qmc5883p_write_raw,
> +	.read_avail = qmc5883p_read_avail,
> +};
> +
> +static const struct iio_chan_spec qmc5883p_channels[] = {
> +	{
> +		.type = IIO_MAGN,
> +		.channel2 = IIO_MOD_X,
> +		.modified = 1,
> +		.address = AXIS_X,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type =
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_type_available =
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},

Could save some dupilcation by making a macro that takes X/Y/Z
as parameter. e.g.

#define QMC5883P_CHAN(ch) \
	...				\
	.channel2 = IIO_MOD_##ch,	\
	...				\
	.address = AXIS_##ch,		\
	...

> +	{
> +		.type = IIO_MAGN,
> +		.channel2 = IIO_MOD_Y,
> +		.modified = 1,
> +		.address = AXIS_Y,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_IN
> FO_SCALE),
> +		.info_mask_shared_by_type =
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_type_available =
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +	{
> +		.type = IIO_MAGN,
> +		.channel2 = IIO_MOD_Z,
> +		.modified = 1,
> +		.address = AXIS_Z,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type =
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_type_available =
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +};
> +
> +static void qmc5883p_suspend_action(void *arg)
> +{
> +	struct qmc5883p_data *data = arg;
> +
> +	regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
> +}
> +
> +static int qmc5883p_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->d
> ev;
> +	struct qmc5883p_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &qmc5883p_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "regmap initialization failed\n");
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = dev;
> +	data->regmap = regmap;
> +	mutex_init(&data->mutex);
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vdd");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				"failed to get vdd regulator\n");
> +
> +	/* Datasheet specifies up to 50 ms supply ramp + 250 us POR time. */
> +	fsleep(50000);
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = qmc5883p_rf_init(data);

Would be more logical to move this up right after regmap is declared.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to initialize regmap fields\n");
> +
> +	ret = qmc5883p_verify_chip_id(data);
> +	if (ret)
> +		retur
> n ret;
> +
> +	ret = qmc5883p_chip_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize chip\n");
> +
> +	indio_dev->name = "qmc5883p";
> +	indio_dev->info = &qmc5883p_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = qmc5883p_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(qmc5883p_channels);
> +
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	pm_runtime_set_active(dev);
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_mark_last_busy(dev);
> +
> +	ret = devm_add_action_or_reset(dev, qmc5883p_suspend_action, data);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);

Usually, we just return directly here. This pretty much doesn't ever fail.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register IIO device\n");
> +	return 0;
> +}
> +
> +static int qmc5883p_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct qmc5883p_data *data = iio_priv(indi
> o_dev);
> +
> +	return regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
> +}
> +
> +static int qmc5883p_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct qmc5883p_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(10000, 11000);

Again, fsleep() and comment.

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
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct qmc5883p_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If the regulator was cut during system suspend, POR will have
> +	 * reset all registers. Reinitialise the chip and resync the
> +	 * regmap cache so that cached control register values are pushed
> +	 * back to har
> dware.
> +	 */
> +	ret = qmc5883p_chip_init(data);
> +	if (ret)
> +		return ret;
> +
> +	regcache_mark_dirty(data->regmap);
> +	return regcache_sync(data->regmap);
> +}
> +
> +static const struct dev_pm_ops qmc5883p_dev_pm_ops = {
> +	SYSTEM_SLEEP_PM_OPS(qmc5883p_system_suspend, qmc5883p_system_resume)
> +	RUNTIME_PM_OPS(qmc5883p_runtime_suspend, qmc5883p_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id qmc5883p_of_match[] = {
> +	{ .compatible = "qst,qmc5883p" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qmc5883p_of_match);
> +
> +static const struct i2c_device_id qmc5883p_id[] = {
> +	{ "qmc5883p", 0 },
> +	{},

IIO style for this is:

	{ }

space between braces and no trailing comma.

> +};
> +MODULE_DEVICE_TABLE(i2c, qmc5883p_id);
> +
