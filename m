Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37908 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdDHP7n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 11:59:43 -0400
Subject: Re: [PATCH v5 1/4] Documentation: dt-bindings: iio: Add max9611 ADC
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
References: <1491488454-22468-1-git-send-email-jacopo+renesas@jmondi.org>
 <1491488454-22468-2-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUNWJ2C9b9Xzod5HRU_ZG3mVamN6a-ZdOywODJqv6TxQw@mail.gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e7a53314-2e57-ae3a-af53-0d22ab445f5a@kernel.org>
Date: Sat, 8 Apr 2017 16:59:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUNWJ2C9b9Xzod5HRU_ZG3mVamN6a-ZdOywODJqv6TxQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/17 15:43, Geert Uytterhoeven wrote:

> On Thu, Apr 6, 2017 at 4:20 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/max9611.txt
>> @@ -0,0 +1,27 @@
>> +* Maxim max9611/max9612 current sense amplifier with 12-bits ADC interface
>> +
>> +Maxim max9611/max9612 is an high-side current sense amplifier with integrated
>> +12-bits ADC communicating over I2c bus.
>> +The device node for this driver shall be a child of a I2c controller.
>> +
>> +Required properties
>> +  - compatible: Should be "maxim,max9611" or "maxim,max9612"
>> +  - reg: The 7-bits long I2c address of the device
>> +  - shunt-resistor-micro-homs: Value, in micro Ohms, of the current sense shunt
> 
> s/homs/ohms/
I'll fix the title as Rob requested and this.  

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks for your hard work on this one!

Jonathan
> 
>> +                               resistor
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

