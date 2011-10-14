Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Fri, 14 Oct 2011 20:33:14 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	zdevai@gmail.com, linus.walleij@linaro.org
Subject: Re: [PATCH] staging:iio:proof of concept in kernel interface.
Message-ID: <20111014193314.GE2931@opensource.wolfsonmicro.com>
References: <1318333383-17663-1-git-send-email-jic23@cam.ac.uk>
 <1318333383-17663-2-git-send-email-jic23@cam.ac.uk>
 <20111013143224.GO1098@sirena.org.uk>
 <4E96F9AC.9000001@cam.ac.uk>
 <20111013204410.GA17160@sirena.org.uk>
 <4E985C60.9020308@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E985C60.9020308@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Oct 14, 2011 at 04:59:28PM +0100, Jonathan Cameron wrote:

> I'm trying to work out what our equivalent of the clk finding api is.

> The best match pair to match on I can come up with is:

> part name: iio_dev.name

> dev_name of underlying hardware if specified.
> dev_name(iio_dev->dev.parent)
> This matching source can be overridden by an optional callback if we
> unique matching is achievable in some other way for the device.

For the existing APIs doing this the device used for the request is the
client device, not the providing device.  The APIs then have a mapping
table (clkdev for most of the clk APIs) which means that boards can then
assign providers to users without needing either of the drivers to know
what's going on, though of course they can be coded that way.
