Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795832527;
	b=Erlm0UMegZ7a5Ogi0sa7L31LYJUqQMvtKILFSJF19ZO2PcrRimb2+0RW6IbdWkq3WMlb
	 iiOQAQzgsk+YCdLxT9Vt72Px3nsRm5+n1EgI2WxKCnqqBUbIWcRFwy4jE7JNuMtM38eZX
	 UbkRA/wPnbpEbuBvbBcG6C9Br7i4QTu3r6BqhCCS9iA2nxNivHaZAuYU2ghMY6MxkudvQ
	 oiFqyApuci25kHdAt6KcYboGtNWYqcvSwXifaaQiETSw1ymOvazpZ3OQxJEaTO2DQT3Zt
	 +GQ8HLhg8avL8OYKq6BgjnLeSlHDBS9jWdLc3ZLh/XtLIJV0CgxKLRrUNbZ7zCEe97w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795832527;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bA0QuwLrAhavKCx5CEuNn3dlERhJ7ym0sruZEZcGMlc=;
	b=hC1hotEdzTIZoeJFOLXI4chAFEWxd4H/htwhF62Qc75HFBPni0S/WVapFb8VNsAuV7Hy
	 V4ULL4QyDErm0U6xnqKaW3jIJgQhf3guBp5viAf6xjHUTtzy6DktWTph4FSPQ69nR8yCz
	 6lXGQGahjSlsPMdP1SBUNiwJXEjneN9oGpHCTJkjRiAnssLQYNDWqhQlzhhxMTQnvXTIP
	 5iABGX+YtruYh64TqmPYRNxKWoFiZo5ovvtadBm3WTyiGPJvze8nvZSwGLdm02tCYU+pn
	 OMzTCE8bXy8ZW1HH2euw+VnimCTsyIlvACA96UEzSyGazWdA5b3tK+FQPt6coglgt7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aenTreZL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4D606A336;
	Sat, 28 Nov 2026 02:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aenTreZL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696B71F00893;
	Sat, 28 Nov 2026 02:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795832527;
	bh=bA0QuwLrAhavKCx5CEuNn3dlERhJ7ym0sruZEZcGMlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aenTreZLm58F62041X4uLrCM7vBWP4Ae7fB50/6drkuNxp10epAbu795uEv7Yhmjh
	 okLGDc9UgvJgaWIWmJLc9bWcDAY28mN0hzKNjIjL+SzykVuBjBeMv7TgT72HigmMc9
	 a0z26ioUYcNgruAzqLtMLLgzTsaElxecs2Rkl2Ip9p2cqoc0Q/Mx3jPfC0Y2h4O7xe
	 CKD+6Kqyx9jxhiSaj8MY5AeW840R/cQKFshlx20eihnHSCjpwDSECwvHlBJErHsOJz
	 U6vg3QbNJJcixE+PfSmNtdt/nsNVjn7EUErCUkbE+Oq7wnHWlNBMPqcZ/MlnSv5A/7
	 ql4J6DNqXbbCw==
Date: Sat, 28 Nov 2026 02:21:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Romain TISSERAND <romain.tisserand@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 2/4] iio: adc: Add the Miyoo A30 analog stick MCU
Message-ID: <20261128022157.7984a33d@jic23-hlaptop>
In-Reply-To: <20261127012612.1589039-3-romain.tisserand@gmail.com>
References: <20261127012612.1589039-1-romain.tisserand@gmail.com>
	<20261127012612.1589039-3-romain.tisserand@gmail.com>
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

On Fri, 27 Nov 2026 02:26:10 +0100
Romain TISSERAND <romain.tisserand@gmail.com> wrote:

> The Miyoo A30 handheld (Allwinner A33) reads its analog stick through a
> microcontroller on uart0. From power-up it streams frames at 9600 baud,
> about 67 per second:
> 
>   0xff <b0> <b1> <b2> <b3> 0xfe
> 
> b2 and b3 are the raw 8-bit readings of the X and Y potentiometers, the
> ones the stock firmware uses. b0 and b1 also move with the stick, but
> their meaning is unknown, so they are not exposed.
> 
> Add a serdev driver that exposes X and Y as two raw IIO channels. As
> the MCU pushes its readings, each complete frame also goes to a software
> IIO buffer (kfifo) with a timestamp: adc-joystick then takes the stick
> from the buffer, without polling, both axes from the same frame. Direct
> reads return the last complete frame, -EAGAIN before the first one.
> 
> Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
Take a look at what Sashiko noted
https://sashiko.dev/#/patchset/20261127012612.1589039-1-romain.tisserand%40gmail.com
as well as what I have below.

> diff --git a/drivers/iio/adc/miyoo-a30-stick.c b/drivers/iio/adc/miyoo-a30-stick.c
> new file mode 100644
> index 000000000000..d83761558ee7
> --- /dev/null
> +++ b/drivers/iio/adc/miyoo-a30-stick.c
> @@ -0,0 +1,204 @@

> +
> +static size_t a30_stick_receive(struct serdev_device *serdev, const u8 *data,
> +				size_t count)
> +{
> +	struct a30_stick *st = serdev_device_get_drvdata(serdev);
> +	size_t i;
> +
> +	for (i = 0; i < count; i++) {

	for (size_t i = 0; ...

> +		/* resynchronise on the start byte */
> +		if (!st->len && data[i] != A30_STICK_START)
> +			continue;
> +
> +		st->frame[st->len++] = data[i];
> +		if (st->len < A30_STICK_FRAME_LEN)
> +			continue;
> +
> +		st->len = 0;
> +		if (st->frame[A30_STICK_FRAME_LEN - 1] != A30_STICK_END)
> +			continue;
> +
> +		scoped_guard(spinlock, &st->lock) {
> +			st->val[0] = st->frame[3];
> +			st->val[1] = st->frame[4];
> +			st->valid = true;
> +		}
> +
> +		if (iio_buffer_enabled(st->indio_dev)) {

I'm not sure if the fix sashiko has for racing with the demux is
correct... Please look into whether that works.

> +			IIO_DECLARE_BUFFER_WITH_TS(u8, scan, 2) = { };
> +
> +			scan[0] = st->frame[3];
> +			scan[1] = st->frame[4];
> +			iio_push_to_buffers_with_ts(st->indio_dev, scan,
> +						    sizeof(scan),
> +						    iio_get_time_ns(st->indio_dev));
> +		}
> +	}
> +
> +	return count;
> +}

> +
> +static int a30_stick_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int *val,
> +			      int *val2, long mask)
> +{
> +	struct a30_stick *st = iio_priv(indio_dev);
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	guard(spinlock)(&st->lock);
> +	if (!st->valid)
> +		return -EAGAIN;
> +
> +	*val = st->val[chan->channel];

blank line here.

> +	return IIO_VAL_INT;
> +}

> +static int a30_stick_probe(struct serdev_device *serdev)
> +{
> +	struct device *dev = &serdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct a30_stick *st;
> +	unsigned int baud;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->indio_dev = indio_dev;
> +	spin_lock_init(&st->lock);
> +
> +	indio_dev->name = "miyoo-a30-stick";
> +	indio_dev->info = &a30_stick_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = a30_stick_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(a30_stick_channels);
> +	indio_dev->available_scan_masks = a30_stick_scan_masks;
> +
> +	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);

At this point interfaces are all exposed (both to usespace and in kernel).
We normally expect everything to be pretty much fully functioning at that
stage. So not to have to do all the stuff that follows.


> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Open the UART last, so that it is closed first on removal: no frame
> +	 * is pushed to the buffer once the IIO device is going away. Reads
> +	 * return -EAGAIN until the first frame.
> +	 */
> +	serdev_device_set_drvdata(serdev, st);
> +	serdev_device_set_client_ops(serdev, &a30_stick_serdev_ops);
> +
> +	ret = devm_serdev_device_open(dev, serdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot open the UART\n");
> +
> +	baud = serdev_device_set_baudrate(serdev, A30_STICK_BAUD);
> +	if (baud != A30_STICK_BAUD)
> +		return dev_err_probe(dev, -EINVAL, "cannot set %u baud (got %u)\n",
> +				     A30_STICK_BAUD, baud);
> +
> +	serdev_device_set_flow_control(serdev, false);
> +	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot set the parity\n");
> +
> +	return 0;
> +}


