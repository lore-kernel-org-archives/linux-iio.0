Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098117;
	b=b9Kvu9M92i2iYx7tdt0jOKwklGE0S3D54bb3dXymgXhbYMzsc1azvAvBdcMn1pkgQOWZ
	 Ij8n0H3wXW4//+pZ7TWcAMi29pVmmJHybPoamRLCkJs4VHmaK4pC2rNfUUMjVXOABqFXL
	 cb5s7KxJ6EXzIJeInii7Tci86FOsREBuPc7OwV/ULw2G5vuNCn7sf+hAfyabTb4NwBB6p
	 kX6DDh2stcNHChdO0gWJZZv7+LC9jAqB3AO0/QBQif/vgzayWFwbjl3ETXJNDamY2v2KL
	 HE6L3lO5CmCBLZCoF+KHFDa7OZxBk2DEuTgqzdAi3Mh/DUckxAxmdPm4OWq8Y5mY/TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098117;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VBkJrsvrksWgv31mI5SC2s8D6+fR7B83FPJCXwL1VlA=;
	b=MCISI4Dn+3TxIYq9I/yehelfBzdQan2+louv3Xl4A2uS6GFJx2J2J0uo4EsFZcyhtlDF
	 +AGuYP/4f9btoJ9uEWW1DxTVjxz2duskNw7fJxXAEVgp8OVBvnaInxay6MPe980z07X/Q
	 4ACw3L6kp1SqC46dDPC0yleE8wc8z0HNhH34L5D05mr8YT7xXdGJg/N88PsoFVtT5D0q5
	 dByRWZ3SzsSbK409i6US0WCcB+AYLSKUavHKra+upiammen8kE/8xjbPTPUGHesjE/CAi
	 P2q93/YuQSOnmEeUxCwUcz74UhZBI81LHT8AIXiM0h8NjTrTJaf4dizwcaDX1WH/gOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keL71BYF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0B606A326;
	Sun,  8 Nov 2026 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keL71BYF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292831F0089F;
	Sun,  8 Nov 2026 00:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098116;
	bh=VBkJrsvrksWgv31mI5SC2s8D6+fR7B83FPJCXwL1VlA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=keL71BYFSqN8hd5dUXZsdQN80/2FmoonW141qffJ/boEaxIaigJPj4uWnZEvapQSD
	 thQ5RCNot5ePz0nnjpLoGxUCbp3XVXJG9gsEREvFg5lMttgh91rZBV+fy7oSeweZyO
	 b0k2aG5hWh99zVNwl/HPPNMydjYuVoeAUQZ9geD+yFNLJak5MhnZ+ZhcU9Kj2N06ba
	 V4e1noYz1j2zTympos6G42OZ4fzRGTqUWnw6l9l9b5I8G9l23FG4Hve8KUXKLF0dwx
	 HVl+n1D4C4kKqCp2JptOOhBT5APMae8W50tYwLQbBgaEvfE4qWgJbUdZmqwPJGFcCW
	 PsGGSmgSeVYTA==
Date: Sun, 8 Nov 2026 00:35:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v5 5/8] iio: imu: Add driver for the ADI ADIS16607
Message-ID: <20261108003510.5b48a969@jic23-hlaptop>
In-Reply-To: <20261102-adis16607-v5-5-4f98b0d271ac@analog.com>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
	<20261102-adis16607-v5-5-4f98b0d271ac@analog.com>
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

On Mon, 02 Nov 2026 11:25:41 +0200
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

Trivial stuff if doing a v6 for other reasons.

> diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
> new file mode 100644
> index 000000000000..5e2c999e68ac
> --- /dev/null
> +++ b/drivers/iio/imu/adis16607.c

> +
> +enum {
> +	ADIS16607_SCAN_ACCEL_X,
> +	ADIS16607_SCAN_ACCEL_Y,
> +	ADIS16607_SCAN_ACCEL_Z,
> +	ADIS16607_SCAN_GYRO_X,
> +	ADIS16607_SCAN_GYRO_Y,
> +	ADIS16607_SCAN_GYRO_Z,
> +	ADIS16607_SCAN_DELTVEL_X,
> +	ADIS16607_SCAN_DELTVEL_Y,
> +	ADIS16607_SCAN_DELTVEL_Z,
> +	ADIS16607_SCAN_DELTANG_X,
> +	ADIS16607_SCAN_DELTANG_Y,
> +	ADIS16607_SCAN_DELTANG_Z,
> +	ADIS16607_SCAN_TEMP,
> +	ADIS16607_SCAN_MAX,

That looks like a terminating entry so no comma to make it
clear nothing should ever go after it.

> +};



> +/*
> + * No external clock sync support yet: always run on the internal clock.
> + * Default dec=3D0 after reset, so period =3D 1 / clk_freq_mHz.
> + */
> +static int adis16607_config_clk(struct adis16607 *st)
> +{
> +	u64 period_ns =3D NSEC_PER_SEC;
> +
> +	st->clk_freq_mHz =3D st->info->int_clk_Hz * MILLIHZ_PER_HZ;
> +
> +	/* clk_freq_mHz is in millihertz: scale to get the period in ns */
> +	period_ns *=3D MILLIHZ_PER_HZ;
> +	st->sample_period_ns =3D DIV_ROUND_CLOSEST_ULL(period_ns,
> +						     st->clk_freq_mHz);

If respinning for other reasons, just make the above one line.

> +	return 0;
> +}



