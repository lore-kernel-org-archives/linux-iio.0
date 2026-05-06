Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB83290A6;
	Wed,  6 May 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085594; cv=none; b=maTFFKO0yTJX9Er+/5aJkrPSK9e8KnCDlh0FdcAJUhAZtxtljwecH15ksu0UeDAwFVhoxX7KakCcYz9NqUrpfU0pAhYfkfiO8gzZ5a9bd4Za65WZf9t9mmH7FOejCuOxD0WnAioPAoiXFNVySXje6hRRUSVI4bKblJky22hhdjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085594; c=relaxed/simple;
	bh=crTWr37JxxQOFovT22H/1jfD6ittyOcsnJm1GphU0Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzOhmwG7SJC8dibhROU0IJeGWaTPRuqBDB079x/Vt4dRHKQ8l6bCxz+herE8IB4LX2shUp2QjgfpLfTcLVab5vqOXfo3QG9/dqrHSBIadEBVU1iyDSRWS+aQeSMOCOiZgkLC80xjKUAUjnYA8vFCMd3SSxGXzfFnaOjBO754je8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrMtUoFU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrMtUoFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A3BC2BCB0;
	Wed,  6 May 2026 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778085594;
	bh=crTWr37JxxQOFovT22H/1jfD6ittyOcsnJm1GphU0Ik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HrMtUoFUP7pwawcJgc50re6LADgOtwBny6mpoVnJs4xdMS5np/SnmFwDs0PU4p+IA
	 8jIjOlnbT3CGJEuexoAHISzlvCRhaQGe2DOoIedhb4XBKFuPiDcC2S4ttD/oFHhZuh
	 Y0Wq8532Q6/YPSNatypyuOGlcloY2m7gUeZ1z6sGuyOtUITs6PtuDvln2Lucdi9ag0
	 GzurpfeBeOyoYtzAyzETLcxSohpm9uSp5vL9C5lZDkxqlJXiNlP84jzu+KvEuPp8w2
	 +CExhWIP66mNNmSyMrStcs8nRW81nE4eEDwDh3xy7A/DNekQtuK6CuzCvB2a6TzlZr
	 LNbKXKXCUu+VQ==
Date: Wed, 6 May 2026 17:39:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/18] iio: magnetometer: ak8975: replace
 usleep_range() with fsleep()
Message-ID: <20260506173946.2b1907d7@jic23-huawei>
In-Reply-To: <CAKqfh0H2s0GbD1BbE1J0_jUBwkuDTcTPoLqe9nkjCae+r8L4gQ@mail.gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-3-831b9b5550fc@gmail.com>
	<CAKqfh0Hz_zc6+7m2ca8uY-kPNs=ttOh=qni7MdrwFwThEx69TA@mail.gmail.com>
	<CALoEA-xNCjBZ5xdEzEC1zoXL36=Zq5Bfwb0zwP0cU5W0Fs6Spg@mail.gmail.com>
	<afrdalgL3rEvYCEV@ashevche-desk.local>
	<CAKqfh0H2s0GbD1BbE1J0_jUBwkuDTcTPoLqe9nkjCae+r8L4gQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 May 2026 01:35:32 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Wed, May 6, 2026 at 1:19=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > =20
> [snip]
> >
> > This simple patch doesn't change the minimum time to sleep, assuming th=
e driver
> > was tested previously (and it had to be), the given change is very unli=
kely to
> > introduce regressions. Also note that the similar changes have been don=
e all
> > around the kernel in the past few month and I haven't heard it brought a
> > regression to the users (but if you, Maxwell, have some pointers to oth=
erwise,
> > please share, I would really like to see such a report!).
> > =20
>=20
> Alright, fair enough. I'm just not as familiar as I'd like to be with
> the fsleep() stuff and wanted to make sure the timings were good
> before guaranteeing anything.
>=20
> best regards,
> max
Applied this one to the testing branch of iio.git

Thanks,

Jonathan

>=20
>=20
>=20
> >
> > Yes, fsleep() is recommended way of non-atomic sleeps with a microsecond
> > granularity.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> > =20

