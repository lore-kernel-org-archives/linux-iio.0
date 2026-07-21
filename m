Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8837A825;
	Tue, 21 Jul 2026 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618671; cv=none; b=MsYTmX6IrgLbfSmYLuUxEQrAjsAGu0TbE0839MN2cAzYKSMm907LX3H6IncDE+H807fMBR4e9Igbj3bMMyxMxu7V4H2Arx2AfMvz6HdDAbPEXtqOpwCWz5owPP+T1W2p+h7zSrnp7BSQFORMHYXSKqZ25Ar2q8oeuV/EmAtnQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618671; c=relaxed/simple;
	bh=6IsxahOCY4cuSPTOpRI2XYECOylwU+cYPFvwRWaA7i8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=rFp1TNMZB6l2jtyergvr6V3bixhQBSb6JiTZoDQke8SLYYFTWqT/QCXQC18Czu2Pt+/glUMGFzY3bReeNGg56KZgF5HdO3jGh0OmvTVExeQZCcweRB73/2HOgiRoFmsOkK8dNwv7oBMW8RxyuWyNiKS/Lx1D91HjY8Px4cu+apI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7Mzmtqc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7Mzmtqc"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 668931F000E9;
	Tue, 21 Jul 2026 07:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784618669;
	bh=6IsxahOCY4cuSPTOpRI2XYECOylwU+cYPFvwRWaA7i8=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=J7Mzmtqclveyv1gtvVWxxheZ7j1xXvdPPV0JyqOY6HK9DGWGJ3uOy8k+iFxpCWcYp
	 Yw/QxeYe/auFWvhgnSieSRFpopMt5Q5NLgIvcdwOgQa1B+d4WpYIZP+ODYMCCy0RAj
	 o1j1ci63LOv4GugTqhL+B5iLaDO6nP7rKVrlIYCp6n3w0QnmMLOSUl70CxaJ7HDOif
	 oAETbjWyULiypJBvAGF/w+p4txbGmfE9sZJrn7yYN92Lof9dBmfiZOIlvPHF7aVzRh
	 KvQf8kKvpm/HTKzCsR0/WoR1wYGC/SOe2EY5z68nnkgpbq5ViVFT8Hv+MhWnJWC/aG
	 Xk/ZeaL6pSt1w==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=523b1aceac9c46e15ef98eb5dcde81ce48d45219a39c4b07e4edd6864e3a;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 21 Jul 2026 09:24:26 +0200
Message-Id: <DK42IP829U4Z.UJK92LWTXG5@kernel.org>
Subject: Re: [PATCH v6 7/8] gpio: regmap: Add IRQ enable/disable helpers
Cc: <dlechner@baylibre.com>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
 <james.tai@realtek.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Yu-Chun Lin" <eleanor.lin@realtek.com>, <linusw@kernel.org>,
 <andriy.shevchenko@intel.com>, <brgl@kernel.org>, <tychang@realtek.com>,
 <wbg@kernel.org>, <mathieu.dubois-briand@bootlin.com>,
 <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
 <andy@kernel.org>, <u.kleine-koenig@baylibre.com>, <dakr@kernel.org>,
 <bhelgaas@google.com>, <o-takashi@sakamocchi.jp>
X-Mailer: aerc 0.20.0
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-8-eleanor.lin@realtek.com>
In-Reply-To: <20260721065802.689530-8-eleanor.lin@realtek.com>

--523b1aceac9c46e15ef98eb5dcde81ce48d45219a39c4b07e4edd6864e3a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 21, 2026 at 8:58 AM CEST, Yu-Chun Lin wrote:
> Add gpio_regmap_enable_irq() and gpio_regmap_disable_irq(). Since struct
> gpio_regmap is opaque, drivers cannot access the embedded gpio_chip direc=
tly.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Reviewed-by: Michael Walle <mwalle@kernel.org>

--523b1aceac9c46e15ef98eb5dcde81ce48d45219a39c4b07e4edd6864e3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCal8eqhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/j7XgGA5OJi1hr0+Eja1cXeGSY4GHtcpfJ4/aOh
3qiOW6uwy5cRNV1VhV6oqr+eiheacJHQAYDhPSW7tu4ArzVrRfbZkm6T5kIGS/z5
7SkEQjz/ckYBKqx0+PUiWSRCtvEZxxBwn48=
=EVYC
-----END PGP SIGNATURE-----

--523b1aceac9c46e15ef98eb5dcde81ce48d45219a39c4b07e4edd6864e3a--
