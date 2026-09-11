Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC983CB2F6;
	Fri, 11 Sep 2026 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143767; cv=none; b=F4LyGv4rASqpq+U8MBjMfds2V8cJhcZJpkHsec6YfXH9DlSNWP3CW/M24u+YDO1oqp1Pgcaf08rTArlwO2dSsB7bP8GjhdiVIqIhqEmko1+nIisok00JVx+Xtb6NeJIfuULNfdtqDBG7KuG74+XL+7Bakz9KvS2XrYQJ15NT9nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143767; c=relaxed/simple;
	bh=o9cs/wE3R289YwEA9DDNeHuwXImTS8/zocoRSd5/fX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9nHoYa/a1hTRbwKuCxujNDEJjcQsG9XJqAI1FtEw8GgrXDlx+z8+T526rP93LMOyCpncsC8tMdJOrjlO2AfKEtKlWlcFEM4lbF+ZfBKbnLL7/0iKhFN4ekUtB8T1CIQLl0h1I2y+kkwxqZHdIZVduJciuQj4qWT6lUX7khhPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nx6eVHHY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nx6eVHHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789143766; x=1820679766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o9cs/wE3R289YwEA9DDNeHuwXImTS8/zocoRSd5/fX0=;
  b=nx6eVHHY9RVJcB9+nLnjeekK3dB3Dg2kxP0LKRUtc2P/xFpMhEACRGgp
   7FAKwKr8s9HF/VOe8BmAPrqTHx5gHeSKQNPTE7MrgmBT/cR/cek8IUMDK
   C+8h5KVg0L6MZT+rbTsApUm3NmtE+07XZtXsI7qxtdwTY0jmpeODTgzlb
   XR/hOtslwdddkmB5/lutw77mE7WuZ7tb/khSIXQ0bQOxAaxCLsZLtVuV5
   9f5Qc2YlEsAluX64/swy5EF8QGpv2yx7itxdnCp6p8eCFPNKw/GPr5/Vz
   mzyv0EdaR7KAXNnphU6SJ+mC91aZ1qFyJJsz3y/SlTKkRRUfMJDQQmTo/
   A==;
X-CSE-ConnectionGUID: VIvzp3OGScSFh7JWepNIwQ==
X-CSE-MsgGUID: f8dHqcAoRKeUHpBikqfjeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89482085"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89482085"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:22:45 -0700
X-CSE-ConnectionGUID: uB5pMXjMSYmJGKekOYsmsQ==
X-CSE-MsgGUID: ilnl7nyQQFGqvjr83fwUUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270197998"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:22:41 -0700
Date: Fri, 11 Sep 2026 19:22:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Marek Vasut <marex@nabladev.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Cheick Traore <cheick.traore-ext@st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 3/8] iio: adc: stm32-adc: add support for stm32mp23 and
 stm32mp25
Message-ID: <aqQqzl-3TBR0yNZl@ashevche-desk.local>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
 <20260911-adc-stm32mp25-v1-v1-3-cef26eecdef2@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-adc-stm32mp25-v1-v1-3-cef26eecdef2@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 05:51:25PM +0200, Fabrice Gasnier wrote:
> Add support for STM32MP23 STM32MP25 SoCs. They have 3 ADCs, split into
> two blocks:
> - ADC12 (ADC1 & ADC2) are tightly coupled.
> - ADC3 is managed independently.
> Trigger list slightly changes between STM32MP23 and STM32MP25.
> 
> Each ADC is a 12-bits successive approximation analog-to-digital converter,
> with up to 20 multiplexed channels that can be configured as single ended
> or differential. ADC resolution ranges from 6 to 12 bits.
> 
> It introduces diversity regarding IRQs, clocks, software calibration
> procedure, internal voltage channels, sampling time (prescaler) and
> trigger list. Most of the architecture, and the driver engine remains
> similar. So, handle the differences w.r.t. other STM32 ADCs family with
> a dedicated compatible and compatible data.
> 
> Trigger list depends on ADC instance, retrieved with "st,adc-trigger-sel"
> property.
> 
> Add support for vddcpu and vddgpu internal channels on stm32mp25.
> These channels are enabled by using ADC option register.
> Add VDDGPU to the list of supported channels in this driver and made
> available on stm32mp25. So update sampling information for all variants
> (with zero'ed data when it's not available).

...

> + * @presc:	clock prescaler array
> + * @num_presc:	number of clock prescalers in presc array

> +	int *presc;
> +	int num_presc;

Why are they signed? I do not see any justification in the kernel doc.

...

>  static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
>  	.regs = &stm32f4_adc_common_regs,
> -	.clk_sel = stm32f4_adc_clk_sel,
> +	.clk_sel = stm32_adc_clk_sel,
> +	.presc = stm32f4_pclk_div,
> +	.num_presc = ARRAY_SIZE(stm32f4_pclk_div),
>  	.max_clk_rate_hz = 36000000,
>  	.num_irqs = 1,
>  	.num_adcs = 3,

>  };

> +static const struct stm32_adc_priv_cfg stm32mp25_adc_priv_cfg = {
> +	.regs = &stm32mp25_adc_common_regs,
> +	.clk_sel = stm32_adc_clk_sel,
> +	.presc = stm32mp25_presc_div,
> +	.num_presc = ARRAY_SIZE(stm32mp25_presc_div),
> +	.max_clk_rate_hz = 70000000,
> +	.ipid = STM32MP25_IPIDR_NUMBER,
> +	.num_irqs = 2, /* 2 IRQs for ADC12, 1 irq for ADC3 */
> +};

Split this patch to two. One prepares the infrastructure for prescaller, and
the other adds a new HW support.

>  static const struct of_device_id stm32_adc_of_match[] = {
>  	{
>  		.compatible = "st,stm32f4-adc-core",
> @@ -895,6 +948,12 @@ static const struct of_device_id stm32_adc_of_match[] = {
>  	}, {
>  		.compatible = "st,stm32mp13-adc-core",
>  		.data = (void *)&stm32mp13_adc_priv_cfg
> +	}, {
> +		.compatible = "st,stm32mp23-adc-core",
> +		.data = (void *)&stm32mp25_adc_priv_cfg
> +	}, {
> +		.compatible = "st,stm32mp25-adc-core",
> +		.data = (void *)&stm32mp25_adc_priv_cfg
>  	}, {
>  	},
>  };

...

>  struct stm32_adc_cfg {
>  	const struct stm32_adc_regspec	*regs;
>  	const struct stm32_adc_info	*adc_info;

> -	const struct stm32_adc_trig_info *trigs;
> +	const struct stm32_adc_trig_info	*trigs[2];

Indentation looks suspicious. I would use just a single space.

>  	bool clk_required;
>  	bool has_vregready;
>  	bool has_boostmode;
>  	bool has_linearcal;
>  	bool has_presel;
>  	bool has_oversampling;
> +	bool has_vregen;
>  	int (*prepare)(struct iio_dev *);
>  	void (*start_conv)(struct iio_dev *, bool dma);
>  	void (*stop_conv)(struct iio_dev *);

...

> struct stm32_adc {

>  	int			int_ch[STM32_ADC_INT_CH_NB];
>  	int			nsmps;
>  	int			ovs_idx;
> +	const struct stm32_adc_trig_info	*trigs;

Ditto. And this shows exactly why the tab formatting is not good. Just a single
space makes it consistent independently on the future development.

>  };

...

> +/* STM32MP23 external trigger sources for ADC12 */
> +static struct stm32_adc_trig_info stm32mp23_adc12_trigs[] = {
> +	{ TIM1_TRGO, STM32_EXT0 },
> +	{ TIM1_TRGO2, STM32_EXT1 },
> +	{ TIM8_TRGO, STM32_EXT2 },
> +	{ TIM8_TRGO2, STM32_EXT3 },
> +	{ TIM2_TRGO, STM32_EXT6 },
> +	{ TIM3_TRGO, STM32_EXT7 },
> +	{ TIM4_TRGO, STM32_EXT8 },
> +	{ TIM5_TRGO, STM32_EXT9 },
> +	{ TIM6_TRGO, STM32_EXT10 },
> +	{ TIM15_TRGO, STM32_EXT11 },
> +	{ TIM1_CH1, STM32_EXT12 },
> +	{ TIM1_CH2, STM32_EXT13 },
> +	{ TIM1_CH3, STM32_EXT14 },
> +	{ TIM2_CH2, STM32_EXT18 },
> +	{ TIM3_CH4, STM32_EXT19 },
> +	{ TIM4_CH4, STM32_EXT20 },
> +	{ TIM5_CH1, STM32_EXT21 },
> +	{ TIM12_CH1, STM32_EXT22 },
> +	{ LPTIM1_CH1, STM32_EXT24 },
> +	{ LPTIM2_CH1, STM32_EXT25 },
> +	{ LPTIM3_CH1, STM32_EXT26 },
> +	{ LPTIM4_CH1, STM32_EXT27 },
> +	{ LPTIM5_OUT, STM32_EXT28 },
> +	{},

The style of the terminator entry is no comma and likely a space inside, but
the latter is optional for custom arrays (the requirement is strong for the ID
tables in IIO).

Ditto for other similar cases. Looking at which I would recommend split the
second patch mentioned above on per-compatible basis, so make it 1 preparatory,
1 with a new HW with some possible additional modifications, and 1 per each
additional compatible line.

> +};

...

> +/*
> + * STM32MP25 offset calibration software procedure. Basically the calibration routine is
> + * expected to average (for example) 8 samples in calibration mode, for single-ended  and
> + * differential channels, to calibrate the zero offset. In case offset is "negative", an
> + * additional offset can be added, to determine calibration factor. It must be kept later
> + * for all conversions.
> + */
> +static int stm32mp25_adc_calib_get_average_data(struct iio_dev *indio_dev, u32 *average)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	const struct stm32_adc_regspec *regs = adc->cfg->regs;
> +	u32 val, avg = 0;
> +	int i, ret;

Why is 'i' signed?

> +
> +	/* Repeat several conversions in calibration mode, average the results */
> +	for (i = 0; i < STM32MP25_CALIB_LOOP; i++) {

Also I don't see the problem with

	for (unsigned int i = 0; i < STM32MP25_CALIB_LOOP; i++) {

> +		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADSTART);
> +		ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
> +						   !(val & (STM32H7_ADSTART)),
> +						   100, STM32_ADC_TIMEOUT_US);
> +		if (ret) {
> +			dev_err(&indio_dev->dev, "calibration average error %d\n", ret);
> +			return ret;
> +		}
> +
> +		val = stm32_adc_readl(adc, regs->dr);
> +		dev_vdbg(&indio_dev->dev, "dr[%d]=0x%08x\n", i, val);
> +		avg += val;
> +	}
> +
> +	*average = DIV_ROUND_CLOSEST(avg, STM32MP25_CALIB_LOOP);
> +	dev_vdbg(&indio_dev->dev, "average=0x%08x\n", *average);
> +
> +	return 0;
> +}

...

> +static int stm32mp25_adc_calib(struct iio_dev *indio_dev)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	u32 calfact = 0, average;
> +	int ret;
> +
> +	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
> +	/* Clears CALADDOS (and old calibration data if any) */
> +	stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, 0);
> +	/* Select single ended input calibration */
> +	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
> +	/* Use default resolution (e.g. 12 bits) */
> +	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR, STM32MP25_RES_MASK);
> +
> +retry:
> +	ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
> +	if (ret)
> +		goto out;
> +
> +	/* If the averaged data is zero, retry with additional offset (set CALADDOS) */
> +	if (!average) {
> +		if (!calfact) {
> +			/* Averaged data is zero, retry with additional offset */
> +			calfact = STM32MP25_CALFACT_CALADDOS;
> +			stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, calfact);
> +			goto retry;
> +		}
> +		/* Averaged data is still zero with additional offset, just warn about it */
> +		dev_warn(&indio_dev->dev, "Single-ended calibration average: 0\n");
> +	}

OMG, try to refactor this to avoid this twisted goto chain.

> +	calfact |= FIELD_PREP(STM32MP25_CALFACT_S_MASK, average);
> +
> +	/* Select differential input calibration (keep previous CALADDOS value) */
> +	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
> +	ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * If the averaged data is below 0x800 (half value in 12-bits mode),
> +	 * retry with additional offset
> +	 */
> +	if (average < BIT(adc->cfg->adc_info->resolutions[0] - 1)) {
> +		if (!(calfact & STM32MP25_CALFACT_CALADDOS)) {
> +			/* Retry the whole calibration with additional offset */
> +			stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
> +			calfact = STM32MP25_CALFACT_CALADDOS;
> +			stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, calfact);
> +			goto retry;
> +		}
> +		/*
> +		 * Averaged data is still below center value. It needs to be clamped to zero,
> +		 * so don't use the result here, warn about it.
> +		 */
> +		dev_warn(&indio_dev->dev, "Differential calibration clamped(0): 0x%x\n", average);
> +	} else {
> +		calfact |= FIELD_PREP(STM32MP25_CALFACT_D_MASK, average);
> +	}
> +
> +	stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, calfact);
> +
> +	dev_dbg(&indio_dev->dev, "set calfact_s=0x%03lx, calfact_d=0x%03lx, calados=%ld\n",
> +		FIELD_GET(STM32MP25_CALFACT_S_MASK, calfact),
> +		FIELD_GET(STM32MP25_CALFACT_D_MASK, calfact),
> +		FIELD_GET(STM32MP25_CALFACT_CALADDOS, calfact));
> +out:
> +	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
> +	stm32_adc_set_res(adc);
> +
> +	return ret;
> +}

...

> +	if (device_property_present(&pdev->dev, "st,adc-trigger-sel")) {
> +		ret = device_property_read_u32(dev, "st,adc-trigger-sel", &trig_id);

Why the first parameter is inconsistent in two device property API calls?

> +		if (ret)
> +			return ret;

No 'else' for the default?

> +	}

...

>  static const struct stm32_adc_cfg stm32f4_adc_cfg = {
>  	.regs = &stm32f4_adc_regspec,
>  	.adc_info = &stm32f4_adc_info,
> -	.trigs = stm32f4_adc_trigs,
> +	.trigs = { stm32f4_adc_trigs, },

When a single line the inner trailing comma is not needed.

>  	.clk_required = true,
>  	.start_conv = stm32f4_adc_start_conv,
>  	.stop_conv = stm32f4_adc_stop_conv,

>  	.vref_charac = 3300,
>  };

...

Overall feeling that this patch is cumbersome of several changes. Please,
split.

-- 
With Best Regards,
Andy Shevchenko


