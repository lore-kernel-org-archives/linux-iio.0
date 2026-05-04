Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81A3FA5C2
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922549; cv=none; b=JOH4wEG6eB/IeUo5+nslP4D+7G2SYYN9UE7LNzTBbizGXeHVEgUVnVcbbvztXhaYPvh+4ZGCIUwecPLyOxtdUmF2B0pbfJ0m/Axiep9Zxza/7A+SQwWBWKZEpWRnIqP+FU/uLTGB/X1DTXoU37hh2hs+/+pUf6s3nR4XK3MlHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922549; c=relaxed/simple;
	bh=i1vqcs/RvYjwwcPYKyLwaaYIcPhGMWol6hVBdEUUbQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiYgL/aU1zqsRkasWmMkI2xM61HxTI1bPp/wbuheDh31ZXiblRNIFJPou3A5m+yBzQq1aSP36eZFZrxtLdYTl1vSK+aUJAJh2ALgJNVcoR2dY2kSc8HsgtPfAdrHzFkTbnzG1aNq6MZ9BMv82IwGqwr0JGK2IsiIhCid29L6kGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=A6S5KVVE; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="A6S5KVVE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=i1vq
	cs/RvYjwwcPYKyLwaaYIcPhGMWol6hVBdEUUbQM=; b=A6S5KVVEcWEBjmdMx45h
	td78AapLxrU2k3jnWjfC2Ak8mHHxq/TBv287RSZEmrLAjBlTz49Adt+CKqeHEJD7
	pJP58vI1Nx33c4CfODKaV0Ikdn+4E3e0fsImfQRzul6AKQYt7FnOEig2M/xOTm9e
	457EowdkgRcMzqA7vS3CgHBKBWDVLiwaZc006swSJyXnudg8EOXzo9/4E6v9IaLB
	SqI6iuIQ/7CcU3cUWs7Gy/wSxdgHYNV/MfayCB5QwTL4l+E+hc4Jq/8wyuyP2xSh
	IYPKI/IGx8q93ol4ZCKm7fLTIR1ctvU5AZRjBSdzrN/L0Wymvg9MHTDR4hRR/b9K
	oA==
Received: (qmail 2341474 invoked from network); 4 May 2026 21:22:22 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 21:22:22 +0200
X-UD-Smtp-Session: l3s3148p1@VeaO2QJRHNcujnvR
Date: Mon, 4 May 2026 21:22:20 +0200
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
Message-ID: <afjx7I6aORbJvuzT@ninjato>
References: <7ddc5b09-b6c9-99f9-d951-6b3ef96f8c1f@axentia.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aawCwhQ4iY+gpLGJ"
Content-Disposition: inline
In-Reply-To: <7ddc5b09-b6c9-99f9-d951-6b3ef96f8c1f@axentia.se>


--aawCwhQ4iY+gpLGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 06:09:58AM +0200, Peter Rosin wrote:
> I'm resigning from my position at Axentia.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

I had to convert your SoB to your new address because the mailmap entry
always translated the author axentia address to your new one. And the
SoB and author address should match. Hope you are okay with it.


--aawCwhQ4iY+gpLGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn48ewACgkQFA3kzBSg
KbYrxA/8DqgEBTsreYbyBg2GhDqnjU4ID2St+tf/3vniV1mndlo9traZj+t/Wsyh
5HkyDEHDEqGA4HgkK+dh8o861NCzwWULJlU4JhdgKox0GDXtOLDWM4RpF/3VAYAo
JwPEoeYgf1pj/U5xcZQ1Wd0iMkd5+6tjvaJ58eHp6K5B+jIKZWjcRxFGeHygD6UK
ECYGPVBubgbzPB/R0efCnCoI93aDe+eJC+O9IbJTPvDtVZ5OjLThhVyY73m3lHnl
O4bsGXm5Wvuam5OncZMDLsbiP8zkuCHtY2zCpkZU7zpR8PGOfkO6kmV1qPiOSnHj
b4pKYevkM/I0Rj34d651EhckVhOkREtN8nn7oVYo+qyT4qe2VJqOSsYCYPdIljtq
r+OOBd87gdcbCntgdE0elzRY9Tieg33/liaGcUjyA/77Locd3GNtU5AKsDyJzxrS
dJHrZToRQVbqQ56LHaMJ3MKRK4K5kFL1n8qq0mygrAtMZ0sLS096k/5/6ZqN779a
nI+LJJ6i/LA/GxCl0n+duilztyXdxoKNaZJc8ATuh15lsrLIP4nXFrY0ReEXYG+0
lmF7tVL7uCQxQz36vjIcmUDz1gS0xZO/po4SBi/Ep+suuG8JEMjkf0L8Q4DVG/Kc
YlLDDIno06qG+7ka2yt5xFe3JKEy2XtvJBbnEu2Rm6TQrpIf1GM=
=B8o1
-----END PGP SIGNATURE-----

--aawCwhQ4iY+gpLGJ--
