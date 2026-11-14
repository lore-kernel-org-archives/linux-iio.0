Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617585;
	b=v1mPkiVDhUFpdrH92KThIGjITeB4zcy4mEOImvqzvB5JGnT8fHL+elNipQjRFqpzKc+2
	 qHmygmUvQo/lPtVcTMoCjwmiDmUbQliL3Lrp5nL/vVO2uMedy/oFpV5oTRTI0nifhuFV1
	 UtoYALl/P6a2KOCWsLdxb+nOs9LLTROBcJ9jZ96C6qgc/TpaW07p74PlTihFdOVRMwS96
	 0LMZI7rKYMgnB/x99QMvsGviWhs7X6QvsRQ56Qrfjo1QpyTyCrehE+30wHUtz5AOVxvFn
	 bc+aezbhne2xAfA8O7FOw0VlH+xA0h6ouxeSZW5IaALvx3PbyLFXCimR319ej2duEyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617585;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sc5OyOgUTeP2eca1hIGhKPy5SDeMPfcieojL3vpE9W8=;
	b=BEXs9B8v1xneLc8ue7M+rjrAWJ9meGRhMuaBZTkC0Xg0DozXS4jvsGZ6hNhe9LIZfWtE
	 i0C2d/HDCCNl5oIKKLxKcrh+Ef/LZA1Kbhy+3eGOhLMVXaYGrQOTLqE18/ERlhnhmwSeT
	 /B1Bxu6igs0r1i2W8cYnBDBUK0v4LmQTJQqLl6Mjh3/mKSfuNxdmlB90K2gjtqkQeTAmM
	 x2Ro0D6LFnWtU7yMvvoUWT5HVj/WR/b9G3nsqlsl/hcGhQEFwdGAtX9Sk23vfkzaq1b3Z
	 UtLBBzn0T+k+TFs3pOwiDPUavJIZVJF06MbX8tpy1BKjnZHoNtxQTYGS2GhD67j+s9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hRIY1M3/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C3606A332;
	Sat, 14 Nov 2026 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRIY1M3/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1A51F000C5;
	Sat, 14 Nov 2026 00:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617585;
	bh=sc5OyOgUTeP2eca1hIGhKPy5SDeMPfcieojL3vpE9W8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hRIY1M3/VHihVtm+gqiqOqOuL1K+ANFTdl4c4RthZ/iL/r8704z7RoJxGPRL9Qgle
	 HeqcK0lSmB203gKzNe8Nxc8Dl90vSxt6wjfFPXb56MMewc4pT0eKgQydyGVgMhRV/U
	 HIhz957P3B9kGG1WSUoSTx9CrWL0PEJEc6kVaLLgFCWzy6YPJQqEM8D6HbcHyTp6RD
	 lA+kyK06Fsx9cVWVOYdbbSbsJ3JFhB/6JkxzFB86zNZy3A7lC/vAQwmV1BjjtWs73b
	 oP8xS93/0bQD4js2RxcWtboVN5A9fhrD5ULz/N5TpSAQhOJcafeQs4EAe4NHpEhL31
	 ozkGAmiT6vVBA==
Date: Sat, 14 Nov 2026 00:52:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Robert
 Budai <robert.budai@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v6 5/8] iio: imu: Add driver for the ADI ADIS16607
Message-ID: <20261114005255.0b64ec92@jic23-hlaptop>
In-Reply-To: <20261113-adis16607-v6-5-3f678719942a@analog.com>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
	<20261113-adis16607-v6-5-3f678719942a@analog.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Nov 2026 14:33:35 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
>=20
> The ADIS16607 is a Precision MEMS IMU from Analog Devices with
> triaxial gyroscope and accelerometer, delta angle/velocity, and
> temperature channels, communicating over a custom SPI Half-Duplex
> protocol. ADIS16607-2 has a =C2=B1450=C2=B0/s gyroscope range, ADIS16607-3
> =C2=B12000=C2=B0/s; both share a =C2=B140g accelerometer range and an 8 k=
Hz internal
> clock.
>=20
> This is the base driver: probe, raw channel reads, sampling-frequency
> control, startup/self-test via adislib, and debugfs identity entries.
> No buffered capture, external clock sync, or calibration bias yet -
> those follow in later patches.
>=20
> Self-test leaves the device's SELF_TEST register cleared on every exit
> path, not just on success, so a read failure or a failed delta check
> doesn't leave the sensor stuck in its self-test/force state until the
> next reset.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>


The chan_spec in here includes buffer related stuff (scan index and
the channel type bit) + the timestamp channel in general. That should
all have been introduced in the next patch.  Thus feedback on that
patch isn't contained and I've dropped this one for now.


> diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
> new file mode 100644
> index 000000000000..f5dc37c54191
> --- /dev/null
> +++ b/drivers/iio/imu/adis16607.c

> +/*
> + * .address indexes adis16607_chan_regs[], .scan_index is the buffer pos=
ition;
> + * both come from the same enum today but are separate fields on purpose.
> + */
> +#define ADIS16607_MOD_CHAN(_type, _mod, _idx)				       \
> +	{								       \
> +		.type =3D (_type),					       \
> +		.modified =3D 1,						       \
> +		.channel2 =3D (_mod),					       \
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		       \
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	       \
> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
> +		.address =3D (_idx),					       \
> +		.scan_index =3D (_idx),					       \
> +		.scan_type =3D {						       \
> +			.sign =3D 's',					       \
> +			.realbits =3D 24,					       \
> +			.storagebits =3D 32,				       \
> +			.endianness =3D IIO_BE,				       \
> +		},							       \
> +	}
> +
> +#define ADIS16607_ACCEL_CHANNEL(_mod)					       \
> +	ADIS16607_MOD_CHAN(IIO_ACCEL, IIO_MOD_ ## _mod,			       \
> +			   ADIS16607_SCAN_ACCEL_ ## _mod)
> +
> +#define ADIS16607_GYRO_CHANNEL(_mod)					       \
> +	ADIS16607_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_ ## _mod,		       \
> +			   ADIS16607_SCAN_GYRO_ ## _mod)
> +
> +#define ADIS16607_MOD_CHAN_DELTA(_type, _mod, _idx)			       \
> +	{								       \
> +		.type =3D (_type),					       \
> +		.modified =3D 1,						       \
> +		.channel2 =3D (_mod),					       \
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		       \
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	       \
> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
> +		.address =3D (_idx),					       \
> +		.scan_index =3D (_idx),					       \
> +		.scan_type =3D {						       \
> +			.sign =3D 's',					       \
> +			.realbits =3D 24,					       \
> +			.storagebits =3D 32,				       \
> +			.endianness =3D IIO_BE,				       \
> +		},							       \
> +	}
> +
> +#define ADIS16607_DELTANG_CHAN(_mod)					       \
> +	ADIS16607_MOD_CHAN_DELTA(IIO_DELTA_ANGL, IIO_MOD_ ## _mod,	       \
> +				 ADIS16607_SCAN_DELTANG_ ## _mod)
> +
> +#define ADIS16607_DELTVEL_CHAN(_mod)					       \
> +	ADIS16607_MOD_CHAN_DELTA(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod,	       \
> +				 ADIS16607_SCAN_DELTVEL_ ## _mod)
> +
> +static const struct iio_chan_spec adis16607_channels[] =3D {
> +	ADIS16607_ACCEL_CHANNEL(X),
> +	ADIS16607_ACCEL_CHANNEL(Y),
> +	ADIS16607_ACCEL_CHANNEL(Z),
> +	ADIS16607_GYRO_CHANNEL(X),
> +	ADIS16607_GYRO_CHANNEL(Y),
> +	ADIS16607_GYRO_CHANNEL(Z),
> +	ADIS16607_DELTVEL_CHAN(X),
> +	ADIS16607_DELTVEL_CHAN(Y),
> +	ADIS16607_DELTVEL_CHAN(Z),
> +	ADIS16607_DELTANG_CHAN(X),
> +	ADIS16607_DELTANG_CHAN(Y),
> +	ADIS16607_DELTANG_CHAN(Z),
> +	{
> +		.type =3D IIO_TEMP,
> +		.indexed =3D 1,
> +		.channel =3D 0,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.address =3D ADIS16607_SCAN_TEMP,
> +		.scan_index =3D ADIS16607_SCAN_TEMP,
> +		.scan_type =3D {
> +			.sign =3D 's',
> +			.realbits =3D 16,
> +			.storagebits =3D 16,
> +			.endianness =3D IIO_BE,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(ADIS16607_SCAN_MAX),

Should not be here and the channels above should not 'yet' hvae
scan_type or scan_index.  Those belong in the patch adding buffered support.


> +};
