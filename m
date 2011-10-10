Return-Path: <zdevai@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20111010100020.GA3607@opensource.wolfsonmicro.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-5-git-send-email-zoss@devai.org>
	<CAKnu2MrAEbS-36YaU+i6+zhwH4KW7ST7-mkKT49tv7jhhSo2UQ@mail.gmail.com>
	<4E92BE19.4060907@cam.ac.uk>
	<20111010100020.GA3607@opensource.wolfsonmicro.com>
Date: Mon, 10 Oct 2011 13:42:30 +0200
Message-ID: <CAGVye5Nc9vhaF=7Y+hvGo4g-GOFb9fHeni+g=+hTj-8WCSqY+Q@mail.gmail.com>
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
From: Zoltan Devai <zdevai@gmail.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

2011/10/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Oct 10, 2011 at 10:42:49AM +0100, Jonathan Cameron wrote:
>
>> It really depends on what those general adc callbacks get used for.
>
> If it's a general purpose ADC it's up to the board designer - you
> sometimes see things like battery or supply monitoring but really it
> could be any low volume analogue input.

It's really up to the board designer. In this case, all real-world
scenarios use the adc for analog-keys AND battery monitoring.

Jonathan, your analysis of the driver is completely correct:
Currently, only the not-yet-submitted analog-keys input driver uses
this, but I'd like to add battery monitoring shortly, so this has at
least two users.

Where should the adc driver go in this case ?

Zoltan
