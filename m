Received: from skycaves.subdimension.ro (skycaves.subdimension.ro [157.180.79.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C3B248883;
	Sat, 28 Feb 2026 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.79.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772284607; cv=none; b=pWg/xDfs31PQNAnUpWMZBO2PYl3+xtFqxsrgHYkT8AoItJpmw73GGgDQG5u0sDjsGPKNWkkOieMvenDA8k/INjt9AzWdDtHIYh45o6OYeLsgnAe027daoLT1jEmWwVcB9mt8rCWqAuSo7fcyWw1fmAWUnxcEL55o0EhDzCBlG3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772284607; c=relaxed/simple;
	bh=KGNzmrJx1hmAnGZ9DVMdt7LlCL6gIhOM3brYpCP2ohM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiwhX8PxhhHb7Z4JmfUp6CYEfK7tuJ/HvlYVQ5DOAIO/ViGkuq+Rxkg5aBQDh97n9c82FGkbIc745fi48wBr+XWl5Idv3jHglx3eKuzZ0/dzuAI+qUdMzxaBGRPTKGReljdlqQ+lcHKVQGqDzb3zsU8DLDWlVrc6T+JaDSoIz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=X9ihyjdB; arc=none smtp.client-ip=157.180.79.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="X9ihyjdB"
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3013:ab00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by skycaves.subdimension.ro (Postfix) with ESMTPSA id 0BCA56546D;
	Sat, 28 Feb 2026 15:16:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1772284595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FdXsEqGA1opIM3oNfnIfap8wZspsSe10UAXblD+Bwj8=;
	b=X9ihyjdB1C0y5HkZF/WjvHyhVF/CiGGSlOoxamuHFpJKnq+iDpm4b/7fQspXl4oXzZwHvh
	1ygTAJqacLTZjqLaiDJFcdMBEsi/+cVk5pmQZsKa805ATpSsk8Aia2xlWiRiPdZTsxmzjj
	BE5LdF4RvZaL1BSbPomqvjzDxqurJQb3ZGC5WIi9iwwJWrUknBvg1UNXKoyTlB9GuUyU3g
	AzggZcnH6nKlQXvX1qXj8MAEg38fwhLe7u21ozYFfZpW2AnB39nHjwG1v96VI3b3S20ohY
	uoIXDBJh4bCdJ6TaV/H2MvzyaKKs25bTkJnrtRsLQtwvaxfmzOqaSTO/p9BBgw==
Date: Sat, 28 Feb 2026 15:16:32 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Felix Gu <ustc.gu@gmail.com>, David Lechner <dlechner@baylibre.com>,
	Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: abp2030pa: Remove IRQF_ONESHOT from
 devm_request_irq()
Message-ID: <aaLqsGEwNTlRmNJ4@sunspire.home.arpa>
References: <20260227-abp-v2-1-a482c02a5876@gmail.com>
 <20260228114823.1411901d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rAxav+xnyXlGh29c"
Content-Disposition: inline
In-Reply-To: <20260228114823.1411901d@jic23-huawei>


--rAxav+xnyXlGh29c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello!

On Sat, Feb 28, 2026 at 11:48:23AM +0000, Jonathan Cameron wrote:
> On Fri, 27 Feb 2026 21:54:29 +0800
> Felix Gu <ustc.gu@gmail.com> wrote:
>=20
> > Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
> > without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
> > in IRQ request and gives a warning if there is no threaded handler.
> >=20
> > Remove IRQF_ONESHOT from devm_request_irq().
> >=20
> > Fixes: 47d323ce1e89 ("iio: pressure: add Honeywell ABP2 driver")
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
>=20
> Applied to the fixes-togreg branch of iio.git.  If Petre wants to take
> another look and perhaps give a tag that would still be welcom.

thank you for the patch, Felix.
took me a hot minute to upgrade everything to 7.0.0, you were both too fast=
 :)

Tested-by: Petre Rodan <petre.rodan@subdimension.ro>

best regards,
peter

>=20
> Thanks!
>=20
> Jonathan
>=20
> > ---
> > Changes in v2:
> > - Fixes Petre's comment.
> > - Link to v1: https://lore.kernel.org/r/20260227-abp-v1-1-b6fed0545852@=
gmail.com
> > ---
> >  drivers/iio/pressure/abp2030pa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/pressure/abp2030pa.c b/drivers/iio/pressure/ab=
p2030pa.c
> > index 4ca056a73cef..b44f1bf4c633 100644
> > --- a/drivers/iio/pressure/abp2030pa.c
> > +++ b/drivers/iio/pressure/abp2030pa.c
> > @@ -520,7 +520,7 @@ int abp2_common_probe(struct device *dev, const str=
uct abp2_ops *ops, int irq)
> >  	data->p_offset =3D div_s64(odelta * data->pmin, pdelta) - data->outmi=
n;
> > =20
> >  	if (data->irq > 0) {
> > -		ret =3D devm_request_irq(dev, irq, abp2_eoc_handler, IRQF_ONESHOT,
> > +		ret =3D devm_request_irq(dev, irq, abp2_eoc_handler, 0,
> >  				       dev_name(dev), data);
> >  		if (ret)
> >  			return ret;
> >=20
> > ---
> > base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
> > change-id: 20260227-abp-016a007ab817
> >=20
> > Best regards,
>=20

--=20
petre rodan

--rAxav+xnyXlGh29c
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJPBAABCgA5FiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmmi6qobFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEHQrJ6djOkljKzMP/3ch4LmGEKlTfIkX/Gqp
yF0sJoFSp1BSR822PZgDD5aNAlfuatg3RwmZ3uIHH2OvlGHMhHONFVJlin59L/By
1Oby2VbHTzUp1w7vPFWPMqozkrgVKfprbPTn/kDHwvJx5XeC3gJA+QIAxVLalTwc
hFdhmMNXvox/PcJW1iPWmuziYODM4+3p93zTTUm2sWYbbtL8X0beKYfmIPAM4pe0
hzRtv1bprAZRbV+ZErG0xRJDDLh2OBR6xSbrA4Y+lz75Ni9QF/IYMfLx9dP90Iib
ndz1zpWilenmMT8KeZHn31XrTzXpPbSu+ml5mLhYmVN95DHIYg3rGOdpDpCd/WQb
osW9g85vHm+ywoiRqsplrshzR65MR1td05Y57VJRNhKmNym+0EwTmhaJo/qU+Zhi
oc9zJfDEn73p3++m4FFGbr+0RSbyPHtPDGOiEJcS052Ww30+ds2jzRYqDX6VbwDa
RQ3ig3TwNQYhLLtAdUjozb/8ycRJJee0/W0ASOeRGZxQnKCfs/TTFtSzoGoOivRe
+7QfIT4fg33ZlqsArBnJtXBiB5Exi0LDo2v/eYUXyzKlrnII5Ic1JS6YWiCi/X5u
/Dk2vwRUGcPKLC2Sm+NusZkxdsUj+OjxE477n07ciM99pFeKR1fjJ8f7u3zFvbT6
0lHSEan6Lv2ehW4km1WTao+e
=KZV9
-----END PGP SIGNATURE-----

--rAxav+xnyXlGh29c--
