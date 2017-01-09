Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:55032 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbdAIU1g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2017 15:27:36 -0500
Subject: Re: [PATCH V2] iio: adc: Add Renesas GyroADC driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20170109000309.22511-1-marek.vasut@gmail.com>
 <94f3e023-03a5-99f0-1810-15b35f3417b9@metafoo.de>
 <1bf1278c-cfbd-bda6-9417-96ea49dd0098@gmail.com>
 <60a9397a-aaa6-2a0d-9acc-79cd967f6938@metafoo.de>
 <CAMuHMdXPazdh5VQbTQx84c+z+KOHb=CRHtM6fFVHrCrxax2TuA@mail.gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2eda8a15-90da-a32d-faad-9e514a9c72c5@metafoo.de>
Date: Mon, 9 Jan 2017 21:27:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXPazdh5VQbTQx84c+z+KOHb=CRHtM6fFVHrCrxax2TuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2017 09:25 PM, Geert Uytterhoeven wrote:
> Hi Lars,
> 
> On Mon, Jan 9, 2017 at 9:07 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 01/09/2017 02:47 PM, Marek Vasut wrote:
>>> On 01/09/2017 02:45 PM, Lars-Peter Clausen wrote:
>>>> On 01/09/2017 01:03 AM, Marek Vasut wrote:
>>>> [...]
>>>>> +- renesas,gyroadc-mode:    GyroADC mode of operation, must be either of:
>>>>> +                   1 - MB88101A mode, 12bit sampling, 4 channels
>>>>> +                   2 - ADCS7476 mode, 15bit sampling, 8 channels
>>>>> +                   3 - MAX1162 mode,  16bit sampling, 8 channels
>>>>
>>>> So is this a ADC, or is this just a specialized SPI controller that
>>>> interfaces to an external ADC?
>>>
>>> It's a special SPI controller, except one cannot access the SPI bus
>>> directly. It sends out clock and reads in the data from the ADC .
>>
>> OK, thanks for the clarification. The commit message does not mention this
>> at the moment and makes it sound like this is a built-in ADC.
>>
>> Also the renesas,gyroadc-mode property is more of a driver configuration
>> setting rather than a description of the hardware, at least it is not very
>> DT-ish.
>>
>> I'd go with something like
>>
>>
>>         &adc {
>>                 compatible = "renesas,r8a7791-gyroadc";
>>                 ...
>>
>>                 adc@0 {
>>                         reg = <0>;
>>                         compatible = "maxim,max1162";
>>
>>                         ref-supply = <&vref_max1162>;
> 
> vref-supply?

Well, the pin is called just ref in the datasheet.

