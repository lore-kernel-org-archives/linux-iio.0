Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33492 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753212AbdBUSUr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Feb 2017 13:20:47 -0500
Subject: Re: [PATCH v3 17/18] ARM: dts: sun8i: sina33: enable battery power
 supply subnode
To: Chen-Yu Tsai <wens@csie.org>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-18-quentin.schulz@free-electrons.com>
 <CAGb2v64SnsrckN7+cv5woHzLTWrM455xjUQFh3dKHUNhjgBB7w@mail.gmail.com>
Cc: knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
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
Message-ID: <4512847d-45b7-c51e-10df-f5f47ae01a38@free-electrons.com>
Date: Tue, 21 Feb 2017 19:20:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAGb2v64SnsrckN7+cv5woHzLTWrM455xjUQFh3dKHUNhjgBB7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/02/2017 05:50, Chen-Yu Tsai wrote:
> On Tue, Feb 14, 2017 at 5:41 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
>> The Sinlinx SinA33 has an AXP223 PMIC and a battery connector, thus, we
>> enable the battery power supply subnode in its Device Tree.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Battery charger enabled without any description of the associated battery...
> In this case I think the driver should use the lowest charge current to be
> safe?
> 

Seems fair.

Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
