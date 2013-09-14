Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43040 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168Ab3INQbE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 12:31:04 -0400
Message-ID: <52349D65.6000403@kernel.org>
Date: Sat, 14 Sep 2013 18:31:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 31/38] iio: accel-core: st: Clean up error handling in
 probe()
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org> <1378817379-8238-32-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-32-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/10/13 13:49, Lee Jones wrote:
> Reduce the amount of those unnecessary goto calls, as in most cases
> we can simply return immediately. We also only call for the IRQ number
> once and use that value throughout.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
...
> -	if (adata->get_irq_data_ready(indio_dev) > 0) {
> +	if (irq > 0) {
>  		err = st_accel_allocate_ring(indio_dev);
>  		if (err < 0)
> -			goto st_accel_common_probe_error;
> +			return err;
>  
>  		err = st_sensors_allocate_trigger(indio_dev,
>  						 ST_ACCEL_TRIGGER_OPS);
> @@ -492,18 +493,16 @@ int st_accel_common_probe(struct iio_dev *indio_dev,
>  	}
>  
>  	err = iio_device_register(indio_dev);
> -	if (err)
> +	if (err && irq > 0)
>  		goto st_accel_device_register_error;
This is the same structure I moaned about earlier. Again, put the if (irq > 0) in the error handling
not here.
>  
>  	return err;
>  
>  st_accel_device_register_error:
> -	if (adata->get_irq_data_ready(indio_dev) > 0)
> -		st_sensors_deallocate_trigger(indio_dev);
> +	st_sensors_deallocate_trigger(indio_dev);
>  st_accel_probe_trigger_error:
> -	if (adata->get_irq_data_ready(indio_dev) > 0)
> -		st_accel_deallocate_ring(indio_dev);
> -st_accel_common_probe_error:
> +	st_accel_deallocate_ring(indio_dev);
> +
>  	return err;
>  }
>  EXPORT_SYMBOL(st_accel_common_probe);
> 
