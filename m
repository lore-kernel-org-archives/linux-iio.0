Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF4233A9CF;
	Thu, 23 Jul 2026 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789663; cv=none; b=Sn5EU9Y3IhHE/IklhnWTfTDnGAQ26upfpoDy9IAYPRNY2RofqCFWAC2qU3Ywga5x4NEM4fxqY50ywMC+u3ee4K+ZmVIXbQRhwDKOnyOCglCi9OGmtJ4mTp1tVVuuIqd4Llhmv3X8SIimbd67jLWvlCtz9CEo7ERPeTQ9tfBwhpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789663; c=relaxed/simple;
	bh=bdpqnFiHgZGEl3ueWLvvbGqZX+pQHB4X6OWkq9p3x7k=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=fbY51+Y9hJsF7GfqDw9oJjSrCkyS2sf9KlJBHlAHKiJyQ6Z0AZjXcGcsP+ccrnZAZgIEs0THeMzj4CIHO+MVId5ogsP0XtAixMnDDb4ShwhvuOGExI7hjf7xjl36BJ6wL1fcu4nOdoXaaag1P7I9LvxA5F/2E8ao2lnoacn6nrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COpmbdtH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COpmbdtH"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5574C1F000E9;
	Thu, 23 Jul 2026 06:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784789661;
	bh=bdpqnFiHgZGEl3ueWLvvbGqZX+pQHB4X6OWkq9p3x7k=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To;
	b=COpmbdtHt1fggssKfDBbQRNCpt0vsZ0w6smHPfQw2dtP396p7kTLZA4ejLD7mxtBj
	 52BDb/5GNsMwLxEx7+fepXc8kxgUtGHLD8cMxOBWMuVfJbt1MwKe80HJFAoEEb/kEc
	 pSfKFqhHg1taTExn4eRL5lgum9GyLqiL4XXViwcdGqM+dMxf7zGOBTyE0qyhj4VRZ5
	 rPbddNFXmHlttm8NjL5YoQEeW72R0GvTmXJBfjYX6u+PjNS1gse0TBPsOCRNRbgzbA
	 Bn1bqH43f2yBk+WZCGoaz8rlj/vPOG+z3NJql+BemW6a+OTajUSsXsDl0iPoeMVjzx
	 6z8AZUL64A9XA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=17022b46754896bcd6d3d300e15f7cca0085d678ccc88cf7f7626a6130c1;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 23 Jul 2026 08:54:18 +0200
Message-Id: <DK5R4PSSVWK3.Z1FXE7HOS7Y6@kernel.org>
To: "Yu-Chun Lin" <eleanor.lin@realtek.com>, <linusw@kernel.org>,
 <andriy.shevchenko@intel.com>, <brgl@kernel.org>, <tychang@realtek.com>,
 <wbg@kernel.org>, <mathieu.dubois-briand@bootlin.com>,
 <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
 <andy@kernel.org>, <u.kleine-koenig@baylibre.com>, <dakr@kernel.org>,
 <bhelgaas@google.com>, <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v7 6/9] gpio: regmap: Add value_xlate callback
Cc: <dlechner@baylibre.com>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
 <james.tai@realtek.com>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260723034237.2501507-1-eleanor.lin@realtek.com>
 <20260723034237.2501507-7-eleanor.lin@realtek.com>
In-Reply-To: <20260723034237.2501507-7-eleanor.lin@realtek.com>

--17022b46754896bcd6d3d300e15f7cca0085d678ccc88cf7f7626a6130c1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Jul 23, 2026 at 5:42 AM CEST, Yu-Chun Lin wrote:
> Introduce a new optional 'value_xlate' callback. This routine allows driv=
ers
> to translate or modify the register value and mask immediately before a w=
rite
> operation. It is particularly useful for hardware that requires additiona=
l
> control bits, such as a write-enable bit, to be appended to the data
> dynamically.
>
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Reviewed-by: Michael Walle <mwalle@kernel.org>

--17022b46754896bcd6d3d300e15f7cca0085d678ccc88cf7f7626a6130c1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCamG6mhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/iQkwF/Tt4BiYCcfypNSwSJV+0TEziuaHgNOFXT
rOWCxZI4kUCmmm1tC/N/S+EbDc71Zf33AX9t2ZYzufSY+0qAT+tRY1kamosYyaQ5
W0tYjDs/Eb73sxCFmuMdb5DbODCZG2DxYpw=
=rPmo
-----END PGP SIGNATURE-----

--17022b46754896bcd6d3d300e15f7cca0085d678ccc88cf7f7626a6130c1--
