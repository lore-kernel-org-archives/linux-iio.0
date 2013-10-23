Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50088 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab3JWP6s (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Oct 2013 11:58:48 -0400
Message-ID: <52680073.5040802@kernel.org>
Date: Wed, 23 Oct 2013 17:59:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>, linux-iio@vger.kernel.org
CC: lee.jones@linaro.org, denis.ciocca@gmail.com
Subject: Re: [PATCH 1/1] iio:pressure: Adds LPS001WP support also on spi interface
 and Kconfig fix
References: <1382466756-21172-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1382466756-21172-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/22/13 19:32, Denis CIOCCA wrote:
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/pressure/Kconfig           |    2 +-
>  drivers/iio/pressure/st_pressure_spi.c |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 26fdc0b..4f2e0f9 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -14,7 +14,7 @@ config IIO_ST_PRESS
>  	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
>  	help
>  	  Say yes here to build support for STMicroelectronics pressure
> -	  sensors: LPS331AP.
> +	  sensors: LPS001WP, LPS331AP.
>  
>  	  This driver can also be built as a module. If so, these modules
>  	  will be created:
> diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> index 399a29b..27322af 100644
> --- a/drivers/iio/pressure/st_pressure_spi.c
> +++ b/drivers/iio/pressure/st_pressure_spi.c
> @@ -48,6 +48,7 @@ static int st_press_spi_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id st_press_id_table[] = {
> +	{ LPS001WP_PRESS_DEV_NAME },
>  	{ LPS331AP_PRESS_DEV_NAME },
>  	{},
>  };
> 
