Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85F48BD56
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590187; cv=pass; b=UHGoeF+gSRqpFPILwVYtkAOidnFRC4Bq0Bq8FRhkgE6CBdj4LkkfDyYwyUzDhGtyUsjf6RFRSLeU8oxgQcB6dEI2ZCQlcYBUtCpR61322ZtdYQ3fKsUwVURACOisLELQcjmI8YkTvfnfOzxWP52g+Sps4AWVNNNdKC+Blf9sksA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590187; c=relaxed/simple;
	bh=R33MDLLx98AGcEWtjDLJMPWkATner6/vdrhTj3+qESw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLbaVk3NI1tlsWf5ZV0osuN6ZqUJBLAxLhnFAd14d2ZWwG4trbdscsFP7S0B2q0/ndnw3Lap3fl3x+NmxS/mmN9aYLmlp5kkUmjIQkBwrYqXzMS2XT3ooqmI/RvaAkzRquiq3G460a2zPhu/cuJla4fPi6Yc3NkiQiOtATWntLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcOo3a+4; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcOo3a+4"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7ea16f090b4so13392027b3.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 09:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780590184; cv=none;
        d=google.com; s=arc-20240605;
        b=kDs2M4yBSuaVI4oiUDaUaDvlqYFUfbBLWEgG9pfzTecTIw7VL52XwyrNaJoV+MbDCr
         +UrGbjyOAkIaxhwP9Z45EFLhq5R45sYpQYFTRzP4Cjm3NLAVp8LS5AN5MQTnuIwtTZWB
         HSr0DFBF/uToL3Vf7Yx3pE2/D5IKXkjV0lXfPNDRSo7HQ8WYYlUCUPnvP7p9fcM6h5XF
         Z98zcQcs2IhR3kp28m+OAK4VloqaNukNjlkjDJ0bYtOm2PMlq5BfN4um5o9Kh5Xgs9zt
         vIGDw4JpyZMRrz7mYm7tJYrK/QJEsQHhoG+P8GRr/HyqiljGJT2eRoqr3F5xP3Ea87vg
         opsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J4GlRxMa9J9gLARfP1LhX+QwG+3ogwBamX6CE29VQtE=;
        fh=NcjN+JJ6bsEALQeXQnPeso/MYCWqJsEzNfTjMvKCWM0=;
        b=A9e46Ph6xaHKudTjbPuhKoyk1ajNM4DVwM/WuGgQzMFUMTz+qba2ByMzysLorTH7EI
         g6VawiIbwbELRHlFCyFGT+jyGMG6poI5A9BDJCAqyhxU3ZKKPPuGkq5G+I0iBt/FWt9+
         fX8b9JGpiW7gE73aJdCE7sN98cosLhGNf6crEPTDaYv7+filW10mhrVu/R8+Sf9bFS2j
         jNVqgFYKMwELxNzhfBBmV87STt3wfvy+UPUHA1aZSqffi/1dYU5TvxIP3hYrSpX3Ho/u
         u3fjjti4Ddj361uhgKrXHjIph/ITdSVjTkfBO7CQK7LTeRfUs8LmmedgwippVnaV0+R7
         fRzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780590184; x=1781194984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4GlRxMa9J9gLARfP1LhX+QwG+3ogwBamX6CE29VQtE=;
        b=mcOo3a+4MSeieQ3I3Uhx7bWRty4H7Mkat0yOe9uDizThNsRqg0MOXb+ZxKVSFbFD85
         wdv79T0lMVejxSIUONvobuHLmOal2jDltMuFDAbWjW9TRES/qh6Kzd4mI7lyutPxCv8O
         psxmsKKgx1a9zAEOH19BXbRxqeHsvOosWVisjUXpqTkxIdnzshcYaoy76EgdSgq22Za8
         l28Q0+PxLy3OkFSb2IeoEk3S3NxzMHeKxtaF8VTbd7DEudf3uaMDJVVLet+FTNWjuVom
         TzFTGG4PZXojda7DELcqQ6zVHfKKIH4kMilGNB3tjMy2fW5PdlIQ++2eTvu8bT4jmFD7
         EhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590184; x=1781194984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4GlRxMa9J9gLARfP1LhX+QwG+3ogwBamX6CE29VQtE=;
        b=IFfdB4JXojNg9N3noC2GV9uc8S9+4Tu6cFEYX2dWQV6i0KiV6Ovrm0tim86RYuwZQg
         r78+oIqf7jtLKyyqZbRps3REmkccj/dks/pyboA5X9nlpKbiEgHP6SGoSmq5BJl5lGXW
         M7wryOOfWqRNo/SIx0W5Va5gZtwgf/7FmvK1oN+raJbgMKce3Qwa+U0AMjhMEMjLffKJ
         v+0C+xpWK5WL/IgDEtgKjQuy0W+D9zLu92GFqqXlwqYEjM/KXLk/ZP4vaRWrmDwUCiab
         nYfqrqXhSmmEq3c1UhTMe+BiniJ1EHgbzl7I/IWkIWsGHFqadojvrB04W6mXEWD7p4Jt
         TAmw==
X-Forwarded-Encrypted: i=1; AFNElJ+W/eCRCukvr0vRM473dJUnOCYC9pXfNPyTsuwy9OnW5Z9IzdEyfwV7kbf1CuTr6PHutYPBYmwmNQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw14T62mkB1BDSLpVb28c8WNPrpEHIz8xE34OAc8JkhNALEL0ug
	VtXpiXQ2jsqPAOgiMCm6n+7+K1p1p9oLb1p06/VGz8/92Iw9sShdrz05hZBiGcEPf4cbM5X+MQc
	1hu74Vi/0e0eazzHDOi1frZy1+HZGnxU=
X-Gm-Gg: Acq92OEMaHIpXLdKUz1YRRGlg3XMEzsNmzAp0mD/3kRJSOPEcDuae8RXJoFhtzVN4xJ
	zRFEKH/ymOlV7aR98W3BJAAW7xl+hyOey5ZW1CWxO0x0O2Fye0H6wmgkpnAy9hwIg04JwtMWEKx
	kKMxjXm/kQUtOhNKsNFymXO97LBSaYUkkY+wJFKu7smBMiSE4r+Gb9nVAvxJS7dby9KOFbMxqLn
	Gq9rh8aQTCmugXTXKunw37gCBcrjMlTiFTXvGLV5HujJUBbLEMMv8SqwIbgI20lpjNUTaW0HpHM
	nsmTvktUhP3MVkcCJw==
X-Received: by 2002:a05:690c:4c11:b0:7dd:b286:dfdc with SMTP id
 00721157ae682-7ea474082dcmr83931297b3.11.1780590183656; Thu, 04 Jun 2026
 09:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604131518.27323-2-m32285159@gmail.com> <CAMknhBGKHdUV10mLz3P_eH3mg9WU5kHw-pGqoRWfVGyvD2HwOA@mail.gmail.com>
In-Reply-To: <CAMknhBGKHdUV10mLz3P_eH3mg9WU5kHw-pGqoRWfVGyvD2HwOA@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 4 Jun 2026 11:21:07 -0500
X-Gm-Features: AVVi8Cc5DGJV2qGkiVnnrzl4T47hU_cqZeZQE22kuY-JOnybjjtLRuBskiXF_mk
Message-ID: <CAKqfh0FU5g96PjcXcz_hPafZR2uLq3xX2V-yyraHqPXX8RBRDw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: chemical: scd30: Use devm_mutex_init() over
 non-devm mutex_init()
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 11:20=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On Thu, Jun 4, 2026 at 3:17=E2=80=AFPM Maxwell Doose <m32285159@gmail.com=
> wrote:
> >
> > The current code uses mutex_init() instead of devm_mutex_init(), which
> > is incorrect as the rest of the file uses the devm automatic resource
> > management API. Fix this so that the mutex is set up in the same way as
> > the rest of the device data structure.
> >
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > ---
> >  v2:
> >  - Drop fixes tag per Jonathan's suggestion.
> >  - Replace dev_err_probe() with return -ENOMEM per Jonathan and Andy's
> >    suggestions.
> >
> >  drivers/iio/chemical/scd30_core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/s=
cd30_core.c
> > index db5cc295aeab..198add58affd 100644
> > --- a/drivers/iio/chemical/scd30_core.c
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -714,7 +714,10 @@ int scd30_probe(struct device *dev, int irq, const=
 char *name, void *priv,
> >         state->pressure_comp =3D SCD30_PRESSURE_COMP_DEFAULT;
> >         state->meas_interval =3D SCD30_MEAS_INTERVAL_DEFAULT;
> >         state->command =3D command;
> > -       mutex_init(&state->lock);
> > +       ret =3D devm_mutex_init(dev, &state->lock);
> > +       if (ret)
> > +               return -ENOMEM;
>
> Why are we ignoring ret?
>
> I would expect:
>
>               return ret;
>

Gah, I must've Jonathan's + Andy's comments get to my head (He said it
should likely only return -ENOMEM) :(
I don't know if he'll want to tweak while applying or if I should just
go back and resubmit.
