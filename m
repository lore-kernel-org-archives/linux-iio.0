Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35741 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab3JXMxG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 08:53:06 -0400
Message-ID: <5269266E.7080905@kernel.org>
Date: Thu, 24 Oct 2013 14:53:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 9/9] iio: light: vcnl4000: Remove redundant code
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org> <1382615615-20153-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-9-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/13 12:53, Sachin Kamat wrote:
> The if check is redundant as the value obtained from
> iio_device_register() is already in the required format.
> Hence return the function directly.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks for the series.
> ---
>  drivers/iio/light/vcnl4000.c |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 2bb3042..ecb3341 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -179,11 +179,7 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	indio_dev->name = VCNL4000_DRV_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	return iio_device_register(indio_dev);
>  }
>  
>  static int vcnl4000_remove(struct i2c_client *client)
> 
