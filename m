Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B28405C57;
	Sat, 16 May 2026 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778936512; cv=none; b=Z/3coPzoccSjsVmggJOPgU55QAIl54fZqq9mhowBkV7TZrdNj6oDvogAHKNlvygMSlTcRJvcE8iPRlt7rnka772+o2BhX2U1Ezo90kDusH9ftGXB43nR2O+Zo1xahW95Dwnfdqr6JStQkHOLDTvzvh4RZqa4m/wA6eg8PKEUvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778936512; c=relaxed/simple;
	bh=XcifK5nGNmsXQauC6qo+kFAgrF4alDihhzhbvueaeZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAgzZwn6yzlQ59tJsEk5ilwUjFTmVFC3OhR8ycReSdX8QGfjEn/T4SgtSlY2iwWE1B1dkQR18IQkndHX0wbjBNdABdjB1a7HRindqjeYiDCCk8lgdappu+b6ebSaj99oDuhVIKIEn/N1L3LJdRukO05MiPhrKIb9SbQaamDeMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulf90Uvq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulf90Uvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620F3C19425;
	Sat, 16 May 2026 13:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778936512;
	bh=XcifK5nGNmsXQauC6qo+kFAgrF4alDihhzhbvueaeZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ulf90UvqhqnYlgDhhu9sl41FEllIOx7TaICLPFBhLuS7aGyISSqKAsn/5dPBOuaUv
	 C/fC1W5GU+UZ/4TOAjVJTmY+ZPLpr3Jw21jo4ZNbJ9KmIEuiX76B5pDE4S+/MFwj/2
	 Gr+vVy2XWLHWXJ8A4Ybw+evTxQKOYN1ly89p/TTbfED1rqUB9VQSn7SEulhMxPVtCJ
	 ojMJlWBfGXYgrI4OkrymhDRxcGs/LTWwxcW6sYSH1dz5ztzD3yJfZCvGIZpYYNHPrm
	 blCx6JPfnAkUZkWNG1v8g1d1YQRFPVuPAQArV8z6HeLvmHGs7VT90AbNoai7efvxtq
	 6sVZimBdoEDiQ==
Date: Sat, 16 May 2026 14:01:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v6] iio: imu: kmx61: Use guard(mutex)() over manual
 locking
Message-ID: <20260516140143.13f420c4@jic23-huawei>
In-Reply-To: <20260513020654.168071-1-m32285159@gmail.com>
References: <20260513020654.168071-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 21:06:54 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Include linux/cleanup.h to take advantage of new macros.
> 
> Replace manual mutex_lock() and mutex_unlock() calls across the file
> with guard(mutex)() and scoped_guard() where appropriate to simplify
> error paths and eliminate manual locking calls.
> 
> Add new helper function kmx61_read_for_each_active_channel() to mitigate
> certain style issues and to prevent notifying that the IRQ is finished
> whilst holding the lock.
> 
> Update certain returns, and add default case to return -EINVAL in
> kmx61_read_raw().
> 
> Remove now-redundant gotos and ret variables, as the new RAII macros
> make them unneeded.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
A couple of trivial things.

Thanks,

Jonathan

>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_ACCEL:
> @@ -834,41 +831,41 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
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
> +	default:
> +		return -EINVAL;
>  	}
> -	return -EINVAL;
> +
No blank line needed.
>  }

> @@ -1051,8 +1045,6 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  		data->mag_dready_trig_on = state;
>  	else
>  		data->motion_trig_on = state;
> -err_unlock:
> -	mutex_unlock(&data->lock);
>  
>  	return ret;
Can we get here with non 0?  If not
	return 0; to make that visually obvious.

>  }
> @@ -1181,30 +1173,52 @@ static irqreturn_t kmx61_data_rdy_trig_poll(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t kmx61_trigger_handler(int irq, void *p)
> +/**
> + * kmx61_read_for_each_active_channel - Read each active channel into a buffer
> + *
> + * @indio_dev: IIO Device struct to read from
> + * @buffer: Destination buffer to write to, the array must be of at least size 8
> + *
> + * Intended only for use in kmx61_trigger_handler().
> + *
> + * Return:
> + * 0 on success, negative errno on failure.
> + */
> +static int kmx61_read_for_each_active_channel(struct iio_dev *indio_dev, s16 *buffer)
>  {
> -	struct iio_poll_func *pf = p;
> -	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct kmx61_data *data = kmx61_get_data(indio_dev);
> -	int bit, ret, i = 0;
>  	u8 base;
> -	s16 buffer[8] = { };
> +	int ret, bit;
> +	int i = 0;
>  
>  	if (indio_dev == data->acc_indio_dev)
>  		base = KMX61_ACC_XOUT_L;
>  	else
>  		base = KMX61_MAG_XOUT_L;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
> +
>  	iio_for_each_active_channel(indio_dev, bit) {
>  		ret = kmx61_read_measurement(data, base, bit);
>  		if (ret < 0) {

No brackets needed any more.

> -			mutex_unlock(&data->lock);
> -			goto err;
> +			return ret;
>  		}
>  		buffer[i++] = ret;
>  	}
> -	mutex_unlock(&data->lock);
> +
> +	return 0;
> +}

> @@ -1419,22 +1433,18 @@ static void kmx61_remove(struct i2c_client *client)
>  		iio_trigger_unregister(data->motion_trig);
>  	}
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
> +
>  	kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
> -	mutex_unlock(&data->lock);
>  }

>  static int kmx61_resume(struct device *dev)
> @@ -1453,13 +1463,10 @@ static int kmx61_resume(struct device *dev)
>  static int kmx61_runtime_suspend(struct device *dev)
>  {
>  	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));

I'm a bit surprised there are any of these left. I thought we'd switched
them all for
	struct kmx61_data *data = dev_get_drvdata(dev);

To avoid going in circles. 

Ah well, job for another day!



> -	int ret;
>  
> -	mutex_lock(&data->lock);
> -	ret = kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
> -	mutex_unlock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
> -	return ret;
> +	return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
>  }
>  
>  static int kmx61_runtime_resume(struct device *dev)

