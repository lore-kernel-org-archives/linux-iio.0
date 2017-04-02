Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48024 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdDBKiu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 06:38:50 -0400
Subject: Re: [PATCH] iio: adc: sun4i: add THERMAL dependency
To: Arnd Bergmann <arnd@arndb.de>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
References: <20170328100855.3982514-1-arnd@arndb.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <871e2c8f-b81d-42ac-14b4-eb542f5b8e0a@kernel.org>
Date: Sun, 2 Apr 2017 11:38:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170328100855.3982514-1-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/17 11:07, Arnd Bergmann wrote:
> With CONFIG_THERMAL=m and CONFIG_SUN4I_GPADC=y, we get a link error
> from calling devm_thermal_zone_of_sensor_register:
> 
> drivers/iio/built-in.o: In function `sun4i_gpadc_probe':
> :(.text+0x1c284): undefined reference to `devm_thermal_zone_of_sensor_register'
> 
> This adds a Kconfig dependency to ensure we can only have the ADC
> driver as built-in when this function is also built-in, or when
> we see the empty stub implementation. When the thermal code is
> a module, we can still build the adc driver as a module, too.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Thanks Arnd,

Applied to the togreg branch of iio.git.  Should be heading
to Greg later today if build tests pass on the branch.

I've added a fixes tag.

Jonathan
> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d0af51d7bcac..7ccbad70a617 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -562,6 +562,7 @@ config SUN4I_GPADC
>  	tristate "Support for the Allwinner SoCs GPADC"
>  	depends on IIO
>  	depends on MFD_SUN4I_GPADC
> +	depends on THERMAL || !THERMAL_OF
>  	help
>  	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
>  	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
> 

