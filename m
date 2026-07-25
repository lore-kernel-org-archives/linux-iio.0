Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC089345CD3;
	Sat, 25 Jul 2026 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785015872; cv=none; b=a927fSvvGUzGJmxYY21kRY1SgbsvMiH+7mTT8NC0/vzDXBdYJKi4vQGlQugtajxkXiCEkDaFg8CG8BceXL+31YwScJOTkPBOqKPyp2NHsqOEC5N0fFuwflRyyx7Z15xr+JZ1lfyeY0lJ6aVVfHy9p3FO393UQacw7gd22jR+EAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785015872; c=relaxed/simple;
	bh=KSTblvUc231h5L6UZ9Wc0y1akqJLOH8rKmUsS/MnG6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwEQc6QNGyDqJRRiFtHgk4SGJFzDm+a6waLMDuorRXHNvFKqABxcXuvz+qNxp37VrxTDzSXv2ertYDAvcXMspa3SbtzXQwTPKJ1tg8E01HCCtG9jxB6qU7Zc05m3xMsnaznca6vPs2pZcSv9FWt2D52a3zjOuNIp1JsOQjOxlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyjenvXv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyjenvXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979711F000E9;
	Sat, 25 Jul 2026 21:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785015871;
	bh=ip1Vm+MMbAple9h1pqgjVtDuijcWbUAFn5vT/OvwhI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lyjenvXvs0DA9iOzSd5qJ+zyt/4SIH6Zu8vsnXw426Yt4u8qKBBwYdr3WlH7Gr7lH
	 BaOBq0mLsz3RkNctwzmugZ9pw6wN4aauHT/cwjgXoapB3BCTDgYQvw6He7z5Sg1qZQ
	 UDrCroS2SIXgcb3uW5ck8dXppGlQrmtB5gH3LArLyDO1l7MKh211mpwweVKbtT2cLD
	 g8qxTZXdLPDo5ir7MVS/6gSQl/ZvNs2W8JBgbVprNHYEHg/qmCLtFLO7zb15gfJBXO
	 zIdzqeR2JYs5hFLWtQlEwxQlNI8gMcqYOh+9sgUqENacEKFBs1He0nHuvvY1ressq3
	 vmjgR/zwoztgg==
Date: Sat, 25 Jul 2026 22:44:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] mailmap: add email mapping
Message-ID: <20260725224427.6eaf616f@jic23-huawei>
In-Reply-To: <CAKqfh0Gu-iZ5ucKXWY=wzkUHSm1r7-YjaXExuq=tGcjqg5eerA@mail.gmail.com>
References: <20260713223046.20779-1-maxwell@maxwelld.cc>
	<20260713223046.20779-2-maxwell@maxwelld.cc>
	<CAKqfh0Gu-iZ5ucKXWY=wzkUHSm1r7-YjaXExuq=tGcjqg5eerA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jul 2026 22:10:59 -0400
Maxwell Doose <m32285159@gmail.com> wrote:

> On Mon, Jul 13, 2026 at 6:31=E2=80=AFPM Maxwell Doose <maxwell@maxwelld.c=
c> wrote:
> >
> > I'm transitioning to a new email, add mapping to keep email up to date.
> >
> > Signed-off-by: Maxwell Doose <maxwell@maxwelld.cc>
> > ---
> >  .mailmap | 1 +
> >  1 file changed, 1 insertion(+)
> > =20
>=20
> Ping
>=20
> I'm also away right now (sorry for not mentioning).
>=20
Krzysztof requested the lot are squashed into one patch, so I was assuming =
I'd
get a v2.

Thanks,

Jonathan

> --
> best regards,
> max

