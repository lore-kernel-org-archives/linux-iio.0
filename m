Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59046 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab3KWRa2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:30:28 -0500
Message-ID: <5290F489.9060800@kernel.org>
Date: Sat, 23 Nov 2013 18:31:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 29/33] staging: iio: tsl2x7x_core: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-30-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-30-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
The power off should be after the unregister given that until the unregister, the userspace
interface is there, but won't work.

Hence, here you have highlighted a bug...
> ---
>  drivers/staging/iio/light/tsl2x7x_core.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index 1880502..cec7595 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -1935,7 +1935,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  	/* Make sure the chip is on */
>  	tsl2x7x_chip_on(indio_dev);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&clientp->dev, indio_dev);
>  	if (ret) {
>  		dev_err(&clientp->dev,
>  			"%s: iio registration failed\n", __func__);
> @@ -1989,8 +1989,6 @@ static int tsl2x7x_remove(struct i2c_client *client)
>  
>  	tsl2x7x_chip_off(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
> -
>  	return 0;
>  }
>  
> 
