Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35849 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdBOJhF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Feb 2017 04:37:05 -0500
Received: by mail-wm0-f44.google.com with SMTP id c85so37125500wmi.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Feb 2017 01:37:04 -0800 (PST)
Date: Wed, 15 Feb 2017 09:37:01 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: Re: [PATCH v3 05/18] mfd: axp20x: add ADC cells for AXP20X and
 AXP22X PMICs
Message-ID: <20170215093701.k33jmzeu4xz5guet@dell>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-6-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170214094112.27426-6-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 14 Feb 2017, Quentin Schulz wrote:

> This adds the AXP20X/AXP22x ADCs driver to the mfd cells of the AXP209,
> AXP221 and AXP223 MFD.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> 
> v3:
>  - removed of_compatible as DT node has been removed,
>  - use different names to probe the ADC driver,
> 
>  drivers/mfd/axp20x.c | 6 ++++++
>  1 file changed, 6 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 9c2fd37..a44a2fe 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -581,6 +581,8 @@ static struct mfd_cell axp20x_cells[] = {
>  	}, {
>  		.name		= "axp20x-regulator",
>  	}, {
> +		.name		= "axp20x-adc",
> +	}, {
>  		.name		= "axp20x-ac-power-supply",
>  		.of_compatible	= "x-powers,axp202-ac-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
> @@ -601,6 +603,8 @@ static struct mfd_cell axp221_cells[] = {
>  	}, {
>  		.name		= "axp20x-regulator",
>  	}, {
> +		.name		= "axp22x-adc"
> +	}, {
>  		.name		= "axp20x-usb-power-supply",
>  		.of_compatible	= "x-powers,axp221-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
> @@ -614,6 +618,8 @@ static struct mfd_cell axp223_cells[] = {
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
