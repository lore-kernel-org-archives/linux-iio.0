Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51152 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbcHUK7I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 06:59:08 -0400
Subject: Re: [PATCH v2 2/3] iio: chemical: atlas-ph-sensor: switch to
 REGCACHE_NONE regmap tree
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1471638971-23039-1-git-send-email-mranostay@gmail.com>
 <1471638971-23039-3-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <48db9db9-e356-5294-0f91-3b1213e3fe55@kernel.org>
Date: Sun, 21 Aug 2016 11:58:55 +0100
MIME-Version: 1.0
In-Reply-To: <1471638971-23039-3-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/08/16 21:36, Matt Ranostay wrote:
> Since there are overlapping volatile regions between parts, and only
> register that isn't volatile is the temperature compensation provided
> from userspace.
This does make me wonder if a shared regmap across the different parts
makes sense. (assuming I've understood the issue).

However, not many registers, not a quick device so who really cares ;)

Applied.

Thanks,

Jonathan
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/iio/chemical/atlas-ph-sensor.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index 696875413d10..c0a0ebbbd54a 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -84,26 +84,10 @@ struct atlas_data {
>  	__be32 buffer[6]; /* 96-bit data + 32-bit pad + 64-bit timestamp */
>  };
>  
> -static const struct regmap_range atlas_volatile_ranges[] = {
> -	regmap_reg_range(ATLAS_REG_INT_CONTROL, ATLAS_REG_INT_CONTROL),
> -	regmap_reg_range(ATLAS_REG_PH_DATA, ATLAS_REG_PH_DATA + 4),
> -	regmap_reg_range(ATLAS_REG_EC_DATA, ATLAS_REG_PSS_DATA + 4),
> -};
> -
> -static const struct regmap_access_table atlas_volatile_table = {
> -	.yes_ranges	= atlas_volatile_ranges,
> -	.n_yes_ranges	= ARRAY_SIZE(atlas_volatile_ranges),
> -};
> -
>  static const struct regmap_config atlas_regmap_config = {
>  	.name = ATLAS_REGMAP_NAME,
> -
>  	.reg_bits = 8,
>  	.val_bits = 8,
> -
> -	.volatile_table = &atlas_volatile_table,
> -	.max_register = ATLAS_REG_PSS_DATA + 4,
> -	.cache_type = REGCACHE_RBTREE,
>  };
>  
>  static const struct iio_chan_spec atlas_ph_channels[] = {
> 

