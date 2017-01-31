Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:41264 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdAaFQk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2017 00:16:40 -0500
MIME-Version: 1.0
In-Reply-To: <7ecf7c00-3f8e-04e5-4c96-db1843294f2e@kernel.org>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-20-quentin.schulz@free-electrons.com> <7ecf7c00-3f8e-04e5-4c96-db1843294f2e@kernel.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 31 Jan 2017 13:06:23 +0800
Message-ID: <CAGb2v6662oikMk8uhD-mMx9d4Gf4Fw64ndOsj89EPcNxA9S6Cg@mail.gmail.com>
Subject: Re: [PATCH v2 19/25] iio: adc: axp20x_adc: map battery IIO channels
To: Jonathan Cameron <jic23@kernel.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
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

On Sat, Jan 28, 2017 at 10:52 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 27/01/17 08:54, Quentin Schulz wrote:
>> This maps the IIO channels batt_v, batt_chrg_i and batt_dischrg_i
>> (respectively exposing the current charging and discharging currents and
>> current voltage measures of the battery power supply) to the battery
>> power supply driver.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
