Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 5 Sep 2016 10:07:48 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
cc: thomas.petazzoni@free-electrons.com, lars@metafoo.de,
    linux-iio@vger.kernel.org, antoine.tenart@free-electrons.com,
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
    knaack.h@gmx.de, maxime.ripard@free-electrons.com, jic23@kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <aed1e00f-ceaa-27e9-502d-51428f59a84f@free-electrons.com>
Message-ID: <alpine.DEB.2.02.1609050924370.12528@pmeerw.net>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com> <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com> <alpine.DEB.2.02.1609041754350.2060@pmeerw.net>
 <aed1e00f-ceaa-27e9-502d-51428f59a84f@free-electrons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> >> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> >> controller and a thermal sensor. This patch adds the ADC driver which is
> >> based on the MFD for the same SoCs ADC.
> > 
> > nitpicking ahead

> [...]
> >> +
> >> +const unsigned int sun4i_gpadc_chan_select(unsigned int chan)
> > 
> > static instead of const?

> static const then?

no, the const is redundant and ignored
-Wignored-qualifiers gives a warning

just static, no const

see
http://stackoverflow.com/questions/12052468/type-qualifiers-on-function-return-type

> >> +{
> >> +	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
> >> +}
> >> +
> >> +struct soc_specific {
> >> +	const int		temp_offset;
> > 
> > wondering why you constify every member?
> > 
> 
> Because they're supposed to be fixed values? It won't change in runtime.
> Is there any reason why I shouldn't do that?

yes, but using the entire struct as const has the same effect;
constifying individual members makes more sense if there are also 
non-const members

nothing wrong, just unusual

> >> +	const int		temp_scale;
> >> +	const unsigned int	tp_mode_en;
> >> +	const unsigned int	tp_adc_select;
> >> +	const unsigned int	(*adc_chan_select)(unsigned int chan);
> >> +};
> [...]
> >> +static int sun4i_gpadc_read(struct iio_dev *indio_dev, int channel, int *val,
> >> +			    unsigned int irq)
> >> +{
> >> +	struct sun4i_gpadc_dev *info = iio_priv(indio_dev);
> >> +	int ret = 0;
> >> +
> >> +	pm_runtime_get_sync(indio_dev->dev.parent);
> >> +	mutex_lock(&info->mutex);
> >> +
> >> +	reinit_completion(&info->completion);
> >> +
> >> +	regmap_write(info->regmap, SUN4I_GPADC_INT_FIFOC,
> >> +		     SUN4I_GPADC_INT_FIFOC_TP_FIFO_TRIG_LEVEL(1) |
> >> +		     SUN4I_GPADC_INT_FIFOC_TP_FIFO_FLUSH);
> > 
> > check retval? here and elsewhere for regmap_write()
> > 
> 
> ACK. What should I do with the retval then?
> 
> There are some in:
> - sun4i_gpadc_read called for read_raws => return which error code (or
> -ret only?)?

I'd just return ret; in the other cases I think it's ok to ignore errors

> - sun4i_gpadc_runtime_suspend => return value of ret, but that would
> cancel the suspend right?
> - sun4i_gpadc_runtime_resume => return value of ret, but that would
> cancel resume right?
> - sun4i_gpadc_probe in the error gotos => probe already failing so do we
> actually care if regmap_update_bits fails? If yes, what's the expected
> behaviour?
> - sun4i_gpadc_remove => return value of ret, but that would mean the
> remove failed right?
> 
> [...]
> >> +static int sun4i_gpadc_read_raw(struct iio_dev *indio_dev,
> >> +				struct iio_chan_spec const *chan, int *val,
> >> +				int *val2, long mask)
> >> +{
> >> +	int ret;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_OFFSET:
> >> +		ret = sun4i_gpadc_temp_offset(indio_dev, val);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		return IIO_VAL_INT;
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		if (chan->type == IIO_VOLTAGE) {
> >> +			ret = sun4i_gpadc_adc_read(indio_dev, chan->channel,
> >> +						   val);
> >> +			if (ret)
> >> +				return ret;
> > 
> > could share the "if (ret) return ret;" between code path
> > 
> 
> ACK.
> 
> [...]
> >> +static int sun4i_irq_init(struct platform_device *pdev, const char *name,
> >> +			  irq_handler_t handler, const char *devname,
> >> +			  unsigned int *irq, atomic_t *atomic)
> >> +{
> >> +	int ret;
> >> +	struct sun4i_gpadc_mfd_dev *mfd_dev = dev_get_drvdata(pdev->dev.parent);
> >> +	struct sun4i_gpadc_dev *info = iio_priv(dev_get_drvdata(&pdev->dev));
> >> +
> >> +	/*
> >> +	 * Once the interrupt is activated, the IP continuously performs
> >> +	 * conversions thus throws interrupts. The interrupt is activated right
> >> +	 * after being requested but we want to control when these interrupts
> >> +	 * occurs thus we disable it right after being requested. However, an
> > 
> > occur
> > 
> 
> ACK for all typos.
> Thanks!
> 
> Quentin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
