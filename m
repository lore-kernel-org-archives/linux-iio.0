Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3A13E5EC7;
	Thu, 28 May 2026 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969112; cv=none; b=FmQTVBli9ZbULEnDMukyw7Et/e9RZ2QTS2pH8nGa3TXw+Jjmj8uZEo9mi075uEK9Nqy+/FDqmzuPK2El+8W59OTViKwDb3A5aF0ffxxhK2Vlrb4n924Dw+gFDujHEui8gOicJ76f5sjKWKBty/b5/ieOEZKCY3TcWKrwKN/fL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969112; c=relaxed/simple;
	bh=Pw4UKXEv6JeqI1TrwKePKLxWnFVrq/+a7kLs/DTSkd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTfrqehqJfMnpKVX7j9AY80M/StzVT+Lo5l3+SEfu+JGbuxHqpynvbZd6gcHmUfSBoqGvztzYcfe09/FJpggzb7XOo0TnKnQ8MJ35GJo+RZCWojBTUwBJQi6KX9k+r7AHjZARnhMOSqN/cQn6M8arR/JuitNlmnoNT3ssnBAK3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euVdc7B+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euVdc7B+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0361F000E9;
	Thu, 28 May 2026 11:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779969109;
	bh=Osw9fJdkPmu55mwjpYV9XEQmGxNSau5vk1ygkibAExo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=euVdc7B+y7D/CTomj2VAt1CNUnEWHFK+zDxr9GHUxE5KkebPiW1xJQkYGe3A0fYXX
	 FGmM6Ml5XJTOWipK02z5Ud+9HuN2WubLdekXh788gyF0h19VxXyJUZ1TBdYVC22Rwl
	 oA19uVUjPkBszFJB0tMQSsI0krC8RA6CoiZUABK8Hip8keoqWLLrkzPwdTrzHCafMp
	 WQZDWWgm3EDpZpzarrbb+Y7ttuLWcLh5YWRMiVftqfFb29G0vEOBjPQvxJ1Kn7MJE5
	 TOcmOs45TsfXehTdWjCzT9mGNxTbcsQ9pJsHV8yN7g8n7PK4FbQm14jx+x6TZVtoyf
	 +FO0dOorEBM2A==
Date: Thu, 28 May 2026 12:51:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver
 into two modules
Message-ID: <20260528125140.16a8f173@jic23-huawei>
In-Reply-To: <20260527-mcp47feb02-fix2-v2-1-3e8946d7b3c4@microchip.com>
References: <20260527-mcp47feb02-fix2-v2-1-3e8946d7b3c4@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 17:50:40 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> The MCP47FEB02 driver was refactored into two modules: mcp47feb02-core.c
> and mcp47feb02-i2c.c in order to prepare the support for SPI
> (MCP48F(E/V)BXX) DAC family on top of the current implementation.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
> The MCP47FEB02 driver was refactored into two modules: mcp47feb02-core.c
> and mcp47feb02-i2c.c in order to prepare the support for SPI
> (MCP48F(E/V)BXX) DAC family on top of the current implementation.

Hi Ariana,

I don't mind reviewing this on it's own but won't merge it until
we have a reason (i.e. that SPI part)

> 
> Changes in v2:
>     Refactor the code into core and I2C modules and update MAINTAINERS,
>       Kconfig and Makefile to the new format.
>     Handle mismatch between vref modes at power up and enable regulator
>       only after the user corrects it.
This doesn't sound like it's related to a refactor..

All of these belong in separate patches from the fundamental code
move. Probably before it given they seem like a good idea anyway..

>     Improve comments and debug messages for clarity.
>     Avoid 64-bit division in mcp47feb02_init_scale().
>     Add available scale array in channel data struct.
>     Add a device_property_present() check for the Vref1 supply before
>       reading the regulator.
>     Rewrite conditions and warning messages for better readablity in
>       init_ctrl_regs().
>     Reorder channel_data struct fields as recommended and run pahole again.
>     Rewrite DAC_GAIN_MASK and DAC_GAIN_VAL formula as recommended.
>     Move initialization of Vref/Vref1 accordingly in probe().
>     Add missing newlines in debug messages.
>     Remove lock in parse_fw().
>     Remove fwnode_get_name function from missing label debug message.
>     Remove redundant reg initialization.
>     Split iio includes from the rest.
>     Rename scale and scale_1 to scale_0 and scale_1.
>     Declare tmp_eval as unsigned in mcp47feb02_set_scale().
>     Declare eewa_val as unsigned in mcp47feb02_write_to_eeprom().
>     Use 'num_channels == 0' instead of '!num_channels' in parse_fw().
>     Move lock from mcp47feb02_write_to_eeprom() to store_eeprom_store().
>     Correct timeout value to 20 USEC_PER_MSEC.
>     Remove blank line before IIO_DEVICE_ATTR_WO.
> v1:
> - first version committed to review
> - Link to v1: https://lore.kernel.org/r/20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com
> ---
>  MAINTAINERS                       |    4 +-
>  drivers/iio/dac/Kconfig           |    5 +
>  drivers/iio/dac/Makefile          |    3 +-
>  drivers/iio/dac/mcp47feb02-core.c |  992 +++++++++++++++++++++++++++++
>  drivers/iio/dac/mcp47feb02-i2c.c  |  145 +++++
>  drivers/iio/dac/mcp47feb02.c      | 1250 -------------------------------------

Did you turn rename detection off?  For a patch like this I'd rather have it on
as much of the code moved from .c to core.c and it will be much easier to spot
any changes.

>  drivers/iio/dac/mcp47feb02.h      |  173 +++++
>  7 files changed, 1320 insertions(+), 1252 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp47feb02-core.c b/drivers/iio/dac/mcp47feb02-core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..fa3e3d06c2c96a5d25c0761b29ffe785e29a622c
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47feb02-core.c
> @@ -0,0 +1,992 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface

That needs an update given this isn't the bus specific code any more.

> + *
> + * Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Ariana Lazar <ariana.lazar@microchip.com>
> + *
> + * Datasheet links for devices with I2C interface:
> + * [MCP47FEBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
> + * [MCP47FVBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
> + * [MCP47FxBx4/8] https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
> + */
> +#include <linux/array_size.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
As part of this rework (probably separate patch) good to update
these headers to include more specific ones and drop device.h

> +#include <linux/export.h>
> +#include <linux/kstrtox.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>


> +
> +int mcp47feb02_common_probe(const struct mcp47feb02_features *chip_features, struct regmap *regmap)

As below. Very long line, break that after ,

> +{



> diff --git a/drivers/iio/dac/mcp47feb02.h b/drivers/iio/dac/mcp47feb02.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..5dee70cb67bf3aca52a0234d30aea1561aa12c58
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47feb02.h


> +/* Register addresses must be left shifted by 3 bits in order to append the command mask */
> +#define MCP47FEB02_DAC0_REG_ADDR			0x00
> +#define MCP47FEB02_VREF_REG_ADDR			0x40
> +#define MCP47FEB02_POWER_DOWN_REG_ADDR			0x48
> +#define MCP47FEB02_DAC_CTRL_MASK			GENMASK(1, 0)

Is the the command mask?  Odd mismatch in naming if so. Perhaps update the comment
to match whilst doing this move.

So far I'm not seeing a reason to move these all to the header. They don't
seem to be used in the i2c specific file.

> +
> +#define MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR		0x50
> +#define MCP47FEB02_GAIN_BIT_MASK			BIT(0)
> +#define MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK		BIT(6)
> +#define MCP47FEB02_GAIN_BITS_MASK			GENMASK(15, 8)

...

> +
> +enum mcp47feb02_vref_mode {
> +	MCP47FEB02_VREF_VDD = 0,
> +	MCP47FEB02_INTERNAL_BAND_GAP = 1,
> +	MCP47FEB02_EXTERNAL_VREF_UNBUFFERED = 2,
> +	MCP47FEB02_EXTERNAL_VREF_BUFFERED = 3,
> +};

Similar to the above - I'd not expect to see these in the buffer specific
drivers, so can we keep the definitions in the core c file?

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
> +/**
> + * struct mcp47feb02_channel_data - channel configuration
> + * @scale_avail: scales available for the channel based on current configuration
> + * @dac_data: DAC value
> + * @ref_mode: chosen voltage for reference
> + * @powerdown_mode: selected power-down mode
> + * @powerdown: is false if the channel is in normal operation mode
> + * @use_2x_gain: output driver gain control
> + * @ref_mismatch: true if the restored register configuration is different from the device tree one
> + */
> +struct mcp47feb02_channel_data {
> +	int *scale_avail;
> +	u16 dac_data;
> +	u8 ref_mode;
> +	u8 powerdown_mode;
> +	bool powerdown;
> +	bool use_2x_gain;
> +	bool ref_mismatch;
> +};
> +
> +/**
> + * struct mcp47feb02_data - chip configuration
> + * @chdata: options configured for each channel on the device
> + * @lock: prevents concurrent reads/writes to driver's state member
> + * @chip_features: pointer to features struct
> + * @scale_1: scales set on channels that are using Vref1
> + * @scale_0: scales set on channels that are using Vref/Vref0
> + * @active_channels_mask: enabled channels
> + * @regmap: regmap for directly accessing device register
> + * @labels: table with channels labels
> + * @vref1_reg: Vref1 regulator to be enabled after correcting reference mismatch
> + * @vref_reg: Vref/Vref0 regulator to be enabled after correcting reference mismatch
> + * @phys_channels: physical channels on the device
> + * @vref1_buffered: Vref1 buffer is enabled
> + * @vref_buffered: Vref/Vref0 buffer is enabled
> + * @use_vref1: vref1-supply is defined
> + * @use_vref: vref-supply is defined
> + * @vref1_enabled: true if Vref1 regulator has been enabled
> + * @vref_enabled: true if Vref/Vref0 regulator has been enabled
> + */
> +struct mcp47feb02_data {
> +	struct mcp47feb02_channel_data chdata[MCP47FEB02_MAX_CH];
> +	struct mutex lock; /* prevents concurrent reads/writes to driver state */
> +	const struct mcp47feb02_features *chip_features;
> +	int scale_1[2 * MCP47FEB02_MAX_SCALES_CH];
> +	int scale_0[2 * MCP47FEB02_MAX_SCALES_CH];
> +	unsigned long active_channels_mask;
> +	struct regmap *regmap;
> +	const char *labels[MCP47FEB02_MAX_CH];
> +	struct regulator *vref_reg;
> +	struct regulator *vref1_reg;
> +	u16 phys_channels;
> +	bool vref1_buffered;
> +	bool vref_buffered;
> +	bool use_vref1;
> +	bool use_vref;
> +	bool vref1_enabled;
> +	bool vref_enabled;
> +};
> +
> +extern const struct regmap_config mcp47feb02_regmap_config;
> +extern const struct regmap_config mcp47fvb02_regmap_config;
> +
> +/* Properties shared by I2C families */
> +int mcp47feb02_common_probe(const struct mcp47feb02_features *chip_features, struct regmap *regmap);

That's a very long line. I'd break it after ,

> +
> +extern const struct dev_pm_ops mcp47feb02_pm_ops;
> +
> +#endif /* _MCP47FEB02_H_ */
> 
> ---
> base-commit: 8625d418d24bc0ff463267b26b7cb2e7a612495f
> change-id: 20260331-mcp47feb02-fix2-95c6baa7fb2b
> 
> Best regards,

