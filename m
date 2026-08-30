Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F8623D7FF;
	Sun, 30 Aug 2026 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788132916; cv=none; b=gYSzgsiC62CJ90PxBD4frqIE6BwuTsMDgiQe9XiZyex0EIIsWdfNFbBOct9sZwMr/C4Y+8toflvEUwfsH5mQSZzrMCj9r7yG20+hfxqosQRKcqzw6Fn7ycsfxaoBCvizQ3Wj/zf5YJnCRjozcV6PStrcHCZWnnMXOdIN2dV5AaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788132916; c=relaxed/simple;
	bh=LBShqt0xPCqxxE1LaZQdL3gMiw0xbKNiZIoVt3PLeYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wx9Q83qPNU3y+K9nQ6d5S2xIvjbXsD/etyQa9UYsA/1q8XRbKbJ3roy1HNZeQ/M2lNSHC+krTblUWq+IQKOS04Cmi6vL7WCI+QZoSCjJh9XWDPArgVSeJWfs1AnwgyRDAZw2Q51bue4SPccK9byPU8pg7PXwmmYXn+gRhJmyj5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9oxy5PK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9oxy5PK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AF71F000E9;
	Sun, 30 Aug 2026 23:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788132914;
	bh=g2kf2DhCJC2zDOkOvPHPx9cq0nusW2H5hRVt9faL9fA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q9oxy5PK3aNtbjuABpxiYb7RqluwRMydJSJxwDlWAX3PV/IAWEDwOPnsEwd2foYpM
	 r0e7aAvF9N+aAvEvRkAnqnuiqMVcB5fLBpfG07Hf3NI7u4f4QmbY/HuhYtFpBJXU4K
	 /8GC3Zi01sxWpZ3kFrDsdDHFrvXWLQhrjwTqCyOZe+N54/PPT7yaDAab3JyvRkw/Lw
	 tm2jsLZBZfadVKgU1hF6NNNny94mO0u9Boehp49fl5ACd+Rz+4RQ1ZuPsjQSpxhpK3
	 XvzdiAjpeWp65kdR4s8PrFm7+38pO/yerA9MNw/x8DvFKJ515VZrSsj/9+D9ZhZXU3
	 paOBpp/E2es/w==
Date: Mon, 31 Aug 2026 00:35:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rishab M <rishab.madhugiri@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: core: Replace BUG() with WARN_ON_ONCE() and
 error return
Message-ID: <20260831003509.4fb38052@jic23-huawei>
In-Reply-To: <CANc32tPtHyJdg-PJa0iZHcqX4WDtMFikZFD+4aO96B1+zmf0_Q@mail.gmail.com>
References: <20260826213140.37437-1-rishab.madhugiri@gmail.com>
	<ao_cCHTp9kKfOV-U@ashevche-desk.local>
	<CANc32tPtHyJdg-PJa0iZHcqX4WDtMFikZFD+4aO96B1+zmf0_Q@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2026 15:24:52 -0700
Rishab M <rishab.madhugiri@gmail.com> wrote:

> Thanks for the feedback.  I totally understand the perspective on code ch=
urn
> versus making tree wide cleanups, and I will let Jonathan make the final =
call
> on whether this is suitable.  I've also noted the wrapping width feedback=
 for
> commit messages in the future.
>=20
Please comment inline.

Anyhow, I have applied this but mostly because it is easier for cases like
this to do so than to reply to a series of folk proposing the change.

Slightly rubbish reason, but meh, too many patches floating around and this
is a harmless way to potentially cut that down a little in the longer term.

Thanks,

Jonathan

> Best,
> Rishab
>=20
> On Wed, Aug 26, 2026 at 11:41=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Wed, Aug 26, 2026 at 09:31:40PM +0000, Rishab Madhugiri wrote: =20
> > > As documented in Documentation/process/deprecated.rst, the
> > > use of BUG() and BUG_ON() should be avoided as they could
> > > cause a complete system crash, preventing further debugging. =20
> >
> > Right, but deprecation doesn't mean the _old_ existing code must be imm=
ediately
> > changed. I leave it to Jonathan, but I see no value in this change exce=
pt
> > the unneeded churn. If we ever want to drop BUG(), it should be done tr=
ee wide.
> > Hence no tag given.
> > =20
> > > In iio_get_time_ns() and current_timestamp_clock_show(), the
> > > clock type is already validated against supported clock
> > > types prior to these calls, making the default switch
> > > branches expected to be unreachable. Replace these with
> > > WARN_ON_ONCE(1) followed by an error return to avoid a
> > > crash and to log the highly unexpected condition. =20
> >
> > There is like 10+ character space on each line, the commit message shou=
ldn't
> > be that condensed.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> > =20

