Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3330B52B;
	Thu,  5 Feb 2026 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323159; cv=none; b=cJMHs+9eFXYRSKkEjK6P7UCBoTw0G/Qip3tAqEqzzAwob/eltaV89vP+HfBoxljMVqZXjpINo211RuTRqBCWoGKjLEAbjhy+NOUHwpfoInkIyLG96AARSW62h0tT6+3a9EE1vpYoa+htQd8/D7eTDpUkYXiObjnlHVgDyoguVbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323159; c=relaxed/simple;
	bh=0l/MyWtGlSbAgtqaFAyK7ClNqPfYXptecD1qySSTre4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUuQvCWmhoTOiI/MdbGGcW+ZvWJJcm2X2S5u2Ah33NE3d+xHvoujX9JZsO78LVmE4+DzktEvSXRbrhhBjc1WcjI4rXo3dif2+vUMJd8CccNs5HfKmNFgsfOKUY1pzxqpFyE/HHaiapYielyYQiJgK3GcVQwiEPtDv4tjFrH50U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojbSmzrv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojbSmzrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DFCC4CEF7;
	Thu,  5 Feb 2026 20:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770323158;
	bh=0l/MyWtGlSbAgtqaFAyK7ClNqPfYXptecD1qySSTre4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ojbSmzrv9bMnwxuxOeqMMYMw5jNs8FJxNK0ZYzyu4idJtl5few/rMPhK9FGBTSe9x
	 1s/rxvyhZkjyfa5TQHynpFsyqS5K+SBVAxrOJH7k/LsgVs2R3fU2GKw1QxzF8VbhfD
	 eUvMO+l1auw74RPJ8Sx8U4MCicqa9pqRxfQ5VMCbuiQ/zpFufcDQGJs2G6o6CQj3Sc
	 SpAYiXdMavdXG0g4g45DsCxJxga/T7KJHNBf+vobs7wepO7ZJoLG6WtndXPCARatLi
	 Hc5qWffhXpILNDpVCz8knO2hVe1i0Wja/pkj6YcgG3e16gQOOlDWX4UFQYvQWQuIgr
	 tVOL7sE5Niqow==
Date: Thu, 5 Feb 2026 20:25:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3] iio: magnetometer: bmc150_magn: Used guard() for
 mutex protection
Message-ID: <20260205202550.7593ec18@jic23-huawei>
In-Reply-To: <20260204021241.53891-1-neelb2403@gmail.com>
References: <20260204010529.48000-1-neelb2403@gmail.com>
	<20260204021241.53891-1-neelb2403@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  3 Feb 2026 21:12:41 -0500
Neel Bullywon <neelb2403@gmail.com> wrote:

> Replaced the manual mutex lock/unlock calls using guard() to simplify
> the error handling and reduce goto statement usage.
>=20
> By using RAII-style cleanup, it ensures the mutex is always released
> when exiting the function, regardless of the return path taken.
>=20
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Looks like this needs to have=20
#include <linux/cleanup.h>
as first use of this stuff in this particular file.

=46rom a quick look it seems to me that there might be other potential
similar cases in this file that would make sense to include as part of this
patch.  Perhaps you could take a look at those?

In some places it is in a switch statement so you'd have to
add {} to define the scope, or use scoped_guard() as appropriate.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magneto=
meter/bmc150_magn.c
> index 6a73f6e2f1f0..bd2706c2078d 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -794,32 +794,25 @@ static int bmc150_magn_data_rdy_trigger_set_state(s=
truct iio_trigger *trig,
>  {
>  	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
>  	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> -	int ret =3D 0;
> +	int ret;
> +
> +	guard(mutex)(&data->mutex);
> =20
> -	mutex_lock(&data->mutex);
>  	if (state =3D=3D data->dready_trigger_on)
> -		goto err_unlock;
> +		return 0;
> =20
>  	ret =3D regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
>  				 BMC150_MAGN_MASK_DRDY_EN,
>  				 state << BMC150_MAGN_SHIFT_DRDY_EN);
>  	if (ret < 0)
> -		goto err_unlock;
> +		return ret;
> =20
>  	data->dready_trigger_on =3D state;
> =20
> -	if (state) {
> -		ret =3D bmc150_magn_reset_intr(data);
> -		if (ret < 0)
> -			goto err_unlock;
> -	}
> -	mutex_unlock(&data->mutex);
> +	if (state)
> +		return bmc150_magn_reset_intr(data);
> =20
>  	return 0;
> -
> -err_unlock:
> -	mutex_unlock(&data->mutex);
> -	return ret;
>  }
> =20
>  static const struct iio_trigger_ops bmc150_magn_trigger_ops =3D {

