Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2393EE1D8;
	Wed,  6 May 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083552; cv=none; b=Js3FSBQr9UvgQZY8LWM5HzE89MILw99wj12bSxGZIFIK5OK8b8j6q8FmOyZyRkJrZvPFTdkDYCs2yDmqxfd9HmX4uEnIqHxwWHNCW0wDaXcxxwS07dUgFKWJ4vyec4fj12ZP3pCIo5ghgN9TaEQCgYE7HUTFcIjk4+gvq2jG0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083552; c=relaxed/simple;
	bh=rh2s3bqRm0gdUfPovUyShKHeycBmncvwZl9+SKSuSNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okEBgvI8LNSAgWlSqYztbcB50HOe/u8vJ4IMvYtTeWfr/Nj6nZGJxz3Ewu3drHBAl5D4thiadlIExFLra80R2UBM3oO/snmFDnauFo66/jxL62vjvV7otpfU5ZqbMu8nF749xaovK9lQuu+QJuFJjT5IOeGFyCrnf/aWTSFmcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBcUG15l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBcUG15l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C1CC2BCB0;
	Wed,  6 May 2026 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778083551;
	bh=rh2s3bqRm0gdUfPovUyShKHeycBmncvwZl9+SKSuSNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DBcUG15lyzUiP9I0nG5CTMQgTRazmik5ZvvpgEWcTIEdkLGFzhezbvTvShtwW/LtN
	 aiqw4oBuh9OjGuY+Wo43i5Hc1+0QDmaYb4A2t9pWatbeffX8Rhl78fV0NFAfFsH6Dl
	 765iaXs2pCNPbck/dXdGKAlMONMelqYFo9xQ4oEcxGfGRX18PMG7ULP9k06uDc43ok
	 gsub5lLfGTxoD4vvz/tvGikFxBRE/ojhQAA6oLAH9d8EpaGYiCeT8fB8EjOu9yll2X
	 ls5KyPrJmAHv60xo72ru8h8BdOiBJ7AtGN6Fz7tfbsKWINKSKbLGPYf/f5kd5exVLj
	 g1igvoA4broOA==
Date: Wed, 6 May 2026 17:05:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v4] iio: imu: kmx61: Use guard(mutex)() over manual
 locking
Message-ID: <20260506170546.66d4d5e7@jic23-huawei>
In-Reply-To: <20260505220719.44646-1-m32285159@gmail.com>
References: <20260505220719.44646-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 May 2026 17:07:19 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Include linux/cleanup.h to take advantage of new macros.
> 
> Replace manual mutex_lock() and mutex_unlock() calls across the file
> with guard(mutex)() and scoped_guard() where appropriate. This will help
> modernize the driver with up-to-date functions/macros.
> 
> Remove now redundant gotos and ret variables, as the new RAII macros
> make them unneeded.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Hi Maxwell

I'd slow down a bit to give more time for reviews.
I'd imagine some of the below was true in earlier versions.

Jonathan

> @@ -830,17 +827,17 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> +	case IIO_CHAN_INFO_SAMP_FREQ: {

Don't need {} in this case as no local variables added in this scope.
scoped_guard() is a trick with a for loop so has it's own scope definition
as part of the macro implementation.

>  		if (chan->type != IIO_ACCEL && chan->type != IIO_MAGN)
>  			return -EINVAL;
>  
> -		mutex_lock(&data->lock);
> -		ret = kmx61_get_odr(data, val, val2, chan->address);
> -		mutex_unlock(&data->lock);
> +		scoped_guard(mutex, &data->lock)
> +			ret = kmx61_get_odr(data, val, val2, chan->address);
>  		if (ret)
>  			return -EINVAL;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	}
> +	}
>  	return -EINVAL;
>  }

> @@ -945,28 +939,25 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
>  	if (state && data->ev_enable_state)
>  		return 0;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	if (!state && data->motion_trig_on) {
>  		data->ev_enable_state = false;
> -		goto err_unlock;
> +		return ret;
>  	}
>  
>  	ret = kmx61_set_power_state(data, state, KMX61_ACC);
>  	if (ret < 0)
> -		goto err_unlock;
> +		return ret;
>  
>  	ret = kmx61_setup_any_motion_interrupt(data, state);
>  	if (ret < 0) {
>  		kmx61_set_power_state(data, false, KMX61_ACC);
> -		goto err_unlock;
> +		return ret;
>  	}
>  
>  	data->ev_enable_state = state;
>  
> -err_unlock:
> -	mutex_unlock(&data->lock);
> -
>  	return ret;
If we know this is 0 (probably is) then return 0.
>  }

> @@ -1195,19 +1184,18 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
>  	else
>  		base = KMX61_MAG_XOUT_L;
>  
> -	mutex_lock(&data->lock);
> -	iio_for_each_active_channel(indio_dev, bit) {
> -		ret = kmx61_read_measurement(data, base, bit);
> -		if (ret < 0) {
> -			mutex_unlock(&data->lock);
> -			goto err;
> +	scoped_guard(mutex, &data->lock) {
> +		iio_for_each_active_channel(indio_dev, bit) {
> +			ret = kmx61_read_measurement(data, base, bit);
> +			if (ret < 0) {
> +				iio_trigger_notify_done(indio_dev->trig);
> +				return IRQ_HANDLED;

The duplication is a bit ugly. I'd be tempted to use a helper to clean this up
Would be something like (not even compiled!)

static int kmx61_read_all(struct iio_dev *indio_dev, s16 buffer[at_least 8])
{
	struct kmx61_data *data = kmx61_get_data(indio_dev);
	u8 base;	
	int ret, i, bit;

	if (indio_dev == data->acc_indio_dev)
		base = KMX61_ACC_XOUT_L;
	else
		base = KMX61_MAG_XOUT_L;
	
	guard(mutex)(&data->lock);

	iio_for_each_active_channel(indio_dev, bit) {
		ret = kmx61_read_measurement(data, base, bit);
		if (ret < 0)
			return ret;
		buffer[i++] = ret;
	}
	return 0;
}

static irqreturn_t kmx61_trigger_handler(int irq, void *p)
{
	struct iio_poll_func *pf = p;
	struct iio_dev *indio_dev = pf->indio_dev;
	s16 buffer[8] = { };
	u8 base;

	if (kmx61_read_all(indio_dev, buffer))
		goto err;

	iio_push_to_buffers(indio_dev, buffer);
err:
	iio_trigger_notify_done(indio_dev->trig);

	return IRQ_HANDLED;
}

> +			}
> +			buffer[i++] = ret;
>  		}
> -		buffer[i++] = ret;
>  	}
> -	mutex_unlock(&data->lock);
>  
>  	iio_push_to_buffers(indio_dev, buffer);
> -err:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;

