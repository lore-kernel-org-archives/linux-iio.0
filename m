Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58296 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab3IUNu1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 09:50:27 -0400
Message-ID: <523DB247.4050509@kernel.org>
Date: Sat, 21 Sep 2013 15:50:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org, lee.jones@linaro.org
Subject: Re: [PATCH 3/4] iio:magn: Register buffer also without specific trigger
References: <1379494822-9985-1-git-send-email-denis.ciocca@st.com> <1379494822-9985-4-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1379494822-9985-4-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 10:00, Denis CIOCCA wrote:
> This patch fix buffer registration that allows to use generic IIO trigger.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Forward ported and applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/st_magn_core.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index e8d2849..0de49f8 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -372,10 +372,11 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
>  	if (err < 0)
>  		goto st_magn_common_probe_error;
>  
> +	err = st_magn_allocate_ring(indio_dev);
> +	if (err < 0)
> +		goto st_magn_common_probe_error;
> +
>  	if (mdata->get_irq_data_ready(indio_dev) > 0) {
> -		err = st_magn_allocate_ring(indio_dev);
> -		if (err < 0)
> -			goto st_magn_common_probe_error;
>  		err = st_sensors_allocate_trigger(indio_dev, NULL);
>  		if (err < 0)
>  			goto st_magn_probe_trigger_error;
> @@ -391,8 +392,7 @@ st_magn_device_register_error:
>  	if (mdata->get_irq_data_ready(indio_dev) > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
>  st_magn_probe_trigger_error:
> -	if (mdata->get_irq_data_ready(indio_dev) > 0)
> -		st_magn_deallocate_ring(indio_dev);
> +	st_magn_deallocate_ring(indio_dev);
>  st_magn_common_probe_error:
>  	return err;
>  }
> @@ -403,10 +403,10 @@ void st_magn_common_remove(struct iio_dev *indio_dev)
>  	struct st_sensor_data *mdata = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (mdata->get_irq_data_ready(indio_dev) > 0) {
> +	if (mdata->get_irq_data_ready(indio_dev) > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
> -		st_magn_deallocate_ring(indio_dev);
> -	}
> +
> +	st_magn_deallocate_ring(indio_dev);
>  }
>  EXPORT_SYMBOL(st_magn_common_remove);
>  
> 
