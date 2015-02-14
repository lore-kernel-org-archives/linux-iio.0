Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33533 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbbBNLg5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Feb 2015 06:36:57 -0500
Message-ID: <54DF3358.5070709@kernel.org>
Date: Sat, 14 Feb 2015 11:36:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IIO: si7020: Allocate correct amount of memory in devm_iio_device_alloc
References: <1423814321-15606-1-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1423814321-15606-1-git-send-email-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/02/15 07:58, Andrey Smirnov wrote:
> Since only a pointer to struct i2c_client is stored in a private area
> of IIO device created by the driver there's no need to allocate
> sizeof(struct i2c_client) worth of storage.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Applied to the fixes-togreg branch of iio.git.
Marked for stable to make sure this confusion doesn't arise
again!

Jonathan
> ---
>  drivers/iio/humidity/si7020.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index 69e49f5..fa3b809 100644
> --- a/drivers/iio/humidity/si7020.c
> +++ b/drivers/iio/humidity/si7020.c
> @@ -126,7 +126,7 @@ static int si7020_probe(struct i2c_client *client,
>  	/* Wait the maximum power-up time after software reset. */
>  	msleep(15);
> 
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*client));
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> 
> --
> 2.1.0
> 

