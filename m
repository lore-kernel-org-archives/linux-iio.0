Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48277 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750AbbHENqf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 5 Aug 2015 09:46:35 -0400
Date: Wed, 5 Aug 2015 21:46:03 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: shawn.guo@linaro.org, mark.rutland@arm.com,
	devicetree@vger.kernel.org, lars@metafoo.de, B38611@freescale.com,
	kernel@pengutronix.de, pawel.moll@arm.com,
	ijc+devicetree@hellion.org.uk, linux-iio@vger.kernel.org,
	galak@codeaurora.org, linux-kernel@vger.kernel.org,
	maitysanchayan@gmail.com, robh+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, pmeerw@pmeerw.net,
	knaack.h@gmx.de, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 2/2] ARM: dts: add property for maximum ADC clock
 frequencies
Message-ID: <20150805134603.GN12927@tiger>
References: <1432730872-14325-1-git-send-email-stefan@agner.ch>
 <1432730872-14325-3-git-send-email-stefan@agner.ch>
 <557477BE.5050108@kernel.org>
 <f598169164aaacc28292d8ccc6afb32d@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f598169164aaacc28292d8ccc6afb32d@agner.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 03, 2015 at 02:22:30PM +0200, Stefan Agner wrote:
> Hi Shawn,
> 
> I guess this will go through your tree? Haven't seen it appear on imx/dt
> so far...

Sorry.  I missed it.  Please use my kernel.org mailbox, which I'm using
for kernel maintenance now.

Applied, thanks.

Shawn

> 
> --
> Stefan
> 
> On 2015-06-07 18:56, Jonathan Cameron wrote:
> > On 27/05/15 13:47, Stefan Agner wrote:
> >> The ADC clock frequency is limited depending on modes used. Add
> >> device tree property which allow to set the mode used and the
> >> maximum frequency ratings for the instance. These allows to
> >> set the ADC clock to a frequency which is within specification
> >> according to the actual mode used.
> >>
> >> Acked-by: Fugang Duan <B38611@freescale.com>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> > I'm happy to take this via IIO if people want me to, otherwise give
> > it's connection to the previous patch that I just applied,
> > 
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > 
> >> ---
> >>  arch/arm/boot/dts/vfxxx.dtsi | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> >> index a29c7ce..c6609bd 100644
> >> --- a/arch/arm/boot/dts/vfxxx.dtsi
> >> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> >> @@ -189,6 +189,8 @@
> >>  				clocks = <&clks VF610_CLK_ADC0>;
> >>  				clock-names = "adc";
> >>  				status = "disabled";
> >> +				fsl,adck-max-frequency = <30000000>, <40000000>,
> >> +							<20000000>;
> >>  			};
> >>
> >>  			wdoga5: wdog@4003e000 {
> >> @@ -387,6 +389,8 @@
> >>  				clocks = <&clks VF610_CLK_ADC1>;
> >>  				clock-names = "adc";
> >>  				status = "disabled";
> >> +				fsl,adck-max-frequency = <30000000>, <40000000>,
> >> +							<20000000>;
> >>  			};
> >>
> >>  			esdhc1: esdhc@400b2000 {
> >>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
