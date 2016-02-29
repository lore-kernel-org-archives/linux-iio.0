Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37019 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbcB2Upz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 29 Feb 2016 15:45:55 -0500
Received: by mail-ig0-f173.google.com with SMTP id z8so3798292ige.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Feb 2016 12:45:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1602292040460.6192@pmeerw.net>
References: <1456772741-9402-1-git-send-email-manabian@gmail.com>
	<1456772741-9402-2-git-send-email-manabian@gmail.com>
	<alpine.DEB.2.02.1602292040460.6192@pmeerw.net>
Date: Mon, 29 Feb 2016 21:45:54 +0100
Message-ID: <CAGhQ9VxZsXJ3Rwu_QLUBOxAUQep=uQXDs9POwpWe-Az2wDFqZQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: adc: add NXP LPC18xx ADC driver
From: Joachim Eastwood <manabian@gmail.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,

On 29 February 2016 at 20:42, Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
>
>> Add base support for the 10-bit SAR ADC peripheral found
>> on NXP LPC18xx/43xx SoCs.
>
> nitpicking below
>
>> This is a minimal driver that does not support burst mode,
>> interrupts, DMA or hardware triggers.
>>
>> User manual with register description can be found on:
>> LPC18xx: www.nxp.com/documents/user_manual/UM10430.pdf
>> LPC43xx: www.nxp.com/documents/user_manual/UM10503.pdf
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>> +/* Data registers bits */
>
> 'Data register bits' maybe
>
>> +     adc->vref = devm_regulator_get(&pdev->dev, "vref");
>> +     if (IS_ERR(adc->vref)) {
>> +             dev_err(&pdev->dev, "error get regulator\n");
>
> getting
>
>> +             return PTR_ERR(adc->vref);
>> +     }
>> +
>> +     indio_dev->name = dev_name(&pdev->dev);
>> +     indio_dev->dev.parent = &pdev->dev;
>> +     indio_dev->info = &lpc18xx_adc_info;
>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>> +     indio_dev->channels = lpc18xx_adc_iio_channels;
>> +     indio_dev->num_channels = ARRAY_SIZE(lpc18xx_adc_iio_channels);
>> +
>> +     ret = regulator_enable(adc->vref);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "unable to enable regulator\n");
>> +             return ret;
>> +     }
>> +
>> +     ret = clk_prepare_enable(adc->clk);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "unable to enable clock.\n");
>
> maybe delete '.', it's the only message with a full stop

I will fix them all in the next version. I also noticed that a couple
of your comments also apply to the dac driver.

Thanks for looking through!


regards,
Joachim Eastwood
