Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48530 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbcJJUd3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2016 16:33:29 -0400
Subject: Re: [PATCH v2 2/8] staging: iio: isl29018: fix poorly named function
To: Brian Masney <masneyb@onstation.org>
References: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
 <1476084002-29683-3-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <82c1efb7-57e6-a3ba-2f68-059e94f02daa@kernel.org>
Date: Mon, 10 Oct 2016 21:33:28 +0100
MIME-Version: 1.0
In-Reply-To: <1476084002-29683-3-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/16 08:19, Brian Masney wrote:
> isl29035_detect() did not do chip detection. Move functionality directly
> into isl29018_chip_init() to avoid naming confusion.
It kind of does do detection (or at least verification). Key point is that
it does other things as well.

I added the word 'just' to the description when applying.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/isl29018.c | 44 ++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 26bbbb8..130f222 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -529,30 +529,6 @@ static const struct attribute_group isl29023_group = {
>  	.attrs = isl29023_attributes,
>  };
>  
> -static int isl29035_detect(struct isl29018_chip *chip)
> -{
> -	int status;
> -	unsigned int id;
> -	struct device *dev = regmap_get_device(chip->regmap);
> -
> -	status = regmap_read(chip->regmap, ISL29035_REG_DEVICE_ID, &id);
> -	if (status < 0) {
> -		dev_err(dev,
> -			"Error reading ID register with error %d\n",
> -			status);
> -		return status;
> -	}
> -
> -	id = (id & ISL29035_DEVICE_ID_MASK) >> ISL29035_DEVICE_ID_SHIFT;
> -
> -	if (id != ISL29035_DEVICE_ID)
> -		return -ENODEV;
> -
> -	/* Clear brownout bit */
> -	return regmap_update_bits(chip->regmap, ISL29035_REG_DEVICE_ID,
> -				  ISL29035_BOUT_MASK, 0);
> -}
> -
>  enum {
>  	isl29018,
>  	isl29023,
> @@ -565,7 +541,25 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
>  	struct device *dev = regmap_get_device(chip->regmap);
>  
>  	if (chip->type == isl29035) {
> -		status = isl29035_detect(chip);
> +		unsigned int id;
> +
> +		status = regmap_read(chip->regmap, ISL29035_REG_DEVICE_ID, &id);
> +		if (status < 0) {
> +			dev_err(dev,
> +				"Error reading ID register with error %d\n",
> +				status);
> +			return status;
> +		}
> +
> +		id = (id & ISL29035_DEVICE_ID_MASK) >> ISL29035_DEVICE_ID_SHIFT;
> +
> +		if (id != ISL29035_DEVICE_ID)
> +			return -ENODEV;
> +
> +		/* Clear brownout bit */
> +		status = regmap_update_bits(chip->regmap,
> +					    ISL29035_REG_DEVICE_ID,
> +					    ISL29035_BOUT_MASK, 0);
>  		if (status < 0)
>  			return status;
>  	}
> 

