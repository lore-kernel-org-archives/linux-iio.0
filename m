Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/3] IIO: arm: Add LRADC to i.MX28 dts
Date: Tue, 14 Aug 2012 04:10:55 +0200
Cc: linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>,
 Juergen Beisert <jbe@pengutronix.de>,
 "Lars-Peter Clausen" <lars@metafoo.de>,
 Wolfgang Denk <wd@denx.de>
References: <1344784918-32352-1-git-send-email-marex@denx.de> <1344784918-32352-4-git-send-email-marex@denx.de> <20120814015649.GD27792@S2101-09.ap.freescale.net>
In-Reply-To: <20120814015649.GD27792@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201208140410.55405.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Shawn Guo,

> The patch subject does not look right.

Can you fix by hand when applying please?

> ARM: dts: imx28: ...
> 
> Regards,
> Shawn
> 
> On Sun, Aug 12, 2012 at 05:21:58PM +0200, Marek Vasut wrote:
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Juergen Beisert <jbe@pengutronix.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Wolfgang Denk <wd@denx.de>
> > ---
> > 
> >  arch/arm/boot/dts/imx28.dtsi |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > index 2a413ed..ad90c59 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -677,7 +677,10 @@
> > 
> >  			};
> >  			
> >  			lradc@80050000 {
> > 
> > +				compatible = "fsl,imx28-lradc";
> > 
> >  				reg = <0x80050000 0x2000>;
> > 
> > +				interrupts = <10 14 15 16 17 18 19
> > +						20 21 22 23 24 25>;
> > 
> >  				status = "disabled";
> >  			
> >  			};

Best regards,
Marek Vasut
