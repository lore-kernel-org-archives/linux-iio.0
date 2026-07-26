Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EA03793A5;
	Sun, 26 Jul 2026 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785095436; cv=none; b=k+ezZCBNl9kS0vTU4k8eyVRxei4m/eP9T7Rkux2c4a4vtduQqbcQgUOrlLWquN/RkYE2eXLyVOZX7KjuaJTBDIQqyNx12qOOrTkKUEPq+gJEEz6OrrRiAAR/8wrSmrmPJVvxUnlcKTDtXJOa3i203tJRLLC+DqnuJXCulLDsG4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785095436; c=relaxed/simple;
	bh=qqqLP6mcck1TJAfeTdOYs7Fl0wukgct+utcOrhrXKZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfi4A1OPmhcAVhLMB2yXP6m/+SWPjUYpE3nOXFMk44FN6YwpQeEpX09JA5Yb2h1behZkQPojqp+3D4gNl1FX7+GHys/xGZF/qJEQgupqbheAzl+wXoCm7O+nzotA639NYI3iVG3RHhhf3gSJGRWxonk5bOkDz7gR1IWDpkx8YUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCtop4Vt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCtop4Vt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67471F000E9;
	Sun, 26 Jul 2026 19:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785095435;
	bh=CLopO89B8ZpHTR2+aNYOFR55eleY8de8BKw9FZhqcFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GCtop4VtI7VFZobsU+bL/SaE+eX+v7KBedTRCu6Lz0VgIN7NopROfg6zmdYidFqE5
	 j1HB6aFJS9U+FBvHyRv+EFP1PSXZ0mq+E3TFB65l+yNoN5+PvHJIOG6QsG4Gwxse17
	 Uy619tolGmoYpvK45w+fTdyc/VNfHNOVj6ka4c/nixsS9IKuQ9b43S3Al63QGU0gKe
	 6JLelSWxzxMVeZmUSXNeweppsTL9d4kOEpPeKhyuKHolDpJX9TRayOz6Z9WKgKp9KX
	 f8//+5WuQ0VF33LTGQO7n6SVWwJEZfIju1dIlANl4zfbNsZTtb4mC7igkAdSWBBkT4
	 a4nYAikCFDhiQ==
Date: Sun, 26 Jul 2026 20:50:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kr494167@gmail.com
Cc: azpijr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: apds9999: register standby action after
 enabling device
Message-ID: <20260726205030.4ca33bb8@jic23-huawei>
In-Reply-To: <20260724025802.13499-1-kr494167@gmail.com>
References: <20260724025802.13499-1-kr494167@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 08:28:02 +0530
kr494167@gmail.com wrote:

> From: Surendra Singh Chouhan <kr494167@gmail.com>
> 
> apds9999_init() called devm_add_action_or_reset() at the start
> of the function, before register configuration and before enabling the
> device via APDS9999_MAIN_CTRL_LS_EN.
> 
> If register initialization failed during apds9999_init() (e.g. SMBus
> write failures on LS_MEAS_RATE or LS_GAIN), devm_add_action_or_reset()
> immediately triggered apds9999_standby(), writing to the control
> register on a device that failed initialization and was never enabled.
> 
> Fix this by registering devm_add_action_or_reset() only after
> APDS9999_MAIN_CTRL_LS_EN is successfully written to the control
> register.
> 
> Fixes: 5f9363e52300 ("iio: light: add support for APDS9999 sensor")

Given the side effect of this is write that is harmless, I don't
think the fixes tag is justified. 

Having said that this is a logical improvement.

I would like Jose to have taken a look though before I consider picking
it up so let us leave it on list for now.

Thanks,

Jonathan

> Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
> ---
>  drivers/iio/light/apds9999.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9999.c b/drivers/iio/light/apds9999.c
> index 43fa9992c9c2..62620c4a2fbc 100644
> --- a/drivers/iio/light/apds9999.c
> +++ b/drivers/iio/light/apds9999.c
> @@ -100,10 +100,6 @@ static int apds9999_init(struct apds9999_data *data)
>  	u8 regval;
>  	int ret;
>  
> -	ret = devm_add_action_or_reset(dev, apds9999_standby, client);
> -	if (ret)
> -		return ret;
> -
>  	guard(mutex)(&data->lock);
>  
>  	regval = FIELD_PREP(APDS9999_LS_RES_MASK, APDS9999_RES_18BIT) |
> @@ -121,8 +117,12 @@ static int apds9999_init(struct apds9999_data *data)
>  		return ret;
>  	data->als_gain_idx = APDS9999_GAIN_3X;
>  
> -	return i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
> -					 APDS9999_MAIN_CTRL_LS_EN);
> +	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
> +					APDS9999_MAIN_CTRL_LS_EN);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, apds9999_standby, client);
>  }
>  
>  static int apds9999_read_channel(struct apds9999_data *data, u8 reg,

