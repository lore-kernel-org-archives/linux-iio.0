Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35529 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbbKYNBx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2015 08:01:53 -0500
Received: by wmuu63 with SMTP id u63so137005552wmu.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2015 05:01:52 -0800 (PST)
Subject: Re: [PATCH 5/5] iio: adc: New driver for Cirrus Logic EP93xx ADC
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <56558B23.4080506@gmail.com> <5655A0A5.20908@gmail.com>
 <alpine.DEB.2.02.1511251331310.11807@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <5655B13D.5060708@gmail.com>
Date: Wed, 25 Nov 2015 14:01:49 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1511251331310.11807@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi!

On 25/11/15 13:43, Peter Meerwald-Stadler wrote:
>> New driver adding support for ADC found on Cirrus Logic EP93xx series of SoCs.
>> > Board specific code must take care to create platform device with all necessary
>> > resources.
> comments below

Thanks for spelling corrections :)

[...]

>> > +		/* At this point conversion must be completed, but anyway... */
>> > +		while (1) {
>> > +			u32 t;
>> > +
>> > +			t = ep93xx_adc_reg_read(priv->base + EP93XX_ADC_RESULT);
>> > +			if (t & EP93XX_ADC_SDR) {
>> > +				/* Sign extend lower 16 bits */
>> > +				*value = (s16)t;
> there would be a nice sign_extend function

Yes, but we don't need its flexibility for the 16 bit case?

> maybe have a timeout?

Maybe... I'll add it...

>> > +				break;
>> > +			}
>> > +		}
>> > +		mutex_unlock(&priv->lock);
>> > +		return IIO_VAL_INT;
>> > +
>> > +	case IIO_CHAN_INFO_OFFSET:
>> > +		/* According to datasheet, range is -25000..25000 */
> huh? so 0 V returns what value?

Manual says it returns ~-25000. This seems to be true in reality, but I cannot tell
you now if it could be even below -25000. But as I've understood, all the relevant
calculations in IIO core are signed, so this should not be a problem.

[...]

>> > +		dev_err(&pdev->dev, "Cannot obtain clock");
> put \n at the end of the message

Yes, thanks for that notice...

[...]

>> > +	ret = clk_enable(priv->clk);
>> > +	if (ret) {
>> > +		dev_err(&pdev->dev, "Cannot enable clock");
>> > +		return ret;
>> > +	}
>> > +
> clock should be disabled on error in the following error path

True... I'll try to postpone clock enabling to the very end...

[...]

>> > +	ret = devm_iio_device_register(&pdev->dev, iiodev);
>> > +	if (ret)
>> > +		return ret;
>> > +
>> > +	platform_set_drvdata(pdev, iiodev);
> this should be done before _register()

I don't agree here, because this is for platform device only and is
only used in _remove() below, not for IIO device.

> just do
> return devm_iio_device_register(..)

Thanks for review!

Regards,
Alexander.
