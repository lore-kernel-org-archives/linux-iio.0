Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6042FFDE3;
	Sat, 14 Feb 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093392; cv=none; b=Tv0YA5ICguQqqlDpwQQwiJxk2K+U6bpnoci70zglTpg1nwWRblwxW/BaNL1yYzuDhdXKmfAYdV+qEvqUVS4dgv49w/9OOFN4LPFRRDacuUFGc+1LVhKNemO3hXVRlaaZyGeo7iOqbR9JFIfEJ4O80DdZm4dy6HUlgt8DzyXnFBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093392; c=relaxed/simple;
	bh=PcsekXIafi+CaNO3Zi+VGqmAciXAsQfdIWHcJJnheXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEWZfv8D8XsvfEIAwBPeVhYrNUr80P5FhMACS28j/hPOz6p/dHiDCxxj9+skI/xZqF0g8s7fiGz+nb6l8ka1uha/x1/Y1hIHMG4f5JFykp3vQwzAOVgDgNvnI50DlId7GYw/7zu1ctEfsjdDVytPPA1rELSUsSPQfZQPtFdIJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDRPY1yn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDRPY1yn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06C6C16AAE;
	Sat, 14 Feb 2026 18:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771093391;
	bh=PcsekXIafi+CaNO3Zi+VGqmAciXAsQfdIWHcJJnheXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lDRPY1ynObFUtx5u2/elRtw0rq1dLjENcMzaxu3Xxn8i5+FuzQcc0BW7eRXoPA7IX
	 ModJ5HnheL66UR29i3tD0igrOSeeXvWByW4dc8BaAwzfskXIxfuhBnIvpR5/pQoMUl
	 PrpZoVUJ9Ve8Fu8JhOmS5pJpxHwFqvRkrMB6cKi43TY5FnwB4WemPXzHYU//onIj2y
	 kfRHQD73IWpdaxOYypXo0HbyZMJJSf1gRltPASmLEa9rKATQsVfc2ktIjxYkzw6gY2
	 4UzDZdcs6yEeqL0MQ4V9ppsw3+57d4IgAAecDbotltGAPuvTXe0xyviQ9SF1awGLL5
	 bUShARl64KROA==
Date: Sat, 14 Feb 2026 18:23:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: magnetometer: si7210: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20260214182303.74466e0f@jic23-huawei>
In-Reply-To: <20260210175137.44178-2-antoniu.miclaus@analog.com>
References: <20260210175137.44178-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 19:51:28 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Simplify probe by using devm_regulator_get_enable_read_voltage() to
> get, enable and read the regulator voltage in a single call, caching
> the value at probe time.

I think it would be good to shout a bit more about this in theory
being a functional change and the fact that in practice it is exceedingly
rare for anyone to change voltages on running parts.

Jonathan

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/magnetometer/si7210.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/si7210.c b/drivers/iio/magnetometer/si7210.c
> index 27e3feba7a0f..0a7a610fbe24 100644
> --- a/drivers/iio/magnetometer/si7210.c
> +++ b/drivers/iio/magnetometer/si7210.c
> @@ -128,13 +128,13 @@ static const struct regmap_config si7210_regmap_conf = {
>  struct si7210_data {
>  	struct regmap *regmap;
>  	struct i2c_client *client;
> -	struct regulator *vdd;
>  	struct mutex fetch_lock; /* lock for a single measurement fetch */
>  	s8 temp_offset;
>  	s8 temp_gain;
>  	s8 scale_20_a[A_REGS_COUNT];
>  	s8 scale_200_a[A_REGS_COUNT];
>  	u8 curr_scale;
> +	unsigned int vdd_uv;
>  };
>  
>  static const struct iio_chan_spec si7210_channels[] = {
> @@ -221,12 +221,8 @@ static int si7210_read_raw(struct iio_dev *indio_dev,
>  		temp *= (1 + (data->temp_gain / 2048));
>  		temp += (int)(MICRO / 16) * data->temp_offset;
>  
> -		ret = regulator_get_voltage(data->vdd);
> -		if (ret < 0)
> -			return ret;
> -
>  		/* temp -= 0.222 * VDD */
> -		temp -= 222 * div_s64(ret, MILLI);
> +		temp -= 222 * div_s64(data->vdd_uv, MILLI);
>  
>  		*val = div_s64(temp, MILLI);
>  
> @@ -396,14 +392,11 @@ static int si7210_probe(struct i2c_client *client)
>  		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
>  				     "failed to register regmap\n");
>  
> -	data->vdd = devm_regulator_get(&client->dev, "vdd");
> -	if (IS_ERR(data->vdd))
> -		return dev_err_probe(&client->dev, PTR_ERR(data->vdd),
> -				     "failed to get VDD regulator\n");
> -
> -	ret = regulator_enable(data->vdd);
> -	if (ret)
> -		return ret;
> +	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vdd");
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to get vdd regulator\n");
> +	data->vdd_uv = ret;
>  
>  	indio_dev->name = dev_name(&client->dev);
>  	indio_dev->modes = INDIO_DIRECT_MODE;

