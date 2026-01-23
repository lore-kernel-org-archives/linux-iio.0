Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1DA33B961;
	Fri, 23 Jan 2026 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162385; cv=none; b=KlHlrHCqXVSvetCUkjddJYBFE94o2s+KVJlWW9zioVU+t578xNqA3STueRUHvQ/D/SKwBSc0YbP7K5/0/a0gvlPG0xkZP8aNNtYHKq5a4WA6w4pNABqClRAnMwu2UrOWkNKN16XODZ1gQPBRGcKvrRxPeNxoaGD30URmZwK3Roc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162385; c=relaxed/simple;
	bh=vR5abBsm/U3O5AV+nyEEHBOsWf1Z3K2+Ex1qGmHdbQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffeYb7PnoihSmBjgKrynl/95oZHqfG04QswCU3uEqhfp/ZUGg3ZWQV7WA/SvshAFOn05G0VpSMmyJPzjSGbu1Z+rcteheBAjck7Qxiyti/yj6d5ZrrMa2BF9EQvlh5Vm+p67o74bkIj/t8O8nY1GgzQh9QRLaMgTu1COYrkqZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vkebqn2k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vkebqn2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABE4C4CEF1;
	Fri, 23 Jan 2026 09:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769162384;
	bh=vR5abBsm/U3O5AV+nyEEHBOsWf1Z3K2+Ex1qGmHdbQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vkebqn2k//BN5RFV2gkmw0to0bTdv7xLHEx3nZICZOU1+7pZmOPc9+b/FwuvJcT7C
	 0QtAumJLLYTF9B2Ej64mgBkhv6IlacIdAntJ859j02/ccQie4NUcbgI/3neB9oFDXo
	 AlSZ3rs62aQDeae+qLK2N/tz79FnKuV62i5Hk3S+kWDwMcy3T7U7T9o9UqoyD0h0D6
	 MXNbbH/G2Kk4ArUZ+ALPHEVYk1EO+5iZa/wavMMuSPhZgtEJS2cpSFxShqN6maMC7m
	 mTsuoh8kd/5NL9+GPLsZvhn4GFGryBdZER8GFHRu4maZT3W3118ojfSXLdN0+fjTEO
	 hk/qpVse6ty6g==
Date: Fri, 23 Jan 2026 09:59:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant <raskar.shree97@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] iio: proximity: rfd77402: Reorder header
 includes
Message-ID: <20260123095936.27efdeb4@jic23-huawei>
In-Reply-To: <CAHc1_P6cPk8T1SXK6jmYPsqzqbwM0h6_9eJ82OiRO-uC1Sn+AA@mail.gmail.com>
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
	<20260121-b4-rfd77402_v5-v6-1-5b944d0605dd@gmail.com>
	<aXCUKMcCyYBf4ZdJ@smile.fi.intel.com>
	<20260122205749.4f939243@jic23-huawei>
	<CAHc1_P6cPk8T1SXK6jmYPsqzqbwM0h6_9eJ82OiRO-uC1Sn+AA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Jan 2026 09:12:31 +0530
Shrikant <raskar.shree97@gmail.com> wrote:

> On Fri, Jan 23, 2026 at 2:27=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Wed, 21 Jan 2026 10:54:00 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > =20
> > > On Wed, Jan 21, 2026 at 02:05:41AM +0530, Shrikant Raskar via B4 Rela=
y wrote:
> > > =20
> > > > Reorder header includes to follow kernel include
> > > > ordering conventions. =20
> > >
> > > FWIW,
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > =20
> >
> > Patches 1 and 2 were already queued up.  I've rebuilt the merge
> > in my tree to drop patch 2 without breaking the rest of the history.
> >
> > Shrikant, it is common for maintainer to pick up the early
> > part of a series whilst later parts still need more work.
> > If that happens, please rebase on the appropriate tree or
> > just drop those patches form your series that have already been
> > applied. Otherwise this mess happens where new review comes
> > in. Review is always good, but it should be clear if it
> > is on applied patches or not!
> > =20
> Sorry for creating the confusion, the patches 1 and 2 which were
> applied in v4 were dropped from v5 onwards as per your suggestion.
> Please see the links of the accepted patches for your reference.
> 1. https://lore.kernel.org/all/20260101-b4-rfd77402_irq-v4-1-42cd54359e9f=
@gmail.com/
> 2. https://lore.kernel.org/all/20260101-b4-rfd77402_irq-v4-2-42cd54359e9f=
@gmail.com/
>=20
> As per reviewer comments , I have split the existing patches into
> multiple commits like:
> 1. Added pre-cursor commit for include order
> 2. Added separate commit for devm mutex initialization
> 3. Added separate commit for kernel-doc for privata data.
>=20
> Because of these separated commits, the total number of
> patches in series are still 5.
Ah ok so in general good. I guess you missed that I mailed to say I picked =
up a few
more in v5.
https://lore.kernel.org/all/20260116200921.7494025b@jic23-huawei/

These things happen so don't worry about it. I was just grumpy last night :(

Feeling much better now I've spent a few more hours getting on top of the
backlog for this cycle!

Jonathan
>=20
> Regards,
> Shrikant
>=20

