Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BD223DFF;
	Mon, 11 May 2026 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520071; cv=none; b=YzApEfXeII9K+Wy3WViEWrx6Vo6yGTdaBX+/lY48ZEsE79UM1mRtGsqEPSw+sq6e9RsvgMittRHp6bUQTX0hO+vGUrnKrO/GwHoFUStEeFszYUG6b2FVHcjxEeHBzupTPjZHlu0xPJ+GfgxX1Sthsfa+e5HEjZ7FObpRRzfnDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520071; c=relaxed/simple;
	bh=eqp4K//W8NdnJQWNnhieEj19AwFeTei9C6+KiP1FPtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8gxCnZCW7iXHWB2SxtHWnZcVE9iNhRu4/n0qLrwDQoPzaQUSLIfvARKSuH/pKOgdtQuPsGoN718Fqh5azZAEZWU1vTScMK6betqrDB7sfX2prD/626i5TvbdcCF/Pm5oioabdOkRraxTaLudQtY7/utIa9e+jObV7D6EjrPzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAuBHJWr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAuBHJWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB324C2BCB0;
	Mon, 11 May 2026 17:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778520071;
	bh=eqp4K//W8NdnJQWNnhieEj19AwFeTei9C6+KiP1FPtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UAuBHJWrCuOhZcfe3xzZotvbVkH1DE+hD0KvkKNqWnulK/7C5sFxEkZuIwv/AAp/O
	 zDRGCmUFXQ4Xq7fGVhctwI5chAEUcXeVEWdT/EPhOrWlR6uEitFSSdRPCGhKz1g60W
	 FYgIHoQsBZ3IS4uDgeH5I5wHH1/0Nu6x7CuhCPqJzNEhDpTSvIcAuzOiDREBqXMOam
	 NdynMBAPAeffpzgGZ8Dijr/2kV8POOjzZEaAEciyfFKblARGYyXQuyFNPLd8Tv56PY
	 1E4lJ6dXiDvAhzAQgnBbxz/PKSQ7EZD9ypKKjxg1BMpduS3MDHsexT1VBK7T+aqqLf
	 68niCP+AfqOWw==
Date: Mon, 11 May 2026 18:21:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, salih.erim@amd.com,
 conall.ogriofa@amd.com, michal.simek@amd.com, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: xilinx-ams: Replace spin_lock() and
 unlock() calls with guard(spinlock*)()
Message-ID: <20260511182101.705a5c1c@jic23-huawei>
In-Reply-To: <CAKqfh0Hmchpq5zvK6Fd=VCqWXN+1FKyWxNyF1O=3zsVEM7HJUw@mail.gmail.com>
References: <20260508124513.17752-1-m32285159@gmail.com>
	<F98D1BE6-7B28-4A36-A372-2431EA151E1E@gmail.com>
	<CAKqfh0Hmchpq5zvK6Fd=VCqWXN+1FKyWxNyF1O=3zsVEM7HJUw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2026 13:53:11 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Fri, May 8, 2026 at 1:50=E2=80=AFPM Sanjay Chitroda
> <sanjayembeddedse@gmail.com> wrote:
> >
> > Hi Maxwell,
> >
> > Thanks for the resource cleanup change.
> >
> > Overall looks good.
> >
> > Also, there is opportunity for guard(mutex)().
> > =20
>=20
> Thanks, of course I'd also be happy to do the transition to
> guard(mutex)() but it seems like something for tomorrow evening since
> I've already submitted a lot to the mailing list.

Nice patch  and well noted by Sanjay - I'd have just applied this
without checking for that :)  I think sensible to do one patch that
deals with guard() for both mutex and spinlock.

Sometimes the Xilinx folk do review so I'll leave this a while longer
anyway in the hope they have time to take a look.
It's a safe change set but none the less nice to give time!

Thanks,

Jonathan

>=20
> best regards,
> max
>=20
>=20
>=20
>=20
> >
> > Thanks,
> > Sanjay Chitroda
> >
> > =20

