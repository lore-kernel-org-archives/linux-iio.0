Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58221 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab3IUNmt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 09:42:49 -0400
Message-ID: <523DB07C.3030008@kernel.org>
Date: Sat, 21 Sep 2013 15:43:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org, lee.jones@linaro.org
Subject: Re: [PATCH 1/4] iio:accel: Register buffer also without specific
 trigger
References: <1379494822-9985-1-git-send-email-denis.ciocca@st.com> <1379494822-9985-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1379494822-9985-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 10:00, Denis CIOCCA wrote:
> This patch fix buffer registration that allows to use generic IIO trigger.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied to the togreg branch of iio.git with the tiny changes needed to make
this apply on top of Lee's patch set.

Please do take a quick look to check I didn't mess it up!

> ---
>  drivers/iio/accel/st_accel_core.c |   19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 1458343..1bbdc8f 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -480,13 +480,13 @@ int st_accel_common_probe(struct iio_dev *indio_dev,
>  	if (err < 0)
>  		goto st_accel_common_probe_error;
>  
> -	if (adata->get_irq_data_ready(indio_dev) > 0) {
> -		err = st_accel_allocate_ring(indio_dev);
> -		if (err < 0)
> -			goto st_accel_common_probe_error;
> +	err = st_accel_allocate_ring(indio_dev);
> +	if (err < 0)
> +		goto st_accel_common_probe_error;
>  
> +	if (adata->get_irq_data_ready(indio_dev) > 0) {
>  		err = st_sensors_allocate_trigger(indio_dev,
> -						 ST_ACCEL_TRIGGER_OPS);
> +							ST_ACCEL_TRIGGER_OPS);
>  		if (err < 0)
>  			goto st_accel_probe_trigger_error;
>  	}
> @@ -501,8 +501,7 @@ st_accel_device_register_error:
>  	if (adata->get_irq_data_ready(indio_dev) > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
>  st_accel_probe_trigger_error:
> -	if (adata->get_irq_data_ready(indio_dev) > 0)
> -		st_accel_deallocate_ring(indio_dev);
> +	st_accel_deallocate_ring(indio_dev);
>  st_accel_common_probe_error:
>  	return err;
>  }
> @@ -513,10 +512,10 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (adata->get_irq_data_ready(indio_dev) > 0) {
> +	if (adata->get_irq_data_ready(indio_dev) > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
> -		st_accel_deallocate_ring(indio_dev);
> -	}
> +
> +	st_accel_deallocate_ring(indio_dev);
>  }
>  EXPORT_SYMBOL(st_accel_common_remove);
>  
> 
