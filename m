Return-Path: <stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 13 Jul 2015 08:44:26 +0200
From: Stefan Agner <stefan@agner.ch>
To: maitysanchayan@gmail.com, Jonathan Cameron <jic23@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, shawn.guo@linaro.org,
 kernel@pengutronix.de, robh+dt@kernel.org, pawel.moll@arm.com,
 mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
 B38611@freescale.com, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: vfxxx: Add property for minimum sample
 time
In-Reply-To: <20150712064753.GA1199@Sanchayan-Arch>
References: <cover.1435134626.git.maitysanchayan@gmail.com>
 <36fa3cef10b6a21b39e96283ea5d6961e9f6d972.1435134626.git.maitysanchayan@gmail.com>
 <20150710085324.GL23464@tiger> <20150710180640.GB8723@Sanchayan-Arch>
 <55A154BE.6000701@kernel.org> <20150712064753.GA1199@Sanchayan-Arch>
Message-ID: <8550db3f2a5db8ec68fc9360dc7173e3@agner.ch>
List-ID: <linux-iio@vger.kernel.org>

On 2015-07-12 08:47, maitysanchayan@gmail.com wrote:
> Hello Jonathan,
> 
> On 15-07-11 18:39:10, Jonathan Cameron wrote:
>> On 10/07/15 19:06, maitysanchayan@gmail.com wrote:
>> > Hello Shawn,
>> >
>> > On 15-07-10 16:53:24, Shawn Guo wrote:
>> >> On Wed, Jun 24, 2015 at 02:03:41PM +0530, Sanchayan Maity wrote:
>> >>> Add a device tree property which allows to specify the minimum sample
>> >>> time which can be used to calculate the actual ADC cycles required
>> >>> depending on the hardware.
>> >>>
>> >>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>> >>> ---
>> >>>  arch/arm/boot/dts/vfxxx.dtsi | 2 ++
>> >>>  1 file changed, 2 insertions(+)
>> >>>
>> >>> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
>> >>> index 90a03d5..71d9c08 100644
>> >>> --- a/arch/arm/boot/dts/vfxxx.dtsi
>> >>> +++ b/arch/arm/boot/dts/vfxxx.dtsi
>> >>> @@ -229,6 +229,7 @@
>> >>>  				status = "disabled";
>> >>>  				fsl,adck-max-frequency = <30000000>, <40000000>,
>> >>>  							<20000000>;
>> >>> +				min-sample-time = <1000>;
>> >>>  			};
>> >>>
>> >>>  			wdoga5: wdog@4003e000 {
>> >>> @@ -447,6 +448,7 @@
>> >>>  				status = "disabled";
>> >>>  				fsl,adck-max-frequency = <30000000>, <40000000>,
>> >>>  							<20000000>;
>> >>> +				min-sample-time = <1000>;
>> >>
>> >> Can we code 1000 as the default in kernel driver, so that only boards
>> >> requiring different value need to have this property?  Doing so makes
>> >> the property optional rather than required.
>> >>
>> >
>> > Not sure if hardcoding it in the driver is the right approach.
>> If it is a true feature of the device (i.e. if in the case of perfect
>> front end electronics) this is the right option, then a default makes
>> a lot of sense.  If that isn't the case (I suspect not) then if we
>> drop it be optional chances are no one will bother thinking about it
>> or trying to tune this at all.
>>
>> Hence seems wrong to put a fairly arbitrary default value on it.
>> However, we do need to still work with old device trees and new kernels
>> so need to cope without it.
>>
>> Hence to my mind, if we had started out with this in the first driver
>> version, then the default would be a bad idea.  As we didn't then we
>> really need to cope with nothing specified (as best we can) and so
>> we do need a sensible default (or perhaps even sensible worst
>> case default) in there.

I agree with Jonathan's argumentation, let's add a default if the dt
propery is not there.

1000ns seems to be a good default value over a wide range of external
resistance/capacity according to the diagrams of the data sheet, so I
would vote for that value as default.

> 
> Just to be sure, do I understand you correctly that you agree with the
> property being in device tree?

I don't think that the device tree property is in discussion, it is just
about whether to add a default value in the driver or not...

> 
> If the device tree property is not specified the driver will just go on
> to use the value "3" which was hardcoded earlier. In my opinion it is
> better to allow users to change the sampling cycles by specifying or not
> specifying this in the device tree rather than have a default value coded
> in the driver. However this is just my opinion.
> 
> Also, some users might not need the somewhat worst case value of 1000. I
> guess we could keep the driver patch the way it is right now and migrate
> the property to be specified in our board dts file? So the property can
> be picked up from the vf-colibri.dtsi or vf500-colibri.dtsi in the adc
> node? Other boards can do the same?

I agree too, especially when we have a default value in the driver, the
property belongs into the board file. I suggest to add the default value
of 1000 to the vf-colibri.dtsi (even if this is the driver default, so
we explicitly request that "verified" value..)

--
Stefan
