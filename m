Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CE32ED24;
	Sun, 31 May 2026 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780245445; cv=none; b=tfx2niZAXmJwrJwQaOqDPPnPXL0zgjpGt9C4IPL09GxJlWkTduh0ZY1BXguF+0EwTuCChtH26aDGoQExmF9/CtD+UVE32FSg8/nJgfOw9mYhdnmT8Zb7263lrUSWnGu2W1aONww9/qAYuDCWo2E4u88QgJpv0S1iaYHGTZ0Z0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780245445; c=relaxed/simple;
	bh=8Hro2RJvTUew4VEgwkUlzZI+J4vfV84n0KW/e0e11yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K84PNG6sOu1yPt3bqfiE++XPsUQoQBkVzS9wUXSyikGhQGX9Sc4Wvd7E8/fQH2AMimtVq2yZL5j5sJU6qRem8jC2Y3UhvbFqiVPefoDuUFHUcDcbX4BWqwi6Ruosp9WeLJDyOP9hH2OXXWqqGC/PnWiaFQ0aaYdwcFLvkMG9WGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMWtajpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMWtajpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB461F00893;
	Sun, 31 May 2026 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780245443;
	bh=8dPW62n88YQXm3Z36nWQvCD7sx0nKMwKDYpNZjRfzAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KMWtajpBY0KRKAKVL+H/b4P+QmKnJzbK8NIAENgKdrv84uTTuuCoONUfMnivH38F7
	 GdjUn2ym94LkI4H7IV2bgIIHxjT080IJjKKqqx/Y1wSbYllh5PTPOUJQwGoF7cIZNh
	 02cJgw/QcMM3M4jjqJG9U6DSHhsEfhZmM6hRCPDmssTTXvG1q9MiUMScF58txE+/0I
	 2fxUNYHaZyrTkdJYFMYYzbmk/W9a9sDZchwGcbbfxI3XK68KekzMcgLyHMIXaaPdw0
	 IUwfqdVW3JZVxPJ0hD5NAGxjB3Uc8c7R0ND9PbBnzlxCxwd1BuWHAaglUvmsI1CjkE
	 EMBBTUFzNwJjA==
Date: Sun, 31 May 2026 17:37:12 +0100
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
Subject: Re: [PATCH v4 11/11] iio: dac: add mcf54415 DAC
Message-ID: <20260531173712.4295981a@jic23-huawei>
In-Reply-To: <20260531-wip-stmark2-dac-v4-11-7e65ab4215dd@baylibre.com>
References: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
	<20260531-wip-stmark2-dac-v4-11-7e65ab4215dd@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 17:26:04 +0200
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
https://sashiko.dev/#/patchset/20260531-wip-stmark2-dac-v4-0-7e65ab4215dd%40baylibre.com
Has some comments.

My assumption is the DAC registers are not going to be wiped out by
reset, so that one is wrong.

For the others they are the fun question of what do we do if resume()
fails and leaves the device effectively disabled.  I'm not that bothered
if the answer is everything fails.

So just really minor stuff inline.  

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
> Changes in v4:
> - remove unused includes
> - sashiko: return "ret" as regmap_read ret value in case of error
> - sashiko: using u32 as regmap_read value
> - use local variable in mcf54415_dac_init() for better readability
> - sashiko: check mcf54415_dac_init return value also in resume()

> diff --git a/drivers/iio/dac/mcf54415_dac.c b/drivers/iio/dac/mcf54415_dac.c
> new file mode 100644
> index 000000000000..474a2c327fcd
> --- /dev/null
> +++ b/drivers/iio/dac/mcf54415_dac.c

> +
> +static int mcf54415_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct mcf54415_dac *info = iio_priv(indio_dev);
> +	int ret;
> +	u32 reg;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(info->map, MCF54415_DAC_DATA, &reg);
> +		if (ret)
> +			return ret;
> +		*val = (int)reg & 0xfff;

Given it's unsigned and the masking means it will fit, I don't see an
obvious reason for needing the cast. Compiler should be able to tell it
can always safely assign this.  Maybe GENMASK(11, 0) would be slightly
nicer than 0xfff but up to you as 3 fs isn't easy to count ;)

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

> +
> +static int mcf54415_dac_suspend(struct device *dev)
> +{
> +	struct mcf54415_dac *info = iio_priv(dev_get_drvdata(dev));
> +
> +	mcf54415_dac_exit(info);
> +	clk_disable_unprepare(info->clk);
> +
> +	return 0;
> +}
> +
> +static int mcf54415_dac_resume(struct device *dev)
> +{
> +	struct mcf54415_dac *info = iio_priv(dev_get_drvdata(dev));
> +	int ret;
> +
> +	ret = clk_prepare_enable(info->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = mcf54415_dac_init(info);
> +	if (ret) {

Generally we aim for side effect free failure, so I think I agree
with sashiko that you should be turning off the clk again here.
Any failure in here should leave device suspended.  That then leaves
us with a dead clock and the shut down path may still try to access
the device. 

Anyhow, I'd add the clk_disable_unprepare() call here for consistency
even though it doesn't really help us with carrying on.

> +		dev_err(dev, "could not resume device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(mcf54415_dac_pm_ops,
> +				mcf54415_dac_suspend, mcf54415_dac_resume);
> +
> +static struct platform_driver mcf54415_dac_driver = {
> +	.probe = mcf54415_dac_probe,
> +	.driver = {
> +		.name = "mcf54415_dac",
> +		.pm = pm_sleep_ptr(&mcf54415_dac_pm_ops),
> +	},
> +};
> +module_platform_driver(mcf54415_dac_driver);
> +
> +MODULE_AUTHOR("Angelo Dureghello <angelo@kernel-space.org>");
> +MODULE_DESCRIPTION("NXP MCF54415 DAC driver");
> +MODULE_LICENSE("GPL");
> 

