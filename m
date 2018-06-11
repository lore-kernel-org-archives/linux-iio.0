Return-Path: <SRS0=emAv=I5=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1528377065-647-1-git-send-email-stefan.popa@analog.com>
References: <1528377065-647-1-git-send-email-stefan.popa@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 11 Jun 2018 10:42:35 +0200
Message-ID: <CACRpkda5T-nUMoJKUUUDmC_MvQPs=ZP3W3ZwkgfpjozxtrHuoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
To: Stefan Popa <stefan.popa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jun 7, 2018 at 3:11 PM, Stefan Popa <stefan.popa@analog.com> wrote:

> + - adi,slew: Array of slewrate settings should contain 3 fields:
> +       1: Should be either 0 or 1 in order to enable or disable slewrate.

We have a standard binding in pin control for "slew-rate".

It doesn't have a unit today though.

> +       2: Slew rate clock:
> +               Valid values for the slew rate update frequency [Hz]:
> +               * 240000
> +               * 200000
> +               * 150000
> +               * 128000
> +               * 64000
> +               * 32000
> +               * 16000
> +               * 8000
> +               * 4000
> +               * 2000
> +               * 1000
> +               * 512
> +               * 256
> +               * 128
> +               * 64
> +               * 16
> +       3: Slew rate step:
> +               Defines by how much the output value changes at each update.
> +               Valid values for the step size LSBs:
> +               * 4
> +               * 12
> +               * 64
> +               * 120
> +               * 256
> +               * 500
> +               * 1820
> +               * 2048

This is pretty idiomatic and just encodes the configuration fields from the
hardware into the device tree.

The normal slew rate unit is Volts per microsecond.

I get the feeling that we could define that simply, and then calculate
the slew rate clock and step using that to find the best match for
a certain slew rate.

Yours,
Linus Walleij
