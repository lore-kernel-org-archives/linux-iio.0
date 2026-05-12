Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B4397E9D;
	Tue, 12 May 2026 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584652; cv=none; b=HKAsBiuLEVb5zlPIDSkiZtFYVfH/TEVHj9SxzJYx0Seqw879nXi22U3kaTFlZOreogPAPk15Q3hnanEG8ncInCzW4IDVs2/BZfXDXAk2R/qkP0OVyyerk4F0uHUvM+Zton1UVu+YawdnfcDEBGxto7IHxmQn5gcoMUqK/RP+EnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584652; c=relaxed/simple;
	bh=y10DzkQTJSgY23IxPUNxAdZciMdxsq0ITE0/+g/o1+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8se7JEqiEVpgoqqAhDo5M8wDwXho3VDWphh5nPRJ5uW+3LNCwIfYRTppSpfIS440h0p/xbRZkkuapbU/l/nSfgCyhcaWZZDjlEmbh2l9GJUytFEWsUNqeGtbMLf+c3q2TFGcM3QzBcPiPUunBxqBZIq/Dn3xeTfwOVeAjcXxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT8cjJf5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT8cjJf5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCFBC2BCF5;
	Tue, 12 May 2026 11:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778584652;
	bh=y10DzkQTJSgY23IxPUNxAdZciMdxsq0ITE0/+g/o1+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gT8cjJf57hKNmbxtZp80sEh1NSzCayWYvejIGj3oNQ2+UCqSuYg69FAgCgsA35sYw
	 kbWjTMTEjHMWxdvkRM72WYne/rJ//oa+q9Wm+plDg09gjeU3dC4IVzV8WRSf/+AkfL
	 A2gKVJV3gP495SsPzE9sSYe37OwTMAVqKL/0Ta+KUwBOwfgn6oTRM+qpJXpCpCKsrq
	 x0mi4PRiH0mvHqmCoXXjWYkpjPbha88DKgynGLF5b8zsRcWXfhdeFhuYQQ2TxD1Y7o
	 dfn9c/vMUCzrnASIk6b/cXIpIJicbnQorBRZKav78ywgs4583wTfkxUg4xVyYq7rsY
	 RbSZUBGWDAMKQ==
Date: Tue, 12 May 2026 12:17:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, "open list:IIO
 SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] iio: imu: kmx61: Use guard(mutex)() over manual
 locking
Message-ID: <20260512121703.54a7c2aa@jic23-huawei>
In-Reply-To: <CAKqfh0GHY_WkiLQK3rhDYtvyab-iQdiUmGFHnYjix=K3xLXJ8A@mail.gmail.com>
References: <20260507223337.48437-1-m32285159@gmail.com>
	<CAKqfh0ELaB7ifXNT3EkuC-K9s=V-mNgQ9WZt0ufVgmSD3xGQeQ@mail.gmail.com>
	<20260511181749.32d64889@jic23-huawei>
	<CAKqfh0GHY_WkiLQK3rhDYtvyab-iQdiUmGFHnYjix=K3xLXJ8A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 12:27:27 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Mon, May 11, 2026 at 12:17=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Fri, 8 May 2026 08:03:45 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:
> > =20
> > > Hi Jonathan,
> > >
> > > On Thu, May 7, 2026 at 5:33=E2=80=AFPM Maxwell Doose <m32285159@gmail=
.com> wrote: =20
> > > > =20
> > > [snip] =20
> > > > @@ -945,29 +942,26 @@ static int kmx61_write_event_config(struct ii=
o_dev *indio_dev,
> > > >         if (state && data->ev_enable_state)
> > > >                 return 0;
> > > >
> > > > -       mutex_lock(&data->lock);
> > > > +       guard(mutex)(&data->lock);
> > > > =20
> > >
> > > Correct me if I'm wrong but this looks like a TOCTOU race, was
> > > reported by sashiko at
> > > https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159%40gma=
il.com.
> > > If this is a confirmed race I'll get a fix out this evening. =20
> > Indeed looks like a correct report.
> >
> > Take your time though. I'm swamped anyway so will be a while before
> > I get to any new patches (probably!)
> > =20
>=20
> Alrighty sounds good. Dunno if we merge this or not and then send the
> fix just in case or if I base it off of the original. Former seems
> preferable.

Given we know about it the fix should go first then this change to guard()
etc based on top of that.

Jonathan

>=20
> best regards,
> max
>=20
>=20
>=20
> > >
> > > best regards,
> > > max =20
> > =20

