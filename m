Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E787513542
	for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682009; cv=none; b=Ptvq2YhgqO5sw1Fv83dHVRQadCALJc0PTMlRx2FDq0xwHJerQ8Htd0vKTOjaeEYU4bafTgsGsYeT1PwwopDVWsRsxxuA46Gb6++XlCtTUeSsOqeH8UWuyPnwsMyU//aaq5MGjxxSqAWCJfWhs0YvbWIupvZ9lJs3xAaSMdtLXTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682009; c=relaxed/simple;
	bh=u8IsgyL0n8tpy3GJJNWYLe0c+JKp0bWZRkeimWzu4ro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHRL8UqdeZAgp3aEYwPethctd0ST1N0se5wGPu3dmTsg2kvlyoC8IVBvXqJU9EfuKyQPsWjYoWR/IbMo+Nn/eTpQRXl4Bjn1vr4BLrFlKVA2xTrsrMcaJ5+tBQhV0axBKjKfkhFxqMqafc1kve9RL7gUjoqZt4wYGmsstrIcqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lwn/bPyG; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwn/bPyG"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-482f6351831so2383712f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790682006; x=1791286806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1yIOKJA8iiYq336CnUG82nFI39PChSWz8mLq4wZ48v0=;
        b=Lwn/bPyG5lzkVNV0fvfxwXQDi+W6U2gC2xFBH5Ic5lRE1L55cjZxSP8CDLZGYK7W5S
         /r2vIHvJEV6P8yl4TwCcOXEwJXo03skkVzeaMQ18gSx82mdCOz6wMf/j2tb4NPzu7FA9
         cpZJCjMs3VN9Hx4ztfffjYyNpBEKQacB6xcHocbAVeZVZEib/9tx9DMvScie3LsJ+nss
         iVAJr2UVrtcgM8x8aKHaJmOMWwjtciFwZSqwlJz7QWdR0isQfxZv692lHKrrl1wILB3W
         I+HDgFglfx9WkG1zF6gvKzXDpe1TaoBIzVwKycQx+frqxW14zMfZGfchk1EMVWk05EDw
         wnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790682006; x=1791286806;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1yIOKJA8iiYq336CnUG82nFI39PChSWz8mLq4wZ48v0=;
        b=ebYfenw3kwvUCFDIQvzMwUeGpEuiz0isBDwFxlvjl8rYJvwc/8uu5tADSi5U5cefwO
         CFLewFRYwwhxfL5FAAcqoip1TLJ03hXlasBGjpKOiI/RwwPTXB87h/uyZnlmTeAbj16c
         x45Kvy84xJEVt3FPnaDgfZQSrNAf/Oi0lzPWy3L12rMh7pN6JWsE5ITA/yxyufR1RThK
         f31daghTskSGikRSHicK0n6/CMMu57DnWLkEDiN8UWhcUJVW3IIynEYpqnx/2JLzXCxJ
         der0He4PGjm7F6oqONL6lkH0IXycHlQtgkS3MEuhh8h2+Y1L4uI6ntBQfsraBpal75o3
         AooQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2Ew4jpVdAY68O/kYMo7HPy/CQJ/As6aFFpfMIlveywXdeEYyxBBiMn4KE25uq1EE3xF5gciZ2mRY=@vger.kernel.org
X-Gm-Message-State: AFuF++km741x9cvl4cTLWst9hejCPLI/qWUhtkR7xGhy1axvPybRVdWc
	955ceE5IfFos25aP1MnhlM1uSVMhinqAzAak1avMqjKz2qhcZJzcw4Hz/mDX7Q==
X-Gm-Gg: AYBFou2npDKXw0ESumuxBT8HsEnd2cQ9mzo+euDpMqU9leurEp5bXdYaFuOhucwyT0X
	d0Dx3TcCvm+d2P9N/gsoUXo6aWD+1xS2dNzR7cbLxo30qfOJaDvi647bLinDP1eoha1TH2S2fw9
	5oQzfoZWPrWKY7R0LWSnGpV75QWoKNhlVkS05H7/SBkgXNjyDp9ELf6B/7rmk5L59j+7EiIBs4y
	TpIixrqu5avOESFhDB18aYFeHtO7FyL1kxLPal3KBKOKHOv8/WZ+/+hNmYA9AHibDUMhgbN6GiY
	4vNjQHTWuWil9hDnl6pAcHbxuAoL5VdWLG9gBw8cT3lV4ttafwtwu13daH9Ivg+hg8jW3kFSixM
	Rv/SXjdBortCkHeepWRydtZcNCFHWU2masyqZmc3OgoDopEObWaGpkkjwZ+ATVVWdW5qW9FoSsw
	4dacERE65LlS9PnB5LJI5sHANbhnxrPrHz/PKrbmXI0hu0MCZAZl1lq6yy0VvAR4GZhIN1oEZ7b
	+G1/49mZSZ1nitSI1TkqYoiI/AL/D+J7+jthmORgPt/by/SdqQdagybfwbXKHA6HOtr2DKWO2HT
	urohvqHgFrqG4ldhJgPC3d7YkanSEeylX+Af852ttA6ab3sXngebU3OvN6u4eXOn5ARKI2wsSkG
	upjH9pXSGLUjhW7Y/zrs0EWqEgLJ+ouxzYb+oDT0b8CX4yG5ipiuJPpJXZJ4ufYjgajb6ngdPmw
	W+kjg4
X-Received: by 2002:a05:600c:1d19:b0:49f:e427:e88f with SMTP id 5b1f17b1804b1-49fe66f1486mr268059805e9.21.1790682005819;
        Tue, 29 Sep 2026 04:40:05 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9b150sm67563765e9.7.2026.09.29.04.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 04:40:05 -0700 (PDT)
Date: Tue, 29 Sep 2026 13:40:03 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: IIO: Likely disruption due to travel.
Message-ID: <20260929134003.00006fda@gmail.com>
In-Reply-To: <CAHp75VdoqXy=8N9K04rr-tFoMgf_zQjb4yYtFSahqaPBaHEK7A@mail.gmail.com>
References: <20260928000824.0c58cd8e@jic23-hlaptop>
	<CAHp75VdoqXy=8N9K04rr-tFoMgf_zQjb4yYtFSahqaPBaHEK7A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Sep 2026 09:34:27 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Sep 28, 2026 at 2:08=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > Hi All,
> >
> > From the middle of this week onwards I'll be travelling (rather indirec=
tly in
> > both directions) to the Linux Plumbers Conference in Prague.  Hopefully=
 see
> > some of you there, but it will mean that my available time over the nex=
t 2
> > weeks will be a bit random. =20
>=20
> Will be there as well. And I will take more days, so for me it will
> also be a disruption of like a week long.
>=20
> > My plan is to send my main 7.4 pull request to Greg before I set off fo=
r Europe
> > and possibly follow up with a small one later (all subject to Greg who =
may also
> > be travelling.)
> >
> > Don't look on this as an invite to rush lots out in the next few days.
> > The first pull request is effectively now closed.
> >
> > Unless it is already something that is in a pretty clean state I would =
be
> > unlikely to take it for a second pull request either.  That will be abo=
ut sweeping
> > up things that are just waiting for minor tweaks or an Ack / RB.
> >
> > Looking at the stats, it is another big cycle for IIO :) =20
>=20
> > p.s. Feel free to email me directly if you are in Prague 5-7 Oct and wa=
nt
> >      to grab a coffee.  LPC is a little crazy but there are always some=
 gaps
> >      and I believe it is in the same venue as OSS Europe this time. =20
>=20
> I believe Joshua wanted to meet us in person.

Yes, would be great to see the people I've been annoying for the past
6 months in person :)

--=20
Kind regards,
Joshua Crofts
