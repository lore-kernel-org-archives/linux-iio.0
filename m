Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37410 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758776AbcC3Iun (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Mar 2016 04:50:43 -0400
Received: by mail-wm0-f46.google.com with SMTP id p65so61130161wmp.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Mar 2016 01:50:42 -0700 (PDT)
Subject: Re: [PATCH 5/8] nvmem: Fix io memory dependencies
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
References: <1458945655-5027-1-git-send-email-richard@nod.at>
 <1458945655-5027-5-git-send-email-richard@nod.at>
Cc: linux-iio@vger.kernel.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <56FB935F.4000404@linaro.org>
Date: Wed, 30 Mar 2016 09:50:39 +0100
MIME-Version: 1.0
In-Reply-To: <1458945655-5027-5-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thanks for the patch,

But there is already a same patch [1] submitted few days back.
I will pick that one.


Thanks,
srini

[1] http://lkml.iu.edu/hypermail/linux/kernel/1603.0/03538.html

On 25/03/16 22:40, Richard Weinberger wrote:
> Not all archs have io memory.
>
> Fixes the following build error:
> ERROR: "devm_ioremap_resource" [drivers/nvmem/nvmem_mtk-efuse.ko] undefined!
> ERROR: "devm_ioremap_resource" [drivers/nvmem/nvmem_lpc18xx_eeprom.ko] undefined!
>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>   drivers/nvmem/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index ca52952..3766da3 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -27,6 +27,7 @@ config NVMEM_IMX_OCOTP
>
>   config NVMEM_LPC18XX_EEPROM
>   	tristate "NXP LPC18XX EEPROM Memory Support"
> +	depends on HAS_IOMEM
>   	depends on ARCH_LPC18XX || COMPILE_TEST
>   	help
>   	  Say Y here to include support for NXP LPC18xx EEPROM memory found in
> @@ -48,6 +49,7 @@ config NVMEM_MXS_OCOTP
>
>   config MTK_EFUSE
>   	tristate "Mediatek SoCs EFUSE support"
> +	depends on HAS_IOMEM
>   	depends on ARCH_MEDIATEK || COMPILE_TEST
>   	select REGMAP_MMIO
>   	help
>
