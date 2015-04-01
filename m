Return-Path: <antoine.tenart@free-electrons.com>
Date: Wed, 1 Apr 2015 15:06:08 +0200
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>,
	sebastian.hesselbarth@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, zmxu@marvell.com, jszhang@marvell.com,
	yrliao@marvell.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: adc: add support for Berlin
Message-ID: <20150401130608.GB10772@kwain>
References: <1426858565-31053-1-git-send-email-antoine.tenart@free-electrons.com>
 <1426858565-31053-2-git-send-email-antoine.tenart@free-electrons.com>
 <alpine.DEB.2.02.1503201819010.21628@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <alpine.DEB.2.02.1503201819010.21628@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Peter,

On Fri, Mar 20, 2015 at 06:43:15PM +0100, Peter Meerwald wrote:
>
> probably these regmap_read() / _write() pairs could be MACRO()'d away 
> somehow

Sure.

> 
> the prefix SYSCTL prefix is unexpected, couldn't you use BERLIN_ or 
> something?

I'll use BERLIN2_ instead of SYSCTL_

> 
> > +#define SYSCTL_SM_CTRL				0x14
> > +#define  SYSCTL_SM_CTRL_SM_SOC_INT		BIT(1)
> 
> whitespace issue?

I added a whitespace to put the bit definitions of a register together,
so that the reading is easier.

> 
> > +#define  SYSCTL_SM_CTRL_SOC_SM_INT		BIT(2)
> > +#define  SYSCTL_SM_CTRL_ADC_SEL(x)		(BIT(x) << 5)	/* 0-15 */
> > +#define  SYSCTL_SM_CTRL_ADC_SEL_MASK		(0xf << 5)
> > +#define  SYSCTL_SM_CTRL_ADC_POWER		BIT(9)
> > +#define  SYSCTL_SM_CTRL_ADC_CLKSEL_DIV2		(0x0 << 10)
> > +#define  SYSCTL_SM_CTRL_ADC_CLKSEL_DIV3		(0x1 << 10)
> > +#define  SYSCTL_SM_CTRL_ADC_CLKSEL_DIV4		(0x2 << 10)
> > +#define  SYSCTL_SM_CTRL_ADC_CLKSEL_DIV8		(0x3 << 10)
> > +#define  SYSCTL_SM_CTRL_ADC_CLKSEL_MASK		(0x3 << 10)
> > +#define  SYSCTL_SM_CTRL_ADC_START		BIT(12)
> > +#define  SYSCTL_SM_CTRL_ADC_RESET		BIT(13)
> > +#define  SYSCTL_SM_CTRL_ADC_BANDGAP_RDY		BIT(14)
> > +#define  SYSCTL_SM_CTRL_ADC_CONT_SINGLE		(0x0 << 15)
> > +#define  SYSCTL_SM_CTRL_ADC_CONT_CONTINUOUS	(0x1 << 15)
> > +#define  SYSCTL_SM_CTRL_ADC_BUFFER_EN		BIT(16)
> > +#define  SYSCTL_SM_CTRL_ADC_VREF_EXT		(0x0 << 17)
> > +#define  SYSCTL_SM_CTRL_ADC_VREF_INT		(0x1 << 17)
> > +#define  SYSCTL_SM_CTRL_ADC_ROTATE		BIT(19)
> > +#define  SYSCTL_SM_CTRL_TSEN_EN			BIT(20)
> > +#define  SYSCTL_SM_CTRL_TSEN_CLK_SEL_125	(0x0 << 21)	/* 1.25 MHz */
> > +#define  SYSCTL_SM_CTRL_TSEN_CLK_SEL_250	(0x1 << 21)	/* 2.5 MHz */
> > +#define  SYSCTL_SM_CTRL_TSEN_MODE_0_125		(0x0 << 22)	/* 0-125 C */
> > +#define  SYSCTL_SM_CTRL_TSEN_MODE_10_50		(0x1 << 22)	/* 10-50 C */

> > +		{							\
> > +			.channel	= n,				\
> > +			.datasheet_name	= "channel"#n,			\
> > +			.type		= t,				\
> > +			.indexed	= 1,				\
> > +			.scan_index	= n,				\
> > +			.scan_type	= {				\
> > +				.sign		= 'u',			\
> > +				.realbits	= 64,			\
> > +				.storagebits	= 64,			\
> > +			},						\
> 
> the data read is not 64 bit I think
> 
> the driver does not seem to support buffered reads, so scan_type and 
> scan_index can be removed

OK.

> > +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> > +		}
> > +
> > +#define N_CHANNELS		8
> 
> not prefixed; would be good if you could do with ARRAY_SIZE over 
> _adc_channels instead

OK.

> 
> > +	BERLIN2_ADC_CHANNEL(0, IIO_VOLTAGE),	/* external input */
> > +	BERLIN2_ADC_CHANNEL(1, IIO_VOLTAGE),	/* external input */
> > +	BERLIN2_ADC_CHANNEL(2, IIO_VOLTAGE),	/* external input */
> > +	BERLIN2_ADC_CHANNEL(3, IIO_VOLTAGE),	/* external input */
> > +	BERLIN2_ADC_CHANNEL(4, IIO_VOLTAGE),	/* reserved */
> > +	BERLIN2_ADC_CHANNEL(5, IIO_VOLTAGE),	/* reserved */
> > +	BERLIN2_ADC_CHANNEL(6, IIO_TEMP),	/* temperature sensor */
> 
> the temperature channel is not indexed (there is only one)

I'll update.

> 
> > +	BERLIN2_ADC_CHANNEL(7, IIO_VOLTAGE),	/* reserved */
> > +	{					/* timestamp */
> 
> 
> use IIO_CHAN_SOFT_TIMESTAMP(N_CHANNELS) here

Oh, nice! I'll update.

> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (chan->type == IIO_VOLTAGE) {
> > +			*val = berlin2_adc_read(idev, chan->channel);
> > +			if (*val < 0)
> > +				return *val;
> 
> is this milli-Volts?

Good question. I think so, but I do not have much information about
the !tsen channels.

> 
> > +
> > +			return IIO_VAL_INT;
> > +		} else if (chan->type == IIO_TEMP) {
> > +			temp = berlin2_adc_tsen_read(idev);
> > +			if (temp < 0)
> > +				return temp;
> > +
> > +			if (temp > 2047)
> > +				temp = -(4096 - temp);
> > +
> > +			/* Convert to Celsius */
> > +			*val = (temp * 100) / 264 - 270;
> 
> use SCALE and OFFSET IIO_CHAN_INFO_s to that the temperature can be 
> interpreted as milli-Celsius (or use _PROCESSED, not _RAW)

I'll fix that.

> > +
> > +static int berlin2_adc_probe(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *idev;
> 
> people prefer indio_dev instead of idev

OK.

> 
> > +	struct berlin2_adc_priv *priv;
> > +	struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
> > +	int ret, val;
> > +
> > +	idev = iio_device_alloc(sizeof(struct berlin2_adc_priv));
> 
> devm_iio_device_alloc?

Yep, that's better.

> > +
> > +	ret = iio_device_register(idev);
> 
> devm_iio_device_register?

Ditto.

> 
> > +	if (ret) {
> > +		dev_err(&pdev->dev,  "Failed to register the IIO device: %d\n",
> > +			ret);
> 
> probably not the most useful error msg and about the only logging; drop 
> it?
> 
> and just do 
> return devm_iio_device_register(idev);

OK.


Thanks for the review!

Antoine

-- 
Antoine Ténart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
