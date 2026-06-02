Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885533EB17;
	Tue,  2 Jun 2026 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393164; cv=none; b=ahPNqj9Tj/fL4FtXyB95vrj8IKqDZpibDykN2vV5M0SoWTAno/JnCCFUKApVN+UEyq3l0vziT19SsRIcnU197DQM1HNRcZoK7TV3W2rKrykyDJaXhTPI+jpp1U2Sva1hTDzTlI0a1sql0vI0x+/+hj99S9Nyeqtn9CwQxRsz/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393164; c=relaxed/simple;
	bh=5oC8ksAHTf+xBVKyW06yVS5MRSz5ZtAoCm0qkxSJeZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghN/4VrvVDS3RL3MnbsjQAI2tlL6VjRojj3lFhEYqstS/tUHFnMIe3uAsoLDRk2DPc8M4L5j2dVnSn6DXBT1YRsmys16tu5euZe917mywmxlCvWwrKQ4hBRo1vN8Osjggt4mUBV0GgIH6x/2O1ujPJ5dFA2t1eewXhw/Lbpqz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anAfl9sZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anAfl9sZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780393163; x=1811929163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5oC8ksAHTf+xBVKyW06yVS5MRSz5ZtAoCm0qkxSJeZQ=;
  b=anAfl9sZRTXk9XITFCRcEdKloCnlhxXPxO2Fx6I1TAyb/tp1rPb89mra
   wKCxvlBUOTK+qgxyJk8V18nLIBwE2ga8nNKnwkc+mj+t4RvHmp7XS0cts
   vCArkpS9BtA7Phk8wuwMqGjHmGphH2dOdSPyw0AKXM2pmKYxzDDKtanoa
   8ZoxX+4A+jqXoi/ws5iggzagsGQB3AuvUuU0XeVT2kcNlvfCh/Xdzfd07
   fGiRqGAGvj8w/LUMn1JR53hTC4s79lUnP7xFCMClRHSnonlyivLdfXWcG
   4xYrtU5mJ80wrO2xIrWLNLlms0xE4EIaL9gvrVCDlIWbgOn62OooN6Qjz
   A==;
X-CSE-ConnectionGUID: rdIMwW/KTy6k8bALpuTbWg==
X-CSE-MsgGUID: O1SYgpBVRY+IZrVDbYZpXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84797710"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="84797710"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:39:22 -0700
X-CSE-ConnectionGUID: gSzDEjBvT1axWlMMHfCJ4A==
X-CSE-MsgGUID: N47fI6AOTuSPh76YjMJXmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="267722861"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:39:18 -0700
Date: Tue, 2 Jun 2026 12:39:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 11/11] iio: dac: add mcf54415 DAC
Message-ID: <ah6kw-oTM9jgkWBL@ashevche-desk.local>
References: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
 <20260531-wip-stmark2-dac-v4-11-7e65ab4215dd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531-wip-stmark2-dac-v4-11-7e65ab4215dd@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 31, 2026 at 05:26:04PM +0200, Angelo Dureghello wrote:

> Add basic version of mcf54415 DAC driver. DAC is embedded in the cpu and

CPU

(or maybe you wanted use 'SoC' acronym)

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

Be consistent: 12-bit on 16-bit

...

> Changes in v4:
> - remove unused includes
> - sashiko: return "ret" as regmap_read ret value in case of error

> - sashiko: using u32 as regmap_read value

Why? regmap API uses 'unsigned int'. Then you can take out any bits, fields,
et cetera from it into fixed-width type of variables.

> - use local variable in mcf54415_dac_init() for better readability
> - sashiko: check mcf54415_dac_init return value also in resume()

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>

> +#include <linux/compiler_types.h>

Drop this (see below).

> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

+ types.h (it also guarantees compile_types.h).

...

> +static int mcf54415_dac_init(struct mcf54415_dac *info)
> +{
> +	int ret;
> +	u16 val = MCF54415_DAC_CR_FILT | FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1);

Can we move towards reversed xmas tree order?

	u16 val = MCF54415_DAC_CR_FILT | FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1);
	int ret;

> +	/* Fixed defaults and enable DAC (bit 0 set to 0) */
> +	ret = regmap_write(info->map, MCF54415_DAC_CR, val);
> +	if (ret)
> +		return ret;
> +
> +	/* DAC is ready after 12us, from RM table 40-3  */
> +	fsleep(12);
> +
> +	return 0;
> +}

...

> +static int mcf54415_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct mcf54415_dac *info = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/* Check based on RM 30.3.2 (DACn_DATA) reg. resolution */
> +		if (val < 0 || val > 4095)
> +			return -EINVAL;
> +		return regmap_write(info->map, MCF54415_DAC_DATA, val);

So, for example, -1 will be written as 0xffffffff (with the respective bits
taken into account). Is it a problem?

> +	default:
> +		return -EINVAL;
> +	}
> +}

...

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
> +		return dev_err_probe(dev, PTR_ERR(regs),
> +				     "failed to get io regs\n");

One line. It's more than decade that checkpatch stopped complaining on
the trailing string literals.

> +	info->map = devm_regmap_init_mmio(dev, regs,
> +					  &mcf54415_dac_regmap_config);

One line (yes, 82 characters).

> +	if (IS_ERR(info->map))
> +		return PTR_ERR(info->map);
> +
> +	info->clk = devm_clk_get_enabled(dev, "dac");
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(dev, PTR_ERR(info->clk),
> +				     "failed getting clock\n");

Also one line.

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

...

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
> +		return ret;
> +	}
> +
> +	return 0;

> +

Besides stray blank line the above can be

	ret = mcf54415_dac_init(info);
	if (ret)
		dev_err(dev, "could not resume device\n");

	return ret;

> +}

-- 
With Best Regards,
Andy Shevchenko


