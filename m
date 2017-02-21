Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60886 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbdBUSDm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Feb 2017 13:03:42 -0500
Subject: Re: [PATCH v3 04/18] iio: adc: add support for X-Powers AXP20X and
 AXP22X PMICs ADCs
To: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, sre@kernel.org,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        lee.jones@linaro.org
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-5-quentin.schulz@free-electrons.com>
 <b76264cc-9c6c-169c-d490-91852c052890@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <cd4eac68-0155-d032-6d49-91e3ebdee72e@free-electrons.com>
Date: Tue, 21 Feb 2017 19:03:22 +0100
MIME-Version: 1.0
In-Reply-To: <b76264cc-9c6c-169c-d490-91852c052890@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On 19/02/2017 13:40, Jonathan Cameron wrote:
> On 14/02/17 09:40, Quentin Schulz wrote:
>> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
>> battery voltage, battery charge and discharge currents, AC-in and VBUS
>> voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
>>
>> This adds support for most of AXP20X and AXP22X ADCs.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Hi Quentin,
> 
> A few bits and bobs inline.  The bigest one is that I don't think
> you need to carry your struct axp_data pointer around in the iio_priv
> structure as it only seems to be used in probe.
> 
> Anyhow, tidy these little bits up (quite a few are optional in the
> sense that they are a matter or personal taste and I don't feel
> strongly about them) and you can add
> 
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> 
> A nice driver.
> 
> Jonathan
[...]
>> +static int axp20x_probe(struct platform_device *pdev)
>> +{
>> +	struct axp20x_adc_iio *info;
>> +	struct iio_dev *indio_dev;
>> +	struct axp20x_dev *axp20x_dev;
>> +	int ret;
>> +
>> +	axp20x_dev = dev_get_drvdata(pdev->dev.parent);
>> +
>> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	info = iio_priv(indio_dev);
>> +	platform_set_drvdata(pdev, indio_dev);
>> +
>> +	info->regmap = axp20x_dev->regmap;
>> +	indio_dev->dev.parent = &pdev->dev;
>> +	indio_dev->dev.of_node = pdev->dev.of_node;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	info->data = (struct axp_data *)platform_get_device_id(pdev)->driver_data;
> I think this is only actually used in probe, so could be handled more
> neatly with a local variable rather than sticking it in info.
> 
[...]
>> +static int axp20x_remove(struct platform_device *pdev)
>> +{
>> +	struct axp20x_adc_iio *info;
>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +
>> +	info = iio_priv(indio_dev);
> Reorder the two lines above this one and then you could just do this
> inline. (really trivial so feel free to not bother ;)
>> +
>> +	iio_device_unregister(indio_dev);
>> +	iio_map_array_unregister(indio_dev);
>> +
>> +	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>> +
>> +	if (info->data->adc_en2)

data is used here to know if I should disable misc ADCs (if supported by
the PMIC). So kinda need it only for that purpose, maybe I can use a
slightly simpler structure to only store regmap and this adc_en2 boolean.

Ack for everything else.

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
