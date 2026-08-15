Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290617BA2;
	Sat, 15 Aug 2026 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786831246; cv=none; b=ppODYO7+bBC5VaFk+aaYtRmW5+ZoTbuB599+0TY8GF0Jz7zLJJlivQj6SOO7nYznoAJcHMMcrdOPauIqd8SG5e7BF6Nelr3uDbcYJpO1y0bJMwZ3CkOQXG74lYiO8QiTfKYNWMtppGV96oFGjWMIy1XC35N3olN+2miMcPqFZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786831246; c=relaxed/simple;
	bh=NZbRv2EmzHX/YejxhirIZDgbMuePqVOYR9yERr4w/LI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R40cFmg9F8qvh1YVgJjLJ7LNSr0P+nDrY9v/keRfTsf9Nsf4Z63a5OLi+Bv68x0XKnHvELSsDvAkEMPmm0+ocYQagai1AUKIY6YpGRlbGP/egr5p3pryeCMFPti90VMwZHjEGMas2o71jAZ/6TBTOZB1iGbFs5EOFCbiqdxo3IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gflaW6mt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gflaW6mt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27F01F00A3A;
	Sat, 15 Aug 2026 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786831244;
	bh=y9PgeDPA5GdMV/XDwLeutR+FzcoZDp2G0uJ0kF+aQzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gflaW6mt8BNOeYJ8nX+33wEp49KTdcqnHFthZvtho0bNZvIX6NdAVJqaE9Fx6qsys
	 /IZQQCmewiOkSuANn6ee4vxgmseMpZdqt289P7QHzg7PHgBanSc/85mm594Ub85/kB
	 GWrX/6d5vuxSgN2WHfnrO/zr5wyBoscKfQQ2zNqHe8DM9t7OvhtRo9/U5i2ohxzJn2
	 1wLYVF8FbHp2/qhS3tmNVQsdNBTfoMn+ETZlc30ARCX5B+V8T7iqnn8QocUmq6Hv14
	 Ymy24y5NeEaVQYnFwZbrYF5BSv9nzuBBgGt5liqhr5UFxnibilJHUA04mKLp3mJg4o
	 MolsRKgT1OJkA==
Date: Sat, 15 Aug 2026 23:00:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: linux-iio@vger.kernel.org, joshua.crofts1@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-kernel@vger.kernel.org, Giorgi Tchankvetadze
 <giorgi@tchankvetadze.com>
Subject: Re: [PATCH v3] iio: light: veml3328: reshape scale array for
 readability
Message-ID: <20260815230040.7e6696f5@jic23-huawei>
In-Reply-To: <20260805083532.92585-3-giorgitchankvetadze1997@gmail.com>
References: <20260805083532.92585-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 12:35:34 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> 
> The veml3328_scale_vals array is declared as a flattened [4][8] array,
> so accessing a scale value requires calculating the offset of its
> (val, val2) pair using gain_inx * 2.
> 
> Reshape the array as [4][4][2], with separate dimensions for integration
> time, gain and the scale value pair. This removes the manual stride
> calculation and makes the relationship between the indexes and values
> explicit.
> 
> Add named integration-time indexes and use designated initializers for
> veml3328_it_times and veml3328_scale_vals so both tables use the same
> index definitions.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Applied to the testing branch of iio.git

Thanks,

Jonathan

> ---
> Changes in v3:
> - Add named integration-time indexes as suggested by Jonathan Cameron.
> - Use designated initializers for veml3328_it_times and
>   veml3328_scale_vals to keep both tables indexed consistently.
> 
> Changes in v2:
> - Reshape veml3328_scale_vals as [4][4][2], as suggested by
>   David Lechner.
> - Update read and write paths to access the scale value pair directly.
> 
> drivers/iio/light/veml3328.c | 53 ++++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
> index 7ff1753925c4..df36c48204be 100644
> --- a/drivers/iio/light/veml3328.c
> +++ b/drivers/iio/light/veml3328.c
> @@ -32,6 +32,11 @@
>  #define VEML3328_REG_DATA_B		0x07
>  #define VEML3328_REG_DATA_IR		0x08
>  
> +#define VEML3328_CONT_IT_50MSECS	0
> +#define VEML3328_CONT_IT_100MSECS	1
> +#define VEML3328_CONT_IT_200MSECS	2
> +#define VEML3328_CONT_IT_400MSECS	3
> +
>  #define VEML3328_CONF_IT_MASK		GENMASK(5, 4)
>  #define VEML3328_CONF_GAIN_MASK		GENMASK(11, 10)
>  
> @@ -89,21 +94,40 @@ static const struct iio_chan_spec veml3328_channels[] = {
>   * Precomputed scale values (micro units).
>   * Formula for calculation: 0.384 * (50000 / IT_us) * (1 / Gain)
>   * Gain indexes: 0 (x0.5), 1 (x1), 2 (x2), 3 (x4)
> - * IT indexes: 0 (50ms), 1 (100ms), 2 (200ms), 3 (400ms)
>   */
> -static const int veml3328_scale_vals[4][8] = {
> -	{ 0, 768000, 0, 384000, 0, 192000, 0, 96000 },
> -	{ 0, 384000, 0, 192000, 0, 96000,  0, 48000 },
> -	{ 0, 192000, 0, 96000,  0, 48000,  0, 24000 },
> -	{ 0, 96000,  0, 48000,  0, 24000,  0, 12000 },
> +static const int veml3328_scale_vals[4][4][2] = {
> +	[VEML3328_CONT_IT_50MSECS] = {
> +		{ 0, 768000 },
> +		{ 0, 384000 },
> +		{ 0, 192000 },
> +		{ 0, 96000 },
> +	},
> +	[VEML3328_CONT_IT_100MSECS] = {
> +		{ 0, 384000 },
> +		{ 0, 192000 },
> +		{ 0, 96000 },
> +		{ 0, 48000 },
> +	},
> +	[VEML3328_CONT_IT_200MSECS] = {
> +		{ 0, 192000 },
> +		{ 0, 96000 },
> +		{ 0, 48000 },
> +		{ 0, 24000 },
> +	},
> +	[VEML3328_CONT_IT_400MSECS] = {
> +		{ 0, 96000 },
> +		{ 0, 48000 },
> +		{ 0, 24000 },
> +		{ 0, 12000 },
> +	},
>  };
>  
>  /* integration times in microseconds */
>  static const int veml3328_it_times[][2] = {
> -	{ 0, 50 * USEC_PER_MSEC },
> -	{ 0, 100 * USEC_PER_MSEC },
> -	{ 0, 200 * USEC_PER_MSEC },
> -	{ 0, 400 * USEC_PER_MSEC },
> +	[VEML3328_CONT_IT_50MSECS] = { 0, 50 * USEC_PER_MSEC },
> +	[VEML3328_CONT_IT_100MSECS] = { 0, 100 * USEC_PER_MSEC },
> +	[VEML3328_CONT_IT_200MSECS] = { 0, 200 * USEC_PER_MSEC },
> +	[VEML3328_CONT_IT_400MSECS] = { 0, 400 * USEC_PER_MSEC },
>  };
>  
>  static int veml3328_power_down(struct veml3328_data *data)
> @@ -184,9 +208,8 @@ static int veml3328_read_raw(struct iio_dev *indio_dev,
>  		if (it_inx >= ARRAY_SIZE(veml3328_it_times) || gain_inx >= 4)
>  			return -EINVAL;
>  
> -		/* Stride by 2 through the flattened array to match (val, val2) */
> -		*val = veml3328_scale_vals[it_inx][gain_inx * 2];
> -		*val2 = veml3328_scale_vals[it_inx][gain_inx * 2 + 1];
> +		*val = veml3328_scale_vals[it_inx][gain_inx][0];
> +		*val2 = veml3328_scale_vals[it_inx][gain_inx][1];
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
>  
> @@ -282,8 +305,8 @@ static int veml3328_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  
>  		for (i = 0; i < 4; i++) {
> -			if (val == veml3328_scale_vals[it_inx][i * 2] &&
> -			    val2 == veml3328_scale_vals[it_inx][i * 2 + 1])
> +			if (val == veml3328_scale_vals[it_inx][i][0] &&
> +			    val2 == veml3328_scale_vals[it_inx][i][1])
>  				break;
>  		}
>  

