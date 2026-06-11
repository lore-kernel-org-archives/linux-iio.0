Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C863C9881;
	Thu, 11 Jun 2026 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174894; cv=none; b=HwioCnpYxmnof2NmtaA00oenEl7L1w9PcPX78tqSxfvYCyxeDd689GyRXn7faecdmhaMbuwgpYph1j+FWwYTEGBTdk+DMmnskrmM8kytqO40WzcC0ZPt/02MN6BNKWsFL55iUThFZRaAe1hACaO8i2eD+EFdCR0ky81hP4Dz4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174894; c=relaxed/simple;
	bh=W9pB9DtRk4kvn3JwX+GidSwhJ0s18lhYEd/I1zdnBz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIYmkJ4Cr/b0iyPaJu0ZW5j3gl67K+wCM8WIrh3Kbrl2fxVcdldTkbKysYa+FgvRgXNjJDWxOFjgL37uE/KlLF4Ykr9sS0wzw+etOWFmJjnGeJpOiART8klPZfh4GgBvUXOEAy6AaXfQBEvbwfgneU78FMo1FUJL/WqcQjkAuWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp8xOUoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp8xOUoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FB01F00893;
	Thu, 11 Jun 2026 10:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781174893;
	bh=crmNupD7hZaxlPv3WiFM5BGDGkQfFm+0iK/KcjZ0EVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gp8xOUoJw7DR55PdOTHPoduThWtKOCaI4yUYsuybdRvLig8x4hic9KEcJFBkqLYy3
	 eTqqGarae18Vwav/snfztbmDhU+Cxr5i6UTyDs6R0xuYfQbUwVBsV7IX1xxdAxXAf2
	 mfLjqBhyZz4AwS5Stq/9XCHGyHYfsDf5rVGsjrGGASuzlBm4BDyswgtZasxxYty/l7
	 tFq7XC72F/SS63YJqo7dvJb2GPSkHvpCAVa8f9w91cKaQ4ekZ/NfQ83hkuS2TxXhA+
	 OYFqceyOb0vPJsGcu8i/mz0xDWEZZUJNxgMq3CQmV0kf7BUGpFwqmrDN4lN1o6OB2A
	 MFl2vU6TPSBlQ==
Date: Thu, 11 Jun 2026 11:48:00 +0100
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
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Brian
 Masney <bmasney@redhat.com>
Subject: Re: [PATCH v5 09/10] iio: dac: add mcf54415 DAC
Message-ID: <20260611114800.009d9797@jic23-huawei>
In-Reply-To: <20260610-wip-stmark2-dac-v5-9-b76b83366d5c@baylibre.com>
References: <20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com>
	<20260610-wip-stmark2-dac-v5-9-b76b83366d5c@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 22:35:14 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add basic version of mcf54415 DAC driver. DAC is embedded in the SoC and
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
> is high speed, default format is right-justified 12-bit on 16-bit word.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
I'm lazy so didn't check earlier versions but assume the two bits
of feedback from Sashiko are false positives:
https://sashiko.dev/#/patchset/20260610-wip-stmark2-dac-v5-0-b76b83366d5c%40baylibre.com

The one about clock underflow if resume fails, and then devm cleanup happens later
is a bit nasty.

I did a bit of digging and maybe it is better to just leave the clock on?
The status dev.power.is_suspended is set to false whether or not resume succeeded
and I believe a following suspend will not take into account that resume failed.

I'm not set up to poke the combinations but it might be worth trying that.
+CC common clk people who may immediately know what the right answer is.

Otherwise just a few minor style comments inline.

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
> Changes in v4:
> - remove unused includes
> - sashiko: return "ret" as regmap_read ret value in case of error
> - sashiko: using u32 as regmap_read value
> - use local variable in mcf54415_dac_init() for better readability
> - sashiko: check mcf54415_dac_init return value also in resume()
> Changes in v5:
> - commit syntax fixes
> - minor code style fixes
> - use include <linux/type.h>
> - removed unneeded cast
> - disable clock in case of DAC init error
> - use unsigned int for regmap_read and GENMASK for masking 12 bits
> - add id table to match "mcfdac" platform device name
> ---
>  drivers/iio/dac/Kconfig        |  11 +++
>  drivers/iio/dac/Makefile       |   1 +
>  drivers/iio/dac/mcf54415_dac.c | 216 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 228 insertions(+)
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

Rewrap this.

> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mcf54415_dac.
> +
> diff --git a/drivers/iio/dac/mcf54415_dac.c b/drivers/iio/dac/mcf54415_dac.c
> new file mode 100644
> index 000000000000..f223aa80aabf
> --- /dev/null
> +++ b/drivers/iio/dac/mcf54415_dac.c

> +
> +static int mcf54415_dac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct mcf54415_dac *info;
> +	void __iomem *regs;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +
> +	regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return dev_err_probe(dev, PTR_ERR(regs), "failed to get io regs\n");
> +
> +	info->map = devm_regmap_init_mmio(dev, regs, &mcf54415_dac_regmap_config);
> +	if (IS_ERR(info->map))
> +		return PTR_ERR(info->map);
> +
> +	info->clk = devm_clk_get_enabled(dev, "dac");
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(dev, PTR_ERR(info->clk), "failed getting clock\n");
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	indio_dev->name = "mcf54415";
> +	indio_dev->info = &mcf54415_dac_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &mcf54415_dac_iio_channel;
> +	indio_dev->num_channels = 1;
> +
> +	ret = mcf54415_dac_init(info);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, mcf54415_dac_exit, info);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
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
> +		dev_err(dev, "could not resume device\n");
> +		clk_disable_unprepare(info->clk);
> +	}
> +
> +	return ret;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(mcf54415_dac_pm_ops,
> +				mcf54415_dac_suspend, mcf54415_dac_resume);
> +
> +static const struct platform_device_id mcf54415_dac_ids[] = {
> +	{ .name = "mcfdac", .driver_data = 0 },

Don't set .driver_data if you aren't using it.  Given very strong
preference for always using a pointer for that (rather than a numeric
value) this line will change if you ever add support for more devices
anyway, so no value in having that there now.

> +	{ }, /* sentinel */
	{ }

No comma and I don't see value in the sentinel marking given that is
fairly obvious.

> +};
> +
No blank line here.  Intent is to keep the macro and the function closely
coupled.

> +MODULE_DEVICE_TABLE(platform, mcf54415_dac_ids);


