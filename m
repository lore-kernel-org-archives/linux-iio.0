Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31C1A5B8C;
	Sun,  2 Aug 2026 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785633917; cv=none; b=f9nKPw6Vg82Y5c4bHgyMKGv1k8CeKdKviF+CdgD3lJV+mbQn49RAtPTX6p7XssLvdu4pFkCanRGf6V4mZRKBI/DWtQYCQYfEght45GV0ameHQVpnh5+jErzXRXgO7MPmENLdsQwRP1Ozpyh5ctBdvv7Vxl78B5MrQIxeYkcdacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785633917; c=relaxed/simple;
	bh=QmDMA5nbNYG0hlv5Yo0hAQ4tTqCnfFP22Pc7ZN0mk9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UO1VTeTvkXRe3gC03TxE7TKtsokuOybLL9S1G7uzHfYAGk7Sol2DGUYevvYvSwaRxlZVYhfLU9Pf/ECFAaazZPCSXGHkW9bG/Asin8uuFcBNyGQceI5K7MXJLEA5tB2T2jLnXN2jh5tsB+Ce3MQTr5MQ/u6o7Nwh0kDHMe0b8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5zyQOD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5zyQOD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE78C1F00AC4;
	Sun,  2 Aug 2026 01:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785633916;
	bh=kwTGn+/QtvOFidqJ9dhPUG4S++xFkaTnPQZI5VDyrUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G5zyQOD3F0u2oY5jI+j/s3WMi6X25Ry5ldtN9umu7tK5DN6D7nCFvxLHqZ9yvq3oR
	 EYMmrAYO5MDxUVDtcgB8P1U9kHXQCjxRfu7cG0E3/BD9z22Ak1Lzz5P60yVW9V9eIV
	 AUyhpVNBGNpGhq1XIz39CVyfVrx7Bg6UVdTQ3T5A1K6p7vhhBvgGApuds9EGvZb/Wh
	 KkbXrVSjrnGCb1wX12vJNtz7dgB7eSDXdeZKuflkaqujKbb4m05OXH6kuLyVpGAfaq
	 HLrBPeDV8K/cBY4orMyFc0JEWAFcd3VTENW9+gY+xZuZSWCdfzpUjnA+VaPCer4cmD
	 FHd7hJSTiHMaA==
Date: Sun, 2 Aug 2026 02:25:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: joshua.crofts1@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Subject: Re: [PATCH v2] iio: light: veml3328: reshape scale array for
 readability
Message-ID: <20260802022511.42b9e769@jic23-huawei>
In-Reply-To: <20260730082932.79484-3-giorgitchankvetadze1997@gmail.com>
References: <20260730082932.79484-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 12:29:34 +0400
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
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>

This is good but a further suggestion below.

> ---
> Changes in v2:
> - Reshape veml3328_scale_vals as [4][4][2], as suggested by
>   David Lechner.
> - Update read and write paths to access the scale value pair directly.
> 
> Link to v1:
> https://lore.kernel.org/r/20260727112726.211344-1-giorgitchankvetadze1997@gmail.com
> 
>  drivers/iio/light/veml3328.c | 39 +++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
> index 7ff1753925c4..ef0bb82e54e0 100644
> --- a/drivers/iio/light/veml3328.c
> +++ b/drivers/iio/light/veml3328.c
> @@ -91,11 +91,31 @@ static const struct iio_chan_spec veml3328_channels[] = {
>   * Gain indexes: 0 (x0.5), 1 (x1), 2 (x2), 3 (x4)
>   * IT indexes: 0 (50ms), 1 (100ms), 2 (200ms), 3 (400ms)
>   */
> -static const int veml3328_scale_vals[4][8] = {
> -	{ 0, 768000, 0, 384000, 0, 192000, 0, 96000 },
> -	{ 0, 384000, 0, 192000, 0, 96000,  0, 48000 },
> -	{ 0, 192000, 0, 96000,  0, 48000,  0, 24000 },
> -	{ 0, 96000,  0, 48000,  0, 24000,  0, 12000 },
> +static const int veml3328_scale_vals[4][4][2] = {
> +	{ /* 50 ms */
Given both this and veml3328_it_times are indexing on the same thing
I wonder if it is worth

#define VEML3328_CONT_IT_50MSECS	0
#define VEML3328_CONT_IT_100MSECS	1
#define VEML3328_CONT_IT_200MSECS	2
#define VEML3328_CONT_IT_400MSECS	3

Then here use
	[VEML3328_CONT_IT_50MSECS] = {

and similar for the veml3328_it_times array.
That way we keep them in sync with code rather than comments.

Jonathan

	
> +		{ 0, 768000 },
> +		{ 0, 384000 },
> +		{ 0, 192000 },
> +		{ 0, 96000 },
> +	},
> +	{ /* 100 ms */
> +		{ 0, 384000 },
> +		{ 0, 192000 },
> +		{ 0, 96000 },
> +		{ 0, 48000 },
> +	},
> +	{ /* 200 ms */
> +		{ 0, 192000 },
> +		{ 0, 96000 },
> +		{ 0, 48000 },
> +		{ 0, 24000 },
> +	},
> +	{ /* 400 ms */
> +		{ 0, 96000 },
> +		{ 0, 48000 },
> +		{ 0, 24000 },
> +		{ 0, 12000 },
> +	},
>  };
>  
>  /* integration times in microseconds */
> @@ -184,9 +204,8 @@ static int veml3328_read_raw(struct iio_dev *indio_dev,
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
> @@ -282,8 +301,8 @@ static int veml3328_write_raw(struct iio_dev *indio_dev,
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

