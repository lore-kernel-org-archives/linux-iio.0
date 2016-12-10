Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48694 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbcLJRyX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2016 12:54:23 -0500
Subject: Re: [PATCH] iio: Add Maxim MAX11100 driver
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        "jacopo@jmondi.org" <jacopo@jmondi.org>
References: <1481041823-18382-1-git-send-email-jacopo@jmondi.org>
 <alpine.DEB.2.02.1612062143480.10644@pmeerw.net>
 <adc93632-e487-0251-1d27-a56e9215e9f6@jmondi.org>
 <CAMuHMdWK1ZaqK=-0dw_ZT=fDjHj9jWNUnue+1+NP+rp8Dyps8w@mail.gmail.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <97c5f3f5-3241-b80b-6d0b-22bf28ce9581@kernel.org>
Date: Sat, 10 Dec 2016 17:54:20 +0000
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWK1ZaqK=-0dw_ZT=fDjHj9jWNUnue+1+NP+rp8Dyps8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/12/16 12:22, Geert Uytterhoeven wrote:
> Hi Jacopo,
> 
> On Wed, Dec 7, 2016 at 9:29 AM, jacopo@jmondi.org <jacopo@jmondi.org> wrote:
>> On 06/12/2016 22:00, Peter Meerwald-Stadler wrote:
>>> On Tue, 6 Dec 2016, Jacopo Mondi wrote:
>>>> Add IIO driver for Maxim MAX11100 single-channel ADC.
>>>> Support raw_read mode only.
>>>
>>> the read_raw() is supposed to return millivolts (after application of
>>> offset and scale); maybe need _SCALE?
>>
>> How can I return millivolts here? They vary in function of the supplied Vref
>> as ( V = val * Vref / (2 ^ 16 - 1)) where "val" is digital value output by
>> the ADC.
>> Since Vref can range from 3.8V to 5.25V, while it's typically 4.096V, isn't
>> it more appropriate to let userspace perform conversion to millivolts, as it
>> knows what Vref value is supplied to the ADC?
> 
> Specify Vref in DT?
More specifically specify that it's supplied by a regulator.. 
If it's a fixed supply then DT should describe it as a fixed regulator.
> 
> Which finally gives a good reason to add a DT binding document for
> MAX11100 ;-)
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
> 

