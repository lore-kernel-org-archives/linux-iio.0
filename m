Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C403A874A;
	Tue, 23 Jun 2026 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248099; cv=none; b=tmXbnAvtIkrMzoWqe1HLuweTNqQ5NZpVBXDdFVWNa17XC6DKMOUJS+Fzq2XxP6ZxEhw6JfmxtmqRe+LuOZ+QpevRCq4XBFz5oNW64l6MsFy5TKY0ObteVTM+o+XS1auC4wgHiGE3h1QVEb9CgPuZUT2Ch7Gcl3w+Kuk0fQthH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248099; c=relaxed/simple;
	bh=MIBL/m8T9jEheydwkOXje8ZP/o4Fk8twQ0dlwjH+UIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T25Yd6zakx1XvS19wYq8joUpDV4txw6nrHzZ9NZzdGfiejHEpYzbS6Y0U2mYCX4jKR3ct0X5sgtWlsYvYJhV+ohuFJztSZOi7P1pJyZ/MoT1oz56k5nPt6dEowAzKzRrwxCkZpAtLcbTWYRaVXGRv+e8xf/UCEgoTgtdG4kIGBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc/5Hpmh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc/5Hpmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E2B1F000E9;
	Tue, 23 Jun 2026 20:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782248098;
	bh=3Z2m5HL3dIMP9dzo+IjA5mpCJbOBbK63u0woQAg54d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vc/5Hpmhc6ijBdo9o3EEMEYDkxJSalXiEqkmpagk5KS8fVui0pmMMjt11f64QxlX7
	 xQHh51Gzqmo/GgwQ8OMafEnNjQDDfR5n76lxQJf06BQnOVPVxkXENq4yjApoqVCnyG
	 SNOoz1m0icS0nkK7YrKW8BWROFCOHwTZGmFaCLTW9RWbk6VOz66Yw7lqO3Pc5ZaVBv
	 pel6bS5TFGZssEtI5L87h49heoDW2pQkoqppFAOon1yNLq18i8sNvn0EqiYIG/axVD
	 oTEsT2pH+d1KkHJ6YcGWidAxO0vlJya1aEXFuCv23Eh8/YfRdTIgEJLKmtsVqSOKuz
	 OATpiXTIzSfog==
Date: Tue, 23 Jun 2026 22:54:56 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andreas Kempe <andreas.kempe@actia.se>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Message-ID: <ajryoPwnsuGHVTeh@lore-desk>
References: <20260604132646.1099072-1-andreas.kempe@actia.se>
 <aiGH7x531jwzOVxF@lore-desk>
 <aiGKz9iMAUfFqxUP@w570anl.actianordic.se>
 <aiGNeKTzOR30w-Qf@lore-desk>
 <aiGZxzz8DF-E-tux@w570anl.actianordic.se>
 <CAMknhBG+u__qiLv0aRLYnUW3iYXkYDLHveQ-bs2gGZfBAD6Viw@mail.gmail.com>
 <aiGmfzaSj3bNyXkM@w570anl.actianordic.se>
 <20260605131518.072dad20@jic23-huawei>
 <aiLS232YzmDvXhsN@w570anl.actianordic.se>
 <20260605151320.415cc432@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y6UqsksppPwpWosT"
Content-Disposition: inline
In-Reply-To: <20260605151320.415cc432@jic23-huawei>


--Y6UqsksppPwpWosT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 5 Jun 2026 13:44:59 +0000
> Andreas Kempe <andreas.kempe@actia.se> wrote:
>=20
> > On Fri, Jun 05, 2026 at 01:15:18PM +0100, Jonathan Cameron wrote:
> > > On Thu, 4 Jun 2026 16:23:27 +0000
> > > Andreas Kempe <andreas.kempe@actia.se> wrote: =20
> > > > On Thu, Jun 04, 2026 at 06:14:11PM +0200, David Lechner wrote: =20
> > > > >
> > > > > How about setting the SW_RESET bit in the CTRL3_C register during
> > > > > probe too to ensure the rest of the registers are in a known stat=
e?
> > > > > =20
> > > >
> > > > While the shub register file is selected, the reset register is
> > > > shadowed so it can't be written without first selecting the normal
> > > > register file. A reset is already called from probe in
> > > > st_lsm6dsx_init_device() after the whoami check has passed. =20
> > >=20
> > > The fix is fine, but I think it shouldn't be buried in the whoami
> > > check as it's a bit of a weird side effect.  I'd like a top level
> > > function that we can see in probe(). That can do the read + write
> > > if necessary sequence you have in this patch.
> > >=20
> > > This driver currently hard rejects unknown wai values (which it proba=
bly
> > > should not given fallback compatibles should work). Lets assume that =
will
> > > get resolved at somepoint and so the wai gate is advisory only. That
> > > means that the dance to avoid writing to a device that doesn't match =
will
> > > no be useful anyway.
> > >=20
> > > As such, I'd prefer this 'reset of the register file mux selector' was
> > > part of the reset function and that was simply called before checking
> > > WAI.  It fits more logically there than in the whoami check function
> > > which is just the first place the unexpected setting causes problems.
> > > That is put it in st_lsm6dsx_reset_device() and call that before
> > > st_lsm6dsx_check_whoami().  Maybe with a comment to justify that.
> > >  =20
> >=20
> > I agree fully that its current placement in st_lsm6dsx_check_whoami()
> > is not optimal.
> >=20
> > The reason I put the fix where it is, is because=20
> > st_lsm6dsx_check_whoami() is what assigns hw->settings needed for
> > st_lsm6dsx_set_page() to work. I moved that assignment to before the
> > whoami check for that very reason.
> >=20
> > As I see it, moving my fix to a more reasonable place would mean a
> > larger restructuring of the driver or making the whoami check advisory
> > per your suggestion.
>=20
> That feels unwise (even though it would work) as a fix for this issue.
> People would get very confused at the informational print.
>=20
> Ok. I guess maybe this is the best we can do.
>=20
> Lets see if Lorenzo is happy with earlier part of this thread

I am fine with fixing the issue in st_lsm6dsx_check_whoami().
For simplicity, I suggest to always disable page_mux if supported by the hw.
Something like:

static int st_lsm6dsx_check_whoami()
{
	...
	if (hw->settings->shub_settings.page_mux.addr) {
		/* Please add a comment here explaining the issue */
		err =3D st_lsm6dsx_set_page(hw, false);
		...
	}

Regards,
Lorenzo

>=20
> Jonathan
>=20
>=20
> >=20
> > Best regards,
> > Andreas Kempe

--Y6UqsksppPwpWosT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajryoAAKCRA6cBh0uS2t
rCgwAQCslPlMXAiUlPBJBT9Q7iNOd7Hq5C5WN+L8FB+nRcq1qQD/dQZZvH775aur
qdxveuzaLDLfAjE2ubacWhbIeG9oFgc=
=BCnd
-----END PGP SIGNATURE-----

--Y6UqsksppPwpWosT--
