Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795833217;
	b=azErF5lOTHA+T3Fk7IyiQwVve4sg+herAIU9dYGxy3z8NOy5EFcSdA8GK4DpAFzytO7i
	 Ivvz6QVZsf2Os1VHKhDqOKhouwifgGsXCMNssqFZK9r2VZ8TwCXTdHWuZPbLxTsJbDCYi
	 2wgAUvKx+NSTjkXQY/WRq953ujsEsPY+wZWR8Zg6voCCtoJWFR7cvrBljacaG8hdfOWD4
	 zD0hRxVW92joaBrK+iLjhvNzv0XSif8CubV+i10xYY+kOYxtqbzaQeqs4+Yxsb0rZkSFJ
	 Bp2iMQr+2sPNkf2qDX390o+rywh892k7HzVmwol2L2hI+cX5gKMlf92kf0MvOWxPazg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795833217;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8auMlamrtMjVlgacbgikZGn2a5GvMMBHqeONTcWM4EA=;
	b=Zff7/6YDzlxOoBeA+5MV5tneWlamuJVriyNcDj6/1zmk32Fi19eEs8i2GwgF1t1dX8Bx
	 7rvpiHqiiiBuT9qlL/o1XqClsFd/t+aPDuNxvwNcXejYU8s7acX88Z3oSnowgWRUAZQXX
	 xuDscgFkHlBEX6JPwLTS334WRE/wAisK+cARaW2ZnthZvfYRLkLGJvCDPEvWYpeerlQUP
	 08n9M4NOMOi2jwWPeMUj5KPXxGOhi9O6+ihtPWLYXGYUCQcj1TlelKc5YQFNihh3PEboB
	 44UHY4CnGWSR09drlyxY7ouKrDgNu5l6HcyRfyxEHq6rk0v8q3Pbr4n8pzyy4RC0rXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UuT+PvST;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDC606A31F;
	Sat, 28 Nov 2026 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UuT+PvST
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAAA1F000C1;
	Sat, 28 Nov 2026 02:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795833216;
	bh=8auMlamrtMjVlgacbgikZGn2a5GvMMBHqeONTcWM4EA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UuT+PvSTJfBSMzu9xcK6TkXcffGKa3KQ03B5tBdBQbv7TxalXTg1Ulg1AF64uboFW
	 3NeEfl+LBegM3ykALxhzunPVaA0zZlxEz5+s0uCNKGE2UrZXXM9ocAQsI7e7Z/AD+O
	 5CjGHImmKcw9Z5FLzXMwk+TWYs8W+8qH5xKZM+ReosVhZNdaeqEB4LWPigUKzBxC0U
	 Y1iizpkVsCDzhh9n6cc4eKHF4eXnGjyFoc9NOXKq3UEFckOQlVZwKyseZ1K5SSp8Hc
	 QdcSGpguCdOgtxleT0pxOEjTlTA4tYxAPhj05T74Eo9ZlmYe21WJOdn87RqKBtv6HH
	 uyjxrhim5TTjQ==
Date: Sat, 28 Nov 2026 02:33:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Romain TISSERAND <romain.tisserand@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 4/4] iio: adc: Add the PocketGo S30 analog stick MCU
Message-ID: <20261128023333.5873929d@jic23-hlaptop>
In-Reply-To: <20261127012612.1589039-5-romain.tisserand@gmail.com>
References: <20261127012612.1589039-1-romain.tisserand@gmail.com>
	<20261127012612.1589039-5-romain.tisserand@gmail.com>
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

On Fri, 27 Nov 2026 02:26:12 +0100
Romain TISSERAND <romain.tisserand@gmail.com> wrote:

> The PocketGo S30 handheld (Allwinner A33) reads its analog stick through
> a microcontroller at address 0x60 on i2c0. A four-byte read returns the
> two raw 8-bit potentiometer readings, each followed by its complement:
> 
>   <a> <~a> <b> <~b>
> 
> The value and its complement appear to come from consecutive samples:
> they differ by a count or two at rest and by more while the stick moves
> fast. With an exact check, about one read in four is rejected, and
> about 4% still fail after three tries when polled as adc-joystick does.
> The stock driver uses an exact check and silently drops such frames.
> Accept a difference of up to 2 instead and read again, up to three
> times, beyond it or on a bus error (the MCU occasionally NACKs its
> address): over 2 x 6000 reads at rest and moving, none failed and under
> 2% needed a second try.
> 
> Add an I2C driver that exposes the two readings as raw IIO channels, so
> that adc-joystick can read the stick in polled mode. Each channel read
> fetches a fresh frame.
> 
> Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
Hi Romain,

A few minor things inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/pocketgo-s30-stick.c b/drivers/iio/adc/pocketgo-s30-stick.c
> new file mode 100644
> index 000000000000..09a60cb307d9
> --- /dev/null
> +++ b/drivers/iio/adc/pocketgo-s30-stick.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PocketGo S30 analog stick MCU
> + *
> + * The MCU samples the two stick potentiometers and answers an I2C read of
> + * four bytes with the raw 8-bit readings, each followed by its complement:
> + *
> + *   <a> <~a> <b> <~b>
> + *
> + * The value and its complement appear to come from consecutive samples:
> + * they differ by a count or two at rest, and by more while the stick moves
> + * fast, so an exact check would drop about one read in four. Accept a
> + * difference of up to S30_STICK_TOLERANCE and read again beyond it. The
> + * readings are exposed as two IIO channels, for adc-joystick.
> + */

I'd guess this is swapping ends of the pot to detect shorts or broken connections?
That has to be on consecutive samples.

> +
> +#define S30_STICK_RETRIES	3
> +/* largest accepted difference between a reading and its complement */
> +#define S30_STICK_TOLERANCE	2
> +
> +/* signed distance of a + b from 0xff, -255..255 */
> +static int s30_stick_mismatch(u8 a, u8 b)
> +{
> +	return a + b - 0xff;
> +}
> +
> +static int s30_stick_read(struct i2c_client *client, u8 *val)
> +{
> +	u8 buf[4];
> +	int i, ret = -EIO;
> +
> +	for (i = 0; i < S30_STICK_RETRIES; i++) {

	for (unsigned int i = 0; ...)

> +		ret = i2c_master_recv(client, buf, sizeof(buf));
> +		if (ret != sizeof(buf)) {
> +			if (ret >= 0)
> +				ret = -EIO;
> +			continue;

Does this actually happen?   It is fairly unusual for a recv to
fail. 

> +		}
> +
> +		if (abs(s30_stick_mismatch(buf[0], buf[1])) > S30_STICK_TOLERANCE ||
> +		    abs(s30_stick_mismatch(buf[2], buf[3])) > S30_STICK_TOLERANCE) {
> +			ret = -EIO;
> +			continue;
> +		}
> +
> +		val[0] = buf[0];
> +		val[1] = buf[2];
> +		return 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static int s30_stick_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int *val,
> +			      int *val2, long mask)
> +{
> +	struct i2c_client *client = iio_device_get_drvdata(indio_dev);

Prefer that the client is embedded in the iio_priv().  That is a lot
more flexible than using the iio_device drvdata.
Currently you have set the size of that to 0.  Instead provide
a structure for any state you need for the driver.


> +	u8 v[2];
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	ret = s30_stick_read(client, v);
> +	if (ret)
> +		return ret;
> +
> +	*val = v[chan->channel];
> +	return IIO_VAL_INT;
> +}

> +
> +static const struct of_device_id s30_stick_of_match[] = {
> +	{ .compatible = "miyoo,pocketgo-s30-stick" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, s30_stick_of_match);
> +
> +static const struct i2c_device_id s30_stick_id[] = {
> +	{ "pocketgo-s30-stick" },

Sashiko got this.  Named initializers for these structures.
There is some rework going on that will shortly require them.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, s30_stick_id);
