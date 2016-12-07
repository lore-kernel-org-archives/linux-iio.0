Return-Path: <SRS0=5DSi=XW=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <adc93632-e487-0251-1d27-a56e9215e9f6@jmondi.org>
References: <1481041823-18382-1-git-send-email-jacopo@jmondi.org>
 <alpine.DEB.2.02.1612062143480.10644@pmeerw.net> <adc93632-e487-0251-1d27-a56e9215e9f6@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Dec 2016 13:22:09 +0100
Message-ID: <CAMuHMdWK1ZaqK=-0dw_ZT=fDjHj9jWNUnue+1+NP+rp8Dyps8w@mail.gmail.com>
Subject: Re: [PATCH] iio: Add Maxim MAX11100 driver
To: "jacopo@jmondi.org" <jacopo@jmondi.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <magnus.damm@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jacopo,

On Wed, Dec 7, 2016 at 9:29 AM, jacopo@jmondi.org <jacopo@jmondi.org> wrote:
> On 06/12/2016 22:00, Peter Meerwald-Stadler wrote:
>> On Tue, 6 Dec 2016, Jacopo Mondi wrote:
>>> Add IIO driver for Maxim MAX11100 single-channel ADC.
>>> Support raw_read mode only.
>>
>> the read_raw() is supposed to return millivolts (after application of
>> offset and scale); maybe need _SCALE?
>
> How can I return millivolts here? They vary in function of the supplied Vref
> as ( V = val * Vref / (2 ^ 16 - 1)) where "val" is digital value output by
> the ADC.
> Since Vref can range from 3.8V to 5.25V, while it's typically 4.096V, isn't
> it more appropriate to let userspace perform conversion to millivolts, as it
> knows what Vref value is supplied to the ADC?

Specify Vref in DT?

Which finally gives a good reason to add a DT binding document for
MAX11100 ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
