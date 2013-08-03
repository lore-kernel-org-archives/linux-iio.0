Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39800 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab3HCUSM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 16:18:12 -0400
Message-ID: <51FD739C.8020200@kernel.org>
Date: Sat, 03 Aug 2013 22:18:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio:vcnl4000: Use devm_iio_device_alloc
References: <1375136311-8523-1-git-send-email-pmeerw@pmeerw.net> <1375136311-8523-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1375136311-8523-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/29/13 23:18, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/light/vcnl4000.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 1014943..2bb3042 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -157,7 +157,7 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> -	indio_dev = iio_device_alloc(sizeof(*data));
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -167,7 +167,7 @@ static int vcnl4000_probe(struct i2c_client *client,
>  
>  	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_PROD_REV);
>  	if (ret < 0)
> -		goto error_free_dev;
> +		return ret;
>  
>  	dev_info(&client->dev, "VCNL4000 Ambient light/proximity sensor, Prod %02x, Rev: %02x\n",
>  		ret >> 4, ret & 0xf);
> @@ -181,22 +181,14 @@ static int vcnl4000_probe(struct i2c_client *client,
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
> -		goto error_free_dev;
> +		return ret;
>  
>  	return 0;
> -
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -	return ret;
>  }
>  
>  static int vcnl4000_remove(struct i2c_client *client)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_device_free(indio_dev);
> -
> +	iio_device_unregister(i2c_get_clientdata(client));
>  	return 0;
>  }
>  
> 
