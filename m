Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973736;
	b=zLTwW+VK/yTGAqS8MDoXv0syCCCZrblPkC5/syQUe5BOAlkDlrABTsRbeUQQYc7Asw7F
	 RtFUFHEDolkNDoUQ3AumfxU+yzDQEvYusTIC5v1P15Aj1qVqtqORstG+iKy+e5pb5pioZ
	 Cpji8nArIxeUKde+cFE6Zp3wpRmz5VTk5m51sISK4psWqG4QBKEWUIyw95mCxkZec/gS0
	 dpVT/3v7aohMV9AIzyOXtcQen1X1Pogj3Pyom4LNGQaKlnBapR1tY9uxH/+tjnPkf/HvP
	 bKrq3P0Mc8z/oAm3Heu7F4NUSscBVyzJ7EoBAqiH5520J4ixoSgYu0PiV5QpkqWsuLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973736;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4miLNdmTCLRRbyZStSHRrLrP4dgFhOGAixFj2EYVbOs=;
	b=lNF1tPBG7GpDDQfFPwcnyrajAL3HYdSw1f4l4SxHunLeKDYDT3Oqc7uVHx+f8VIdW46f
	 xoNYsJIs18adMqiLuT9Aql42MVeAJ40t5px/8UvzOcDIO87scmnZ0knHOBGOoTa6B68Ic
	 UyQR7cINnmL0uixKBH8rv0u27P/5jCh8PwamM+8BS+d+S0w3KTISrs2a9vl1EzCvvIJwu
	 gk/86NkN06hezqjzJqyRWv06rYw2AlG5XRXBJBs7Haf3v5Re5SscmAOHwirlNpUK0bf+J
	 eXnKTirHi6/SyTrbt3mXxbWrsyx5hlqpmdbPF6EQXNF5uN7Xyd75iadKpLaMDu4soZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TRQ/3KML";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2384606A31A;
	Mon, 26 Oct 2026 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRQ/3KML
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AE31F01825;
	Mon, 26 Oct 2026 00:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792973735;
	bh=4miLNdmTCLRRbyZStSHRrLrP4dgFhOGAixFj2EYVbOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TRQ/3KML6Rh1/J4tthZlYjCZgRp7rCtxofShMv0RG6GKs8eqlzK5eVD7cwoF5CZWs
	 XR19KreUETCf7SPTyIbLnVt4eiTkG0fkTE0iT7xZ9TyiIZp5IWwKOuSTn2gHsS3F1u
	 8HrdOCpnYQqZe2TQck57bO80GLCrAU2ecvusuQgZIedA9CO/guX5XeLrZkfrfoYfVS
	 ukQa+I/vQEcSDCIwspBR5UEqREld0AwOJeNM56ZUKgaQdJX0k4UgWBQURQai49M9Vc
	 ZHIJhoZR0We4cIVHd9ft2UY7n5eBrp6V7+VnhgItFNLrWWG8idg5d6MJGh18VZgadV
	 4UJEUd3JcN8tg==
Date: Mon, 26 Oct 2026 00:15:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v4 8/8] iio: imu: adis16607: Add calibration bias
 support for gyro/accel
Message-ID: <20261026001527.456f2472@jic23-hlaptop>
In-Reply-To: <20261023-adis16607-v4-8-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
	<20261023-adis16607-v4-8-a4d541ebfd13@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 12:30:25 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add IIO_CHAN_INFO_CALIBBIAS support for the gyroscope and
> accelerometer axes, backed by the device's per-axis bias registers
> (XA/YA/ZA_BIAS, XG/YG/ZG_BIAS).
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
I'd missed the use of scan_index in here.  That seems like very
fragile coding to me. Moving over to address is going to require
changes a few patches back.

> +
>  /*
>   * SPI Half-Duplex read operation for ADIS16607.
>   * Protocol:
> @@ -863,6 +878,7 @@ static int adis16607_read_raw(struct iio_dev *indio_dev,
>  			      int *val, int *val2, long info)
>  {
>  	struct adis16607 *st = iio_priv(indio_dev);
> +	const int idx = chan->scan_index;

As below. This to me is hurting readability a little.
Using scan_index for this is a bit fragile anyway as those can
be changed by people expecting them to only about buffered capture.
This should be using address and that may well mean you need that
to become a lookup into an array of multiple register addresses
needed for a given channel rather than directly to one register as
currently.


>  	int ret;
>  	u32 tmp;
>  
> @@ -900,6 +916,16 @@ static int adis16607_read_raw(struct iio_dev *indio_dev,
>  		*val = 5000;
>  		return IIO_VAL_INT;
>  
> +	case IIO_CHAN_INFO_CALIBBIAS: {
> +		u16 tmp16;
> +
> +		ret = adis_read_reg_16(&st->adis, adis16607_calib_bias[idx], &tmp16);
> +		if (ret)
> +			return ret;
> +		*val = sign_extend32(tmp16, 15);
> +		return IIO_VAL_INT;
> +	}
> +
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		ret = adis16607_get_freq(st, &tmp);
>  		if (ret)
> @@ -918,6 +944,7 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
>  			       int val, int val2, long info)
>  {
>  	struct adis16607 *st = iio_priv(indio_dev);
> +	const int idx = chan->scan_index;

I'd just go long on the line that uses this or at least push declaring it
down to the case statement that uses it.

>  	u32 tmp;
>  
>  	switch (info) {
> @@ -925,6 +952,11 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
>  		tmp = val * 1000 + val2 / 1000;
>  		return adis16607_set_freq(st, tmp);
>  
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val < S16_MIN || val > S16_MAX)
> +			return -EINVAL;
> +		return adis_write_reg_16(&st->adis, adis16607_calib_bias[idx], val);
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -934,7 +966,8 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
>  	.type = (_type), \
>  	.modified = 1, \
>  	.channel2 = (_mod), \
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_CALIBBIAS), \
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
>  	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	.address = (_address), \
> 

