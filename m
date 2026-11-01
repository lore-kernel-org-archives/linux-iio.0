Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793491452;
	b=1KaPv18lemW92u3OMjwSfisjer9HwMNZ34YXNWNqM0pw2qiPgMCpn8XZNH1kpZ1Eo1Hl
	 1DRyktRfbLO7WajZRIfOWpqcyiUP29YU0/bIBZQWVnDMXMjv49T8DEhWn9R+WMQluk/zu
	 89BZFGlZ1aAA5WG5jNfqj+ipmb7w6eGWTOpH2G2gtB7njYYjDQVL8LzGjcuypNXQk3u/i
	 xT9hAdCYdBlCxCcgJorxLdvjZIb3kbe0f2xtVB9B5bgybq+astFwu5mln+EFwEKmxjJH6
	 Tfru3naksbCuD0FN92kvG9SGcjIKluluVUEo6OII6S2qQs3s2E7G/tpnCXl5K31I9aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793491452;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3DxqaAvoC2uAX8+s2/lJDh1AcKyFA/x2pgp6BwQODEM=;
	b=IgkPzEMKkwNukf4B41e8+ABlPyo6XWHOaXpaFfc8ZFbFuAsDe0HDHsBL3fwByuIcXr3a
	 /5n6JQT+8M/cZ6V0HiR8w0kO53JwhLPJXqqs4a6zmIqyflWhevvLrjWJOovaFLBIsUQg6
	 pPLwgaUpT8O+ftHbq415FIG0dEAOvS4yEdmM0uPWpQXJ465CDwzobDX5kI3r1hl1OwX8P
	 yrqjr+rixGj/dEoZKP/CDuitO582JqN8hUJ7BBc8juN9uI+2kP8aUgLoSdmygdTE7Y4k4
	 BDCQpOAWU5roEso/Qtbab1FN7buU48ZP/X56EQJuznZ2Jjl71U+N1MkxSKE7D6ko7gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5WjeD7g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B13606A31A;
	Sun,  1 Nov 2026 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5WjeD7g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835EE1F000C1;
	Sun,  1 Nov 2026 00:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793491451;
	bh=3DxqaAvoC2uAX8+s2/lJDh1AcKyFA/x2pgp6BwQODEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X5WjeD7g6cq6rexakEaQ3NCj8GKHfFdG5bqmIW4r44v1bOKE3HMNS1yDOSDIDwINa
	 Zn3Hr42/Um7idvrtdIgTOkG+s3rujcu+ggq3/XVYyhb1LoB1XbfSTX9r6p/YHsf6Vs
	 XuKd+YyvSAf2BitdH0lo9wq6NvFqX1cR5xIAcYIb0GUPXJkv0TmQlKREBGDpnK8olh
	 asglpLoeDLQwucbFZ+4qbJAk004iaIg2A01HFK+hGuQGyk4CzRRG28fTKZUJEMIRAo
	 yUF5/nkhu9iOzqniYsaQRyLnR6rVgsPniaHQ9+jBDrtvTmq3+xn28r89sRwas80a9y
	 yBRb6DAxN7J7g==
Date: Sun, 1 Nov 2026 00:04:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: laixiangwu <laixiangwu@cmss.chinamobile.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix runtime PM refcount leak in
 trigger enable path
Message-ID: <20261101000404.41fe1028@jic23-hlaptop>
In-Reply-To: <20261030084305.1660-1-laixiangwu@cmss.chinamobile.com>
References: <20261030084305.1660-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 16:43:05 +0800
laixiangwu <laixiangwu@cmss.chinamobile.com> wrote:

> mpu3050_drdy_trigger_set_state() calls pm_runtime_get_sync() when
> enabling the data ready trigger, but all five error returns in the
> enable path return directly without the matching
> pm_runtime_put_autosuspend(). The disable path, in contrast, drops
> the reference correctly.
> 
> As a result, a failed trigger enable leaves the runtime PM usage
> counter incremented and the sensor can never runtime suspend. It also
> leaves hw_irq_trigger set to true, claiming the hardware IRQ is in
> use when it is not.
> 
> Add an error label that drops the runtime PM reference and clears
> hw_irq_trigger, and check the return value of pm_runtime_get_sync()
> like the rest of the driver does.
> 
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
Hi,

> ---
>  drivers/iio/gyro/mpu3050-core.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 07c0f9011..9c6d5ba82 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -988,20 +988,24 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  		return 0;
>  	} else {
>  		/* Else we're enabling the trigger from this point */
> -		pm_runtime_get_sync(mpu3050->dev);
> +		ret = pm_runtime_get_sync(mpu3050->dev);

Read the documentation of this function.  It suggests what
I think is the appropriate change here. Use pm_runtime_resume_and_get()
not get_sync()

> +		if (ret < 0) {
> +			pm_runtime_put_noidle(mpu3050->dev);
> +			return ret;
> +		}
>  		mpu3050->hw_irq_trigger = true;
>  
>  		/* Disable all things in the FIFO */
>  		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
>  		if (ret)
> -			return ret;
> +			goto err_put_pm;
>  
>  		/* Reset and enable the FIFO */
>  		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
>  				      MPU3050_USR_CTRL_FIFO_EN |
>  				      MPU3050_USR_CTRL_FIFO_RST);
>  		if (ret)
> -			return ret;
> +			goto err_put_pm;
>  
>  		mpu3050->pending_fifo_footer = false;
>  
> @@ -1013,12 +1017,12 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  				   MPU3050_FIFO_EN_GYRO_ZOUT |
>  				   MPU3050_FIFO_EN_FOOTER);
>  		if (ret)
> -			return ret;
> +			goto err_put_pm;
>  
>  		/* Configure the sample engine */
>  		ret = mpu3050_start_sampling(mpu3050);
>  		if (ret)
> -			return ret;
> +			goto err_put_pm;
>  
>  		/* Clear IRQ flag */
>  		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> @@ -1037,10 +1041,16 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  
>  		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
>  		if (ret)
> -			return ret;
> +			goto err_put_pm;
>  	}
>  
>  	return 0;
> +
> +err_put_pm:

I'm not keen on an error block that only applies to one of the two legs
of the if /else in such a large function.  Better here would be to introduce
a pair of helpers for the if and else parts (enable / disable) and call
the appropriate one.  Do that in a precursor patch and then this will
become a more readable change.

> +	pm_runtime_put_autosuspend(mpu3050->dev);
> +	mpu3050->hw_irq_trigger = false;
> +
> +	return ret;
>  }
>  
>  static const struct iio_trigger_ops mpu3050_trigger_ops = {

