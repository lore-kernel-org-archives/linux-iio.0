Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeICAPJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 20:15:09 -0400
Date: Sun, 2 Sep 2018 20:58:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 02/30] mfd: Kconfig: Remove MFD_SUN4I_GPADC config
 option
Message-ID: <20180902205808.49cbc19a@archlinux>
In-Reply-To: <20180830154518.29507-3-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
        <20180830154518.29507-3-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 30 Aug 2018 17:44:50 +0200
Philipp Rossak <embed3d@gmail.com> wrote:

> We are merging the mfd:sun4i-gpadc driver into the
> iio/adc/sun4i-gpadc driver. So we need to remove the MFD_SUN4I_GPADC
> config option.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Do need to separate this and patch 1 as they are really two
facets of the same thing.

Jonathan

> ---
>  drivers/mfd/Kconfig | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5aa194..c7ab57d65610 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -40,23 +40,6 @@ config MFD_ACT8945A
>  	  linear regulators, along with a complete ActivePath battery
>  	  charger.
>  
> -config MFD_SUN4I_GPADC
> -	tristate "Allwinner sunxi platforms' GPADC MFD driver"
> -	select MFD_CORE
> -	select REGMAP_MMIO
> -	select REGMAP_IRQ
> -	depends on ARCH_SUNXI || COMPILE_TEST
> -	depends on !TOUCHSCREEN_SUN4I
> -	help
> -	  Select this to get support for Allwinner SoCs (A10, A13 and A31) ADC.
> -	  This driver will only map the hardware interrupt and registers, you
> -	  have to select individual drivers based on this MFD to be able to use
> -	  the ADC or the thermal sensor. This will try to probe the ADC driver
> -	  sun4i-gpadc-iio and the hwmon driver iio_hwmon.
> -
> -	  To compile this driver as a module, choose M here: the module will be
> -	  called sun4i-gpadc.
> -
>  config MFD_AS3711
>  	bool "AMS AS3711"
>  	select MFD_CORE
