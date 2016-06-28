Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58838 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbcF1QZw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 12:25:52 -0400
In-Reply-To: <alpine.DEB.2.02.1606281617430.21474@pmeerw.net>
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com> <1467101897-15946-3-git-send-email-quentin.schulz@free-electrons.com> <alpine.DEB.2.02.1606281106040.17230@pmeerw.net> <57727DF5.1090702@free-electrons.com> <alpine.DEB.2.02.1606281617430.21474@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 2/3] iio: adc: add support for Allwinner SoCs ADC
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 28 Jun 2016 17:25:33 +0100
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Quentin Schulz <quentin.schulz@free-electrons.com>
CC: jic23@kernel.org, maxime.ripard@free-electrons.com,
	linux-iio@vger.kernel.org, thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Message-ID: <389DB893-13F0-4F59-B20A-2174636D4C0D@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 28 June 2016 15:18:56 BST, Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
>
>> >> +struct sunxi_gpadc_dev {
>> >> +	void __iomem			*regs;
>> >> +	struct completion		completion;
>> >> +	int				temp_data;
>> > 
>> > s32 maybe? what is the datatype and unit of temp_data? IIO wants 
>> > milliCelsius
>> > 
>> 
>> temp_data has no real datatype as it is the raw value given by the
>ADC
>> before conversion (with an offset and scale different for each SoC).
>The
>> temperature after conversion is given in milliCelsius as expected.
>
>great!
> 
>> >> +	u32				adc_data;
>> >> +	struct regmap			*regmap;
>> >> +	unsigned int			fifo_data_irq;
>> >> +	unsigned int			temp_data_irq;
>> >> +	unsigned int			flags;
>> >> +};
>> >> +
>> >> +#define ADC_CHANNEL(_channel, _name) {				\
>> > 
>> > prefix needed
>> > 
>> >> +	.type = IIO_VOLTAGE,					\
>> >> +	.indexed = 1,						\
>> >> +	.channel = _channel,					\
>> >> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>> >> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>> >> +	.datasheet_name = _name,				\
>> >> +}
>> >> +
>> >> +static struct iio_map sunxi_gpadc_hwmon_maps[] = {
>> > 
>> > const possible?
>> > 
>> 
>> The compiler complains with the following error:
>> warning: passing argument 2 of ‘iio_map_array_register’ discards
>‘const’
>> qualifier from pointer target type [-Wdiscarded-qualifiers]
>> ret = iio_map_array_register(indio_dev, sunxi_gpadc_hwmon_maps);
>> 
>> Is there a point to leave const even if it is discarded by the only
>> function using it?
>
>my bad, leave as is
> 
Surprised me as well. That function should probably be taking it as const.
Can't immediately see a reason not to!
>regards, p.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
