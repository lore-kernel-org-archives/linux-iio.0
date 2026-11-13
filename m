Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535437;
	b=mXdfYQ3dNBH251ifIOhN+KWHlI0MagzLWrN7UesC+vTKSj5YhHkwEYzd5cP+Vs13yPSj
	 VppTNg5eBLkCuSrU2AXuZo27Y2kagGpUaFt3pVonYXT+IEEkttpKPDs7iFLpywE2/ej+O
	 7K2Cts8kiMVOMy5zhZsec5vRtASoaCyOoOrQ6K5WtjTWINHBD7sBW3ImLH3uJHNOPlSjz
	 kdVOIUAdB8nMEvN03IxA8M5VJloMbGc3PqITm2wiRJEjCqqlChrh7S5GqsbaZ4cknAs8r
	 8h+Nl11yCa/0jS7NGCg5LSfR1MxTgQpsyA5dp2f8k56vRC8ta2hs9FWXoYUghqH7GrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535437;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=52ypZZbH0W5iPBW6QvuskKZ2OD4EQJiTD+ro0Z2NwZc=;
	b=g7NbwCmpcfUBesrzPzElrlrGOMqOCpjzGwT8QYGS95eVKpk3R4yAqXQ/xNwblj4hkOfV
	 u07jk4f1B8Wuav6UdcqZZL/IFgqrbeHXbuVxkK/RgAqZ4MSSoq9y4BOJKL4xC2xJ/xOqz
	 6eCxY00pVb8uLx9fpYiiPPMbEbTKAvB2vqZuuG18NEguAM70jI3HqsF/wplAJqIkAdSOY
	 3j4m3SpdoIvi3zhf5khETlSuTgG7jCHm0B1lq+pT3Snv8dbzF5Erdd0mAqY7QJjTvJzQY
	 StislIWExvmVdLokOSRybx2zJ/1DNZQJ9yu7J10ntsg156DZ642dmIhssCYqwfNBZwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1O3kJia;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBCB606A31C;
	Fri, 13 Nov 2026 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1O3kJia
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A201F000C4;
	Fri, 13 Nov 2026 02:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794535436;
	bh=52ypZZbH0W5iPBW6QvuskKZ2OD4EQJiTD+ro0Z2NwZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E1O3kJiaCdQbu6ToQsMC6pBJVhVyZiXJgkiz/fyhhMKKT1CQA8kQOtjv2a/oQZLyH
	 KJ9pywLNBb1TaQk0mOPiIRthynunZatHN62BIcUfplhdH4W//SUfTzRNo/bmLiRO2e
	 YtzQ08uzikWZlKd7ekJHGzyk0O4kdJ9a04dtdt8/mRHgULmCpLAQ7XDKIAqSbX/1+I
	 6J0B7zzB3nlqQXj71hE23uG6ydIUu8A0/GTJkOI4ahzhONO6uZaNgvWVFm84quu6df
	 2+ORblExCh4+BLfQyQpdNfH5XZAv0rMuF+6al7mItV9ZpI87livQHuiWhjM+SolSOk
	 uttcqvGXYdWSg==
Date: Fri, 13 Nov 2026 02:03:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: update gyro start and stop
 delay
Message-ID: <20261113020353.6d57fd46@jic23-hlaptop>
In-Reply-To: <20261110-iio-imu-inv-icm42600-update-gyro-start-stop-delay-v2-1-c6f5d35290d4@tdk.com>
References: <20261110-iio-imu-inv-icm42600-update-gyro-start-stop-delay-v2-1-c6f5d35290d4@tdk.com>
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

On Tue, 10 Nov 2026 16:57:17 +0100
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com=
@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
> From internal specifications maximum start time for gyroscope is 45ms.
> Stop time is required for letting gyroscope mechanical structure settle
> down before enabling it back. 50ms is a sufficient value for that.
>=20
> Update values to these numbers.
>=20
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied to the testing branch of iio.git.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Do not refer to datasheet since these values are not available.
> - Link to v1: https://patch.msgid.link/20261020-iio-imu-inv-icm42600-upda=
te-gyro-start-stop-delay-v1-1-ed52290a4ca4@tdk.com
>=20
> To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h
> index 3737e79dbcc1..c4a928fd3b8a 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -439,8 +439,8 @@ struct inv_icm42600_sensor_state {
>  #define INV_ICM42600_POWER_UP_TIME_MS		100
>  #define INV_ICM42600_RESET_TIME_MS		1
>  #define INV_ICM42600_ACCEL_STARTUP_TIME_MS	20
> -#define INV_ICM42600_GYRO_STARTUP_TIME_MS	60
> -#define INV_ICM42600_GYRO_STOP_TIME_MS		150
> +#define INV_ICM42600_GYRO_STARTUP_TIME_MS	45
> +#define INV_ICM42600_GYRO_STOP_TIME_MS		50
>  #define INV_ICM42600_TEMP_STARTUP_TIME_MS	14
>  #define INV_ICM42600_SUSPEND_DELAY_MS		2000
> =20
>=20
> ---
> base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
> change-id: 20261019-iio-imu-inv-icm42600-update-gyro-start-stop-delay-68d=
afe160210
>=20
> Best regards,
> -- =20
> Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
>=20

