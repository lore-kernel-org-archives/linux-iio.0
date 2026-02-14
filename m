Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC415687D;
	Sat, 14 Feb 2026 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771097824; cv=none; b=IYmRg0bOJ2cTgzsSU7wr2gpl2bL74T5wz/ZtnFbKxi1CvdxyhYSUsWC5nDJ+tHFJBn6XVQhMLer5NetgkYpfHVDcyw3KWmB5435FTmLQWUXapUz280PLPq7cQShS7THvAz5o78paDa/1JSChV66KCFajg/KRg0rswbeO8jF8Yz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771097824; c=relaxed/simple;
	bh=fm61Rmr0+qWsH73wwxe8yX2TOhhZ2Wj3iPzIX2BYZ1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYB8okT7agxZcy+zlTuKQs58etz6NZQqQ1MYEAbJiZjiNQV9nOsjagzPzD06BUkT5Fcp+lZ3e2E4x0v4eWFJWyND3UqDnNVXnQWAiw2CrI14WhS4rjBecREqBOWzUtFo8Na81PMW/1t++S6Aek35P5n6CwQI/ySbKjkuqU7R/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAcz1cEt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAcz1cEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A18C16AAE;
	Sat, 14 Feb 2026 19:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771097824;
	bh=fm61Rmr0+qWsH73wwxe8yX2TOhhZ2Wj3iPzIX2BYZ1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KAcz1cEtwo8HnTnpjGvB5El/npRpPEiZ/yVbgm8moJro7I261WTkaTFQHn0kJkMoM
	 0BRVPpKmShXOPhJj5B16jKeBNMcglgdkLSieIH1qFHo5wN7fe+DdBf4MY4xd2y5Pte
	 Vx3rQsSRARxfONGLv4KtjHRPzJnJ7RoyycRfBBb7iIOzakFZpY6PZsmOObjSWcJg7g
	 38nSsbLap/Mn9uuzcEt+GpNUklnTCOaElYkFjTqiLRGOpLxH7UKI/nXm2T3ppA2VQx
	 z0hx3k6Q1k0TrwzsuVOBubWKOro2P/bLBG9QYDuHMPjDTMw1HNux+FTffc9rb4F+bv
	 1VYnR3Sny8LWw==
Date: Sat, 14 Feb 2026 19:36:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Marius Cristea
 <marius.cristea@microchip.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: adf4350: Return -ENOMEM on memory
 allocation failure
Message-ID: <20260214193655.01f75842@jic23-huawei>
In-Reply-To: <CAHp75Vdy=0+RF=4OSa-p_kkAkqqBZHOUv=nZ7sF3PjajfTr6mA@mail.gmail.com>
References: <20260211171007.143527-2-antoniu.miclaus@analog.com>
	<CAHp75Vdy=0+RF=4OSa-p_kkAkqqBZHOUv=nZ7sF3PjajfTr6mA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Feb 2026 19:39:43 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Feb 11, 2026 at 7:10=E2=80=AFPM Antoniu Miclaus
> <antoniu.miclaus@analog.com> wrote:
> >
> > adf4350_parse_dt() returns NULL only when devm_kzalloc() fails. The
> > caller should return -ENOMEM in this case, not -EINVAL. =20
>=20
> Right, and the memory allocator dumps enough info if it happens.
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
I dropped the fixes tag as seems inappropriate for something that doesn't
happen except in the death throws of a platform and where it only gave
a wrong error code.  With that gone, applied.

Thanks,

Jonathan

>=20
> ...
>=20
> >                 pdata =3D dev_get_platdata(&spi->dev); =20
>=20
> Side note: Have you considered killing legacy platform data?
>=20

