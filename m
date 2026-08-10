Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D90390C84
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348545; cv=none; b=VWssIFWUoE+EfuBQkjyW6rZA3jmAsxW7IZXhWDbVl396I4cpYcV/sMlfsarz0S9Xf6GfkHVXRld6gPAp1ytptzvXw8POTA+UTAW93x3+rC3951agwSVcIbQ+BPcpCMjGHRE599qShZc+N5dKl79F4SjEZlEk1F482tJqWqNKe/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348545; c=relaxed/simple;
	bh=CfY9GXcy7Uu6pe55Y290vufRTa2iQtz0q30tAtYPN80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXAoXTLo54la0TdbPARWJWnN9JFT/EXIYaxYl9V+jQSkQHyy9B+PozvbZBJYEHcED4wmsjGxOD4oDFj2srvZcFuqC8dw7r08isLm3jH5liF2swTLn8eNS9iKaMRJNCLmOqNf52X5N/NApqlvnFlBtqdz4eygf4eSpBuNy4hjH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WYFhlo/F; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WYFhlo/F"
Date: Mon, 10 Aug 2026 10:55:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348540; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=82lkkM/QsZF2kEurZLORw+0RKriA3bE/GFTKcOTjUvg=;
	b=WYFhlo/FTXbcOjxZGzzOTPrfsoxj2uN/4mAqeEwHZhaesRUSmmijT+3KPA1iTR0tic4VFI
	iQR83ch6BgNhKutPVWmJQTZYA92lIKt20beTe0KwTGS4GV6FGrjWbpyDJwVVc/9T3IF+uq
	K9RragYyKxbtXl/d9jCXNZ3SvCcA8Ls=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	0012-iio-accel-kx022a-Fix-IPOL-macro-name.patch@mva-rohm
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>
Subject: [PATCH 12/12] iio: accel: kionix-kx022a: Fix IPOL macro name
Message-ID: <c26c2741ca11adf7a089c094d8648f4ec6cbab54.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QyBQFuSnY8wRRi53"
Content-Disposition: inline
In-Reply-To: <cover.1786347811.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--QyBQFuSnY8wRRi53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The "interrupt polarity high" -macro for KX022A variant is defined as:
However, the KX022A_MASK_IPOL1 is not defined anywhere, so actually
using the KX022A_IPOL_HIGH would produce a compile error.

Fix the define by using correct mask.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")

---
It appears the KX022A_IPOL_HIGH is unused as the IRQ is currently,
unconditionally set level low in kx022a_prepare_irq_pin(). The KX022A
hardware would support other configurations though. So, another
potential fix would be removing the define altogether. I decided to
leave the define there, as having it will allow users who need different
configuration to simply change the KX022A_IPOL_LOW to KX022A_IPOL_HIGH,
which is kind of a "easy to try" thing.

I don't have a strong preference here though.
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


--QyBQFuSnY8wRRi53
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5g+0ACgkQeFA3/03a
ocWszgf/R0DYNmXxaREMAcNc1Mz3mLHRrv8E+sAro2trSrF6Go8eA1+1xOyxHaYt
KX3EpzAEkpgN0nY0imEM6bcIBbD9CXk5ymKJ6K0Tu6RyP4B7Vm73TsQF8kin/qk6
fddQAJ29oXfPp/5t17MuKM/Nk8dm1OA7aKnZCcEUMK6rbzLop8VcolAUJuzHZS+I
I6ndSfDI9ioGNVtGX+PVCvNZy58MO5U3ztj93ZwTVUODPjfy2ZoNvcBHzkWLDe8h
IuKpKTIEyj46KB0x3mxJiGJBZpuLRFbbgMd2UoXcv07Zwd64lSNA0BYiDan3ytfn
JslR+J2a5+FJQQki/9UWfay1sEE/DA==
=CIkl
-----END PGP SIGNATURE-----

--QyBQFuSnY8wRRi53--
