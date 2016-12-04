Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42807 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934482AbdAHJnO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:43:14 -0500
Subject: Re: [PATCH 02/19] staging: iio: isl29028: remove enable flag from
 isl29028_enable_proximity()
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
 <1480817983-32359-3-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c578b88b-9b8a-b3a3-ae05-bfd6f7522871@kernel.org>
Date: Sun, 4 Dec 2016 11:16:04 +0000
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
On second thoughts (stupid email is hiding somewhere to be sent when I have wifi
so can't reply to it) perhaps this is a coarse way of only turning proximity on if
the LED is present?  Not sure...
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

