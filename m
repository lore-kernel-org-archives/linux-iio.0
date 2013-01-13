Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/2 V4] iio: mxs: Implement support for touchscreen
Date: Sun, 13 Jan 2013 15:13:36 +0100
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Shawn Guo <shawn.guo@linaro.org>
References: <1357947308-11226-1-git-send-email-marex@denx.de> <20130113030903.GA27264@core.coreip.homeip.net> <50F2922F.904@kernel.org>
In-Reply-To: <50F2922F.904@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201301131513.36953.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Jonathan Cameron,

> On 01/13/2013 03:09 AM, Dmitry Torokhov wrote:
> > On Sat, Jan 12, 2013 at 12:35:07AM +0100, Marek Vasut wrote:
> >> This patch implements support for sampling of a touchscreen into
> >> the MXS LRADC driver. The LRADC block allows configuring some of
> >> it's channels into special mode where they either output the drive
> >> voltage or sample it, allowing it to operate a 4-wire or 5-wire
> >> resistive touchscreen.
> >> 
> >> In case the touchscreen mode is enabled, the LRADC slot #7 is
> >> reserved for touchscreen only, therefore it is not possible to
> >> sample 8 LRADC channels at time, but only 7 channels.
> >> 
> >> The touchscreen controller is configured such that the PENDOWN event
> >> disables touchscreen interrupts and triggers execution of worker
> >> thread, which then polls the touchscreen controller for X, Y and
> >> Pressure values. This reduces the overhead of interrupt-driven
> >> operation. Upon the PENUP event, the worker thread re-enables the
> >> PENDOWN detection interrupt and exits.
> >> 
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> I've added this to the togreg branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> 
> Note it did not directly apply as I'm guessing you have a slightly
> out of date tree.

Ah yes, it was still based off of stable 3.7 .

> Please could you check I didn't mess up the
> fixing up of the patch. There was a fair bit of fuzz and the devinit
> devexit stuff shouldn't have been in your patch in the first place.

Checked just now, looks OK to me, thanks!

> Shawn, do you want to take the board device tree patch or shall
> I take that one as well?
> 
> Jonathan
