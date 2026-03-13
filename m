Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B5235E92C;
	Fri, 13 Mar 2026 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420716; cv=none; b=eLyd4r8ga94MyN4znqsXp+vUMWpmBVLrzcPci4AlgbhnQj2cIhizUag212sGW2ZrUNzFEzirIPXHFVUIqAwUfJmXP/lvzs9LqtoUE0Nnk7Sxp4DSYPSvEF0H/CyFua3gGNPCVfNJvHxTYA5HXo+44XCmBNtzmPDR3rdhGbW9TnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420716; c=relaxed/simple;
	bh=lFPdsTRQIac0h20us+/rsEhtCke2dTOPyz2JdgoPmZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgYXqRP3cpsHfonJHRnLny59kFEGVU73ThMwxSArP1yQI3JiIYkngy2leWW+ktF1S9x0+eULG1CLXofiKmyIzvH4dvUkKd7c9yxM0RJG4y2a8ay/ifYJs4aubm9eqbMFL10i7rWe9MrhFx+/tC9DkkQciR59osNvQuxs7/rQwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuqH0owB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuqH0owB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448C8C19425;
	Fri, 13 Mar 2026 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773420715;
	bh=lFPdsTRQIac0h20us+/rsEhtCke2dTOPyz2JdgoPmZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuqH0owBJ5zYkJvKJnKft9Lq15W7NGrQlgAt43FbOK1uVltXbXJ+nwpS7JDdHvqyG
	 ckqt6azUqU2p6bpLJ3E4optg7es6GLJQFxyLh1rdbwpEoph90Lr1eHLAM60Ti1G7ei
	 Rm1GzeiC/WPhG8ykmpfXVkD+usRDX537i1n2oTbPseH9GV3cxnXpoTo8FbBCAYVEvd
	 NgksUiItyZO/vvzF327w05loREK9jPad49ttR/8dvzfr5clRRqT7wghErVYn9bUCFY
	 B0NBbwfCFDv1F5NYOEdhdztlsnmcwEJ/YojDAPMU0kdgtaqAyk/YOpNjS696r58X5v
	 Jq9Cgme38CGPA==
Date: Fri, 13 Mar 2026 16:51:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: light: vcnl4000: add regulators
Message-ID: <20260313-reputably-pregame-ba41c3c1438a@spud>
References: <20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com>
 <20260312-vcnl4000-regulators-v2-1-2bdebbcbb58a@gmail.com>
 <20260312-slouching-shelf-c8f64433881d@spud>
 <3d27945a-639d-4c3d-969f-2ec23bdd9900@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Nw0i8gb4BqMs9qV"
Content-Disposition: inline
In-Reply-To: <3d27945a-639d-4c3d-969f-2ec23bdd9900@gmail.com>


--+Nw0i8gb4BqMs9qV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 06:39:25PM +0200, Erikas Bitovtas wrote:
>=20
>=20
> On 3/12/26 7:39 PM, Conor Dooley wrote:
> > On Thu, Mar 12, 2026 at 01:53:12PM +0200, Erikas Bitovtas wrote:
> >> This commit adds regulator properties for vcnl4000 ambient light and
> >> proximity sensors.
> >=20
> > This we can see. Your commit message should say why.
> >=20
> > Do all devices in the binding have all of these supplies?
> >=20
>=20
> If we look at the datasheet for vcnl4040,
> https://www.vishay.com/docs/84274/vcnl4040.pdf, in figure 11 we can see
> that there can be 3 supplies: sensor supply Vdd (vdd), I2C supply for
> the bus Vpull_up (vddio) and IR LED anode Vdd_led (vled).
> The other datasheets refer to three supplies as well - one for the
> sensor, one for anode and one for the bus:
> https://www.vishay.com/docs/83372/vcnl4000.pdf
> https://www.vishay.com/docs/84138/designingvcnl4010.pdf
> https://www.vishay.com/docs/84327/designingvcnl4200.pdf

Please provide this information in the commit message in v2.

Thanks,
Conor.
pw-bot: changes-requested

>=20
> >>
> >> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> >> ---
> >>  Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml | 7 =
+++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl40=
00.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> >> index 2ba4d5de4ec4..a1b4c02db246 100644
> >> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> >> @@ -33,6 +33,10 @@ properties:
> >>    interrupts:
> >>      maxItems: 1
> >> =20
> >> +  vdd-supply: true
> >> +  vddio-supply: true
> >> +  vled-supply: true
> >> +
> >>    reg:
> >>      maxItems: 1
> >> =20
> >> @@ -54,6 +58,9 @@ examples:
> >>              compatible =3D "vishay,vcnl4200";
> >>              reg =3D <0x51>;
> >>              proximity-near-level =3D <220>;
> >> +            vdd-supply =3D <&reg_vdd>;
> >> +            vddio-supply =3D <&reg_vddio>;
> >> +            vled-supply =3D <&reg_vled>;
> >>          };
> >>      };
> >>  ...
> >>
> >> --=20
> >> 2.53.0
> >>
>=20

--+Nw0i8gb4BqMs9qV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabRApgAKCRB4tDGHoIJi
0vDkAQCshe3nKx65m2CNcOl5oQt9otncLP8FiCIxDNfENpedyQEA2tgP6bBNXlJ+
GIbUAOt1aQiV+0+Ujn4lrTD2Tv8UQw4=
=5mIE
-----END PGP SIGNATURE-----

--+Nw0i8gb4BqMs9qV--
