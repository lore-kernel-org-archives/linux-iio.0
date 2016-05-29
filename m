Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34121 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbcE2SxL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 14:53:11 -0400
Subject: Re: [PATCH 2/2] iio: light: bh1780: assign a static name
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1464162027-24612-1-git-send-email-linus.walleij@linaro.org>
 <1464162027-24612-2-git-send-email-linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3c1a7937-3c90-9f26-c9fe-e2ffad140e06@kernel.org>
Date: Sun, 29 May 2016 19:53:10 +0100
MIME-Version: 1.0
In-Reply-To: <1464162027-24612-2-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/05/16 08:40, Linus Walleij wrote:
> Using the struct i2c_device->id field for naming the light sensor
> is a bad idea: when booting from the pure device tree this is NULL
> and that causes the device not to have the "name" property in
> sysfs and that in turn confuses the "lsiio" command to stop listing
> devices.
> 
> So instead of using the device .id, use the hard string "bh1780",
> which works just fine.
> 
> Fixes: 1f0477f18306 ("iio: light: new driver for the ROHM BH1780")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the fixes-togreg-post-rc1 and marked for stable.
Thanks,

Jonathan
> ---
>  drivers/iio/light/bh1780.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
> index 5fd432df2c8f..b54dcba05a82 100644
> --- a/drivers/iio/light/bh1780.c
> +++ b/drivers/iio/light/bh1780.c
> @@ -187,7 +187,7 @@ static int bh1780_probe(struct i2c_client *client,
>  
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->info = &bh1780_info;
> -	indio_dev->name = id->name;
> +	indio_dev->name = "bh1780";
>  	indio_dev->channels = bh1780_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(bh1780_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> 

