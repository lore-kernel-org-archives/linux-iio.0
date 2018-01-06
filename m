Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753129AbeAFMSY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 07:18:24 -0500
Date: Sat, 6 Jan 2018 12:18:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: st_lsm6dsx: fix endianness in
 st_lsm6dsx_read_oneshot()
Message-ID: <20180106121820.2fa5a849@archlinux>
In-Reply-To: <20180101185444.22045-2-lorenzo.bianconi@redhat.com>
References: <20180101185444.22045-2-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  1 Jan 2018 19:54:42 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Apply le16_to_cpu() to data read from the sensor in order to take into
> account architecture endianness
> 
> Fixes: 290a6ce11d93 (iio: imu: add support to lsm6dsx driver)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
I'm going to take this via togreg rather than the fixes branch
purely because we are very late in the cycle so that is probably
quicker now!

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 239c735242be..812cd25f284e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -448,7 +448,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>  
>  	st_lsm6dsx_sensor_disable(sensor);
>  
> -	*val = (s16)data;
> +	*val = (s16)le16_to_cpu(data);
>  
>  	return IIO_VAL_INT;
>  }

