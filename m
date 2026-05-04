Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0B318BA6
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882208; cv=none; b=CB5wn+gOYr/M+QY6xANAwQyzBw0aHvjoIzsT8K/QpAy6fmzjvAn9nIXAd6nc2hdxp+28yWhoVYc5F0LC0BHauT0uacZmssvZRbALPqvg497d6OlC7kcuWdBw+eDtPYWLhM2fv6waWqH+FK2BY6zYZz/1DL0l94NqNvRbudy/rK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882208; c=relaxed/simple;
	bh=itbDJGEOISoHPf4qr/uG6JkLkngN8B566NqgSWCaRGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kW30tZ1/82aK5EKP2CMmMKthsosIMmaGraos7PyyFZXEknWdKTV5haVG+BvUtYJJIIKBjYsQ0TyZzA/cIA+irbWqJWyZSRaq4SMKQeEzHL0jXYy2Mz1MN7WiMy+dijoYGPchwtM/dU+Z5L7LWGvtiN++i7/ImaJuVuqECuqJGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ORvrqe6D; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ORvrqe6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=itbD
	JGEOISoHPf4qr/uG6JkLkngN8B566NqgSWCaRGs=; b=ORvrqe6DCng3+29HhOhJ
	c5F//xuA65hy1htAfVkxNNlpHJKs7Sg5BsLha1xG5yk4BJCoVuav+ei6mHK398/6
	HB13sVmapKufETOx6hffrzrLZO/zAy6MdJmGLPKLiQcHIDQNjlkrB4wy/uHdH+/s
	DfKkESOnWmZEptrhHtHWhTHxuXk4t0nzWfo/IHbkDKs9d1tpTl91V1KoNvYJ47Ee
	vRnCtpsGCjyLyDs//LQQ9KqYjizVf2tagTTRNpTsR549/V4xPVcTjljv7P/J7y02
	EUebGW5K7mE8d7m2d5fGPcwdMhyBBFa3rgytSUBA5ceCI2EZ0XAQIcP/B+XqMFxo
	AA==
Received: (qmail 2096968 invoked from network); 4 May 2026 10:10:04 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 10:10:04 +0200
X-UD-Smtp-Session: l3s3148p1@mN06dflQwsIujnvR
Date: Mon, 4 May 2026 10:10:03 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Peter Rosin <peda@axentia.se>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Linux I2C <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH] MAINTAINERS: Update mail for Peter Rosin
Message-ID: <afhUW7anAEURM0Gz@ninjato>
References: <7ddc5b09-b6c9-99f9-d951-6b3ef96f8c1f@axentia.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KDFJeNXwTNf6IRbE"
Content-Disposition: inline
In-Reply-To: <7ddc5b09-b6c9-99f9-d951-6b3ef96f8c1f@axentia.se>


--KDFJeNXwTNf6IRbE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2026 at 06:09:58AM +0200, Peter Rosin wrote:
> I'm resigning from my position at Axentia.

All the best for your future path and thank you for all the work so far!

> Signed-off-by: Peter Rosin <peda@axentia.se>

Do you take this via the mux tree or shall I pick it via I2C?


--KDFJeNXwTNf6IRbE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn4VFsACgkQFA3kzBSg
KbYq4w//VweLV8Q/whmnEkuLhEDZlNP8U3Q02TRfB0SqJoCzubJaGAm1G5uV4PrD
loM6xqn1svJcgpNKUmqDgOpoMDuS7IRR9+quFkAc4mSOoSNZvxLpmxuSP6u24sLJ
J1iJbaAPzik2xMhsZWN9wN2Dgz7vSmdymTLiopsOo+m4ZeCVzOQDBSq+QWsTPRn+
scvLmg2+Yi3GrkF6fejgTK3NY8UYTo6tDKTdeCDaP7oh0hJkJr8wqHyEssa9pDqO
83UIEyqpVD5AyVTL5xhSmpFNtTrBko48hQOaW/gm+Xr2MTMeu0DHOXMbAqDcxDrK
yuV2ExlR/rJGzrPKg0GccMb/W89ZXBOqsFSJaqe89v8XSqbZKvS2kahJWnGjy2wG
E5k6ZGrV8Unnn6QfQTXMg0HzNz9nF0yjuXTUPSJL6xz9DK0v2YkpPG++Bj2cgEIo
H9DLqoB3YSoho0DebZQuSyYsoD8Wmlrmc6VRMbC4PGdxvdJTYrAlFVdYe1uqdprT
JA7VOjIihE3SV/XDSJSR42jYmIC0vDQq5nQnCRAhBlL29bdxDQoMtyeIzYYvt8Kw
rbvpf0JMCHd6KHJWkrsGJezklE8alFEFYXgj8FrmO6+cgMbsFyVoaSFnsRAAwHN1
Sy//jJXa5qLb9OYPQxle/dP9Cf0IApI7Wbhp2iWr14yt/Ajhakc=
=Trad
-----END PGP SIGNATURE-----

--KDFJeNXwTNf6IRbE--
