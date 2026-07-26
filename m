Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D64625;
	Sun, 26 Jul 2026 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785024906; cv=none; b=nHXeMtYQzrKtuRXd1d1AaOiyf5TMC0x4Hu8BXdCMFwKgUVnEhl/fX630mveYy+aUfis6IzUTmG5GAK8RbzGARkTsF7u4Won+nWgl+02bhpzhn7EPxTvDLP5+aS9MW4hbQT+5wWpNRwCZp8gH7BSqD30r4chSFZZ17qloRI5YT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785024906; c=relaxed/simple;
	bh=o7/a0Kt41jJ6Dg8Xf2J/K/JdOrNrmCpXeMjcHIZJLeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZBE7NmAYIfCNTHu2BSnp63CSPSjkqyOOabcug8xdiSLeZpChLJEjlvCiic0u2GVQLoddn0ABVc00TM9fr+MqFNPCtKo4UBIq11a2oF+H1uaGxGu7QOg7ZmvxtbpNvTkDt7ZqQmDd20TnICG4D8mKp+VQjDAz17bodanwIvM3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgeTfPNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgeTfPNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46141F000E9;
	Sun, 26 Jul 2026 00:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785024905;
	bh=kFNDyTa1qtFCV+i4n4Xa0YhOwSpwdjPz21aZJ94K5UM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DgeTfPNlMYw2sZp01TUAj64NLbewbWE+gdoxTnmixGV6QjLzS2Ga7LXNCdv3AEfFU
	 v6Uw+ZL56G4yvdalWZ8I9CA/PjjlfDTS6CUKyJgRIp1LPou6zKYegpuTYt3+6pbP+o
	 hxUUVXAOZAGwF/dMXfT7cSKI5uSK34klRGN7oQFWePj34S6EdYRu1+vqq9yRr4aOAc
	 yiOQy73xA7uIDMFXS/JeVUXHMRTn29DX0cnWupJlz3UhbjCRWsPCRfV2OEXUaYPa9V
	 p5oPWE7Ih+/c+374IfznUlqew+heUwTxDxLASpejkIONYWYDioJrlVZhbOn46NZBwl
	 qB3/W6G2KHVyg==
Date: Sun, 26 Jul 2026 01:14:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C
 driver into two modules
Message-ID: <20260726011457.2cdfa9d5@jic23-huawei>
In-Reply-To: <20260723-mcp47feb02_refactor-v1-1-ee59e63672bc@microchip.com>
References: <20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com>
	<20260723-mcp47feb02_refactor-v1-1-ee59e63672bc@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 16:43:10 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> Prepare the driver for the bus-specific code refactoring into

by refactoring into..

> separate files. The renamed file will contain the common DAC functionality
> shared by the MCP47FxBy1/2/4/8 I2C and MCP48FxBy1/2/4/8 SPI drivers. The
> MCP47FEB02 driver was refactored into two modules: mcp47feb02-core.c
> and mcp47feb02-i2c.c in order to prepare the support for SPI
> MCP48FxBy1/2/4/8 DAC family on top of the current implementation.

Rewrap to a consistent line length.  People tend to use either 72 or 75 chars
for commit messages.

My main comment in the following is that a lot of stuff gets moved into
the header and I think the vast majority of it can stay in the core.c
file reducing it's scope and generally keeping things a little simpler.

Jonathan


> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  MAINTAINERS                                        |   4 +-
>  drivers/iio/dac/Kconfig                            |  10 +-
>  drivers/iio/dac/Makefile                           |   3 +-
>  .../iio/dac/{mcp47feb02.c => mcp47feb02-core.c}    | 414 +--------------------
>  drivers/iio/dac/mcp47feb02-i2c.c                   | 145 ++++++++
>  drivers/iio/dac/mcp47feb02.h                       | 153 ++++++++
>  6 files changed, 325 insertions(+), 404 deletions(-)

> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02-core.c
> similarity index 64%
> rename from drivers/iio/dac/mcp47feb02.c
> rename to drivers/iio/dac/mcp47feb02-core.c
> index a823c2a673a26d70e5829cb587034da435af0451..6c86fa40e6eb2f1f602cac4c75265b6af7000c72 100644
> --- a/drivers/iio/dac/mcp47feb02.c
> +++ b/drivers/iio/dac/mcp47feb02-core.c
> @@ -2,7 +2,7 @@
>  /*
>   * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface
>   *
> - * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + * Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries

I'd go with 2025-2026 

>   *
>   * Author: Ariana Lazar <ariana.lazar@microchip.com>
>   *



> diff --git a/drivers/iio/dac/mcp47feb02-i2c.c b/drivers/iio/dac/mcp47feb02-i2c.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..808c51d0afdf564321abcd46a5a7d9595c5472da
> --- /dev/null

> diff --git a/drivers/iio/dac/mcp47feb02.h b/drivers/iio/dac/mcp47feb02.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..7dbf157d7d6dcfeda7e47141ad447dfa0a79fd51
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47feb02.h
> @@ -0,0 +1,153 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef __DRIVERS_IIO_DAC_MCP47FEB02_H__
> +#define __DRIVERS_IIO_DAC_MCP47FEB02_H__
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/iio.h>
> +
> +/* Register addresses must be left shifted with 3 positions in order to append command mask */

Maybe it becomes obvious later, but for this patch at least, why
are we moving the register defines into a header?  They are only used
from the core driver so can we not leave them there?

Aim to have as little as possible in the shared header.
That also applies to the enums and most of the structures that follow.


> +#define MCP47FEB02_DAC0_REG_ADDR			0x00
> +#define MCP47FEB02_VREF_REG_ADDR			0x40
> +#define MCP47FEB02_POWER_DOWN_REG_ADDR			0x48
> +#define MCP47FEB02_DAC_CTRL_MASK			GENMASK(1, 0)
> +
> +#define MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR		0x50
> +#define MCP47FEB02_GAIN_BIT_MASK			BIT(0)
> +#define MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK		BIT(6)
> +#define MCP47FEB02_GAIN_BITS_MASK			GENMASK(15, 8)
> +
> +#define MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR		0x58
> +
> +#define MCP47FEB02_NV_DAC0_REG_ADDR			0x80
> +#define MCP47FEB02_NV_VREF_REG_ADDR			0xC0
> +#define MCP47FEB02_NV_POWER_DOWN_REG_ADDR		0xC8
> +#define MCP47FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR	0xD0
> +#define MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK		GENMASK(7, 0)
> +
> +/* Voltage reference, Power-Down control register and DAC Wiperlock status register fields */
> +#define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
> +#define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
> +
> +/* Gain Control and I2C Slave Address Reguster fields */
> +#define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
> +#define DAC_GAIN_VAL(ch, val)				((val) << (8 + (ch)))
> +
> +#define REG_ADDR(reg)					((reg) << 3)
> +#define NV_REG_ADDR(reg)				((NV_DAC_ADDR_OFFSET + (reg)) << 3)
> +#define READFLAG_MASK					GENMASK(2, 1)
> +
> +#define MCP47FEB02_MAX_CH				8
> +#define MCP47FEB02_MAX_SCALES_CH			3
> +#define MCP47FEB02_DAC_WIPER_UNLOCKED			0
> +#define MCP47FEB02_NORMAL_OPERATION			0
> +#define MCP47FEB02_INTERNAL_BAND_GAP_uV			2440000
> +#define NV_DAC_ADDR_OFFSET				0x10
> +
> +/* Macro used for generating chip features structures */
> +#define MCP47FEB02_CHIP_INFO(_name, _channels, _res, _vref1, _eeprom) \
> +static const struct mcp47feb02_features _name##_chip_features = { \
> +	.name = #_name, \
> +	.phys_channels = _channels, \
> +	.resolution = _res, \
> +	.have_ext_vref1 = _vref1, \
> +	.have_eeprom = _eeprom, \
> +}
> +
> +enum mcp47feb02_vref_mode {
> +	MCP47FEB02_VREF_VDD = 0,
> +	MCP47FEB02_INTERNAL_BAND_GAP = 1,
> +	MCP47FEB02_EXTERNAL_VREF_UNBUFFERED = 2,
> +	MCP47FEB02_EXTERNAL_VREF_BUFFERED = 3,
> +};
> +
> +enum mcp47feb02_scale {
> +	MCP47FEB02_SCALE_VDD = 0,
> +	MCP47FEB02_SCALE_GAIN_X1 = 1,
> +	MCP47FEB02_SCALE_GAIN_X2 = 2,
> +};
> +
> +enum mcp47feb02_gain_bit_mode {
> +	MCP47FEB02_GAIN_BIT_X1 = 0,
> +	MCP47FEB02_GAIN_BIT_X2 = 1,
> +};
> +
> +extern const char * const mcp47feb02_powerdown_modes[];
> +
> +/**
> + * struct mcp47feb02_features - chip specific data
> + * @name: device name
> + * @phys_channels: number of hardware channels
> + * @resolution: DAC resolution
> + * @have_ext_vref1: does the hardware have an the second external voltage reference?
> + * @have_eeprom: does the hardware have an internal eeprom?
> + */
> +struct mcp47feb02_features {
> +	const char *name;
> +	unsigned int phys_channels;
> +	unsigned int resolution;
> +	bool have_ext_vref1;
> +	bool have_eeprom;
> +};
I think this is one of the few structures that does want to be in this header.

> +
> +/**
> + * struct mcp47feb02_channel_data - channel configuration
> + * @ref_mode: chosen voltage for reference
> + * @use_2x_gain: output driver gain control
> + * @powerdown: is false if the channel is in normal operation mode
> + * @powerdown_mode: selected power-down mode
> + * @dac_data: dac value
> + */
> +struct mcp47feb02_channel_data {
> +	u8 ref_mode;
> +	bool use_2x_gain;
> +	bool powerdown;
> +	u8 powerdown_mode;
> +	u16 dac_data;
> +};
> +
> +/**
> + * struct mcp47feb02_data - chip configuration
> + * @chdata: options configured for each channel on the device
> + * @lock: prevents concurrent reads/writes to driver's state members
> + * @chip_features: pointer to features struct
> + * @scale_1: scales set on channels that are based on Vref1
> + * @scale: scales set on channels that are based on Vref/Vref0
> + * @active_channels_mask: enabled channels
> + * @regmap: regmap for directly accessing device register
> + * @labels: table with channels labels
> + * @phys_channels: physical channels on the device
> + * @vref1_buffered: Vref1 buffer is enabled
> + * @vref_buffered: Vref/Vref0 buffer is enabled
> + * @use_vref1: vref1-supply is defined
> + * @use_vref: vref-supply is defined
> + */
> +struct mcp47feb02_data {
> +	struct mcp47feb02_channel_data chdata[MCP47FEB02_MAX_CH];
> +	struct mutex lock; /* prevents concurrent reads/writes to driver's state members */
> +	const struct mcp47feb02_features *chip_features;
> +	int scale_1[2 * MCP47FEB02_MAX_SCALES_CH];
> +	int scale[2 * MCP47FEB02_MAX_SCALES_CH];
> +	unsigned long active_channels_mask;
> +	struct regmap *regmap;
> +	const char *labels[MCP47FEB02_MAX_CH];
> +	u16 phys_channels;
> +	bool vref1_buffered;
> +	bool vref_buffered;
> +	bool use_vref1;
> +	bool use_vref;
> +};

Even this looks superficially like it could stay in the -core.c file.

> +
> +extern const struct regmap_config mcp47feb02_regmap_config;
> +extern const struct regmap_config mcp47fvb02_regmap_config;
> +
> +/* Properties shared by I2C and SPI families */
> +int mcp47feb02_common_probe(const struct mcp47feb02_features *chip_features, struct regmap *regmap);
> +
> +extern const struct dev_pm_ops mcp47feb02_pm_ops;
> +
> +#endif /* __DRIVERS_IIO_DAC_MCP47FEB02_H__ */
> +
> 

