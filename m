Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A8D30F52B;
	Thu, 22 Jan 2026 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109322; cv=none; b=spTejRZzie+cx6VqS7kFDw/LlzEHeznlOAhRc5bR5htMgU/E/mw+9hUn/+y2Go+VBDwh5bKbBFS2dHHWSqRDc355gzxQWuFRLxeanMBQLUraAb3VY1pKiNOnHg+gGZd9PX38/FPcJNxl4EMjUo4CCvw7AMbxnD18pQG7fwjuFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109322; c=relaxed/simple;
	bh=7Jl5E5KkPzQnVVwZ6kadxvQ5BzsBWFNS7T3cU6d6uqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beQlYDX5urVrzV7gIsEpGgE6l2MJmQtJwHgSCFwiVjmP5lZgmYVas5Pe0WVo/7slbQdK+9kzm1h143DT+Cd55XMxhz9ugOVLsl4Q4WhG4IvkgFRROSVa0re1R/lMU0J7S98Vk302y8K4TYdML3I4xQGya/l0LBRh7beFerNiM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiet4xtR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiet4xtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3247CC116C6;
	Thu, 22 Jan 2026 19:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769109320;
	bh=7Jl5E5KkPzQnVVwZ6kadxvQ5BzsBWFNS7T3cU6d6uqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eiet4xtRtY4kY7O9MpOhxhCu4d/jU83iMsvMdeU3ejAN7H7/e4XmFrAw93NJWkoXd
	 +w3lxh5Ggp29w6as2J3UHO8cS+ca9dp80UeRzTmznTCPjHMS/igvlc5SbiDPSA8/ZQ
	 5Wf27+GFhUI80yZX1h13G57AD4GxEy80huzWO2Y3C4InP0onYZbkHnEp5ZOXVLD70L
	 uVI1MYYGtzkYSCCLEnJELGk7jQ+eOcOJE2UNDZqTWJw8JGSyJMLujTHgys/VUVt+fF
	 xHdHspjnPZ8LCi8dz8QlJUMIZ+7s8Cd0iV93k+KxsopecNw08zgIqMMhlFYcUWg2/t
	 f6CUTwBRDOZ3w==
Date: Thu, 22 Jan 2026 19:15:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Benson
 Leung <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
Subject: Re: [PATCH v5 6/7] iio: health: max30102: Use IIO cleanup helpers
Message-ID: <20260122191510.2aca6bef@jic23-huawei>
In-Reply-To: <20260120-lock-impr-v5-6-d4d22347041f@gmail.com>
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
	<20260120-lock-impr-v5-6-d4d22347041f@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 01:20:46 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Use IIO_DEV_GUARD_CURRENT_MODE() cleanup helper to simplify and drop
> busy-waiting code in max30102_read_raw().
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
FWIW this and the next one trip up sparse as well :(

> ---
>  drivers/iio/health/max30102.c | 33 +++++++++------------------------
>  1 file changed, 9 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 6918fcb5de2b..47da44efd68b 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -467,44 +467,29 @@ static int max30102_read_raw(struct iio_dev *indio_=
dev,
>  			     int *val, int *val2, long mask)
>  {
>  	struct max30102_data *data =3D iio_priv(indio_dev);
> -	int ret =3D -EINVAL;
> +	int ret;
> =20
>  	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_RAW: {
>  		/*
>  		 * Temperature reading can only be acquired when not in
>  		 * shutdown; leave shutdown briefly when buffer not running
>  		 */
> -any_mode_retry:
> -		if (!iio_device_try_claim_buffer_mode(indio_dev)) {
> -			/*
> -			 * This one is a *bit* hacky. If we cannot claim buffer
> -			 * mode, then try direct mode so that we make sure
> -			 * things cannot concurrently change. And we just keep
> -			 * trying until we get one of the modes...
> -			 */
> -			if (!iio_device_claim_direct(indio_dev))
> -				goto any_mode_retry;
> +		IIO_DEV_GUARD_CURRENT_MODE(indio_dev);
> =20
> -			ret =3D max30102_get_temp(data, val, true);
> -			iio_device_release_direct(indio_dev);
> -		} else {
> -			ret =3D max30102_get_temp(data, val, false);
> -			iio_device_release_buffer_mode(indio_dev);
> -		}
> +		ret =3D max30102_get_temp(data, val, !iio_buffer_enabled(indio_dev));
>  		if (ret)
>  			return ret;
> =20
> -		ret =3D IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
> +	}
>  	case IIO_CHAN_INFO_SCALE:
>  		*val =3D 1000;  /* 62.5 */
>  		*val2 =3D 16;
> -		ret =3D IIO_VAL_FRACTIONAL;
> -		break;
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
>  	}
> -
> -	return ret;
>  }
> =20
>  static const struct iio_info max30102_info =3D {
>=20

