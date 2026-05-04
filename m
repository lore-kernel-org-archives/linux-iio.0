Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22E364923
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911466; cv=none; b=Xw+1492a94LXDgnnadmJZDOhBrkB+qRz8OYGyh8rYkOA6UVuR6qC3en/zU5TqOb0O2q2+j0qQrQowg/OxbhxcXQhKPgRu4F2I0YuZ++SqwumwK6bAfjNHNVyqlFxMC/pCdwB/UCsgnKsJ7OBgkBO9/wvSfg4W8jxe77ttcTSBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911466; c=relaxed/simple;
	bh=KnCLwZuu3QPPBvbFjEeQdeoWzUFp4sjkfRxzljZKI44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMlNZC33nLnxvmkeE4Kk5eE8+QwvoUNPldnCqbuuIYK5VrTYV8zyDFDtT9ZYL/iWlJO6fpSr+rsSQhyJ1nGM1AmZhkWKQRU3Z2Vc+mKD5f1F563JonQod7fe5hpYFBt8sPQPMyv0/3H0dbbjC8DaUtOAZVVxfP7I3VOZm37WE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF18FyTD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF18FyTD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA609C2BCB8;
	Mon,  4 May 2026 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777911466;
	bh=KnCLwZuu3QPPBvbFjEeQdeoWzUFp4sjkfRxzljZKI44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XF18FyTDNhMX6/UbgIFcHOEj5hZAwWP8fkU1tdHznzPQ9qWCvicsfMuEDbP4mQQgu
	 aRTH3pbty4+MXaNkFy+3mhNbl1Vn9SlI9QxbFM5QKAZiNlCYwTVjLn/NCKGiNxr71v
	 dgbCdbemy5jr+mSiBtLX8IRd1iXvExjs2XAZW9a+h0vSssnUtdQRjhym5PDKQB+d3j
	 tnSRlV/w8B33rLuAyseDjJk1Za64+B7int5k0qolbyp9luEXWQU6dQ+Mu2fo+g+hOM
	 Yl62snqeoc2KCadUeD6gP3wyN3XcIf53yK7UK3BiSMrhM4xeG+j18WFpx03moNDg85
	 IEj2I4OnEPH3g==
Date: Mon, 4 May 2026 17:17:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?Sm/Do28=?= Fernandes <joaovictor.fernandes@usp.br>
Cc: jean-baptiste.maneyrol@tdk.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, gcotavio@usp.br,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: refactor accel/gyro
 configuration paths
Message-ID: <20260504171738.1075442a@jic23-huawei>
In-Reply-To: <20260503031703.33330-1-joaovictor.fernandes@usp.br>
References: <20260503031703.33330-1-joaovictor.fernandes@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  3 May 2026 00:12:36 -0300
Jo=C3=A3o Fernandes <joaovictor.fernandes@usp.br> wrote:

> Refactor accel and gyro configuration paths to remove duplicated
> logic and improve code structure.
> Introduce a generic helper, inv_icm42600_set_sensor_conf(), to handle
> common register programming and state updates.
>=20
> Keep sensor-specific handling in inv_icm42600_set_accel_conf() and
> inv_icm42600_set_gyro_conf() wrappers. Also extract configuration
> sanitization into a dedicated helper inv_icm42600_sanitize_conf()
> to further reduce repetition.
>=20
> Signed-off-by: Jo=C3=A3o Fernandes <joaovictor.fernandes@usp.br>
> Co-developed-by: Otavio Capobianco <gcotavio@usp.br>
> Signed-off-by: Otavio Capobianco <gcotavio@usp.br>
> ---
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 125 +++++++++---------

When you get a patch to 'remove duplicated' code and it adds 1 line,
then start questioning if it is a good idea.  I think on balance, not
quite worth it here. Some feedback inline.

I haven't broken it out but maybe the sanitize section is a sensible
small deduplication patch?

Comments mostly about too much complexity.

Thanks,

Jonathan



>  1 file changed, 63 insertions(+), 62 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c
> index 76eb22488..e326e0aae 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -289,15 +289,51 @@ static int inv_icm42600_set_pwr_mgmt0(struct inv_ic=
m42600_state *st,
>  	return 0;
>  }
> =20
> -int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
> -				struct inv_icm42600_sensor_conf *conf,
> -				unsigned int *sleep_ms)
> +static int inv_icm42600_set_sensor_conf(struct inv_icm42600_state *st,
> +			      struct inv_icm42600_sensor_conf *target_conf,
> +			      struct inv_icm42600_sensor_conf *accel_conf,
> +			      struct inv_icm42600_sensor_conf *gyro_conf,
> +			      struct inv_icm42600_sensor_conf *oldconf,

It's a bit odd to have 3 with _conf and one with no _
Maybe old_config?  Given you are updating it, is it really old?
Maybe just call it conf?


> +			      unsigned int reg_config0,

The number of parameters is what got me first wondering if this was
worth doing.  To me it feels of marginal benefit.

> +			      unsigned int target_config0_val,
> +			      unsigned int *sleep_ms)
>  {
> -	struct inv_icm42600_sensor_conf *oldconf =3D &st->conf.accel;
>  	unsigned int val;
>  	int ret;
> =20
> -	/* Sanitize missing values with current values */
> +	/* set target sensor's CONFIG0 register */
> +	if (target_conf->fs !=3D oldconf->fs || target_conf->odr !=3D oldconf->=
odr) {
> +		ret =3D regmap_write(st->map, reg_config0, target_config0_val);
> +		if (ret)
> +			return ret;
> +
> +		oldconf->fs =3D target_conf->fs;
> +		oldconf->odr =3D target_conf->odr;
> +	}
> +
> +	/* set GYRO_ACCEL_CONFIG0 register */

Code makes that obvious. So I'd drop the comment.

> +	if (target_conf->filter !=3D oldconf->filter) {
> +		val =3D INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(accel_conf->filter)=
 |
> +		      INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(gyro_conf->filter);
> +
> +		ret =3D regmap_write(st->map,
> +				   INV_ICM42600_REG_GYRO_ACCEL_CONFIG0,
> +				   val);
> +		if (ret)
> +			return ret;
> +
> +		oldconf->filter =3D target_conf->filter;
> +	}
> +
> +	/* set PWR_MGMT0 register */
> +	return inv_icm42600_set_pwr_mgmt0(st, gyro_conf->mode, accel_conf->mode,
> +					  st->conf.temp_en, sleep_ms);
> +}
> +
> +static void inv_icm42600_sanitize_conf(
> +	struct inv_icm42600_sensor_conf *conf,
> +	const struct inv_icm42600_sensor_conf *oldconf)

Maybe go a bit long on this one and use this style:
static void inv_icm42600_sanitize_conf(struct inv_icm42600_sensor_conf *con=
f,
				       const struct inv_icm42600_sensor_conf *oldconf)

> +{
>  	if (conf->mode < 0)
>  		conf->mode =3D oldconf->mode;
>  	if (conf->fs < 0)
> @@ -306,6 +342,17 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600_=
state *st,
>  		conf->odr =3D oldconf->odr;
>  	if (conf->filter < 0)
>  		conf->filter =3D oldconf->filter;
> +}
> +
> +int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
> +				struct inv_icm42600_sensor_conf *conf,
> +				unsigned int *sleep_ms)
> +{
> +	struct inv_icm42600_sensor_conf *oldconf =3D &st->conf.accel;
> +	unsigned int config0_val;
> +
> +	/* Sanitize missing values with current values */
> +	inv_icm42600_sanitize_conf(conf, oldconf);
> =20
>  	/* force power mode against ODR when sensor is on */
>  	switch (conf->mode) {
> @@ -324,30 +371,12 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600=
_state *st,
>  		break;
>  	}
> =20
> -	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
> -	if (conf->fs !=3D oldconf->fs || conf->odr !=3D oldconf->odr) {
> -		val =3D INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
> +	config0_val =3D INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
>  		      INV_ICM42600_ACCEL_CONFIG0_ODR(conf->odr);
> -		ret =3D regmap_write(st->map, INV_ICM42600_REG_ACCEL_CONFIG0, val);
> -		if (ret)
> -			return ret;
> -		oldconf->fs =3D conf->fs;
> -		oldconf->odr =3D conf->odr;
> -	}
> -
> -	/* set GYRO_ACCEL_CONFIG0 register (accel filter) */
> -	if (conf->filter !=3D oldconf->filter) {
> -		val =3D INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(conf->filter) |
> -		      INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(st->conf.gyro.filter);
> -		ret =3D regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_CONFIG0, val=
);
> -		if (ret)
> -			return ret;
> -		oldconf->filter =3D conf->filter;
> -	}
> =20
> -	/* set PWR_MGMT0 register (accel sensor mode) */
> -	return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode,
> -					  st->conf.temp_en, sleep_ms);
> +	return inv_icm42600_set_sensor_conf(st, conf, conf, &st->conf.gyro, old=
conf,
> +					    INV_ICM42600_REG_ACCEL_CONFIG0,
> +					    config0_val, sleep_ms);
>  }
> =20
>  int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
> @@ -355,45 +384,17 @@ int inv_icm42600_set_gyro_conf(struct inv_icm42600_=
state *st,
>  			       unsigned int *sleep_ms)
>  {
>  	struct inv_icm42600_sensor_conf *oldconf =3D &st->conf.gyro;
> -	unsigned int val;
> -	int ret;
> +	unsigned int config0_val;
> =20
> -	/* sanitize missing values with current values */
> -	if (conf->mode < 0)
> -		conf->mode =3D oldconf->mode;
> -	if (conf->fs < 0)
> -		conf->fs =3D oldconf->fs;
> -	if (conf->odr < 0)
> -		conf->odr =3D oldconf->odr;
> -	if (conf->filter < 0)
> -		conf->filter =3D oldconf->filter;
> +	/* Sanitize missing values with current values */
> +	inv_icm42600_sanitize_conf(conf, oldconf);
> =20
> -	/* set GYRO_CONFIG0 register (gyro fullscale & odr) */
> -	if (conf->fs !=3D oldconf->fs || conf->odr !=3D oldconf->odr) {
> -		val =3D INV_ICM42600_GYRO_CONFIG0_FS(conf->fs) |
> +	config0_val =3D INV_ICM42600_GYRO_CONFIG0_FS(conf->fs) |
>  		      INV_ICM42600_GYRO_CONFIG0_ODR(conf->odr);
> -		ret =3D regmap_write(st->map, INV_ICM42600_REG_GYRO_CONFIG0, val);
> -		if (ret)
> -			return ret;
> -		oldconf->fs =3D conf->fs;
> -		oldconf->odr =3D conf->odr;
> -	}
> =20
> -	/* set GYRO_ACCEL_CONFIG0 register (gyro filter) */
> -	if (conf->filter !=3D oldconf->filter) {
> -		val =3D INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(st->conf.accel.filt=
er) |
> -		      INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(conf->filter);
> -		ret =3D regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_CONFIG0, val=
);
> -		if (ret)
> -			return ret;
> -		oldconf->filter =3D conf->filter;
> -	}
> -
> -	/* set PWR_MGMT0 register (gyro sensor mode) */
> -	return inv_icm42600_set_pwr_mgmt0(st, conf->mode, st->conf.accel.mode,
> -					  st->conf.temp_en, sleep_ms);
> -
> -	return 0;
> +	return inv_icm42600_set_sensor_conf(st, conf, &st->conf.accel, conf, ol=
dconf,
> +					    INV_ICM42600_REG_GYRO_CONFIG0,
> +					    config0_val, sleep_ms);
>  }
> =20
>  int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enabl=
e,

