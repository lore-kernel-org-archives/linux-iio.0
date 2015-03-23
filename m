Return-Path: <shawn.guo@linaro.org>
Date: Mon, 23 Mar 2015 21:30:31 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Stefan Agner <stefan@agner.ch>
Cc: kernel@pengutronix.de, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	B38611@freescale.com, maitysanchayan@gmail.com,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ARM: dts: add property for maximum ADC clock
 frequencies
Message-ID: <20150323133030.GD28410@dragon>
References: <1426518614-20201-1-git-send-email-stefan@agner.ch>
 <1426518614-20201-4-git-send-email-stefan@agner.ch>
 <80ba0aa345e8bb04e23e2988f51a851d@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80ba0aa345e8bb04e23e2988f51a851d@agner.ch>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 16, 2015 at 04:17:55PM +0100, Stefan Agner wrote:
> Forgot to add i.MX/Vybrid maintainers Shawn and Sascha.
> 
> On 2015-03-16 16:10, Stefan Agner wrote:
> > The ADC clock frequency is limited depending on modes used. Add
> > device tree property which allow to set the mode used and the
> > maximum frequency ratings for the instance. These allows to
> > set the ADC clock to a frequency which is within specification
> > according to the actual mode used.
> > 
> > Acked-by: Fugang Duan <B38611@freescale.com>
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/vf610-adc.txt | 9 +++++++++

Bindings doc shouldn't be part of dts change, and needs to be approved
by DT maintainers.

Shawn

> >  arch/arm/boot/dts/vfxxx.dtsi                            | 4 ++++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
> > b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
> > index 1a4a43d..3eb40e2 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
> > @@ -11,6 +11,13 @@ Required properties:
> >  - clock-names: Must contain "adc", matching entry in the clocks property.
> >  - vref-supply: The regulator supply ADC reference voltage.
> >  
> > +Recommended properties:
> > +- fsl,adck-max-frequency: Maximum frequencies according to datasheets operating
> > +  requirements. Three values are required, depending on conversion mode:
> > +  - Frequency in normal mode (ADLPC=0, ADHSC=0)
> > +  - Frequency in high-speed mode (ADLPC=0, ADHSC=1)
> > +  - Frequency in low-power mode (ADLPC=1, ADHSC=0)
> > +
> >  Example:
> >  adc0: adc@4003b000 {
> >  	compatible = "fsl,vf610-adc";
> > @@ -18,5 +25,7 @@ adc0: adc@4003b000 {
> >  	interrupts = <0 53 0x04>;
> >  	clocks = <&clks VF610_CLK_ADC0>;
> >  	clock-names = "adc";
> > +	fsl,adck-max-frequency = <30000000>, <40000000>,
> > +				<20000000>;
> >  	vref-supply = <&reg_vcc_3v3_mcu>;
> >  };
> > diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> > index a29c7ce..c6609bd 100644
> > --- a/arch/arm/boot/dts/vfxxx.dtsi
> > +++ b/arch/arm/boot/dts/vfxxx.dtsi
> > @@ -189,6 +189,8 @@
> >  				clocks = <&clks VF610_CLK_ADC0>;
> >  				clock-names = "adc";
> >  				status = "disabled";
> > +				fsl,adck-max-frequency = <30000000>, <40000000>,
> > +							<20000000>;
> >  			};
> >  
> >  			wdoga5: wdog@4003e000 {
> > @@ -387,6 +389,8 @@
> >  				clocks = <&clks VF610_CLK_ADC1>;
> >  				clock-names = "adc";
> >  				status = "disabled";
> > +				fsl,adck-max-frequency = <30000000>, <40000000>,
> > +							<20000000>;
> >  			};
> >  
> >  			esdhc1: esdhc@400b2000 {
> 
