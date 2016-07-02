Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38810 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751420AbcGBUnH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Jul 2016 16:43:07 -0400
Date: Sat, 2 Jul 2016 22:43:03 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jonathan Cameron <jic23@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: sun4i-lradc: Add binding documentation
Message-ID: <20160702204303.GD20045@piout.net>
References: <1467406855-9677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <CAGb2v66PzgVqVGxs4FSQkkX=2hX42UmftahOgJmepv4wA-mwnw@mail.gmail.com>
 <20160702133528.GC20045@piout.net>
 <b23bd147-0d68-a6a6-14c0-5047af35e6b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b23bd147-0d68-a6a6-14c0-5047af35e6b7@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/07/2016 at 21:46:43 +0200, Hans de Goede wrote :
> Hi,
> 
> On 02-07-16 15:35, Alexandre Belloni wrote:
> > On 02/07/2016 at 17:12:55 +0800, Chen-Yu Tsai wrote :
> > > Hi,
> > > 
> > > On Sat, Jul 2, 2016 at 5:00 AM, Alexandre Belloni
> > > <alexandre.belloni@free-electrons.com> wrote:
> > > > Document the bindings for the Allwinner LRADC.
> > > 
> > > We already have Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> > > and I'm pretty sure Hans (CC-ed) argued that this is not a generic ADC
> > > block.
> > > 
> > > Any plans to reconcile the different bindings?
> > > 
> > 
> > Yes, I already submitted an adc-keys driver that can work with any ADC:
> > https://lkml.org/lkml/2016/7/1/670
> > 
> > I agree that because it is not yet handling interrupts and is polling
> > the ADC, it is not as good as sun4i-lradc-keys yet. My plan is to solve
> > that but it require significant work in iio.
> 
> And it also seems to break dt compatibility. Note I'm not against
> making an exception for this and breaking the dt compat, but until
> the polling is fixed we should not replace sun4i-lradc-keys.
> 
> If I understand you correctly then you want to use a new generic
> "sun4i-lradc" compatible. If you do that then we can just build both
> drivers for now and use the right compatible depending on how the
> board uses the lradc for now.
> 

Well, I never said we have to remove the previous compatible, just that
it was probably not the best one. I also didn't send a patch to remove
the previous driver and they can indeed coexist nicely for now.

Anyway, if we want to remove the sun4i-lradc-keys driver and keep DT
compatibility, we'll have to write a small stub driver. It isn't the
easiest task but it is doable.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
