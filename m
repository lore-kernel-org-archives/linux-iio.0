Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:40922 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdAaEJN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 23:09:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170127085458.18270-7-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com> <20170127085458.18270-7-quentin.schulz@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 31 Jan 2017 12:08:48 +0800
Message-ID: <CAGb2v66pKZQb1c84hu+2kxjPvAhmAK6z+TqPWT3ag=CyELQkiQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/25] ARM: dtsi: axp209: add AXP209 ADC subnode
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
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
        =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jan 27, 2017 at 4:54 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> X-Powers AXP209 PMIC has multiple ADCs, each one exposing data from the
> different power supplies connected to the PMIC.
>
> This adds the ADC subnode for AXP20X PMIC.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Given the device node no longer exports anything, we might
as well drop it from the device tree.
