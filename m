Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35699 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182Ab3JXMvt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 08:51:49 -0400
Message-ID: <52692621.301@kernel.org>
Date: Thu, 24 Oct 2013 14:52:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 7/9] iio: dac: max517: Remove redundant variable
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org> <1382615615-20153-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-7-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/13 12:53, Sachin Kamat wrote:
> Remove an inconsequential print message and return directly
> thereby eliminating an intermediate variable.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/dac/max517.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index d26be14..6e19035 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -160,7 +160,6 @@ static int max517_probe(struct i2c_client *client,
>  	struct max517_data *data;
>  	struct iio_dev *indio_dev;
>  	struct max517_platform_data *platform_data = client->dev.platform_data;
> -	int err;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -192,13 +191,7 @@ static int max517_probe(struct i2c_client *client,
>  		data->vref_mv[1] = platform_data->vref_mv[1];
>  	}
>  
> -	err = iio_device_register(indio_dev);
> -	if (err)
> -		return err;
> -
> -	dev_info(&client->dev, "DAC registered\n");
> -
> -	return 0;
> +	return iio_device_register(indio_dev);
>  }
>  
>  static int max517_remove(struct i2c_client *client)
> 
