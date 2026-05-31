Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6501F3BAC;
	Sun, 31 May 2026 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780232316; cv=none; b=qtdk6VGrK8HF8stEFlieGg3WvSgpTUIhpiQKq/SFtyZfNrQPNCgeLJ+rcyvhA5ktV2bttFiULoiTAxFSwFtdyj2nTjWkraeyMp8iKSQELVrNuxvB7dftKUWr4hj8NJeh5y5eSdlu3jAj9G34PYdipAunuBQGmrXbblutIwM6Qe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780232316; c=relaxed/simple;
	bh=idAL3HNc/TgMamT2gmTLTexn6as+2ynGuFAnG9iqaQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyElD12CBx4mhkHVKVfBerQo0lOPw3tY2DnnhyFsDfKjaCOUwZ4NtLJ2XmBrYcrtoBRu1o0A6IfGo7IwRBZOwgvBWSlSzinUbxrNGLMtvSQkA4JZM/+Ex5zCDGzAu5W/cVhpMCDyLVOmIFlWfGH3JUXGc3jE/9Zoc2l2dO1B5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVDOQFS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVDOQFS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABBA1F00893;
	Sun, 31 May 2026 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780232314;
	bh=+CA+v+FUWBPtZ6XNzVlGy534etJ1KYmo7MXS0bn/j60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hVDOQFS8dc7teV5JeOSXzM8E0IQI6FyFRlxFE+w6jLBdeDMRe5fD24yI7nzMnrQ/b
	 Sf1AJTkWEn+Abe/wJFBb0x24PbDYy3rcCufnMmGk7UALjKQRgKu1V3EZn8mvafsfoI
	 f7iPEdEY6+fOy86hueb9Jeo3G63dRKEGuTS9xsf2AU5GWP0j0MbEZZ9Sq0stTHsQAn
	 X8lzdjnejJ5n0dYx9okjyPVGYImAw7FKBPTCo4ZBKHhvi0I85wRY2apE1uM+DVMv84
	 8MkhEX/iz7Ko0HIWQ8SHtUT0OcVfa12cSGx6/25xfbYRW02fJV08I1ZrQuQsxDfuC1
	 S/Bfu8tRRf2tg==
Date: Sun, 31 May 2026 13:58:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V9 10/11] iio: imu: inv_icm42607: Add Gyroscope to
 icm42607
Message-ID: <20260531135823.015c4fd1@jic23-huawei>
In-Reply-To: <20260530031739.109063-11-macroalpha82@gmail.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
	<20260530031739.109063-11-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 22:17:37 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add gyroscope functions to the icm42607 driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Hi Chris,
Various things inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> index 5b69bf895b35..c45239613344 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c

>  int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st)
>  {
> +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(st->indio_gyro);
>  	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
>  	struct inv_sensors_timestamp *ts;
>  	int ret;
> @@ -491,6 +494,16 @@ int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st)
>  	if (st->fifo.nb.total == 0)
>  		return 0;
>  
> +	/* handle gyroscope timestamp and FIFO data parsing */
> +	if (st->fifo.nb.gyro > 0) {
> +		ts = &gyro_st->ts;
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_gyro,
> +						st->timestamp.gyro);
> +		ret = inv_icm42607_gyro_parse_fifo(st->indio_gyro);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/* handle accelerometer timestamp and FIFO data parsing */
>  	if (st->fifo.nb.accel > 0) {
>  		ts = &accel_st->ts;
> @@ -507,12 +520,14 @@ int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st)
>  int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
>  				     unsigned int count)
>  {
> +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(st->indio_gyro);
>  	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
>  	struct inv_sensors_timestamp *ts;
> -	s64 accel_ts;
> +	s64 gyro_ts, accel_ts;
>  	int ret;
>  
>  	accel_ts = iio_get_time_ns(st->indio_accel);
> +	gyro_ts = iio_get_time_ns(st->indio_gyro);

Sashiko calls out correctly that there is a race with devices finishing
coming up that might be hit here.  Probably need some sort of presence
check and locking to be sure those are both valid.



>  
>  	ret = inv_icm42607_buffer_fifo_read(st, count);
>  	if (ret)


> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> new file mode 100644
> index 000000000000..8d59156086b1
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c

> +
> +static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
> +	{ },
No comma. Check for any other commas after terminating entries like this one.
> +};


> +
> +int inv_icm42607_gyro_parse_fifo(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts = &gyro_st->ts;
> +	ssize_t i, size;
> +	unsigned int no;
> +	const void *accel, *gyro, *timestamp;
> +	const s8 *temp;
> +	unsigned int odr;
> +	s64 ts_val;
> +	struct inv_icm42607_gyro_buffer buffer = { };
> +
> +	guard(mutex)(&st->lock);
Sashiko thinks there is a deadlock here as this lock will already
be held.  Report looks correct to me + same bug in the accelerometer case.

I'm surprised you didn't see them in testing as deadlocks tend to be obvious!


> +
> +	/* parse all fifo packets */
> +	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
> +		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
> +				&accel, &gyro, &temp, &timestamp, &odr);
> +		/* quit if error or FIFO is empty */
> +		if (size <= 0)
> +			return size;
> +
> +		/* If the packet size could cause us to overflow, return. */
> +		if (i + size > st->fifo.count)
> +			return -EIO;
> +
> +		/* skip packet if no gyro data or data is invalid */
> +		if (gyro == NULL || !inv_icm42607_fifo_is_data_valid(gyro))
> +			continue;
> +
> +		/* update odr */
> +		if (odr & INV_ICM42607_SENSOR_GYRO)
> +			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
> +							st->fifo.nb.total, no);
> +
> +		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
> +		/* convert 8 bits FIFO temperature in high resolution format */
> +		buffer.temp = temp ? (*temp * 64) : 0;
> +		ts_val = inv_sensors_timestamp_pop(ts);
> +		iio_push_to_buffers_with_ts(indio_dev, &buffer,
> +					    sizeof(buffer), ts_val);
> +	}
> +
> +	return 0;
> +}

