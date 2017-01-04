Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33223 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758416AbdADLE2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jan 2017 06:04:28 -0500
Received: by mail-wm0-f54.google.com with SMTP id v3so2780339wme.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Jan 2017 03:04:27 -0800 (PST)
Date: Wed, 4 Jan 2017 10:58:33 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        wens@csie.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        antoine.tenart@free-electrons.com,
        thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH v9 2/3] mfd: Kconfig: MFD_SUN4I_GPADC depends on
 !TOUCHSCREN_SUN4I_GPADC
Message-ID: <20170104105833.GY27589@dell>
References: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
 <20161213143332.24988-3-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161213143332.24988-3-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 13 Dec 2016, Quentin Schulz wrote:

> MFD_SUN4I_GPADC and TOUCHSCREEN_SUN4I are incompatible (both are drivers
> for Allwinner SoCs' ADC). This makes sure TOUCHSCREEN_SUN4I isn't
> enabled while MFD_SUN4I_GPADC is enabled.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> added in v8. I wrongly put the XOR dependance for SUN4I_GPADC and
> TOUCHSCREEN_SUN4I instead of for MFD_SUN4I_GPADC and TOUCHSCREEN_SUN4I.
> 
>  drivers/mfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 443ee50..e803884 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -45,6 +45,7 @@ config MFD_SUN4I_GPADC
>  	select MFD_CORE
>  	select REGMAP_MMIO
>  	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on !TOUCHSCREEN_SUN4I
>  	help
>  	  Select this to get support for Allwinner SoCs (A10, A13 and A31) ADC.
>  	  This driver will only map the hardware interrupt and registers, you

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
