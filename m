Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533019;
	b=tq7R+nBRnlgUhiNDS9TV0cVML5QhG3aHnEQyu0bx6xXhuF7NkLPwfT54Z80iWmDFJ+Cl
	 jW/X2VoRSKo2VxEWwpE2UzP3ZIbQIr6fgSzodjDI3Ekbc2XD+ZnpxoiMHUHJGQX5qxW9o
	 Zr3BlodPaqyTQwlVRlQ0J239jG+FT/vN9EsoFsb/iMDPrzv+707pk6qHGjMUblKfOFDrn
	 NDsM2KxPxgkP+Ubp0pZd9tLKVFDCtXH8vLYCT82mEY3XdrWJ2HAd1/R3zDg3418tJi2G5
	 6RPWVuZBu4BWeToWPni+Jz47vms4apFaqj5GPP7ynXQO6Os35B+x8HiEPY4RMg7fj8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533019;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=k1Mts7cCBH+Sxlevciq38wr7yODppUz/Qexc6piMtgs=;
	b=R/kkn/UCPy82oTIeZPmWQSHGQ3Pzb52/Hlfla3GQIOgJ9/sNng930+lhJttdfRT0ciYt
	 mkXWFlG+7lnF5aQNvD7SLsYDuyEx8QixciByaMHbll0hz+lfWF+N+ygrz2VYlG/dM5VBh
	 YanyPfPUYHoQbj9MCw4/+lIV5eFo6whHCcKnygzYRIiHvZ9HMHqgDVEYFb6/R2qTMpmlS
	 sxm3h4fJpHmORR95eP8SImvxX1kR3iC1KY8ME0P9fZT4Yi25abdJcSvhGTwZufU/Dny1l
	 hNlPop7roFZdiL7ndmweXKqPiIbPe9nxX98qikPvsDlVNIoADuispujI8j1TpFzi1Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGLwZSob;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF71606A321;
	Fri, 13 Nov 2026 01:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGLwZSob
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D831F000C4;
	Fri, 13 Nov 2026 01:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794533018;
	bh=k1Mts7cCBH+Sxlevciq38wr7yODppUz/Qexc6piMtgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VGLwZSob3GFWot4zgQ1z2wJ3AUgQ4trf1uYlC0rF1GlHdvyyQGcco0h3e60HasMXb
	 oOj+4BSwrC8OnG3zLnrMQZtZAKDtIyap+vfDqYYUh5tmbZZzeCB42z0xbWtOTv+hf+
	 6X9ScGsgbSksgSpgmlx81sFTPq0Ygo34sbt7mA42lZQtbJdC1Tm7Ynd4UdL9ttkNrB
	 WY72kQcvMkHR1tDMcZ1qEbw8j0khktCx/4/H/JIAsKp6QVdV6iFLN4TKJ0wr3umaZB
	 K9e4brDiymXDhbF/YZDOQ5K4wFHBS5BOLT3gFzvJ9StQgJHMdIF+Ofmx6HBKncRANW
	 Eu6WsraabcmrA==
Date: Fri, 13 Nov 2026 01:23:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: potentiostat: lmp91000: Handle configuration write
 errors
Message-ID: <20261113012332.1be06bf9@jic23-hlaptop>
In-Reply-To: <20261112071747.154626-1-zhujun2@cmss.chinamobile.com>
References: <20261112071747.154626-1-zhujun2@cmss.chinamobile.com>
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

On Thu, 12 Nov 2026 15:17:47 +0800
Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:

> lmp91000_read_config() ignores errors when unlocking and programming
> the TIA and reference registers. Probe can then succeed even though
> the hardware configuration does not match the parameters used to
> interpret measurements.
> 
> Check the configuration writes and return the first error. After a
> successful unlock, attempt to restore write protection even if a
> configuration write fails, and report a relock failure as well.
> 
> Fixes: 67e17300dc1d ("iio: potentiostat: add LMP91000 support")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Minor comment on the approach used inline.

Thanks,

Jonathan

> ---
>  drivers/iio/potentiostat/lmp91000.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index 00cb3fea97ca..4a29fe627af7 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -205,7 +205,7 @@ static int lmp91000_read_config(struct lmp91000_data *data)
>  {
>  	struct device *dev = data->dev;
>  	unsigned int reg, val;
> -	int i, ret;
> +	int i, ret, lock_ret;
>  
>  	ret = device_property_read_u32(dev, "ti,tia-gain-ohm", &val);
>  	if (ret) {
> @@ -250,13 +250,19 @@ static int lmp91000_read_config(struct lmp91000_data *data)
>  		return ret;
>  	}
>  
> -	regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
> -	regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
> -	regmap_write(data->regmap, LMP91000_REG_REFCN,
> -		     LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);
> -	regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
> +	ret = regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
> +	if (ret)
> +		return ret;
>  
> -	return 0;
> +	ret = regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
> +	if (!ret)
> +		ret = regmap_write(data->regmap, LMP91000_REG_REFCN,
> +				   LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);
> +
> +	/* Restore write protection even if programming the registers failed. */
> +	lock_ret = regmap_write(data->regmap, LMP91000_REG_LOCK, 1);

I'm never a fan of flows where we pick between ret values. tHey make for very messy
code.  It is easier to read with one line effectively duplicated.


	ret = regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
	if (ret)
		return ret;

	ret = regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
	if (ret)
		goto unlock;
	
	ret = regmap_write(data->regmap, LMP91000_REG_REFCN,
			   LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);
	if (ret)
		goto unlock;

	return regmap_write(data->regmap, LMP91000_REG_LOCK, 1);

unlock:
	regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
	
	return ret;
	
> +
> +	return ret ? ret : lock_ret;
>  }
>  
>  static int lmp91000_buffer_cb(const void *val, void *private)

