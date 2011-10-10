Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Mon, 10 Oct 2011 12:44:08 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Zoltan Devai <zdevai@gmail.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
Message-ID: <20111010114407.GD3607@opensource.wolfsonmicro.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
 <1318178172-7965-5-git-send-email-zoss@devai.org>
 <CAKnu2MrAEbS-36YaU+i6+zhwH4KW7ST7-mkKT49tv7jhhSo2UQ@mail.gmail.com>
 <4E92BE19.4060907@cam.ac.uk>
 <20111010100020.GA3607@opensource.wolfsonmicro.com>
 <CAGVye5Nc9vhaF=7Y+hvGo4g-GOFb9fHeni+g=+hTj-8WCSqY+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGVye5Nc9vhaF=7Y+hvGo4g-GOFb9fHeni+g=+hTj-8WCSqY+Q@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 10, 2011 at 01:42:30PM +0200, Zoltan Devai wrote:

> Where should the adc driver go in this case ?

At the minute it seems to me that arch/arm is as good a place as any
really - currently this code is getting dumped wherever the main device
is.
