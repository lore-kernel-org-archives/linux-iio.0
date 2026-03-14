Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AD1DEFE8
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773486487; cv=none; b=Lew1yDSLbOnPgtPZrt81Y04AVE1mijTRouco4Hoc4VYt+dkoLqAIJkYbviVq8G7cWL6XU/9R36wnZdrp311CKH4OwQ8v+XPu63UuI0G4/63WzQCBds+apml4OMC7Iu6jLN1wXvw6VafC1QwajdxYan7hlMfuxuP0pzqX+Y4ahCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773486487; c=relaxed/simple;
	bh=Hyg4fLhf81sjaKn5jp+QabTmuBj/KAuiiXO/3cSiMy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDtXRLXl1xv3St2ikofJwp+NychAm6Hc8aF7rTTmHlzW0NwaugD8jngXV4jlDkFYKKc4S7Y7ii/MG5mN0N5zQhdop/bOdR5zE0yoDJJUEoKyOZr0U3WWiQeAFRgZGMeYHoHRhlf67Xtjb0tHulnML+tIJEiLpdevpILC4xUmSuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViUxyz+g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViUxyz+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836D9C116C6;
	Sat, 14 Mar 2026 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773486487;
	bh=Hyg4fLhf81sjaKn5jp+QabTmuBj/KAuiiXO/3cSiMy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ViUxyz+g2cqEVVx41+X4Yd7jNbfLg4AeHH+RPbEcJlKRC813T0xVDExIjpEP6/L3d
	 FVMkMSqsv2i885iQEw5DVhFkJh/EtJw8Zzf0gGFnpH2AMAFUFL+fWumiQIa8wdxT1x
	 A12MTNO0MPNICwpHEqAUDYkEs57XGSEI8u/qDeKpuLXKUBWQjO9DaX75xwWp0EyaWY
	 B2D+Ztrm4stQZaaxg1vPEiMpUzCHj+XFWObwKphPsZnYaPZFQPdKqjQpzlfI7jYduL
	 I3G8mH4F12fNkVsnVYNK+yJ3HPvKHz2n7NEY+adE4ZbZCxGLIuP+5okO4iIX6zTLOx
	 b/khIbQuh10Dw==
Date: Sat, 14 Mar 2026 11:07:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>, andy@kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [RFC] GSoC 2026: Transitioning IIO to guard() and
 scoped_guard()
Message-ID: <20260314110758.2fc20704@jic23-huawei>
In-Reply-To: <CAHp75VeZb0pSiAkHo9QUeS+2L-qP_83-dKKRSp7-1VfZrtr1bw@mail.gmail.com>
References: <20260311194624.1521-1-ethantidmore06@gmail.com>
	<CAHp75VeZb0pSiAkHo9QUeS+2L-qP_83-dKKRSp7-1VfZrtr1bw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2026 22:18:07 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Mar 11, 2026 at 9:46=E2=80=AFPM Ethan Tidmore <ethantidmore06@gma=
il.com> wrote:
> >
> > Hi Jonathan, Andy,
> >
> > I'm proposing converting the entire IIO tree to use guard() and
> > scoped_guard() instead of manual locking. This would greatly reduce
> > boilerplate, the possibility of lock leaks and modernize the entire IIO
> > tree to current kernel API standards.
> >
> > $ grep -rn "mutex_lock" drivers/iio | wc -l
> > 874
> >
> > This would have to be a "Large" project according to GsoC due to the sc=
ale
> > of the IIO tree. If this is wanted, I would like to know how these chan=
ges
> > should be submitted to make this easier to review. I was thinking per
> > directory per vendor.
> >
> > Looking forward to hear your feedback. =20
>=20
> Most of the cases can be automated with coccinelle, so you can even
> create a script in one day and estimate the real number of corner
> cases (id est that require manual work). That said, it's not a big
> project from amount of drivers point of view. It might be still big
> depending on corner cases and if you wish to target them as well.

Hi Ethan

I'm not keen on a mass cleanup like this without taking a closer look at
the drivers. I would say (based on gut feeling rather than actually
having checked the stats) that perhaps 25% of these patches result in
feedback on the surrounding code or follow on improvements that are
enabled. I don't mind people doing this sort of stuff as a 'first few
patches' thing but not seeing the benefit from a mass conversion. In
particular it would absorb a huge amount of reviewer time. Improving
readability of old drivers that aren't touched that much isn't a big
priority for me at least.  This particular guard() pattern thing
isn't universal. Sometimes it's not the right tool to use or much
more comprehensive restructuring is needed to make it useful

As to the your question on how this 'might' be done, it would need to be
1 patch per driver because this will cause chaos for backports of later
fixes due to significant churn.

There are ABI changes that we want to push through the tree such
as iio_push_to_buffers_with_ts() but that's because the new ABI
is inherently safer and I want to get rid of the old one.
Some of those cases are easy, others much less so.

Jonathan



>=20

