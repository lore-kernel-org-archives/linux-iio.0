Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751946AbdFKNuk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 09:50:40 -0400
Date: Sun, 11 Jun 2017 14:50:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        denis.ciocca@st.com
Subject: Re: [PATCH 2/2] iio: magnetometer: st_magn_spi: fix spi_device_id
 table
Message-ID: <20170611145027.06315770@kernel.org>
In-Reply-To: <20170606205124.14905-3-lorenzo.bianconi@st.com>
References: <20170606205124.14905-1-lorenzo.bianconi@st.com>
        <20170606205124.14905-3-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue,  6 Jun 2017 22:51:24 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Remove LSM303DLHC, LSM303DLM from st_magn_id_table since LSM303DL series
> does not support spi interface
> 
> Fixes: 872e79add756 (iio: magn: Add STMicroelectronics magn driver)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

thanks,
Jonathan

> ---
>  drivers/iio/magnetometer/st_magn_spi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> index 6325e7dc8e03..f3cb4dc05391 100644
> --- a/drivers/iio/magnetometer/st_magn_spi.c
> +++ b/drivers/iio/magnetometer/st_magn_spi.c
> @@ -48,8 +48,6 @@ static int st_magn_spi_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id st_magn_id_table[] = {
> -	{ LSM303DLHC_MAGN_DEV_NAME },
> -	{ LSM303DLM_MAGN_DEV_NAME },
>  	{ LIS3MDL_MAGN_DEV_NAME },
>  	{ LSM303AGR_MAGN_DEV_NAME },
>  	{},

