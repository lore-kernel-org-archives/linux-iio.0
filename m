Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAAA4189AC;
	Tue, 21 Jul 2026 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617635; cv=none; b=Vi4F+DEpijnseMDiFCjQUVg4FoePGA0WI/qXsN49E9GvrGilwUgVog+UZa8m/CdvAS64cyhiTeIQbakvj/povYghhXlnDn+RHMDmnbyiI4J/4hrAIlDFYPaQUACnWVdoBr7czJajl5rbrRqELIW/jiUKjXNIqkII0+Eay6cujzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617635; c=relaxed/simple;
	bh=ayZuSsf3BKMb2f5eO+Xs5TiiTUWXRPgFzLi1ygliwaQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=PT9DSS5DTsuN6BmZUdQzOWlevj7VHidOvIVdk0vRqUJwTO9HmGRcF4XaWbeSMCiiO1HTcvulb6Sof/WRhjhSeiXkHUTVLMYjXnVE485NSA8QDPk/Gcc+HBifmZBS1B9RQ0fO5WEZm+CuWqLDQmylr2XexsAVfagqF+6vmFzvnCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCXUpMYE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCXUpMYE"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7952D1F000E9;
	Tue, 21 Jul 2026 07:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784617634;
	bh=ayZuSsf3BKMb2f5eO+Xs5TiiTUWXRPgFzLi1ygliwaQ=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=MCXUpMYElMnuh0fnBEMnhCibto36g/8i80kvfrc2kGPSrN34HCaAhz/LkFEdWnhJq
	 5eYPHHpDf+FHDq9CC++hjzHRK0SKkumrCG/lcKxhZi5ZxDtJhoC/RcwUjBmKIxpzTT
	 Z/8N7TCjoxQv4Gz19PhG0r5MTn+o2gohbnS9qgogayvXxkhKLowE8TztfBEXeXtntJ
	 q0UxFdhZSXKa8Yqlk+l0OxbQhkJCjraYGUH3AZUrZCWKkTjv+qxjsc3qYT6s+nkOs8
	 usy0egqw/uvzI8JetgYgoeTasRI9+i0jlDSwwsWkmWiqkjPQT5tIPHnND5+07ib12Z
	 sfpo0aYniDjKg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e8809b0be6f1a6e97a8df13d0157864f028ca76be9da478350fdcad1425b;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 21 Jul 2026 09:07:10 +0200
Message-Id: <DK425HBW34SI.3TLNJ7B7GYCQD@kernel.org>
Subject: Re: [PATCH v6 4/8] gpio: regmap: Order kernel-doc descriptions with
 the actual appearance
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
 <20260721065802.689530-5-eleanor.lin@realtek.com>
In-Reply-To: <20260721065802.689530-5-eleanor.lin@realtek.com>

--e8809b0be6f1a6e97a8df13d0157864f028ca76be9da478350fdcad1425b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 21, 2026 at 8:57 AM CEST, Yu-Chun Lin wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Order kernel-doc descriptions with the actual appearance.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Reviewed-by: Michael Walle <mwalle@kernel.org>

--e8809b0be6f1a6e97a8df13d0157864f028ca76be9da478350fdcad1425b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCal8anhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jhDwF+IktX/VjgOiQuFewP1z9DRFUHATeIyFjc
DsHAHrRha1HsgCixz3E3+g/YVTjGrCJmAX0Qu0bLZM6UanWahfhZog8ywIARzgkX
qqao+PvqrzIUwbFKYRsNC5crlkOMY9Ny878=
=7dBA
-----END PGP SIGNATURE-----

--e8809b0be6f1a6e97a8df13d0157864f028ca76be9da478350fdcad1425b--
