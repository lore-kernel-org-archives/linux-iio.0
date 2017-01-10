Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36039 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759306AbdAJSl6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 13:41:58 -0500
Received: by mail-io0-f194.google.com with SMTP id q20so12340831ioi.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Jan 2017 10:41:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f9750b6e-d540-d08d-ee7e-066481ba6158@gmail.com>
References: <20170109000309.22511-1-marek.vasut@gmail.com> <94f3e023-03a5-99f0-1810-15b35f3417b9@metafoo.de>
 <1bf1278c-cfbd-bda6-9417-96ea49dd0098@gmail.com> <60a9397a-aaa6-2a0d-9acc-79cd967f6938@metafoo.de>
 <e0128ace-9dfe-561a-31e2-ee5007d16415@gmail.com> <df158052-8b1d-102f-2d8d-178cfda09d8b@metafoo.de>
 <e73f8953-ed8b-7dc0-ec47-035a03ab1ca7@gmail.com> <CAMuHMdV-_5GHNJP9ZcAn4yc56V_wp-rXb=ZdMF23akkoCxecGQ@mail.gmail.com>
 <f9750b6e-d540-d08d-ee7e-066481ba6158@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Jan 2017 19:41:56 +0100
Message-ID: <CAMuHMdXEuRKrE--v9HC8-wJO2mE_3Kn59zYWs76OST5Gr_rpEA@mail.gmail.com>
Subject: Re: [PATCH V2] iio: adc: Add Renesas GyroADC driver
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,

On Tue, Jan 10, 2017 at 7:35 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> On Mon, Jan 9, 2017 at 10:55 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> On 01/09/2017 10:02 PM, Lars-Peter Clausen wrote:
>>>> On 01/09/2017 09:56 PM, Marek Vasut wrote:
>>>>> On 01/09/2017 09:07 PM, Lars-Peter Clausen wrote:
>>>>>> On 01/09/2017 02:47 PM, Marek Vasut wrote:
>>>>>>> On 01/09/2017 02:45 PM, Lars-Peter Clausen wrote:
>>>>>>>> On 01/09/2017 01:03 AM, Marek Vasut wrote:
>>>>>>>> [...]
>>>>>>>>> +- renesas,gyroadc-mode: GyroADC mode of operation, must be either of:
>>>>>>>>> +                        1 - MB88101A mode, 12bit sampling, 4 channels
>>>>>>>>> +                        2 - ADCS7476 mode, 15bit sampling, 8 channels
>>>>>>>>> +                        3 - MAX1162 mode,  16bit sampling, 8 channels
>>>>>>>>
>>>>>>>> So is this a ADC, or is this just a specialized SPI controller that
>>>>>>>> interfaces to an external ADC?
>>>>>>>
>>>>>>> It's a special SPI controller, except one cannot access the SPI bus
>>>>>>> directly. It sends out clock and reads in the data from the ADC .
>>>>>>
>>>>>> OK, thanks for the clarification. The commit message does not mention this
>>>>>> at the moment and makes it sound like this is a built-in ADC.
>>>>>>
>>>>>> Also the renesas,gyroadc-mode property is more of a driver configuration
>>>>>> setting rather than a description of the hardware, at least it is not very
>>>>>> DT-ish.
>>>>>>
>>>>>> I'd go with something like
>>>>>>
>>>>>>
>>>>>>     &adc {
>>>>>>             compatible = "renesas,r8a7791-gyroadc";
>>>>>>             ...
>>>>>>
>>>>>>             adc@0 {
>>>>>>                     reg = <0>;
>>>>>>                     compatible = "maxim,max1162";
>>>>>
>>>>> But then the max1162 ADC driver* will try to bind to this, right ?
>>>>> And since the MAX1162 is an SPI device, it will fail to work as the
>>>>> ADC driver does not provide any sort of SPI interface. Or is that
>>>>> actually OK ?
>>>>
>>>> Only if you call of_register_spi_devices().
>>>>
>>>> We for example have devices that can either work in SPI or I2C mode and both
>>>> use the same compatible string. Depending on whether the device is a subnode
>>>> of a SPI or I2S controller it is registered as a SPI or I2C device.
>>>>
>>>> This situation is not that different.
>>>
>>> So in this case, the gyroadc driver would instead iterate over the
>>> subnodes, check the compatible string and configure the channel mode
>>> according to the subnode compatible string?
>>
>> That's correct.
>>
>>> But then, the gyroadc only has one configuration register which applies
>>> to all channels, which selects how many bits to read from the connected
>>> SPI-ADC device(s) (sample width). This is not per-channel configurable.
>>> The driver would then have to check if all the compatible properties in
>>> the ADC subnodes select the same ADC or at least ADC which has the same
>>
>> Correct again.
>>
>>> sample width. This looks like a duplication to me. Thoughts ?
>>
>> While the protocols have to be the same for each channel, you can connect
>> different devices. If you have e.g. a thermometer or barimeter that speaks
>> the same protocol as a max1162 (i.e. it responds with 2 zero bytes and 2
>> bytes of data), you can mix and match that with max1162 devices, once
>> you have added support for the thermometer or barimeter to your driver.
>
> Which driver, the gyroadc driver ? That's only an ADC driver, it

The gyroadc driver.

> shouldn't be aware of any temperature/pressure sampling or any such
> stuff IMO. What you suggest would result in overbloating the gyroadc
> driver with support for all sorts of ADCs connected to it's channels
> and providing all sorts of information, which I think would violate
> the functional separation in the driver model.

If the need ever arises, it can be turned into a "gyroadc" framework,
and the actual sensor drivers can be enhanced to support the gyroadc
driver, in addition to regular SPI master drivers?

Something for the far future, of course ;-)
For now we can limit it to the 3 types of devices officially supported by
the GyroADC hardware.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
