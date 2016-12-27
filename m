Return-Path: <SRS0=s1Yq=YK=linaro.org=bjorn.andersson@kernel.org>
Date: Mon, 26 Dec 2016 22:58:14 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	"Ivan T . Ivanov" <iivanov.xz@gmail.com>,
	Andy Gross <andy.gross@linaro.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/3 v2] iio: adc: add a driver for Qualcomm PM8xxx
 HK/XOADC
Message-ID: <20161227065814.GC10531@minitux>
References: <1481842118-14095-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481842118-14095-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu 15 Dec 14:48 PST 2016, Linus Walleij wrote:

> The Qualcomm PM8xxx PMICs contain a simpler ADC than its
> successors (already in the kernel as qcom-spmi-adc.c):
> the HK/XO ADC (Housekeeping/Chrystal oscillator ADC).
> 
> As far as I can understand this is equal to the PMICs
> using SSBI transport and encompass PM8018, PM8038,
> PM8058, PM8917 and PM8921, so this is shortly named
> PM8xxx.
> 
> This ADC monitors a bunch of on-board voltages and the die
> temperature of the PMIC itself, but it can also be routed
> to convert a few external MPPs (multi-purpose pins). On
> the APQ8060 DragonBoard this feature is used to let this
> ADC convert an analog ALS (Ambient Light Sensor) voltage
> signal from a Capella CM3605 ALS into a LUX value.
> 
> Developed and tested with APQ8060 DragonBoard based on
> Ivan's driver. The SPMI VADC driver is quite different,
> but share enough minor functionality that I have split
> out to the common file in a previous patch.

I gave this a spin on one of my APQ8064 devices - with PM8921 - and I
can do measurements.

Several of the channels do give me reasonable readings. But the channels
in PM8921 are different than PM8058, so it looks like we need additional
prescales defined. Further more, the 8921 has several different
thermo-related channels, each with their own (post-)scaling function.

And lastly it seems that I have 2 thermo-channels on "mpp amux", but I'm
still confused to how that is supposed to work in the downstream code -
I will need to investigate this further.


One of the channels defined in my APQ8064 device measures
ADC_MPP_1_AMUX5, a lookup table is used to convert the measured value to
a temperature. As the table depends on an external thermistor, which
seems to differ between products a number of lookup tables exists - with
156 data points each.

[..]
> +
> +/*
> + * The different channels have hard-coded prescale ratios defined
> + * by the hardware.
> + */
> +static const struct vadc_prescale_ratio adc_prescale_ratios[] = {
> +	{ .num = 1, .den = 2 }, /* CHANNEL_VCOIN */
> +	{ .num = 1, .den = 3 }, /* CHANNEL_VBAT */
> +	{ .num = 1, .den = 10 }, /* CHANNEL_VCHG */
> +	{ .num = 1, .den = 1 }, /* CHANNEL_CHG_MONITOR */
> +	{ .num =  1, .den = 3 }, /* CHANNEL_VPH_PWR */
> +	{ .num =  1, .den = 1 }, /* CHANNEL_MPP5 */
> +	{ .num =  1, .den = 1 }, /* CHANNEL_MPP6 */
> +	{ .num =  1, .den = 2 }, /* CHANNEL_MPP7 */
> +	{ .num =  1, .den = 2 }, /* CHANNEL_MPP8 */
> +	{ .num =  1, .den = 3 }, /* CHANNEL_MPP9 */
> +	{ .num =  1, .den = 3 }, /* CHANNEL_USB_VBUS */
> +	{ .num =  1, .den = 1 }, /* CHANNEL_DIE_TEMP */
> +	{ .num =  1, .den = 1 }, /* CHANNEL_INTERNAL */
> +	{ .num =  1, .den = 1 }, /* CHANNEL_125V */
> +	{ .num =  1, .den = 1 }, /* CHANNEL_INTERNAL_2 */
> +	{ .num =  1, .den = 1 }, /* CHANNEL_MUXOFF */
> +};

The pm8921 have different meaning for the channels and the prescale
values are hence different. In the downstream kernel the values comes
from the board file, but I don't know if that means they will ever
change.

[..]
> +
> +static int pm8xxx_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct pm8xxx_xoadc *adc = iio_priv(indio_dev);
> +	const struct pm8xxx_chan_info *ch;
> +	u16 adc_code;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		/* Only die temperature ends up here */
> +		ch = pm8xxx_get_channel(adc, chan->address);
> +		if (!ch) {
> +			dev_err(adc->dev, "no such channel %lu\n",
> +				chan->address);
> +			return -EINVAL;
> +		}
> +		ret = pm8xxx_read_channel(adc, ch, &adc_code);
> +		if (ret)
> +			return ret;
> +		*val = pm8xxx_calibrate(adc, ch, adc_code);
> +		/* 2mV/K, return milli Celsius */
> +		*val /= 2;
> +		*val -= KELVINMIL_CELSIUSMIL;

On my 8064 device I have 6 different temperatures (2 coming from amux'ed
mpp channels). They all have different lookup tables, which seems
calibrated based on some external resistor.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			ch = pm8xxx_get_channel(adc, chan->address);
> +			if (!ch) {
> +				dev_err(adc->dev, "no such channel %lu\n",
> +					chan->address);
> +				return -EINVAL;
> +			}
> +			ret = pm8xxx_read_channel(adc, ch, &adc_code);
> +			if (ret)
> +				return ret;
> +			*val = pm8xxx_calibrate(adc, ch, adc_code);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Applies to all voltage channels: we scale the microvolts
> +		 * to millivolts as required by the userspace ABI.
> +		 */
> +		*val = 0;
> +		*val2 = 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int pm8xxx_of_xlate(struct iio_dev *indio_dev,
> +			   const struct of_phandle_args *iiospec)
> +{
> +	struct pm8xxx_xoadc *adc = iio_priv(indio_dev);
> +	unsigned int i;
> +
> +	for (i = 0; i < adc->nchans; i++)
> +		if (adc->iio_chans[i].channel == iiospec->args[0])
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info pm8xxx_xoadc_info = {
> +	.driver_module = THIS_MODULE,
> +	.of_xlate = pm8xxx_of_xlate,
> +	.read_raw = pm8xxx_read_raw,
> +};
> +
> +static int pm8xxx_xoadc_parse_channel(struct device *dev,
> +				      struct device_node *np,
> +				      struct pm8xxx_chan_info *ch)
> +{
> +	const char *name = np->name;
> +	u32 chan, rsv, dec;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "reg", &chan);
> +	if (ret) {
> +		dev_err(dev, "invalid channel number %s\n", name);
> +		return ret;
> +	}
> +	if (chan > XOADC_CHAN_MAX) {
> +		dev_err(dev, "%s too big channel number %d\n", name, chan);
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_bool(np, "qcom,ratiometric")) {
> +		ch->calibration = VADC_CALIB_RATIOMETRIC;
> +		ret = of_property_read_u32(np, "qcom,ratiometric-ref", &rsv);

If this is what you intended, you can squash the two properties into
one.

> +		if (ret) {
> +			dev_err(dev, "invalid RSV %s\n", name);
> +			return ret;
> +		}
> +		if (rsv > XOADC_RSV_MAX) {
> +			dev_err(dev, "%s too large RSV value %d\n", name, rsv);
> +			return -EINVAL;
> +		}
> +		if (rsv == AMUX_RSV3) {
> +			dev_err(dev, "%s invalid RSV value %d\n", name, rsv);
> +			return -EINVAL;
> +		}
> +	} else {
> +		ch->calibration = VADC_CALIB_ABSOLUTE;
> +		rsv = 0;
> +	}
> +
> +	ret = of_property_read_u32(np, "qcom,decimation", &dec);
> +	if (!ret) {
> +		/* It's OK to skip this ... */
> +		ret = qcom_vadc_decimation_from_dt(dec);
> +		if (ret < 0) {
> +			dev_err(dev, "%s invalid decimation %d\n",
> +				name, dec);
> +			return ret;
> +		}
> +		ch->decimation = ret;
> +	} else {
> +		ch->decimation = VADC_DEF_DECIMATION;
> +	}
> +
> +	ch->amux_channel = chan;
> +	ch->name = name;
> +	ch->amux_ip_rsv = rsv;
> +	ch->amux_mpp_channel = PREMUX_MPP_SCALE_0; /* FIXME: get from DT */

After reading the code related to "amux/mpp" I've quite confused, it
does indeed look like the only thing done is to apply some scaling to
the value - but this doesn't make sense looking at the board files and
naming of the defines used downstream.

I will have to try to find some hints in the documentation and play
around with this a little bit more.

> +
> +	dev_dbg(dev, "channel %d \"%s\" ref voltage: %d, decimation %d\n",
> +		ch->amux_channel,
> +		ch->name,
> +		ch->amux_ip_rsv,
> +		ch->decimation);
> +	return 0;
> +}
> +
> +static int pm8xxx_xoadc_parse_channels(struct pm8xxx_xoadc *adc,
> +				       struct device_node *np)
> +{
> +	struct device_node *child;
> +	struct pm8xxx_chan_info *ch;
> +	int ret;
> +	int i;
> +
> +	adc->nchans = of_get_available_child_count(np);
> +	if (!adc->nchans) {
> +		dev_err(adc->dev, "no channel children\n");
> +		return -ENODEV;
> +	}
> +	dev_dbg(adc->dev, "found %d ADC channels\n", adc->nchans);
> +
> +	adc->iio_chans = devm_kcalloc(adc->dev, adc->nchans,
> +				      sizeof(*adc->iio_chans), GFP_KERNEL);
> +	if (!adc->iio_chans)
> +		return -ENOMEM;
> +
> +	adc->chans = devm_kcalloc(adc->dev, adc->nchans,
> +				  sizeof(*adc->chans), GFP_KERNEL);
> +	if (!adc->chans)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	for_each_available_child_of_node(np, child) {
> +		struct iio_chan_spec *iio_chan;
> +
> +		ch = &adc->chans[i];
> +		ret = pm8xxx_xoadc_parse_channel(adc->dev, child, ch);
> +		if (ret) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +
> +		iio_chan = &adc->iio_chans[i];
> +		iio_chan->channel = ch->amux_channel;
> +		iio_chan->datasheet_name = ch->name;
> +		/* A single temperature channel, the rest are voltages */
> +		if (ch->amux_channel == CHANNEL_DIE_TEMP) {
> +			iio_chan->type = IIO_TEMP;
> +			iio_chan->info_mask_separate =
> +				BIT(IIO_CHAN_INFO_PROCESSED);
> +		} else {
> +			iio_chan->type = IIO_VOLTAGE;
> +			iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_SCALE);
> +		}
> +		iio_chan->indexed = 1;
> +		iio_chan->address = ch->amux_channel;
> +
> +		i++;
> +	}
> +
> +	/* Check for required channels */
> +	ch = pm8xxx_get_channel(adc, CHANNEL_125V);
> +	if (!ch) {
> +		dev_err(adc->dev, "missing 1.25V reference channel\n");
> +		return -ENODEV;
> +	}
> +	ch = pm8xxx_get_channel(adc, CHANNEL_INTERNAL);
> +	if (!ch) {
> +		dev_err(adc->dev, "missing 0.625V reference channel\n");
> +		return -ENODEV;
> +	}
> +	ch = pm8xxx_get_channel(adc, CHANNEL_MUXOFF);
> +	if (!ch) {
> +		dev_err(adc->dev, "missing MUXOFF reference channel\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pm8xxx_xoadc_probe(struct platform_device *pdev)
> +{
> +	struct pm8xxx_xoadc *adc;
> +	struct iio_dev *indio_dev;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct regmap *map;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	adc = iio_priv(indio_dev);
> +	adc->dev = dev;
> +	init_completion(&adc->complete);
> +	mutex_init(&adc->lock);
> +
> +	ret = pm8xxx_xoadc_parse_channels(adc, np);
> +	if (ret)
> +		return ret;
> +
> +	map = dev_get_regmap(dev->parent, NULL);
> +	if (!map) {
> +		dev_err(dev, "Parent regmap unavailable.\n");
> +		return -ENXIO;
> +	}
> +	adc->map = map;
> +
> +	/* Bring up regulator */
> +	adc->vref = devm_regulator_get(dev, "xoadc-ref");
> +	if (IS_ERR(adc->vref)) {
> +		dev_err(dev, "failed to get XOADC VREF regulator\n");
> +		return PTR_ERR(adc->vref);
> +	}
> +	/* We strictly require this voltage */
> +	ret = regulator_set_voltage(adc->vref, 2200000, 2200000);

On 8064 the reference is L14 and it's at 1.8V, so this fails for me.

However, the way that this is written should reflect on the board design
and your L18 (and my L14) will have a single valid value. As such  there
should be no need to set a voltage here (other then to catch mistakes).

> +	if (ret) {
> +		dev_err(dev, "unable to set LDO18 voltage to 2.2V\n");
> +		return ret;
> +	}

Regards,
Bjorn
