Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7F13815F3;
	Fri, 15 May 2026 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874283; cv=none; b=A4YYc8mQ9iECRIEnybIbet6QhQ+NO5ZFw/2tLeXb6pD8GdXZLfms5lJF+CgHlvxlVkDLKKy287djysvopZFgX1ClBFZJOIlghnS6nwErXZO4bPbZbvlDR6YnW0vpCDJy/RYSRqyhda9Cc5DZWkqrt0l99y0CJjWvfhvWMoMEceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874283; c=relaxed/simple;
	bh=rzrlAISMn/eiteqlbQ00LvCAczT91++vuO6hzroHa/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naaz71M5zvpST6toop/xKBuhfLQ6WLjuTT6xC0ifE3AjoCsV85FpnAO1x26zruyAYUjcwzMf/WXr8MCaxgKsT4Xo3M+E1uJsduaqdQflWvJ96PFIp8J/CnG9X+Ct8fW3U+99mvp66xlOiN7LktZTEzNvReb8RulNuwxWwvikqhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2uTVscz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2uTVscz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BBCC2BCC7;
	Fri, 15 May 2026 19:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874283;
	bh=rzrlAISMn/eiteqlbQ00LvCAczT91++vuO6hzroHa/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z2uTVsczQWMV6c1ohqiAdqFoLZdssdhOUCgDkZ+7vrBBofggRtaJM3fubHHFspJsf
	 zspbZWA7X89uG7bZW9HLy3nMhU0GY2LMxEW4OgECv8c2r0E2SH5hJTDTTFEXvqpqQ8
	 6IP/Rp3EiZmRWg5Lgysr6CIbPS8WNXjbY2ivRaxW/mCfcHMXiiL6tqC22NjVo9SZ/D
	 mXbpA1JMNdL3kM44ybH4EPNbasU3PVQQVCBCS8CDmDAmq6LbvkXELvYlUiNO92sMH0
	 7RKGzYdzcpivjjuHpXOvXokYp1kja3EjujEQA+XpERY0CRHiw4lPB47GsZzOLfwT/1
	 6IJnyS5peoQ+w==
Date: Fri, 15 May 2026 20:44:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V7 10/11] iio: imu: inv_icm42607: Add Gyroscope to
 icm42607
Message-ID: <20260515204433.3ddbe884@jic23-huawei>
In-Reply-To: <20260515130018.237378-11-macroalpha82@gmail.com>
References: <20260515130018.237378-1-macroalpha82@gmail.com>
	<20260515130018.237378-11-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 08:00:15 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add gyroscope functions to the icm42607 driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris last one I'm getting to today...


> @@ -499,9 +512,10 @@ int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st)
>  int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
>  				     unsigned int count)
>  {
> +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(st->indio_gyro);
>  	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
>  	struct inv_sensors_timestamp *ts;
> -	s64 accel_ts;
> +	s64 gyro_ts, accel_ts;

Most of what sashiko got matched the earlier accelerometer driver but this
is a good catch.  you never initialize gyro_ts unlike accel_ts:

	accel_ts = iio_get_time_ns(st->indio_accel);

>  	int ret;
>  
>  	accel_ts = iio_get_time_ns(st->indio_accel);
> @@ -513,6 +527,14 @@ int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
>  	if (st->fifo.nb.total == 0)
>  		return 0;
>  
> +	if (st->fifo.nb.gyro > 0) {
> +		ts = &gyro_st->ts;
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
> +		ret = inv_icm42607_gyro_parse_fifo(st->indio_gyro);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (st->fifo.nb.accel > 0) {
>  		ts = &accel_st->ts;
>  		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);

