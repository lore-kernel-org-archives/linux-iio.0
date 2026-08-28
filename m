Received: from mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D13F3D955B
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902884; cv=none; b=A+1DHmgriZRpgiz7UP5sI9Zz5npiHL+Gd8GgedVbKme0R9vThGNPUlk2ElOgaR96MtOXWIk+KiiLk7dFak+vB8ZKFKFxtuhCUZiOzCjQ2ferWzQ7FIV/AQ0kviBajZK30a6ukD+dXgen+30L/Vg5AhSgRmZyVuIsMEDkmMdYHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902884; c=relaxed/simple;
	bh=lxQwDZUBPKMiN4rKy7Wx4GnvGH6bw5PgAm6OjTB5zS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fgy8fLjWZ35Zou6rgFcIUWlWa6eJ7oj3FPlNsH1sCxcVrR1GHW5MquWXOI9Fq3QMHtbcMrDrurmndq+C6KDD1nN6itKWkUk1oC3PJxp2+N31a6vI3tmgl8qQAV28i+kn7mK5RClbJ6ISxXmUnje3srJulQRH2eYdlgdlsk4K/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NV9r7Nis; arc=none smtp.client-ip=91.218.175.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NV9r7Nis"
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lxQwDZUBPKMiN4rKy7Wx4GnvGH6bw5PgAm6OjTB5zS8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787902880; v=1; x=1788507680;
 b=NV9r7NisaxEkdQNNWw5FX5n9PzcMgTFIRk+J6U6K3rsuSXGqWRXaWnD+rhcytjBe/MD3q1qw
 79vwv4DCN+mW3sx5QQLxyj4zoJIVgXYSCAdtISXDla8AeXp/51tRggljqKNRhhCF9R9z3uYzz9x
 Xdtmqi0mq6VlmefaoyFXbTV4=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 52cc6e5ea10533eb;
	Fri, 28 Aug 2026 07:41:20 +0000
X-Mizu-Trace-ID: 52cc6e5ea10533eb
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 10:41:15 +0300
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
Subject: [PATCH v2 4/4] iio: accel: kionix-kx022a: Fix IPOL macro name
Message-ID: <c2ecaac02c39ebe9a409f642b3cfc0969ac0b3b7.1787901813.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1787901813.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0hs/Mw2K0VOgxflI"
Content-Disposition: inline
In-Reply-To: <cover.1787901813.git.mazziesaccount@gmail.com>

--0hs/Mw2K0VOgxflI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The "interrupt polarity high"-macro for KX022A variant is defined as:
"#define KX022A_MASK_IPOL KX022A_MASK_IPOL1"

However, the KX022A_MASK_IPOL1 is not defined anywhere, so actually
using the KX022A_IPOL_HIGH would produce a compile error.

Fix the define by using correct mask.

Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

---
Revision history:
v1 =3D> v2:
 - Fixed the commit message where line: "#define KX022A_MASK_IPOL
   KX022A_MASK_IPOL1" was lost, as git treated it as a comment :)
 - Moved Fixes before SOB
---
 drivers/iio/accel/kionix-kx022a.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-k=
x022a.h
index 0ed54f584223..a2d122c1e234 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -65,7 +65,7 @@
 #define KX022A_MASK_IEN		BIT(5)
 #define KX022A_MASK_IPOL	BIT(4)
 #define KX022A_IPOL_LOW		0
-#define KX022A_IPOL_HIGH	KX022A_MASK_IPOL1
+#define KX022A_IPOL_HIGH	KX022A_MASK_IPOL
 #define KX022A_MASK_ITYP	BIT(3)
 #define KX022A_ITYP_PULSE	KX022A_MASK_ITYP
 #define KX022A_ITYP_LEVEL	0
--=20
2.55.0


--0hs/Mw2K0VOgxflI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqRO5sACgkQeFA3/03a
ocXcdwf9H+X03uz+kSa/2wDaPaP5+zmcu+pfvOrlMAbjuoshbCtfbWk6F8SDfCoT
ZNnUOPAacDrCjaIYTjIaYXCAo4hy3hJgdaevaMWhEeq0QYcbrM5gQ2VXahuFCrp5
TeRDncKi7N+sM6zuQwubGrqUDwa/Zrb6eskiR0FciUq2AISk2bY94S9kLit90VVM
jDlEhuho4fTsbWqH3DsdYsI9/lkRgxukvS+tmXetB+Ba/iZA71d+flmxq8nWkl5e
fOPGsW4s4mSWW68xL6YZwZiNiJTgLMeuHgHgOYR04J3jjYV3vIOzkhNnM/lD+Ch1
spM+dOfifcs/qQIYUziCWDEr8eOf3g==
=dyl7
-----END PGP SIGNATURE-----

--0hs/Mw2K0VOgxflI--
