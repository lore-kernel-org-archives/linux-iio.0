Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39780 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab3HCURP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 16:17:15 -0400
Message-ID: <51FD7360.50606@kernel.org>
Date: Sat, 03 Aug 2013 22:17:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio:adjd_s311: Use devm_iio_device_alloc
References: <1375136311-8523-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1375136311-8523-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/29/13 23:18, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/light/adjd_s311.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
> index 5f4749e..55b9e18 100644
> --- a/drivers/iio/light/adjd_s311.c
> +++ b/drivers/iio/light/adjd_s311.c
> @@ -293,11 +293,10 @@ static int adjd_s311_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	int err;
>  
> -	indio_dev = iio_device_alloc(sizeof(*data));
> -	if (indio_dev == NULL) {
> -		err = -ENOMEM;
> -		goto exit;
> -	}
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> @@ -312,7 +311,7 @@ static int adjd_s311_probe(struct i2c_client *client,
>  	err = iio_triggered_buffer_setup(indio_dev, NULL,
>  		adjd_s311_trigger_handler, NULL);
>  	if (err < 0)
> -		goto exit_free_device;
> +		return err;
>  
>  	err = iio_device_register(indio_dev);
>  	if (err)
> @@ -324,9 +323,6 @@ static int adjd_s311_probe(struct i2c_client *client,
>  
>  exit_unreg_buffer:
>  	iio_triggered_buffer_cleanup(indio_dev);
> -exit_free_device:
> -	iio_device_free(indio_dev);
> -exit:
>  	return err;
>  }
>  
> @@ -338,7 +334,6 @@ static int adjd_s311_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	kfree(data->buffer);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
