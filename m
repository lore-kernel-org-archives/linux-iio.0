Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:49794 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750734AbcGDQ1S (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2016 12:27:18 -0400
Date: Mon, 4 Jul 2016 18:27:15 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: sun4i_lradc: new driver
Message-ID: <20160704162715.GK20045@piout.net>
References: <1467406855-9677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1467406855-9677-2-git-send-email-alexandre.belloni@free-electrons.com>
 <d6c47bf9-06b5-f5a2-54c3-3937a4e79def@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d6c47bf9-06b5-f5a2-54c3-3937a4e79def@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/2016 at 13:11:33 +0100, Jonathan Cameron wrote :
> On 01/07/16 22:00, Alexandre Belloni wrote:
> > Add an IIO driver for the Allwinner LRADC.
> To avoid idiots (i.e. me) confusing this with the touch screen ADC
> could you expand a little on the description in future patches.
> 

Sure, one is low resolution, the other one has a better resolution. I
pretty sure that is not completely helpful  :)

> > +/* LRADC_CTRL bits */
> > +#define FIRST_CONVERT_DLY(x)	((x) << 24) /* 8 bits */
> > +#define CHAN_SELECT(x)		((x) << 22) /* 2 bits */
> > +#define CONTINUE_TIME_SEL(x)	((x) << 16) /* 4 bits */
> > +#define KEY_MODE_SEL(x)		((x) << 12) /* 2 bits */
> > +#define LEVELA_B_CNT(x)		((x) << 8)  /* 4 bits */
> > +#define LRADC_HOLD_EN		BIT(6)
> > +#define LEVELB_VOL(x)		((x) << 4)  /* 2 bits */
> > +#define LRADC_SAMPLE_RATE(x)	((x) << 2)  /* 2 bits */
> > +#define LRADC_EN		BIT(0)
> > +
> > +/* LRADC_INTC and LRADC_INTS bits */
> > +#define CHAN1_KEYUP_IRQ		BIT(12)
> > +#define CHAN1_ALRDY_HOLD_IRQ	BIT(11)
> > +#define CHAN1_HOLD_IRQ		BIT(10)
> > +#define	CHAN1_KEYDOWN_IRQ	BIT(9)
> > +#define CHAN1_DATA_IRQ		BIT(8)
> > +#define CHAN0_KEYUP_IRQ		BIT(4)
> > +#define CHAN0_ALRDY_HOLD_IRQ	BIT(3)
> > +#define CHAN0_HOLD_IRQ		BIT(2)
> > +#define	CHAN0_KEYDOWN_IRQ	BIT(1)
> > +#define CHAN0_DATA_IRQ		BIT(0)
> > +
> > +#define NUM_CHANS		2
> > +#define NUM_TRIGGERS		4
> ? Interesting, but not present here.

Well, I toyed with trigger events and I forgot to remove that define.

> > +static int sun4i_lradc_write_raw_get_fmt(struct iio_dev *indio_dev,
> > +					 struct iio_chan_spec const *chan,
> > +					 long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	default:
> > +		break;
> > +	}
> > +	return IIO_VAL_INT_PLUS_NANO;
> Umm. You don't write anything other than samp_freq and the above
> is the default so I don't think you need this function at all.

I'll try again but I was under the impression that this was needed.
Maybe I got something else wrong when I first tested.

> > +	indio_dev->name = dev_name(dev);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &sun4i_lradc_info;
> > +
> > +	st->vref_supply = devm_regulator_get(dev, "vref");
> > +	if (IS_ERR(st->vref_supply))
> > +		return PTR_ERR(st->vref_supply);
> > +
> > +	st->base = devm_ioremap_resource(dev,
> > +			platform_get_resource(pdev, IORESOURCE_MEM, 0));
> > +	if (IS_ERR(st->base))
> > +		return PTR_ERR(st->base);
> > +
> Perhaps a trivial comment on what this is doing... Presumably clearing all
> inerrupts then turning them on?  If so you probably want to do that after
> you have claimed the irqs.

I'll add a comment. It is in fact disabling the interrupts and then
clearing them. It is not completely necessary until I add tirgger
support.

> > +	writel(0, st->base + SUN4I_LRADC_INTC);
> > +	writel(0xffffffff, st->base + SUN4I_LRADC_INTS);
> > +
> > +	err = devm_request_irq(dev, platform_get_irq(pdev, 0),
> > +			       sun4i_lradc_irq, 0,
> > +			       "sun4i-a10-lradc", indio_dev);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Setup the ADC channels available on the board */
> > +	indio_dev->num_channels = ARRAY_SIZE(sun4i_lradc_chan_array);
> > +	indio_dev->channels = sun4i_lradc_chan_array;
> > +
> > +	err = regulator_enable(st->vref_supply);
> > +	if (err)
> > +		return err;
> Ever disable it again?  You need a remove function.  Note, be careful
> with using devm_ form of iio_device_register when you add the remove
> as it'll mean you turn the power off (possibly) before you remove the
> interfaces to talk to the chip.

Sure, that shouldn't be an issue.

> > +
> > +	err = devm_iio_device_register(dev, indio_dev);
> > +	if (err < 0) {
> > +		dev_err(dev, "Couldn't register the device.\n");
> > +		return err;
> > +	}
> At this point all userspace interfaces and in kernel interfaces are
> exposed.  You really want the device to be ready to go by here.
> Doesn't look like it is too me!

Right, I'll move that at the end of the probe function.

> > +
> > +	/* lradc Vref internally is divided by 2/3 */
> > +	st->vref_mv = regulator_get_voltage(st->vref_supply) * 2 / 3000;
> > +
> > +	init_completion(&st->data_ok[0]);
> > +	init_completion(&st->data_ok[1]);
> > +	spin_lock_init(&st->lock);
> > +
> > +	/* Continuous mode on both channels */
> > +	writel(CHAN_SELECT(0x3) | KEY_MODE_SEL(0x2) | LRADC_SAMPLE_RATE(0x00) |
> > +	       LRADC_EN, st->base + SUN4I_LRADC_CTRL);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id sun4i_lradc_of_match[] = {
> > +	{ .compatible = "allwinner,sun4i-a10-lradc", },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, sun4i_lradc_of_match);
> > +
> > +static struct platform_driver sun4i_lradc_driver = {
> > +	.probe	= sun4i_lradc_probe,
> > +	.driver = {
> > +		.name	= "sun4i-a10-lradc",
> > +		.of_match_table = of_match_ptr(sun4i_lradc_of_match),
> > +	},
> > +};
> > +
> > +module_platform_driver(sun4i_lradc_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("Allwinner sun4i low resolution ADC driver");
> > +MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
> > 
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
