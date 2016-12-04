Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42900 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934277AbdAHJsS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:48:18 -0500
Subject: Re: [PATCH 02/19] staging: iio: isl29028: remove enable flag from
 isl29028_enable_proximity()
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
 <1480817983-32359-3-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2703a991-126c-b4bf-8a2a-2b430bc02f3d@kernel.org>
Date: Sun, 4 Dec 2016 11:13:02 +0000
MIME-Version: 1.0
In-Reply-To: <1480817983-32359-3-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/12/16 02:19, Brian Masney wrote:
> isl29028_enable_proximity() has a boolean argument named enable. This
> function is only called once and the enable flag is set to true in that
> call. This patch removes the enable parameter from that function.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
The first thing that strikes me about this, is why do we have an enable only function?

I think the intention was probably that we also disable the proximity sensing after the
reading was done...  Ideally we'd do this a little more cleverly, perhaps using runtime
pm so that if someone is requesting a stream of proximity measurements, we won't end up
powering up and down each time.

It's a little 'interesting' as we would want to power this element down even if we do
have a continuous stream of reads on the ALS.  As such we may need to roll our own
equivalent of runtime pm.

In the first instance, I'd just put a disable after the reading is taken.  This will
make a bit of a mockery of the faster sampling frequencies but there we are!


Jonathan
> ---
>  drivers/staging/iio/light/isl29028.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 4e35d00..c8e234d 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -93,15 +93,13 @@ static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
>  				  sel << ISL29028_CONF_PROX_SLP_SH);
>  }
>  
> -static int isl29028_enable_proximity(struct isl29028_chip *chip, bool enable)
> +static int isl29028_enable_proximity(struct isl29028_chip *chip)
>  {
>  	int ret;
> -	int val = 0;
>  
> -	if (enable)
> -		val = ISL29028_CONF_PROX_EN;
>  	ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
> -				 ISL29028_CONF_PROX_EN_MASK, val);
> +				 ISL29028_CONF_PROX_EN_MASK,
> +				 ISL29028_CONF_PROX_EN);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -215,7 +213,7 @@ static int isl29028_proxim_get(struct isl29028_chip *chip, int *prox_data)
>  	int ret;
>  
>  	if (!chip->enable_prox) {
> -		ret = isl29028_enable_proximity(chip, true);
> +		ret = isl29028_enable_proximity(chip);
>  		if (ret < 0)
>  			return ret;
>  		chip->enable_prox = true;
> 

