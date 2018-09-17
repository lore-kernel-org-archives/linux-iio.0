Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:12164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727185AbeIQN4k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Sep 2018 09:56:40 -0400
Date: Mon, 17 Sep 2018 09:30:00 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
CC: "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/2] staging:iio:ad7606: Add support for the ad7605-4
Message-ID: <20180917093000.00004920@huawei.com>
In-Reply-To: <63a25b543a35e8f896e26796230ca7104a83b9cd.camel@analog.com>
References: <20180913110212.29068-1-alexandru.ardelean@analog.com>
        <20180913110212.29068-2-alexandru.ardelean@analog.com>
        <20180916122201.71ca224c@archlinux>
        <63a25b543a35e8f896e26796230ca7104a83b9cd.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Sep 2018 07:33:13 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2018-09-16 at 12:22 +0100, Jonathan Cameron wrote:
> > On Thu, 13 Sep 2018 14:02:12 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> > > Add support for the AD7605-4 to the AD7606 driver. The AD7605-4 is
> > > mostly
> > > interface compatible to the AD7606-6 with the only difference being not
> > > having support for oversampling.
> > > 
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > 
> > I am guessing this might clash with the devm change from earlier in the
> > day so I'm not going to apply it (too much risk of a bug sneaking in).
> > 
> > Please resend the remaining patches in for this driver as a series so
> > ordering is obvious etc.  
> 
> Hmm, the patch doesn't clash, but I will send them as a series.

I was being lazy and didn't actually check ;) Relied on false intuition.

Thanks,

Jonathan

> 
> > 
> > Otherwise this one looks good to me.
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Thanks
> Alex
> 
> > > ---
> > >  drivers/staging/iio/adc/Kconfig      |  2 +-
> > >  drivers/staging/iio/adc/ad7606.c     | 33 +++++++++++++++++++++++-----
> > >  drivers/staging/iio/adc/ad7606.h     |  3 +++
> > >  drivers/staging/iio/adc/ad7606_par.c |  3 +++
> > >  drivers/staging/iio/adc/ad7606_spi.c |  1 +
> > >  5 files changed, 36 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/adc/Kconfig
> > > b/drivers/staging/iio/adc/Kconfig
> > > index e17efb03bac0..9d3062a07460 100644
> > > --- a/drivers/staging/iio/adc/Kconfig
> > > +++ b/drivers/staging/iio/adc/Kconfig
> > > @@ -11,7 +11,7 @@ config AD7606
> > >  	select IIO_TRIGGERED_BUFFER
> > >  	help
> > >  	  Say yes here to build support for Analog Devices:
> > > -	  ad7606, ad7606-6, ad7606-4 analog to digital converters
> > > (ADC).
> > > +	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital
> > > converters (ADC).
> > >  
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called ad7606.
> > > diff --git a/drivers/staging/iio/adc/ad7606.c
> > > b/drivers/staging/iio/adc/ad7606.c
> > > index 793de92f27ed..06d65196bedb 100644
> > > --- a/drivers/staging/iio/adc/ad7606.c
> > > +++ b/drivers/staging/iio/adc/ad7606.c
> > > @@ -275,7 +275,7 @@ static const struct attribute_group
> > > ad7606_attribute_group_range = {
> > >  	.attrs = ad7606_attributes_range,
> > >  };
> > >  
> > > -#define AD7606_CHANNEL(num)					\
> > > +#define AD760X_CHANNEL(num, mask)				\
> > >  	{							\
> > >  		.type = IIO_VOLTAGE,				\
> > >  		.indexed = 1,					\
> > > @@ -283,8 +283,7 @@ static const struct attribute_group
> > > ad7606_attribute_group_range = {
> > >  		.address = num,					
> > > \
> > >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> > >  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
> > > -		.info_mask_shared_by_all =			\
> > > -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	
> > > \
> > > +		.info_mask_shared_by_all = mask,		\
> > >  		.scan_index = num,				\
> > >  		.scan_type = {					
> > > \
> > >  			.sign = 's',				\
> > > @@ -294,6 +293,20 @@ static const struct attribute_group
> > > ad7606_attribute_group_range = {
> > >  		},						\
> > >  	}
> > >  
> > > +#define AD7605_CHANNEL(num)	\
> > > +	AD760X_CHANNEL(num, 0)
> > > +
> > > +#define AD7606_CHANNEL(num)	\
> > > +	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> > > +
> > > +static const struct iio_chan_spec ad7605_channels[] = {
> > > +	IIO_CHAN_SOFT_TIMESTAMP(4),
> > > +	AD7605_CHANNEL(0),
> > > +	AD7605_CHANNEL(1),
> > > +	AD7605_CHANNEL(2),
> > > +	AD7605_CHANNEL(3),
> > > +};
> > > +
> > >  static const struct iio_chan_spec ad7606_channels[] = {
> > >  	IIO_CHAN_SOFT_TIMESTAMP(8),
> > >  	AD7606_CHANNEL(0),
> > > @@ -310,17 +323,24 @@ static const struct ad7606_chip_info
> > > ad7606_chip_info_tbl[] = {
> > >  	/*
> > >  	 * More devices added in future
> > >  	 */
> > > +	[ID_AD7605_4] = {
> > > +		.channels = ad7605_channels,
> > > +		.num_channels = 5,
> > > +	},
> > >  	[ID_AD7606_8] = {
> > >  		.channels = ad7606_channels,
> > >  		.num_channels = 9,
> > > +		.has_oversampling = true,
> > >  	},
> > >  	[ID_AD7606_6] = {
> > >  		.channels = ad7606_channels,
> > >  		.num_channels = 7,
> > > +		.has_oversampling = true,
> > >  	},
> > >  	[ID_AD7606_4] = {
> > >  		.channels = ad7606_channels,
> > >  		.num_channels = 5,
> > > +		.has_oversampling = true,
> > >  	},
> > >  };
> > >  
> > > @@ -351,6 +371,9 @@ static int ad7606_request_gpios(struct ad7606_state
> > > *st)
> > >  	if (IS_ERR(st->gpio_frstdata))
> > >  		return PTR_ERR(st->gpio_frstdata);
> > >  
> > > +	if (!st->chip_info->has_oversampling)
> > > +		return 0;
> > > +
> > >  	st->gpio_os = devm_gpiod_get_array_optional(dev,
> > > "oversampling-ratio",
> > >  			GPIOD_OUT_LOW);
> > >  	return PTR_ERR_OR_ZERO(st->gpio_os);
> > > @@ -429,12 +452,12 @@ int ad7606_probe(struct device *dev, int irq,
> > > void __iomem *base_address,
> > >  		return ret;
> > >  	}
> > >  
> > > +	st->chip_info = &ad7606_chip_info_tbl[id];
> > > +
> > >  	ret = ad7606_request_gpios(st);
> > >  	if (ret)
> > >  		goto error_disable_reg;
> > >  
> > > -	st->chip_info = &ad7606_chip_info_tbl[id];
> > > -
> > >  	indio_dev->dev.parent = dev;
> > >  	if (st->gpio_os) {
> > >  		if (st->gpio_range)
> > > diff --git a/drivers/staging/iio/adc/ad7606.h
> > > b/drivers/staging/iio/adc/ad7606.h
> > > index 57f11b46bc69..f422296354c9 100644
> > > --- a/drivers/staging/iio/adc/ad7606.h
> > > +++ b/drivers/staging/iio/adc/ad7606.h
> > > @@ -13,11 +13,13 @@
> > >   * struct ad7606_chip_info - chip specific information
> > >   * @channels:		channel specification
> > >   * @num_channels:	number of channels
> > > + * @has_oversampling:   whether the device has oversampling support
> > >   */
> > >  
> > >  struct ad7606_chip_info {
> > >  	const struct iio_chan_spec	*channels;
> > >  	unsigned int			num_channels;
> > > +	bool				has_oversampling;
> > >  };
> > >  
> > >  /**
> > > @@ -87,6 +89,7 @@ int ad7606_probe(struct device *dev, int irq, void
> > > __iomem *base_address,
> > >  int ad7606_remove(struct device *dev, int irq);
> > >  
> > >  enum ad7606_supported_device_ids {
> > > +	ID_AD7605_4,
> > >  	ID_AD7606_8,
> > >  	ID_AD7606_6,
> > >  	ID_AD7606_4
> > > diff --git a/drivers/staging/iio/adc/ad7606_par.c
> > > b/drivers/staging/iio/adc/ad7606_par.c
> > > index 956e38774767..8bd86e727b02 100644
> > > --- a/drivers/staging/iio/adc/ad7606_par.c
> > > +++ b/drivers/staging/iio/adc/ad7606_par.c
> > > @@ -79,6 +79,9 @@ static int ad7606_par_remove(struct platform_device
> > > *pdev)
> > >  
> > >  static const struct platform_device_id ad7606_driver_ids[] = {
> > >  	{
> > > +		.name		= "ad7605-4",
> > > +		.driver_data	= ID_AD7605_4,
> > > +	}, {
> > >  		.name		= "ad7606-8",
> > >  		.driver_data	= ID_AD7606_8,
> > >  	}, {
> > > diff --git a/drivers/staging/iio/adc/ad7606_spi.c
> > > b/drivers/staging/iio/adc/ad7606_spi.c
> > > index ffd9d0626ec2..b76ca5a8c059 100644
> > > --- a/drivers/staging/iio/adc/ad7606_spi.c
> > > +++ b/drivers/staging/iio/adc/ad7606_spi.c
> > > @@ -55,6 +55,7 @@ static int ad7606_spi_remove(struct spi_device *spi)
> > >  }
> > >  
> > >  static const struct spi_device_id ad7606_id[] = {
> > > +	{"ad7605-4", ID_AD7605_4},
> > >  	{"ad7606-8", ID_AD7606_8},
> > >  	{"ad7606-6", ID_AD7606_6},
> > >  	{"ad7606-4", ID_AD7606_4},  
> > 
> >  
