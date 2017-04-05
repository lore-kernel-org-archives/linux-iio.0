Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41414 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932830AbdDELXL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2017 07:23:11 -0400
Subject: Re: [PATCH v3 00/11] add thermal throttling to Allwinner A33 SoC
To: Lee Jones <lee.jones@linaro.org>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170404083133.ffrsxjsakynruwzv@dell>
 <fcc2ec2c-cf46-0cf9-1933-53511fe77cf2@free-electrons.com>
 <20170405095752.pji6o7u5no6svd5i@dell>
Cc: mark.rutland@arm.com, thomas.petazzoni@free-electrons.com,
        lars@metafoo.de, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com,
        dmitry.torokhov@gmail.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, pmeerw@pmeerw.net,
        knaack.h@gmx.de, maxime.ripard@free-electrons.com,
        linux-input@vger.kernel.org, jic23@kernel.org, icenowy@aosc.xyz
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <a5ef789f-7cd4-3f00-e4f0-dce86076e506@free-electrons.com>
Date: Wed, 5 Apr 2017 13:23:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170405095752.pji6o7u5no6svd5i@dell>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lee,

On 05/04/2017 11:57, Lee Jones wrote:
> On Wed, 05 Apr 2017, Quentin Schulz wrote:
>> On 04/04/2017 10:31, Lee Jones wrote:
>>> On Tue, 21 Mar 2017, Quentin Schulz wrote:
>>>> v3:
>>>>   - fixed compatible name in DT and in documentation,
>>>>   - fixed DT node name and label,
>>>>   - added explanations in commit logs,
>>>>   - moved frequencies that need overvolting to board DTS instead of A33 DTSI,
>>>>   - fixed a typo in if is_enabled condition,
>>>>   - removed all patches concerning Olimex Olinuxino (no HW to test on),
>>>
>>> What is the plan for this series?
>>>
>>> I'm guessing there are no hard dependencies on the ARM parts?
>>>
>>> If not, I'm happy to take the changes to 'drivers/*'.
>>>
>>
>> I've sent a v4 to add some Acked-by and change a few commit "titles".
>> It's ready to be merged with only the following patch required (which
>> Jonathan asked if you could merge it through the mfd tree): "[RESEND
>> PATCH v4] iio: adc: add support for X-Powers AXP20X and AXP22X PMICs
>> ADCs" (https://patchwork.kernel.org/patch/9660879/)

I got things mixed up between the two different IIO/ADC drivers I'm
trying to get merge. Forget about this dependency, that's not for this
patch series. Sorry for that.

> 
> Right, but how would you like *this* patch-set applied?
> 
> I'm guessing the ARM patches need to go in via ARM-SoC.
> 
> What about the drivers/{input,iio,mfd} patches?
> 
> I'm guessing they're to all go in via my tree?
> 

Patches 1-2 - MFD maintainer I guess? (Lee)
Patches 3-4 - IIO maintainer (Jonathan)
Patches 5-8 - SUNXI maintainer (Maxime)

I think that should do it.

Quentin

>>>> [1] https://lkml.org/lkml/2016/12/13/298 : "[PATCH v9] add support for Allwinner
>>>> SoCs ADC"
>>>>
>>>> Thanks,
>>>> Quentin
>>>>
>>>> Maxime Ripard (1):
>>>>   ARM: sun8i: a33: Add devfreq-based GPU cooling
>>>>
>>>> Quentin Schulz (10):
>>>>   ARM: sun8i: a33: add operating-points-v2 property to all nodes
>>>>   ARM: sun8i: a33: add all operating points
>>>>   ARM: dts: sun8i: sina33: add cpu-supply
>>>>   Documentation: DT: bindings: mfd: add A33 GPADC binding
>>>>   Documentation: DT: bindings: input: touschcreen: remove sun4i
>>>>     documentation
>>>>   iio: adc: sun4i-gpadc-iio: move code used in MFD probing to new
>>>>     function
>>>>   iio: adc: sun4i-gpadc-iio: add support for A33 thermal sensor
>>>>   ARM: dtsi: sun8i: a33: add thermal sensor
>>>>   ARM: dtsi: sun8i: a33: add CPU thermal throttling
>>>>   ARM: sun8i: sina33: add highest OPP of CPUs
>>>>
>>>>  .../touchscreen/sun4i.txt => mfd/sun4i-gpadc.txt}  |  21 +++
>>>>  arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   1 +
>>>>  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  18 +++
>>>>  arch/arm/boot/dts/sun8i-a33.dtsi                   | 141 +++++++++++++++++
>>>>  drivers/iio/adc/Kconfig                            |   2 +-
>>>>  drivers/iio/adc/sun4i-gpadc-iio.c                  | 170 +++++++++++++++++----
>>>>  include/linux/mfd/sun4i-gpadc.h                    |   4 +
>>>>  7 files changed, 324 insertions(+), 33 deletions(-)
>>>>  rename Documentation/devicetree/bindings/{input/touchscreen/sun4i.txt => mfd/sun4i-gpadc.txt} (64%)
>>>>
>>>
>>
> 

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
