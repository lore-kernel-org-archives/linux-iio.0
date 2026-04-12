Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26227A916;
	Sun, 12 Apr 2026 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776004251; cv=none; b=RQmkEVhzXGseHtaOVnLpaXUI0u0Bq/5EE3W415h+zu1Yb6e0KCOhp8fkKw0eaokWKdnWzRmH3AZlRbD+6lSjW7LcgiHEiKIjrFedPjtngQbK/S+pHzTl0MaRBse/dm5RsnPC5UD9hzJLPQ1lX77F3FYTKNhnJSklARn3X5jE85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776004251; c=relaxed/simple;
	bh=2gzcxfJeBiWbZmIl0C9gQie7Je7b4SeDA5IKTcaLUv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcQ9MyNQthUk5rn7IYNLnRg/lyfV5rax13UEX/QAzQXj0wwXpgCP9M3IEBvS3k6G2WWaM0Ps4R2d5L5rOUyxDJCnidVRre7lGfRsWVZ+YmSN9xYZtinac+Ab48/HtKb5Y5F2zTISnSdXUwRR0bVDrpJMMiblB1vsAXxMA0GZma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0MVs6iH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0MVs6iH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A25C19424;
	Sun, 12 Apr 2026 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776004251;
	bh=2gzcxfJeBiWbZmIl0C9gQie7Je7b4SeDA5IKTcaLUv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A0MVs6iHum1jlWbCUGMKw+4G0bj7KbLzrV2oMVnYzAzf5n+adMF9l8lsSeAv0WYqF
	 yDIEHX8nv7sTf8+Uavkh/lsboL7tMFSMluEzG1drfEKSp0KBIWLSzRXvgQK7r027tU
	 q0NQnMzDuF2yBD/aMrpek2dO+VqAvAOnuLS+1uGzoYiO5gnY70osMKdyEyEzwniDMx
	 OfBahKHpKbiIYJ4uDN5CVDKciJwLp+n2D5gYwMdVr+67X+n8Ha8xN+zZS4xMq+R/sC
	 4c1E+y7SbwJxVe2omxkhvpi20lJIWMHsDKXNQPniZgRdYyctxNe0Scan/BXD2Z2Alr
	 MvvcMB4OPHXJA==
Date: Sun, 12 Apr 2026 15:30:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7191: Don't check for specific
 errors when parsing properties
Message-ID: <20260412153040.0e6f2d7f@jic23-huawei>
In-Reply-To: <abkv_76b1cue1bGK@ashevche-desk.local>
References: <20260219143936.2276366-1-andriy.shevchenko@linux.intel.com>
	<c59c19d923d369eac2a0a46405e13e41836591c2.camel@gmail.com>
	<CAHp75VcpuxP=3cGuVrJoSuirQ3vPNR9LLWkf5CyaGcghJ2hzag@mail.gmail.com>
	<abkv_76b1cue1bGK@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Mar 2026 12:42:07 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Feb 20, 2026 at 12:33:28PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 20, 2026 at 12:04=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmai=
l.com> wrote: =20
> > > On Thu, 2026-02-19 at 15:39 +0100, Andy Shevchenko wrote: =20
> > > > Instead of checking for the specific error codes (that can be consi=
dered
> > > > a layering violation to some extent) check for the property existen=
ce first
> > > > and then either parse it, or apply a default value. =20
> > >
> > > Not really sure how I feel about this one. Checking for specific erro=
rs is a very common
> > > pattern and this change just makes it we check for the property prese=
nce twice. That said,
> > > this makes it more "future proof" (though I find it very unlikely for=
 ret value o change). =20
> >=20
> > I already have an answer to this:
> > https://lore.kernel.org/r/aZcenabXYsOdBu84@smile.fi.intel.com =20
>=20
> Does it help?
>=20
> > > Anyways, even if we choose to go down this route, I don't see much be=
nefit in starting
> > > converting the drivers with the pattern below (which should be a cons=
iderable number). =20
> >=20
> > There is not a big number of them, so I prefer to have common patterns
> > without exact error code checks. =20
>=20


I left this one for a while to see if the discussion would continue but see=
ms not.
I'm not sure it is always the case, but in this particular example I think =
the
resulting code is a little nicer to read so applied.

So for me, case by case basis for this sort of change.

Thanks,

Jonathan
