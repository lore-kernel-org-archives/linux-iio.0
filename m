Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:60582 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbFGTZM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 15:25:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Date: Sun, 07 Jun 2015 21:23:03 +0200
From: Stefan Agner <stefan@agner.ch>
To: Jonathan Cameron <jic23@kernel.org>, shawn.guo@linaro.org
Cc: kernel@pengutronix.de, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, B38611@freescale.com,
	maitysanchayan@gmail.com, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] ARM: dts: add property for maximum ADC clock
 frequencies
In-Reply-To: <557477BE.5050108@kernel.org>
References: <1432730872-14325-1-git-send-email-stefan@agner.ch>
 <1432730872-14325-3-git-send-email-stefan@agner.ch>
 <557477BE.5050108@kernel.org>
Message-ID: <b32971379e0b8dcc60620716d3d79aed@agner.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2015-06-07 18:56, Jonathan Cameron wrote:
> On 27/05/15 13:47, Stefan Agner wrote:
>> The ADC clock frequency is limited depending on modes used. Add
>> device tree property which allow to set the mode used and the
>> maximum frequency ratings for the instance. These allows to
>> set the ADC clock to a frequency which is within specification
>> according to the actual mode used.
>>
>> Acked-by: Fugang Duan <B38611@freescale.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> I'm happy to take this via IIO if people want me to, otherwise give
> it's connection to the previous patch that I just applied,

I guess the chances for conflicts are rather small. I don't have any
preferences, Shawn?

--
Stefan

> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> 
>> ---
>>  arch/arm/boot/dts/vfxxx.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
>> index a29c7ce..c6609bd 100644
>> --- a/arch/arm/boot/dts/vfxxx.dtsi
>> +++ b/arch/arm/boot/dts/vfxxx.dtsi
>> @@ -189,6 +189,8 @@
>>  				clocks = <&clks VF610_CLK_ADC0>;
>>  				clock-names = "adc";
>>  				status = "disabled";
>> +				fsl,adck-max-frequency = <30000000>, <40000000>,
>> +							<20000000>;
>>  			};
>>
>>  			wdoga5: wdog@4003e000 {
>> @@ -387,6 +389,8 @@
>>  				clocks = <&clks VF610_CLK_ADC1>;
>>  				clock-names = "adc";
>>  				status = "disabled";
>> +				fsl,adck-max-frequency = <30000000>, <40000000>,
>> +							<20000000>;
>>  			};
>>
>>  			esdhc1: esdhc@400b2000 {
>>

