Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB63D3D01;
	Wed, 20 May 2026 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278743; cv=none; b=C39JrvecnpESaSrg4z+SE2yHT0K7LHC8yQ0uQ2IRdxISD+2PWUv8hP95UlgYLPI9r8p8EpWS2RqE3wKH1wQi1lzUguD+tVf7O6nE0jP1J6uZZVueymOd3lUhyNnTqTwfR1d7xxqaGPuBvN+ANNHZ+AQV9fP8YpwLBlrNul+DbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278743; c=relaxed/simple;
	bh=gtaIzIKdPT1IRRHAErnRuoi1PyhDH/Ur18sK+yaPlfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwUuLtVsPo/oQWD0MrK/XEJ7jeXHgXZazqGlYgNoO5BGHI34AyLyGvxpzMIjxjuk5NRqTyD6cbBzrhmy3/yy40B/vg9OdAHKMk2XwVISixnRFdoaao92iJp2DBr3WdIWwFfJeK4SqiI+FyX9JsoSThAw7Jb7AK1ZzdVZ8qYt4/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WioeESbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WioeESbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B091F000E9;
	Wed, 20 May 2026 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779278741;
	bh=YQeI5Pe0M7sD9o6abmKRyl6FWUX73SwdYop7Z57B4UY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WioeESbrAeDmuGu8byeRJuW3AACLHN8Qe+FY9zfuBRJ5tYesd7m1lUNe3BmLrF0d6
	 /jJcT0Tbv6SiGA091lckr4yaOTXvBimuZ2bq8goQ7Hb9M6SMDkbHRfP4vTZI9NCR9w
	 Uzkq8Z8C+tbO+ZbHYmx98+kBRGUXRbHV+pnPhiLh0PTrwvqNZuVQVKUa4vzkm3v52y
	 29gPRHIM8Jf5uxoLlMDNBL7q4gEYHnsZc70iBo2ywsvIN2gIrlB19C+zuj3J6mBNCd
	 Bxagiv50OsD/7/PY1By/41xpNgu62OG4SGN+c3BW4Tm+BxB9rJgLcTwBi3snnds6Ug
	 yQtPj1nD4YbYA==
Date: Wed, 20 May 2026 13:05:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: Add StarFive SAR-ADC driver
Message-ID: <20260520130532.15e65a18@jic23-huawei>
In-Reply-To: <20260518081852.116909-3-xingyu.wu@starfivetech.com>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
	<20260518081852.116909-3-xingyu.wu@starfivetech.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 16:18:52 +0800
Xingyu Wu <xingyu.wu@starfivetech.com> wrote:

> Add a new IIO ADC driver for the StarFive JHB100 SAR ADC controller.
> 
> The hardware provides 12-bit conversion precision and up to 8 input
> channels. This driver supports single-shot channel reads and exposes
> standard IIO interfaces for raw ADC values, processed voltages, and
> scale reporting. The driver also supports channel monitor mode with
> out-of-bound detection and scan frequency configuration.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
Hi

Welcome to IIO.
As Andy indicated there is quite a lot of work to do here.
As such I did a quick review, but a lot of the code will change anyway
as a result of ripping out the custom ABI and the dt-binding changes
requested.

Jonathan

> diff --git a/drivers/iio/adc/starfive-saradc.c b/drivers/iio/adc/starfive-saradc.c
> new file mode 100644
> index 000000000000..78409cb1bcb2
> --- /dev/null
> +++ b/drivers/iio/adc/starfive-saradc.c

> +
> +#define SARADC_CHAN(_index) {					\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = _index,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			BIT(IIO_CHAN_INFO_PROCESSED),		\
See below.

> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.datasheet_name = "SARADC_"#_index,			\
> +	.scan_index = _index,					\
Not used.
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = SARADC_REALBITS,			\
> +		.endianness = IIO_CPU,				\
Not used - so don't specify it.
> +	},							\
> +}

> +
> +static const struct iio_chan_spec starfive_saradc_iio_channels[] = {
> +	SARADC_CHAN(0),
> +	SARADC_CHAN(1),
> +	SARADC_CHAN(2),
> +	SARADC_CHAN(3),
> +	SARADC_CHAN(4),
> +	SARADC_CHAN(5),
> +	SARADC_CHAN(6),
> +	SARADC_CHAN(7),

SARADC is a common name, so prefix macros etc with something related
to starfive.

> +};

> +
> +static void starfive_saradc_ch_lower_bound_set(struct starfive_saradc *priv,
> +					       int ch, u32 data)
> +{
> +	void __iomem *base = priv->base + SARADC_ULB_CHX_REG_GET(ch);
> +	u32 reg = readl(base) & ~ADC_LOWER_BOUND_MSK;
> +
> +	writel(FIELD_PREP(ADC_LOWER_BOUND_MSK, data) | reg, base);
These helpers don't really help much. I'd just put the readl/writel inline
where it's needed.

> +}

> +
> +static struct attribute *starfive_saradc_attributes[] = {
> +	&iio_dev_attr_scan_frequency.dev_attr.attr,
> +	&iio_dev_attr_in_voltage0_upper.dev_attr.attr,
> +	&iio_dev_attr_in_voltage1_upper.dev_attr.attr,
> +	&iio_dev_attr_in_voltage2_upper.dev_attr.attr,
> +	&iio_dev_attr_in_voltage3_upper.dev_attr.attr,
> +	&iio_dev_attr_in_voltage4_upper.dev_attr.attr,
> +	&iio_dev_attr_in_voltage5_upper.dev_attr.attr,
> +	&iio_dev_attr_in_voltage6_upper.dev_attr.attr,
> +	&iio_dev_attr_in_voltage7_upper.dev_attr.attr,
> +	&iio_dev_attr_in_voltage0_lower.dev_attr.attr,
> +	&iio_dev_attr_in_voltage1_lower.dev_attr.attr,
> +	&iio_dev_attr_in_voltage2_lower.dev_attr.attr,
> +	&iio_dev_attr_in_voltage3_lower.dev_attr.attr,
> +	&iio_dev_attr_in_voltage4_lower.dev_attr.attr,
> +	&iio_dev_attr_in_voltage5_lower.dev_attr.attr,
> +	&iio_dev_attr_in_voltage6_lower.dev_attr.attr,
> +	&iio_dev_attr_in_voltage7_lower.dev_attr.attr,
> +	&iio_dev_attr_voltage_monitor_channel.dev_attr.attr,
> +	&iio_dev_attr_voltage_monitor_en.dev_attr.attr,

Look at IIO event support and use that. I'm not seeing anything
in here that should be provided as custom attributes.

Basic rule is that if you add any custom attributes your driver
will get a lot more push back. Key is that
custom attributes == no userspace support in standard code == not much used.


> +	NULL,
> +};
> +
> +static const struct attribute_group starfive_saradc_attr_group = {
> +	.attrs = starfive_saradc_attributes,
> +};
> +
> +static int starfive_saradc_read(struct starfive_saradc *priv)
> +{
> +	unsigned int tmp;
> +	int ret;
> +
> +	starfive_saradc_ch_dis_save(priv);
> +	if (!starfive_saradc_is_ready(priv)) {
> +		dev_err(priv->dev, "ADC do not ready, please try again later!\n");

Generally just return -EBUSY for this - no print because otherwise you provide
a userspace path to spam the kernel logs. If a print is really needed it should
be rate limited.

> +		starfive_saradc_ch_stop(priv);
> +		return -EBUSY;
> +	}
> +
> +	priv->err = false;
> +	starfive_saradc_ch_start(priv);
> +
> +	tmp = starfive_saradc_data_get(priv);
> +	/* Check that the data is ready to be read. */
> +	if (!(tmp & ADC_DAT_RDY_MSK)) {
> +		ret = readl_poll_timeout(priv->base + SARADC_DATAX_REG_GET(priv->using_ch), tmp,
> +					 (tmp & ADC_DAT_RDY_MSK), 10, SARADC_TIMEOUT);
> +		if (ret) {
> +			priv->err = true;
> +			dev_err(priv->dev, "channel%d is still not ready to be read! Timeout!\n",
> +				priv->using_ch);
> +		}
> +	}
> +
> +	if (priv->err)
> +		tmp = 0;
> +
> +	starfive_saradc_ch_stop(priv);
> +
> +	return (int)(tmp & ADC_DAT_MSK);

Prefer FIELD_GET() for all value extraction.

> +}
> +
> +static int starfive_saradc_read_raw(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan,
> +				    int *val, int *val2, long mask)
> +{
> +	struct starfive_saradc *priv = iio_priv(indio_dev);
> +	int ret;
> +	u64 tmp;
> +
> +	mutex_lock(&priv->lock);
guard() and acquire for PM (see below).
But try to do these in the same order in all functions. Makes reasoning
about what is protected simpler.  Normally I'd turn the power on first
as that is reference counted anyway so doesn't need to be under the lock.

> +	priv->using_ch = chan->channel;
> +	ret = pm_runtime_get_sync(priv->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(priv->dev);
As below. the call that failed doesn't have side effects on failure so this
smells like an underflow.

> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = starfive_saradc_read(priv);
> +		if (ret < 0)
> +			break;
> +
> +		*val = ret;
> +		ret = IIO_VAL_INT;
> +		break;
> +
> +	case IIO_CHAN_INFO_PROCESSED:

Don't provide both processed and raw for a channel.

If the transform is linear then _raw + _scale if not then _processed.

> +		ret = starfive_saradc_read(priv);
> +		if (ret < 0)
> +			break;
> +
> +		/* VIN = AVDD * data[11:0] / 4096. (AVDD = 1.8v) */
> +		tmp = SARADC_RAW_TO_VDD_ADJ(ret);
> +		*val = (int)(tmp / 1000000);
> +		*val2 = (int)(tmp % 1000000);
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * AVDD is fixed at 1.8v.
> +		 * 1.8 / (1 << 12) * 1000000
> +		 */
> +		*val = 0;
> +		*val2 = SARADC_AVDD_VOL / (1 << SARADC_REALBITS);

> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	pm_runtime_put_autosuspend(priv->dev);
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t starfive_saradc_mon_stop_threadfn(int irq, void *data)
> +{
> +	struct starfive_saradc *priv = data;
> +	u8 ch = priv->mon_ch;
> +	u32 up, low, raw;
> +
> +	mutex_lock(&priv->lock);
guard()

> +	if (!priv->mon_en) {

How would we get here?  If it's a race on shut down of events then normally
we wouldn't worry as that's just precise timing of disable vs this thread
running.

> +		mutex_unlock(&priv->lock);
> +		return IRQ_HANDLED;
> +	}
> +
> +	raw = readl(priv->base + SARADC_DATAX_REG_GET(ch)) & ADC_DAT_MSK;
> +	up = starfive_saradc_ch_upper_bound_get(priv, ch);
> +	low = starfive_saradc_ch_lower_bound_get(priv, ch);
> +	dev_err(priv->dev,
> +		"channel %d is out of bounds. sample data: %dmv (range: %dmv ~ %dmv)\n",
> +		ch, (SARADC_RAW_TO_VDD_ADJ(raw) / 1000),
> +		priv->low_bounds[ch], priv->up_bounds[ch]);

We have the IIO events infrastructure to report these to userspace. Use it
or drop this. dev_err is not a valid way to report this sort of threshold
events.

> +
> +	starfive_saradc_ch_monitor_stop(priv, ch);

Why stop it?  Add a comment.  We aren't interested in future events?

> +	pm_runtime_put_autosuspend(priv->dev);
> +	mutex_unlock(&priv->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t starfive_saradc_irq_handler(int irq, void *data)
> +{
> +	struct starfive_saradc *priv = data;
> +	u32 irq_err = readl(priv->base + SARADC_IRQ_EN_ST);
> +
> +	if (!priv->mon_working)

How do we hit this condition? If it's a race thing then add a comment
on what that race is. If it's not our interrupt then return IRQ_NONE.

> +		return IRQ_HANDLED;
> +
> +	/* Error of out of bounds */
> +	if (irq_err & BIT(priv->mon_ch)) {
> +		/* Clear the interrupt */
> +		writel(irq_err, priv->base + SARADC_IRQ_EN_ST);
> +		priv->err = true;
> +		return IRQ_WAKE_THREAD;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void starfive_saradc_init(struct starfive_saradc *priv)
> +{
This will probably go away anyway but comments inline for future reference.

> +	bool use_def = false;
> +	u16 up, low, scan, tmp;
> +	u32 upmv, lowmv;
> +	int i;
> +
> +	if (of_property_read_u16(priv->dev->of_node, "upper-bound-mv", &tmp)) {

Use property.h accessors for new drivers, not the of_ones.
They are cleaner and maybe this driver will one day be used with other firmware
types.  Also I don't want of specific code in IIO drivers because it gets cut
and paste into others where another firmware type is actually likely.


> +		use_def = true;
> +	} else {
> +		up = SARADC_VDD_MV_TO_RAW(tmp);
> +		if (up > ADC_UPPER_BOUND_DEF)

If DT provide an invalid input fail to probe. We need that fixed.
If it was a missing property then current convention is to use a check on the property
existing as a separate call before reading it.  That provides neater error handling.


Mind you as per he discussion in that dt-binding thread this is going away.

> +			use_def = true;
> +		else
> +			upmv = tmp;
> +	}
> +
> +	if (use_def) {
> +		up = ADC_UPPER_BOUND_DEF;
> +		upmv = SARADC_RAW_TO_VDD_ADJ(up);
> +		use_def = false;
> +	}
> +
> +	if (of_property_read_u16(priv->dev->of_node, "lower-bound-mv", &tmp)) {
Same for all of these as commnets above. 
> +		use_def = true;
> +	} else {
> +		low = SARADC_VDD_MV_TO_RAW(tmp);
> +		if (low > ADC_UPPER_BOUND_DEF)
> +			use_def = true;
> +		else
> +			lowmv = tmp;
> +	}
> +
> +	if (use_def) {
> +		low = ADC_LOWER_BOUND_DEF;
> +		lowmv = SARADC_RAW_TO_VDD_ADJ(low);
> +	}
> +
> +	if (of_property_read_u16(priv->dev->of_node, "scan-freq", &scan))
> +		scan = ADC_SCAN_FREQ_DEF;
> +
> +	if ((scan & ADC_SCAN_FREQ_MSK) < ADC_SCAN_FREQ_MIN) {
> +		dev_warn(priv->dev, "The scan_freq is out of range and use the default value!\n");
> +		scan = ADC_SCAN_FREQ_DEF;
> +	}
> +
> +	starfive_saradc_scan_freq_set(priv, scan);
> +
> +	for (i = 0; i < SARADC_MAX_CHANNELS; i++) {
> +		starfive_saradc_ch_upper_bound_set(priv, i, up);
> +		starfive_saradc_ch_lower_bound_set(priv, i, low);
> +		priv->up_bounds[i] = upmv;
> +		priv->low_bounds[i] = lowmv;
> +	}
> +}
> +
> +static int starfive_saradc_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +				      unsigned int writeval, unsigned int *readval)
> +{
> +	struct starfive_saradc *priv = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (reg % 4 || reg > SARADC_SCAN_FREQ)
> +		return -EINVAL;
> +
> +	ret = pm_runtime_get_sync(priv->dev);
Look at  PM_RUNTIME_ACQUIRE_AUTOSUSPEND() 
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(priv->dev);

Why? It failed so we should not have a refcount to drop.

> +		return ret;
> +	}
> +
> +	mutex_lock(&priv->lock);
In combination with  the acquire mentioned above, use a guard() for the mutex.
> +
> +	if (readval)
> +		*readval = readl(priv->base + reg);
> +	else if (reg < SARADC_ULB_CH0)
> +		/* Allowed to write from SARADC_ULB_CH0 to SARADC_SCAN_FREQ */
> +		ret = -EINVAL;
With the changes above you can just return here.

> +	else
> +		writel(writeval, priv->base + reg);
> +
> +	mutex_unlock(&priv->lock);
> +	pm_runtime_put_sync_autosuspend(priv->dev);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info starfive_saradc_iio_info = {
> +	.read_raw = starfive_saradc_read_raw,
> +	.debugfs_reg_access = starfive_saradc_reg_access,
> +	.attrs = &starfive_saradc_attr_group,
> +};
> +
> +static int starfive_saradc_probe(struct platform_device *pdev)
> +{
> +	struct starfive_saradc *priv;
> +	struct iio_dev *indio_dev;
> +	int irq, ret;
Worth using a local struct device.
e.g.
	struct device *dev = &pdev->dev;
just to shorten the various lines where it's used.

> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return dev_err_probe(&pdev->dev, -ENOMEM, "failed allocating iio device\n");
This print is a noop for -ENOMEM so don't bother having it.
	if (!indio_dev)
		return -ENOMEM;


> +
> +	priv = iio_priv(indio_dev);
> +	platform_set_drvdata(pdev, indio_dev);
> +	priv->dev = &pdev->dev;
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(&pdev->dev, irq,
> +				     "failed to get irq\n");

One line. Note that going slightly over 80 chars is fine if it helps
readability. I think this one is just under 80 anyway.

> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq,
> +					starfive_saradc_irq_handler,
> +					starfive_saradc_mon_stop_threadfn,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,

Trigger direction should come from DT.  So don't set it here.
We do this historically in some drivers and can't fix it now because some
board might rely on it.  Don't introduce it in a new driver.

> +					dev_name(&pdev->dev), priv);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to request irq handler\n");
> +
> +	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
> +				     "failed to get clock\n");

As sashiko pointed out this might result in a clock underflow.  Fixing
that the mess of devm + runtime pm and working out general patterns is
still a work in progress. For now maybe just check if you get such a warning.


> +
> +	priv->rst = devm_reset_control_array_get_shared(&pdev->dev);
> +	if (IS_ERR(priv->rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->rst),
> +				     "failed to get resets\n");
> +
> +	ret = reset_control_deassert(priv->rst);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to deassert reset\n");
> +
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &starfive_saradc_iio_info;
> +	indio_dev->channels = starfive_saradc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(starfive_saradc_iio_channels);
> +
> +	starfive_saradc_init(priv);
> +	mutex_init(&priv->lock);
> +
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static void starfive_saradc_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);

This is out of order wrt to the setup in probe.   I suspect you can use
devm_pm_runtime_enable() instead and drop remove entirely.

> +}
> +
> +static int starfive_saradc_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct starfive_saradc *priv = iio_priv(indio_dev);
> +
> +	starfive_saradc_pwr_on(priv, false);

Having a function called pwr_on() is missleading given you use it
to turn the power off. Rename it simply pwr() Or consider if it is
worth having the helper at all as it's very small and maybe having
the code inline is simpler.


> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static int starfive_saradc_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct starfive_saradc *priv = iio_priv(indio_dev);
> +	int ret = clk_prepare_enable(priv->clk);
> +
> +	if (ret)
> +		return ret;
slight preference for

	int ret;

	ret = clk_prepare_enable(priv->clk);
	if (ret)
		return ret;

as it keeps the set of ret and it's check right next to each other.
> +
> +	starfive_saradc_pwr_on(priv, true);
> +	/* Need time to completely power on. */
> +	msleep(20);

fsleep() preferred. Takes time in usecs but the point is it will use
the generally right call for whatever the sleep is. That means readers
don't have to think about it. See the docs for the implementation of fsleep()
for more info on how it decides whether to call msleep or not.

If possible reference a datasheet section / table or similar for this sleep
length.  That is helpful if turns out to be too short on some device in
the future.

> +
> +	return 0;
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(starfive_saradc_pm_ops,
> +				 starfive_saradc_runtime_suspend,
> +				 starfive_saradc_runtime_resume, NULL);
> +
> +static const struct of_device_id starfive_saradc_of_match[] = {
> +	{ .compatible = "starfive,jhb100-saradc", },
> +	{ }
> +};
> +
> +static struct platform_driver starfive_saradc_driver = {
> +	.probe	= starfive_saradc_probe,
> +	.remove	= starfive_saradc_remove,
> +	.driver	= {
> +		.name = "starfive_saradc",
> +		.of_match_table = starfive_saradc_of_match,
> +		.pm = pm_ptr(&starfive_saradc_pm_ops)
> +	},
> +};

common practice to not have a blank line here. Dropping it makes
a clear association between the struct platform_driver and the macro
that uses it.

> +
> +module_platform_driver(starfive_saradc_driver);
> +
> +MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
> +MODULE_DESCRIPTION("StarFive Successive Approximation Register ADC driver");
> +MODULE_LICENSE("GPL");

