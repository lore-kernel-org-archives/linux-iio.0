Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703C1FB1;
	Sun, 22 Feb 2026 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771785634; cv=none; b=aNgicvd2eQAsfMrNuLYPDY3p6rJLLRV0boQ77FySwRF/O9760IxFy9+Y1uDfZAx0HdxkDaBHi+fqr9s72zZ69COBgT19ad/jLLEnZc1D8RSCS7Ahz6ulKwWT6hJPLStAjEwbGF0TgXBw6cX2ixn+g9Xlk31RbOIjRDivxOswKe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771785634; c=relaxed/simple;
	bh=YgGYcrOUqWVOPgUwJJrjX0jwYIJUOPBpJVNOpR4hNwQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Or3tYKhlGhT5AYlHLbRgRz/nbsyEibXdSkCmOV61EC33NiTTubiABcDkGc7uVV5q5A5R/gwmSoQ/lxl/PWghMJXDVTWCXDCdjE3H2mqtNcvdLhtmQ6dhTfrgQnPyVIwPrEwmEVRLbqZMK9Ibt+lGlHZpQ+cL0DnQt8VDoyoS+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=MmGcFmUr; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="MmGcFmUr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1771785161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vH/aTJXZM/s9zD1ltReAAPSsBXJf9aC4/sh1vnIe8hk=;
	b=MmGcFmUrAZpuLU+olgXhEI77im9Efpz4ov1rcOQrIo1L1E8DgyZYZb6jnVKxX9hSaHGBiN
	NjlW4TNoFu1WqnvKWh85GIHei4up8kf7scIKXq+kBCYNeJAPeEdBLvtgkV9kMCpshW0xjy
	lFZZkcnVLySWtENL6h0noP/lz3o+2tA=
Message-ID: <d09f49f7d7643fae6cba6d7b140302cd9c38a62f.camel@crapouillou.net>
Subject: Re: [PATCH 1/2] iio: pressure: mpl115: add system suspend/resume
 support
From: Paul Cercueil <paul@crapouillou.net>
To: Jonathan Cameron <jic23@kernel.org>, Neel Bullywon <neelb2403@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J.
 Wysocki"	 <rafael.j.wysocki@intel.com>
Date: Sun, 22 Feb 2026 19:32:38 +0100
In-Reply-To: <20260222164008.7fed0ff4@jic23-huawei>
References: <20260221172601.77818-1-neelb2403@gmail.com>
	 <20260222164008.7fed0ff4@jic23-huawei>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le dimanche 22 f=C3=A9vrier 2026 =C3=A0 16:40 +0000, Jonathan Cameron a =C3=
=A9crit=C2=A0:
> On Sat, 21 Feb 2026 12:26:00 -0500
> Neel Bullywon <neelb2403@gmail.com> wrote:
>=20
> > The driver currently only implements runtime PM callbacks to
> > control
> > the shutdown GPIO, but lacks system suspend/resume support. This
> > means
> > the device may remain powered during system sleep, wasting energy.
> >=20
> > Add system sleep PM ops using pm_runtime_force_suspend() and
> > pm_runtime_force_resume() to properly synchronize the runtime PM
> > state
> > across system suspend/resume cycles. This ensures the shutdown GPIO
> > is
> > asserted during system sleep when the device has a shutdown GPIO
> > configured.
> >=20
> > Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
>=20
> Interestingly for the non exported version we have
> DEFINE_RUNTIME_DEV_PM_OPS()
> and the docs for that suggest we should use
> EXPORT_RUNTIME_DEV_PM_OPS() but as you've realized that doesn't set
> the
> suspend and resume callbacks. If that was intentional then the
> documentation
> is less than clear (and I don't remember that being the intent)
>=20
> +CC Paul and Rafael.
>=20
> We have very few users of these macros, so it should be easy enough
> to
> make the export variants consistent if we want to.

Looks like the users are all in IIO which makes it even more
convenient.

It's been a while so my memory is fuzzy, but it would make sense to
have the suspend/resume callbacks, indeed.

> Jonathan
>=20
> > ---
> > =C2=A0drivers/iio/pressure/mpl115.c | 6 ++++--
> > =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/pressure/mpl115.c
> > b/drivers/iio/pressure/mpl115.c
> > index 830a5065c008..29794ce53bc6 100644
> > --- a/drivers/iio/pressure/mpl115.c
> > +++ b/drivers/iio/pressure/mpl115.c
> > @@ -244,8 +244,10 @@ static int mpl115_runtime_resume(struct device
> > *dev)
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > -EXPORT_NS_RUNTIME_DEV_PM_OPS(mpl115_dev_pm_ops,
> > mpl115_runtime_suspend,
> > -			=C2=A0 mpl115_runtime_resume, NULL,
> > IIO_MPL115);
> > +EXPORT_NS_GPL_DEV_PM_OPS(mpl115_dev_pm_ops, IIO_MPL115) =3D {
> > +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > pm_runtime_force_resume)
> > +	RUNTIME_PM_OPS(mpl115_runtime_suspend,
> > mpl115_runtime_resume, NULL)
> > +};

One thing I noticed is that now the symbols are exported as GPL, which
is probably fine (better than the other way around) but if that was on
purpose, it should at least be mentioned in the commit message.

Cheers,
-Paul
