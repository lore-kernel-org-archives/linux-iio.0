Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0722D7DC8;
	Wed, 20 May 2026 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303861; cv=none; b=Zqp7n3UWUPaUk/L8dn2WM2ysE3cHG8kQnt7SVwVEk5ZcnpdT2+mZvchdqz95pAbaStuu1DIIKJ09n1XU09Aa7NquN5xGog0W+Rq0F909y+KU32q8jamf+P8D0Ice/WuA8cezjfnN9TYmtPE3zodcrjzWtZZSp1q9DduFh417z+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303861; c=relaxed/simple;
	bh=V8QtK8WIZJimDpZR8D3/5sJCtukZ+1YEVhjD/TGWP7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekHYL5AwrWb4x6c+DNwUy3uo14ZhdoQpd9STeV17lZmFJRidUVS2t3RM3l63XkIEvq9BDcK3i1BSHmGWYTk7PoT/3XCdyrxmF8fy8VxSDzp0WepCOYtXAzQ1iU7jTQvQWBsWJVsl3oZGD0NnFPuFmsHyiY1hQMrmX3MxAperaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrwVRwkL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrwVRwkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3F41F000E9;
	Wed, 20 May 2026 19:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779303860;
	bh=V8QtK8WIZJimDpZR8D3/5sJCtukZ+1YEVhjD/TGWP7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YrwVRwkLfMSl7STh8r0y61x0SlefUQ740g2wvGCQR+PciA9zwqEaFMgbnT82463Eb
	 GWj00jkImZZ+dUWp4Acx7PFE4bouAH/n4tHn/lsTz058blwzGvXkQMVMPiyC9PFPX3
	 3L9vJKyMWD8kC5/JEqhx02Mk9e5hNJt4kyzS0QukSIwee6X2HGBWtmJrCehI1ojb2k
	 yE2cOS6NypN/Di1dF+KCFIqQ+tUN5M3Dy3XjByK5cvG/ro81zLExd2wyTWuSCza4Ib
	 xEOPq53ZeFEHYNBkuuCvKgOeDD3tgvaIxHGpamvKJbmt9jZoGIt8tY9+a6RF5nP/yE
	 LrABEZavjdO8g==
Date: Wed, 20 May 2026 20:04:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, tomasz.duszynski@octakon.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: chemical: sps30: Replace manual locking with
 RAII locking
Message-ID: <20260520200412.32068dcb@jic23-huawei>
In-Reply-To: <CAKqfh0G43HY9Mt5WW=0evk4Rveh_4hqkMdragdZcd+cQBNGr2g@mail.gmail.com>
References: <20260519212602.30541-1-m32285159@gmail.com>
	<20260520122229.15326-1-sozdayvek@gmail.com>
	<CAKqfh0G43HY9Mt5WW=0evk4Rveh_4hqkMdragdZcd+cQBNGr2g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026 11:49:33 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Wed, May 20, 2026 at 7:22=E2=80=AFAM Stepan Ionichev <sozdayvek@gmail.=
com> wrote:
> >
> > The hunk in sps30_read_raw() adds an empty line before "default:" in
> > the switch, which is unrelated to the RAII conversion and probably
> > worth dropping.
> > =20
>=20
> First one is a stray change, my bad.
>=20
>=20
> > Also, moving guard(mutex) into sps30_do_meas() changes its contract:
> > previously callers had to hold state->lock around the call, now the
> > function takes it itself. A line in the commit log would help future
> > readers avoid the obvious "I'll just wrap it in mutex_lock()" pitfall.
> >
> > Stepan =20
>=20
> See:
> >> Add guard(mutex)() into sps30_do_meas() as every caller locks it's cal=
l. =20
>=20
> Basic but still denotes that sps30_do_meas() holds the lock.

I'd tweak to something a tiny bit more detailed like

Move mutex locking (and switch to guard()) into sps30_do_meas() as every
caller takes the lock just for this call.

>=20
> best regards,
> max
>=20

