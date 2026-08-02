Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F21DFDA1
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785691155; cv=none; b=LJoNwWAjHG1441wNtwp5gRA1zX+c5UTkgftXdOVfaLkCMQyTJJDF9RIKX9cbPwOZWN7B9KNLVhl1c9HGpjetJL6XY7xHIGRAVY04H7Q0m0KfcpaEVheKeRrMlDbMv8JS980GSsg5Zz7PHQundO2OKW5JCyYLfiRNewpuWksqz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785691155; c=relaxed/simple;
	bh=Wh+Eqh5XTZlcgrUerjCOZGw6WM2ztokDXiXkt1TVwSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPhjqYYlQpknKZIH5R08hh45WxtZjtBqtWq3N/gWn3E0WASmYXJuuQJaxho2IoT4p9H3i/pJfQgr2ab+1S1JFU8G1q59KgkXE4Pghqi5nViI0cBInluaUJ6SFOOyWqnUGr15LynL1WFF29rwkYmltegC8ryVFfykpmPtBVtP6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ma7P4jzJ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ma7P4jzJ"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e6b5737bb2so2423004a34.1
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785691150; x=1786295950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pc/pX7W0HcPIaYjI5sIiUjyN5ogQk0IFQ/5RQoXewV0=;
        b=Ma7P4jzJD6eAFuCXkoGI1ak7LoCrR0V+SBQmSRW3c6DH279TBYmmQJgKHysuLGZaEj
         DdSg7ssYZ3Kmc1+1IuNQv5yO09/AcjsQv3Beq/FycJK9WoscrU4GNs38UxJ/bPjmvZVf
         ll2i297Li+dFYdiznHeN0dxo/E8zbgzJYfBIp6kDlbYTQ6NsjApUbKgE++hiCoPLoy5F
         fv6yF/VEZIcrwHTWv8mcMuQ0SWBC0K+xQZ8uR9592HguuhxI1tM7Y/fLpJ77TGVgKX42
         wK1o/nmg+GuvNfh7qeUF0i+XZgu1Zk/4yfuzYHxgIYAPvP5IZkLqchm2g8onPRLPMCJP
         LkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785691150; x=1786295950;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pc/pX7W0HcPIaYjI5sIiUjyN5ogQk0IFQ/5RQoXewV0=;
        b=HOSBAH1+bfXUnyIXylwaaGSreFP05HPxul8Wmkug8BrUT73oGYQKuOvj5YHSdl5Idx
         qcJ7WiCH8RNB4qoPXXydabPjTx9JKa157lzptWebt65YN+wnUA7/0YjpU7MFgrq21ZH4
         fgpk0C7u5oi8jdrU2KBfv3IaXF9Kd33iF1Op4P/v1bcgWRnzTKD6EqrPsjTT9igKxvdX
         +Snmtf9Vf1RQRNtRWRRR86vJFNzCenSpE83QZansCtQUHKc5s5PwUWYd6/xYG4ppOxtu
         1w+wOFFYfz+g3A6m/YmUG0lQNtjJvRZ3My+kp72S0y8DxHzpnSe/w/Y0NDzQzvSHtMVD
         qudg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5nugQE6P2ggU2E3BCW6N2T/YuaNYWrga/ika/mBJVl6C6dFS9eAEdcYFWOnHwv19jsPK3v6Iti4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0/bdDEMiCjlB+1iMZmSuXTklxX/qYViJdBtghxr/1Nvn+WwwM
	nLFhFQ62jOx7gXvkHNh3+bM3m4Lue3Vw4PFmQIymRxmVFv4n4ZPtQilwCk6L69Kgyj0=
X-Gm-Gg: AR+sD13Z9S8HEMt++eJNPaTbf7pJkXyOOzbY3IdU4eNhNFiHb1I6RFAmTfOQQIVs6ed
	rMMufpngC7T//fbKkOADGEF3chL22Xv2QAKsYisNuorrjgy5ITuoiqplSowDF/QS1qPolFGmg2Z
	qh6eSDc/oHgVQVxun9sw+95Eb8JNg4SMoEL6p3AuW9dZ9B0cu1i9jLGBP4Xv5GMJp4fdl0X8/Bh
	3KJzs2IRXWFhucnNcgGkAGs3ebpUwcqCUZVyLxZ0UvNZ941R/Rr8jb6cnQNco7sZugBj3e+XB/l
	ZfMBWPyW5liWy+kGXTrp01CtKVIcMTpPZ+ysOMa7sL0NBoh8wQ9qygLSzAke4fwP1ajppKBNwgW
	Bbjm2sFjH+Xt9fiq92AbSE86S/ygol1J+Thc3bXBdDMwtudWLUqHLrVlkeQhfA09lmoiYaUNeTz
	Ek5Z9BR2w15tN7tR3RicdHv0fTFYcTh/T3ODKNm2oRK9/H5IXInf3B7gNkrnWKHPwlXlMVYc55S
	aFz9quje4CqqXrPaKGZFjy6GrIDC9oVTOWrb8MP8r2wbsAPEg==
X-Received: by 2002:a05:6830:211b:b0:7e9:c102:333d with SMTP id 46e09a7af769-7f196f8ad8cmr12503710a34.9.1785691150034;
        Sun, 02 Aug 2026 10:19:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a500sm5401960a34.14.2026.08.02.10.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 10:19:08 -0700 (PDT)
Message-ID: <50fee508-db53-46c3-b245-22893023f370@baylibre.com>
Date: Sun, 2 Aug 2026 12:19:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: dac: dac8163: Add driver for DAC8163
To: Lukas Metz <lukas.metz@gmx.net>, Jonathan Cameron <jic23@kernel.org>,
 Siratul Islam <siratul.islam@linux.dev>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260802-dac8163-work-v3-0-3ecc7bc66d0d@gmx.net>
 <20260802-dac8163-work-v3-2-3ecc7bc66d0d@gmx.net>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802-dac8163-work-v3-2-3ecc7bc66d0d@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/2/26 11:07 AM, Lukas Metz wrote:
> The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-output,
> dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
> respectively. These devices include a 2.5-V, 4-ppm/°C internal
> reference, giving a full-scale output voltage range of 2.5 V or 5 V.
> 
> Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
> ---
>  MAINTAINERS                  |   1 +
>  drivers/iio/dac/Kconfig      |  16 ++
>  drivers/iio/dac/Makefile     |   1 +
>  drivers/iio/dac/ti-dac8163.c | 449 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 467 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 314f235332f5..5512f5eaab44 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26399,6 +26399,7 @@ M:	Lukas Metz <lukas.metz@gmx.net>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> +F:	drivers/iio/dac/ti-dac8163.c
>  
>  TI DATA TRANSFORM AND HASHING ENGINE (DTHE) V2 CRYPTO DRIVER
>  M:	T Pratham <t-pratham@ti.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index db9f5c711b3d..aa80b871995b 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -632,6 +632,22 @@ config TI_DAC7612
>  
>  	  If compiled as a module, it will be called ti-dac7612.
>  
> +config TI_DAC8163
> +	tristate "Texas Instruments 12/14/16-bit 2-channel DAC driver"
> +	depends on SPI_MASTER
> +	select REGMAP_SPI
> +	help
> +	  Driver for the Texas Instruments digital-to-analog converter
> +	  family dacxx6x compatible with the following variants
> +	  - DAC7562 (2 channels, 12 bits, resets to zero)
> +	  - DAC7563 (2 channels, 12 bits, resets to mid-scale)
> +	  - DAC8162 (2 channels, 14 bits, resets to zero)
> +	  - DAC8163 (2 channels, 14 bits, resets to mid-scale)
> +	  - DAC8562 (2 channels, 16 bits, resets to zero)
> +	  - DAC8563 (2 channels, 16 bits, resets to mid-scale)
> +
> +	  If compiled as a module, it will be called ti-dac8163.
> +
>  config VF610_DAC
>  	tristate "Vybrid vf610 DAC driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 2a80bbf4e80a..359cde446623 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -62,4 +62,5 @@ obj-$(CONFIG_TI_DAC082S085) += ti-dac082s085.o
>  obj-$(CONFIG_TI_DAC5571) += ti-dac5571.o
>  obj-$(CONFIG_TI_DAC7311) += ti-dac7311.o
>  obj-$(CONFIG_TI_DAC7612) += ti-dac7612.o
> +obj-$(CONFIG_TI_DAC8163) += ti-dac8163.o
>  obj-$(CONFIG_VF610_DAC) += vf610_dac.o
> diff --git a/drivers/iio/dac/ti-dac8163.c b/drivers/iio/dac/ti-dac8163.c
> new file mode 100644
> index 000000000000..35af7828dc22
> --- /dev/null
> +++ b/drivers/iio/dac/ti-dac8163.c
> @@ -0,0 +1,449 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * DAC8163 IIO driver (SPI)
> + * https://www.ti.com/de/lit/gpn/dac8163
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/stddef.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define COMMAND_MASK GENMASK(6, 3)
> +#define ADDRESS_MASK GENMASK(2, 0)
> +
> +#define CMD_WRITE_INPUT_REG	0x0
> +#define CMD_UPDATE_DAC		0x1
> +#define CMD_WRITE_UPDATE_ALL	0x2
> +#define CMD_WRITE_UPDATE	0x3
> +#define CMD_POWER_MODE		0x4
> +#define CMD_SOFT_RST		0x5
> +#define CMD_LDAC_MODE		0x6
> +#define CMD_REF			0x7
> +
> +#define LDAC_CHANNEL_A_MASK BIT(0)
> +#define LDAC_CHANNEL_B_MASK BIT(1)
> +#define VREF_MASK	    BIT(0)
> +
> +#define DAC8163_INTERNAL_REF_mV 2500
> +#define DAC8163_RES_12_BIT	12
> +#define DAC8163_RES_14_BIT	14
> +#define DAC8163_RES_16_BIT	16

Macros that just map to a number that is part of the macro name
aren't that helpful. We can just use the number directly.

> +
> +enum dac8163_reset_types {
> +	OUTPUT_ONLY_RESET = 0,
> +	FULL_RESET = 1,
> +};
> +
> +enum dac8163_ldac_modes {
> +	LDAC_ACTIVE = 0,
> +	LDAC_INACTIVE = 1,
> +};
> +
> +enum dac8163_voltage_reference {
> +	VREF_EXTERNAL = 0,
> +	VREF_INTERNAL = 1,
> +};
> +
> +struct dac8163_state {
> +	struct regmap *regmap;
> +	struct regulator *vref;
> +
> +	int vref_mV;
> +	int gain;
> +};
> +
> +struct dac8163_chip_info {
> +	const char *name;
> +	const struct iio_chan_spec channels[2];
> +	const struct regmap_config regmap_config;
> +};
> +
> +#define DAC8163_CHAN(id, resolution)					\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.channel = (id),					\
> +		.output = 1,						\
> +		.indexed = 1,						\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\

The gain can be configured per-channel, so SCALE should also be info_mask_separate.

> +		.scan_type = {						\
> +			.realbits = (resolution),			\
> +			.shift = 16 - (resolution),			\
> +		},							\
> +	}
> +
> +#define DAC8163_MID_SCALE(resolution) \
> +	(BIT((resolution) - 1) << (16 - (resolution)))
> +
> +static bool dac8163_reg_false(struct device *dev, unsigned int ref)

This is only used for volatile_reg callback so I would stil call it
dac8163_volatile_reg().

Also, registers that have a side-effect when written, like updating all
outputs or resetting should be considered volatile.

And the fact that the reference select registers also changes the gain
makes the gain registers volatile.

And there is a reset that only touches DAC data registers, so techically
those could be volatle too if we ever used that reset.

> +{
> +	return false;
> +}
> +
> +static const struct reg_default dacxxx2_reg_defaults[] = {
> +	{
> +		.reg = FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
> +		       FIELD_PREP_CONST(ADDRESS_MASK, 0),
> +		.def = 0,
> +	},
> +	{
> +		.reg = FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
> +		       FIELD_PREP_CONST(ADDRESS_MASK, 1),
> +		.def = 0,
> +	},

This should include all non-volitile registers.

> +};
> +
> +static const struct regmap_config dacxxx2_regmap_config = {

We always try to avoid using xes names like this. Just pick the
lowest matching exact model number and use that.

> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = CMD_REF << 3,
> +	.cache_type = REGCACHE_MAPLE,

This driver currently only uses regmap_write() which always bypasses the cache
and writes the value over the bus.

> +	.volatile_reg = dac8163_reg_false,
> +	.reg_defaults = dacxxx2_reg_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(dacxxx2_reg_defaults),
> +};

It could also make sense to add a writeable table since there are
only actually 20 valid "registers" out of a 6-bit value.

> +
> +static const struct reg_default dac7563_reg_defaults[] = {
> +	{
> +		.reg = FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
> +		       FIELD_PREP_CONST(ADDRESS_MASK, 0),
> +		.def = DAC8163_MID_SCALE(12),
> +	},
> +	{
> +		.reg = FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
> +		       FIELD_PREP_CONST(ADDRESS_MASK, 1),
> +		.def = DAC8163_MID_SCALE(12),
> +	},
> +};
> +
> +static const struct regmap_config dac7563_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = CMD_REF << 3,
> +	.cache_type = REGCACHE_MAPLE,
> +	.volatile_reg = dac8163_reg_false,
> +	.reg_defaults = dac7563_reg_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(dac7563_reg_defaults),
> +};
> +
> +static const struct reg_default dac8163_reg_defaults[] = {
> +	{
> +		.reg = FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
> +		       FIELD_PREP_CONST(ADDRESS_MASK, 0),
> +		.def = DAC8163_MID_SCALE(14),
> +	},
> +	{
> +		.reg = FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
> +		       FIELD_PREP_CONST(ADDRESS_MASK, 1),
> +		.def = DAC8163_MID_SCALE(14),
> +	},
> +};
> +
> +static const struct regmap_config dac8163_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = CMD_REF << 3,
> +	.cache_type = REGCACHE_MAPLE,
> +	.volatile_reg = dac8163_reg_false,
> +	.reg_defaults = dac8163_reg_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(dac8163_reg_defaults),
> +};
> +
> +static const struct reg_default dac8563_reg_defaults[] = {
> +	{
> +		.reg = FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
> +		       FIELD_PREP_CONST(ADDRESS_MASK, 0),
> +		.def = DAC8163_MID_SCALE(16),
> +	},
> +	{
> +		.reg = FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
> +		       FIELD_PREP_CONST(ADDRESS_MASK, 1),
> +		.def = DAC8163_MID_SCALE(16),
> +	},
> +};
> +

If we only care about avoid extra writes when using CMD_WRITE_UPDATE,
this might be an exception where using the regmap cache is not the
best choice and just keep track of those values ourselves.

> +static const struct regmap_config dac8563_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = CMD_REF << 3,
> +	.cache_type = REGCACHE_MAPLE,
> +	.volatile_reg = dac8163_reg_false,
> +	.reg_defaults = dac8563_reg_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(dac8563_reg_defaults),
> +};
> +
> +static const struct dac8163_chip_info dac7562_chip_info = {
> +	.name = "dac7562",
> +	.channels = {
> +		DAC8163_CHAN(0, DAC8163_RES_12_BIT),
> +		DAC8163_CHAN(1, DAC8163_RES_12_BIT),
> +	},
> +	.regmap_config = dacxxx2_regmap_config,
> +};
> +
> +static const struct dac8163_chip_info dac7563_chip_info = {
> +	.name = "dac7563",
> +	.channels = {
> +		DAC8163_CHAN(0, DAC8163_RES_12_BIT),
> +		DAC8163_CHAN(1, DAC8163_RES_12_BIT),
> +	},
> +	.regmap_config = dac7563_regmap_config,
> +};
> +
> +static const struct dac8163_chip_info dac8162_chip_info = {
> +	.name = "dac8162",
> +	.channels = {
> +		DAC8163_CHAN(0, DAC8163_RES_14_BIT),
> +		DAC8163_CHAN(1, DAC8163_RES_14_BIT),
> +	},
> +	.regmap_config = dacxxx2_regmap_config,
> +};
> +
> +static const struct dac8163_chip_info dac8163_chip_info = {
> +	.name = "dac8163",
> +	.channels = {
> +		DAC8163_CHAN(0, DAC8163_RES_14_BIT),
> +		DAC8163_CHAN(1, DAC8163_RES_14_BIT),
> +	},
> +	.regmap_config = dac8163_regmap_config,
> +};
> +
> +static const struct dac8163_chip_info dac8562_chip_info = {
> +	.name = "dac8562",
> +	.channels = {
> +		DAC8163_CHAN(0, DAC8163_RES_16_BIT),
> +		DAC8163_CHAN(1, DAC8163_RES_16_BIT),
> +	},
> +	.regmap_config = dacxxx2_regmap_config,
> +};
> +
> +static const struct dac8163_chip_info dac8563_chip_info = {
> +	.name = "dac8563",
> +	.channels = {
> +		DAC8163_CHAN(0, DAC8163_RES_16_BIT),
> +		DAC8163_CHAN(1, DAC8163_RES_16_BIT),
> +	},
> +	.regmap_config = dac8563_regmap_config,
> +};
> +
> +static int dac8163_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct dac8163_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		ret = regmap_read(st->regmap,
> +				  FIELD_PREP(COMMAND_MASK, CMD_WRITE_UPDATE) |
> +				  FIELD_PREP(ADDRESS_MASK, chan->channel),
> +				  val);
> +		if (ret)
> +			return ret;
> +		*val >>= chan->scan_type.shift;
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE: {
> +		*val = st->vref_mV * st->gain;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int dac8163_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct dac8163_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		if (val2 != 0)
> +			return -EINVAL;
> +
> +		if (val < 0 || val >= BIT(chan->scan_type.realbits))
> +			return -ERANGE;

Usually, we just use -EINVAL for this.

> +
> +		return regmap_write(st->regmap,
> +				    FIELD_PREP(COMMAND_MASK, CMD_WRITE_UPDATE) |
> +				    FIELD_PREP(ADDRESS_MASK, chan->channel),
> +				    (u16)val << chan->scan_type.shift);
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info dac8163_iio_info = {
> +	.write_raw = dac8163_write_raw,
> +	.read_raw = dac8163_read_raw,
> +};
> +
> +static int dac8163_probe(struct spi_device *spi)
> +{
> +	const struct dac8163_chip_info *info;
> +	struct gpio_desc *ldac_gpio;
> +	struct iio_dev *indio_dev;
> +	struct dac8163_state *st;
> +	bool internal_reference;
> +	int ret;
> +
> +	info = spi_get_device_match_data(spi);
> +	if (!info)
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	indio_dev->name = info->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &dac8163_iio_info;
> +	indio_dev->channels = info->channels;
> +	indio_dev->num_channels = ARRAY_SIZE(info->channels);
> +
> +	st->regmap = devm_regmap_init_spi(spi, &info->regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> +				     "failed to initialize regmap\n");
> +
> +	// for now we keep the ldac pin asserted permanently so that the output
> +	// is updated immediately after a write to the channels raw attribute

Use IIO comment style. (checkpatch should have flagged this.)

	/*
	 * For now we keep the LDAC pin asserted permanently so that the output
	 * is updated immediately after a write to the channels raw attribute.
	 */

I also fixed up captialization and punctuation.

> +	ldac_gpio = devm_gpiod_get_optional(&spi->dev, "ldac",
> +					    GPIOD_OUT_HIGH);
> +	if (IS_ERR(ldac_gpio))
> +		return dev_err_probe(&spi->dev, PTR_ERR(ldac_gpio),
> +				     "failed to get ldac gpio");
> +
> +	ret = devm_regulator_get_enable(&spi->dev, "avdd");
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "failed to get avdd voltage\n");

Usually, we need to turn the power on before appling voltage to any I/O
pins on a chip. So this should be before the LDAC gpio.

> +
> +	if (device_property_present(&spi->dev, "vrefin-supply")) {
> +		ret = devm_regulator_get_enable_read_voltage(&spi->dev,
> +							     "vrefin");
> +		if (ret < 0)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "failed to get vrefin voltage\n");
> +
> +		st->vref_mV = ret / (MICRO / MILLI);
> +		internal_reference = false;
> +		st->gain = 1;
> +	} else {
> +		st->vref_mV = DAC8163_INTERNAL_REF_mV;
> +		internal_reference = true;
> +		st->gain = 2;
> +	}
> +
> +	ret = regmap_write(st->regmap, FIELD_PREP(COMMAND_MASK, CMD_SOFT_RST),
> +			   FULL_RESET);
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "failed to reset device\n");
> +
> +	ret = regmap_write(st->regmap, FIELD_PREP(COMMAND_MASK, CMD_LDAC_MODE),
> +			   FIELD_PREP(LDAC_CHANNEL_A_MASK, LDAC_INACTIVE) |
> +			   FIELD_PREP(LDAC_CHANNEL_B_MASK, LDAC_INACTIVE));


I know I have said many times before not to hide FIELD_PREP() in a macro.
However, that was for register _values_, not register _addresseses_.

In this case, I think we can make an exception for the address like:

#define DAC8163_REG(cmd, addr) \
	(FIELD_PREP(COMMAND_MASK, (cmd)) | FIELD_PREP(ADDRESS_MASK, (addr)))

So we can write it like:

	ret = regmap_write(st->regmap, DAC8163_REG(CMD_LDAC_MODE, 0),
			   FIELD_PREP(LDAC_CHANNEL_A_MASK, LDAC_INACTIVE) |
			   FIELD_PREP(LDAC_CHANNEL_B_MASK, LDAC_INACTIVE));

Having FIELD_PREP() on all of the register addresses throught this patch
was really throwing me off and gets quite verbose and repetitive.

> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "failed to set ldac mode\n");
> +
> +	ret = regmap_write(st->regmap, FIELD_PREP(COMMAND_MASK, CMD_REF),
> +			   FIELD_PREP(VREF_MASK, internal_reference));
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "failed to select reference voltage\n");
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct of_device_id dac8163_of_match[] = {
> +	{
> +		.compatible = "ti,dac7562",
> +		.data = &dac7562_chip_info,
> +	},
> +	{
> +		.compatible = "ti,dac7563",
> +		.data = &dac7563_chip_info,
> +	},
> +	{
> +		.compatible = "ti,dac8162",
> +		.data = &dac8162_chip_info,
> +	},
> +	{
> +		.compatible = "ti,dac8163",
> +		.data = &dac8163_chip_info,
> +	},
> +	{
> +		.compatible = "ti,dac8562",
> +		.data = &dac8562_chip_info,
> +	},
> +	{
> +		.compatible = "ti,dac8563",
> +		.data = &dac8563_chip_info,
> +	},

These fit on one line under 80 chars.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dac8163_of_match);
> +
> +static const struct spi_device_id dac8163_id_table[] = {
> +	{
> +		.name = "dac7562",
> +		.driver_data = (kernel_ulong_t)&dac7562_chip_info,
> +	},
> +	{
> +		.name = "dac7563",
> +		.driver_data = (kernel_ulong_t)&dac7563_chip_info,
> +	},
> +	{
> +		.name = "dac8162",
> +		.driver_data = (kernel_ulong_t)&dac8162_chip_info,
> +	},
> +	{
> +		.name = "dac8163",
> +		.driver_data = (kernel_ulong_t)&dac8163_chip_info,
> +	},
> +	{
> +		.name = "dac8562",
> +		.driver_data = (kernel_ulong_t)&dac8562_chip_info,
> +	},
> +	{
> +		.name = "dac8563",
> +		.driver_data = (kernel_ulong_t)&dac8563_chip_info,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, dac8163_id_table);
> +
> +static struct spi_driver dac8163_driver = {
> +	.driver = {
> +		.name = "dac8163",
> +		.of_match_table = dac8163_of_match,
> +	},
> +	.probe = dac8163_probe,
> +	.id_table = dac8163_id_table,
> +};
> +module_spi_driver(dac8163_driver);
> +
> +MODULE_AUTHOR("Lukas Metz <lukas.metz@gmx.net>");
> +MODULE_DESCRIPTION("Texas Instruments 12/14/16-bit 2-channel DAC driver");
> +MODULE_LICENSE("GPL");
> 

