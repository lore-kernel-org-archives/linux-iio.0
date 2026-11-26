Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660547;
	b=EBnV5xSL39mtT/GRfart5+B1oeCygq2WbQKV+OPs8wF4njDaH/OfaghBkKFp4yrru1cP
	 jygymjHf0LNo7zg0Tyx++LwMbC4ysicg6JD7gdIumd6dskLHbIpT7XAl7intsMKwIjEyU
	 tyG3oAHIBFklUyz3fGoa3ravaRijlwE5Hfy5TJMH7WlRSumkDcNVCUFOv9hnfntlZvgH0
	 obeaEF3mPffuy+YmDYWaEpwgFmKeR0bkJiYVbiXF6WxJleh9XWu+VRI7A+Q3HIAjZiAPf
	 425hxidZ86CAe1v2q2Ms8Pvu4SqISXJ8FUFemeT9MlnfZAwiWJWHEw1l1G+KxJ4Uymw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660547;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=H8xLYvEzN6EZmvIcxD6c+omug0rknIMO4bC7+VX1nRM=;
	b=ZDJBxVm3HATHte0+vDGSjv1V9wLjcuqxcGn1zt18TyOsNx59UgubDqnJhiDlXFV5fsZq
	 lc6rrM6sv6kh5s44kgVT05Tz7Qrg2mcqvXCODgxcD+kzu2BIDKk4Ti5BvDjp7r+avzPmG
	 wU1IuVYIO5R6IjIJukiK9femZ3wE2xXAUgmUrINyUnKyMFAAIEGzUqJkOsfK696E3Z8tZ
	 Nz/U938iOQD0v/4m/+iCX9tMS3etI290Vmg7mV47CeW/1wqXYyfsexUPSvb5De4/3+/pB
	 qqmITmp4iH4M1Ihl7zFuMV6fqujKLGL1eNJqKGls7207EyPo2Ltz5l2sTQFxt+54SMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9YIPYBn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F740606A330;
	Thu, 26 Nov 2026 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9YIPYBn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46411F000D0;
	Thu, 26 Nov 2026 02:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795660546;
	bh=H8xLYvEzN6EZmvIcxD6c+omug0rknIMO4bC7+VX1nRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T9YIPYBntSerqms4pAydovTDuOUyCVrQFvDyLKrVV0KIz08ikTOaLuWUKcr0tJVZq
	 dWM/YjqnF6fo+lpxfOTSzdcA8uYX8JwC7TIVIs1nAWlGA3y0A+siBJ/WmnZGmEOl3J
	 TXTpBevKQ3U27mTwLEx7Bz0BDrmQLI+XdIdaXmLkMk84JjoxdL66+/4J1i/z6RojpB
	 pcJq4gb3UsUstpVzl4qvF3scApxDnga01w8ykMVw8/05uXJi1kWqZb1ClNtJunGkmp
	 d1uTG5pCzm5ZvLesgIOa/HnIIZ6LzAkrf/26Twn4dzX3uTk2QVHzJdyZJX4ARFq2hb
	 ZGXUIu7iY1mdg==
Date: Thu, 26 Nov 2026 02:35:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Cc: robertijtsma@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: add ams OSRAM TCS3430 XYZ and ambient
 light sensor driver
Message-ID: <20261126023540.35016e71@jic23-hlaptop>
In-Reply-To: <20261124-iio-tcs3430-v1-2-0f2a38a6a4c1@gmail.com>
References: <20261124-iio-tcs3430-v1-0-0f2a38a6a4c1@gmail.com>
	<20261124-iio-tcs3430-v1-2-0f2a38a6a4c1@gmail.com>
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

On Tue, 24 Nov 2026 23:46:58 +0100
Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org> wrote:

> From: Robert Ijtsma <robertijtsma@gmail.com>
> 
> Add an IIO driver for the ams OSRAM TCS3430 ambient light and CIE 1931
> XYZ tristimulus color sensor (found at I2C address 0x39 on devices such
> as the Microsoft Surface Pro X).
> 
> The driver exposes:
> - Illuminance (photopic Y channel) with raw counts and lux scale
> - Modified intensity channels for X, Y, Z, and IR1
> - Selectable hardware gain (1x, 4x, 16x, 64x, 128x) and integration time

So hardware gain has an interesting history. It isn't the interface that
should be used to control the gain of a sensor like this.  For that
_scale should be used.  Hardware gain is pretty much only for the
weird corner where the thing you are adjusting the gain on is not actually
what you are measuring.  Time of flight sensors are the main user.

I have let in drivers that use it as a read only parameter + there
might be one or two others where I missed it being used as the control.

Scale well predates it in the ABI so is what userspace software
is more likely to expect.

I appreciate that it can feel a little tricky when we also have
integration time scaling in the mix.  There is a helper
library that can make this easier in drivers/iio/industrialio-gts-helper.c

I haven't thought hard about whether that applies well in this
particular case.

Otherwise, just some quick comments below.


> - Regulator management and system sleep suspend/resume support
> 
> Tested on Microsoft Surface Pro X SQ2 (SC8180X).
> 
> Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>

> diff --git a/drivers/iio/light/tcs3430.c b/drivers/iio/light/tcs3430.c
> new file mode 100644
> index 0000000..138c8ab
> --- /dev/null
> +++ b/drivers/iio/light/tcs3430.c

> +
> +static int tcs3430_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct tcs3430_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		guard(mutex)(&data->lock);

I'll assume you fix the scope issues already point out.

> +		ret = i2c_smbus_read_word_data(data->client, chan->address);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE: {
> +		u32 itime_us = TCS3430_DEFAULT_ATIME_CYCLES * TCS3430_ATIME_STEP_US;
> +		u64 scale_nano;
> +		u32 rem;
> +		int gain;
> +
> +		scoped_guard(mutex, &data->lock)

Given the maths is quick, I'd just hold the lock for the remainder of the
function.
		guard(mutex)(&data->lock);

> +			gain = tcs3430_gains[data->gain_idx];

> +
> +		scale_nano = div_u64(TCS3430_LUX_FACTOR * NSEC_PER_SEC * USEC_PER_MSEC,
> +				     (u32)gain * itime_us);
> +		*val = div_u64_rem(scale_nano, NSEC_PER_SEC, &rem);
> +		*val2 = rem;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	}

> +
> +static int tcs3430_write_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct tcs3430_data *data = iio_priv(indio_dev);
> +	unsigned int i;
> +
> +	if (mask != IIO_CHAN_INFO_HARDWAREGAIN || val2 != 0)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(tcs3430_gains); i++) {

	for (unsigned int i = 0;
is fine and saves a line.

> +		if (tcs3430_gains[i] == val) {
> +			guard(mutex)(&data->lock);
> +			return tcs3430_apply_gain(data, i);
> +		}
> +	}
> +
> +	return -EINVAL;
> +}

