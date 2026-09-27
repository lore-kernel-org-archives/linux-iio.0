Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB83515DA;
	Sun, 27 Sep 2026 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790530554; cv=none; b=lnRNpGWw64D5lJ0gSeE6szY+HPSbt05eYY4Uygmgliz3fdzjov/XubFzZJjv9E67gR6iSLcYjmeh7kV+NgDuMtViovC6Goc2Nah2wIjHJLRwkyR1GtZl9JUd20XDGn5AJ3cQm20ZhjlKz5+Au8r8gWx2/zRRQO/yC+c8Pbegk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790530554; c=relaxed/simple;
	bh=eNkFFfz6dc3SZZj9a4N7GcFLV3wHeNJZAOcqq1YjwrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a13B9G6mCYKLsDSAhSld8PKHJha3kKTTbvuMkDnqaf8BVJgyTVF6H0WAVDgXut9tDdamWZcapESVRTdUJLsiMYOl9d23jiLTkCRhGpo44Vt1jHJvaYDPpB0d9iGPBkBZqbzoi9ajl2BEkwWpiYbSEj4a3vbPbIkid/UUCHDI9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnE1jXtz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnE1jXtz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7AE1F000FF;
	Sun, 27 Sep 2026 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790530553;
	bh=PAuXAU+9SM44dYTSefN91gN6j1Zwqe0SxuriMvR676Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EnE1jXtzQN/xH49a2VYFtamnP7OUaHDGqpOQdZxKLjp2lRyyB2Un9+SMlw6L8c3jD
	 ihTlFf51wiJ0ABHq+mFBPXaMIXHZpc1hiftqfsD+Tq0GntnmjDDFhRiS7jLhTCelQG
	 sdkg8Yu7dVTcAR8sXOHuOeNeYbQNQPRsbFR5So9dOnzpf9B58q3zE/8VEyIcAuhXAk
	 X+y3cczmXc5+2yQBvSLl0cOJLh3A+f6QpDPIGYbwbiFRmre4+Zw6B1/GExnWhT0FaI
	 RNgLuZPVw4OMC+eD/ytR02nkLClJCTWr+M64/cwkD+fsPlCLNbWbyve19YTkuOTHUc
	 yXM92YAo4x9BA==
Date: Sun, 27 Sep 2026 18:35:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: pressure: add Sensirion SDP31 driver
Message-ID: <20260927183546.0260dc19@jic23-hlaptop>
In-Reply-To: <20260926154118.5471-3-m.abubakar365@yahoo.com>
References: <20260926154118.5471-1-m.abubakar365@yahoo.com>
	<20260926154118.5471-3-m.abubakar365@yahoo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 20:41:18 +0500
Muhammad Abu Bakar <m.abubakar365@yahoo.com> wrote:

> Add an IIO driver for the Sensirion SDP31 differential pressure sensor.
> The device is accessed over I2C and reports differential pressure and
> temperature. Each measurement is validated using the sensor's CRC-8
> checksum.
> 
> Tested on an SDP31 connected to a Raspberry Pi 4 I2C bus.
> 
> Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Hi. 

Given you are going to probably need to changes stuff in the dt binding
and so do a v4, various comments inline.  Mostly optimization suggestions.

Jonathan

>  st_pressure-y := st_pressure_core.o
> diff --git a/drivers/iio/pressure/sdp31.c b/drivers/iio/pressure/sdp31.c
> new file mode 100644
> index 000000000..fd7cac027
> --- /dev/null
> +++ b/drivers/iio/pressure/sdp31.c

> +static int sdp31_measure(struct sdp31_data *data, struct sdp31_reading *out)
> +{
> +	u8 rx[9];
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = sdp31_send_cmd(data->client, SDP31_CMD_TRIG_DP);
> +	if (ret)
> +		return ret;
> +
> +	msleep(SDP31_MEAS_DELAY_MS);
> +
> +	ret = i2c_master_recv(data->client, rx, sizeof(rx));

Given there is only a one time read of scale and that i2c is a rather
slow bus, can we do a short read when we only want the temperature
and pressure?  The datasheet mentions Nack + stop is
sufficient to stop the read out sequence and that is IIRC the
normal end of an i2c read sequence. So it 'should' be fine to just
read fewer bytes.

> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(rx))
> +		return -EIO;
> +
> +	if (sdp31_check_crc(&rx[0]) ||
> +	    sdp31_check_crc(&rx[3]) ||
> +	    sdp31_check_crc(&rx[6]))
> +		return -EIO;
> +
> +	out->pressure = (s16)get_unaligned_be16(&rx[0]);
> +	out->temp = (s16)get_unaligned_be16(&rx[3]);
> +	out->scale = get_unaligned_be16(&rx[6]);
> +
> +	return 0;
> +}

> +
> +static int sdp31_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct sdp31_data *data;
> +	struct sdp31_reading r;
> +	int ret;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> +
> +	/* Wait for the sensor to be ready after power-up (datasheet t_PU). */
> +	msleep(SDP31_POWERUP_TIME_MS);
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	/* The CRC table is shared by all instances; initialise it once. */

I would argue that is obvious, so no comment needed.

> +	DO_ONCE(crc8_populate_msb, sdp31_crc8_table, SDP31_CRC8_POLY);
> +
> +	/* Confirm the sensor is present and learn its scale factor. */

If you end up with with a specific call to get the scale factor this
comment will become excessive (see below).

> +	ret = sdp31_measure(data, &r);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to read from sensor\n");
> +	if (!r.scale)
> +		return dev_err_probe(dev, -EINVAL, "invalid scale factor\n");

See above. This is the only time we actually read the scale - so perhaps
we can save some traffic on every other access. Most likely that would give
you a different command for this scale read back.

> +	data->dp_scale = r.scale;
> +
> +	indio_dev->name = "sdp31";
> +	indio_dev->info = &sdp31_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = sdp31_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sdp31_channels);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


