Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C393E51E2
	for <linux-iio@vger.kernel.org>; Wed,  2 Sep 2026 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338969; cv=none; b=WFXUN60NMrUBYWEi56KcuRu3EMxhIDSMlP5x8s0Ii/06K7IRYcLhVVmxH4cHC6hwgpZ61lUg7hMU6egmlfZy+C8v/G3kPmW5Xb/TDg2UY2g9gIkbpia9NcIuhOypfwELGthzriuB2rx73HvFt4hi4EzX8HUyqwtFAe6nHie3oPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338969; c=relaxed/simple;
	bh=5LER9EYvbKs9Qka4Wbjxj3pXZ4EQVA5Hj6MTLn2ZuJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iH4VHDY5v0z1qvKPqI1WEuXe/33LFyxo3SjkipgFHkN2Xl4I+avSp8DWe/hsiNA8zq9RO7xFSCoMTr74XY4SW5v/ZviZC5qLdaLmOUBKXdeNlLq17zH/YUSO2jbn2s/Dfl8+4Quwo3E++lbxpWRYmghMuyrr36YCuG5aoLAkRQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HApcDrlR; arc=none smtp.client-ip=91.218.175.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HApcDrlR"
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5LER9EYvbKs9Qka4Wbjxj3pXZ4EQVA5Hj6MTLn2ZuJc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788338966; v=1; x=1788943766;
 b=HApcDrlRhVWTQw7bl4NI3Wq13MBFOT4DtWXDx3sC4gNwyyo1XQ0JsJ4zqtboJxGTT8TiNClk
 qV2q0ddEnU3wlATcS9cvBAurCkrR/XIC3wXDJ0B2US+hmPzS/nM6pTJCwumto93sPf1/2fUeb5t
 wl5LMbOJ61TOtN4wzlOeLjVE=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 488d2f085647059f;
	Wed, 02 Sep 2026 08:49:25 +0000
X-Mizu-Trace-ID: 488d2f085647059f
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 11:49:18 +0300
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
Subject: [PATCH v3 3/3] iio: accel: kionix-kx022a: Fix IPOL macro name
Message-ID: <542c61177f34fe6f6c0f937021f6b3b7ca51a024.1788336588.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1788336588.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AiCy6vkZhqDS8qHz"
Content-Disposition: inline
In-Reply-To: <cover.1788336588.git.mazziesaccount@gmail.com>

--AiCy6vkZhqDS8qHz
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
v2 =3D>:
 - No changes
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


--AiCy6vkZhqDS8qHz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqX4w4ACgkQeFA3/03a
ocX/8wf/TZ5VbC5SsQV+t50SQGok6kUP5YW0B5HwYVmlPMGQG6zg5JI6eBPdnKpU
a4hq0i+SgfZQNdAFRN8qc+1Kr2cXIbkRF0G8S2HTaGr/F0jmcGS+Yfut3Lv5b5yc
AGVpsjD1WCJmlUVAmuurHyOc8Jgik0Z5KldA97PqneabfhBbrdRYptxQ0WufH2BT
y4f2gXpxyd41rBwPEc2Qrwn3NDLEDe6dxIsO/qE4mu2EjKVkbCLA3a9I9YdJbjKg
YlGP6T9G4k9e8Ktkl0gzHSZSGgJJLV018ysV2/1FqA9cGGP3S5Ia7UnOc7UBqR7b
Byb9mAdPkX1zSjBpSjnbqBxuQW99yg==
=K/lY
-----END PGP SIGNATURE-----

--AiCy6vkZhqDS8qHz--
