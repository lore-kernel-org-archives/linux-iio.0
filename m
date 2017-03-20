Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36533 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754163AbdCTKo3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 06:44:29 -0400
Received: by mail-wm0-f53.google.com with SMTP id n11so59798097wma.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Mar 2017 03:43:49 -0700 (PDT)
Date: Mon, 20 Mar 2017 10:43:45 +0000
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
Subject: Re: [RESEND PATCH v4 3/9] mfd: axp20x: add ADC cells for AXP20X and
 AXP22X PMICs
Message-ID: <20170320104345.3qjsv3j3cip7uj4i@dell>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
 <20170320081653.8884-4-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170320081653.8884-4-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 20 Mar 2017, Quentin Schulz wrote:

> This adds the AXP20X/AXP22x ADCs driver to the mfd cells of the AXP209,
> AXP221 and AXP223 MFD.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> v3:
>  - removed of_compatible as DT node has been removed,
>  - use different names to probe the ADC driver,
> 
>  drivers/mfd/axp20x.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index e02edf1..46bdd23 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -590,6 +590,8 @@ static struct mfd_cell axp20x_cells[] = {
>  	}, {
>  		.name		= "axp20x-regulator",
>  	}, {
> +		.name		= "axp20x-adc",
> +	}, {
>  		.name		= "axp20x-ac-power-supply",
>  		.of_compatible	= "x-powers,axp202-ac-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
> @@ -610,6 +612,8 @@ static struct mfd_cell axp221_cells[] = {
>  	}, {
>  		.name		= "axp20x-regulator",
>  	}, {
> +		.name		= "axp22x-adc"
> +	}, {
>  		.name		= "axp20x-usb-power-supply",
>  		.of_compatible	= "x-powers,axp221-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
> @@ -623,6 +627,8 @@ static struct mfd_cell axp223_cells[] = {
>  		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
>  		.resources		= axp22x_pek_resources,
>  	}, {
> +		.name		= "axp22x-adc",
> +	}, {
>  		.name			= "axp20x-regulator",
>  	}, {
>  		.name		= "axp20x-usb-power-supply",

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
