Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788025;
	b=HXU9OfLRp8VMndSURJLPj1QG8jNKat1tKhoi3fnIBppOfN5D8+cH/eCSylhkQ5f0M1gF
	 vlJ06XLD7PdYjE2Yxk1WEdIRwwDyVCiEkYnDJcOnON7GFlCb8mVYoZAfPPcRWbLU3iTN4
	 pSQxpn4dFUkYO27En5dLztlhpvQsFz0mtlTMWdI+TYP5IMMcainw9ge2hF0MDjjk60MTD
	 E6egdrK3s6NP1l0ClsmCBDU8JHCrYEZxrK/gA0gpJTdhxaO7+VmQglPLo81N+AIC9pgm+
	 2XKXB05P1GF/+BMYZ7xyaSdDgR3E9Y5Sf9oR2xZhFo5feyhRKA5uCvuF7EL94nYrxQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788025;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Sj3N8ofVLmUhviS1Qitt8FcFhDmmyzbZj344e+t8UZQ=;
	b=PZSmRCNcpzSkwandC225VB+d8y3RKO3/qZzlAB7nOrq5B0MHsH6SEirn6mBVtmUuZYM9
	 RfF0c2iWGKUOm7E2QHR0Ox0knTRTA7kepccgjOhjVKXnCg6v2fwtNO9hJCbknfyVcmBmD
	 yJZJx6UALV1vH9iCKVGBtZS5xEzs5pCH99fCCLAN2lI2atlyBFYnvlHbNiV+lsjJp/Cq0
	 l8CvRY8229D9bpaI7avAy25gtFqdGSHkIs8t96TOWA8UL5VF4C10NFL9QaSY9jxLlksp6
	 bN6dmciedK+MpnPNyM8R2imy6R33RW3BDZ+Puz8vtmYEWdWQQl2T97ciGVc2oUElz2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eThajyz6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB721606A31D;
	Fri, 23 Oct 2026 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eThajyz6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C901F031E0;
	Fri, 23 Oct 2026 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792788024;
	bh=Sj3N8ofVLmUhviS1Qitt8FcFhDmmyzbZj344e+t8UZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eThajyz67bQE5cq81KRSeUm5cVIvX+5E8TJp6b2mx/A5V6GkLQmtoVqPdD2M8S5LM
	 thaFsJqpByB33EHTQMNnZFdGVFNOR/gGl0rijVKnw5ATg5BSTwTJNohMI0wbf0lRl2
	 1nN0mM5vlvnMl+JOISbp7z2cgIwkGIUcBfXwg77ucf/nFnffORKCuawUoe3UiILCTC
	 ZvwSIcvogReKnXR0/zRoq8IzT4isnXRfBJ2MuWr4jXY8OrwPG99YBi0tw+g0XbTTBQ
	 7UQsfXxKcSxoHDMQ9vVufxwCzn/XluiF2MzqQrlS3CIhEtRGjBD5WvnNGEGkAspKLl
	 hSsyjNwikcPeg==
Date: Fri, 23 Oct 2026 21:40:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adi =?UTF-8?B?S2FkdcWhacSH?= <kadusicadi1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Jorijn van der Graaf
 <jorijnvdgraaf@catcrafts.net>, Miao Li <limiao@kylinos.cn>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, "Rafael G. Dias"
 <rafael.guimaraes.dias@usp.br>, Pan Chuang <panchuang@vivo.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: stk3310: replace sprintf() with safer
 sysfs_emit()
Message-ID: <20261023214019.7861c071@jic23-hlaptop>
In-Reply-To: <20261023202543.144563-1-kadusicadi1@gmail.com>
References: <20261023202543.144563-1-kadusicadi1@gmail.com>
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

On Fri, 23 Oct 2026 22:25:40 +0200
Adi Kadu=C5=A1i=C4=87 <kadusicadi1@gmail.com> wrote:

> This patch replaces sprintf() with sysfs_emit() safer alternative
> with no functional changes.
>=20
> Signed-off-by: Adi Kadu=C5=A1i=C4=87 <kadusicadi1@gmail.com>
Applied.
> ---
>  drivers/iio/light/stk3310.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 0a16e326e939..e751e7c97bc1 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -18,7 +18,6 @@
>  #include <linux/pm.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> -#include <linux/sprintf.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
> =20
> @@ -180,7 +179,7 @@ static ssize_t stk3310_read_near_level(struct iio_dev=
 *indio_dev,
>  {
>  	struct stk3310_data *data =3D iio_priv(indio_dev);
> =20
> -	return sprintf(buf, "%u\n", data->ps_near_level);
> +	return sysfs_emit(buf, "%u\n", data->ps_near_level);
>  }
> =20
>  static const struct iio_chan_spec_ext_info stk3310_ext_info[] =3D {

