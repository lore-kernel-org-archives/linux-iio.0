Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:58191 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbdAIVCt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2017 16:02:49 -0500
Subject: Re: [PATCH V2] iio: adc: Add Renesas GyroADC driver
To: Marek Vasut <marek.vasut@gmail.com>, linux-iio@vger.kernel.org
References: <20170109000309.22511-1-marek.vasut@gmail.com>
 <94f3e023-03a5-99f0-1810-15b35f3417b9@metafoo.de>
 <1bf1278c-cfbd-bda6-9417-96ea49dd0098@gmail.com>
 <60a9397a-aaa6-2a0d-9acc-79cd967f6938@metafoo.de>
 <e0128ace-9dfe-561a-31e2-ee5007d16415@gmail.com>
 <df158052-8b1d-102f-2d8d-178cfda09d8b@metafoo.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9cf18320-8dcb-b06f-4772-09f21ae76347@metafoo.de>
Date: Mon, 9 Jan 2017 22:02:46 +0100
MIME-Version: 1.0
In-Reply-To: <df158052-8b1d-102f-2d8d-178cfda09d8b@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2017 10:02 PM, Lars-Peter Clausen wrote:
> On 01/09/2017 09:56 PM, Marek Vasut wrote:
>> On 01/09/2017 09:07 PM, Lars-Peter Clausen wrote:
>>> On 01/09/2017 02:47 PM, Marek Vasut wrote:
>>>> On 01/09/2017 02:45 PM, Lars-Peter Clausen wrote:
>>>>> On 01/09/2017 01:03 AM, Marek Vasut wrote:
>>>>> [...]
>>>>>> +- renesas,gyroadc-mode:	GyroADC mode of operation, must be either of:
>>>>>> +			1 - MB88101A mode, 12bit sampling, 4 channels
>>>>>> +			2 - ADCS7476 mode, 15bit sampling, 8 channels
>>>>>> +			3 - MAX1162 mode,  16bit sampling, 8 channels
>>>>>
>>>>> So is this a ADC, or is this just a specialized SPI controller that
>>>>> interfaces to an external ADC?
>>>>
>>>> It's a special SPI controller, except one cannot access the SPI bus
>>>> directly. It sends out clock and reads in the data from the ADC .
>>>
>>> OK, thanks for the clarification. The commit message does not mention this
>>> at the moment and makes it sound like this is a built-in ADC.
>>>
>>> Also the renesas,gyroadc-mode property is more of a driver configuration
>>> setting rather than a description of the hardware, at least it is not very
>>> DT-ish.
>>>
>>> I'd go with something like
>>>
>>>
>>> 	&adc {
>>> 		compatible = "renesas,r8a7791-gyroadc";
>>> 		...
>>>
>>> 		adc@0 {
>>> 			reg = <0>;
>>> 			compatible = "maxim,max1162";
>>
>> But then the max1162 ADC driver* will try to bind to this, right ?
>> And since the MAX1162 is an SPI device, it will fail to work as the
>> ADC driver does not provide any sort of SPI interface. Or is that
>> actually OK ?
> 
> Only if you call of_register_spi_devices().
> 
> We for example have devices that can either work in SPI or I2C mode and both
> use the same compatible string. Depending on whether the device is a subnode
> of a SPI or I2S controller it is registered as a SPI or I2C device.

I2C controller

> 
> This situation is not that different.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

