Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34746 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdAUNGd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 08:06:33 -0500
Subject: Re: [PATCH] iio: bmi160: use variable names for sizeof() operator
To: Alison Schofield <amsfield22@gmail.com>
References: <20170116050102.GA6310@d830.WORKGROUP>
Cc: daniel.baluta@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <888a0b08-59cc-7f0a-86db-abdfd603a968@kernel.org>
Date: Sat, 21 Jan 2017 13:06:31 +0000
MIME-Version: 1.0
In-Reply-To: <20170116050102.GA6310@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/01/17 05:01, Alison Schofield wrote:
> Replace the types with the actual variable names when using the
> sizeof() operator.  This is kernel preferred style as it protects
> against future changes to variable type.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Sensible change from an obviously correct stand point.
Future changes to the type are a non starter here given this is a feature of
the hardware!  I've dropped that bit of the commit message and added
something about readability.

Jonathan
> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 5355507..1e7c88b 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -338,9 +338,9 @@ static int bmi160_get_data(struct bmi160_data *data, int chan_type,
>  	__le16 sample;
>  	enum bmi160_sensor_type t = bmi160_to_sensor(chan_type);
>  
> -	reg = bmi160_regs[t].data + (axis - IIO_MOD_X) * sizeof(__le16);
> +	reg = bmi160_regs[t].data + (axis - IIO_MOD_X) * sizeof(sample);
>  
> -	ret = regmap_bulk_read(data->regmap, reg, &sample, sizeof(__le16));
> +	ret = regmap_bulk_read(data->regmap, reg, &sample, sizeof(sample));
>  	if (ret < 0)
>  		return ret;
>  
> @@ -405,8 +405,8 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>  
>  	for_each_set_bit(i, indio_dev->active_scan_mask,
>  			 indio_dev->masklength) {
> -		ret = regmap_bulk_read(data->regmap, base + i * sizeof(__le16),
> -				       &sample, sizeof(__le16));
> +		ret = regmap_bulk_read(data->regmap, base + i * sizeof(sample),
> +				       &sample, sizeof(sample));
>  		if (ret < 0)
>  			goto done;
>  		buf[j++] = sample;
> 

