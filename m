Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42855 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933381AbcDYTdy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2016 15:33:54 -0400
Subject: Re: [PATCH] iio: tmp006: Set correct iio name
To: Yong Li <sdliyong@gmail.com>, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, k.kozlowski@samsung.com, mranostay@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1461296584-11918-1-git-send-email-sdliyong@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <43150fbd-37ac-2d51-dd87-f41670417b96@kernel.org>
Date: Mon, 25 Apr 2016 20:33:51 +0100
MIME-Version: 1.0
In-Reply-To: <1461296584-11918-1-git-send-email-sdliyong@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/04/16 04:43, Yong Li wrote:
> When load the driver using the below command:
> echo tmp006 0x40 > /sys/bus/i2c/devices/i2c-0/new_device
> 
> In sysfs, the i2c name is tmp006, however the iio name is 0-0040,
> they are inconsistent. With this patch,
> the iio name will be the same as the i2c device name
> 
> Signed-off-by: Yong Li <sdliyong@gmail.com>
Peter, this looks right to me, but could you take a quick look as I guess
there might be a reason you did this in an unusual way originally?

Jonathan
> ---
>  drivers/iio/temperature/tmp006.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index 18c9b43..17c8413 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -221,7 +221,7 @@ static int tmp006_probe(struct i2c_client *client,
>  	data->client = client;
>  
>  	indio_dev->dev.parent = &client->dev;
> -	indio_dev->name = dev_name(&client->dev);
> +	indio_dev->name = id->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &tmp006_info;
>  
> 

