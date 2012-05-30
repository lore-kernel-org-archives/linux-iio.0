Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38426 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391Ab2E3SVa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 May 2012 14:21:30 -0400
Message-ID: <4FC67337.4020400@kernel.org>
Date: Wed, 30 May 2012 20:21:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Shubhrajyoti D <shubhrajyoti@ti.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: hmc5843: Make it behave better as modules
References: <1338217921-23174-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1338217921-23174-1-git-send-email-shubhrajyoti@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/28/2012 04:12 PM, Shubhrajyoti D wrote:
> The memory regions of the probe and remove are move
> to __devinit and __devexit respectively.
> 
Please send on to Greg KH.
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index c1fa09f..6c3e50f 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -665,7 +665,7 @@ static const struct iio_info hmc5843_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> -static int hmc5843_probe(struct i2c_client *client,
> +static int __devinit hmc5843_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct hmc5843_data *data;
> @@ -704,7 +704,7 @@ exit:
>  	return err;
>  }
>  
> -static int hmc5843_remove(struct i2c_client *client)
> +static int __devexit hmc5843_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
> @@ -755,7 +755,7 @@ static struct i2c_driver hmc5843_driver = {
>  	},
>  	.id_table	= hmc5843_id,
>  	.probe		= hmc5843_probe,
> -	.remove		= hmc5843_remove,
> +	.remove		= __devexit_p(hmc5843_remove),
>  	.detect		= hmc5843_detect,
>  	.address_list	= normal_i2c,
>  };

