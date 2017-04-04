Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:32919 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbdDDIbj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Apr 2017 04:31:39 -0400
Received: by mail-wr0-f173.google.com with SMTP id w43so203264092wrb.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Apr 2017 01:31:38 -0700 (PDT)
Date: Tue, 4 Apr 2017 09:31:33 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        thomas.petazzoni@free-electrons.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.xyz
Subject: Re: [PATCH v3 00/11] add thermal throttling to Allwinner A33 SoC
Message-ID: <20170404083133.ffrsxjsakynruwzv@dell>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 21 Mar 2017, Quentin Schulz wrote:

> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. The first four channels can be used
> either for the ADC or the touchscreen and the fifth channel is used for
> the thermal sensor. We currently have a driver for the two latter
> functions in drivers/input/touchscreen/sun4i-ts.c but we don't have
> access to the ADC feature at all. It is meant to replace the current
> driver by using MFD and subdrivers for existing bindings.
> 
> The Allwinner A33 only has a thermal sensor present in the GPADC. In
> addition, there is not an existing DT binding for the GPADC. Thus, we do
> not need the sun4i-gpadc MFD driver which was made to keep DT compatibility
> and probe subdrivers without the need to add DT subnodes.
> 
> This series of patch adds the thermal sensor for the A33 and GPU/CPU
> thermal throttling. It also adds the cpu-supply property to the CPU node
> needed by the Sinlinx SinA33 and Olinuxino A33 to adapt their CPU regulator
> voltage depending on the currently used OPP. The other A33 boards all have
> their cpu-supply property set.
> 
> This series also fixes the missing operating-points-v2 property in cpu DT
> nodes. Finally, it also adds all remaining OPPs which can be found in
> Allwinner 3.4 linux and fex files of all A33 boards.
> 
> This series of patch is based on this[1] series of patch.
> 
> v3:
>   - fixed compatible name in DT and in documentation,
>   - fixed DT node name and label,
>   - added explanations in commit logs,
>   - moved frequencies that need overvolting to board DTS instead of A33 DTSI,
>   - fixed a typo in if is_enabled condition,
>   - removed all patches concerning Olimex Olinuxino (no HW to test on),

What is the plan for this series?

I'm guessing there are no hard dependencies on the ARM parts?

If not, I'm happy to take the changes to 'drivers/*'.

> [1] https://lkml.org/lkml/2016/12/13/298 : "[PATCH v9] add support for Allwinner
> SoCs ADC"
> 
> Thanks,
> Quentin
> 
> Maxime Ripard (1):
>   ARM: sun8i: a33: Add devfreq-based GPU cooling
> 
> Quentin Schulz (10):
>   ARM: sun8i: a33: add operating-points-v2 property to all nodes
>   ARM: sun8i: a33: add all operating points
>   ARM: dts: sun8i: sina33: add cpu-supply
>   Documentation: DT: bindings: mfd: add A33 GPADC binding
>   Documentation: DT: bindings: input: touschcreen: remove sun4i
>     documentation
>   iio: adc: sun4i-gpadc-iio: move code used in MFD probing to new
>     function
>   iio: adc: sun4i-gpadc-iio: add support for A33 thermal sensor
>   ARM: dtsi: sun8i: a33: add thermal sensor
>   ARM: dtsi: sun8i: a33: add CPU thermal throttling
>   ARM: sun8i: sina33: add highest OPP of CPUs
> 
>  .../touchscreen/sun4i.txt => mfd/sun4i-gpadc.txt}  |  21 +++
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   1 +
>  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  18 +++
>  arch/arm/boot/dts/sun8i-a33.dtsi                   | 141 +++++++++++++++++
>  drivers/iio/adc/Kconfig                            |   2 +-
>  drivers/iio/adc/sun4i-gpadc-iio.c                  | 170 +++++++++++++++++----
>  include/linux/mfd/sun4i-gpadc.h                    |   4 +
>  7 files changed, 324 insertions(+), 33 deletions(-)
>  rename Documentation/devicetree/bindings/{input/touchscreen/sun4i.txt => mfd/sun4i-gpadc.txt} (64%)
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
