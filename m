Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43822 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdCVGbd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 02:31:33 -0400
Date: Wed, 22 Mar 2017 06:31:24 +0000
In-Reply-To: <CAGb2v66JC65=9WiMy-Nu+9tTFRLsJL2Eyb0wfJV_K=65ABc6Zg@mail.gmail.com>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com> <20170320081653.8884-3-quentin.schulz@free-electrons.com> <CAGb2v66JC65=9WiMy-Nu+9tTFRLsJL2Eyb0wfJV_K=65ABc6Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [RESEND PATCH v4 2/9] iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs
To: Chen-Yu Tsai <wens@csie.org>, Jonathan Cameron <jic23@kernel.org>
CC: Quentin Schulz <quentin.schulz@free-electrons.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Liam Breck <liam@networkimprov.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-iio@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <B745132F-4A85-496A-93FC-515DF126895A@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 22 March 2017 04:34:45 GMT+00:00, Chen-Yu Tsai <wens@csie.org> wrote:
>Hi,
>
>On Mon, Mar 20, 2017 at 4:16 PM, Quentin Schulz
><quentin.schulz@free-electrons.com> wrote:
>> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose
>the
>> battery voltage, battery charge and discharge currents, AC-in and
>VBUS
>> voltages and currents, 2 GPIOs muxable in ADC mode and PMIC
>temperature.
>>
>> This adds support for most of AXP20X and AXP22X ADCs.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Acked-by: Chen-Yu Tsai <wens@csie.org>
>> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
>
>This patch seems to depend on commit 4707274714ef ("mfd: axp20x:
>Correct name
>of temperature data ADC registers") currently in the mfd tree.
>
>Jonathan, would it be ok for Lee to take this patch through the mfd
>tree
>as well?
Sure.
>
>
>Thanks
>ChenYu
>
>P.S. I'm thinking about having MFD_AXP20X imply its various
>sub-drivers.
>Not sure if that was the intended usage of the new imply syntax though.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
