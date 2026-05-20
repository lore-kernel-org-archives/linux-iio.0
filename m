Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A323392C;
	Wed, 20 May 2026 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290121; cv=none; b=PSoHcJFD8D2VMknzpmcUe7YBIRKM0htoa2YvMksWp5ILVq6ZRAvKflPKQAOhC7T2fweDxreUqRfAHw33ChD8qfLZWLDfompECeIq2cv65ZD2EHlKk4yydjabbpImNJouFiwyCvBS4jr9edbqDnEE28d86fxKY96zVLN2h9vb4z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290121; c=relaxed/simple;
	bh=NZSgKFgG2uLnybY8Ey86rps1JwEUPARwcBbuVqSMbg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyvNf8qjkqAwcedhqUA2MdertImLKLstrPjBctfZPDD8e4YvCIOXHeQa+/5mLaHpFk0SLp4wwYbN0V3fifPZBJwKcu3NPI1f90Y05KvFpKF4ir/MW5XWXshHN28PIK/3NuqKFx+srixWZn2pLnCJxlYRv5nkUoXqCFF2N+NVMyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4ehVveg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4ehVveg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F20C1F000E9;
	Wed, 20 May 2026 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290120;
	bh=NZSgKFgG2uLnybY8Ey86rps1JwEUPARwcBbuVqSMbg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G4ehVveg75FUn2MPgarPmuGAchB9FIVXC35vJOjnUB9NVYh3mXeNgPqPQxCiQlvCc
	 xT5SgWJVpnsaxN0OXQCrkAdg/MlKF5rc70UubWNSXtCO7xDVdyCqOfHTha87YoPmwG
	 1zn9p0ykTFj5ZP0RTpbjlX64VcnqrRzoU0GtYMW/2v15rJk9CqXdWyO2d2yFvurci9
	 4FRNmpm3+nBULSQFId/EIzAlgznU8g9wYKUGHDJTcjWF+dzb1ufKfjouhoQF0aoZWB
	 9QY/vslzzXG4gOoEHipib+JDpW/DaGvyaE6vfZx4fmFGq5wTXNHdnzsekfqFgJZn+/
	 Dk7vaxN9oivZA==
Date: Wed, 20 May 2026 16:15:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Message-ID: <20260520-divisible-slouchy-4bcf4b5bb09d@spud>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
 <20260518-elderly-barman-2b1abfc3755c@spud>
 <NTZPR01MB095679F35A873BBBA304655F9F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260519-undoing-ambitious-012d608ebd7f@spud>
 <20260520121109.6b5faac0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ClC63Vaq8cFVQ4Tc"
Content-Disposition: inline
In-Reply-To: <20260520121109.6b5faac0@jic23-huawei>


--ClC63Vaq8cFVQ4Tc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 12:11:09PM +0100, Jonathan Cameron wrote:
rom 0 to 1800 mV. This set value cannot exceed it. This explanation will be=
 added later. =20
> >=20
> > I'm asking how this is calculated so that I can tell if you the property
> > is permitted or not.=20
>=20
> Far as I can tell this stuff is boot script / udev rule stuff - doesn't
> belong in DT.

I have suspected this to be the case, but I have been giving the
submitter the benefit of the doubt ;)

--ClC63Vaq8cFVQ4Tc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag3QBAAKCRB4tDGHoIJi
0hQkAQCo/WEzm/gfEDlfhE+9oXlwy/KPyAIAEUYKSAK0expT1AEAweXkvt8fc4H3
Z3/6m5McrePqvQsEZ6mRYWFJoX62OwE=
=7yEX
-----END PGP SIGNATURE-----

--ClC63Vaq8cFVQ4Tc--
