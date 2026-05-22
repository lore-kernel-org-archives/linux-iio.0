Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32D8403EA5
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463246; cv=none; b=im1NFJ/TFd2PotnyL/nas1jWy5N3OCThzBJEpcty73FfNn96MaEG6TKU9kZUJ11KXsuaT7tp2GD6kX+Vx4pwPta/kh2f5MpmBK80Dh424xaG/pZzQ2KJMoXLu8pBXb/PR2PpNZY+kcELpBYfThV3TUhHyo4i5a390Z3JdNVqfVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463246; c=relaxed/simple;
	bh=nLUx2UP4MwpnDMJGY+m5pT1VVtP08/5dK0Olb07sQ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxPyrgsf3UBmbV/nfKiLijrQQ0zogkI290jPAUkmAXeHyvKIbRuRZ0NalyDrcXlQmIztvQJBp5Wy9LyZv/hOxjISevrnI1pkHnu+zPoaa4QTNwYzl+UftWELxrqByhH5kLd+D9EjPGvG921iiHUjoM3VaUGvY4hAI9lVPZYm+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mo26EuQU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mo26EuQU"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49048e043e5so3414915e9.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779463240; x=1780068040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YpzBcWn0NYSa55PlDZp4tOM/PQBOjQz3giuJp/KMUYU=;
        b=mo26EuQUfCsgEHN9e1bxTEbvI+SBP2MIBKPinOspmu/YK0D2nRivGF3SBnQUgXWnWH
         MgHwUeTsi/MZ/kJIInfYJ16BLiSpqDL9iG6OhJDE987zEZrqCrhVDqgo4rAARjjxDNQw
         z/J0ELmlQShAMpk3BDVibULf3AclVk75E6WAIHHZgQ0QnnMqCIuBiN2ZB+DVgXa2iutu
         tAm6yPKLaP0/pMymzPjKkTi5VDVkQD5cMDwUvphMGMap8pU7vMfqs5UAXZto3+KPx9V+
         yUoxxVIEuM1WYgiINkw/5ux15JzkOMhyupodvDz4LipGHd+VY8J4hgnhEY6BEywhdhqN
         StFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463240; x=1780068040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpzBcWn0NYSa55PlDZp4tOM/PQBOjQz3giuJp/KMUYU=;
        b=CYsJIkLET5Y21BeYHkvvi3USu4rm3/Frrs/STzf72dF/PyIJS261gWy2Cm69kM/Tpp
         w9fhdXn3juCefnDS3IKJXraYJpTSFvUd1A2pGLXvkGLENh7sIH5BZ4BsTDOPKfoX5lZU
         1j/1Ev3maygPgF0dWDwknMFT1NSCjO1w1DhY6mpgDh0gH41oMURzIZmInm6YNOoujBDt
         y8iyOJU9sboBZ39IyTICbuDyjdlwXO4fLgL2nF0ViODIZnvjz6qTsFqj/b6EzJrVAGXQ
         9qICeIGIWuIFKUqWAtbND7KtCLcy2FOqB7BQ41V1LyeudAOmmRxE88/V3oFQrjhzRWnm
         ct+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/mXuVOXvz8TamXrfTLEO75uytvVNwcxaucfsjuPfEW9H3tNyQ/yEsiVYZUNiRjELmyP7XLS/FKGH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAckjIVMg7fZd1ibX8XoS+bw2G7I+lo1sZLQk1X29hxjI3Pktr
	scDChsgExuuSNsxQyF/mUQpE4WX4AtCuT/5rmk0r11Du4dRSHF4+yjbL3k0q2sU+bSk=
X-Gm-Gg: Acq92OGWFS81K5GGWwmLjgT5NLG5Hoxb+mepJk9sZU40joX73BMLRZrT5b9EZQI/PJu
	s2hqENGejKeXYlTca+yYuo5+j4dldaKQI1oIqMISL/hJ3xnnBKV1V7WPYgb1l4xVcBgW1eLQozX
	kHKObEcIRqMDAAdrt4nAmugoFW+nv8zHZXDAIcuQsKO+IGJ0TAG0pgk/umyu+Z+d1g3OcR1UBUi
	YdSCakzMhuLlL4d2PFuf9fPNYVju2pCMevjB9noHDeEItqi5KmKUHeLli31ybp0Hh7zSRiOD8dv
	13sGjcQPjU6Jlp41mYvWybj9WUVhxnsW8Be1WyKSYR07whBxsTQbOQ4gecNRQubQdPNWRZXO1UE
	mz57Cbc7t1DQ0XAIlqssiL5nviuMSTncbabJkTSIqSfHe9tFpS4kMx21m6pr4SDvrEnEy7PdH5O
	h9jCDBDXeW2CZ+fL6DUfl5FZ4q0UIQN98a2is2ufAE7JKGs3nNmNT62FI6ysU8tkzfWmcV7Kr4P
	uItbbm0ahc6omv3rkfGhg4kmVXjacaVB7Tm
X-Received: by 2002:a05:600c:a106:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-490424a0d41mr40088135e9.2.1779463240113;
        Fri, 22 May 2026 08:20:40 -0700 (PDT)
Received: from localhost (p200300f65f47db04fdedbb26b9ad100d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:fded:bb26:b9ad:100d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490417a3be1sm28974035e9.3.2026.05.22.08.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 08:20:39 -0700 (PDT)
Date: Fri, 22 May 2026 17:20:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>, 
	radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 2/2] iio: adc: ad_sigma_delta: fix clear_pending_event
 for registerless devices
Message-ID: <ahBwbklQh9VKkfKZ@monoceros>
References: <20260521-ad_sigma_delta-fix-v4-0-bfb3df3e36da@analog.com>
 <20260521-ad_sigma_delta-fix-v4-2-bfb3df3e36da@analog.com>
 <20260522145143.1e651c12@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zblwkgigrtev7vmi"
Content-Disposition: inline
In-Reply-To: <20260522145143.1e651c12@jic23-huawei>


--zblwkgigrtev7vmi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] iio: adc: ad_sigma_delta: fix clear_pending_event
 for registerless devices
MIME-Version: 1.0

Hello,

[adding Thomas to the discussion as he also participated in the old
linked discussion]

On Fri, May 22, 2026 at 02:51:43PM +0100, Jonathan Cameron wrote:
> On Thu, 21 May 2026 13:30:49 +0300
> Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:
>=20
> > From: Radu Sabau <radu.sabau@analog.com>
> >=20
> > ad_sigma_delta_clear_pending_event() falls through to the status regist=
er
> > read path for devices with has_registers =3D false and no rdy_gpiod. For
> > such devices, ad_sd_read_reg() skips the address byte entirely and cloc=
ks
> > raw MISO bytes with no address phase =E2=80=94 making it byte-for-byte =
identical
> > to reading conversion data. If a pending conversion result is present,
> > this partially consumes it and corrupts the data stream for the subsequ=
ent
> > ad_sd_read_reg() call in ad_sigma_delta_single_conversion().
> >=20
> > Furthermore, with num_resetclks =3D 0 on these devices, data_read_len
> > evaluates to 0. If the clocked byte has bit 7 clear, pending_event is s=
et
> > and the code attempts memset(data + 2, 0xff, 0 - 1), overflowing to
> > SIZE_MAX and corrupting the heap.
> >=20
> > Fix by returning 0 immediately when neither rdy_gpiod nor has_registers
> > is set. This is safe because the IRQ is requested with IRQF_NO_AUTOEN a=
nd
> > IRQ_DISABLE_UNLAZY, which keeps the hardware IRQ line unmasked even whi=
le
> > software-disabled. Any falling edge from a completed conversion is latc=
hed
> > by the IRQ controller.
>=20
> David raised this on v2.
>=20
> This sounds suspiciously like we are in implementation defined territory.
> IIRC if an irq is disabled, whether the interrupt is latched is down
> to whether the irq controller happens to do so. There is no hard rule on =
this
> or way to detect whether it will or not.
>=20
> https://lore.kernel.org/all/io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3=
rz2a2@orquwgflrtyc/
> Was I think the most recent detailed thread on this.
>=20
> Uwe - you were driving that discussion can you sanity check what we have
> here if you have a moment?  Thanks!

Without having looked at the code but skimmed through the old discussion
again, the result back then was that you won't get reliable behaviour
without rdy-gpio.

I didn't try to understand what's different fro "registerless devices",
but I doubt this implements a robust solution.

Best regards
Uwe

--zblwkgigrtev7vmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoQdEMACgkQj4D7WH0S
/k7ONgf/Z13WLZ5EanU+dQwXvMQnIeZdqUc8eYKifYLtiWO+OHOVU2FojoCptGpH
05CdaPG/kDEq19QInvtjCJsNrlSg1tlgqtRfqwma9/a9bPkGns/dooiLt1jGRg2P
vNbDIKFr36FgVLxhh9L/RVUOMAOFCjpnvo4PJJv1YiREEaEOe/zINgZDbUay1PQ6
FQELENs/1nKriB9Smirw4qH4i2ELqQDadfW2PYNOIQGOmQV9X0bGEcJlwkhRsyVu
4qRB3zxhSfdzkBKz1SpXdSFQPsN5wlVcS5amq/OsQTLlgKt5itocWZVr8XqosY3T
p24ex/DnEdBF/owQh3+qLMG/L680wQ==
=Rdq8
-----END PGP SIGNATURE-----

--zblwkgigrtev7vmi--
