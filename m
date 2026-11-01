Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499270;
	b=o/phZIgRis0gJ5ZyVEttNptEGo/K4LHjbe692OthaFctXl3buuOYIDIRZa5gNYTefqX0
	 l4TB4H+IFIhe+wQffvrJ9MLlBa7qDL350K/pyFbXcRAp/hFmCZwUnkGExDtC3qm8LUKqh
	 ARSShg0Unkc6pY9Z/G6VL3q3PsZcIztqQyBZutShneEdA7imEyhOhZBYVT+bQDDXkfsPg
	 CtX2y2L554CIG3duJ3HIDLa+OG5N1bZfGSncryK/8hebnEKaCYPC6fOxVdp+QYjvM/d98
	 AV8lf2fit1JQCiLhl65ncDCVTENc3ML7cqe1ESUk6uUNf31dhAA/ZjmD3cRt/XVBQyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499270;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bLftdHNsUM6/IPlatRWp4igHoscYXR0a/WAbN93tJ4s=;
	b=43Fi2UhGR2pIrEqaNDJriNeC+2ZGAzd2oqnq/kuc6ZD229RTGP5RkJppHUSnFMUmCkGA
	 gRiynkMwz7FEHj2MpWJ61V/oLxd5FsxZOtx8Acz6XpIPMWBJWqx9/UVx+w/B0x/3eOEut
	 VrvVUrtyUOkDlC5vYZqHnfWDMqodA5wHPXW4OcC/0EEQUonNyi0nM9VheYTuVKUOsOVsp
	 5YsLny9K1Hbw5WzzQBI/ecswtWJ62ljM1ksa5jSma8UsOUCjaqz9eyoL4Dkhk9pqbgfU6
	 4cfPTb96dO64NwtJLJHTad+9Ah5+FWRSzrJibBeoRAOkIHZr/lsCGmAENxFeE7+fblQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZQNhkNk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA585606A324;
	Sun,  1 Nov 2026 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZQNhkNk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AF21F00919;
	Sun,  1 Nov 2026 02:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499269;
	bh=bLftdHNsUM6/IPlatRWp4igHoscYXR0a/WAbN93tJ4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZZQNhkNk1FBW1CsTBV4WqzvEl2TodwIO5O2Gi3jXzwWwucHK5Xp1D4doGiBjMdszn
	 uuqZ+M0a693ZJRwKdFbA3kT0jrXrvHvvUNOldPYKj6P5ZCCXAPe2bHrtC9RwcB2f9v
	 7spLojSW2FSf4fh6rnVUI2vNSLn4+zALq2xPNGitQTkLZQciNYO4n4gDtX6K8xRmO8
	 agcIsi5HaN5JBSsYhqTvSwHZtM0g7esWJJzDv925ZZBX3d0yiNMReZ20LIQaPeu+jv
	 z1FAczFGWgRoHx+JfpOO5fiqoRv9zj8qM/MBmXUEyqrbPwpGxYVbapiYZSPrVkIUPp
	 SnzRs7X98Mwwg==
Date: Sun, 1 Nov 2026 02:14:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, Jean-Baptiste
 Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 12/15] iio: imu: inv_mpu6050: don't disable the IRQ
 under lock
Message-ID: <20261101021422.0c9e0815@jic23-hlaptop>
In-Reply-To: <20261027-llm-char-misc-iio-v1-12-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-12-0d818334f6c7@linuxfoundation.org>
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

On Tue, 27 Oct 2026 17:19:16 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> If the chip is a wake-up source, inv_mpu_suspend() calls disable_irq() wi=
th
> st->lock held.  disable_irq() waits for the threaded handler, and
> inv_mpu6050_interrupt_handle() takes st->lock to read the interrupt
> status.  If the chip raises an interrupt while the system is being
> suspended, the handler waits for the lock, the suspend callback waits for
> the handler, and the suspend hangs.
>=20
> Disable the interrupt once the lock has been dropped.
>=20
> Fixes: 305914d01807 ("iio: imu: inv_mpu6050: add WoM suspend wakeup with =
low-power mode")
> Cc: stable <stable@kernel.org>
> Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

This seems correct to me, but waiting on Jean-Baptiste for
view from someone more familiar with the driver (and maybe
able to give it a sanity check test!)

> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 38c3f3b398d4..0ae9d497ccfd 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -2166,7 +2166,7 @@ static int inv_mpu_resume(struct device *dev)
>  	return result;
>  }
> =20
> -static int inv_mpu_suspend(struct device *dev)
> +static int __inv_mpu_suspend(struct device *dev, bool *disable)
>  {
>  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>  	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> @@ -2212,7 +2212,7 @@ static int inv_mpu_suspend(struct device *dev)
>  		if (result)
>  			return result;
>  		enable_irq_wake(st->irq);
> -		disable_irq(st->irq);
> +		*disable =3D true;
>  	} else {
>  		result =3D inv_mpu6050_set_power_itg(st, false);
>  		if (result)
> @@ -2223,6 +2223,21 @@ static int inv_mpu_suspend(struct device *dev)
>  	return 0;
>  }
> =20
> +static int inv_mpu_suspend(struct device *dev)
> +{
> +	struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata(dev));
> +	bool disable =3D false;
> +	int result;
> +
> +	result =3D __inv_mpu_suspend(dev, &disable);
> +
> +	/* Not under st->lock: this waits for the handler, which takes it */
> +	if (disable)
> +		disable_irq(st->irq);
> +
> +	return result;
> +}
> +
>  static int inv_mpu_runtime_suspend(struct device *dev)
>  {
>  	struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata(dev));
>=20

