Received: from skycaves.subdimension.ro (skycaves.subdimension.ro [157.180.79.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC278427A05;
	Thu, 26 Feb 2026 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.79.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136855; cv=none; b=ti04vYrHj+z/2/0NGTQAXG87IRAVZemmW3WLemxQbLl71tfGbmSPVdIOkPHpv7GidUO/x8X2Z85pYTOEnl1MAACgk/y0uLKkE7WXz/I8vpAiOxcw31q1w/C0kJ0Eljj1GTmfHCSOs5AygKjs6WdXlWqp6ifmlsSgwayUY8a5F7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136855; c=relaxed/simple;
	bh=qk1FHmZgRR3d/mTRIXi6Yrws+3hu6vXGumt+uj61XLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3AX8zMYsjocQliu4z4jLHW7NQu8XcCs8LtHLSZ/HTC2P4FdEWji0Q+7tYVrjdsYqCGjytxPwZoti49CU4TSH74Q35Iq36RIHN8O16/gRMdBAskF1kn+mLXK+TRNVUvLp+ANIanzPlNwBEAg9pouSVOw7jP9CIQnedAw/nRseQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=MBTNvOuY; arc=none smtp.client-ip=157.180.79.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="MBTNvOuY"
Received: from lipo.home.arpa (unknown [188.27.131.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by skycaves.subdimension.ro (Postfix) with ESMTPSA id 6F66E6546D;
	Thu, 26 Feb 2026 22:04:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1772136294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TOn63Eg5/y5RUXq9tse/LgGdltAbj9ysJfTjNNM6QhU=;
	b=MBTNvOuYxZq6mkUL8AH81LP4pce6nEEOpJ71H+thL+7tx7nFmNLPNbXuHohOphb8IszZ2Q
	1CMyGLmaJrXYFdmsH9Fs3UbFCHEcw7uik5F0ZUywe6ov3FoSNlHj+uvFd9VQKI8sdb70Cy
	EeFmUoiYCNEOLRB9ck7YLd4OiK/pqP1IfHnmUqR9JRicedRyQVElHp5bUp4N5pemEEgyBh
	XoxDFXV+LydUFsqw33U1BqqWwNcqWOb8nQ+eyp72UyXIyH2KiTe9DesEUb4ryogxwjvBEa
	w3dt7rTYA+whgT0yP0H8lfe5An+CMRkpHXnFbGBw4wKmqy4eUGE+i4BXsofy7w==
Date: Thu, 26 Feb 2026 22:04:51 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: abp2030pa: Replace IRQF_ONESHOT with
 IRQF_NO_THREAD
Message-ID: <aaCnYxWE8vuOEimE@lipo.home.arpa>
References: <20260227-abp-v1-1-b6fed0545852@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i53ZVNQLy00triIt"
Content-Disposition: inline
In-Reply-To: <20260227-abp-v1-1-b6fed0545852@gmail.com>


--i53ZVNQLy00triIt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello,

based on previous feedback [1] IRQF_ONESHOT should be replaced with 0.

[1] https://lore.kernel.org/linux-iio/20260114121448.00000249@huawei.com/

best regards,
peter

On Fri, Feb 27, 2026 at 12:43:51AM +0800, Felix Gu wrote:
> Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
> without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
> in IRQ request and gives a warning if there is no threaded handler.
>=20
> Replace IRQF_ONESHOT with IRQF_NO_THREAD.
>=20
> Fixes: 47d323ce1e89 ("iio: pressure: add Honeywell ABP2 driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/iio/pressure/abp2030pa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/pressure/abp2030pa.c b/drivers/iio/pressure/abp2=
030pa.c
> index 4ca056a73cef..858e13e02bb4 100644
> --- a/drivers/iio/pressure/abp2030pa.c
> +++ b/drivers/iio/pressure/abp2030pa.c
> @@ -520,7 +520,7 @@ int abp2_common_probe(struct device *dev, const struc=
t abp2_ops *ops, int irq)
>  	data->p_offset =3D div_s64(odelta * data->pmin, pdelta) - data->outmin;
> =20
>  	if (data->irq > 0) {
> -		ret =3D devm_request_irq(dev, irq, abp2_eoc_handler, IRQF_ONESHOT,
> +		ret =3D devm_request_irq(dev, irq, abp2_eoc_handler, IRQF_NO_THREAD,
>  				       dev_name(dev), data);
>  		if (ret)
>  			return ret;
>=20
> ---
> base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
> change-id: 20260227-abp-016a007ab817
>=20
> Best regards,
> --=20
> Felix Gu <ustc.gu@gmail.com>
>=20

--=20
petre rodan

--i53ZVNQLy00triIt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJPBAABCgA5FiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmmgp1wbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEHQrJ6djOkljfZEP/iQZ7TiiTbVjF3l7ADy8
01cNFGthQAOK6eYIfZmS4g487Kzkb1LRAGmeVqLTO8tHLbZgUl7nmFAZgG+ktsVS
lJyH7yTKYdGrO037Zrui3eBehGj8egTLzdRzNdV257i41IT01qcjdCutiG9Xsytz
ufaNNioQ0JNmfxq/SUbVB+kmm3sIwDpTD7YHC/BbTqNt65TIsp+rYKLiCJREEhM3
PyXQ90saGnm7rGjfB7jZvo4gbUjM680a4cnv+r+YhjC1i4n/BOWbYzuvRXS4fzju
U5b6XeakwIXAzBt3lua33g+l5hiTSrAPjw0nP0du1i1iS7KbplE70vQHtVHrUVEJ
eXEeFePBSTTlWEgkbh6GXjKHiStmtpailEnZvfMS33BZk9EwVprR0Ckr1t9RzgH7
9cIh6OzrtLPEYhxUcXsAOtqxx1Ph56dxojFF9dAwPDebEHQUXw9soZWuKlMQlOQD
nOEXH7FWcJDLDPX1KFqvof8euaJolRrCn1BFxmekGui1E350YoRiYbNUAgRqQb4Y
YoENuDt2cGFkCGl+nfLbClwv3wNvwSSWTCpPTxXbeeCed0QVgK/UFALIEO8skIm3
9VrK8oMSI2FddJbX7+x3jP48p2j4GNP1mct8cRvPfqvp7akWv2PpjFgxBgfDWY3r
8G4nJs7os+qpMNZKKOM2ziFZ
=QeAi
-----END PGP SIGNATURE-----

--i53ZVNQLy00triIt--
