Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Mon, 10 Oct 2011 11:00:21 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Zoltan Devai <zoss@devai.org>,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
Message-ID: <20111010100020.GA3607@opensource.wolfsonmicro.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
 <1318178172-7965-5-git-send-email-zoss@devai.org>
 <CAKnu2MrAEbS-36YaU+i6+zhwH4KW7ST7-mkKT49tv7jhhSo2UQ@mail.gmail.com>
 <4E92BE19.4060907@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E92BE19.4060907@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 10, 2011 at 10:42:49AM +0100, Jonathan Cameron wrote:

> It really depends on what those general adc callbacks get used for.

If it's a general purpose ADC it's up to the board designer - you
sometimes see things like battery or supply monitoring but really it
could be any low volume analogue input.
