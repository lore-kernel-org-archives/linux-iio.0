Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58277 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab3IUNuJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 09:50:09 -0400
Message-ID: <523DB235.2070406@kernel.org>
Date: Sat, 21 Sep 2013 15:50:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org, lee.jones@linaro.org
Subject: Re: [PATCH 2/4] iio:gyro: Register buffer also without specific trigger
References: <1379494822-9985-1-git-send-email-denis.ciocca@st.com> <1379494822-9985-3-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1379494822-9985-3-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 10:00, Denis CIOCCA wrote:
> This patch fix buffer registration that allows to use generic IIO trigger.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Forward ported and applied to the togreg branch of iio.git

> ---
>  drivers/iio/gyro/st_gyro_core.c |   19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index e13c2b0..8a45d43 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -329,13 +329,13 @@ int st_gyro_common_probe(struct iio_dev *indio_dev,
>  	if (err < 0)
>  		goto st_gyro_common_probe_error;
>  
> -	if (gdata->get_irq_data_ready(indio_dev) > 0) {
> -		err = st_gyro_allocate_ring(indio_dev);
> -		if (err < 0)
> -			goto st_gyro_common_probe_error;
> +	err = st_gyro_allocate_ring(indio_dev);
> +	if (err < 0)
> +		goto st_gyro_common_probe_error;
>  
> +	if (gdata->get_irq_data_ready(indio_dev) > 0) {
>  		err = st_sensors_allocate_trigger(indio_dev,
> -						  ST_GYRO_TRIGGER_OPS);
> +							ST_GYRO_TRIGGER_OPS);
>  		if (err < 0)
>  			goto st_gyro_probe_trigger_error;
>  	}
> @@ -350,8 +350,7 @@ st_gyro_device_register_error:
>  	if (gdata->get_irq_data_ready(indio_dev) > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
>  st_gyro_probe_trigger_error:
> -	if (gdata->get_irq_data_ready(indio_dev) > 0)
> -		st_gyro_deallocate_ring(indio_dev);
> +	st_gyro_deallocate_ring(indio_dev);
>  st_gyro_common_probe_error:
>  	return err;
>  }
> @@ -362,10 +361,10 @@ void st_gyro_common_remove(struct iio_dev *indio_dev)
>  	struct st_sensor_data *gdata = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (gdata->get_irq_data_ready(indio_dev) > 0) {
> +	if (gdata->get_irq_data_ready(indio_dev) > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
> -		st_gyro_deallocate_ring(indio_dev);
> -	}
> +
> +	st_gyro_deallocate_ring(indio_dev);
>  }
>  EXPORT_SYMBOL(st_gyro_common_remove);
>  
> 
