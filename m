Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: i.MX28 die temperature
Date: Thu, 28 Jun 2012 00:58:26 +0200
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
 linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com> <4FEAF75E.5090505@cam.ac.uk> <201206271433.15303.jbe@pengutronix.de>
In-Reply-To: <201206271433.15303.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201206280058.26485.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Juergen Beisert,

[...]
> 
> It requires a more or less complex state-machine to switch the used 4 or 5
> pins to different modes to measure the X/Y position and the pressure. And
> these pins interfere with the ADC input pins.
> 
> > [...]

I said I'll go through it, but it seems the IIO changed again, so I'll need to 
wrap my head around new stuff in there.

Besides, I have a feeling that the driver, as is, just simply doesn't fit in as 
it should. I'm discussing with Jonathan, since I can't really make heads or 
tails from the IIO api. It's way too complex and unless I really missed 
something, way underdocumented.

> Regards,
> Juergen

Best regards,
Marek Vasut
