Return-Path: <plagnioj@jcrosoft.com>
Date: Fri, 29 Mar 2013 17:28:56 +0100
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: ludovic.desroches@atmel.com, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, nicolas.ferre@atmel.com,
	maxime-ripard@free-electrons.com
Subject: Re: [PATCH] ARM: at91: dts: add adc resolution stuff
Message-ID: <20130329162856.GF20693@game.jcrosoft.org>
References: <1364548399-15827-1-git-send-email-ludovic.desroches@atmel.com>
 <5155633A.3060701@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5155633A.3060701@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On 09:47 Fri 29 Mar     , Jonathan Cameron wrote:
> On 03/29/2013 09:13 AM, ludovic.desroches@atmel.com wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> > 
> > Add the ADC low and high resolution configuration and which one to use.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> > ---
> > 
> > Hi,
> > 
> > This patch is a split from this set of patches:
> > http://thread.gmane.org/gmane.linux.ports.arm.kernel/206130/focus=6321
> > 
> > Then device tree changes can go through ARM-SOC and driver changes through the
> > iio subsystem.
> I am guessing the IIO side is to follow.  Even when posting series where it different
> bits are to go through different trees, it is useful to have them in one series so that
> people can see the whole result.

I agree too

Ludo please resend the whole series

Best Regards,
J.
> 
> 
> > 
> > Regards
> > 
> > Ludovic
> > 
> >  arch/arm/boot/dts/at91sam9260.dtsi | 3 +++
> >  arch/arm/boot/dts/at91sam9g45.dtsi | 3 +++
> >  arch/arm/boot/dts/at91sam9x5.dtsi  | 3 +++
> >  3 files changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> > index cb7bcc5..367a604 100644
> > --- a/arch/arm/boot/dts/at91sam9260.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> > @@ -484,6 +484,9 @@
> >  				atmel,adc-drdy-mask = <0x10000>;
> >  				atmel,adc-status-register = <0x1c>;
> >  				atmel,adc-trigger-register = <0x04>;
> > +				atmel,adc-res = <8 10>;
> > +				atmel,adc-res-names = "lowres", "highres";
> > +				atmel,adc-use-res = "highres";
> >  
> >  				trigger@0 {
> >  					trigger-name = "timer-counter-0";
> > diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> > index 6b1d4ca..0fa28af 100644
> > --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> > @@ -484,6 +484,9 @@
> >  				atmel,adc-drdy-mask = <0x10000>;
> >  				atmel,adc-status-register = <0x1c>;
> >  				atmel,adc-trigger-register = <0x08>;
> > +				atmel,adc-res = <8 10>;
> > +				atmel,adc-res-names = "lowres", "highres";
> > +				atmel,adc-use-res = "highres";
> >  
> >  				trigger@0 {
> >  					trigger-name = "external-rising";
> > diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> > index a98c0d5..08bcdd7 100644
> > --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> > @@ -505,6 +505,9 @@
> >  				atmel,adc-drdy-mask = <0x1000000>;
> >  				atmel,adc-status-register = <0x30>;
> >  				atmel,adc-trigger-register = <0xc0>;
> > +				atmel,adc-res = <8 10>;
> > +				atmel,adc-res-names = "lowres", "highres";
> > +				atmel,adc-use-res = "highres";
> >  
> >  				trigger@0 {
> >  					trigger-name = "external-rising";
> > 
