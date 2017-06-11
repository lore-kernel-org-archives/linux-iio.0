Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751916AbdFKNtb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 09:49:31 -0400
Date: Sun, 11 Jun 2017 14:49:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        denis.ciocca@st.com
Subject: Re: [PATCH 1/2] iio: accel: st_accel_spi: fix spi_device_id table
Message-ID: <20170611144926.5f6a49c1@kernel.org>
In-Reply-To: <20170606205124.14905-2-lorenzo.bianconi@st.com>
References: <20170606205124.14905-1-lorenzo.bianconi@st.com>
        <20170606205124.14905-2-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue,  6 Jun 2017 22:51:23 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Remove LSM303DL, LSM303DLM, LSM303DLH, LSM303DLHC from st_accel_id_table
> since LSM303DL series does not support spi interface
> 
> Fixes: d62511689de5 (iio: accel: Add STMicroelectronics accel driver)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/st_accel_spi.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index 29a15f27a51b..1a867f5563a4 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -47,15 +47,11 @@ static int st_accel_spi_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id st_accel_id_table[] = {
> -	{ LSM303DLH_ACCEL_DEV_NAME },
> -	{ LSM303DLHC_ACCEL_DEV_NAME },
>  	{ LIS3DH_ACCEL_DEV_NAME },
>  	{ LSM330D_ACCEL_DEV_NAME },
>  	{ LSM330DL_ACCEL_DEV_NAME },
>  	{ LSM330DLC_ACCEL_DEV_NAME },
>  	{ LIS331DLH_ACCEL_DEV_NAME },
> -	{ LSM303DL_ACCEL_DEV_NAME },
> -	{ LSM303DLM_ACCEL_DEV_NAME },
>  	{ LSM330_ACCEL_DEV_NAME },
>  	{ LSM303AGR_ACCEL_DEV_NAME },
>  	{ LIS2DH12_ACCEL_DEV_NAME },

