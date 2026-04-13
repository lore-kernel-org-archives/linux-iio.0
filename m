Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5822E3FE;
	Mon, 13 Apr 2026 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109852; cv=none; b=Yu8QTY8umsncGWs7/BlDPHheVLLmtDd6pqTfJNmO65le02Dydww5AawlXGsCoK7Ru3lvu1rKWA5F8eUv2IY4pJxpMGbchy38gMdvjr0oRovD+hlkF3XH3Qyjkt4pRxOXLaVuXAyEKtSoKRnPpxtxFLenuwfry77Lm1n/DQgN44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109852; c=relaxed/simple;
	bh=L38VbUrCM/Y9/BqRWJZzGWXTZGQajiSuOZsrqVudQ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CflCGRNuH28LaKNPbL/l9GesR9PK8QFL0QRUj6dDSbMr9hwU/vawt7GfGD6kX/wSkk6537ZSaTQdqhrLYhKrTOhtNl9KM0gje1mBV+D/EFIfHMJxlgyvvERG1N2bvwZYxAedeQ2Jt/vzfNsernwtjI+y01t0IuXLNO5ob4lzscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfr97mUR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfr97mUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C91AC2BCB0;
	Mon, 13 Apr 2026 19:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776109852;
	bh=L38VbUrCM/Y9/BqRWJZzGWXTZGQajiSuOZsrqVudQ6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rfr97mUR8oH8G2A+sd5SMZWOQBIK7BieIle+ssb4yUlpz9fTn+7XuELVn+oZYa+tB
	 7K6pZM2+4PErkMR4zqgoe9nDm0JNCY5C6xXMA1H8psNQ5f8tbGRQpvqFJCINycRyVr
	 wvlrq1/Zvx7ZNNjDBzaVzCQlyzqMJ7a+LXRHXjz5iBqtx8eUfd3fsqgNUIvHxhgof2
	 oNi0T0Np5+AzWZ6ps5l13JeGoUWBJ7yeVwAnY0yO78ClyJjWdkNGR/YZ/VYYjcrXiu
	 YFQBt9KHBw2GFXgPyu5ikG2As04zKHr4JmCq81Shx84M+I1qVHWxQ5v/zmsIlyT6/v
	 8+T9vquRLDG5w==
Date: Mon, 13 Apr 2026 20:50:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Giarola <matheustpgiarola@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, matheusgiarola@usp.br, arthurpilone@usp.br,
 davidbtadokoro@ime.usp.br
Subject: Re: [PATCH v4] iio: adc: ad7280a: replace mutex_lock() with
 guard(mutex)
Message-ID: <20260413205043.43f8833c@jic23-huawei>
In-Reply-To: <20260412154748.24937-1-matheusgiarola@usp.br>
References: <20260412154748.24937-1-matheusgiarola@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Apr 2026 12:47:48 -0300
Matheus Giarola <matheustpgiarola@gmail.com> wrote:

> Use guard(mutex) instead of mutex_lock()/mutex_unlock(),
> ensuring the mutex is released automatically when leaving
> the function scope. The change improves error handling and
> avoids issues such as missing unlocks. It also simplifies the
> code by removing 'err_unlock' label and several mutex_unlock()
> calls.
> 
> As suggested, in ad7280_read_raw(), wrap the IIO_CHAN_INFO_RAW
> case in braces, providing a scope for the implicit variable
> declared by guard(mutex).
> 
> Also, limit guard(mutex) scope in ad7280_show_balance_timer()
> to keep it locked just when necessary.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
> ---
> v4:
> - limit guard(mutex) scope in ad7280_show_balance_timer()

Some confusion has occured here.  The braces thing works for some
places (where we bring only trivial extra operations under the lock)
but don't use it where scoped_guard() is cleaner.

> 
> v3:
> - correct v2 patch tags
> 
> v2:
> - fix missing scope in ad7280_read_raw() by wrapping IIO_CHAN_INFO_RAW
>   case in braces so as to fix build errors.
> 
>  drivers/iio/adc/ad7280a.c | 34 +++++++++++++---------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
> index ba12a3796e2b..f3cbf8810daa 100644
> --- a/drivers/iio/adc/ad7280a.c
> +++ b/drivers/iio/adc/ad7280a.c
...

> @@ -519,10 +518,11 @@ static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
>  	unsigned int msecs;
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> -	ret = ad7280_read_reg(st, chan->address >> 8,
> +	{
> +		guard(mutex)(&st->lock);
> +		ret = ad7280_read_reg(st, chan->address >> 8,
>  			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
> -	mutex_unlock(&st->lock);

Not this.  For this case you scoped_guard() or just take the view
that it doesn't matter if we hold the lock a bit longer.


> +	}
>  
>  	if (ret < 0)
>  		return ret;
> @@ -551,11 +551,10 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
>  	if (val > 31)
>  		return -EINVAL;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  	ret = ad7280_write(st, chan->address >> 8,
>  			   (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG, 0,
>  			   FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
> -	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }
> @@ -737,7 +736,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
>  	if (val2 != 0)
>  		return -EINVAL;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  	switch (chan->type) {
>  	case IIO_VOLTAGE:
>  		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
> @@ -760,8 +759,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
Just above this is:
			if (ret)
				break;

Make that
			if (ret)
				return ret;

and same for other such breaks on error.


>  			st->cell_threshlow = value;
>  			break;
>  		default:
> -			ret = -EINVAL;
> -			goto err_unlock;
> +			return -EINVAL;
>  		}
>  		break;
>  	case IIO_TEMP:
> @@ -785,18 +783,12 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
>  			st->aux_threshlow = value;
>  			break;
>  		default:
> -			ret = -EINVAL;
> -			goto err_unlock;
> +			return -EINVAL;
>  		}
>  		break;
>  	default:
> -		ret = -EINVAL;
> -		goto err_unlock;
> +		return -EINVAL;
>  	}
> -
> -err_unlock:
> -	mutex_unlock(&st->lock);
> -
>  	return ret;
maybe with the changes suggested above used throughout we might not
be able to get here with out ret == 0;
In which case make that obvious with
	return 0;

>  }
>  
> @@ -884,14 +876,13 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  
>  	switch (m) {
> -	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&st->lock);
> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&st->lock);
>  		if (chan->address == AD7280A_ALL_CELLS)
>  			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
>  		else
>  			ret = ad7280_read_channel(st, chan->address >> 8,
>  						  chan->address & 0xFF);
> -		mutex_unlock(&st->lock);
>  
>  		if (ret < 0)
>  			return ret;
> @@ -899,6 +890,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
>  		*val = ret;
>  
>  		return IIO_VAL_INT;
> +	}
>  	case IIO_CHAN_INFO_SCALE:
>  		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6_REG)
>  			*val = 4000;

