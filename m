Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34293 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937916AbdAIU45 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2017 15:56:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so24869273wmi.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Jan 2017 12:56:56 -0800 (PST)
Subject: Re: [PATCH V2] iio: adc: Add Renesas GyroADC driver
To: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20170109000309.22511-1-marek.vasut@gmail.com>
 <94f3e023-03a5-99f0-1810-15b35f3417b9@metafoo.de>
 <1bf1278c-cfbd-bda6-9417-96ea49dd0098@gmail.com>
 <60a9397a-aaa6-2a0d-9acc-79cd967f6938@metafoo.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <e0128ace-9dfe-561a-31e2-ee5007d16415@gmail.com>
Date: Mon, 9 Jan 2017 21:56:54 +0100
MIME-Version: 1.0
In-Reply-To: <60a9397a-aaa6-2a0d-9acc-79cd967f6938@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2017 09:07 PM, Lars-Peter Clausen wrote:
> On 01/09/2017 02:47 PM, Marek Vasut wrote:
>> On 01/09/2017 02:45 PM, Lars-Peter Clausen wrote:
>>> On 01/09/2017 01:03 AM, Marek Vasut wrote:
>>> [...]
>>>> +- renesas,gyroadc-mode:	GyroADC mode of operation, must be either of:
>>>> +			1 - MB88101A mode, 12bit sampling, 4 channels
>>>> +			2 - ADCS7476 mode, 15bit sampling, 8 channels
>>>> +			3 - MAX1162 mode,  16bit sampling, 8 channels
>>>
>>> So is this a ADC, or is this just a specialized SPI controller that
>>> interfaces to an external ADC?
>>
>> It's a special SPI controller, except one cannot access the SPI bus
>> directly. It sends out clock and reads in the data from the ADC .
> 
> OK, thanks for the clarification. The commit message does not mention this
> at the moment and makes it sound like this is a built-in ADC.
> 
> Also the renesas,gyroadc-mode property is more of a driver configuration
> setting rather than a description of the hardware, at least it is not very
> DT-ish.
> 
> I'd go with something like
> 
> 
> 	&adc {
> 		compatible = "renesas,r8a7791-gyroadc";
> 		...
> 
> 		adc@0 {
> 			reg = <0>;
> 			compatible = "maxim,max1162";

But then the max1162 ADC driver* will try to bind to this, right ?
And since the MAX1162 is an SPI device, it will fail to work as the
ADC driver does not provide any sort of SPI interface. Or is that
actually OK ?

* I dunno if that made it mainline yet, but there's a driver for
  compatible ADC, https://patchwork.kernel.org/patch/9472237/

> 			ref-supply = <&vref_max1162>;
> 		};
> 		
> 		... repeat for each front-end ADC.
> 
> 	};
> 
> That's much more idiomatic which makes it e.g. easier to understand for
> someone who does not know the specifics of the binding.
> 
> It also makes it more extensible and portable in terms of the same binding
> for similar devices.
> 
> Internally in the driver you can still use your mode variable initializing
> it based on the compatible string of the subnode.
> 
> - Lars
> 


-- 
Best regards,
Marek Vasut
