Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37172 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbdCTKo3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 06:44:29 -0400
Received: by mail-wm0-f43.google.com with SMTP id n11so60646718wma.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Mar 2017 03:44:02 -0700 (PDT)
Date: Mon, 20 Mar 2017 10:43:58 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        icenowy@aosc.xyz, liam@networkimprov.net,
        thomas.petazzoni@free-electrons.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [RESEND PATCH v4 4/9] mfd: axp20x: add AC power supply cells for
 AXP22X PMICs
Message-ID: <20170320104358.37h3tn2ikwpyhalj@dell>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
 <20170320081653.8884-5-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170320081653.8884-5-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 20 Mar 2017, Quentin Schulz wrote:

> The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
> supply.
> 
> This adds the AC power supply driver to the MFD cells of the AXP22X
> PMICs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-By: Sebastian Reichel <sre@kernel.org>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/axp20x.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 46bdd23..37643b1 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -614,6 +614,11 @@ static struct mfd_cell axp221_cells[] = {
>  	}, {
>  		.name		= "axp22x-adc"
>  	}, {
> +		.name		= "axp20x-ac-power-supply",
> +		.of_compatible	= "x-powers,axp221-ac-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources	= axp20x_ac_power_supply_resources,
> +	}, {
>  		.name		= "axp20x-usb-power-supply",
>  		.of_compatible	= "x-powers,axp221-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
> @@ -631,6 +636,11 @@ static struct mfd_cell axp223_cells[] = {
>  	}, {
>  		.name			= "axp20x-regulator",
>  	}, {
> +		.name		= "axp20x-ac-power-supply",
> +		.of_compatible	= "x-powers,axp221-ac-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources	= axp20x_ac_power_supply_resources,
> +	}, {
>  		.name		= "axp20x-usb-power-supply",
>  		.of_compatible	= "x-powers,axp223-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
