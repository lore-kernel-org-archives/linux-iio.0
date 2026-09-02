Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F073403F8
	for <linux-iio@vger.kernel.org>; Wed,  2 Sep 2026 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338901; cv=none; b=YNsFLdoGS9t6nmCFVtK7oM5kJh4nQa1x6dWtwLLgzfJm1ogPG8/xpwaeD8lXqmKmZ+3u/FvuHkm9ItKs+stCBcBJKpQWojxcASG8go0Muw3ptNNzIrQf4OIx6E5WuPStKrCroOdRS4DHhvyNvmEEm6QFehMd+zlDlQE88e+1wP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338901; c=relaxed/simple;
	bh=uSSt0YZc9UyGJ0tHLqvxaxgo8QowM9tTZTaHwVI6irs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g0D/CRcgN6hY1Q7oET8SVZYAUVjco2tEfd3blUCMth6Fk734TkWfyutBa0H0RwG2eZAxeIpfEooYymAMpdVYwjbLJrZ4Qd0aTk2NUWAc/DPwcfJI/0DSzEwkCQsXITJbQUs8QCb6e8LrTV/v//0okSFS/urklgXj63Wq3RGAK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NKHl91V6; arc=none smtp.client-ip=95.215.58.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NKHl91V6"
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uSSt0YZc9UyGJ0tHLqvxaxgo8QowM9tTZTaHwVI6irs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788338897; v=1; x=1788943697;
 b=NKHl91V6D1VWfEKI/6SstijH78GtrZAJgY1UPAu6MueDH2Xq6eA/MWW4815XjEjHVOsnFbHu
 wD2k2xLqEEnqiazTKLi1/Zc/fMIdndgLlCGyRo2JVR0ip3ZklM88NF5JpYWrHkUNEXbeHVdxV4p
 laEaydTsImbbbxRnhqDIvPuo=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 2d80e7c3e17ee174;
	Wed, 02 Sep 2026 08:48:17 +0000
X-Mizu-Trace-ID: 2d80e7c3e17ee174
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 11:48:13 +0300
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
Subject: [PATCH v3 0/3] ROHM IIO fixes
Message-ID: <cover.1788336588.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vBdOIqWgyUNRDY0P"
Content-Disposition: inline

--vBdOIqWgyUNRDY0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix a few issues from IIO drivers for ROHM components.

I hired couple of gnomes to work for me. :) (Ran AI reviews).
Unsurprizingly some bugs were spotted. Time to try fix mess (mostly) I
have authored.

Bugs were found by AI review but fixes are made by hand. Hence no
AI-tooling tags are added. Please, let me know if one is needed.

Revision history:
v2 =3D> v3:
 - Drop already applied patch (1/4 in v2)
 - patch 1/3: Change integration time getter signature as suggested by
   Jonathan.
 - patch 2/3: Improve unwinding goto label naming
v1 =3D> v2:
 - Drop already applied patches (except the 1/4 which is in testing)
 - all: Fixes tag before SOB
 - patch 2/4: Clarify units for minimum integration time
 - patch 3/4: Fix the unwinding of fifo enable
 - patch 4/4: Fix the broken commit message

---

NOTE: Only _very_ shallow testing is done. All reviewing and testing is
appreciated as usual!

Matti Vaittinen (3):
  iio: light: rohm-bu27034: Fix infinite delay on error
  iio: accel: kionix-kx022a: Prevent memory leak and fix state
  iio: accel: kionix-kx022a: Fix IPOL macro name

 drivers/iio/accel/kionix-kx022a.c | 28 ++++++++++++---
 drivers/iio/accel/kionix-kx022a.h |  2 +-
 drivers/iio/light/rohm-bu27034.c  | 60 ++++++++++++++++++-------------
 3 files changed, 60 insertions(+), 30 deletions(-)


base-commit: 183f05a300eab41e4578337eac59335730dfebf9
--=20
2.55.0


--vBdOIqWgyUNRDY0P
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqX4s0ACgkQeFA3/03a
ocWqWAgAgF8djzYnH4vXN/hvdQc7kGOyKIaq4+9gAPtueI/MuBBDgjQHex7iLMJE
iy2EwUQM2mpaRItQGck1WQ8p6RxfXYEv4foirNk5HpopWP1aV7xnKh6yqctPx+Go
6PDTBiPrwEBeBjlbGUIqWUk4Tb0l9irHFi85eqYhz55W3n/slLRuG0MNH3iAi4Vg
jp3WCjLo0ZFsx7tg00uUroFNtPXNO0g1nstZaQTrWUEVqrXhH1ux5TwHc+cZQElo
wX8fg6e85uPnZ9NqMpx3ZGonTXMWrcFIOCPvi9Zd5P3oDA4UIfyLrAyc0fLvNQ9F
WQ5CLP/IJQwDpWg1tt64bvQi1t150w==
=fzlr
-----END PGP SIGNATURE-----

--vBdOIqWgyUNRDY0P--
