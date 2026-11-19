Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058692;
	b=U/9vVdY9JdFBX186w7Fns5X3CPhg7TPMbn3oYqGr0MfrdvekEMUdTceiL7FfYBd90Zo1
	 Vqfk/bBP46vCyJy6qUJdZjapJwxwaLAy07qPAVDMde8oW3mnJ6mDwOuRAkEb8RcqCWJyh
	 k/dVBifQeDCIdfG7mP7/Epjj8ckQ44QZX6PswfEUkDqphA2LopUX3Fx+Pnha57yzsDXsP
	 rF4KlGNLMKgDmL9BnO2BzzahX2WGihMIqg7wVecpiD9F5v8qBwLp/XURvqX3njEWpzHaP
	 xpCxEszOMBG1hAhsDteJaktcj1TofYV0Db1Zq5duhUSJva1yGA5MZTSgOngGsT1hI3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058692;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HbfKZcwjCthi8ePlvWznI1oYqUDWBujowO/kPuxenKo=;
	b=jBwT9xgIrVh2ozKtnV7Ght5/VGolTB+5KQJIC5QFcFMDqi8rdepPJxZkSAbyYPtVGEmc
	 B/xKe2Y2VYZ7jlbLzcy8LJMRjtYgClCeXXNuarGoIpuTzEQKkUanDEIUFe1CAYGm/yq+F
	 kH0V2wU+eqbjh+nlV0e2fUVBCUBY6Y34HQjcCLGenlHo6RQccQrWAfRFtKGD1OPIcIdQA
	 QG8sDxTpP6uQcPXx2pa9Rk+yBRuxzqKfze0FLYx6FI1C4NY+muKTXFviLTFBmsr7EAofE
	 qMt4iodk5u2fBsLYdOk3Vb1SWAP4+H9qEzq/tupdw1IOvMWuhAdUTnOjW8WnxEkcodA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ps7X7E4x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AB606A332;
	Thu, 19 Nov 2026 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ps7X7E4x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C483D1F000C5;
	Thu, 19 Nov 2026 03:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795058692;
	bh=HbfKZcwjCthi8ePlvWznI1oYqUDWBujowO/kPuxenKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ps7X7E4xwIqlNOD9TP7DyBYVUge4IUB7UgEMtf819J447QqEL/8dfL+baxW/AmGJ3
	 Zlvm44svClT5UREC6PIT19c9UsH2nLFgkIPAJzqdyAfkZLlsKe+KRxe39uak5bPnRn
	 kTcacdoyWu+625pyVUPNUoXti3hbBrK59wb4p99+KR+OvH/BAMG4w7GuoMMBeU7qLy
	 zOdLdVARULQnVQjCZybfVM5fuwBvSuTaVPuz93RgKkg9k8JJKmlBKIOD6B7Y1bRMh9
	 c7+h1YNyhMOletnWu4I2bURJiHsJEOSk6+X1HaCtdzclySTDYaXsnCxW8irA4wDuk4
	 7SfSxMRF78wxA==
Date: Thu, 19 Nov 2026 03:24:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Robert Budai <robert.budai@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux@analog.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 5/7] iio: imu: Add driver for the ADI ADIS16607
Message-ID: <20261119032446.65d0eeba@jic23-hlaptop>
In-Reply-To: <20261118-adis16607-v7-5-707609737691@analog.com>
References: <20261118-adis16607-v7-0-707609737691@analog.com>
	<20261118-adis16607-v7-5-707609737691@analog.com>
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

On Wed, 18 Nov 2026 15:17:47 +0200
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
>=20
> Self-test leaves the device's SELF_TEST register cleared on every exit
> path, not just on success, so a read failure or a failed delta check
> doesn't leave the sensor stuck in its self-test/force state until the
> next reset.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
One really minor thing inline. If that's all that comes up
it isn't worth a respin.

> diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
> new file mode 100644
> index 000000000000..c53f3e62d3fc
> --- /dev/null
> +++ b/drivers/iio/imu/adis16607.c

> +
> +static int adis16607_set_freq(struct adis16607 *st, u32 freq)
> +{
> +	u32 dec;
> +	int ret;
> +
> +	if (!freq)
> +		return -EINVAL;
> +
> +	dec =3D DIV_ROUND_CLOSEST(st->clk_freq_mHz, freq);
> +	if (dec)
> +		dec--;
> +
> +	dec =3D min(dec, st->info->max_dec);
> +
> +	adis_dev_auto_scoped_lock(&st->adis) {

Why not just
	adis_dev_auto_lock() ?

Seems like that would be fine through this series.


> +		/* Reset the decimation accumulator before the new value */
> +		ret =3D __adis_write_reg_16(&st->adis, ADIS16607_REG_DEC_RATE, 0);
> +		if (ret)
> +			return ret;
> +
> +		st->dec =3D 0;
> +
> +		if (dec) {
> +			ret =3D __adis_write_reg_16(&st->adis,
> +						  ADIS16607_REG_DEC_RATE, dec);
> +			if (ret)
> +				return ret;
> +
> +			st->dec =3D dec;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * .address is an index into adis16607_chan_regs[] for this driver, not a
> + * literal register like adis_single_conversion() expects, and the chann=
el
> + * spec carries no scan_type for it to take the register width and sign
> + * extension from. Resolve both on a local copy rather than reimplementi=
ng
> + * the helper's locking logic ourselves.
> + */
> +static int adis16607_raw_read(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan, int *val)
> +{
> +	struct iio_chan_spec raw_chan =3D *chan;
> +	bool is_temp =3D chan->type =3D=3D IIO_TEMP;
> +
> +	raw_chan.address =3D adis16607_chan_regs[chan->address].raw_reg;
> +	raw_chan.scan_type.sign =3D 's';
> +	raw_chan.scan_type.realbits =3D is_temp ? 16 : 24;
> +	raw_chan.scan_type.storagebits =3D is_temp ? 16 : 32;
> +
> +	return adis_single_conversion(indio_dev, &raw_chan, 0, val);
> +}
