Return-Path: <heiko@sntech.de>
From: Heiko Stuebner <heiko@sntech.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, john@metanate.com, linux-arm-kernel@lists.infradead.org, linux@roeck-us.net
Subject: Re: [PATCH v3 1/4] iio: adc: rockchip_saradc: reset saradc controller before programming it
Date: Mon, 22 Aug 2016 19:19:18 +0200
Message-ID: <2324843.WCcsUObKgk@phil>
In-Reply-To: <b25cda21-0e24-de46-fb23-2142135eca03@kernel.org>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com> <7e84e59d-48ee-3e17-feff-8e57ae7c2b4b@kernel.org> <b25cda21-0e24-de46-fb23-2142135eca03@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

Am Sonntag, 21. August 2016, 21:01:19 CEST schrieb Jonathan Cameron:
> Something in here got it blocked by the lists. I'm guessing it
> was the characters my email client didn't like so trying again
> with them dropped.
> 
> Jonathan
> 
> On 21/08/16 20:11, Jonathan Cameron wrote:
> > On 15/08/16 19:10, Caesar Wang wrote:
> >>> On 27/07/16 15:24, Caesar Wang wrote:
> >>>> SARADC controller needs to be reset before programming it, otherwise
> >>>> it will not function properly.
> >>>> 
> >>>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> >>>> Cc: Jonathan Cameron <jic23@kernel.org>
> >>>> Cc: Heiko Stuebner <heiko@sntech.de>
> >>>> Cc: Rob Herring <robh+dt@kernel.org>
> >>>> Cc: linux-iio@vger.kernel.org
> >>>> Cc: linux-rockchip@lists.infradead.org
> >>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
> >>> 
> >>> Hi
> >>> 
> >>> Patch is fine (I'll fix up the wording issue) however...
> >>> 
> >>> I'm not clear on the severity of the issue. Is this something
> >>> we should be pushing for stable?
> >> 
> >> I think that should be pushing for stable, since the common isssue for
> >> the ADC is initially enabled on loader, and only disabled after the
> >> first read.
> >> 
> >> cat /sys/class/hwmon/hwmon1/device/temp1_input
> >> cat: /sys/class/hwmon/hwmon1/device/temp1_input: Connection timed out
> >> 
> >> The kernel log shows:
> >> 
> >> [ 32.209451] read channel() error: -110
> >> ..
> >> 
> >> Also, for my experience. Some other reasons caused the adc (controller)
> >> glitch for the kernel side.> 
> > Fine.  So now the only question is who is handling it. The
> > fix is useless (I think) without the dts changes to support it.
> > Normally we'd route the dts and driver changes separately as it
> > should not matter, but here I think I'd prefer it if the whole
> > thing went via rockchip -> arm-soc tree so it goes in together.
> > 
> > Hence (with wording fixed)
> > 
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > Cc: <Stable@vger.kernel.org>
> > (for the driver patch).
> > 
> > If people want me to take it via IIO then I'll need acks for
> > the dts changes with explicit agreement that they can be marked
> > for stable. Would image Heiko, these would come from you.

I don't know how the armsoc people feel about routing other subsystem changes 
through armsoc, but I think small dts changes coming through driver trees is 
the more common case, so personally I'd think patches 1,3 and 4 could go 
through the iio tree.

Patch 2 of course isn't material for stable, as it adds new functionality, so 
I'd pick that up directly, especially as we see numerous rk3399 changes, so 
that would be prone to conflict.


Heiko
