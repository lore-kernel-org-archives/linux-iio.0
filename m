Return-Path: <maitysanchayan@gmail.com>
Date: Fri, 10 Jul 2015 23:36:40 +0530
From: maitysanchayan@gmail.com
To: Shawn Guo <shawnguo@kernel.org>
Cc: jic23@kernel.org, shawn.guo@linaro.org, kernel@pengutronix.de,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	B38611@freescale.com, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stefan@agner.ch
Subject: Re: [PATCH v2 2/2] ARM: dts: vfxxx: Add property for minimum sample
 time
Message-ID: <20150710180640.GB8723@Sanchayan-Arch>
References: <cover.1435134626.git.maitysanchayan@gmail.com>
 <36fa3cef10b6a21b39e96283ea5d6961e9f6d972.1435134626.git.maitysanchayan@gmail.com>
 <20150710085324.GL23464@tiger>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20150710085324.GL23464@tiger>
List-ID: <linux-iio@vger.kernel.org>

Hello Shawn,

On 15-07-10 16:53:24, Shawn Guo wrote:
> On Wed, Jun 24, 2015 at 02:03:41PM +0530, Sanchayan Maity wrote:
> > Add a device tree property which allows to specify the minimum sample
> > time which can be used to calculate the actual ADC cycles required
> > depending on the hardware.
> > 
> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > ---
> >  arch/arm/boot/dts/vfxxx.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> > index 90a03d5..71d9c08 100644
> > --- a/arch/arm/boot/dts/vfxxx.dtsi
> > +++ b/arch/arm/boot/dts/vfxxx.dtsi
> > @@ -229,6 +229,7 @@
> >  				status = "disabled";
> >  				fsl,adck-max-frequency = <30000000>, <40000000>,
> >  							<20000000>;
> > +				min-sample-time = <1000>;
> >  			};
> >  
> >  			wdoga5: wdog@4003e000 {
> > @@ -447,6 +448,7 @@
> >  				status = "disabled";
> >  				fsl,adck-max-frequency = <30000000>, <40000000>,
> >  							<20000000>;
> > +				min-sample-time = <1000>;
> 
> Can we code 1000 as the default in kernel driver, so that only boards
> requiring different value need to have this property?  Doing so makes
> the property optional rather than required.
> 

Not sure if hardcoding it in the driver is the right approach.

However if the maintainers and others agree on doing this, I will do
the necessary change.

Thanks.

Regards,
Sanchayan.
