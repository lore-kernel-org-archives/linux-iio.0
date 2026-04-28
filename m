Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BAD44D6A4;
	Tue, 28 Apr 2026 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397985; cv=none; b=cZ85/qc5Kpr3DeRuWOPuijWIMSvAzLkgECRfWa2Mh3KPonRCPYXIkchkr7+ndARB0uKL5nAaL9EFrGyA2rFgWUV+xppwSwcknyCiG/x5RWHN5e5jwRwP4SZTgXwI55dGYIF+mSkQd79Jeeo8qHTgFGvsVu2z95Z7HOQDfp6OIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397985; c=relaxed/simple;
	bh=CkN/t8W9ONX8NxZJ2UzBMmylTOs5Rz36qjuLu+hxQ/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbMuGEb/dsByuABF3L2J+3AHcYW6oxicIlJAqrDqqxbz4m2Cmg3hwIRY2mL8fJrxDCXITMwYHADqg/GygJc/AyIC3j1EHhaFQR4w93LUu4ZlXNTXJ7kecNCrFr06g25aa0KbSgTqyspPigp7M9EzlByhPJlG4Rh1So5D+/P2dJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Npf8wqhe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Npf8wqhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98DAC2BCB5;
	Tue, 28 Apr 2026 17:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777397984;
	bh=CkN/t8W9ONX8NxZJ2UzBMmylTOs5Rz36qjuLu+hxQ/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Npf8wqhemgIo5c2P1Lr78+HUzQL3VRZZj139je1kn2NLTXsTTu9P8xesp1dgLBpC8
	 VMdvLlUSM50LEL+5h9I+KAQRHxKi86CksZbTyWTBmR0BF6MaLTyHKqR+IGGkSFlj3n
	 3XhMkImujKKiLM+Yf0vJovYjkbAPi5iSYEwWI3rPaSDEigj2FCu9uA6FAaTb1Wda3c
	 AZNaWaoILpN6b/WWyJxYd+0XoYzeBaSrm2ynv3Aid9ioQsqn4CPnJze/Lz9GYZro4+
	 xHbfiU+VeOLtoimxyDHzF3m8j0+qQ5t/L2ZdT2TjrzvvlLibfAMaDkOudCpRujpYMo
	 cXuPRINrkFKOQ==
Date: Tue, 28 Apr 2026 18:39:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: magnetometer: rm3100: Use guard(mutex)() in
 rm3100_trigger_handler()
Message-ID: <20260428183935.29af0f41@jic23-huawei>
In-Reply-To: <CAKqfh0HbPJN-L9ji9=Oq=g0UnEk0FES8iQE_mfTpyXdcB5j0Jw@mail.gmail.com>
References: <20260428124644.49707-1-m32285159@gmail.com>
	<20260428124644.49707-5-m32285159@gmail.com>
	<20260428163247.4511aa5b@jic23-huawei>
	<CAKqfh0HbPJN-L9ji9=Oq=g0UnEk0FES8iQE_mfTpyXdcB5j0Jw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Apr 2026 12:27:18 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Tue, Apr 28, 2026 at 10:32=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> > =20
> [snip]
> >
> > There is even an outside chance of deadlock if you hold a local lock
> > when calling iio_trigger_notify_done() as that can call back into the d=
river.
> > Here you are ok because no trigger_ops are set so there isn't a reenabl=
e()
> > callback.
> > =20
>=20
> Given this, I'll also likely go back to scoped_guard as well once we
> remove the gotos, that way we'll be able to unlock it before we get to
> a potential callback.
>=20
I'd prefer a helper function with straight forward guard() + returns.
Then you can have a single exit point from the outer function.

ret =3D helper()
if (ret)
	return ret;

other stuff.

> best regards,
> maxwell

