Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51724 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938129AbdAEISR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2017 03:18:17 -0500
Subject: Re: [PATCH 15/22] mfd: axp20x: add CHRG_CTRL1 to writeable regs for
 AXP20X/AXP22X
To: Chen-Yu Tsai <wens@csie.org>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-16-quentin.schulz@free-electrons.com>
 <CAGb2v67KmaECfFO+QBxKbtKscD0O=KNVHO1TS4FspYEdaLWUCA@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <304cdd9e-93a7-f554-99ce-e3e01762761d@free-electrons.com>
Date: Thu, 5 Jan 2017 09:10:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAGb2v67KmaECfFO+QBxKbtKscD0O=KNVHO1TS4FspYEdaLWUCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/01/2017 07:10, Chen-Yu Tsai wrote:
> On Tue, Jan 3, 2017 at 12:37 AM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
>> The CHR_CTRL1 register is made of 7 read-write bits with one being used
>> to set the target voltage for battery charging.
> 
> The description is incorrect.
> 
> All 8 bits are read-write:
> 
>   - The highest bit enables the charger module
>   - Bits [6:5] set the target voltage
>   - Bits [4:3] set when the charge cycle ends, based on percentage
>     of charge current
>   - Bits [2:0] set the charge current
> 
> Feel free to use the above in the commit message.
> 

Thanks for the correction.

>>
>> This adds the CHRG_CTRL1 register to the list of writeable registers for
>> AXP20X and AXP22X PMICs.
> 
> You might want to add up to CHRG_CTRL3 for the AXP22x and CHRG_CTRL2
> for the AXP20x. These control additional aspects of the charger.
> 

ACK.

> AXP20X_CHRG_BAK_CTRL controls the charger for the RTC battery. You
> could add this now, or let the person doing the RTC battery driver
> add it.

I'll let the person adding the RTC battery driver add it.

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
