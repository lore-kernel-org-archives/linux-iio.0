Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:48980 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdBUEuw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 23:50:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170214094112.27426-18-quentin.schulz@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com> <20170214094112.27426-18-quentin.schulz@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 21 Feb 2017 12:50:28 +0800
Message-ID: <CAGb2v64SnsrckN7+cv5woHzLTWrM455xjUQFh3dKHUNhjgBB7w@mail.gmail.com>
Subject: Re: [PATCH v3 17/18] ARM: dts: sun8i: sina33: enable battery power
 supply subnode
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

On Tue, Feb 14, 2017 at 5:41 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The Sinlinx SinA33 has an AXP223 PMIC and a battery connector, thus, we
> enable the battery power supply subnode in its Device Tree.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Battery charger enabled without any description of the associated battery...
In this case I think the driver should use the lowest charge current to be
safe?

Acked-by: Chen-Yu Tsai <wens@csie.org>
