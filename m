Return-Path: <rsc@pengutronix.de>
Date: Fri, 20 Jul 2012 10:39:20 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Marek Vasut <marex@denx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org, Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
Message-ID: <20120720083920.GY12601@pengutronix.de>
References: <1341368129-20468-1-git-send-email-marex@denx.de>
 <50081AC0.10703@metafoo.de>
 <201207192126.31772.marex@denx.de>
 <201207200418.41554.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201207200418.41554.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jul 20, 2012 at 04:18:41AM +0200, Marek Vasut wrote:
> One more thing I'm curious about. There's another ADC block on the
> CPU, called HSADC (high-speed ADC). It can sample even up to
> 2Msamples/s. If I were to, say -- sample at 100kHz and be able to DMA
> the results into memory -- is there any way to push such results into
> userland somehow? Or how to operate such fast beast?

As this unit is mainly intended for things like laser / barcode
scanners, wouldn't v2l2 be a good abstraction for it (with one line and
N pixels)? Just an idea, didn't look too closely.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
