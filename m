Return-Path: <pmeerw@pmeerw.net>
Date: Tue, 28 Jun 2016 16:18:56 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
cc: jic23@kernel.org, maxime.ripard@free-electrons.com,
    linux-iio@vger.kernel.org, thomas.petazzoni@free-electrons.com,
    antoine.tenart@free-electrons.com
Subject: Re: [PATCH 2/3] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <57727DF5.1090702@free-electrons.com>
Message-ID: <alpine.DEB.2.02.1606281617430.21474@pmeerw.net>
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com> <1467101897-15946-3-git-send-email-quentin.schulz@free-electrons.com> <alpine.DEB.2.02.1606281106040.17230@pmeerw.net> <57727DF5.1090702@free-electrons.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="324295856-1599208087-1467123536=:21474"
List-ID: <linux-iio@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--324295856-1599208087-1467123536=:21474
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT


> >> +struct sunxi_gpadc_dev {
> >> +	void __iomem			*regs;
> >> +	struct completion		completion;
> >> +	int				temp_data;
> > 
> > s32 maybe? what is the datatype and unit of temp_data? IIO wants 
> > milliCelsius
> > 
> 
> temp_data has no real datatype as it is the raw value given by the ADC
> before conversion (with an offset and scale different for each SoC). The
> temperature after conversion is given in milliCelsius as expected.

great!
 
> >> +	u32				adc_data;
> >> +	struct regmap			*regmap;
> >> +	unsigned int			fifo_data_irq;
> >> +	unsigned int			temp_data_irq;
> >> +	unsigned int			flags;
> >> +};
> >> +
> >> +#define ADC_CHANNEL(_channel, _name) {				\
> > 
> > prefix needed
> > 
> >> +	.type = IIO_VOLTAGE,					\
> >> +	.indexed = 1,						\
> >> +	.channel = _channel,					\
> >> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> >> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> >> +	.datasheet_name = _name,				\
> >> +}
> >> +
> >> +static struct iio_map sunxi_gpadc_hwmon_maps[] = {
> > 
> > const possible?
> > 
> 
> The compiler complains with the following error:
> warning: passing argument 2 of ‘iio_map_array_register’ discards ‘const’
> qualifier from pointer target type [-Wdiscarded-qualifiers]
> ret = iio_map_array_register(indio_dev, sunxi_gpadc_hwmon_maps);
> 
> Is there a point to leave const even if it is discarded by the only
> function using it?

my bad, leave as is
 
regards, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
--324295856-1599208087-1467123536=:21474--
