Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7DE492508;
	Wed,  6 May 2026 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085451; cv=none; b=KPpdDWK4MCFnPWsEb/Nt2QANRTLIX5PglrmW+pyi6E/05ifx0pZwQFdfmC8Z/RuaEr8MK1cS+fpvuU1gpgmp64yvqzA7XUr1ko4z2X2y2zwBz30IvTC2mY8ZAp0uuJLmNMhsD2lcTMu4jkMqIMGKnBIfChZkRlxNUSOkhS+G9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085451; c=relaxed/simple;
	bh=+dCqL+5KjQ6FHbhhm7bia/0lwOae3a2UAFphd/UAhcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+Rx8FM420fpaHqyjmNSC4OiFEAnmDwa2sig+XLxGKWZtM4Mm9xsiP2SzUQNpjJFgnl6gcBgdoZ2aEfXZX6tc6eiesqknG+u4oK3V6khm+QCNVczwlRU//05OqEXbquBeGS/9DkK1i32f5npDUlQ5hZVFU1eLu5b2FxFNRpl7p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA5baYZ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA5baYZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458C1C2BCB0;
	Wed,  6 May 2026 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778085450;
	bh=+dCqL+5KjQ6FHbhhm7bia/0lwOae3a2UAFphd/UAhcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CA5baYZ09sCz3tdgyKlhbdG93Iy7THHacjH8QLQRdxnIdnJ6qCiUCJwA9o7DELgPn
	 JmF76BU3ymDs6nh9h4uX94ovMq/Jq8q75mfoP1S3dUk1kCCP3cHfw12lPibzz/Dj+X
	 /ETo4LKyJjsxh+xFp1IxwntUoWoaVZRSbQwjdaVXVvpwWpiCWc81EX44Avf/t/LQGx
	 Z3HiiuOMyIb6H9MpwzbFz+M7iNDwIHRTtfOtoDyXfENzIRDuGnvd9MN/qyQ9dtaKyT
	 fDpBa3tjdN6lamrIf5rDKIBa3nbh9sFFZGBNIWueZuO2Gfo9UVXeFZR3Mg5Ud8Shdq
	 TnEuLGBl6Ru+w==
Date: Wed, 6 May 2026 17:37:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 02/18] iio: magnetometer: ak8975: update headers per
 IWYU principle
Message-ID: <20260506173721.1d8c37db@jic23-huawei>
In-Reply-To: <CAKqfh0En+CuUFPttGpb0x26sMtnTS=u1c6UvqUUYiL4bN+yyyQ@mail.gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-2-831b9b5550fc@gmail.com>
	<CAKqfh0En+CuUFPttGpb0x26sMtnTS=u1c6UvqUUYiL4bN+yyyQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 May 2026 19:38:55 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Tue, May 5, 2026 at 6:58=E2=80=AFAM Joshua Crofts via B4 Relay
> <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
> >
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Remove kernel.h proxy header and unused headers (slab.h, iio/sysfs.h,
> > iio/trigger.h). Add missing headers to ensure atomicity (array_size.h,
> > dev_printk.h, asm/byteorder.h, irqreturn.h, minmax.h, property.h,
> > types.h, wait.h).
> >
> > Audited using the include-what-you-use tool.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/iio/magnetometer/ak8975.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > =20
> [snip]
> > =20
>=20
> LGTM.
>=20
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Applied to the testing branch of iio.git.=20
If you do a v6 base either base on that (and state it) or
just drop the ones I've applied and don't state a base.

Thanks,

Jonathan

>=20
> best regards,
> max

