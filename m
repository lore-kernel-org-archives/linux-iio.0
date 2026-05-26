Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3B222590;
	Tue, 26 May 2026 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800278; cv=none; b=URKsTMPesIP2V0EpSrAGNgFQ6VXVBk+Ud7T6CjYhhQozaEuphRO3S40dubJsfqfey83QBLkNdZgHuwrMniWDOoTrGmD0o4PYhBypSiQZDb7lPDN1apc7/lhSBExI7+o4vGNiMLU+nnfazg3cA+v0X29BC2kL34q0cHLtBFo/3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800278; c=relaxed/simple;
	bh=M1V7AnnJ3A8SDM6CIn2SHxy7T+YaUQh1OMM1HNfKRx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVEfv3gBO9uXzt3I+PMu5g5sKo3nlLe7LZRfg3xCrVDHGxjNSBf5QtVcqSmgJZyuDPjfZEWGasGa/7JDu9qzrgGmav/DRRPkofFjL6nL0fHeZCJQ9pdoKF//Ja0b6xdbuAmC0RI0OCJ8Myw3J184XyOQbUt++Q3MpK7H6uweybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVaqo1cu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVaqo1cu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B121F000E9;
	Tue, 26 May 2026 12:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779800276;
	bh=y3PWhORBiHLhpLJN5Gqj7oJl3xVXekVN4sqdvdQuuRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gVaqo1cu6lWfXnkUT7O28heDKL0B1T528VyHqmiNJRtXEWLX13RfKzNSggsOJsvEs
	 RoNRspw2PVe6z0iz+3ZrTR6cvqCqmt01zAJSWDIv3TWUgt3+iojHYjFXilvSYl5fYr
	 FHZ6kFnE3/f6k6tIgg7owBBKgbOM92m4F3cdPSvfBG9I8Qp/I2B0tkZ6hl/fvU6wf5
	 bkX0OFQQvono/2P0Kkh6YwnTQe4wkEj5YinG1fHn6a46bq5eO/ZeUP5xJvR6YVhRvT
	 YCSkk+n8eU9F4jkOOCHzCJFC8gaIvYF2eNXx+Otq1qL6jkEYscFuuxmLWVU+dpS/wT
	 GGOEU4Dtfx7VA==
Date: Tue, 26 May 2026 13:57:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 3/8] iio: tcs3472: convert remaining locking to
 guard(mutex)
Message-ID: <20260526135747.230b7a6d@jic23-huawei>
In-Reply-To: <20260522123420.45495-4-aldocontelk@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
	<20260522123420.45495-4-aldocontelk@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


>  
>  static irqreturn_t tcs3472_event_handler(int irq, void *priv)
> @@ -445,16 +433,16 @@ static int tcs3472_powerdown(struct tcs3472_data *data)
>  	int ret;
>  	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
>  					data->enable & ~enable_mask);
> -	if (!ret)
> -		data->enable &= ~enable_mask;
> +	if (ret)
> +		return ret;
>  
> -	mutex_unlock(&data->lock);
> +	data->enable &= ~enable_mask;

Hi Aldo,

I'm going to comment on a similar (but worse) case in review of patch 8.
If you do rework that to avoid falsely setting cached state that we can't
rely on being right, you could switch to using a local variable here.

	u8 enable = data->enable & ~(TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON);

	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, enable);
  	if (ret)
		return ret;

	data->enable = enable;

	return 0;

(similar for other cases).  Given it's unrelated to what you are doing here
that doesn't stop me picking up this patch as is.

I'm working through the series, but so far 1-3 applied to the testing branch
of iio.git.

Thanks,

Jonathan


> -	return ret;
> +	return 0;
>  }
>  
>  static int tcs3472_probe(struct i2c_client *client)
> @@ -583,16 +571,16 @@ static int tcs3472_resume(struct device *dev)
>  	int ret;
>  	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
>  		data->enable | enable_mask);
> -	if (!ret)
> -		data->enable |= enable_mask;
> +	if (ret)
> +		return ret;
>  
> -	mutex_unlock(&data->lock);
> +	data->enable |= enable_mask;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(tcs3472_pm_ops, tcs3472_suspend,

