Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD81407CEC;
	Fri, 22 May 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458847; cv=none; b=fiYkOYuQT67dUNljcNiVClOd5Q8DH2yWtsZgDZeYLySWcB3qKCb1ukDIBP8fQ2qUuQXdw8lzUZSEraHtlbcVpEa+sWlOrB8sAKdrp8AHrAvU1yt+f5AQXyZYuqyLVugS7v4yPX6gyz3TZleAl+Mz++5CZm2AiNWjoyHVaDru0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458847; c=relaxed/simple;
	bh=vGSeh/fJW+a9rvrg2l4GQEnRKGhL1atVRKcpJAs4cnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGgYDBHTlpMxK9EcSI9KCm3DYxj48o6dNk6E0Fk5JJVtGBxiBtrbtRZZ6Nqq0MKycBigyvb3kIUl5KYQ0sr1KS/6CXMImb33+WPX2TW4tOvnalM2DC/khQvcP9YncSqQySQLre4ECy4tR4wMLJUGkgQkN66ZWUunSA5jISBs7yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpyDJz7V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpyDJz7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D74F1F000E9;
	Fri, 22 May 2026 14:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779458839;
	bh=7mEYUUPrWuqSt8JdrQO7r0SOcdtoFB4ISMjJj78+2lI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FpyDJz7VI/OK0Ls1TejpK//H8beSWluZdV9YG5XT6/IHxsoOHJ1wWAGZTdu8tkN2E
	 GqKIY3lSgDt0n8lra0AfQeHbGjIWTZsJsnIeT0K8bLOQY0b2NoLrtwGI/PamJg6Ujs
	 DsWA37S6AVoaPustssspm2fN8eu/o4dDM+u20esAuW+vj+6chkWU57XpbT4cAfkRbL
	 KZ9yRLxjXjjI8OXf03S7zEzRuN7dWOqtp2gtK8c8q8uhdR3O1pjVevIWMEMU8ibNHL
	 VTCSaApLVJ4FOJYNPcz5m+A7/IQ+tjbgm9HXT0mBRBmaMh2tqQVUryMPKizYnZH077
	 GUnvmU4cale/g==
Date: Fri, 22 May 2026 15:07:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>,
 Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iio: light: opt3001: prefer dev_err_probe()
Message-ID: <20260522150715.007751fb@jic23-huawei>
In-Reply-To: <CAKqfh0H5uaQ3AOODBOtT844JLRunVhm11Mxv9Hrgcd7kWs+-mg@mail.gmail.com>
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
	<20260521-opt3001-cleanup-v3-5-820169dec8c3@gmail.com>
	<CAKqfh0GeFG7Jw8==fjve9oZ=xy4AnitzF6z84iTLtNKB4wLLHA@mail.gmail.com>
	<CALoEA-w7mjwABNsUVGWbW8FbA6qRvwThjKVC4_85-T0k7rkn1w@mail.gmail.com>
	<CAKqfh0H5uaQ3AOODBOtT844JLRunVhm11Mxv9Hrgcd7kWs+-mg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 May 2026 00:19:16 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Fri, May 22, 2026 at 12:07=E2=80=AFAM Joshua Crofts <joshua.crofts1@gm=
ail.com> wrote:
> >
> > On Fri, 22 May 2026 at 03:49, Maxwell Doose <m32285159@gmail.com> wrote=
: =20
> > > Ah, but all of the above don't seem like _probe() functions. I'm not
> > > an expert on dev_err_probe() but I'm pretty sure it's only for use (or
> > > at least, designed for use) in _probe() functions. Only function where
> > > I know it's 100% fine in is the one below. =20
> >
> > Hi Max,
> >
> > Actually if you have any functions that are *only* called in _probe(), =
then
> > it is okay to move them to dev_err_probe(), you just have to ensure
> > you're not calling dev_err_probe() twice - once in the function and
> > once at the call site.
> > =20
>=20
> Ahh, interesting, I never knew that. Thanks for letting me know,
> that's cool. I guess it's more flexible than I thought.
>=20
> best regards,
> max
opt3001_configure() has a name that makes me think it might well be called
elsewhere (it's not though!).  It is probably not worth the churn of
renaming it however.

Jonathan

>=20
>=20
> > --
> > Kind regards
> >
> > CJD =20

