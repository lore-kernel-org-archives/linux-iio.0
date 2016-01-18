Return-Path: <ludovic.desroches@atmel.com>
Date: Mon, 18 Jan 2016 08:59:31 +0100
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Ludovic Desroches <ludovic.desroches@atmel.com>,
	<nicolas.ferre@atmel.com>, <alexandre.belloni@free-electrons.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<linux-arm-kernel@lists.infradead.org>, <pmeerw@pmeerw.net>,
	<robh@kernel.org>
Subject: Re: [PATCH v3 3/5] ARM: at91/dt: sama5d2: add adc device
Message-ID: <20160118075931.GC10663@odux.rfo.atmel.com>
References: <1452785897-16270-1-git-send-email-ludovic.desroches@atmel.com>
 <1452785897-16270-4-git-send-email-ludovic.desroches@atmel.com>
 <569A2BB6.4070602@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <569A2BB6.4070602@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jan 16, 2016 at 11:38:30AM +0000, Jonathan Cameron wrote:
> On 14/01/16 15:38, Ludovic Desroches wrote:
> > Add the ADC device, and remove the adc_op_clk which is useless since the
> > adc sampling frequency is configured with sysfs.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> I've now applied the driver to the togreg branch of iio.git.
> Should get a pull request out to Greg in about 2 weeks time and it'll
> probably be in linux-next a week after that.  I'm assuming all the device
> tree changes will got through the at91 tree and arm-soc etc. 
> Shout if you want me to take them through IIO.
> 

Ok, I think Nicolas would take this patch.

Regards

Ludovic

> Thanks,
> 
> Jonathan
> > ---
> >  arch/arm/boot/dts/sama5d2.dtsi | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> > index 3f750f6..46dd430 100644
> > --- a/arch/arm/boot/dts/sama5d2.dtsi
> > +++ b/arch/arm/boot/dts/sama5d2.dtsi
> > @@ -88,12 +88,6 @@
> >  			#clock-cells = <0>;
> >  			clock-frequency = <0>;
> >  		};
> > -
> > -		adc_op_clk: adc_op_clk{
> > -			compatible = "fixed-clock";
> > -			#clock-cells = <0>;
> > -			clock-frequency = <1000000>;
> > -		};
> >  	};
> >  
> >  	ns_sram: sram@00200000 {
> > @@ -1085,6 +1079,18 @@
> >  				status = "disabled";
> >  			};
> >  
> > +			adc: adc@fc030000 {
> > +				compatible = "atmel,sama5d2-adc";
> > +				reg = <0xfc030000 0x100>;
> > +				interrupts = <40 IRQ_TYPE_LEVEL_HIGH 7>;
> > +				clocks = <&adc_clk>;
> > +				clock-names = "adc_clk";
> > +				atmel,min-sample-rate-hz = <200000>;
> > +				atmel,max-sample-rate-hz = <20000000>;
> > +				atmel,startup-time-ms = <4>;
> > +				status = "disabled";
> > +			};
> > +
> >  			pioA: pinctrl@fc038000 {
> >  				compatible = "atmel,sama5d2-pinctrl";
> >  				reg = <0xfc038000 0x600>;
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
