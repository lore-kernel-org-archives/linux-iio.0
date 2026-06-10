Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E83191C8;
	Wed, 10 Jun 2026 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105559; cv=none; b=uL7CKhPogkjU5qz49hZOFZ4P43Rn++PZYk2KbIPJdZf/rEgWxC6+Fe2EmoPvix9M/592VXjuvDOrouIs/vXib1A8FesQX1puh3f7CPJQZH2rdmZwrB+lcRZrU7hns548WAb2yjJ+cGND80jVeZBhtzKx5iWJpnrQVdUX4wREehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105559; c=relaxed/simple;
	bh=U/XhO5JM8x+rjwnsud02zH/tVfKZWUQLrplEP8EHfaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkggcPNzaGaJ04umf0BHXPOW87tdI5+mVFAOVzPgjbJThWGrxBHrtECJthGEdg3MkFs9+LphwpqnjlgRy+T1M5CITU5b/FI2/lU/qiKVVvkvYyqDUsEgd4bXnKHirfjIM8aZWQPBzomMt+i5TC3gmOndlfyqGbix1Hs8f/RZMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY5FZhxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY5FZhxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5D51F00893;
	Wed, 10 Jun 2026 15:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105558;
	bh=zGWAOjvUhZA6rxPGTdmrBORNmUdL9GLH5oxpXT19z1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kY5FZhxgWP06ckUS5O6fg0rdXcQAplr9H3Trx0DlJjdRfpmIOyCHrvBNup4bSgj0q
	 B3R4hc0cA6JmZEK5iIYOUz7dGKgsmhUBQgqcVXf4geiPe9xJDMyWVAu7RPtJYHYXBM
	 iDSnwSnDW52282nQJ6PgKhKmGGoC+GImieHUaQ7FOunCh6BAq7UwuspFJg5OQZLuQF
	 Qd4uuhfH9U1BxsACvC7Y9NdvxnH8JEtw3felJriuGv+jGrri2iOO4WPPi7OGsBLTbo
	 VTMZrGU+Z22EQDSXN+IvIOqJWAXe7wx8Yq8fP/wlJDQLuaCJ9T0lnJqvQGRrRmRpw3
	 S2gt0vyzFyBWQ==
Date: Wed, 10 Jun 2026 16:32:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: magnetometer: bmc150: use FIELD_PREP and
 FIELD_GET helpers
Message-ID: <20260610163230.51d5866c@jic23-huawei>
In-Reply-To: <20260610135831.91739-3-dennylin0707@gmail.com>
References: <20260610135831.91739-1-dennylin0707@gmail.com>
	<20260610135831.91739-3-dennylin0707@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 13:58:31 +0000
Hungyu Lin <dennylin0707@gmail.com> wrote:

> Replace open-coded bitfield operations with FIELD_PREP() and
> FIELD_GET() helpers where appropriate.
> 
> Also simplify bmc150_magn_set_odr() by returning directly from
> the matching table entry.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Andy mentioned in previous patch - slow down!  More than one version a day
is very rarely appropriate.  That creates a lot of noise on the list
and means that you aren't gathering up multiple bits of feedback before
posting a new verison.

Anything I apply for IIO is now 7.3 material so this isn't going upstream
for about 3 months anyway so take your time!

The alignment is not the preferred amount for pretty much all cases.
Rather than go to v7, applied but with this fix up:
Note that it is on the testing branch of iio.git which will get rebased
on rc1 once available in about 3 weeks time.

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index ee8092d4006c..32dff9cdd0f7 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -248,13 +248,13 @@ static int bmc150_magn_set_power_mode(struct bmc150_magn_data *data,
                                          BMC150_MAGN_REG_OPMODE_ODR,
                                          BMC150_MAGN_MASK_OPMODE,
                                          FIELD_PREP(BMC150_MAGN_MASK_OPMODE,
-                                                 BMC150_MAGN_MODE_SLEEP));
+                                                    BMC150_MAGN_MODE_SLEEP));
        case BMC150_MAGN_POWER_MODE_NORMAL:
                return regmap_update_bits(data->regmap,
                                          BMC150_MAGN_REG_OPMODE_ODR,
                                          BMC150_MAGN_MASK_OPMODE,
                                          FIELD_PREP(BMC150_MAGN_MASK_OPMODE,
-                                                 BMC150_MAGN_MODE_NORMAL));
+                                                    BMC150_MAGN_MODE_NORMAL));
        }
 
        return -EINVAL;
@@ -312,10 +312,10 @@ static int bmc150_magn_set_odr(struct bmc150_magn_data *data, int val)
                        continue;
 
                return regmap_update_bits(data->regmap,
-                                        BMC150_MAGN_REG_OPMODE_ODR,
-                                        BMC150_MAGN_MASK_ODR,
-                                        FIELD_PREP(BMC150_MAGN_MASK_ODR,
-                                                bmc150_magn_samp_freq_table[i].reg_val));
+                                         BMC150_MAGN_REG_OPMODE_ODR,
+                                         BMC150_MAGN_MASK_ODR,
+                                         FIELD_PREP(BMC150_MAGN_MASK_ODR,
+                                                    bmc150_magn_samp_freq_table[i].reg_val));
        }
 
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 33 ++++++++++++--------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index f6639d7fab04..ee8092d4006c 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -9,6 +9,7 @@
>   * (C) Copyright 2011~2014 Bosch Sensortec GmbH All Rights Reserved
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> @@ -246,14 +247,14 @@ static int bmc150_magn_set_power_mode(struct bmc150_magn_data *data,
>  		return regmap_update_bits(data->regmap,
>  					  BMC150_MAGN_REG_OPMODE_ODR,
>  					  BMC150_MAGN_MASK_OPMODE,
> -					  BMC150_MAGN_MODE_SLEEP <<
> -					  BMC150_MAGN_SHIFT_OPMODE);
> +					  FIELD_PREP(BMC150_MAGN_MASK_OPMODE,
> +						  BMC150_MAGN_MODE_SLEEP));
Should be aligned as:
					  FIELD_PREP(BMC150_MAGN_MASK_OPMODE,
						     BMC150_MAGN_MODE_SLEEP));

>  	case BMC150_MAGN_POWER_MODE_NORMAL:
>  		return regmap_update_bits(data->regmap,
>  					  BMC150_MAGN_REG_OPMODE_ODR,
>  					  BMC150_MAGN_MASK_OPMODE,
> -					  BMC150_MAGN_MODE_NORMAL <<
> -					  BMC150_MAGN_SHIFT_OPMODE);
> +					  FIELD_PREP(BMC150_MAGN_MASK_OPMODE,
> +						  BMC150_MAGN_MODE_NORMAL));
Same here.

>  	}
>  
>  	return -EINVAL;
> @@ -291,7 +292,7 @@ static int bmc150_magn_get_odr(struct bmc150_magn_data *data, int *val)
>  	ret = regmap_read(data->regmap, BMC150_MAGN_REG_OPMODE_ODR, &reg_val);
>  	if (ret < 0)
>  		return ret;
> -	odr_val = (reg_val & BMC150_MAGN_MASK_ODR) >> BMC150_MAGN_SHIFT_ODR;
> +	odr_val = FIELD_GET(BMC150_MAGN_MASK_ODR, reg_val);
>  
>  	for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++)
>  		if (bmc150_magn_samp_freq_table[i].reg_val == odr_val) {
> @@ -304,21 +305,17 @@ static int bmc150_magn_get_odr(struct bmc150_magn_data *data, int *val)
>  
>  static int bmc150_magn_set_odr(struct bmc150_magn_data *data, int val)
>  {
> -	int ret;
>  	u8 i;
>  
>  	for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++) {
> -		if (bmc150_magn_samp_freq_table[i].freq == val) {
> -			ret = regmap_update_bits(data->regmap,
> -						 BMC150_MAGN_REG_OPMODE_ODR,
> -						 BMC150_MAGN_MASK_ODR,
> -						 bmc150_magn_samp_freq_table[i].
> -						 reg_val <<
> -						 BMC150_MAGN_SHIFT_ODR);
> -			if (ret < 0)
> -				return ret;
> -			return 0;
> -		}
> +		if (bmc150_magn_samp_freq_table[i].freq != val)
> +			continue;
> +
> +		return regmap_update_bits(data->regmap,
> +					 BMC150_MAGN_REG_OPMODE_ODR,
> +					 BMC150_MAGN_MASK_ODR,
> +					 FIELD_PREP(BMC150_MAGN_MASK_ODR,
> +						 bmc150_magn_samp_freq_table[i].reg_val));
and here should be
		return regmap_update_bits(data->regmap,
					  BMC150_MAGN_REG_OPMODE_ODR,
					  BMC150_MAGN_MASK_ODR,
					  FIELD_PREP(BMC150_MAGN_MASK_ODR,
						     bmc150_magn_samp_freq_table[i].reg_val));

>  	}
>  
>  	return -EINVAL;
> @@ -801,7 +798,7 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  
>  	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
>  				 BMC150_MAGN_MASK_DRDY_EN,
> -				 state << BMC150_MAGN_SHIFT_DRDY_EN);
> +				 FIELD_PREP(BMC150_MAGN_MASK_DRDY_EN, state));
>  	if (ret < 0)
>  		return ret;
>  

