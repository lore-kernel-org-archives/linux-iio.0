Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5C233B97D;
	Fri,  5 Jun 2026 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684001; cv=none; b=bn247IZJD56XF5BJpnQMu1er/L1NtR6G9sNZV/kVNljyXsj/EdoI8MI6MtKsdg7v+89EqALp96xUbxpgnEqcPT1eGfPGqk/vzYK2vGUHUGn7Flpzp6EOQTLthVgKX82OgeYF5X2TpG9pkXdakkMiCaIX4jVZAlysHL7H6//qWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684001; c=relaxed/simple;
	bh=RjL+gZcb8Pu5u1wQOJtlMZ0HQXrKLaYHiIu5sq1/doo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApNdEuOGsvXTV1bCGjzKqAQxZu0YjdhJpL3Ju8RhWAtOfxsLUEC9+rO19iPVOhPQpNqshPyAND/KYgl8w/Td/BjWCW1yZ009yk/yRM6kT2FiSzogHNOSOUTNnZEzce6d4NLAS+X/NUM+0vCLduD9xEYD2nA3tJnOd3cUyRklLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQMH1M+z; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQMH1M+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780684000; x=1812220000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RjL+gZcb8Pu5u1wQOJtlMZ0HQXrKLaYHiIu5sq1/doo=;
  b=iQMH1M+z/eTe0K+xcJhywTDoV/C8Jqul9PIni81U7DvrhLxaDXDbMp+9
   x2QRiiCNscaUCVS5eUumY5Wp7cuqWHnEgIwvV423i8aOqmfIXNQIIz9Fe
   LHKMCLqkDBsu7y4f7a9KgDbJ1E/hb771GTy5XRp1E6h9eUaMNVqqumDyE
   N3FO9BhQPttBvPdSyTs5e2nCIrL6qaaHmXtE3hmmAnrnUVBMoty933876
   HzmqsNaIG1VLHwQjAOBaKRaHlkgVMqRzKZcOHEP1gjaRddpW6tw9j7gDr
   yskSYV+VGHKE3z0FUSY7BNcOrUhxwL8f0O1z3Hijf2Ba0UMblO6guwGYh
   w==;
X-CSE-ConnectionGUID: QYWTEIHxQMu7FYXV9PqHEg==
X-CSE-MsgGUID: wuF6KD0JTweyS7Tb9lwboA==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="85143590"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="85143590"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:26:40 -0700
X-CSE-ConnectionGUID: JL9ncvhfR626JhODTejIOg==
X-CSE-MsgGUID: wM8N52NTTFmO5KoQMSUNgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="243811759"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:26:36 -0700
Date: Fri, 5 Jun 2026 21:26:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: add Axiado SARADC driver
Message-ID: <aiMU2bOFgKT9NrNQ@ashevche-desk.local>
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
 <20260528-axiado-ax3000-ax3005-saradc-v1-2-345dd5f6608a@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-axiado-ax3000-ax3005-saradc-v1-2-345dd5f6608a@axiado.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 28, 2026 at 01:10:24AM -0700, Petar Stepanovic wrote:
> Add support for the SARADC controller found on Axiado AX3000 and
> AX3005 SoCs.
> 
> The driver supports single-shot voltage reads through the IIO
> subsystem. The number of available input channels is selected from
> the SoC match data, allowing AX3000 and AX3005 variants to use the
> same driver.

(I'll try to not duplicate what Joshua noticed already.)

...

> +config AXIADO_SARADC
> +	tristate "Axiado SARADC driver"
> +	depends on ARCH_AXIADO || COMPILE_TEST

> +	depends on OF

No, in IIO we want a good justification on non-agnostic requirements.
Why can't this device driver be agnostic?

...


> +#include <linux/bitfield.h>

+ bits.h

> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/io.h>

> +#include <linux/kernel.h>

No driver should have this header to be included.
Rare and well justified exceptions are possible
(and no, not in this case).

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>

...

> +struct axiado_saradc {
> +	void __iomem *regs;
> +	struct clk *clk;
> +	unsigned long clk_rate;

> +	int vref_uv;

_uV (yes, capital letter as per SI).

> +	struct mutex lock; /* Serializes ADC conversions. */
> +};

...

> +static int axiado_saradc_conversion(struct axiado_saradc *info,
> +				    struct iio_chan_spec const *chan, int *val)
> +{
> +	unsigned long usecs;

Missing blank line here.

> +	/* Select the channel to be used and trigger conversion */

> +	iowrite32(AX_SARADC_MANUAL_CTRL_EN(chan->channel),
> +		  info->regs + AX_SARADC_MANUAL_CTRL);

Why not writel()?

> +
> +	/* Hardware requires 13 conversion cycles at clk_rate */
> +	usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * 1000000, info->clk_rate);

USe USEC_PER_SEC from time.h.

> +	usleep_range(usecs, usecs + 10);
> +
> +	*val = ioread32(info->regs + AX_SARADC_DOUT) &
> +	       GENMASK(AX_RESOLUTION_BITS - 1, 0);
> +
> +	/* Stop manual conversion */
> +	iowrite32(0, info->regs + AX_SARADC_MANUAL_CTRL);
> +	return 0;
> +}

...

> +static int axiado_saradc_probe(struct platform_device *pdev)
> +{
> +	struct axiado_saradc *info;
> +	const struct axiado_saradc_soc_data *soc_data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +	u32 reg;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +
> +	info->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(info->regs))
> +		return PTR_ERR(info->regs);
> +
> +	info->clk = devm_clk_get_enabled(&pdev->dev, NULL);

Why no name? It will make harder for the next generations of HW in case they
want more than one clock to be used.

> +	if (IS_ERR(info->clk))
> +		return PTR_ERR(info->clk);
> +
> +	info->clk_rate = clk_get_rate(info->clk);
> +	if (!info->clk_rate)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "invalid clock rate\n");

> +	info->vref_uv = devm_regulator_get_enable_read_voltage(&pdev->dev,
> +							       "vref");

Having

	struct device *dev = &pdev->dev;

will make the code shorter and easier to read.

> +	if (info->vref_uv < 0)
> +		return dev_err_probe(&pdev->dev, info->vref_uv,
> +				     "failed to get vref voltage\n");
> +
> +	soc_data = device_get_match_data(&pdev->dev);
> +	if (!soc_data)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "failed to get match data\n");
> +
> +	mutex_init(&info->lock);



> +	reg = FIELD_PREP(AX_SARADC_CH_EN_MASK,
> +			 GENMASK(soc_data->num_channels - 1, 0)) |
> +	      AX_SARADC_SAMPLE_16 | AX_SARADC_MODE | AX_SARADC_ENABLE;

FIELD_PREP_CONST() ?

> +	iowrite32(AX_SARADC_PD, info->regs + AX_SARADC_GLOBAL_CTRL);
> +	iowrite32(reg, info->regs + AX_SARADC_GLOBAL_CTRL);
> +
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->info = &axiado_saradc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = axiado_saradc_iio_channels;
> +	indio_dev->num_channels = soc_data->num_channels;
> +
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to register IIO device\n");
> +
> +	return 0;
> +}

...

> +static const struct of_device_id axiado_saradc_match[] = {
> +	{
> +		.compatible = "axiado,ax3000-saradc",
> +		.data = &ax3000_saradc_data,
> +	},
> +	{
> +		.compatible = "axiado,ax3005-saradc",
> +		.data = &ax3005_saradc_data,
> +	},
> +	{},

No comma for the terminator entry.

> +};

...

> +static struct platform_driver axiado_saradc_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,

We want to have these kind of strings to be fixed.

> +		.of_match_table = axiado_saradc_match,
> +	},
> +	.probe = axiado_saradc_probe,
> +};

> +

Unnecessary blank line.

> +module_platform_driver(axiado_saradc_driver);

-- 
With Best Regards,
Andy Shevchenko


