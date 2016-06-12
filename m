Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1465462845-1571-1-git-send-email-capellamicro@gmail.com>
References: <1465462845-1571-1-git-send-email-capellamicro@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 12 Jun 2016 19:30:04 +0200
Message-ID: <CACRpkdaRiNaUPt-pB4M-k6u4-z5mCaz8FRYvZyHYD7B6VPy31A@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] iio: light: Added CM36672 Proximity Sensor Driver.
To: Kevin Tsai <capellamicro@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Guenter Roeck <linux@roeck-us.net>,
	Jiri Slaby <jslaby@suse.cz>, Daniel Baluta <daniel.baluta@intel.com>,
	Adriana Reus <adriana.reus@intel.com>, Andreas Dannenberg <dannenberg@ti.com>,
	Matt Ranostay <mranostay@gmail.com>, Crestez Dan Leonard <leonard.crestez@intel.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Anatol Pomazau <anatol@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jun 9, 2016 at 11:00 AM, Kevin Tsai <capellamicro@gmail.com> wrote:

> V2:
> Thanks commends from Peter Meerwald-Stadler, Jonathan Cameron, and Linux
> Walleij.

Haha that again, everybody does that.

> Updated for the following:
>  - Remove unused defines.
>  - Rewrite event registration.
>  - Remove direct register values in the device tree.
>  - Rewrite by regmap API.
>  - Remove irq module parameter.
>  - Correct cm36672_remove().

Awesome. Minor comments still:

> +Required properties:
> +- compatible: must be capella,cm36672"
> +- reg: the I2C slave address, usually 0x60
> +- interrupts: interrupt mapping for GPIO IRQ

Don't say GPIO IRQ. Some chips have hardwired external interrupt lines
rather than GPIOs and those should work just as fine. Does it support
level, edge etc IRQs?

> +Optional properties:
> +- interrupt-parent: interrupt controller
> +- interrupts: interrupt mapping for GPIO IRQ

That is mentioned again, I guess it is not optional and should be removed
from here?

> +- cm36672,prx_led_current: LED current, must be one of the following values:
> +    - 0: 50mA
> +    - 1: 75mA
> +    - 2: 100mA
> +    - 3: 120mA
> +    - 4: 140mA
> +    - 5: 160mA
> +    - 6: 180mA
> +    - 7: 200mA

Do not specify enumerators. Specify milliamps in the device tree
and have the code translate it to enumerators. DTS should be
human-readable and easy to understand without reading tables.

Just use vendor prefix and something you seen before like:
capella,driver-strength = <160>;
For 160mA

> +- cm36672,prx_hd: width of proximity sensor output data, must be one of the
> +  following values:
> +    - 0: 12-bit
> +    - 1: 16-bit

Use
capella,bus-width = <12>;
The SD cards have this pattern for bus widths.

Yours,
Linus Walleij
