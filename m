Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02C1FF1C7
	for <linux-iio@vger.kernel.org>; Sat, 26 Sep 2026 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403199; cv=none; b=eMoY3QS/Q8z0LXtugSmA3rE70XJwR9Xiskfjnyn71KHJcqeoY93atL3zPCEDGxe3lh1CLd2V/RN/VDC6dq6SFpJcVrA3W0RGmdyUAWwbMkaFKMquw0MlN6c/cJHDWC5yY/EN1g1ht3EhBIC8gqDKNPIPP3LxTJd7+vnGXJdS7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403199; c=relaxed/simple;
	bh=JhcNgD5ym0n7rwQt8AOhW6hhqsqms6onYIIkuwgKgBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7N9Zq87EdIS1scqnkSgUPOOnidxoI1Jhwz8Tkxlv9vpzFuoDZ/tddo8DAEOe0LWTVVejwVqaiBPethxTFHpg80DDqstRiJbLQ7heoyXzdstjMlNw71BfN1AFib1dvGLxRvTVy6B3c2kZeUmm3CFvVPcUQota9nC/9wncBd5MX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=c0GRycFa; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="c0GRycFa"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff23af865so10713385e9.2
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 23:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790403196; x=1791007996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n+km6I0NWRugPNV0kiVWI6nk70n82CkGaUZAPuixyOY=;
        b=c0GRycFa3eglYxxl2TfiX9HAjmix0YX5ADYM2UGNIN/yiNhj6cO55TSRLUiz5o4lAx
         uRZttNMsOg7dfoIGEUUQUgK/em5JwdtFAnfOrJ4PtqPJNd+/1FGtiOUcVJDjHLiUYmo5
         QwgaGR2D0nnT/z/C9vobkhhXsD/vfKc3aKGg8tDb+K7dHwwedRGLcitbkp+DZS0tow/u
         xbM643tCjRvhySTYPsPg5rVmaakY6ZHgXe+m5CuWE8iFBD1neB/X0XLofBg328v98j2D
         bZ4p2isFCfP9a7vsqlruc4VCjgG4jNxWbXlFGgp/83eIyDdOaouUk/qHrCojrmdqQx3O
         Zdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403196; x=1791007996;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n+km6I0NWRugPNV0kiVWI6nk70n82CkGaUZAPuixyOY=;
        b=TjROOkZpR2zf8qPNs5pA1qiNaPLWTGH8yxyRmoc944Co2ohdULYpQhjdmsD75DG7Oz
         pC7qu0gmpb3ei54P219s0dSwJ4jqBdSWP1O4ZB1TRHeiEdPnmRca52xzgsky0pXcRE4o
         3f19hX4iFvHsg7cJfSJowA+73GfgAhS8DuhqnQ0FR0gZT1PZF17rpUlKZbbJk5uAtgtE
         AJ9sxkuQNsxshB8CiFAMcvZf72qx88XVg5HdboQQciS/uPgmrLjBq1x/DmNFfycWRN/D
         SRdyFiaiS3WkfFjwiiwH4ta5Kz+j/y+Qe66bv6KYwQBpcah4cajeYEpnuFArZ88rhwhX
         mavg==
X-Forwarded-Encrypted: i=1; AKwUvBz9llZxKFwPwOULFXs4MO3NDENjUJAARFYex/QbReuyt4O8lTEr9K41ocFuaFm9w9qL+dW2qBNLjBo=@vger.kernel.org
X-Gm-Message-State: AFuF++lY4syuaLinYDnsSzTv62BY70hrnJboW02q3Ld9ARZFxmngCK8g
	OTRnit9xnZtNZhe8+wcYTzbCI2xOsqou4rz40jB9mSK2borTDDG4/mbp70uYHkb/TaPhzi46+ms
	Z36gw
X-Gm-Gg: AYBFou1rToiKRYq0sAOoM85tVg3B9y5mxtHtaZmO7OgQwtsrU/yF5bf6V4K1+J0zU3f
	BU63KNiAAaMpgS5kuiW083bajMZfSMjjiiJslnRCgXuydY+u+A0BmblQEP4+gh9/LIxgpZ+TL6c
	ZPPq/eC24L3v8XDgQurIWbsY7dTHDBV20n2FEeN2fVHgC14BjwYIlkM5PAXq2gk5B0rNDLwXUMk
	mr6kPswiex2TeNRiTSahkV1Xy7c66500OoP971ec7qpHTmFGhMrBF90O8XE9COfHfztwpNYySax
	0d2ELeIdcF0Ey4LYLLivCpAwN+E5t8yT3V3VSk8O4PMH44QDQzY7LoOO5d9ze9W9mWkbeXjD2RX
	lVejn4eYTjiLychi0eqbdoZzh3hLHyWQtK+xDz8FTA+8vX+u4yodjZkhLF6VkbTtzEve8Qru4fh
	YYn4saZVR8F4Llouet9+3Yoq9e0jGyhLLsrRgzDerbd/SL2Uq8a/a86cDo9pW3ORbCghTrdAnbR
	2IP
X-Received: by 2002:a05:600c:698e:b0:49c:fc6e:a3dc with SMTP id 5b1f17b1804b1-49fe66f1491mr142775025e9.27.1790403196073;
        Fri, 25 Sep 2026 23:13:16 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49ff06b6108sm129009385e9.8.2026.09.25.23.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:13:15 -0700 (PDT)
Date: Sat, 26 Sep 2026 08:13:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiale Yao <yaojiale02@163.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rodrigo Alencar <rodrigo.alencar@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Anshul Dalal <anshulusr@gmail.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Herve Codina <herve.codina@bootlin.com>, 
	Shi Hao <i.shihao.999@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Angel Iglesias <ang.iglesiasg@gmail.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] iio: validate SPI match data before use
Message-ID: <ardhvKaSdYh2HiS6@monoceros>
References: <20260925131738.2200612-1-yaojiale02@163.com>
 <20260926021143.478d5361@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qj3qlzf53fecmdod"
Content-Disposition: inline
In-Reply-To: <20260926021143.478d5361@jic23-hlaptop>


--qj3qlzf53fecmdod
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/7] iio: validate SPI match data before use
MIME-Version: 1.0

Hello Jonathan,

On Sat, Sep 26, 2026 at 02:11:43AM +0100, Jonathan Cameron wrote:
> On Fri, 25 Sep 2026 21:17:29 +0800
> Jiale Yao <yaojiale02@163.com> wrote:
>=20
> > SPI driver_override can bind a device without a matching entry in the
> > driver's ID tables.  spi_get_device_match_data() then returns NULL.
> >=20
> > These seven IIO drivers use that result without checking it, causing a
> > NULL pointer dereference during probe.  Add the missing checks before
> > the match data is used.
>=20
> I was hoping we'd close this finally by adding a flag to the
> drivers to say they should fail a match if driver_override is set.
> Given I thought maybe that would happen when Andy looked into this
> a while back I've been sitting on this problem for a while.
>=20
>=20
> Unfortunately seems we have to carry on papering over it in the
> drivers for now :(

Note there is another effort:
https://lore.kernel.org/lkml/20260922-driver-override-opt-out-v1-0-58c35ded=
3b83@nvidia.com/

Best regards
Uwe

--qj3qlzf53fecmdod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq3YnYACgkQj4D7WH0S
/k5G3wf+ISl+49DMFXf4GNQEB2v8tA68jc5xy+T5JzNOcNEajtXS1J/YhuorbySX
ienyxR20KZdHnn2ax1uAP+2IjdhZbLyoRFxHUw+p+EJ5gEJNm4I0vQaMTr/IhF79
Mkkc9TIyswqCMGbg3fUHtDOGWQTjUwlpRRZwKcdLvUgGL3A+ZAZXj36SlPhQn/cA
DUo1TDIplGtu+FuHgPOXHd9TcmMbIsqz7Dw0UitCJPIMQl1NJRhracEWxaX3Ro4f
/8sncXjnm7obW25uWPW2JvMqcZr8Kp6bUWsp3lj6gapfnyXXb97Htcoag4i+beMY
kVyfupYJzav/YzrpCYV1FqnYd18jlQ==
=VFj7
-----END PGP SIGNATURE-----

--qj3qlzf53fecmdod--
