Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59694 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757348AbcIXQiu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 12:38:50 -0400
Subject: Re: [PATCH v2] drivers: iio: light: Fix sparse warnings
To: Sandhya Bankar <bankarsandhya512@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <20160924161455.GA8895@localhost.localdomain>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ac0f5af8-dacf-89f7-1fde-f5c3a950be1c@kernel.org>
Date: Sat, 24 Sep 2016 17:38:49 +0100
MIME-Version: 1.0
In-Reply-To: <20160924161455.GA8895@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/09/16 17:14, Sandhya Bankar wrote:
> Fixing below warnings:
> 
> drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
> drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
> drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
> drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
> 
> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Plenty of time for any other comments though as I won't be pushing out
togreg publicly for at least a few days.

Thanks,

Jonathan
> ---
> Changes in v2:
> * Introducing local variable to do the initial read,
> then put it in regval via be16_to_cpu call
> 
>  drivers/iio/light/max44000.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index 6511b20..a144ca3 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -204,17 +204,18 @@ static int max44000_write_alspga(struct max44000_data *data, int val)
>  static int max44000_read_alsval(struct max44000_data *data)
>  {
>  	u16 regval;
> +	__be16 val;
>  	int alstim, ret;
>  
>  	ret = regmap_bulk_read(data->regmap, MAX44000_REG_ALS_DATA_HI,
> -			       &regval, sizeof(regval));
> +			       &val, sizeof(val));
>  	if (ret < 0)
>  		return ret;
>  	alstim = ret = max44000_read_alstim(data);
>  	if (ret < 0)
>  		return ret;
>  
> -	regval = be16_to_cpu(regval);
> +	regval = be16_to_cpu(val);
>  
>  	/*
>  	 * Overflow is explained on datasheet page 17.
> 

