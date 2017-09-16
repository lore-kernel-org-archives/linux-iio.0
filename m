Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbdIPWRh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Sep 2017 18:17:37 -0400
Date: Sat, 16 Sep 2017 15:17:34 -0700
From: Jonathan Cameron <jic23@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Icenowy Zheng <icenowy@aosc.io>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 6/6] ARM: sun8i: h3: add partial CPU thermal zone
Message-ID: <20170916151734.10968b7a@archlinux>
In-Reply-To: <b41a80ec-23d5-a614-f6cc-d09c5a459e03@free-electrons.com>
References: <20170914145251.21784-1-icenowy@aosc.io>
        <20170914145251.21784-7-icenowy@aosc.io>
        <b41a80ec-23d5-a614-f6cc-d09c5a459e03@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 16 Sep 2017 12:05:49 +0200
Quentin Schulz <quentin.schulz@free-electrons.com> wrote:

> Hi Icenowy,
> 
> On 14/09/2017 16:52, Icenowy Zheng wrote:
> > Because of the restriction of the OF thermal framework, the thermal
> > sensor will fail to probe if the thermal zone doesn't exist.
> >   
> 
> Oh no, that's not good.
> 
> We discussed about it on IRC and I even proposed a patch for it, telling
> you I would post it on the mailing list soon after. Of course, I forgot
> and you definitely should have yelled at me for not doing it :)
> 
> I won't be able to test the patch soon. I can send it to you so that you
> can test it and integrate it in your patch series so it won't block you.
> Otherwise, we'll have to wait for a week or two for me to test it.
> 
> Thanks and sorry for forgetting to post the patch you need,
> Quentin

Other this outstanding issue I'm happy with the series, so hopefully
with Quentin's patch added we should be good to merge this one.

Jonathan

> 
> > Add a partial thermal zone which claims the H3 THS as the thermal sensor.
> > 
> > The cooling device (CPU DVFS) is still not added as it's not ready, and
> > the trip points are also not added yet.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> > index 3220da3ad790..687c6457d214 100644
> > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > @@ -89,6 +89,15 @@
> >  		};
> >  	};
> >  
> > +	thermal-zones {
> > +		cpu-thermal {
> > +			/* milliseconds */
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +			thermal-sensors = <&ths>;
> > +		};
> > +	};
> > +
> >  	timer {
> >  		compatible = "arm,armv7-timer";
> >  		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> >   
> 

