Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822E3BBA04;
	Sat, 17 Oct 2026 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792268923; cv=none; b=otbX8duE0QhzIr/cHXGgFwv8kjuTIgVqrkrym8yXZ9IILGSQ9LTD9F3eubSIeukZ/YhLUBKpc0Q3ECtaaCeCoXuDAYx+vGr188623EKMF4x8acOmAmF9h/pl6oiuTJBQrYZFEW0vKKR+gizx3VVlkt3qkRJ56uskTuI61zTBi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792268923; c=relaxed/simple;
	bh=kEiSxuOqtCpX5TGbh/HQD8KrZIp+uST+kLyovhv2jMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYiS6zQRZn0wyoKFroehVYAtF9z/+J73Ogyc0S9fSSaNiN455ZMJ0AMXpiO9S1DGkwWYlIwuXw38E1+mpWJWtPVtj7vZtaL4qQ+ltBrOPOR5gByNvnobJkgwkz9SCAHnnTrR7ztJJhT6L6D0fEikx/Bnaoe7mwh/UWmNjvD7uY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhPLSzHv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhPLSzHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41791F000C4;
	Sat, 17 Oct 2026 20:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792268921;
	bh=eztiBbz0hHSLA0rg19Q99Plggh4R5jSlD7UXFCPsnDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dhPLSzHvss9ECPD4QSQmRWgtjsa4DCWr8iO5QaPPyDV4sx+AGbyk5Fkf/wTxXPPd8
	 f8tqyFHwno8KUg6mV78YwpD87wgYRR8l/kogbtyqeNr6W28HbT8XuWc+qkCENcIem5
	 g+irmYtMhrphPGtK3fL8KIy/pXdeCRSdGLQtqVkF7jyeIjzPtYK0Qce8D1TsVaB9kW
	 1dq552gtpmifFhNRSQimg8tH1xrvqM5RpP4Pj8v5SS1RGVjpHonVZ08KBBYM8yk4gK
	 Z9LgAV17R302w2bdnOnYKXhX7wlgbZDYGB4jWiSosabTAEeupcFPQKs58tS69Ln+oX
	 pt3lrZMcCDN1w==
Date: Sat, 17 Oct 2026 21:28:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Rodrigo Alencar
 <455.rodrigo.alencar@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, Olivier Moysan
 <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 02/10] iio: backend: add devm_iio_backend_get_optional()
Message-ID: <20261017212834.002392c6@jic23-hlaptop>
In-Reply-To: <atIt3eXNeTT7cqxH@nsa>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
	<20261015-ad9910-backend-support-v1-2-3c21648c8e26@analog.com>
	<atEeZPOLASHAcnjF@ashevche-desk.local>
	<atHjHqyxXj6jkObW@nsa>
	<w7waqang6lriwbcq6o5s5yuedouuwgacmnj55qsjpzjrv3jut2@cthvkakgyhpi>
	<atIkZa0noHjcl13X@ashevche-desk.local>
	<atIt3eXNeTT7cqxH@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Oct 2026 15:07:02 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Fri, Oct 16, 2026 at 04:19:33PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 16, 2026 at 08:18:08AM -0300, Rodrigo Alencar wrote: =20
> > > On 16/10/26 09:45, Nuno S=C3=A1 wrote: =20
> > > > On Thu, Oct 15, 2026 at 09:41:40PM +0300, Andy Shevchenko wrote: =20
> > > > > On Thu, Oct 15, 2026 at 01:49:42PM -0300, Rodrigo Alencar via B4 =
Relay wrote:
> > > > >  =20
> > > > > > Frontend devices might not need a backend driver to rely on. An=
 IIO device
> > > > > > that supports backends can behave differently when they are not=
 available
> > > > > > and that should be acceptable. Such parts may provide basic fun=
ctionality
> > > > > > solely using the control interface (SPI for instance), being ab=
le to have
> > > > > > extended features when a backend is present.
> > > > > >=20
> > > > > > Add devm_iio_backend_get_optional(), which returns NULL when th=
e backend
> > > > > > is not described in firmware, i.e., when the io-backends proper=
ty is not
> > > > > > present or, for a named lookup, when the name is not listed in =
the
> > > > > > io-backend-names property. Other errors, such as probe deferral=
, are
> > > > > > still returned.
> > > > > >=20
> > > > > > To make that possible, a named lookup that does not match any e=
ntry of
> > > > > > io-backend-names now fails with -ENOENT, the same error returne=
d when the
> > > > > > io-backends reference is missing. Also, the missing reference i=
s no longer
> > > > > > logged as an error, leaving that to the caller. =20
> >=20
> > ...
> >  =20
> > > > > >  		ret =3D device_property_match_string(dev, "io-backend-names"=
, name);
> > > > > > +		if (ret =3D=3D -EINVAL || ret =3D=3D -ENODATA)
> > > > > > +			return ERR_PTR(-ENOENT); =20
> > > > >=20
> > > > > No. Please, use device_property_present() instead. =20
> > > >=20
> > > > Oh right! Totally forgot about that internally :). And it fits into=
 my
> > > > internal point where I don't agree much in treating -ENODATA the sa=
me
> > > > way as property does not exist. =20
> >=20
> > +1
> >  =20
> > > Say a frontend consumes multiple backends, but some of them are optio=
nal.
> > > If we care only about the presence of the property we would fail when
> > > trying to acquire the optional ones when the required ones are define=
d.
> > > am I thinking correctly? =20
> >=20
> > If there is an empty property for names, shouldn't we simply fail? I ra=
ther
> > would consider the firmware table to be broken in such a case. =20
>=20
> What Rodrigo is saying is that an IIO frontend driver can have multiple
> backends. So in practice:
>=20
> io-backend-names =3D "foo", "bar";
>=20
> But we might want to have foo as optional while bar is mandatory so that
>=20
> io-backend-names =3D "bar"

Not sure mandatory or not is relevant.  Two optional backends where the
driver can run with either or both of them would hit the same problem of
present property but particular backend not being there.

>=20
> So if we treat all errors (after checking for presence) the same we will =
fail
> in the optional one. Note -ENODATA also means match_string() failed.
>=20
> As of now there's no such usecase in tree or oeven out of tree (that I'm
> aware of) but to support it is also fairly simple that I don't mind to
> have it now.

I'm in two minds over this. It's unused complexity, but it also makes the
function behave how a user might expect.  Definitely needs some
good justifying comments in the code though as it will look weird!

Jonathan


>=20
> - Nuno S=C3=A1
>=20
> >=20
> > --=20
> > With Best Regards,
> > Andy Shevchenko
> >=20
> >  =20

