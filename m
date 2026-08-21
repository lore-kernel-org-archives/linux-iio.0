Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913D357CFE
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308186; cv=none; b=N/uH2VZYwxRpyeaLXGkPkrv99yh5X4rUoGBmrkJ7wIE+PMpR9+oOyxuxbvVsD7grJTaHf210lJ1b4N1jMAH28jHJqWPxxxbFuuvEhm7q/OOyHpRPNoFpVAri9jcKMKnWOu0sOK2uiEcvd/U84YRybg0WjtZvuOKcjfNYrftZkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308186; c=relaxed/simple;
	bh=z9EQoVgNbg2axkWkbAyKd8/CEnXWbyzyw2LD4bW39oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E91MvauRvRTDecXkqI4g4czi9ho/Nik76eJbbsUShin1cYPa12Wa1Fgk49UYUxgySM3Uux8kh5yHN09Fvaz3N04TFzpsb/mg2LU+CU7qQwLWkXrUHy5xqtWtniS/God1Abtf2QgKfcKhaUOwfueIgOtR9/EEGgko6i4CkA0Vs/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Z0gY53W6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Z0gY53W6"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a3e145e1bfso1180294a12.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 03:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787308177; x=1787912977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3q2kAFvuoxQvl05k3dFsUQHbA2yys0YHAMJwMetTSBg=;
        b=Z0gY53W67ggpiCJYVuceEnvhCIA5Yp81w5jpwpQ7pd+9AkMk1j13pm/O/MOBTHCpvN
         FtDdFyVNz/dxRKCHW1WkjHCutSIybUq8P5QQHGNU4hEqXCbz2DICOhNM9BO54OBt5x+O
         SSgXd1ckQIfoZx2kDAtsjLgnvTCygdY/WHt4wM488Qje2B9SVtAXGrH1XEQcRVcddIdP
         S4hNmtXZberYFmfF5Q8CeycUkmDCgmHPzcv0pHGqFhzGR0QcPH1irFsjK5CiwHGYwao+
         2bx3Hnan6LIO+ocHShyolGarUXJ2pDtnYmHcsr979U2eRYLXRos2UH2LdWyUimGp4bwY
         TVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787308177; x=1787912977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3q2kAFvuoxQvl05k3dFsUQHbA2yys0YHAMJwMetTSBg=;
        b=tWFLbMeCAO/sQqcqH21xWEQC3gu9uBoS8GnlgbDaksPiGu2FnEhVT9B2uSzHehNROU
         PGWdzLKDnx/AksmPig50WCfOJ3Rik65ikyfEexVs2Kzw3R/lxwLaZO58IlH5sR/8sJIS
         8EsFY2STVE4lW7xOZ5s54JCrU3CV3yrLZGArfZ/YMgXVDN/bK/573hBVPb2eXDehcUbp
         L9hQGeQSD0sw4h1AWdrbnklN3IELcA5PB6682YxxKZA+qrp6zKxm0pIQHopPpwYAh09h
         3vyD+JRqHVpLT5yTzJ5iVHaTCknVLYw2DDa5Avt9m+7x0Cp7Kfj88LeSPB+dRnlBzdsH
         SP8w==
X-Forwarded-Encrypted: i=1; AHgh+RpkKl8f1NeyZB4ajVNwEjEB2blr8tX7Hwj8n8Db5hJWP9toeZJ7FsJjGUoAcP3hTlRsKXJ8J6yfcRs=@vger.kernel.org
X-Gm-Message-State: AFuF++lTlRaeFUZ0w649m1JAUD0zBjqjxC/cuRFysQhlY35zZvstwrYr
	YLMiR9EhabF5f5Yvtz3KwoAGJp/c+Rb4hJ5E4IdRFAkJ0oH9fxPL8RZ8RUXUtoH4DAM=
X-Gm-Gg: AR+sD12h85GLXT4QsRnQ0dvKio62HRlUVzqujg0xwKZ7WPwAzT3pmnX0apbWRRc5MXq
	CdkkUwf+eds99n+YlIOA390DzsdwLfFMvUMoQzE/3NqFyvs5ef5fHRCjWcO0lNTH7fhbDMKjZxW
	4GFFUVLPyysGcYULz3msrshAuikZUfsf626Tpkv4u0U070D6zvh2CzoBd0fF7D0WC50bsk/eMFe
	y24le2yMf0vpWCPLoYwO4E4o0gmnRuCmrl+k/xqtEOdKfM3Zs2GgXhShKl4VbzTs0LlEDt+ValM
	mkHPgQh4SMz2oIF1C6JwLexOx570aPEX6P1ZTB1GaAadiJaundXv2EcbyZAsL04yLGCuF5VQjoF
	vW74Eh2bGmcCcm0rbH+niCh4fzSRgVciZ5Y5Z+jGJQ4GiQvMdRPmh+KW6+Gg985OHTqgwGcFn32
	ahU8MEfpaAq5E0EYvms9yJM0/umCMKLPnNdtPLyIkqeYMbhJiQNJQwNxCx4wpW7Hs1lL/Mtd+BP
	JcsPelRlA2kSsiBcAMNkBObrEDQrY6TNcLt5m5UZiGvAkz8pJnlx8mBgaA+v+I=
X-Received: by 2002:a05:6402:190b:b0:6a3:fdb6:9db2 with SMTP id 4fb4d7f45d1cf-6a42f14dee5mr5384496a12.3.1787308176450;
        Fri, 21 Aug 2026 03:29:36 -0700 (PDT)
Received: from localhost (p200300f65f19a904ef0464a68b5fdde4.dip0.t-ipconnect.de. [2003:f6:5f19:a904:ef04:64a6:8b5f:dde4])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6a3ff0c3491sm5884995a12.10.2026.08.21.03.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:29:35 -0700 (PDT)
Date: Fri, 21 Aug 2026 12:29:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Mark Brown <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH linux-next] thermal/drivers/qcom-spmi-mbg-tm: Add module
 namespace import for IIO_CONSUMER
Message-ID: <aogl2JvYUnxwr_cE@monoceros>
References: <20260812-qcom-spmi-mbg-tm-ns-modpost-error-v1-1-d849390d2714@kernel.org>
 <20260813023543.6936b188@jic23-huawei>
 <20260814000505.GA3919970@ax162>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gftjfe4gnzfoeoa5"
Content-Disposition: inline
In-Reply-To: <20260814000505.GA3919970@ax162>


--gftjfe4gnzfoeoa5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH linux-next] thermal/drivers/qcom-spmi-mbg-tm: Add module
 namespace import for IIO_CONSUMER
MIME-Version: 1.0

Hello,

On Thu, Aug 13, 2026 at 05:05:05PM -0700, Nathan Chancellor wrote:
> On Thu, Aug 13, 2026 at 02:35:43AM +0100, Jonathan Cameron wrote:
> > I did plan for this being a possible issue:
> >=20
> > Ideal is merge=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git #iio-inke=
rn-namespace-ib
> > to the thermal tree.  If I'd called that out originally (or a thermal
> > rebase is a possibility) it would be cleaner to do this before the
> > qcom patch adds another user then squash what you have here in the appr=
opriate
> > patch.  Alternative is do it as a merge conflict resolution whilst merg=
ing
> > in that tree.  If the second, I'd also mention that in the thermal pull=
 request to
> > Linus given it's a little unusual.
>=20
> Ah, I did not realize that you had a stable branch with the module
> namespace patch. Merging that in then applying this to the thermal tree
> seems like the best course of action. If rebasing is possible, I do not
> mind this patch being squashed into the original.

FTR, this issue is still present as of next-20260820. Assuming that
c3dce117333c ("thermal/drivers/qcom: Add support for Qualcomm MBG
thermal monitoring") is supposed to go into v7.3-rc1, it would be
awesome to address this before the commit hits Linus' tree.

Best regards
Uwe

--gftjfe4gnzfoeoa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqIKIkACgkQj4D7WH0S
/k5oNwf+P7ShIOzZtMVykns2ARO4q7wy2ilILuhF81COzO9YwBFJpU55RFz+5SYw
T/3c3PNN8PRp8toJEGod5jjBwNG5nu9Z/lml5aiUQqQn3bg6gbpGMAqVf/OjzQ9G
I1sxcXY3r4keqqNS9lwwVulyV821skH0PCL60ahASvPE553sZKfFXybw40F5+CS1
5nWVgswzlAsz6fCbVqq9BXIvfvHYJLUowM4brWEsSrc61cU1W6T+1OKV2+u7ZV2t
AXgJrJgJiLSbxk8OhDXZfSHhY0zzWnoNHzFYCr3mJ2PP8GDJTWi8vH6RABcTZTeb
aQQWEWJuDyNN5Y95QB2JyfIcZuogYw==
=F3e/
-----END PGP SIGNATURE-----

--gftjfe4gnzfoeoa5--
