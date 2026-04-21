Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A7B3D902E
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783000; cv=none; b=IbpGf4M7Ny+WqzGeU1Xv+LCdZcPa86tNU10DA582Gisx/dygQEPzrV0OqjG/z1KTwDP6UlGZnoe1LGuUCHtHh35BO0VXi7uZXDAiocz7JY+NZwc/jLs6VPpyIN3L6viWYNLJvudxX9yv88GvowTeMCntSl+9uQaOXUQduHK0ZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783000; c=relaxed/simple;
	bh=PrL5mq8synLEqVGxMH4/wOKYi5FgKI1OA09m3Ym3+Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WO+Wo3LqCdmBzZAAQjGTrjYA8QxWrEDcNFZV5IYEQ8c+hrf/YqDaalwrKO+2pa82kRSDdLCMJhgn5SMlINaUNCnQCf6AecH46H8maGqWAWDjSac5rQE7NDZQUuBzFlWE2FjQw62jF3dpLN1cf/EGw+0+lUH90RgM9gbngZAqNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3voDJz9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3voDJz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D874FC2BCB0;
	Tue, 21 Apr 2026 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776783000;
	bh=PrL5mq8synLEqVGxMH4/wOKYi5FgKI1OA09m3Ym3+Dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V3voDJz9s9Nv+Yup3OTmukM1eXrdw0Y15S1ElxH+qjOzzne/Dv7pSrHlnRMMXb9ez
	 e7x10oEdJr0CwJ/LvkF5bf6MhgataTyZt55yNKUPMYIYdGCvYW5Pob+aVltBQqOEww
	 f9AH/Qbdrnu32dUrk8/8NpfdNTuxmZUHlIY7MCVw8lOFlbgbN6XZ2i6h1wp11EMjVB
	 ULnJdn42GcMq1Yo6ELfcHk/QIBu4KrEBwkInLt2NHVWFfdr4VPkP9ztT1OV+3Himr9
	 73f1AlYJmRtKaozddlS2Nz1MxUprYBxLrG2Vcu6MkubfOMPAH63JOuE6uxcAkPzk6u
	 qLMQeApCK+dKg==
Date: Tue, 21 Apr 2026 15:49:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Raffael Raiel Trindade <raffaelraiel@usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Kim Carvalho
 <kim.ca@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: vcnl4000: use lock guard()
Message-ID: <20260421154952.5784d2bb@jic23-huawei>
In-Reply-To: <20260420200047.102159-1-raffaelraiel@usp.br>
References: <20260420200047.102159-1-raffaelraiel@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 16:59:33 -0300
Raffael Raiel Trindade <raffaelraiel@usp.br> wrote:

> From: Raffael Raiel Trindade <raffaelraiel@usp.br>
> 
> Use guard() for handling mutex lock instead of manually locking and
> unlocking. Remove gotos in error handling logic. This prevents forgotten
> locks on early exits.
> 
> Signed-off-by: Raffael Raiel Trindade <raffaelraiel@usp.br>
> Co-developed-by: Kim Carvalho <kim.ca@usp.br>
> Signed-off-by: Kim Carvalho <kim.ca@usp.br>


There are some functions in here where guard() is useful but you haven't
updated. e.g. vcnl4000_measure(), vcnl4040_write_als_it()
vcnl4040_write_als_period() and maybe more.

I don't mind a mix of guard() and non guard() but only when that is
because one approach is better suited to a particular bit of code than the other.
Here it looks like at least some other functions would benefit similar to the
changes this patch makes.

So I'd like a more complete patch.

One other thing inline.

Thanks,

Jonathan




> @@ -1480,13 +1466,13 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
>  	u16 val, mask;
>  	struct vcnl4000_data *data = iio_priv(indio_dev);
>  
> -	mutex_lock(&data->vcnl4000_lock);
> +	guard(mutex)(&data->vcnl4000_lock);
>  
>  	switch (chan->type) {
>  	case IIO_LIGHT:
>  		ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
>  		if (ret < 0)
> -			goto out;
> +			return ret;
>  
>  		mask = VCNL4040_ALS_CONF_INT_EN;
>  		if (state)
> @@ -1495,13 +1481,11 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
>  			val = (ret & ~mask);
>  
>  		data->als_int = FIELD_GET(VCNL4040_ALS_CONF_INT_EN, val);
> -		ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
> -						val);
> -		break;
> +		return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, val);
>  	case IIO_PROXIMITY:
>  		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
>  		if (ret < 0)
> -			goto out;
> +			return ret;
>  
>  		if (dir == IIO_EV_DIR_RISING)
>  			mask = VCNL4040_PS_IF_AWAY;
> @@ -1511,17 +1495,10 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
>  		val = state ? (ret | mask) : (ret & ~mask);
>  
>  		data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, val);
> -		ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
> -						val);
> -		break;
> +		return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
>  	default:
> -		break;
> +		return ret;

		return -EVINAL;

and drop the intialization of ret.

>  	}
> -
> -out:
> -	mutex_unlock(&data->vcnl4000_lock);
> -
> -	return ret;
>  }
>  
>  static irqreturn_t vcnl4040_irq_thread(int irq, void *p)

