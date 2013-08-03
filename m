Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39812 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab3HCUTG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 16:19:06 -0400
Message-ID: <51FD73D1.4020300@kernel.org>
Date: Sat, 03 Aug 2013 22:19:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio:mcp4725: Use devm_iio_device_alloc
References: <1375136311-8523-1-git-send-email-pmeerw@pmeerw.net> <1375136311-8523-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1375136311-8523-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/29/13 23:18, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/dac/mcp4725.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 18a78cd..1f4a48e 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -292,15 +292,12 @@ static int mcp4725_probe(struct i2c_client *client,
>  
>  	if (!platform_data || !platform_data->vref_mv) {
>  		dev_err(&client->dev, "invalid platform data");
> -		err = -EINVAL;
> -		goto exit;
> +		return -EINVAL;
>  	}
>  
> -	indio_dev = iio_device_alloc(sizeof(*data));
> -	if (indio_dev == NULL) {
> -		err = -ENOMEM;
> -		goto exit;
> -	}
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> @@ -317,7 +314,7 @@ static int mcp4725_probe(struct i2c_client *client,
>  	err = i2c_master_recv(client, inbuf, 3);
>  	if (err < 0) {
>  		dev_err(&client->dev, "failed to read DAC value");
> -		goto exit_free_device;
> +		return err;
>  	}
>  	pd = (inbuf[0] >> 1) & 0x3;
>  	data->powerdown = pd > 0 ? true : false;
> @@ -326,25 +323,16 @@ static int mcp4725_probe(struct i2c_client *client,
>  
>  	err = iio_device_register(indio_dev);
>  	if (err)
> -		goto exit_free_device;
> +		return err;
>  
>  	dev_info(&client->dev, "MCP4725 DAC registered\n");
>  
>  	return 0;
> -
> -exit_free_device:
> -	iio_device_free(indio_dev);
> -exit:
> -	return err;
>  }
>  
>  static int mcp4725_remove(struct i2c_client *client)
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
