Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF73B52FD
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030344; cv=none; b=EiJi55iaPgr7YK0c23CiCNS8m87NDsGi9C+Iq8SQjB/yq4mpRu80rGDgKE1H0a0+HZCVq8eF8Q8TxZ2HIP+3VrHKu3XseC7tRALYvPbU9VO4YkdUapQtY5WqEx0qN2D8sRJdlR4KFrJ7p3sniBdTF6IP1CqrjFOwoyc1lNEJtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030344; c=relaxed/simple;
	bh=uQWrxPQc/TbbWdq5m8PJOvoPnFH89fF+CYOe2qV/WU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8O3YAylCdS5jO2IGvo/4Q2oGNBNMoFGCVtvpftFiJ8mAXFteZZTp/ZW8jssBC8vebOSKVGULjPt23VdezZjA4ioeLdx74o5jBtnYhawfeHAZL+wy+0rg9iwPYrhFPc6HhBBGVQLMfLuU3FQMc6FTtyYCGOlQDOM34Nf2QWnCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hREzJqwY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hREzJqwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0280C19425;
	Fri, 24 Apr 2026 11:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777030344;
	bh=uQWrxPQc/TbbWdq5m8PJOvoPnFH89fF+CYOe2qV/WU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hREzJqwY4wAibJ/T+8j6rHCqqx66McUs5Z1YufNl1tYKSKJdi2vYfqXWROQQ00Zjp
	 PASH4TafLMeB/Ey+BKC/xXg2zJ2MAYHVGkDO4o8UwGHDYw/SD8MsrToFaS6+1S6Ov+
	 SOF+zlvPZ+FwyMvpyUmzRnwobUKZI5BEXhxyP+zPL6jHC2xj7htiPBjEbUeXbiXQbT
	 rLAnaBkDv1aUS8XuyBESe3jRPCrmXfA0QcuZbw3u51rM9SSy/okfUffqIvBKaF7LhX
	 vMDNZ6EAXv4dWyYYnBnxypMw6p7vpenCR90weAczG6dVlO26wWFi3iJwIQJrVp9Flu
	 7VVIOSU66EyAA==
Date: Fri, 24 Apr 2026 12:32:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: rafasales@usp.br
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, "Gustavo C.
 Arakaki" <gustavo.arakaki@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: light: ltr501: use automatic cleanup of
 locks
Message-ID: <20260424123216.3e0a2969@jic23-huawei>
In-Reply-To: <20260422231305.677778-3-rafasales@usp.br>
References: <20260422231305.677778-1-rafasales@usp.br>
	<20260422231305.677778-3-rafasales@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 20:12:56 -0300
rafasales@usp.br wrote:

> From: "Rafael B. Sales" <rafasales@usp.br>
> 
> Replace `mutex_lock()` and `mutex_unlock()` calls with guards
> to reduce boilerplate and allow for simpler code blocks.
> 
> Signed-off-by: Rafael B. Sales <rafasales@usp.br>
> Co-developed-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
> Signed-off-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
> 
> ---
> Changes in v3:
> - Replaces `scoped_guard()` with {} + `guard()` in some cases
> - Simplifies some return statements
> - Includes cleanup.h header
> 
> Changes in v2:
> - Maintains original locking boundaries
> - Simplifies some return statements

>  static int ltr501_als_read_samp_period(const struct ltr501_data *data, int *val)
> @@ -504,9 +499,10 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
>  		if (new_val < 0 || new_val > 0x0f)
>  			return -EINVAL;
>  
> -		mutex_lock(&data->lock_als);
> -		ret = regmap_field_write(data->reg_als_prst, new_val);
> -		mutex_unlock(&data->lock_als);
> +		scoped_guard(mutex, &data->lock_als) {
> +			ret = regmap_field_write(data->reg_als_prst, new_val);
> +		}
> +
>  		if (ret >= 0)
Whilst here I'd like these to take more standard form.  

		if (ret)
			return ret;

		data->als_period = period;

		return 0; 

It would be a separate patch though so I don't mind if we leave it for another day.

Also removes suggestion that the current code makes that ret > 0 is a possibility
when it isn't.
>  			data->als_period = period;
>  
> @@ -524,9 +520,10 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
>  		if (new_val < 0 || new_val > 0x0f)
>  			return -EINVAL;
>  
> -		mutex_lock(&data->lock_ps);
> -		ret = regmap_field_write(data->reg_ps_prst, new_val);
> -		mutex_unlock(&data->lock_ps);
> +		scoped_guard(mutex, &data->lock_ps) {
> +			ret = regmap_field_write(data->reg_ps_prst, new_val);
> +		}
> +
>  		if (ret >= 0)
>  			data->ps_period = period;
Same on this one and any other similar cases.


> @@ -1095,19 +1085,16 @@ static int ltr501_write_event_config(struct iio_dev *indio_dev,
>  				     enum iio_event_direction dir, bool state)
>  {
>  	struct ltr501_data *data = iio_priv(indio_dev);
> -	int ret;
>  
>  	switch (chan->type) {
> -	case IIO_INTENSITY:
> -		mutex_lock(&data->lock_als);
> -		ret = regmap_field_write(data->reg_als_intr, state);
> -		mutex_unlock(&data->lock_als);
> -		return ret;
> -	case IIO_PROXIMITY:
> -		mutex_lock(&data->lock_ps);
> -		ret = regmap_field_write(data->reg_ps_intr, state);
> -		mutex_unlock(&data->lock_ps);
> -		return ret;
> +	case IIO_INTENSITY: {
> +		guard(mutex)(&data->lock_als);
> +		return regmap_field_write(data->reg_als_intr, state);
> +		}
If you end up keeping this stuff, I think conventional style would have
the bracket here:
	}
> +	case IIO_PROXIMITY: {
> +		guard(mutex)(&data->lock_ps);
> +		return regmap_field_write(data->reg_ps_intr, state);
> +		}
>  	default:
>  		return -EINVAL;
>  	}

