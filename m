Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5346AF03;
	Thu, 23 Jul 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784805628; cv=none; b=ROYZiK4xkkWjQHZe+YhUzeSOn8ueJ6gJZtU2u5pnGLG2KqVXkahpbYgqTi5ceRiAeZQTsptxwBMNj0ovYhrIjoHZAOhcP81HUqOTJPkqdD4ksC6KNTfhNnGBOgSVnmsxW33DyDEpw2ZzGwtkH3x+btI35Bgd0FJrY+zOM/rSrkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784805628; c=relaxed/simple;
	bh=5Fdw6C9CHqTA6siCY+5hDqPSAlcVHjMSa+k82VoNgdU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=CR72mdVuAN/c75OEp42WfIt8Tetnx7bbOk5aATL72tLMM+xgjqCNrUCBGhGw5e2BR3Z4b+KAJmATKDAAVbrhgcwLcaM03Ax6TCLCq7t2sp5aSMr3GrfgU3WyrKTj46bPn7XMIQC/jkhRS9D+8Raz8MRG0fILq1jTNE/JKmCGIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7E9591F000E9;
	Thu, 23 Jul 2026 11:20:24 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ed7c1d66c25002b5f0565ddb31e40e324e749ed623d8d0d68e4d09ecb6a6;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 23 Jul 2026 13:20:20 +0200
Message-Id: <DK5WSEM5SVXT.2A5HHVXDHGYGF@kernel.org>
Subject: Re: [PATCH v7 5/9] gpio: regmap: Add gpio_regmap_operation to
 extend reg_mask_xlate callback
Cc: "dlechner@baylibre.com" <dlechner@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux@analog.com" <linux@analog.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, =?utf-8?b?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?=
 <cy.huang@realtek.com>, =?utf-8?b?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?=
 <james.tai@realtek.com>
From: "Michael Walle" <mwalle@kernel.org>
To: =?utf-8?b?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>,
 "linusw@kernel.org" <linusw@kernel.org>, "andriy.shevchenko@intel.com"
 <andriy.shevchenko@intel.com>, "brgl@kernel.org" <brgl@kernel.org>,
 =?utf-8?b?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>,
 "wbg@kernel.org" <wbg@kernel.org>, "mathieu.dubois-briand@bootlin.com"
 <mathieu.dubois-briand@bootlin.com>, "nuno.sa@analog.com"
 <nuno.sa@analog.com>, "Michael.Hennerich@analog.com"
 <Michael.Hennerich@analog.com>, "jic23@kernel.org" <jic23@kernel.org>,
 "andy@kernel.org" <andy@kernel.org>, "u.kleine-koenig@baylibre.com"
 <u.kleine-koenig@baylibre.com>, "dakr@kernel.org" <dakr@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "o-takashi@sakamocchi.jp"
 <o-takashi@sakamocchi.jp>
X-Mailer: aerc 0.20.0
References: <20260723034237.2501507-1-eleanor.lin@realtek.com>
 <20260723034237.2501507-6-eleanor.lin@realtek.com>
 <DK5R2VCAK468.2GAEC7VG8OJBZ@kernel.org>
 <f4b79d5510b64ad3bc2d716a51d21cfe@realtek.com>
In-Reply-To: <f4b79d5510b64ad3bc2d716a51d21cfe@realtek.com>

--ed7c1d66c25002b5f0565ddb31e40e324e749ed623d8d0d68e4d09ecb6a6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Jul 23, 2026 at 1:14 PM CEST, Yu-Chun Lin [=E6=9E=97=E7=A5=90=E5=90=
=9B] wrote:
> Regarding the hardware, this controller indeed has dedicated and separate
> bits for IN, OUT, and DIR. If configured as an output, reading the IN bit
> does not reflect the actual state, so we must check the DIR bit first to
> know which bit to read.

Just out of curiosity, the out bit is also the control bit which
will set the gpio line state, correct? IOW, you are reading just the
bit you've set before and there is no way to read the real line
state.

-michael

--ed7c1d66c25002b5f0565ddb31e40e324e749ed623d8d0d68e4d09ecb6a6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCamH49BIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/j68QF/Z3Su72c123++84tw1JkukDf2Fk4LioZb
MvcqDzSP6SHa/GeVRbYvNKIe0r/MK8GTAX9XTUkNSkG31GONUt0mjfrfnlTQ11Hm
iAYh/q3t4ouzp9ZzjExoHcULjaNyUEsgpyw=
=W5VJ
-----END PGP SIGNATURE-----

--ed7c1d66c25002b5f0565ddb31e40e324e749ed623d8d0d68e4d09ecb6a6--
