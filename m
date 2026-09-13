Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062A374721;
	Sun, 13 Sep 2026 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789334940; cv=none; b=AfTZR18vyfoyqfIApSjZ82wIYVc0qxgh4b7ppw53ejFTyzpLbot8cZWjLbWy0udG3aSsbD1P8Ikntj0RaCU5gU7y32ccJZPhY1w20DNSJR61OaeR95OoR2ECIq4iUe4M8XZhKyc6jNC5kPm9WNVwtIU/9i67Fim/wyTBKbOm4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789334940; c=relaxed/simple;
	bh=hdl0HPgZWp5OFcEjPYJMMYkM6HAAD3lRbSgzmiZteKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mExH/e7OERgL8z5n0bl83OPXSReE+0HcStG96MmNgpWbeihbQVVvIywQh1pSrYD4G0ZOdGgzYEPF+RfqPDkFmFZJ+BLYYAJiJMYI+ailCabVh83L2CQFfZ3ShRcSrzXGA4kWpQgkNydbtsn6bVntIi98UEhmJwYt1SdzARe9xxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGNNrgqb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGNNrgqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7DF1F000FF;
	Sun, 13 Sep 2026 21:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789334939;
	bh=xEY92NMXVVGlBTh4xsh7r/mT2eimuxnC3W7iwuky1Vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WGNNrgqbmZDCTX4MUxRtxtW0qpIn6Is3YbPyPIy6hf4MbIiVVywZZmaRzjzlU2DfG
	 ME9zKKMOc3VDV0K7ZQU5HzomGiTyJ0ykEoCxQXfl3FFPc/sUVcMv7mG7uadqiBlTDx
	 9GxkHKn2ktHDNdnhgH4cuzqJIdNm4cDOT5io19j0/OPNohB4QDmiAFKUfKi7LK6wv6
	 3AcuJutwBJ1/pp6i/JnrkIhir2tqvEAhVf1xQH3R274ly2uLdhDLv2RnMT9Bj8KjNY
	 BupErsAp0En67buJKyu0k6DWO15fRGlFRXOUDp/kyplaFk9zs3LT3xBJZLh5TyEv9n
	 kRBOjBC7VdK4Q==
Date: Sun, 13 Sep 2026 22:28:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Cesari <fabio.cesari@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Brian Masney
 <bmasney@redhat.com>, Joshua Crofts <joshua.crofts1@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: isl29028: fix runtime PM reference leak
 on error paths
Message-ID: <20260913222855.6db3932c@jic23-hlaptop>
In-Reply-To: <20260910062449.331749-1-fabio.cesari@gmail.com>
References: <20260910062449.331749-1-fabio.cesari@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 08:24:35 +0200
Fabio Cesari <fabio.cesari@gmail.com> wrote:

> isl29028_read_raw() and isl29028_write_raw() take a runtime PM reference
> with pm_runtime_resume_and_get() but return directly on their error
> paths without dropping it. The usage count never balances again and the
> device stops entering autosuspend for good. In isl29028_read_raw() this
> needs a regmap access to fail; in isl29028_write_raw() one rejected
> sysfs write is enough, for example
> 
>   echo 200 > in_proximity_sampling_frequency
> 
> which is outside the [1:100] range and returns -EINVAL with the
> reference still held.
> 
> Take the reference with PM_RUNTIME_ACQUIRE_AUTOSUSPEND() instead, so it
> is released on every return path.
> 
> This also stops the return value of pm_runtime_put_autosuspend() from
> reaching userspace. That value only says whether the device could be
> suspended right away, so -EAGAIN or -EPERM turns a successful access
> into a failure, and with CONFIG_PM=n the stub returns -ENOSYS on every
> access.
> 
> PM_RUNTIME_ACQUIRE_AUTOSUSPEND() exists since v6.19. Older trees need
> the manual form instead: keep pm_runtime_resume_and_get() and drop the
> reference on all paths with an unchecked pm_runtime_put_autosuspend().

No need to talk about how to backport.  That just bloats the patch
description. By all means add that info below the ---

If you fancy doing it, a follow up cleanup would be a nice to have (see inline).

I'll take this the slow route so applying it to the testing branch of iio.git
for the next merge window.

> 
> Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for < 6.19
Will drop that comment as well.  It's kind of obvious and may not be true
as often these macros get backported to make it easier to backport fixes like
this one.

> Assisted-by: LLM coccinelle
> Signed-off-by: Fabio Cesari <fabio.cesari@gmail.com>
> ---
> 
> Changes in v3, from the review of v2:
>   - use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() rather than the _IF_ENABLED_
>     variant
>   - sent as its own thread rather than as a reply to v2
> 
> v1: https://lore.kernel.org/linux-iio/20260906131203.125407-1-fabio.cesari@gmail.com/
> v2: https://lore.kernel.org/linux-iio/20260906223737.206730-1-fabio.cesari@gmail.com/
> 
> Found by auditing IIO drivers with a Coccinelle semantic patch for
> runtime PM acquire/release imbalances.
> 
> Compile-tested only: arm64 (native) and x86_64 (cross), defconfig plus
> CONFIG_SENSORS_ISL29028=m, plus an arm64 CONFIG_PM=n build to cover the
> stubs, with gcc 15.2.0, W=1 and sparse v0.6.5-rc1: no warnings. I have no
> isl29028 hardware, so this is untested at runtime.
> 
>  drivers/iio/light/isl29028.c | 33 ++++++++-------------------------
>  1 file changed, 8 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index 33deb1726689..e481ac908fc1 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -342,8 +342,9 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  	struct device *dev = regmap_get_device(chip->regmap);
>  	int ret;
>  
> -	ret = pm_runtime_resume_and_get(dev);
> -	if (ret < 0)
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
>  		return ret;
>  
>  	mutex_lock(&chip->lock);
> @@ -392,14 +393,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  
>  	mutex_unlock(&chip->lock);
Seeing this manual unlock made me take a closer look.
Given your patch takes uses the cleanup stuff already maybe we can
do better on the rest. We could leave the lock where it is, or reduce the scope.
Something like ...

	

	switch (chan->type) {
	case IIO_PROXIMITY: {
		if (mask != IIO_CHAN_INFO_SAMP_FREQ) {
			dev_err(dev,
				"%s(): proximity: Mask value 0x%08lx is not supported\n",
				__func__, mask);
			return -EINVAL;
		}

		if (val < 1 || val > 100) {
			dev_err(dev,
				"%s(): proximity: Sampling frequency %d is not in the range [1:100]\n",
				__func__, val);
			return -EINVAL;
		}
		guard(mutex)(&chip->lock);

		return isl29028_set_proxim_sampling(chip, val, val2);
	}
	case IIO_LIGHT: {
		if (mask != IIO_CHAN_INFO_SCALE) {
			dev_err(dev,
				"%s(): light: Mask value 0x%08lx is not supported\n",
				__func__, mask);
			break;
		}

		if (val != 125 && val != 2000) {
			dev_err(dev,
				"%s(): light: Lux scale %d is not in the set {125, 2000}\n",
				__func__, val);
			break;
		}
		guard(mutex)(&chip->lock);

		ret = isl29028_set_als_scale(chip, val);
		break;
	}
	default:
		dev_err(dev, "%s(): Unsupported channel type %x\n",
			__func__, chan->type);
		return -EINVAL;
Though the print can probably go as well as I assume this path can't
be hit.

	}
>  
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = pm_runtime_put_autosuspend(dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	return ret;
>  }
>  
>  static int isl29028_read_raw(struct iio_dev *indio_dev,
> @@ -408,10 +402,11 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct isl29028_chip *chip = iio_priv(indio_dev);
>  	struct device *dev = regmap_get_device(chip->regmap);
> -	int ret, pm_ret;
> +	int ret;
>  
> -	ret = pm_runtime_resume_and_get(dev);
> -	if (ret < 0)
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
>  		return ret;
>  
>  	mutex_lock(&chip->lock);
> @@ -461,18 +456,6 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  
>  	mutex_unlock(&chip->lock);
>  
> -	if (ret < 0)
> -		return ret;
> -
> -	/**
> -	 * Preserve the ret variable if the call to
> -	 * pm_runtime_put_autosuspend() is successful so the reading
> -	 * (if applicable) is returned to user space.
> -	 */
> -	pm_ret = pm_runtime_put_autosuspend(dev);
> -	if (pm_ret < 0)
> -		return pm_ret;
> -
>  	return ret;
>  }
>  
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

