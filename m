Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696762;
	b=MwTbF1En4LvPeHMoK2zW/oYoyuHu156/2FKV/QuEmgSe975vOkK2QhaFJm1/FXGAEqTS
	 q1gfMlF7LT33lEtUkycQOTMCODg8mOn9Z6eBD2Fackuxd/ZcJUNQ7EoMX62oDHB+wPHnY
	 hd4xUg+40kPhQJ5X2s+yKSo9zBCeR9/HU8GK5upMfVClNGj8633SKLiWMOESE7mMZLuTJ
	 6SF8YgnTez1NRyURNpxgUNgOeCTcuKckNw9YNITsZV4JV2AKk+dVTlPT2hB55cXC4d7TQ
	 2LNURkCBMeDaq7qO3K8g80MViQPBO0I3YbuTsd0chl40EfAAZIVqPKi5WGSKoPLrkqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696762;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cgQv+swg3j1uTk1KouV9vzt0anaUlnwwFnwk+cQL8t4=;
	b=e5OPfA1Q/sgm8fXjzwhnKPI44nfAB6darhU989ZusirtpSD4p2hhw5o2xVuWwo6J2ShX
	 8HbynZq0jdynfNS7y3W2tawJrVp80eB1IjD4rb4Z0n29BdNwMm+Eq5baFF+8l5933BWXd
	 jOT0N7MbBo5MjXOY+89zMvbD7fkaY8e3UWwVNrwr+ycAgGlrnxeQ2MrPhA3IV+sMwuiF/
	 IHF7K1pGV8UJbB+xz4+AFAHGmlH1ouenGlPt6JrtdBQVyspOr1IsCbyLQFHOLPmVhNlsB
	 xJR4FUVPKEUeZvd2cv6eI0h9OXIf6NG1l/Imi3eVcqoSZCWwyatUZj9MsqavCBpx4Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=AXoVmUHI;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8CA606A31C
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 12:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B8CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=AXoVmUHI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=cgQv
	+swg3j1uTk1KouV9vzt0anaUlnwwFnwk+cQL8t4=; b=AXoVmUHIOoosd5aN0bYg
	fy8ng/QdA3ekgOn+01xc5re9UHdc+6Y9rWNdHrKmNvcAcp5N2l7QhHzpUEVo8efK
	zNT8+NkHcq3l5KDQr2uDb8G9HIHRM+5LKZcEC+Ew9gb7NaaBDX5W6Hupr2SdHCTj
	dQHea3tM0fRvMeORDsWkMBiyEnt4nARK6tYeHuA3txKETmI2K9cnF3quDTumz2u0
	QcIG3x//njfdkmSRGkv0pL44vaA/eCkkX8nupPyY8FAMRMrOiraHOMbXYVjSEGSQ
	bPY+HFWtp7tl9x5Fv5luqXGfSfDWAk/uynHoDkwXti3cYZuxe7SQAwswjPlJMyyF
	7g==
Received: (qmail 1524107 invoked from network); 26 Nov 2026 13:39:09 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Nov 2026 13:39:09 +0100
X-UD-Smtp-Session: l3s3148p1@fq7gOi1htL8ujnv5
Date: Thu, 26 Nov 2026 13:39:09 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] power: sequencing: Allow desc=NULL in
 enable/disable stub functions
Message-ID: <awgoaQTep07E_w6i@shikoro>
References: <20261126081155.501493-1-wenst@chromium.org>
 <20261126081155.501493-2-wenst@chromium.org>
 <CA+V-a8tqzDTbMu5375vub=DBHmpJWW2TvUGKfsuPf_gjpSuC=w@mail.gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tlm8BQ2eIaHuWJKs"
Content-Disposition: inline
In-Reply-To: <CA+V-a8tqzDTbMu5375vub=DBHmpJWW2TvUGKfsuPf_gjpSuC=w@mail.gmail.com>

--Tlm8BQ2eIaHuWJKs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> >  static inline int pwrseq_enable(struct pwrseq_desc *desc)
> >  {
> > +       if (!desc)
> > +               return 0;
> > +
> >         return -ENOSYS;

Bike-shedding alert: What about the ternary operator? It is nicely
concise here:

	return desc ? -ENOSYS : 0;

Other than that:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--Tlm8BQ2eIaHuWJKs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmsIKGkACgkQFA3kzBSg
KbYcWA//WM8ET+BJb0rD7IFfgFxuTQ77OW8upJZQCeBKKFekSEX2TKLXOsRLNrVa
EyPSZuGnzfXKmDmtt565idfSZnlwYSZskSapjzzAY2rhcjomKbhRpG5tFEbbp51g
T2/sS2IEPHfUJoh2EwO2LkQJ8e1AFdI0gt7hbeYeUOQpM1QUpO1uc9LQ5Satg4rl
kQej/QoHDcG0rqo3A2lPbhX96c8w+HOxuLF1pyjhfhqleEPZI52BrbuIpiK1HmGi
ptLVQ+eWHHVk7QKJ7Ed0kqHblTfrbR5Sg8mET81moKpLhxFqBFOUB2ZDq30Vv7qm
TieTWXnYYYAt65rJhfBxLVoCzPs5tFqFdb8OhC1oMKK6mu2gihaF3HumXUchryTi
2aKMVtdhw1xg4fS3+rZdIC844IAUQQ/XY1No2W77d77FMoUr7steW6P6TNn4nmZR
Xl5GA6sQo/uPfv2hXUYNXLfBBDUBoWi6bdGQNJVbTWFun7LHRCRNTbNBTFwa5/2x
h+kt4+/lxHqAv+l6DjLCep+PdkOSu6XavNTQhqFDK3kZ5oE0QiRBjQ2z/TKPsGLW
3nqpgoJ1r2LvI3fhaSeg3lzmUI1s2VfVB9F6vMiVDBTH7eRKZZQYv4lJul0bdwyd
9SE+fzmmOY/GCMpEJkTdPXUWoQf9r72kJpAtLO7Qe2FgrLbrTT8=
=giy1
-----END PGP SIGNATURE-----

--Tlm8BQ2eIaHuWJKs--
