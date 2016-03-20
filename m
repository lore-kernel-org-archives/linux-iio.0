Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56727 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbcCTKeP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2016 06:34:15 -0400
Subject: Re: [PATCH] iio: light: apds9960: correct FIFO check condition
To: Matt Ranostay <mranostay@gmail.com>
References: <1458272888-26146-1-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, dcb314@hotmail.com, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56EE7CA5.9060205@kernel.org>
Date: Sun, 20 Mar 2016 10:34:13 +0000
MIME-Version: 1.0
In-Reply-To: <1458272888-26146-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/03/16 03:48, Matt Ranostay wrote:
> Correct issue that the last entry in FIFO was being read twice due
> to an incorrect decrement of entry count variable before condition
> check.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to the fixes branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/light/apds9960.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index f6a07dc..a6af56a 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -769,7 +769,7 @@ static void apds9960_read_gesture_fifo(struct apds9960_data *data)
>  	mutex_lock(&data->lock);
>  	data->gesture_mode_running = 1;
>  
> -	while (cnt-- || (cnt = apds9660_fifo_is_empty(data) > 0)) {
> +	while (cnt || (cnt = apds9660_fifo_is_empty(data) > 0)) {
>  		ret = regmap_bulk_read(data->regmap, APDS9960_REG_GFIFO_BASE,
>  				      &data->buffer, 4);
>  
> @@ -777,6 +777,7 @@ static void apds9960_read_gesture_fifo(struct apds9960_data *data)
>  			goto err_read;
>  
>  		iio_push_to_buffers(data->indio_dev, data->buffer);
> +		cnt--;
>  	}
>  
>  err_read:
> 

