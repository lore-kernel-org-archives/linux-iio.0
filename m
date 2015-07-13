Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58991 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbbGMJ1E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2015 05:27:04 -0400
In-Reply-To: <20150712064753.GA1199@Sanchayan-Arch>
References: <cover.1435134626.git.maitysanchayan@gmail.com> <36fa3cef10b6a21b39e96283ea5d6961e9f6d972.1435134626.git.maitysanchayan@gmail.com> <20150710085324.GL23464@tiger> <20150710180640.GB8723@Sanchayan-Arch> <55A154BE.6000701@kernel.org> <20150712064753.GA1199@Sanchayan-Arch>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v2 2/2] ARM: dts: vfxxx: Add property for minimum sample time
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 13 Jul 2015 10:26:57 +0100
To: maitysanchayan@gmail.com
CC: Shawn Guo <shawnguo@kernel.org>, shawn.guo@linaro.org,
	kernel@pengutronix.de, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, B38611@freescale.com,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stefan@agner.ch
Message-ID: <A9520B2A-9581-49C9-A891-96AFEC0E440A@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 12 July 2015 07:47:53 BST, maitysanchayan@gmail.com wrote:
>Hello Jonathan,
>
>On 15-07-11 18:39:10, Jonathan Cameron wrote:
>> On 10/07/15 19:06, maitysanchayan@gmail.com wrote:
>> > Hello Shawn,
>> > 
>> > On 15-07-10 16:53:24, Shawn Guo wrote:
>> >> On Wed, Jun 24, 2015 at 02:03:41PM +0530, Sanchayan Maity wrote:
>> >>> Add a device tree property which allows to specify the minimum
>sample
>> >>> time which can be used to calculate the actual ADC cycles
>required
>> >>> depending on the hardware.
>> >>>
>> >>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>> >>> ---
>> >>>  arch/arm/boot/dts/vfxxx.dtsi | 2 ++
>> >>>  1 file changed, 2 insertions(+)
>> >>>
>> >>> diff --git a/arch/arm/boot/dts/vfxxx.dtsi
>b/arch/arm/boot/dts/vfxxx.dtsi
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
>> >> Can we code 1000 as the default in kernel driver, so that only
>boards
>> >> requiring different value need to have this property?  Doing so
>makes
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
>> However, we do need to still work with old device trees and new
>kernels
>> so need to cope without it.
>> 
>> Hence to my mind, if we had started out with this in the first driver
>> version, then the default would be a bad idea.  As we didn't then we
>> really need to cope with nothing specified (as best we can) and so
>> we do need a sensible default (or perhaps even sensible worst
>> case default) in there.
>
>Just to be sure, do I understand you correctly that you agree with the
>property being in device tree?
Absolutely. I wish it had been there from the start!
>
>If the device tree property is not specified the driver will just go on
>to use the value "3" which was hardcoded earlier. In my opinion it is
>better to allow users to change the sampling cycles by specifying or
>not
>specifying this in the device tree rather than have a default value
>coded
>in the driver. However this is just my opinion.
>
>Also, some users might not need the somewhat worst case value of 1000.
>I
>guess we could keep the driver patch the way it is right now and
>migrate
>the property to be specified in our board dts file? So the property can
>be picked up from the vf-colibri.dtsi or vf500-colibri.dtsi in the adc
>node? Other boards can do the same?
The issue is device trees that don't get updated on devices. Those need a default and the property to be optional.
>
>We came up with the change after noticing huge reading discrepancies
>where
>we had a 4 wire resistive touch screen connected to the ADC channels
>and
>the driver sampled these channels at an interval of 10-20ms[1]. Once
>the
>touchscreen came into picture, readings from temperature channel or
>others
>showed deviations between 40000-60000. Somehow the temperature channel
>seemed to be the most affected.
Yikes
>
>For a while, I thought the ts driver logic was at a fault, but Stefan
>pointed
>out the discrepancies in the driver using a fixed clock cycle which was
>not
>correct along the sampling time also being hardcoded. Stefan's "respect
>ADC
>clocking limitations" and this patch are based on our above
>observations.
Fair enough. Can see how this was missed in the first place.  Good to see it fixed.
>
>[1] https://lkml.org/lkml/2015/6/30/103
>
>- Sanchayan.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
