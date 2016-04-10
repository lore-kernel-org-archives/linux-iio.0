Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44177 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbcDJOS1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 10:18:27 -0400
Subject: Re: [PATCH] iio: ak8975: fix maybe-uninitialized warning
To: Richard Leitner <dev@g0hl1n.net>
References: <20160405150348.30fea0a9@g0hl1n.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A60B1.5060706@kernel.org>
Date: Sun, 10 Apr 2016 15:18:25 +0100
MIME-Version: 1.0
In-Reply-To: <20160405150348.30fea0a9@g0hl1n.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/04/16 14:03, Richard Leitner wrote:
> If i2c_device_id *id is NULL and acpi_match_device returns NULL too,
> then chipset may be unitialized when accessing &ak_def_array[chipset] in
> ak8975_probe. Therefore initialize chipset to AK_MAX_TYPE, which will
> return an error when not changed.
> 
> This patch fixes the following maybe-uninitialized warning:
> 
> drivers/iio/magnetometer/ak8975.c: In function ‘ak8975_probe’:
> drivers/iio/magnetometer/ak8975.c:788:14: warning: ‘chipset’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>   data->def = &ak_def_array[chipset];
> 
> Signed-off-by: Richard Leitner <dev@g0hl1n.net>
Applied to the fixes-togreg branch of iio.git and marked fo stable.
> ---
>  drivers/iio/magnetometer/ak8975.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c
> b/drivers/iio/magnetometer/ak8975.c index 9c5c9ef..82783dc 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -732,7 +732,7 @@ static int ak8975_probe(struct i2c_client *client,
>  	int eoc_gpio;
>  	int err;
>  	const char *name = NULL;
> -	enum asahi_compass_chipset chipset;
> +	enum asahi_compass_chipset chipset = AK_MAX_TYPE;
>  
>  	/* Grab and set up the supplied GPIO. */
>  	if (client->dev.platform_data)
> 

