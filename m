Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:49040 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbdBUEwO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 23:52:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170215093701.k33jmzeu4xz5guet@dell>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-6-quentin.schulz@free-electrons.com> <20170215093701.k33jmzeu4xz5guet@dell>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 21 Feb 2017 12:51:49 +0800
Message-ID: <CAGb2v64zeOG+JtifgtdtxDMvi=+i6aeJ9_5UqghqB2oeBTjA3Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] mfd: axp20x: add ADC cells for AXP20X and AXP22X PMICs
To: Lee Jones <lee.jones@linaro.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Sebastian Reichel <sre@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 15, 2017 at 5:37 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 14 Feb 2017, Quentin Schulz wrote:
>
>> This adds the AXP20X/AXP22x ADCs driver to the mfd cells of the AXP209,
>> AXP221 and AXP223 MFD.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>
>> v3:
>>  - removed of_compatible as DT node has been removed,
>>  - use different names to probe the ADC driver,
>>
>>  drivers/mfd/axp20x.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
