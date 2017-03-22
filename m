Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:39866 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758764AbdCVDcz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 23:32:55 -0400
MIME-Version: 1.0
In-Reply-To: <20170321153611.16228-2-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com> <20170321153611.16228-2-quentin.schulz@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 22 Mar 2017 11:32:28 +0800
Message-ID: <CAGb2v65qMod+k5Uo-Z4qG=7kMx_FiHhR_01XS+Bn+m3T=JH6bg@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] ARM: sun8i: a33: add operating-points-v2
 property to all nodes
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.xyz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 21, 2017 at 11:36 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The OPP are declared as shared but no operating points are declared for
> cpu1, 2 and 3. Thus, the following error happens during the boot:
>
> cpu cpu1: dev_pm_opp_of_get_sharing_cpus: Couldn't find tcpu_dev node.
>
> This patch applies the operating points to each cpu of the A33.
>

This should have

Fixes: 03749eb88e63 ("ARM: dts: sun8i: add opp-v2 table for A33")

and be merged as fixes for 4.11.

> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
