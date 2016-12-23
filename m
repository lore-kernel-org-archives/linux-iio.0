Return-Path: <SRS0=8Gsf=YG=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAL_JsqLwS51MhOJQb-Lmo=osHiYKcAcCJaxKJFdSvZBpafz7Gw@mail.gmail.com>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
 <1481494905-18037-2-git-send-email-bgolaszewski@baylibre.com>
 <20161213192712.gbaw4t4awayybnta@rob-hp-laptop> <CAMpxmJWw3wCE4ch8TVik+2b3BC8Lvxbi13HGd9GxruSRLu95Mg@mail.gmail.com>
 <CAL_JsqLwS51MhOJQb-Lmo=osHiYKcAcCJaxKJFdSvZBpafz7Gw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Dec 2016 10:07:16 +0100
Message-ID: <CAMuHMdWfAwPE2N-_0WhW5+EEK3bqWoo9HpQZTgLzRRutCg++qg@mail.gmail.com>
Subject: Re: [PATCH 1/2] devicetree: power: add bindings for GPIO-driven power switches
To: Rob Herring <robh@kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Rutland <mark.rutland@arm.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>,
	Patrick Titiano <ptitiano@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>,
	Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>,
	linux-gpio <linux-gpio@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Dec 15, 2016 at 4:05 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Dec 14, 2016 at 10:58 AM, Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
>> 2016-12-13 20:27 GMT+01:00 Rob Herring <robh@kernel.org>:
>>> On Sun, Dec 11, 2016 at 11:21:44PM +0100, Bartosz Golaszewski wrote:
>>>> Some boards are equipped with simple, GPIO-driven power load switches.
>>>> An example of such ICs is the TI tps229* series.
>>>
>>> How is this different than a GPIO regulator? The input and output
>>> voltages just happen to be the same. I could be convinced this is
>>> different enough to have a different compatible, but it somewhat seems
>>> you want to use this for IIO, so you are creating a different binding
>>> for that usecase.
>>
>> It's more of a fixed regulator I suppose. Do you mean adding a new
>> compatible to the fixed-regulator binding (e.g. "gpio-power-switch" or
>> "simple-power-switch") and then providing an iio driver for toggling
>> the switch?
>
> Yes, at least the first part. I view the switch as just a more
> specific subtype of a fixed-regulator. Whether an IIO driver is a
> separate discussion which is happening.

The switch could also be an opto-isolator (for which I could use gpio-leds,
too, although also without libiio control ;-) or a relay.

While I agree a switch is a degenerate regulator, modelling it as a regulator
feels a bit weird to me. Switches could be extended to e.g. double throw
relays, or H-bridges using 4 GPIOs.

BTW, I'm not an IIO expert, but from my limited knowledge, it looks like "O"
support in IIO is limited to DACs?

P.S. My motiviation is using libiio to control my board farm, which has a bank
     of opto-isolators in addition to BayLibre's ACME.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
