Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34866 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbcIYIu4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 04:50:56 -0400
Subject: Re: [PATCH] drivers: iio: chemical: Fix sparse endianness warnings
 cast to restricted __be16
To: Sandhya Bankar <bankarsandhya512@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <20160924191621.GA18812@localhost.localdomain>
Cc: outreachy-kernel@googlegroups.com,
        Matt Ranostay <mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fac3a3d0-e3e9-b4c6-500d-e7320bf4750b@kernel.org>
Date: Sun, 25 Sep 2016 09:50:51 +0100
MIME-Version: 1.0
In-Reply-To: <20160924191621.GA18812@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/09/16 20:16, Sandhya Bankar wrote:
> Fix the following sparse endianness warnings:
> 
> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
> 
> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
Hi Sandhya,

Please also CC the author of a driver if possible.  Here it's a little
trickier as Matt's email address changed recently.

Patch is fine though so applied to the togreg branch of iio.git.
Initially pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/chemical/atlas-ph-sensor.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index 407f141..a3fbdb7 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -207,13 +207,14 @@ static int atlas_check_ec_calibration(struct atlas_data *data)
>  	struct device *dev = &data->client->dev;
>  	int ret;
>  	unsigned int val;
> +	__be16	rval;
>  
> -	ret = regmap_bulk_read(data->regmap, ATLAS_REG_EC_PROBE, &val, 2);
> +	ret = regmap_bulk_read(data->regmap, ATLAS_REG_EC_PROBE, &rval, 2);
>  	if (ret)
>  		return ret;
>  
> -	dev_info(dev, "probe set to K = %d.%.2d", be16_to_cpu(val) / 100,
> -						 be16_to_cpu(val) % 100);
> +	val = be16_to_cpu(rval);
> +	dev_info(dev, "probe set to K = %d.%.2d", val / 100, val % 100);
>  
>  	ret = regmap_read(data->regmap, ATLAS_REG_EC_CALIB_STATUS, &val);
>  	if (ret)
> 

