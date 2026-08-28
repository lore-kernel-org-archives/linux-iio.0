Received: from mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65D3BED24
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902812; cv=none; b=Onsnw1kxWZkLDDEq1S6Wrw/4I+mmXHgvP6cRAZGcSKDis4OnrxqDA1t5A7ZHWoEmxDKri01Bh5/azosR3Bh9m5RWDLLPiVB5hY7XZlYSPSWkNTxg9YUQkqRCyHdjwB0ipFEooyBe0OArSCQ9/cCp9Pef7oCT9sQahyOeY+JUfKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902812; c=relaxed/simple;
	bh=rL/6qfGg6mmgjpZhsO7KrFUY8uNhWd6M5WBeIxuhvIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GjK/1T2W8dsapLWtNDewk2ntTvf3BqnbyLnWCpDNferqiiWU2jtBtm/SZPSMiYRLfiNoX0O/Lw7pUmJ7PkTM4NeZmPEgN6mKkSWgJhy+STsKL/hc0y8kzG9GQyaIRyFv7/un3FSzByLNTjXT8ihxiT1AzeYMNFjDvKTE4gONxv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=snrEDu+w; arc=none smtp.client-ip=91.218.175.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="snrEDu+w"
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rL/6qfGg6mmgjpZhsO7KrFUY8uNhWd6M5WBeIxuhvIc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787902808; v=1; x=1788507608;
 b=snrEDu+wnyxRCzKQzcUM87F4c7Ph7V7RLR/YqusZ8JCD1/sfBO35SpQh+pnk5Qmj1sst/Rcv
 uXhYoXfu9x2v2ZIpFf9o8zAL3lMobKSHwZQZALzwdt4sO9+9yB7le3ZQY+qgAD0MwTjHv96/eFm
 5I5JIkB+YIlKZQ1ixxwlf250=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 866af999396479e3;
	Fri, 28 Aug 2026 07:40:08 +0000
X-Mizu-Trace-ID: 866af999396479e3
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 10:40:03 +0300
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] ROHM IIO fixes
Message-ID: <cover.1787901813.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BTmo6VO9SxIgB+PL"
Content-Disposition: inline

--BTmo6VO9SxIgB+PL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix a few issues from IIO drivers for ROHM components.

I hired couple of gnomes to work for me. :) (Ran AI reviews).
Unsurprizingly some bugs were spotted. Time to try fix mess (mostly) I
have authored.

Bugs were found by AI review but fixes are made by hand. Hence no
AI-tooling tags are added. Please, let me know if one is needed.

Note that the patch 1/4 is already applied to Jonathan's testing repo.
Including it because I couldn't find it from IIO's public repo to rebase
the series on it.

Revision history:
v1 =3D> v2:
 - Drop already applied patches (except the 1/4 which is in testing)
 - all: Fixes tag before SOB
 - patch 2/4: Clarify units for minimum integration time
 - patch 3/4: Fix the unwinding of fifo enable
 - patch 4/4: Fix the broken commit message

---

NOTE: Only _very_ shallow testing is done. Some of the fixes are not
tested in the hardware at all. All reviewing and testing is appreciated
as usual!

Matti Vaittinen (4):
  iio: pressure: rohm-bm1390: Fix AVE_NUM initialization
  iio: light: rohm-bu27034: Fix infinite delay on error
  iio: accel: kionix-kx022a: Prevent memory leak and fix state
  iio: accel: kionix-kx022a: Fix IPOL macro name

 drivers/iio/accel/kionix-kx022a.c  | 28 +++++++++++++++++++++++-----
 drivers/iio/accel/kionix-kx022a.h  |  2 +-
 drivers/iio/light/rohm-bu27034.c   | 10 ++++++++++
 drivers/iio/pressure/rohm-bm1390.c |  4 +++-
 4 files changed, 37 insertions(+), 7 deletions(-)


base-commit: 6b9f23b5460818aaf199dda90210d5fc08d66c8f
--=20
2.55.0


--BTmo6VO9SxIgB+PL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqRO1IACgkQeFA3/03a
ocU8bggAlGb4WbUonHYzzIOkthGfvBeavpcHCmbGcUtxAbFeIbNmLumZ0z/p6RZU
oRaEMbPF5NRSi123pB4pEFiD8xlTjU5g6IT6oKd1vOP12XaJLmd2AbfVEHL4/IBQ
0cN7X04+mWfOjKV8DvkEsT71xpa+B9jchvWbPv5lKfLRI28RGOZFRIHmXUEYYCMr
7DtM3X+uNfWQ1VBOZSvpEaiNf/Gh5FEGC4OEVvp8hlZcCnoz+OzKc1ZxwqOThVYc
05WGbsg8arBiyndSE9ASNMejd/R/QW9k+cgglEquBnha2583r4XtCrfiyJmCiJMX
pLryo3Xaq28rlnHBaWMKZgs4xkdXGA==
=VvMs
-----END PGP SIGNATURE-----

--BTmo6VO9SxIgB+PL--
