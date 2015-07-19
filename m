Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47078 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbbGSMpC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 08:45:02 -0400
Message-ID: <55AB9BC7.9040408@kernel.org>
Date: Sun, 19 Jul 2015 13:44:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>
CC: Sanchayan Maity <maitysanchayan@gmail.com>, mark.rutland@arm.com,
	devicetree@vger.kernel.org, B38611@freescale.com,
	pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, kernel@pengutronix.de, galak@codeaurora.org,
	shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] ARM: dts: vf-colibri: Add property for minimum
 sample time
References: <cover.1436880513.git.maitysanchayan@gmail.com> <20e2cfad3fbb1a45332e9936ea493ddc8bfaf51d.1436880513.git.maitysanchayan@gmail.com> <20150715015725.GK4119@tiger> <c84f141e3e222a48b6adf52e686df7e9@agner.ch>
In-Reply-To: <c84f141e3e222a48b6adf52e686df7e9@agner.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/07/15 14:02, Stefan Agner wrote:
> On 2015-07-15 03:57, Shawn Guo wrote:
>> On Tue, Jul 14, 2015 at 07:23:23PM +0530, Sanchayan Maity wrote:
>>> Add a device tree property which allows to specify the minimum sample
>>> time which can be used to calculate the actual ADC cycles required
>>> depending on the hardware.
>>>
>>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/vf-colibri.dtsi | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
>>> index ab10d2e..59f5deb 100644
>>> --- a/arch/arm/boot/dts/vf-colibri.dtsi
>>> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
>>> @@ -16,10 +16,12 @@
>>>  };
>>>
>>>  &adc0 {
>>> +	min-sample-time = <1000>;
>>>  	status = "okay";
>>>  };
>>>
>>>  &adc1 {
>>> +	min-sample-time = <1000>;
>>
>> Since this is the default value anyway, we can just save the patch,
>> right?
> 
> I thought it would be nice to be explicit here and define this value
> which we verified internally.
> 
> On the other hand, we did not derived the minimum value from the DS
> (using the capacity/resistance of the actual analog source connected) to
> maximize the sampling frequency, hence I'm also ok with not explicitly
> defining a value.
I'll drop this patch then and we are all happy (I think)
> 
> --
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

