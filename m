Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085304;
	b=o6eRLnfYDrjpfvraZ2ivJRZOR7ili+vkP5nrB0h1O9W6+A4sLY8f/Q9zcqIz5EMGgXkd
	 fZQyEacl8o+wuWl+4hR3IvgKY9ZRpak0PHhzg2GJcPdDCYYCDEesXk5Zvkx0N8epjrBY9
	 QXHhNHZ2+NkpqDa6raFThh+AOj0Xhmev40qgmlQen4PYeCCZE5KSkZLrOV52Ec15qeCKw
	 CY+INp8gKkuz47euqtNV9ottC9vCJMbBIdMimkrNxMdzHRsN9k1vIN9dGmhhMHOetmISv
	 lnSjWNSx9F3KY5s+VVQt241dFlQCqyAOE0rimQuwwBZRwxekfIdWRKPECAKiksawQLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085304;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ArJdLWr8o0oO4xfWC0qNE8GAjULqRVkduBQm2jzPol8=;
	b=Wd0cc0/ibJGQy/KbxXo5D9DyJVk7Tamo42+L28cQlBAHixLRBEMBBqHYx6hOF0wWGLXr
	 UlIeM4fJRhPOkDJaiGQdWA/8qRZNZV4o7I80DgP7HMlNXQZKjzzMEc3M7ATnH9aQjo0xL
	 kFvpJ4dV1zcQGP8u5RpOjMq5+anxqwrt/qPAF0+qYLWwT0Huq1n3bW9PHQv65QTdQVCxj
	 2mgh6caftqLif1S/hf5EbeCwYWANwA8wGnQk/76ciJHztReBVNNvncagHjODpPNwcBgFj
	 uayan3LGVwG9en0UppMVhkPOLnVF7tiDspB6qOLJQpdQpbNoHIuuCIxp8Iw9CX3Fovg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g29z27b3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19042606A326;
	Sat,  7 Nov 2026 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g29z27b3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBBF1F0089F;
	Sat,  7 Nov 2026 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794085303;
	bh=ArJdLWr8o0oO4xfWC0qNE8GAjULqRVkduBQm2jzPol8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g29z27b3Y0i3aM0cWZQbPDWK/i8n7rWieWleJygKnJt94A5B5nAAtdE9wYrX2eAF8
	 TVKxNe3iVUFc3GKMHVw8TQv/Xg3sPMIWRynpBu0/LWt9t2ZapH/CtkL4yYZOtuQATT
	 1YAOO2RD3N9VRGGzME7uJyjitJu4/FnbZsmnmgGugRz9wQqNqUYii+wl1rvaizwoO5
	 Kkxhz/B+lpD5yxjGa6D2lZZFTGrY9a9/R2bpABxIfZOTCkzXmRiiKPrNlDJ95n7Kzg
	 IFro843S1c+EPmMuZepDAoZYEOT1vURMBPu6mu9XoHe3DqWf/J9nvauQ/ClKOQP7nn
	 ve8L/5Uo/LvJw==
Date: Sat, 7 Nov 2026 21:01:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v5] iio: chemical: ccs811: Make sampling frequency
 configurable
Message-ID: <20261107210139.4290dd12@jic23-hlaptop>
In-Reply-To: <20261104151138.9968-1-nikhilgtr@gmail.com>
References: <20261104151138.9968-1-nikhilgtr@gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Wed,  4 Nov 2026 20:41:38 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Allow userspace to configure the CCS811 IAQ measurement rate through
> the IIO sampling_frequency attribute.
>=20
> Support the three IAQ measurement modes with sampling frequencies of
> 1 Hz, 0.1 Hz, and approximately 0.016667 Hz, corresponding to
> measurement intervals of 1, 10, and 60 seconds.
>=20
> Preserve unrelated bits in the MEAS_MODE register when updating the
> drive mode, and cache the selected mode after a successful register
> write. Expose the supported frequencies through
> sampling_frequency_available.
>=20
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
A few trivial things + a note on why you are seeing those build failures.

If it wasn't for that scope issue I might have applied this version
and possibly tidied up the trivial stuff.

There is also one more significant suggestion inline if you want
to take it on.  Up to you though!

Jonathan

> @@ -163,16 +185,21 @@ static int ccs811_start_sensor_application(struct i=
2c_client *client)
>  	return 0;
>  }
> =20
> -static int ccs811_setup(struct i2c_client *client)
> +static int ccs811_setup(struct ccs811_data *data)
>  {
>  	int ret;
> =20
> -	ret =3D ccs811_start_sensor_application(client);
> +	ret =3D ccs811_start_sensor_application(data->client);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D i2c_smbus_write_byte_data(data->client, CCS811_MEAS_MODE,
> +					CCS811_MODE_IAQ_1SEC);
>  	if (ret < 0)
>  		return ret;
> =20
> -	return i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE,
> -					 CCS811_MODE_IAQ_1SEC);
> +	data->drive_mode =3D CCS811_MODE_IAQ_1SEC;

Trivial but a blank line here would be a tiny readability=20
improvement.  Lets the eye immediately spot the 'good' return path.

> +	return 0;
>  }

> +
> +static int ccs811_set_sampling_freq(struct ccs811_data *data,
> +				    int val, int val2)
> +{
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ccs811_set_wakeup(data, true);
> +	ret =3D ccs811_update_sampling_freq(data, val, val2);
> +	ccs811_set_wakeup(data, false);

If you are feeling adventurous and want a follow up, it might
be worth thinking about defining a guard for ccs811_set_wakeup.

=46rom a quick glance it looks to me like it would simplify some
existing paths in the driver as well.  I suspect it doesn't need
to be as tightly scoped as it is in probe() today and can wait
for the end of that function.  To prevent races it might be necessary
to take data->lock in probe though - I haven't walked through exactly
what that is protecting but as wakeup isn't reference counted it
seems likely that is part of the protected state.

Anyhow, entirely optional - I just noticed it because it would have
saved a few lines of code here.

> +
> +	return ret;
> +}

>  static int ccs811_read_info_raw(struct ccs811_data *data,
>  				struct iio_chan_spec const *chan,
>  				int *val, int mask)
> @@ -249,6 +343,24 @@ static int ccs811_read_info_raw(struct ccs811_data *=
data,
>  	}
>  }
> =20
> +static int ccs811_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ccs811_data *data =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:

The build warnings are because this doesn't have scope defined
around the declaration of the variable cleanup that is
the magic behind these.
	case IIO_CHAN_INFO_SAMP_FREQ: {
		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
		if (IIO_DEV_ACQUIRE_FAILED(claim))
			return -EBUSY;

		return ccs811_set_sampling_freq(data, val, val2);
	}
	default:

should fix that up.

> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		return ccs811_set_sampling_freq(data, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int ccs811_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan,
> +				    long mask)
> +{
> +	if (mask =3D=3D IIO_CHAN_INFO_SAMP_FREQ)
> +		return IIO_VAL_INT_PLUS_MICRO;

This is the the default, so should be no need to provide get_fmt.

> +
> +	return -EINVAL;
> +}

>  		return ret;

