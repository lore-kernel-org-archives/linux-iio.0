Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1763D22DFA4;
	Tue, 26 May 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802263; cv=none; b=gvqhE/wYWKRhocLJDOekLKrK8JHT3n3nLmarzJU/OMuv0CU6LCR6w7X0FGjITwsgul9VSREH3h8i5GfCtZaypmBSgIDSJHXa3iQi8EDeHhek5mn9PSNqAd4Sf4ukc+JGLeGLVhlttJymj2cXfFAlPjG+GS5ZAhzCyeToScjxLVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802263; c=relaxed/simple;
	bh=BeT+RqhNkn0jpJ+SIU/uSUnaiPTDO+bspvY4tL8ckrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkaJx58j4JfyoDdE8JJOgYIlA1IlN4aL4C1rxdc+YN4p8SoCjwz7GJEk2qS6GmmfZxLBwVzbNCRQOM5e3TwDl8qTCIcm55BHRZRASiM3qHZgDGkMy7h6F5pXBDxCrk83TEtwnlt5fpVgkzvog9wsM7jnnki8gdh+EGyxglts3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu9Fx7SK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu9Fx7SK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B3F1F000E9;
	Tue, 26 May 2026 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802261;
	bh=zfr++GQ9MeThNDBnulZ1nizhOi2AUmBRDj/hKcyQDuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Gu9Fx7SKsgDY8eiEi5lPhYAtl7pZ9gbntJXKhldJtPOI0OhUJ7yWD06iitx9PFJ+X
	 WNLsvTyWw8R7KXU5pLQJQd8QW8ZVQXSygHThTurzvv1czd3z4H3ZMybywz6AOGctXp
	 107j6PWFsRaDNh4M/45uoSG8rJJgdNlixmLqMkGTif9sG/8W1+Y/HgchuZtgu7klVB
	 VxdzX09FVRxE0BxdbUXzEBoRM+JvJmktPwY3l+gwOQTivbp898Zmn8c2pMegqFkTvD
	 xdUzi+L/9X5ruqxe7uZgSgHBwqJxJjUObtuI4EcFqwzVLnsdIyHMIamF0x1TsyWd5h
	 J7n4Lska0KPFw==
Date: Tue, 26 May 2026 14:30:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann
 <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 11/11] iio: dac: add mcf54415 DAC
Message-ID: <20260526143050.5fca6514@jic23-huawei>
In-Reply-To: <20260522-wip-stmark2-dac-v3-11-16be0ad35a67@baylibre.com>
References: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
	<20260522-wip-stmark2-dac-v3-11-16be0ad35a67@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 23:20:39 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add basic version of mcf54415 DAC driver. DAC is embedded in the cpu and
> DAC configuration registers are mapped in the internal IO address space.
> 
> The DAC accepts a 12-bit digital signal and creates a monotonic 12-bit
> analog output varying from DAC_VREFL to DAC_VREFH. The DAC module
> consists of a conversion unit, an output amplifier, and the associated
> digital control blocks. Default register values for DAC_VREFL and DAC_VREFH
> are respectively 0 and 0xfff, left untouched in this initial version.
> 
> This initial version of the driver is minimalistic, "output raw" only, to
> be extended in the future. DMA and external sync are disabled, default mode
> is high speed, default format is right-justified 12bit on 16bit word.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
https://sashiko.dev/#/patchset/20260522-wip-stmark2-dac-v3-0-16be0ad35a67%40baylibre.com

Given there were only a couple of comments I've included them below alongside
my review.  All minor stuff.

Thanks,

Jonathan

> ---
> Changes in v2:
> - remove tests from commit message, moved to patch 0
> - remove additional blank lines
> - remove dead code and unused definitions
> - use regmap
> - add limit check on raw write
> - non functional style fixes
> - add COMPILE_TEST to Kconfig
> Changes in v3:
> - add comments where needed
> - code style changes
> - remove unneeded variables
> - use regmap_set_bits where possible
> - remove macro not needed to define a single channel
> - set up regmap to big_endian accesses for next patches that will come,
>   that will adjust ColdFire readx/writex as standard LE (links in 0/x).
> - add return value check on regmap calls
> - sashiko: remove unneeded .io_port from regmap init.
> - sashiko: add select REGMAP_MMIO in Kconfig

Looks like you missed or disagreed with the previous sashiko comment on v2 about
type passed to regmap_read()

> ---
>  drivers/iio/dac/Kconfig        |  11 +++
>  drivers/iio/dac/Makefile       |   1 +
>  drivers/iio/dac/mcf54415_dac.c | 207 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 219 insertions(+)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index cd4870b65415..b1a578076188 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -516,6 +516,17 @@ config MAX5821
>  	  Say yes here to build support for Maxim MAX5821
>  	  10 bits DAC.
>  
> +config MCF54415_DAC
> +	tristate "NXP MCF54415 DAC driver"
> +	depends on M5441x || COMPILE_TEST
> +	select REGMAP_MMIO
> +	help
> +	  Say yes here to build support for NXP MCF54415
> +	  12bit DAC.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mcf54415_dac.
> +

> diff --git a/drivers/iio/dac/mcf54415_dac.c b/drivers/iio/dac/mcf54415_dac.c
> new file mode 100644
> index 000000000000..c8c87572d43d
> --- /dev/null
> +++ b/drivers/iio/dac/mcf54415_dac.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * NXP mcf54415 DAC driver
> + *
> + * Copyright 2026 BayLibre - adureghello@baylibre.com
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/compiler_types.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>

not seeing any use of this. I guess it 'evolved' away.
Anyhow, please sanity check these all one more time for v4.

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define MCF54415_DAC_CR			0x00
> +#define MCF54415_DAC_CR_PDN		BIT(0)
> +#define MCF54415_DAC_CR_HSLS		BIT(6)
> +#define MCF54415_DAC_CR_WMLVL		GENMASK(9, 8)
> +#define MCF54415_DAC_CR_FILT		BIT(12)
> +
> +#define MCF54415_DAC_DATA		0x02
> +
> +struct mcf54415_dac {
> +	struct regmap *map;
> +	struct clk *clk;
> +};
> +
> +static const struct regmap_config mcf54415_dac_regmap_config = {
> +	.reg_bits = 16,
> +	.reg_stride = 2,
> +	.val_bits = 16,
> +	.max_register = 0x0c, /* DACX_FILTCNT,  R.M. Table 30-2 */
> +	.val_format_endian = REGMAP_ENDIAN_BIG,
> +	.reg_format_endian = REGMAP_ENDIAN_BIG,
> +};
> +
> +static int mcf54415_dac_init(struct mcf54415_dac *info)
> +{
> +	int ret;
> +
> +	/* Keeping defaults and enable DAC (bit 0 set to 0) */
> +	ret = regmap_write(info->map, MCF54415_DAC_CR, MCF54415_DAC_CR_FILT |
> +			   FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1));

Perhaps use a local variable. It is a tiny bit too easy to miss that
parameter being split over two lines.

	u16 val = MCF54415_DAC_CR_FILT | FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1);

would avoid that.

Alternatively perhaps just reflowing as:
	ret = regmap_write(info->map, MCF54415_DAC_CR,
			   MCF54415_DAC_CR_FILT |
			   FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1));

avoids that reading issue (I read it wrong ;)



> +	if (ret)
> +		return ret;
> +
> +	/* DAC is ready after 12us, from RM table 40-3  */
> +	fsleep(12);
> +
> +	return 0;
> +}

> +
> +static int mcf54415_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct mcf54415_dac *info = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(info->map, MCF54415_DAC_DATA, val);

Sashiko pointed out that regmap_read() expects a u32* so this should use
a local variable for the read.

> +		if (ret)
> +			return -EIO;

Another one sashiko got. Why is this eating the possibly more useful error
code from regmap_read()?

> +		*val &= 0xfff;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Reference voltage as per ColdFire datasheet is 3.3V */
> +		*val = 3300 /* mV */;
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int mcf54415_dac_resume(struct device *dev)
> +{
> +	struct mcf54415_dac *info = iio_priv(dev_get_drvdata(dev));
> +	int ret;
> +
> +	ret = clk_prepare_enable(info->clk);
> +	if (ret)
> +		return ret;
> +
> +	mcf54415_dac_init(info);
If this fails should we report it?  I think you'd at least want
some print to help with debug. (Sashiko got this)

> +
> +	return 0;
> +}


