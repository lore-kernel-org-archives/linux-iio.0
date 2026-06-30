Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9BB2ECD32;
	Tue, 30 Jun 2026 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860381; cv=none; b=UwUN5dO6U2DQsGE/pxV83n5x1USsaBqQYA96VmaScKKIJCIoVCi8Wup/gdQNV+oRHuq5B7LsUmEUt8FWHx9++uzfovnfjeWlfqhFQWSIPTVuX/M1eaMIR6tEaMRzRhkrjLHEBZ7AllETw2NfuoWwaHv2pAHTKVj7B3VXTGnaxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860381; c=relaxed/simple;
	bh=osL3uTJhTm9LSLp2YQOww4VTQarThaS3fqxKF5kmtwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbKbuSYL3a7HY4FxRvQv2W2sqkCdrC9jqcNzYYwyYIuhLOOJxHfBXtBl70hWqVDi7S+F0C3XeLsonCgg86eXdVzHyfCZcDtnXoDKydnZjLA+T6Zi6v91jkaH7r7bn+fIVFyyrB0LUguP0Ho9kKLIRDQ3enW6L6HHt/E6xTyCaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm9De9GY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm9De9GY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA291F00A3A;
	Tue, 30 Jun 2026 22:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782860379;
	bh=hpGHznkuiVzbCssE8nF1WP+hU9QiCHLL5//s39XABS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mm9De9GY9AnlBfnkQ9gv0ORM7La070SlXrEbmoHfUfxOBaaYtLJzUqs9PXOSo5uvx
	 x8ahgeal3hZOtIlVzn+sGWk2Wd9jC54VlkmDT+j5eym3wm5AyGxRApheO30IDwD0K2
	 QdandJ9p+VqURQ55EBEevLOY9PD2oxYa3D+5N4hcCkk1dxrxTbWQmt0dW7EiJpPW5G
	 b46VcVPSt/7ODA+Cf+2Qz5OPJ8C8iyGxJyl1JksTpn0JixooJbhtizar1JMDgq1vyl
	 uSARJIL8TJdfN7XRf+Dd3m/PbdMBkIu5nYFVZcm4oktRv733+3Li6DDj1RcA9xv49a
	 VbgZsQ9v79akg==
Date: Tue, 30 Jun 2026 23:59:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: iio: Initialize spi_device_id arrays
 using member names
Message-ID: <20260630235935.4cfa827c@jic23-huawei>
In-Reply-To: <4c743f86ca4072d34d715333589aa540aed895f2.1782833415.git.u.kleine-koenig@baylibre.com>
References: <cover.1782833415.git.u.kleine-koenig@baylibre.com>
	<4c743f86ca4072d34d715333589aa540aed895f2.1782833415.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jun 2026 17:35:36 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>=20
> The mentioned robustness is relevant for a planned change to struct
> spi_device_id that replaces .driver_data by an anonymous union.
>=20
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Link: https://patch.msgid.link/cac7a68e6a6adb1b58207640ab045e59eec86f53.1=
781883685.git.u.kleine-koenig@baylibre.com
Given I messed up applying this in v1, picked up now.

Thanks for catching that miss!

Jonathan

> ---
>  drivers/staging/iio/adc/ad7816.c       | 6 +++---
>  drivers/staging/iio/frequency/ad9834.c | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/a=
d7816.c
> index 0e32a2295990..30644d2d7c54 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -426,9 +426,9 @@ static const struct of_device_id ad7816_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, ad7816_of_match);
> =20
>  static const struct spi_device_id ad7816_id[] =3D {
> -	{ "ad7816", ID_AD7816 },
> -	{ "ad7817", ID_AD7817 },
> -	{ "ad7818", ID_AD7818 },
> +	{ .name =3D "ad7816", .driver_data =3D ID_AD7816 },
> +	{ .name =3D "ad7817", .driver_data =3D ID_AD7817 },
> +	{ .name =3D "ad7818", .driver_data =3D ID_AD7818 },
>  	{ }
>  };
> =20
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio=
/frequency/ad9834.c
> index 4359b358e0e5..f95c5365cd03 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -465,10 +465,10 @@ static int ad9834_probe(struct spi_device *spi)
>  }
> =20
>  static const struct spi_device_id ad9834_id[] =3D {
> -	{"ad9833", ID_AD9833},
> -	{"ad9834", ID_AD9834},
> -	{"ad9837", ID_AD9837},
> -	{"ad9838", ID_AD9838},
> +	{ .name =3D "ad9833", .driver_data =3D ID_AD9833 },
> +	{ .name =3D "ad9834", .driver_data =3D ID_AD9834 },
> +	{ .name =3D "ad9837", .driver_data =3D ID_AD9837 },
> +	{ .name =3D "ad9838", .driver_data =3D ID_AD9838 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ad9834_id);

