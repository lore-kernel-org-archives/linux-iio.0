Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53445 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751574AbcIMHGh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Sep 2016 03:06:37 -0400
Subject: Re: [PATCH v5 2/3] mfd: add support for Allwinner SoCs ADC
To: Lee Jones <lee.jones@linaro.org>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
 <20160912091829.GB1873@dell>
 <93bd339b-85ab-d0fc-5e80-e2aca290c0d7@free-electrons.com>
 <20160912095923.GD1873@dell>
 <5dec118f-45ae-4fb6-dd1e-2028947add53@free-electrons.com>
 <20160912135646.GB9789@dell>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        maxime.ripard@free-electrons.com, wens@csie.org,
        thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <a48580b4-1494-d474-b33c-007f898b29b7@free-electrons.com>
Date: Tue, 13 Sep 2016 09:06:34 +0200
MIME-Version: 1.0
In-Reply-To: <20160912135646.GB9789@dell>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/09/2016 15:56, Lee Jones wrote:
> On Mon, 12 Sep 2016, Quentin Schulz wrote:
>> On 12/09/2016 11:59, Lee Jones wrote:
>>> On Mon, 12 Sep 2016, Quentin Schulz wrote:
>>>
>>>> On 12/09/2016 11:18, Lee Jones wrote:
>>>>> On Thu, 08 Sep 2016, Quentin Schulz wrote:
>>>>> [...]
>>>>>> +
>>>>>> +MODULE_DEVICE_TABLE(of, sun4i_gpadc_mfd_of_match);
>>>>>
>>>>> Place this directly under the table.
>>>>>
>>>>>> +static struct platform_driver sun4i_gpadc_mfd_driver = {
>>>>>> +	.driver = {
>>>>>> +		.name = "sun4i-adc-mfd",
>>>>>> +		.of_match_table = of_match_ptr(sun4i_gpadc_mfd_of_match),
>>>>>> +	},
>>>>>> +	.probe = sun4i_gpadc_mfd_probe,
>>>>>
>>>>> No .remove?
>>>>>
>>>>
>>>> No, everything in probe is handled with devm functions.
>>>
>>> Don't you need to undo the register write you did?
>>>
>>
>> The regmap_write I use is there to disable all interrupts on hardware
>> side before the irq_chip handles all interrupts by itself. The
>> interrupts are not used in the MFD driver.
>>
>> Thus, I chose to disable the hardware interrupts in the remove function
>> of drivers using the interrupts (only the IIO yet but the touchscreen
>> driver later also which will be using a third interrupt). When the MFD
>> driver is removed, the MFD cells will all be removed, thus calling their
>> own remove functions, thus disabling hardware interrupts used in each
>> driver. So the hardware interrupts disabling would be called twice.
> 
> This does send some little alarm bells ringing.  I'd normally expect
> the .remove function to undo everything you did in .probe.  So, if you
> are disabling the IRQs from within the leaf drivers, shouldn't you be
> initialising them in the leaf driver's respective .probes?
> 

I use the regmap_write in the MFD driver's probe to disable all
interrupts before requesting irq_chip to guarantee the interrupts are in
a known state, being disabled. It is to insure no interrupt will occur
unwittingly before we want the leaf drivers to handle them.

The disabling of irqs in the remove is handled rather by
devm_regmap_del_irq_chip than by an explicit regmap_write in the
driver's removal function. It performs the exact same thing.

I always use devm functions for requesting either an irq_chip or the
irqs themselves. In that case, when the device is removed, the irqs are
freed on leaf drivers' (where the irqs are requested) removal while the
removal of irq_chip in the MFD driver will also free all irqs mapped to
this irq_chip thanks to devm_regmap_del_irq_chip. Therefore, the
interrupts are disabled by devm functions.

The regmap_update_bits in probe and removal of the ADC driver to disable
irqs are actually redundant because the devm functions already handle
the irqs disabling.

Thanks,
Quentin
