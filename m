Received: from mail-wr2-f27.google.com (mail-wr2-f27.google.com [74.125.225.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6946F48C
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092101; cv=none; b=qFj1Q81IpzzIWmH8F5wA+KjLJZ+hdJRdikoHIvlh4z8/rGdR+o4ZCJLFRFmUrgl4Kwj+cmuTOUaJRmh1tYwPfQaPajKh0QV0UqpAaz2oSsZNgNcBt91hNnZczmvuO7yIOrIA6irnU7CqSeKDYg+7FjLcuVZ7l1ESf2fs41MVcZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092101; c=relaxed/simple;
	bh=CIfPjTSgJNU579mmXNXZ32Ee1aV5b3VoPFia2/BquTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yd+UhGiGjr/WzFCtsWkoQGKiPBOO2MHWbaOnb7MHxYByzdGmoaRDk81bthjrht5GeB69aNTbQb/qtLjd64J2mIhVY2QEUyHNkLI0+4EpUUkls3qih1l+nLixiJiRZ4HPAvcFfVGOuBFSfyrFCOGiGr/1HCiraPG+NRPCSw5mfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6YJyL2P; arc=none smtp.client-ip=74.125.225.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6YJyL2P"
Received: by mail-wr2-f27.google.com with SMTP id ffacd0b85a97d-4843796e373so64281f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790092097; x=1790696897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KQofmJZ8zDc5ZUdeGJ6RMe0Nmm0iRcNJJdGbPQGpS8c=;
        b=A6YJyL2PMT+EZtbZD2h5HXD/wlL/ZxCJ+Wvt6KTBCNDTtFEEiTJKWy+khgaZByzkQq
         EvVWVRrGJikWLRjeKBsMlfq/ElKXQreutPRBMy8fi/PvS32tdQkOIJZvfceNkk7NTqZy
         4Y82kBk67ju9UxwOuveaK8617HekgNhwR1uXoWVx6OXUyhirytgtlUbEfegX/MHYZ2su
         GRULKawri2u0BtPKQLrEXvloD0uMkbhMFKsZnmUsnUiTlTtTeJIR7o5xclJIw7ipAbEM
         RHGlSjH/+hdvXm7Zh2AqRM28Nv4Hr+J3/tWnGQHsT2r2sbEtWviRcU8+uppg0dmpVDU4
         X31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092097; x=1790696897;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KQofmJZ8zDc5ZUdeGJ6RMe0Nmm0iRcNJJdGbPQGpS8c=;
        b=zjxV/bRLlVEOPa6lJlhJyf2UZ7h/EiSeg0sIeXT6NYy0qLjidid31a8g8hZwQ8O32e
         ByZC1sdl/iycknhC/25OpGacL+Ja9WeH9XTQ3229rD3kAl0q2dU1chxQGRMFaLWSqhhe
         3yh42sxRpRpxiKfjzi6jBKCt2Daf7jwjGIycDKnA5rwU4N1fkkzsUKbBOfYp1OfSLjQH
         8JXpJSCNAiU8d0ua8+pnYawA4pxaVeRe5wuSWbNmR1MTv6tpEYDqXe1CLWsLA/6ilfiI
         TNMCiNrTjtnyqT18dSWUWiHwzz3icm4RqX9vigZPed5HM3e5SnUe4617dlSZU8aGXoaA
         hXMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXADws/VNT+i+O7KKKuLbz33j+wXv/jqMMRKOFf9JhcSn8V/VSodDJGS3B6cGh8W/2Os+RTOVGstQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kf71FW3Vyjrwk2o/010vsUGZ+oBE9rir5X8cA0ALAu6yA/oppY
	Y7Vhy9SXB0WE3zgQp+l/xGCJUARtrHli2HlX2OUwpvWxA0z2uyJaYwOohSibHg==
X-Gm-Gg: AYBFou0hNfKzVXWsZAh1tLsoikb4SI7bcpwztysiZq3dp81qrL21CIKoQK7GYGu/8VA
	421N0CDGBKHWYFeLpws5E1SXSkekSnXsSbWR4jW5/Cf48ConjboNhIYqNXQOCkweX+OSRTKAFPJ
	OdlLw2Q/F9R48WcLdu/KtRwiYFlgsWzs/4AMJnckBTlkL2g74rHw8hvNzCYelYfyCHAN4Kl6SO1
	k404EpXqz2P4kPfL2ZO5lFzKVMSOlmasRaDHcQLYXjAFo2Gnh+XN4qyE2idaIQvGxmeTeO5NwvQ
	Pfv4cD5Tw7PMNqLWsejrvP2iBraaQFyMapUu5gf8TCFFpZnoPe0pWaip/UafwgqqSxpaWtT8N4O
	HrsmYR+s5opZU3GRgSL9wJYX7IYBbIMWlD8y3bIST78D/PSOTGSvKDRATNo5cWeVMOxZAcA1sC0
	p2GCQ03NHCooQduwklBh8DVyS4MC4o8YxlD9ghwEq3yq0wmETZfOma3V9GnMIcnijUrI2ANBlZX
	9iOPTUK6eCvnyn4FnNfbg35Ux87f3LJQSt40pT+P7NYwbKIKcvDB25Dbd27k1AUQLQrKiDE0Hh1
	RxIgHJGFxSMTX8fZg3Wr8yph1tc+dYkeEuD/S1NR5EqaXIN1oLwbI1rHiBaFAgkel4xHk6k0YLw
	pdLbfL5SQhRiFFHdBe/vIlhoGtHCgETfRalcXN6R5LzJAKSwU9DDvFj65hnHvkydffARYLoj7nC
	jAe/H2Ewm27F2vjFM=
X-Received: by 2002:a05:6000:29da:b0:487:219d:eff0 with SMTP id ffacd0b85a97d-487219df79fmr13569577f8f.40.1790092097254;
        Tue, 22 Sep 2026 08:48:17 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886277df51sm6041451f8f.15.2026.09.22.08.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:48:17 -0700 (PDT)
Date: Tue, 22 Sep 2026 17:48:15 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 jic23@kernel.org, andy@kernel.org
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
Message-ID: <20260922174815.00006a5d@gmail.com>
In-Reply-To: <arKhAjl9cnsOSzfH@nsa>
References: <20260817111825.000063f6@gmail.com>
	<cb1937e9-c2fa-4d8d-bd95-f53423d88077@baylibre.com>
	<20260818090652.000020bc@gmail.com>
	<arD2UjzKu2k8elgM@nsa>
	<20260922165124.0000132f@gmail.com>
	<arKWs7nTaJAda-XA@nsa>
	<20260922170734.000046d7@gmail.com>
	<arKhAjl9cnsOSzfH@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Sep 2026 16:44:07 +0100
Nuno S=E1 <nuno.sa@analog.com> wrote:

> On Tue, Sep 22, 2026 at 05:07:34PM +0200, Joshua Crofts wrote:
> > On Tue, 22 Sep 2026 16:03:26 +0100
> > Nuno S=E1 <nuno.sa@analog.com> wrote:
> >  =20
> > > On Tue, Sep 22, 2026 at 04:51:24PM +0200, Joshua Crofts wrote: =20
> > > > On Mon, 21 Sep 2026 10:28:24 +0100
> > > > Nuno S=E1 <nuno.sa@analog.com> wrote:   =20
> > > > > > I'd propose 2 documents:
> > > > > > - entry profile - documenting the review cycle, patchwork, poin=
t people over to
> > > > > >   Sashiko, relevant git tree etc.
> > > > > > - code style - the TODO is fine for existing problems in the su=
bsystem but doesn't
> > > > > >   point out idioms we have in IIO, i.e. not using (the awful) k=
ernel.h, preferring
> > > > > >   devm_* functions, not failing on a mismatched ID to ensure fa=
llback etc. This is
> > > > > >   stuff that appears a lot in patches.     =20
> > > > >=20
> > > > > Personally I do think we have some things (not just coding style)=
  that are very
> > > > > specific to IIO. But maybe another docs file is not the question.=
 Or at least one
> > > > > for humans to read :)?! Have you evaluate just having an IIO entr=
y for
> > > > > sashiko? That way, hopefully the bot would take care about the su=
bsystem
> > > > > specifics and preferences.
> > > > >=20
> > > > > I wanted to do this myself at some point but I'm always pulled for
> > > > > something else so if this is feels like something you agree and w=
ould
> > > > > like to get done, please go ahead :)
> > > > >=20
> > > > > [1]: https://github.com/masoncl/review-prompts/tree/main/kernel/s=
ubsystem
> > > > >=20
> > > > > My 2 cents!
> > > > > - Nuno S=E1   =20
> > > >=20
> > > > There was a thread about adding Sashiko reviews to IIO but it died =
out :(
> > > > I proposed adding an IIO-specific prompt. Any ideas on what it shou=
ld contain?   =20
> > >=20
> > > Not sure if I get the above. I already see sashiko doing reviews in I=
IO?
> > > What am I missing?
> > >=20
> > > What I mean is adding specialized IIO preferences/tecnical details to=
 it. And for that
> > > we need to add a new iio.md in [1] and a table entry in [2]. If I'm n=
ot
> > > missing anything.
> > >=20
> > > Sashiko is using the review prompt repo.
> > >  =20
> >=20
> > Yes, that is what I meant, adding iio.md (or something like that). I be=
lieve Sashiko
> > pulls prompts from here [1] (?). =20
>=20
> For hwmon yes. For iio we would need our own set of rules. AFAIK, sashiko=
 will
> use the entries in [2] (see my previous email) so that it will pull the
> proper subsystem set of rules. Given we have none, it probably uses the
> more generic technical patterns. Basically this why I suggested to have
> an iio.md for the bot rather than other howto doc in tree.
>=20

Yes, I should've clarified the hwmon entry is just an example :)

I guess the only thing that remains is to write the prompt.

--=20
Kind regards,
Joshua Crofts
