Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303610;
	b=h4yFccLTdchv3Cqrkd2bWLViYSU84GZ8c+h+bQs87FV9jtlcVO7XZdBY08q2aByH0bsh
	 xPrfehdW5LK1FuCmgiJlSuToQOLO8K7Nfr1T7cqykvlrAJQ+nZdpElB4AiX3+Wi/1x+dw
	 BCNMQSYwKj1eC8h9pdx+UfQSWmfX0RDeclR24aCs+a8fHJTfZ+a5J1vX9EEI7cxxnf+Jc
	 e/vD1F2SrENPYg5TqQKaX5w2RemAGb0BIZwdy+EvhG6uK2xP5D6ImfBJRK2S5Zv9mM22X
	 2Q5uStA7s3WzH/EZOR7usN+S2zTpM6WHyyjj+j8hY5oVQZioA/ruBLfVHMJRqjw/R3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XQa27/t7HuzOBuNW1CeD2HKdjuOcRupBblm3fp1zI2g=;
	b=ky0fK0z94/T9XTGQZCUIFU7qggB/0DRUv5unNxVSHfahO++HCzMu7T8dN/TTm9lulbBS
	 N0WMhP6X8w46UOZ7yZZAorM/qZPQToWw5j7MFBSWdwpspUoL5EAFUW/iC9j8KChVZj3Dv
	 6beR2TcJx8rVoLZIuhHtRgD7yIhUbkfPXDZ1+CDnhyjxOU1SXgsYm2um0hQn5b2x8gXCZ
	 DyJYNpeJTD8yl7Q5x00rHhNfkNjXTcscKD+im7xtB36LY/UeOFR32CSejVcSVUnTouBgd
	 Mw/3g0W/m7p92achUQnKnD9CYsJdfTEoHh1obcH4cG4t4FjDDoVj7MIZLwVzjo+xA1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="TF/xYG7t";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8E6071E56
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 09:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EA8E6071E56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=TF/xYG7t
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so18813595e9.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 01:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794303608; x=1794908408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XQa27/t7HuzOBuNW1CeD2HKdjuOcRupBblm3fp1zI2g=;
        b=TF/xYG7t7x1jbQ2fkewApK9XPbzgcslO0bbHQVtZ5wAEbYigvOl3NpUKklUkDpBtpr
         2DRSJ1ReEvAsRGPpys6MGzFXuDCRkWzzbdedmHZ19KvHYtblOIk1XnFmA7Wg1d9TmSGe
         ShnhjNlgjmAOhYxzi7mMtg0IW9yAaF8cFZeBoU1kxKP7SNTJ9ltKduxXeUZx4qzkME9H
         fwvBZZvDXV/Vv8OeYBUZBIlVhXwnwqleCIlKHNUQpKs1lAVi0ldCU0n4Yh+5HqT35etm
         QTh8y217ftPTp6spLfo4rfV9SHbIUgmQwkI+zz5fykOeFWCn3LqsFiuRnjs+qywhyfk7
         Yxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794303608; x=1794908408;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQa27/t7HuzOBuNW1CeD2HKdjuOcRupBblm3fp1zI2g=;
        b=iJscysEVyPDIlAOhguz+FFwnijMWvnZhaNoY2LOZc1p7c/Su+xdWTiNePXc7LIVHEt
         8F+KivPF8NgFNf6+w48RYJxb47IuLNBxTFdwMvLP8uWSVd2ZvzjRsMIm8L05IuWzdj/x
         7SsHIv/3h00/M0NzJlIcOLT8BUaZFV4lHrgfNW9fDZ+icPt8kxLWhHKNj1/pfHSJr0cA
         Mt3D6soIWd/QM5supbJqvl+Zk+HCbJyOR4daYXMy8eHVzWiHrhj/r/seRAJXAFdep/sp
         aY7l/0xr/yBGOm6r1knTxmwDlpHuT8OuYHULVL8DeuPLtyNZV6PM89N+9QHNyYAmWPte
         mEfA==
X-Forwarded-Encrypted: i=1; AL+hErEbjJuBf1WaOr2SXUsTXUN84dreD2x5hceY2ULaDP/gpcGZQZM4i2vjGdYecGeKjl6pmoyfimfayVM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2FzyZ34tvPJZQTYEOlRc6FS82tWpaPONtKKhplHdbTQd9X8ty
	YxuOfeR45sauBmxZG4Xk9P5c1TpqOJYh/x0IzqJgAjRMquypcG5Q0i/UXuWOSgWCdrU=
X-Gm-Gg: AYBFou3uibcfvwkDTKqcqr6UBytI90zaZIjxDVF6s9M8RBNncOCjEO0xBz0kbqC4btE
	5JWbKJaP5kLmI1n4YvYTViNo3MBkOQji+eW7PMHpqswhstrZ3/n6jigylOUcORzMqUImyrlC0BQ
	K1DLHc0J6XAX7tZkAltOxFYtaQ6muV29JZyp+oTAwpu7ChqMJ09TAIPHtbe1gWXUaWa7CBJJYMj
	2me+31T1YG1EyD1EVxdWnHf+NjnNGraw1iXFtjdZaWX48o6EqBG78aohiBdbJxfORK2cpqOXfvq
	aYlL5nAj2XJ+0B1et1/UnNuc1WGCM/r2GYvda0kp+cKWAwaf5PiOKvK4teTbdc2HwvQPCdjJF4f
	emPiFuGbjoca4iSyeUmnt8Xat0V7GGjd4B19yxRn86GLIBy3hKFHFVuoef8kmPufiS5CKg+rYR4
	SWMAE9eoDu/LBX4YOM3mxqkwXZ+xE9Lfy+HPQ21r+ddzZaCwuccgwTKAs4jRmRAp2zixqbr55eO
	WFE9cuy1SS1HjtZUqstbFFv70hWuLenfbfNyqfV6h9Pyo9K7GfhqWXePKBknX8a0QC/IHlvsB13
	Yt+rg3HOi8kwAHsMp4APRXyYn5UlZRRmABg=
X-Received: by 2002:a05:600c:6296:b0:4a1:fe26:24f0 with SMTP id 5b1f17b1804b1-4ba02348dd9mr31353275e9.20.1794303607698;
        Tue, 10 Nov 2026 01:40:07 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4ba022ff5c3sm23953585e9.0.2026.11.10.01.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:40:06 -0800 (PST)
Date: Tue, 10 Nov 2026 10:40:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Rodolfo Giometti <giometti@enneenne.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Angelo Dureghello <adureghello@baylibre.com>, Tobias Sperling <tobias.sperling@softing.com>, 
	Eason Yang <j2anfernee@gmail.com>, Marilene Andrade Garcia <marilene.agarcia@gmail.com>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz, herve.codina@bootlin.com, 
	thomas.petazzoni@bootlin.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <avLluP28gVZEfFfe@monoceros>
References: <20261030164705.297354-1-maxime.chevallier@bootlin.com>
 <20261030164705.297354-3-maxime.chevallier@bootlin.com>
 <auyjgDddFs3OvnC3@monoceros>
 <20261108013218.0fe627e7@jic23-hlaptop>
 <avAy6cemm3MRHSQO@monoceros>
 <avIGbBH88xZwndaC@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xrvk6vw4g5gzbbvg"
Content-Disposition: inline
In-Reply-To: <avIGbBH88xZwndaC@ashevche-desk.local>


--xrvk6vw4g5gzbbvg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
MIME-Version: 1.0

Hello,

On Mon, Nov 09, 2026 at 07:44:12PM +0200, Andy Shevchenko wrote:
> On Sun, Nov 08, 2026 at 09:32:10AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Sun, Nov 08, 2026 at 01:32:18AM +0000, Jonathan Cameron wrote:
> > > On Thu, 5 Nov 2026 16:42:42 +0100
> > > Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
> > >=20
> > > > On Fri, Oct 30, 2026 at 05:47:04PM +0100, Maxime Chevallier wrote:
> > > > > +#include <linux/i2c.h>
> > > > > +#include <linux/mod_devicetable.h> =20
> > > >=20
> > > > Please don't include <linux/mod_devicetable.h>. <linux/i2c.h> alrea=
dy
> > > > provides i2c_device_id and of_device_id. <linux/mod_devicetable.h>
> > > > provides many more *_device_id and thus introduces a big list of
> > > > unnecessary dependencies.
> > > >=20
> > > > I recommend to just drop <linux/mod_devicetable.h> here. If you ins=
ist
> > > > on full iwyu, there is <linux/device-id/i2c.h> and
> > > > <linux/device-id/of.h>.
>=20
> It must also imply acpi.h.

That's true, but irrelevant for the patch under discussion because it
doesn't use acpi stuff. So at least here even with full iwyu you don't
need to care about <linux/acpi.h> or <linux/device-id/acpi.h>.

Best regards
Uwe

--xrvk6vw4g5gzbbvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmry5nIACgkQj4D7WH0S
/k5A0Qf/UlVG2sAQs+UgFERuB1rhQInSRoLdCeHto+8YE/qkryzNXfzSyOCOV13b
/4pNCDCt0zmQeG7W6eHGlvBpZiSUL9nHf6qsm+/Sciw7X7qMOKZUJbE092MErD+I
F9LUxplu7GHBBDeVVwgNSmiIQW1gRlMcNTWHJahPCplAj0sv1g8OEZXOl8FZk08C
6qjffOFMonsW4Q+oKUrQhW8lPsHU74Ah5LooLSWhdfEaWsgrgpXrRYRilKAmDGJw
Q/32M3v6YNBZjZparnKx/Ycw0xsdBW4BrzeKro5GBXDJjyHyEMeipV3I4ecZBVDg
/uBtYslaJ/7hIygWqlHNxNzvlVAWvg==
=3Cj6
-----END PGP SIGNATURE-----

--xrvk6vw4g5gzbbvg--
