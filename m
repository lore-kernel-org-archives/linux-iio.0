Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D3238D54;
	Sun, 13 Sep 2026 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789269957; cv=none; b=FPbseP88YF4H3XVS/QUeuowytFBghFJHxHIbIlEOQhGmiQnUNbAlEiDDUCjkkA65fe+VTizX7Dea5z725PQjMIS5xwMi20LDXEM9a5cn299dodu3SNGPdmXOVZPjE2UEvASUDmZEcFf0ulwopiA3kt2aBYhLtdoBJTGdD5i2PWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789269957; c=relaxed/simple;
	bh=n+ysqi0a1NX5c/YyASHQUb1duMHa7O4AEB3NUgadjZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/OOX56oa8uMeCFQK3ViCsy+uGs3BnTFtvpgkQbniSHKgpeWs8kS6ulZr82KzQqjeWuMogoPNmQpTOl9nvpm133XPV6FCG60yGU63OmxXs8s8rpv9m0cxKaZ2hWGsVUxNrImqy0X+IQ7XcVGYv4PHthPSjNlsoynMRdAEIw5Bic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5OdDYaX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5OdDYaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460AF1F000FF;
	Sun, 13 Sep 2026 03:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789269954;
	bh=qUIb14/0OAjAHlQSJSidqNaWRphPPmrzD+AXNTOoLe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K5OdDYaXz71j1JtHhqb4irKRXamfBZLkRP6okXK1bfB/W11/Lkw7lAbdvHqifexHF
	 k9AMbpbpw2p5ZpdWjKv2XOtpjWXJ4+HuJHvRb7MeMasVrd8QGSxQ5+bJyrdoda2O5r
	 aP6HnpL4EY8tI900qc8YLWlSBqGHEU/4B5UlO+UdXBKTrlA/YIxRkX6FbnvI/uEjp7
	 EadxsmBbMmTbIEz1SpMItZwwbOo5SlO3Kh2quBrJlLF54C9FI8JolXaCWCKpT6hkfh
	 iZrtLINmsZ9rm40L/MgwIe8Q3FBAuD71u7jDQgXgXPSOGeSoQd/1Og0EJRnsG5MnLp
	 v9XhjbSi1BMOg==
Date: Sun, 13 Sep 2026 04:25:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Marek Vasut
 <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Cheick Traore <cheick.traore-ext@st.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 3/8] iio: adc: stm32-adc: add support for stm32mp23 and
 stm32mp25
Message-ID: <20260913042548.299b1109@jic23-hlaptop>
In-Reply-To: <20260911-adc-stm32mp25-v1-v1-3-cef26eecdef2@foss.st.com>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
	<20260911-adc-stm32mp25-v1-v1-3-cef26eecdef2@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 17:51:25 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

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
> 
> Co-developed-by: Cheick Traore <cheick.traore-ext@st.com>
> Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
> Co-developed-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Hi. various comment inline. Some stuff will change if the two
compatible solution works out instead of the trigger array
stuff.  There are also some bits I'd like as enabling refactors
where you add the new stuff to support extra variability before
bringing in a the device support that uses it.  Tends to end up more
readble.

>  /* STM32F4 ADC internal common clock prescaler division ratios */
>  static int stm32f4_pclk_div[] = {2, 4, 6, 8};
>  
> +/* STM32MP25 ADC internal common clock prescaler division ratios */
> +static int stm32mp25_presc_div[] = {1, 2, 4, 6, 8, 10, 12, 16, 32, 64, 128, 256};

Spaces after { and before } 
I don't mind the line being a bit longer. Hmm. Local style so maybe leave it
for now.

> +
>  /**
> - * stm32f4_adc_clk_sel() - Select stm32f4 ADC common clock prescaler
> + * stm32_adc_clk_sel() - Select stm32f4 ADC common clock prescaler
>   * @pdev: platform device
>   * @priv: stm32 ADC core private data
>   * Select clock prescaler used for analog conversions, before using ADC.
>   */
> -static int stm32f4_adc_clk_sel(struct platform_device *pdev,
> -			       struct stm32_adc_priv *priv)
> +static int stm32_adc_clk_sel(struct platform_device *pdev,
> +			     struct stm32_adc_priv *priv)
>  {
>  	unsigned long rate;
>  	u32 val;
>  	int i;
>  
> -	/* stm32f4 has one clk input for analog (mandatory), enforce it here */
> +	/* stm32f4/mp25 has one clk input for analog (mandatory), enforce it here */
>  	if (!priv->aclk) {
>  		dev_err(&pdev->dev, "No 'adc' clock found\n");
>  		return -ENOENT;
> @@ -153,20 +166,20 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
>  		return -EINVAL;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(stm32f4_pclk_div); i++) {
> -		if ((rate / stm32f4_pclk_div[i]) <= priv->max_clk_rate)
> +	for (i = 0; i < priv->cfg->num_presc; i++) {
> +		if ((rate / priv->cfg->presc[i]) <= priv->max_clk_rate)
>  			break;
>  	}
> -	if (i >= ARRAY_SIZE(stm32f4_pclk_div)) {
> +	if (i >= priv->cfg->num_presc) {
>  		dev_err(&pdev->dev, "adc clk selection failed\n");
>  		return -EINVAL;
>  	}
>  
> -	priv->common.rate = rate / stm32f4_pclk_div[i];
> -	val = readl_relaxed(priv->common.base + STM32F4_ADC_CCR);
> -	val &= ~STM32F4_ADC_ADCPRE_MASK;
> -	val |= i << STM32F4_ADC_ADCPRE_SHIFT;
> -	writel_relaxed(val, priv->common.base + STM32F4_ADC_CCR);
> +	priv->common.rate = rate / priv->cfg->presc[i];

Where a refactor is needed do it first in an enabling patch
with no new device support, then follow up with the new devices stuff.

You might want to break that enabling up into a couple of patches as there
are multiple things that need to become configurable and it will get
complex in one patch.

> +	val = readl_relaxed(priv->common.base + priv->cfg->regs->ccr);
> +	val &= ~priv->cfg->regs->presc_msk;
> +	val |= i << priv->cfg->regs->presc_shift;
> +	writel_relaxed(val, priv->common.base + priv->cfg->regs->ccr);
>  
>  	dev_dbg(&pdev->dev, "Using analog clock source at %ld kHz\n",
>  		priv->common.rate / 1000);
> @@ -314,6 +327,8 @@ static const struct stm32_adc_common_regs stm32f4_adc_common_regs = {
>  	.ovr_msk = { STM32F4_OVR1, STM32F4_OVR2, STM32F4_OVR3 },
>  	.ier = STM32F4_ADC_CR1,
>  	.eocie_msk = STM32F4_EOCIE,
> +	.presc_msk = STM32F4_ADC_ADCPRE_MASK,
> +	.presc_shift = STM32F4_ADC_ADCPRE_SHIFT,
>  };


> +
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
Feel free to delete this trailing comma whilst you are here.

>  };
>
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 183b3474cad1..42827ce489dd 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c

>  
>  enum stm32_adc_int_ch {
> @@ -86,6 +97,7 @@ enum stm32_adc_int_ch {
>  	STM32_ADC_INT_CH_VDDQ_DDR,
>  	STM32_ADC_INT_CH_VREFINT,
>  	STM32_ADC_INT_CH_VBAT,
> +	STM32_ADC_INT_CH_VDDGPU,
>  	STM32_ADC_INT_CH_NB,

That one shouldn't have a comma as it's just there for counting and must
always be last. Feel free to tidy that up whilst you are here!

>  };
>  
> @@ -105,6 +117,7 @@ static const struct stm32_adc_ic stm32_adc_ic[STM32_ADC_INT_CH_NB] = {
>  	{ "vddq_ddr", STM32_ADC_INT_CH_VDDQ_DDR },
>  	{ "vrefint", STM32_ADC_INT_CH_VREFINT },
>  	{ "vbat", STM32_ADC_INT_CH_VBAT },
> +	{ "vddgpu", STM32_ADC_INT_CH_VDDGPU },

A precursor making all these arrays use
	[STM32_ADC_INT_CH_VBAT] = { "...." } would help avoid the need for static
magic below.


>  };
...

> +/* STM32MP25 external trigger sources for ADC12 */
> +static struct stm32_adc_trig_info stm32mp25_adc12_trigs[] = {
> +	{ TIM1_TRGO, STM32_EXT0 },
> +	{ TIM1_TRGO2, STM32_EXT1 },

> +	{ LPTIM5_OUT, STM32_EXT28 },
> +	{},
As below. Look for others.

> +};
> +
> +/* STM32MP25 external trigger sources for ADC3 */
> +static struct stm32_adc_trig_info stm32mp25_adc3_trigs[] = {

> +	{ LPTIM1_CH1, STM32_EXT24 },
> +	{ LPTIM2_CH1, STM32_EXT25 },
> +	{ LPTIM3_CH1, STM32_EXT26 },
> +	{ LPTIM4_CH1, STM32_EXT27 },
> +	{ LPTIM5_OUT, STM32_EXT28 },
> +	{},

No comma on terminating entries like this +
	{ }
preferred as style for IIO drivers. (random choice but I'd
like consistency across drivers eventually!)

> +};

> @@ -970,7 +1162,8 @@ static int stm32h7_adc_exit_pwr_down(struct iio_dev *indio_dev)
>  
>  	/* Exit deep power down, then enable ADC voltage regulator */
>  	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_DEEPPWD);
> -	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADVREGEN);
> +	if (adc->cfg->has_vregen)

I'd prefer this extra flag came in during a percursor patch (and was
always set during that).  Will reduce the complexity of this patch a touch.

> +		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADVREGEN);
>  
>  	if (adc->cfg->has_boostmode &&
>  	    adc->common->rate > STM32H7_BOOST_CLKRATE)
> @@ -1310,6 +1503,163 @@ static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
>  	stm32h7_adc_enter_pwr_down(adc);
>  }
>  
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
> +
> +	/* Repeat several conversions in calibration mode, average the results */
> +	for (i = 0; i < STM32MP25_CALIB_LOOP; i++) {

	for (unsigned int i = 0; i...

Look for other cases of this that can be simplified given this style
is now allowed in the kernel (has been for last few years).

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

>  
> -static const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
> +/* Internal channel indexes are mapped on stm32_adc_int_ch enum */
> +static const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000, 0 };
>  static_assert(ARRAY_SIZE(stm32_adc_min_ts_h7) == STM32_ADC_INT_CH_NB);
Given we only care about some entries, maybe we should have a precursor
that drops all these static asserts and instead does

static const unsigned int stm32_adc_min_ts_h7[STM32_ADC_INT_CH_NB] = {
	[STM32_ADC_INT_CH_VDDQ_DDR] = 4300,
	.. Only the ones that need to be non 0.
};

> @@ -2728,18 +3098,19 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
>  	.vref_charac = 3300,
>  };
>  
> -static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
> +static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 0, 0, 4300, 9800, 0 };

As below.  If these need to change for some reason, precursor patch. If it were just the
extra entry that would be fine but numbers are changing for earlier entries.

>  static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp1) == STM32_ADC_INT_CH_NB);
>  
>  static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
>  	.regs = &stm32mp1_adc_regspec,
>  	.adc_info = &stm32h7_adc_info,
> -	.trigs = stm32h7_adc_trigs,
> +	.trigs = { stm32h7_adc_trigs, },
>  	.has_vregready = true,
>  	.has_boostmode = true,
>  	.has_linearcal = true,
>  	.has_presel = true,
>  	.has_oversampling = true,
> +	.has_vregen = true,
>  	.start_conv = stm32h7_adc_start_conv,
>  	.stop_conv = stm32h7_adc_stop_conv,
>  	.prepare = stm32h7_adc_prepare,
> @@ -2751,14 +3122,15 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
>  	.vref_charac = 3300,
>  };
>  
> -static const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
> +static const unsigned int stm32_adc_min_ts_mp13[] = { 1000, 1000, 1000, 4300, 9800, 0 };

Why is this existing entry changing?

>  static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp13) == STM32_ADC_INT_CH_NB);
>  
>  static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
>  	.regs = &stm32mp13_adc_regspec,
>  	.adc_info = &stm32mp13_adc_info,
> -	.trigs = stm32h7_adc_trigs,
> +	.trigs = { stm32h7_adc_trigs, },
>  	.has_oversampling = true,
> +	.has_vregen = true,
>  	.start_conv = stm32mp13_adc_start_conv,
>  	.stop_conv = stm32h7_adc_stop_conv,
>  	.prepare = stm32h7_adc_prepare,
> @@ -2770,11 +3142,50 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
>  	.vref_charac = 3300,
>  };


