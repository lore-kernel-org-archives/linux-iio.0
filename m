Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:54950 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754485AbdA0Jc1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 04:32:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170127085458.18270-3-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com> <20170127085458.18270-3-quentin.schulz@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 27 Jan 2017 17:30:48 +0800
Message-ID: <CAGb2v65kt9GdEtZWDRwUF-jVC=gcRYYB-wHgG5wEgx7cfkidEw@mail.gmail.com>
Subject: Re: [PATCH v2 02/25] mfd: axp20x: correct name of temperature data
 ADC registers
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
> The registers 0x56 and 0x57 of AXP22X PMIC store the value of the
> internal temperature of the PMIC.
>
> This patch modifies the name of these registers from AXP22X_PMIC_ADC_H/L
> to AXP22X_PMIC_TEMP_H/L so their purpose is clearer.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
