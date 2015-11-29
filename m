Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44879 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbbK2RTm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Nov 2015 12:19:42 -0500
Subject: Re: [PATCH 5/5] iio: adc: New driver for Cirrus Logic EP93xx ADC
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <56558B23.4080506@gmail.com> <5655A0A5.20908@gmail.com>
 <565B23FB.9040405@kernel.org> <565B2A91.6050409@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <565B33AC.40908@kernel.org>
Date: Sun, 29 Nov 2015 17:19:40 +0000
MIME-Version: 1.0
In-Reply-To: <565B2A91.6050409@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/11/15 16:40, Alexander Sverdlin wrote:
> Hello Jonathan!
> 
> Thanks for your review!
> 
> On 29/11/15 17:12, Jonathan Cameron wrote:
>>> New driver adding support for ADC found on Cirrus Logic EP93xx series of SoCs.
>>>> Board specific code must take care to create platform device with all necessary
>>>> resources.
>>>>
>>>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>> Datasheet links always appreciated if available.
>>
>> Right now Cirrus' website is fighting back so I can't get to any
>> of their docs - hence bare with me!
> 
> Yeah, with Cirrus one is served elsewhere much better than on the Cirrus's website.
> First hit by Google (on "ep9301 user's guide") gives the document which is even
> missing at Cirrus:
> https://www.embeddedarm.com/documentation/third-party/ts-7000_ep9301-ug.pdf
> 
>> A few bits inline.  Primary question which is hard to answer without the
>> datasheets is what meaning the channel names actually have?  THe brief
>> says they are general purpose.  If so then it's not really valid
>> to given them extended names suggesting anything more.
> 
> High end models (EP9307, EP9312, EP9315) have TS controller, which can operate
> in general purpose ADC mode. In this mode these names are just ball names on the
> pinout. They are all the same. There is only one issue -- I have not found any
> official numbering for these devices, therefore wanted to expose this naming to
> user space. Low end devices (EP9301, EP9302) have same hw block where TS mode is
> not advertised, and even though the balls/pins are still named as in TS controller,
> they are also referred as ADC0-ADC4 in datasheet. But there are only 5 of them,
> so we do not know the numbers for other 3 in the bigger devices.
> 
> If this is not the purpose of extend_name, I'll drop them.
It's not.  We've had discussions about either exposing the datasheet names via
sysfs or perhaps allowing arbitrary labelling but nothing has come of it yet.

Perhaps in this case clear documentation of the mapping is the way to go in 
documentation for the driver.
> 
> [...]
> 
>>>> +static const struct iio_chan_spec ep93xx_adc_channels[EP93XX_NUM_CHANNELS] = {
>>>> +	EP93XX_ADC_CH(0, "YM",	"ym",	0x608),
>>>> +	EP93XX_ADC_CH(1, "SXP",	"sxp",	0x680),
>>>> +	EP93XX_ADC_CH(2, "SXM",	"sxm",	0x640),
>>>> +	EP93XX_ADC_CH(3, "SYP",	"syp",	0x620),
>>>> +	EP93XX_ADC_CH(4, "SYM",	"sym",	0x610),
>>>> +	EP93XX_ADC_CH(5, "XP",	"xp",	0x601),
>>>> +	EP93XX_ADC_CH(6, "XM",	"xm",	0x602),
>>>> +	EP93XX_ADC_CH(7, "YP",	"yp",	0x604),
>>>> +};
>> Hmm.  I'm a little dubious about the extended names.  What in the device
>> acutally restricts them to these uses?  This naming is probably something
>> to do with touch screens?  If there is no special purpose hardware then
>> I'd just drop the extended names (datasheet names obviously fine if thats
>> what they are called on the datasheet!)
> 
> see above...
> 
>>>> +		ep93xx_adc_delay(DIV_ROUND_UP(1000000, 925),
>>>> +				 DIV_ROUND_UP(1000000, 925));
>>>> +		/* At this point conversion must be completed, but anyway... */
>>>> +		while (1) {
>> Might be worth a timeout and adding a sleep in here to avoid a tight
>> spin.  Obviously it should always be fine, but who knows!
> 
> Yes, I've added a timeout for v2. We really don't need a second sleep here, the sleep
> before should ensure polling ends up immediately. But timeout will ensure read
> will not hang even if HW is exploded.
> 
> [...]
> 
>>>> +	ret = devm_iio_device_register(&pdev->dev, iiodev);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	platform_set_drvdata(pdev, iiodev);
>> I'd reorder as Peter suggested - it doesn't mater obviously but
>> you could then do return devm_iio_device_register and save
>> a few lines of code without a lost of functionality.
>>
>> However, this is racey as the userspace interface will be removed
>> 'after' the clk_disable below.  Basic rule of thumb is that if
>> you do anything at all in the remove, you can't use devm_iio_device_register
>> as if it makes sense to do it it must effect device functionality of a
>> device still exposed to userspace.
> 
> This is a valid point... Will drop devm_iio_device_register() usage in v2...
> 
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int ep93xx_adc_remove(struct platform_device *pdev)
>>>> +{
>>>> +	struct iio_dev *iiodev = platform_get_drvdata(pdev);
>>>> +	struct ep93xx_adc_priv *priv = iio_priv(iiodev);
>> Personal taste, but I'd roll the above into one call as we never
>> use the iio_dev in this function..
> 
> Well, dropping devm_iio_device_register() will require its usage...
> 
>>>> +
>>>> +	clk_disable(priv->clk);
>>>> +
>>>> +	return 0;
>>>> +}
> 
> [...]
> 
> Regards,
> Alexander.
> 

