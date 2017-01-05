Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:35618 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbdAEGSr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2017 01:18:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170102163723.7939-16-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com> <20170102163723.7939-16-quentin.schulz@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 5 Jan 2017 14:10:32 +0800
Message-ID: <CAGb2v67KmaECfFO+QBxKbtKscD0O=KNVHO1TS4FspYEdaLWUCA@mail.gmail.com>
Subject: Re: [PATCH 15/22] mfd: axp20x: add CHRG_CTRL1 to writeable regs for AXP20X/AXP22X
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
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

On Tue, Jan 3, 2017 at 12:37 AM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The CHR_CTRL1 register is made of 7 read-write bits with one being used
> to set the target voltage for battery charging.

The description is incorrect.

All 8 bits are read-write:

  - The highest bit enables the charger module
  - Bits [6:5] set the target voltage
  - Bits [4:3] set when the charge cycle ends, based on percentage
    of charge current
  - Bits [2:0] set the charge current

Feel free to use the above in the commit message.

>
> This adds the CHRG_CTRL1 register to the list of writeable registers for
> AXP20X and AXP22X PMICs.

You might want to add up to CHRG_CTRL3 for the AXP22x and CHRG_CTRL2
for the AXP20x. These control additional aspects of the charger.

AXP20X_CHRG_BAK_CTRL controls the charger for the RTC battery. You
could add this now, or let the person doing the RTC battery driver
add it.

Regards
ChenYu

>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 65c57d0..19bdba3 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -66,6 +66,7 @@ static const struct regmap_access_table axp152_volatile_table = {
>  static const struct regmap_range axp20x_writeable_ranges[] = {
>         regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>         regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> +       regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL1),
>         regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
>         regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
>  };
> @@ -94,6 +95,7 @@ static const struct regmap_access_table axp20x_volatile_table = {
>  static const struct regmap_range axp22x_writeable_ranges[] = {
>         regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>         regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> +       regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL1),
>         regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
>  };
>
> --
> 2.9.3
>
