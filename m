Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Thu, 13 Oct 2011 17:25:03 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Zoltan Devai <zdevai@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
Message-ID: <20111013162503.GK5193@opensource.wolfsonmicro.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
 <20111013121745.GU21648@n2100.arm.linux.org.uk>
 <20111013143857.GH5193@opensource.wolfsonmicro.com>
 <201110131656.56519.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201110131656.56519.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 13, 2011 at 04:56:56PM +0200, Arnd Bergmann wrote:
> On Thursday 13 October 2011, Mark Brown wrote:

> > The driver specific data structures should probably just be moving to
> > include/linux/platform_data which is the approved location for that sort
> > of thing.

> Note that we also need someone to watch over that and say no to silly
> platform_data definitions being put in there, e.g. using wildly different
> ways of expressing the same things in almost-identical drivers, or
> using function pointers where a simple data structure is enough.

Yeah, I'm not sure I entirely understand the plan with it though even
without any structure it doesn't make much difference (in that
everything is being reviewed by the subsystem maintainers just as it was
before we dumped the files in a single directory).  I'm tempted to say
the device tree folks should be looking at it as an awful lot of what
they're doing is exactly the same thing.
