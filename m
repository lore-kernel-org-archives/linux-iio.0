Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37021 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbcBNPCP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2016 10:02:15 -0500
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: switch regmap cache
To: Matt Ranostay <mranostay@gmail.com>
References: <1455412842-750-1-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56C096F3.9070908@kernel.org>
Date: Sun, 14 Feb 2016 15:02:11 +0000
MIME-Version: 1.0
In-Reply-To: <1455412842-750-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/02/16 01:20, Matt Ranostay wrote:
> switch from using REGCACHE_FLAT to REGCACHE_RBTREE so initial hw values
> are read from device. This also allows some volatile ranges to be
> dropped.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
I'm lost here. Why should changing the storage of the register cache result
in different behaviour other than in efficiency of access to cached values?

Jonathan
> ---
>  drivers/iio/chemical/atlas-ph-sensor.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index 06cd49c..71c8e02 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -65,8 +65,6 @@ struct atlas_data {
>  
>  static const struct regmap_range atlas_volatile_ranges[] = {
>  	regmap_reg_range(ATLAS_REG_INT_CONTROL, ATLAS_REG_INT_CONTROL),
> -	regmap_reg_range(ATLAS_REG_CALIB_STATUS, ATLAS_REG_CALIB_STATUS),
> -	regmap_reg_range(ATLAS_REG_TEMP_DATA, ATLAS_REG_TEMP_DATA + 4),
>  	regmap_reg_range(ATLAS_REG_PH_DATA, ATLAS_REG_PH_DATA + 4),
>  };
>  
> @@ -83,7 +81,7 @@ static const struct regmap_config atlas_regmap_config = {
>  
>  	.volatile_table = &atlas_volatile_table,
>  	.max_register = ATLAS_REG_PH_DATA + 4,
> -	.cache_type = REGCACHE_FLAT,
> +	.cache_type = REGCACHE_RBTREE,
>  };
>  
>  static const struct iio_chan_spec atlas_channels[] = {
> 

