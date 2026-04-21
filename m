Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E7537FF60
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765521; cv=none; b=VlkSC05vh08IR1/MaAQW/9okNAtht3zH4t34rHxc0f/X5bAPYzbzETj/9RkJf/5sHPxFZyYBxVE4EKxwqqUiahbE4szMw7n3WUWKHIPjqe4x2tvPdKOt9tXI0/FsEm0THJvMnZHBKz6xrQsBYlWil42iieQuOTPCAloYfrDDkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765521; c=relaxed/simple;
	bh=kNH6HaNBlswyUL4GdgIcWIlpccFBiNVfzPrBQKf9qw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/h95Paeinpz5SyngnVh/E6abiwpk9bjTbvuiUtfnpIQcRDCa+zoX962Djz0awD/s9+AtTlts34VW16YkYvyqufVlQiN86wHCdvucMw6KTaCkrA5kYHKv29ne9t/avJjR67MXeW8gyJ1fjpvlXN0vmDLavWcYLbr1qA7z91Sx1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiaXV+EC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiaXV+EC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A23C2BCB8;
	Tue, 21 Apr 2026 09:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776765521;
	bh=kNH6HaNBlswyUL4GdgIcWIlpccFBiNVfzPrBQKf9qw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qiaXV+ECTMlxuO62bmrpm0ynOvvQYuhRDCu890mkWSkZEJZeuDzLIuYSVaAGuy8k5
	 zts9QSvdDYan+gctU75LSskN0JnaGoXcLGMp6F8koGq9YaDoWigSI6BH2EVQW8zmZR
	 1YKztFfHh3VdtPkqxtbICsXbTD0ajjrs41raxqiCLvFbkXc69Caf09rBGHHH2dePwC
	 6nHn275OH22waJ81z8MbDR9CCbHFA1mG8kZMlbDFVaq6zGNWCZ/KsDz4Txt8IYFEkm
	 Ei//vGA6mMR/+PXFuyYQym0ZVAo5VyxL+N5cyfX/vPpp+mFiy99LqRCmqCBo3HHaJq
	 qoxRuunhqL4MA==
Date: Tue, 21 Apr 2026 10:58:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pedro Barletta Gennari <pedro.pbg@usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: iqs621-als: use lock guards
Message-ID: <20260421105834.0d6ebd98@jic23-huawei>
In-Reply-To: <20260421040313.21029-1-pedro.pbg@usp.br>
References: <20260421040313.21029-1-pedro.pbg@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 01:00:11 -0300
Pedro Barletta Gennari <pedro.pbg@usp.br> wrote:

> Use guard(mutex)() for handling mutex lock instead of
> manually locking and unlocking the mutex. This prevents forgotten
> locks due to early exits and remove the need of gotos.
> 
> Signed-off-by: Pedro Barletta Gennari <pedro.pbg@usp.br>
> ---
> v2:
>   - Keep include list ordered
>   - Remove redundant 'else'
>   - Remove unnecessary variable 'ret'
Hi Pedro,

The changes here enable a few additional code improvements that
I'd like to see made in the same patch.

See below,

Thanks,

Jonathan

> ---
>  drivers/iio/light/iqs621-als.c | 85 +++++++++++-----------------------
>  1 file changed, 28 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
> index b9f230210f07..8d08f28c642d 100644
> --- a/drivers/iio/light/iqs621-als.c
> +++ b/drivers/iio/light/iqs621-als.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> @@ -107,25 +108,21 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
>  	indio_dev = iqs621_als->indio_dev;
>  	timestamp = iio_get_time_ns(indio_dev);
>  
> -	mutex_lock(&iqs621_als->lock);
> +	guard(mutex)(&iqs621_als->lock);
>  
>  	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
>  		ret = iqs621_als_init(iqs621_als);
>  		if (ret) {
>  			dev_err(indio_dev->dev.parent,
>  				"Failed to re-initialize device: %d\n", ret);
> -			ret = NOTIFY_BAD;
> -		} else {
> -			ret = NOTIFY_OK;
> +			return NOTIFY_BAD;
>  		}
> -
> -		goto err_mutex;
> +		return NOTIFY_OK;
>  	}
>  
>  	if (!iqs621_als->light_en && !iqs621_als->range_en &&
>  	    !iqs621_als->prox_en) {
 	if (!iqs621_als->light_en && !iqs621_als->range_en && !iqs621_als->prox_en)

After change noted below, I'd just make this a slightly long single line.
We have gotten more relaxed on going a little over 80 chars since this
code was written.

> -		ret = NOTIFY_DONE;
> -		goto err_mutex;
> +		return NOTIFY_DONE;
>  	}

Single statement so { } not needed

>  

>  
>  static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
> @@ -278,11 +262,11 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
>  	unsigned int val;
>  	int ret;
>  
> -	mutex_lock(&iqs621_als->lock);
> +	guard(mutex)(&iqs621_als->lock);
>  
>  	ret = regmap_read(iqs62x->regmap, iqs62x->dev_desc->als_flags, &val);
>  	if (ret)
> -		goto err_mutex;
> +		return ret;
>  	iqs621_als->als_flags = val;
>  
>  	switch (chan->type) {
> @@ -293,7 +277,7 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
>  									 0xFF);
>  		if (!ret)
>  			iqs621_als->light_en = state;
> -		break;
> +		return ret;
Same as two cases below
>  
>  	case IIO_INTENSITY:
>  		ret = regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
> @@ -302,12 +286,12 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
>  									 0xFF);
>  		if (!ret)
>  			iqs621_als->range_en = state;
> -		break;
> +		return ret;
As below, flip this to
		if (ret)
			return ret;

		iqs621_als->range_en = state;

		return 0;

>  
>  	case IIO_PROXIMITY:
>  		ret = regmap_read(iqs62x->regmap, IQS622_IR_FLAGS, &val);
>  		if (ret)
> -			goto err_mutex;
> +			return ret;
>  		iqs621_als->ir_flags = val;
>  
>  		ret = regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
> @@ -315,16 +299,11 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
>  					 state ? 0 : 0xFF);
>  		if (!ret)
>  			iqs621_als->prox_en = state;

Please flip this to the more common form. Makes reading the code a little easier
if errors are handled out of line as early as possible.

		if (ret)
			return ret;

		iqs621_als->prox_en = state;

		return 0;

> -		break;
> +		return ret;
>  
>  	default:
> -		ret = -EINVAL;
> +		return -EINVAL;
>  	}
> -
> -err_mutex:
> -	mutex_unlock(&iqs621_als->lock);
> -
> -	return ret;
>  }

>  static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
> @@ -377,7 +351,7 @@ static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
>  	u8 ir_flags_mask, *thresh_cache;
>  	int ret = -EINVAL;

Drop this initialization and instead return the specific value on error paths.

>  
> -	mutex_lock(&iqs621_als->lock);
> +	guard(mutex)(&iqs621_als->lock);
>  
>  	switch (dir) {
>  	case IIO_EV_DIR_RISING:
> @@ -426,29 +400,26 @@ static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
>  			break;
>  
>  		default:
> -			goto err_mutex;
> +			return ret;
>  		}
>  
>  		thresh_cache = &iqs621_als->thresh_prox;
>  		break;
>  
>  	default:
> -		goto err_mutex;
> +		return ret;

return -EINVAL;

>  	}
>  
>  	if (thresh_val > 0xFF)
> -		goto err_mutex;
> +		return ret;

return -EINVAL;

>  
>  	ret = regmap_write(iqs62x->regmap, thresh_reg, thresh_val);
>  	if (ret)
> -		goto err_mutex;
> +		return ret;
>  
>  	*thresh_cache = thresh_val;
>  	iqs621_als->ir_flags_mask = ir_flags_mask;
>  
> -err_mutex:
> -	mutex_unlock(&iqs621_als->lock);
> -
>  	return ret;
>  }
>  

