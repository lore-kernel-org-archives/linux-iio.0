Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] iio: mxs: Implement support for touchscreen
Date: Thu, 13 Dec 2012 17:48:14 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Shawn Guo <shawn.guo@linaro.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
References: <1354893893-26338-1-git-send-email-marex@denx.de> <50C312D8.4050405@kernel.org> <20121210222437.GA19008@core.coreip.homeip.net>
In-Reply-To: <20121210222437.GA19008@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201212131748.14778.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Dmitry Torokhov,

[...]

> > > +#define CHAN_MASK_TOUCHBUTTON		(0x3 << 0)
> > > +#define CHAN_MASK_TOUCHSCREEN_4WIRE	(0xf << 2)
> > > +#define CHAN_MASK_TOUCHSCREEN_5WIRE	(0x1f << 2)
> > > +	int			use_touchbutton:1;
> 
> Why would someone not want to use it?

The touchbutton is not present on many devices using the MX28. I'd like to 
implement it in subsequent patch for completeleness though.

Jonathan, just a quick thought, but we're getting close to have MX233 Olinuxino 
device supported as well (not my work, another guy is working on that I guess). 
The device is very cheap, maybe you can get one? It also has this insane 
touchscreen controller and all these cool insane parts ;-)

> > > +	int			use_touchscreen_4wire:1;
> > > +	int			use_touchscreen_5wire:1;
> 
> This is weird. Can it be both 4 and 5 wires? I assume not, so using
> bits is not the best idea.

What do you say to "use_touchscreen" and "use_touchscreen_5wire" ? 5wire 
touchscreen is special case, but it's easy to support it, so I dropped it in.

Or maybe make it enum?

TOUCHSCREEN_NONE = 0,
TOUCHSCREEN_4WIRE,
TOUCHSCREEN_5WIRE,

I like enum :)

[...]

Rest will be fixed in V2. Thanks for the review!

Best regards,
Marek Vasut
