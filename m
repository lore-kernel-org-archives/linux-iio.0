Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37586 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088AbcAIQfC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jan 2016 11:35:02 -0500
Subject: Re: [PATCH] iio: dac: mcp4725: set iio name property in sysfs
To: Yong Li <sdliyong@gmail.com>, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, akinobu.mita@gmail.com
References: <1452042583-10580-1-git-send-email-sdliyong@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569136B4.306@kernel.org>
Date: Sat, 9 Jan 2016 16:35:00 +0000
MIME-Version: 1.0
In-Reply-To: <1452042583-10580-1-git-send-email-sdliyong@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/01/16 01:09, Yong Li wrote:
> Without this change, the name entity for mcp4725 is missing in
> /sys/bus/iio/devices/iio\:device*/name
> 
> With this change, name is reported correctly
> 
> Signed-off-by: Yong Li <sdliyong@gmail.com>
Hi Yong,

A fix like this gets applied to the iio fixes-togreg branch
and this one required a bit of pushing to get it to apply.

I've marked it for stable as well.

Thanks!

Jonathan
> ---
>  drivers/iio/dac/mcp4725.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index fb4b336..cca935c 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -346,6 +346,7 @@ static int mcp4725_probe(struct i2c_client *client,
>  	data->client = client;
>  
>  	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
>  	indio_dev->info = &mcp4725_info;
>  	indio_dev->channels = &mcp472x_channel[id->driver_data];
>  	indio_dev->num_channels = 1;
> 

