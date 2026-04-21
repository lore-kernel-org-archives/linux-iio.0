Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A333B2FDA
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767382; cv=none; b=JSqK58tVxyVDeN3MkrpVlPUUubgNBhtF6BvkrPG8u9KxEgjEYJFINj8QgvDeUc2yYWyPZGnzc7RLhhYlOvQ550oWwWXVTODiUD2Xuj7pz2mACq7eJDtqAhmTfde/yRspzLXNEfQnpJUyAdebo+XWmpbP3Vnk87wHKZXaFnNYNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767382; c=relaxed/simple;
	bh=YT18/9jmP61Yg7XOAZ23tnIRw4XvzEZIIlU3o+/zewU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5bF8oTjhSMdHMg6LK01Q2d8a1t4zEpK/8bESpbbof0MWVLKuJVampLl2bNzsof5gXwigYs5u3W2b72Cf1Lw48XkwpkQZKmaXvV1rvKuT/W3YMQFP722oX0K2f36Gjl9CICOI32u46KbCE3SfSZV8ckDswVAOnR4Dj0AlQwuY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja5d7M8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja5d7M8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E230C2BCB0;
	Tue, 21 Apr 2026 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776767382;
	bh=YT18/9jmP61Yg7XOAZ23tnIRw4XvzEZIIlU3o+/zewU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ja5d7M8mQx77+Oi39eOqdIDYBQAIn3uSKoLJe/sn/Mv7SPKkivsNknu5dUSrPuqPI
	 vG8nHoNFPH9gSrzIPk07UgHz8j42lH5Rz2ImZL73ZX78Zv0ZlcDFVA7wr74scnlvc8
	 IcV006DaCNJkiFUdDk0ISF48F8WtSG7AQSjHb2CoU0j7O7y4N/o7pkjDlYNFHj8JWX
	 hfrq6GPDPmKifBlw8v+j3xdOB8X2zOhgTiCDfZQQm/yMpfD0NMvxux1qFmpcGlOd12
	 is+S67POjZVkTjLklSgYkyvz5wEDgqa3svehGccowv1IRTh0uY/4TajYmW/siA+POo
	 oIie3ik4R77fQ==
Date: Tue, 21 Apr 2026 11:29:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: rafasales@usp.br
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, "Gustavo C.
 Arakaki" <gustavo.arakaki@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: ltr501: use automatic cleanup of
 locks
Message-ID: <20260421112934.737107c8@jic23-huawei>
In-Reply-To: <20260421021023.563290-3-rafasales@usp.br>
References: <20260421021023.563290-1-rafasales@usp.br>
	<20260421021023.563290-3-rafasales@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 23:10:01 -0300
rafasales@usp.br wrote:

> From: "Rafael B. Sales" <rafasales@usp.br>
> 
> Replace `mutex_lock()` and `mutex_unlock()` calls with guards
> to reduce boilerplate and allow for simpler code blocks.
> 
> Signed-off-by: Rafael B. Sales <rafasales@usp.br>
> Co-developed-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
> Signed-off-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>

I think a few of these can be done in a cleaner fashion - see below.

Jonathan

>  
>  static int ltr501_als_read_samp_period(const struct ltr501_data *data, int *val)
> @@ -505,9 +499,8 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
>  		if (new_val < 0 || new_val > 0x0f)
>  			return -EINVAL;
>  
> -		mutex_lock(&data->lock_als);
> -		ret = regmap_field_write(data->reg_als_prst, new_val);
> -		mutex_unlock(&data->lock_als);
> +		scoped_guard(mutex, &data->lock_als)
> +			ret = regmap_field_write(data->reg_als_prst, new_val);
>  		if (ret >= 0)
>  			data->als_period = period;
>  
> @@ -525,9 +518,8 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
>  		if (new_val < 0 || new_val > 0x0f)
>  			return -EINVAL;
>  
> -		mutex_lock(&data->lock_ps);
> -		ret = regmap_field_write(data->reg_ps_prst, new_val);
> -		mutex_unlock(&data->lock_ps);
> +		scoped_guard(mutex, &data->lock_ps)
> +			ret = regmap_field_write(data->reg_ps_prst, new_val);
>  		if (ret >= 0)
>  			data->ps_period = period;
This and the one above are more complex as we'd not want to imply protection of
ps_period by including it in the lock if that doesn't make sense.

>  
> @@ -669,18 +661,16 @@ static int ltr501_read_info_raw(struct ltr501_data *data,
>  
>  	switch (chan->type) {
>  	case IIO_INTENSITY:
> -		mutex_lock(&data->lock_als);
> -		ret = ltr501_read_als(data, buf);
> -		mutex_unlock(&data->lock_als);
> +		scoped_guard(mutex, &data->lock_als)
> +			ret = ltr501_read_als(data, buf);
>  		if (ret < 0)
>  			return ret;
>  		*val = le16_to_cpu(chan->address == LTR501_ALS_DATA1 ?
>  				   buf[0] : buf[1]);

This is cheap and local stuff only. For these two cases i'd use {} + guard() as below and
not worry about doing this under the lock.

>  		return IIO_VAL_INT;
>  	case IIO_PROXIMITY:
> -		mutex_lock(&data->lock_ps);
> -		ret = ltr501_read_ps(data);
> -		mutex_unlock(&data->lock_ps);
> +		scoped_guard(mutex, &data->lock_ps)
> +			ret = ltr501_read_ps(data);
>  		if (ret < 0)
>  			return ret;
>  		*val = ret & LTR501_PS_DATA_MASK;
> @@ -705,9 +695,8 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
>  			if (!iio_device_claim_direct(indio_dev))
>  				return -EBUSY;
>  
> -			mutex_lock(&data->lock_als);
> -			ret = ltr501_read_als(data, buf);
> -			mutex_unlock(&data->lock_als);
> +			scoped_guard(mutex, &data->lock_als)
> +				ret = ltr501_read_als(data, buf);
This use of scoped_guard() does make sense as there is non trivial work to
do afterwards.
>  			iio_device_release_direct(indio_dev);
>  			if (ret < 0)
>  				return ret;
> @@ -820,9 +809,8 @@ static int __ltr501_write_raw(struct iio_dev *indio_dev,
>  			if (val != 0)
>  				return -EINVAL;
I'd use a guard here (see below) for same reasons. It'll just be after this
initial sanity check.

>  
> -			mutex_lock(&data->lock_als);
> -			ret = ltr501_set_it_time(data, val2);
> -			mutex_unlock(&data->lock_als);
> +			scoped_guard(mutex, &data->lock_als)
> +				ret = ltr501_set_it_time(data, val2);

>  			return ret;
>  		default:
>  			return -EINVAL;
> @@ -971,18 +959,16 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		switch (dir) {
>  		case IIO_EV_DIR_RISING:
> -			mutex_lock(&data->lock_als);
> -			ret = regmap_bulk_write(data->regmap,
> -						LTR501_ALS_THRESH_UP,
> -						&val, 2);
> -			mutex_unlock(&data->lock_als);
> +			scoped_guard(mutex, &data->lock_als)
> +				ret = regmap_bulk_write(data->regmap,
> +							 LTR501_ALS_THRESH_UP,
> +							 &val, 2);
See below.

>  			return ret;
>  		case IIO_EV_DIR_FALLING:
> -			mutex_lock(&data->lock_als);
> -			ret = regmap_bulk_write(data->regmap,
> -						LTR501_ALS_THRESH_LOW,
> -						&val, 2);
> -			mutex_unlock(&data->lock_als);
> +			scoped_guard(mutex, &data->lock_als)
> +				ret = regmap_bulk_write(data->regmap,
> +							 LTR501_ALS_THRESH_LOW,
> +							 &val, 2);
See below.
>  			return ret;
>  		default:
>  			return -EINVAL;
> @@ -992,18 +978,16 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		switch (dir) {
>  		case IIO_EV_DIR_RISING:
> -			mutex_lock(&data->lock_ps);
> -			ret = regmap_bulk_write(data->regmap,
> -						LTR501_PS_THRESH_UP,
> -						&val, 2);
> -			mutex_unlock(&data->lock_ps);
> +			scoped_guard(mutex, &data->lock_ps)
> +				ret = regmap_bulk_write(data->regmap,
> +							 LTR501_PS_THRESH_UP,
> +							 &val, 2);
See below.
>  			return ret;
>  		case IIO_EV_DIR_FALLING:
> -			mutex_lock(&data->lock_ps);
> -			ret = regmap_bulk_write(data->regmap,
> -						LTR501_PS_THRESH_LOW,
> -						&val, 2);
> -			mutex_unlock(&data->lock_ps);
> +			scoped_guard(mutex, &data->lock_ps)
> +				ret = regmap_bulk_write(data->regmap,
> +							 LTR501_PS_THRESH_LOW,
> +							 &val, 2);
See below.
>  			return ret;
>  		default:
>  			return -EINVAL;
> @@ -1100,14 +1084,12 @@ static int ltr501_write_event_config(struct iio_dev *indio_dev,
>  
>  	switch (chan->type) {
>  	case IIO_INTENSITY:
> -		mutex_lock(&data->lock_als);
> -		ret = regmap_field_write(data->reg_als_intr, state);
> -		mutex_unlock(&data->lock_als);
> +		scoped_guard(mutex, &data->lock_als)
> +			ret = regmap_field_write(data->reg_als_intr, state);
>  		return ret;
for these I'd rather see the pattern

	case IIO_INTENSITY: {
		guard(mutex)(&data->lock_als);
		return regmap_field_write();
	}

The scoped_guard() has some annoying issues wrt to compilers and their ability to
see that the loop (it's a for loop underneath) is always entered and so you can't
move the return in there.  The bare guard() form doesn't have that problem.

>  	case IIO_PROXIMITY:
> -		mutex_lock(&data->lock_ps);
> -		ret = regmap_field_write(data->reg_ps_intr, state);
> -		mutex_unlock(&data->lock_ps);
> +		scoped_guard(mutex, &data->lock_ps)
> +			ret = regmap_field_write(data->reg_ps_intr, state);
As above.

>  		return ret;
>  	default:
>  		return -EINVAL;

