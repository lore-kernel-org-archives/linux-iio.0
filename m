Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56B184;
	Sun,  5 Jul 2026 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783210798; cv=none; b=XtyfntiA5wHNy6tMSJy/19+V+KeiiXO/pch8CuCKjmNe7sGPvjqOi9JaJSe5s758wuKbyAAPnFgJAHhaml5whsmv5eKIpEqQeritYENCzTfRRMEUIgNcSO2LsU7NP/db0/CAF1F9VBthT0xfqPbQPMdr9CLBPvSeHfJWFRCP/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783210798; c=relaxed/simple;
	bh=uJeTkOZ/J+1RFLboJwPzJDq9n+hqap/Lf2KSWJq8uWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oj6LbbchR44FHJdOo4tI3a7quQKt8wQ/goq16f33TWplbFn4APrUq5Cu274NRpqzg8zkrQi8saY5Nb7Zhh7WCi1PlSsLM1Al3kgUiV1RAjy6quAZOfcT1IlRx+srufAqk6xEh1QZqD8OdIPioBO7dEGUwPHcRFJJecG+o2jeqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdwqxIJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdwqxIJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD491F000E9;
	Sun,  5 Jul 2026 00:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783210797;
	bh=rttHgm1iwoKCbWNl1QLE3msskxdHTigyFYUsbfIweBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VdwqxIJZvLsbT7aO17WFDAx4rWhf+cHavT9fnvJdbmR2HfL+xzYO1YDYHjLAjUZjf
	 u9URa/Hzupmel9MMqYhYgYQpo4WS4Xt1mUSiYTbKS/5O89yTDJB2S7CoQ6IUOTZ5Ck
	 6fUx+353Za9mOojF27NiPAxtIBarv0CTRoDFkpo/czu10hHy5IrEOA7mO/0X0NI3ZN
	 +Nlwdt+fUqlDM9H89SoEdNG3bmNapIOYi5KPaAM3GxZ82HQdysW4yYGTb8TAzaVE0o
	 gpf+9s+JEUDMeHaBO+TzG6fDFb7k47tUZcNpPynhbWEwocZFPeCXqaqBqaN7CGPPXy
	 4l5quc0HKpGuw==
Date: Sun, 5 Jul 2026 01:19:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biren Pandya <birenpandya@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linusw@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: kxsd9: fix runtime PM leaks and
 unchecked returns
Message-ID: <20260705011953.37c08bf2@jic23-huawei>
In-Reply-To: <20260703-kxsd9-v3-proper-v1-2-e9f08af25d7e@gmail.com>
References: <20260703-kxsd9-v3-proper-v1-0-e9f08af25d7e@gmail.com>
	<20260703-kxsd9-v3-proper-v1-2-e9f08af25d7e@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 Jul 2026 22:53:23 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> The driver fails to check the return value of pm_runtime_get_sync(),
> leading to potential silent failures. Additionally, error paths leak the
> runtime PM usage counter by returning without decrementing it.
> 
> Fix this by transitioning to pm_runtime_resume_and_get():
> 
> - In kxsd9_write_raw() and kxsd9_read_raw(), check the resume status and
>   guarantee pm_runtime_put_autosuspend() is called on all return paths.
>   Simultaneously, refactor the control flow to align with standard IIO
>   idioms (removing the dead -EINVAL initializer in favor of explicit
>   assignments).
> - In kxsd9_buffer_preenable(), propagate the resume error code.
> - In kxsd9_common_remove(), only decrement the usage counter on a
>   successful resume, while retaining the unconditional power-down for a
>   best-effort shutdown.
> 
> Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>
> ---
>  drivers/iio/accel/kxsd9.c | 42 ++++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 27adcdd312014..e9a0790e2eea2 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -139,18 +139,17 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
>  			   int val2,
>  			   long mask)
>  {
> -	int ret = -EINVAL;
>  	struct kxsd9_state *st = iio_priv(indio_dev);
> +	int ret;
>  
> -	pm_runtime_get_sync(st->dev);
> +	ret = pm_runtime_resume_and_get(st->dev);
> +	if (ret < 0)
> +		return ret;
>  
> -	if (mask == IIO_CHAN_INFO_SCALE) {
> -		/* Check no integer component */
> -		if (val)
> -			ret = -EINVAL;
> -		else
> -			ret = kxsd9_write_scale(indio_dev, val2);
> -	}
> +	if (mask == IIO_CHAN_INFO_SCALE && !val)
This is a mix of checking for two very different conditions. I'd rather
they were handled separately as before - that will require you to do
	if (mask == IIO_CHAN_INFO_SCALE) {
		if (val)
			ret = -EINVAL;
		else
			ret = kxsd9_write_scale(indio_dev, val2);
	} else {
		ret = -EINVAL;

Given how ugly this is we should probably switch this to the ACQUIRE stuff.
Maybe it would be better to just do that as part of this fix rather
than as a follow up.  PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and
PM_RUNTIME_ACQUIRE_ERR()

Then this can all be eaerly returns.
	if (mask != IIO_CHAN_INFO_SCALE)
		return -EINVAL;

	if (val)
		return -EINVAL;

	return kxsd9_write_scale();


	}
> +		ret = kxsd9_write_scale(indio_dev, val2);
> +	else
> +		ret = -EINVAL;
>  
>  	pm_runtime_put_autosuspend(st->dev);
>  
> @@ -161,20 +160,22 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  			  struct iio_chan_spec const *chan,
>  			  int *val, int *val2, long mask)
>  {
> -	int ret = -EINVAL;
>  	struct kxsd9_state *st = iio_priv(indio_dev);
>  	unsigned int regval;
>  	__be16 raw_val;
>  	u16 nval;
> +	int ret;
>  
> -	pm_runtime_get_sync(st->dev);
> +	ret = pm_runtime_resume_and_get(st->dev);
> +	if (ret < 0)
> +		return ret;

Similar to above, switching to the ACQUIRE magic will simplify this
flow a lot as well as dealing with resource leaks.

>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = regmap_bulk_read(st->map, chan->address, &raw_val,
>  				       sizeof(raw_val));
>  		if (ret)
> -			goto error_ret;
> +			break;
>  		nval = be16_to_cpu(raw_val);
>  		/* Only 12 bits are valid */
>  		nval >>= 4;
> @@ -191,18 +192,20 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  				  KXSD9_REG_CTRL_C,
>  				  &regval);
>  		if (ret < 0)
> -			goto error_ret;
> +			break;
>  		*val = 0;
>  		*val2 = kxsd9_micro_scales[regval & KXSD9_CTRL_C_FS_MASK];
>  		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
>  	}
>  
> -error_ret:
>  	pm_runtime_put_autosuspend(st->dev);
>  
>  	return ret;
> -};
> +}
>  
>  static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
>  {
> @@ -240,9 +243,7 @@ static int kxsd9_buffer_preenable(struct iio_dev *indio_dev)
>  {
>  	struct kxsd9_state *st = iio_priv(indio_dev);
>  
> -	pm_runtime_get_sync(st->dev);
> -
> -	return 0;
> +	return pm_runtime_resume_and_get(st->dev);
>  }
>  
>  static int kxsd9_buffer_postdisable(struct iio_dev *indio_dev)
> @@ -480,8 +481,9 @@ void kxsd9_common_remove(struct device *dev)
>  
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
> -	pm_runtime_get_sync(dev);
> -	pm_runtime_put_noidle(dev);
> +
> +	if (pm_runtime_resume_and_get(dev) >= 0)
> +		pm_runtime_put_noidle(dev);

I'd just let it underflow in this case.   Trying to cleanly 
handle errors in a driver unbind is rarely worth the effort
and despite what Sashiko thinks, runtime pm underflow isn't
a real problem - it's just messy and generally indicative
of something being less than ideal.

Jonathan

>  	pm_runtime_disable(dev);
>  	kxsd9_power_down(st);
>  }
> 

