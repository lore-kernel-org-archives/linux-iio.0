Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F130498E;
	Sat, 11 Jul 2026 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783811309; cv=none; b=kgfEoD3RrLMmPRU8agf2XOTCToZUBeWvAO6myXTLInY0Jw2/Y/Km1afhpW4GanCrJRsHomZgjI2g/aLseyai+pQbKZiue+v80vNIDVshQ0ZJ1fjCjpOlPylBWh10Imp8sVqzdRKep/PqdqpVsI7P5Do0WMWWqETxuuLxSf3zR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783811309; c=relaxed/simple;
	bh=F+v8RHQm+6qNc5mBbT7iF+7CPJB/vkoDU/7nJ96RvNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtZWs7JfExmH2eTZjlymjVb0+yfElKZ7/OkEtHcnc8qZN2h6HyuWEF4zi5x1GseslLIZGJWk2cIKAOD9/bOCXS6Y8Xuw1Aqo+xdP9EU0fj9tfyC5ZYLak4snaopxyDiV2AfQeK85FeBTRru/ojj/bq3WMSVrcLedkqpfGK+OHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPQg1Mcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPQg1Mcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ED71F000E9;
	Sat, 11 Jul 2026 23:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783811307;
	bh=yBRwMN4Q60Id72FX9KHhaX20Y6VJp57wq0wuqAF/AZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fPQg1McruX7cyxbvcvdQrikx8EFpozOrIKHj6oG1P8TppHm7UCM9izjvzNqcQ/ZLz
	 /wQnO9JOEnKF2YMZ4vMgqhnubjlH1J32INYDkUgs2AzaNSG7A9BiphVJO+VTTSpphW
	 tubY46m1nSXCZwP2IRf4W9rEZs3exTIoWJ004SgxHCEUnOdTR1mSH84RoBojKfBooQ
	 0f7/Vips+tIULffpJmDsLt5kMZyEzY+x3Ipn7dH8sJ2TrfPYK5sQ1RMTrJi0Zf15Hz
	 2EEIG0OCHsGTfLrh3jMX07OHCqLKCAfMslp+JuY/KPZswRyz+UwLn1SjROSCzqZWIP
	 it3bIx0vxm5cw==
Date: Sun, 12 Jul 2026 00:08:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biren Pandya <birenpandya@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Linus Walleij <linusw@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: accel: kxsd9: fix runtime PM leaks and
 unchecked returns
Message-ID: <20260712000823.327e506a@jic23-huawei>
In-Reply-To: <20260706074650.96042-4-birenpandya@gmail.com>
References: <20260706074650.96042-3-birenpandya@gmail.com>
	<20260706074650.96042-4-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jul 2026 13:16:52 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> The kxsd9 driver previously used manual pm_runtime_get_sync() and
> pm_runtime_put_autosuspend() calls in various return paths, which is
> prone to memory leaks if a return path is missed. Specifically, in
> kxsd9_write_raw(), if the user provides a non-zero integer component
> for scale, the function previously returned -EINVAL directly, leaking
> the runtime PM usage counter.

This has become too complex. For the fix, can we just close that one
problem case.  Then follow up with the refactors and hardening after?

The minimal fix is probably the code move you have to check that
the request is valid before doing anything with runtime pm.

> 
> Switch to using the new scoped-based PM_RUNTIME_ACQUIRE_AUTOSUSPEND()
> and PM_RUNTIME_ACQUIRE_ERR() macros to automatically handle dropping
> the PM usage counter upon return. This simplifies the logic by allowing
> early returns in error paths.
> 
> In remove(), use pm_runtime_resume_and_get() with an error check to
> prevent unchecked return issues, and perform a best-effort power down.
> 
> Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>
> ---
>  drivers/iio/accel/kxsd9.c | 59 ++++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 7569201ed3c75..a71b473cbfa03 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -139,68 +139,65 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
>  			   int val2,
>  			   long mask)
>  {
> -	int ret = -EINVAL;
>  	struct kxsd9_state *st = iio_priv(indio_dev);
> +	int ret;
>  
> -	pm_runtime_get_sync(st->dev);
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
>  
> -	if (mask == IIO_CHAN_INFO_SCALE) {
> -		/* Check no integer component */
> -		if (val)
> -			return -EINVAL;
> -		ret = kxsd9_write_scale(indio_dev, val2);
> -	}
> +	if (val)
> +		return -EINVAL;
>  
> -	pm_runtime_put_autosuspend(st->dev);
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(st->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
>  
> -	return ret;
> +	return kxsd9_write_scale(indio_dev, val2);
Yikes this driver has 'aged'.  This call has a nasty
goto err_ret in one path that just returns the error, yet
does direct retuns in the other.

Anyhow, the reason I mention that is an alternative
to this would be to move the runtime pm into
kxsd9_write_scale()  That would be part of a more signficant
cleanup but if you are interested it... Lets just take that function:

> static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
> {
> 	int ret, i;
> 	struct kxsd9_state *st = iio_priv(indio_dev);
> 	bool foundit = false;

After changes below can also do a bit of reordering to make this
reverse xmas tree.

> 
> 	for (i = 0; i < 4; i++)
Replace the 4 with ARRAY_SIZE(kxsd9_micro_scales) ou
and 
	for (unsigned int i = 0; i < ARRAY_SIZE(kxsd9_micro_scales), i++)

> 		if (micro == kxsd9_micro_scales[i]) {
> 			foundit = true;
Drop foundit as pointless. Instead...
> 			break;
> 		}
> 	if (!foundit)
	if (i == ARRAY_SIZE(kxsd9_micro_scales))
		return -EINVAL;

> 		return -EINVAL;
> 
> 	ret = regmap_update_bits(st->map,
> 				 KXSD9_REG_CTRL_C,
> 				 KXSD9_CTRL_C_FS_MASK,
> 				 i);
rewrap that.
> 	if (ret < 0)
> 		goto error_ret;
	if (ret)

As regmap always returns <= 0 

		return ret; 

> 
> 	/* Cached scale when the sensor is powered down */

Not sure this is terribly helpful as comments go, so maybe drop it.

> 	st->scale = i;
> 
> error_ret:
> 	return ret;

return 0;

> }

I don't have time now to do a full driver review (too many patches
waiting) but in general this looks like it could do with some
'modernization'.   I feel justified in being particularly rude
about this one as a much younger me wrote it :)

>  }
>  
>  static int kxsd9_read_raw(struct iio_dev *indio_dev,
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
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(st->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = regmap_bulk_read(st->map, chan->address, &raw_val,
>  				       sizeof(raw_val));
>  		if (ret)
> -			goto error_ret;
> +			return ret;
>  		nval = be16_to_cpu(raw_val);
>  		/* Only 12 bits are valid */
>  		nval >>= 4;
>  		*val = nval;
> -		ret = IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OFFSET:
>  		/* This has a bias of -2048 */
>  		*val = KXSD9_ZERO_G_OFFSET;
> -		ret = IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;

Hmm. Turning the power on to output a known constant is a bit
ugly and a side effect of the original goto pattern.  Let us
drag the PM_RUNTIME_ACQUIRE... into the cases that need it.
Make sure to use {} to define scope for case blocks where you
are doing this.

>  	case IIO_CHAN_INFO_SCALE:
>  		ret = regmap_read(st->map,
>  				  KXSD9_REG_CTRL_C,
>  				  &regval);
>  		if (ret < 0)
> -			goto error_ret;
> +			return ret;
>  		*val = 0;
>  		*val2 = kxsd9_micro_scales[regval & KXSD9_CTRL_C_FS_MASK];
> -		ret = IIO_VAL_INT_PLUS_MICRO;
> -		break;
> +		return IIO_VAL_INT_PLUS_MICRO;

	default:
		reutrn -EINVAL;
and get rid of the block below.   The reason for this style is to
make it obvious it is intentional that the switch statement only
covers a subset.

>  	}
>  
> -error_ret:
> -	pm_runtime_put_autosuspend(st->dev);
> -
> -	return ret;
> +	return -EINVAL;
>  };
>  
>  static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
> @@ -239,9 +236,7 @@ static int kxsd9_buffer_preenable(struct iio_dev *indio_dev)
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
> @@ -476,12 +471,18 @@ void kxsd9_common_remove(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct kxsd9_state *st = iio_priv(indio_dev);
> +	int ret;
>  
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
> -	pm_runtime_get_sync(dev);
> -	pm_runtime_put_noidle(dev);
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		dev_warn(dev, "Failed to resume device (%d)\n", ret);
> +
>  	pm_runtime_disable(dev);
> +	if (ret >= 0)
> +		pm_runtime_put_noidle(dev);
Andy's point is valid about the reorder.  I don't think it is
a bug, but I'm fairly sure it is unnecessary as nothing else is
going to mess with the reference count in this window.

I'm also not sure I care about an underflow if we are in the
weird corners of runtime pm failing on remove.
Note that it doesn't actually fail if you drop it too far (despite
what sashiko thinks).  Runtime pm counters are always >= 0.
Implementation is:
static inline void pm_runtime_put_noidle(struct device *dev)
{
	atomic_add_unless(&dev->power.usage_count, -1, 0);
}

Whilst I prefer to keep balance, that protection is there to
simplify this sort of tear down triggered underflow so let us
use it here.


>  	kxsd9_power_down(st);
>  }
>  EXPORT_SYMBOL_NS(kxsd9_common_remove, "IIO_KXSD9");

