Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36544 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759007AbdADLwA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jan 2017 06:52:00 -0500
Received: by mail-wm0-f46.google.com with SMTP id c85so220785255wmi.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Jan 2017 03:51:57 -0800 (PST)
Date: Wed, 4 Jan 2017 11:55:39 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: Re: [PATCH 02/22] mfd: axp20x: add ADC data regs to volatile regs
 for AXP22X
Message-ID: <20170104115539.GA24058@dell>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-3-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170102163723.7939-3-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 02 Jan 2017, Quentin Schulz wrote:

> The AXP22X PMICs have multiple ADCs, each one exposing data from the
> different power supplies connected to the PMIC.
> 
> This adds the different ADC data registers to the volatile registers of
> the AXP22X PMIC.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
> ---
>  drivers/mfd/axp20x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 619a83e..a33db5e 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -100,6 +100,7 @@ static const struct regmap_range axp22x_writeable_ranges[] = {
>  static const struct regmap_range axp22x_volatile_ranges[] = {
>  	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
>  	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> +	regmap_reg_range(AXP22X_TEMP_ADC_H, AXP20X_BATT_DISCHRG_I_L),
>  	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
>  	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
>  	regmap_reg_range(AXP22X_PMIC_ADC_H, AXP20X_IPSOUT_V_HIGH_L),

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
