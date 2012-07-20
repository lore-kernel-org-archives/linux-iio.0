Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
Date: Fri, 20 Jul 2012 13:32:45 +0200
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,
 linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Wolfgang Denk <wd@denx.de>
References: <1341368129-20468-1-git-send-email-marex@denx.de> <201207200418.41554.marex@denx.de> <20120720083920.GY12601@pengutronix.de>
In-Reply-To: <20120720083920.GY12601@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201207201332.46091.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Robert Schwebel,

> On Fri, Jul 20, 2012 at 04:18:41AM +0200, Marek Vasut wrote:
> > One more thing I'm curious about. There's another ADC block on the
> > CPU, called HSADC (high-speed ADC). It can sample even up to
> > 2Msamples/s. If I were to, say -- sample at 100kHz and be able to DMA
> > the results into memory -- is there any way to push such results into
> > userland somehow? Or how to operate such fast beast?
> 
> As this unit is mainly intended for things like laser / barcode
> scanners, wouldn't v2l2 be a good abstraction for it (with one line and
> N pixels)? Just an idea, didn't look too closely.

Considering it's not only for barcode scanners, but also some crazy sampling, I 
won't go for v4l2

Best regards,
Marek Vasut
