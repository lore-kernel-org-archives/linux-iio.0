Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175F5540BD
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089664; cv=none; b=BuSMSIER4ZBfJpUjBSvEyXjPFxK05uendd5K0UV1xO2aIRDc8u26OLRI4Tv8ZHARO/TtzKKTqxXYId3W2oevi/KvCHdMiQDc7+prg3SC0gmQA6SOCQOiZiFljgvAx/nAED36bjJ2V3/K/87pnzx5aBSH20EQJWXVOPSdr1bQ40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089664; c=relaxed/simple;
	bh=A5lEFNp4zZC8TW9NCE07Bcytxj1y0F1MHW2S3HOG98Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+VnGQ7Mj+eimhiJMDCRGcnIxuMx3YI2NT6cqlXquAvVQZMrToH1552g6hC5FBkeCDG9zkR9Jgq+F4iDfWWy1IxAMv+ky74y9T+OGujxGlsrvQXB7gFoba9k143aRhfyr1ELrvFGzW26GT2VVJoqoePaCIVQa+dvlz7pTP8R6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7yJZJzJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7yJZJzJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so25483685e9.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790089658; x=1790694458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cYVZ7T3jaCAtW5iQuO9uelNVDbhOTDL0HmEhCbd0NOQ=;
        b=j7yJZJzJ7oTg8DWq13Abc0/PuFs2hQS1chhP/6R9IVH6aKUvReOanH0lTXIx0sO5yU
         SZVxv64vuI8cx212hzpxi6zD9nR4Ow6MNGgoJEpkCwGvfLTAoPFUq1v0P/hFT0Jxi9B2
         Fs4PMKxesK/itI9cXBiTUeVWraesXJB6yaPeNxJQ9XBk56LkrTzAzSYbvzf41QHvkkY/
         EYORqjLVUxBkszIsB+wxZgRZi+DaJFmhhtEWH2eLWvTVFPfG1BrHkYiXC+bi+d7RVUmo
         9/AwpnxDy74YegNekqHQeRSTH3CDu/bf/0rh4QbqjyfZI/CeopBcgOwdx6q7hcWRzRym
         tj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089658; x=1790694458;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cYVZ7T3jaCAtW5iQuO9uelNVDbhOTDL0HmEhCbd0NOQ=;
        b=p6FXlpGp4A4kGj34enepckgkgv5kvkQgop8aAdr+oyGmyxc2Z65ZuWh6BtbIMUApZM
         r9fhDUuNqdJ9HHM1vl+En0HuiNH/LI1JpX5pRhx8lPdcV5a6F5CIOet2V9lPxHPv2Ytx
         3nGtUfISD3XJ/Qfvc2C6oQKfLt3J7PCOPn6GTpMalmdd4PhB7XpET7m/3BYo1n8RL4rb
         LljnpWy2XubZdY3pAHsZPh/BTPfIWTcScWr0WZCvCyvRA846k1QWs7Hh/cuf8eCMIpZ0
         24iBrcuaqsMti35jAOyKTYxtMwP5rQX4KmdcfiwsAGzGfr1/rBZoDw/jfE6Xl42mXXkr
         TZXA==
X-Forwarded-Encrypted: i=1; AKwUvBxqsFbfLb0Xj7B/4EySJ+4NRkhnsPgVJdq2Z9Yg599/0vnDp3HG0vdIPblIyKsoSj65Gk9qysi3WWo=@vger.kernel.org
X-Gm-Message-State: AFuF++mJqyVkT+HK8/YqZzODKhhsJDl0ViJ+fKVQxLVoh9vM0M9LbxEZ
	F0Bz/Ar6521paFhms+gvyUOq5h1xGsWRuXsejC+D4R043IW3875FBy52
X-Gm-Gg: AYBFou2Yd1RGP8DcHuuI0UsLwE8ydKzKI9TsOg/4hzp0+F60u+jylHaO22adIaYQeP1
	XKpK/8ZF0XRRSo4Ezf10Z8p7I3/z8NH6drE6ZUXEwkX6/oTCeCRH3hbK2E0ejcjR/IMGEpceQYN
	uR3+Q6ow+1EZ18Z/njMv8xXhZSiOVh6Vde6NBlf5iMaDhNwgImQmegv7Gr2FAVbA81MrjWN4krV
	kXyiLNwIg0/5bhspBav3ywEBSG36IgXDZ+NwrYYYptf509a4eyqN4uUjsvJziGLyvH06Dd7Qxov
	al81B0p6jyxz7KhJvC9S46wPmE8uRGdDwdQJg7pQ0kqiDckSwwT2APc4ZfI/+FFHh9WDyCzzk4/
	Jn6cHg4L85GxMK0PtqCQZKHy9NO+hLIdfg7Z0yyyDBhqB1uj+Irg8D7oOmmWlzZoY59xUZMChaY
	J/OPsKh3UsrXOi6flcoTsiWvDTkaKFvCsqWTSawI+fg+/6dSKVZDFIez/TCQenf/F+Yo4ZGy/fp
	ISATOEsVRaH09BAfDYbvJ/+YlA9CRBbK87Ga+fxxVAt7EGJPMGMjLf2Tma5Khmoj49oIZiEwa81
	z8E3N6Jd0q73BfxtFedsfh70OMApnxCIi0D7XyU1bjrK/9VQIuPqcG5UluXspVSf93kClwmt4Hx
	0Bf9uRrAKryXd5ONAIkNZB1ce8gNctvP45hog6O/Pdek6m6v9uOYbzAJUIT/0svhFw5xrS6rguB
	MByAWI
X-Received: by 2002:a05:600c:c494:b0:49f:ce78:3568 with SMTP id 5b1f17b1804b1-49fce783681mr134919705e9.25.1790089658065;
        Tue, 22 Sep 2026 08:07:38 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fddfe221fsm869795e9.10.2026.09.22.08.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:07:35 -0700 (PDT)
Date: Tue, 22 Sep 2026 17:07:34 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 jic23@kernel.org, andy@kernel.org
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
Message-ID: <20260922170734.000046d7@gmail.com>
In-Reply-To: <arKWs7nTaJAda-XA@nsa>
References: <20260817111825.000063f6@gmail.com>
	<cb1937e9-c2fa-4d8d-bd95-f53423d88077@baylibre.com>
	<20260818090652.000020bc@gmail.com>
	<arD2UjzKu2k8elgM@nsa>
	<20260922165124.0000132f@gmail.com>
	<arKWs7nTaJAda-XA@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Sep 2026 16:03:26 +0100
Nuno S=E1 <nuno.sa@analog.com> wrote:

> On Tue, Sep 22, 2026 at 04:51:24PM +0200, Joshua Crofts wrote:
> > On Mon, 21 Sep 2026 10:28:24 +0100
> > Nuno S=E1 <nuno.sa@analog.com> wrote: =20
> > > > I'd propose 2 documents:
> > > > - entry profile - documenting the review cycle, patchwork, point pe=
ople over to
> > > >   Sashiko, relevant git tree etc.
> > > > - code style - the TODO is fine for existing problems in the subsys=
tem but doesn't
> > > >   point out idioms we have in IIO, i.e. not using (the awful) kerne=
l.h, preferring
> > > >   devm_* functions, not failing on a mismatched ID to ensure fallba=
ck etc. This is
> > > >   stuff that appears a lot in patches.   =20
> > >=20
> > > Personally I do think we have some things (not just coding style)  th=
at are very
> > > specific to IIO. But maybe another docs file is not the question. Or =
at least one
> > > for humans to read :)?! Have you evaluate just having an IIO entry for
> > > sashiko? That way, hopefully the bot would take care about the subsys=
tem
> > > specifics and preferences.
> > >=20
> > > I wanted to do this myself at some point but I'm always pulled for
> > > something else so if this is feels like something you agree and would
> > > like to get done, please go ahead :)
> > >=20
> > > [1]: https://github.com/masoncl/review-prompts/tree/main/kernel/subsy=
stem
> > >=20
> > > My 2 cents!
> > > - Nuno S=E1 =20
> >=20
> > There was a thread about adding Sashiko reviews to IIO but it died out =
:(
> > I proposed adding an IIO-specific prompt. Any ideas on what it should c=
ontain? =20
>=20
> Not sure if I get the above. I already see sashiko doing reviews in IIO?
> What am I missing?
>=20
> What I mean is adding specialized IIO preferences/tecnical details to it.=
 And for that
> we need to add a new iio.md in [1] and a table entry in [2]. If I'm not
> missing anything.
>=20
> Sashiko is using the review prompt repo.
>=20

Yes, that is what I meant, adding iio.md (or something like that). I believ=
e Sashiko
pulls prompts from here [1] (?).

[1] https://github.com/sashiko-dev/sashiko/blob/main/third_party/prompts/ke=
rnel/subsystem/hwmon.md

--=20
Kind regards,
Joshua Crofts
