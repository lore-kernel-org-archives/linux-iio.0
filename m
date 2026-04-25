Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED64C97
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777145141; cv=pass; b=lfs6btlkXoO6dwDWie7OWmH/41eVpV4gkv2UmOclXaTbeR7dw1wHeucifD0Sr/SeymI++dun1Yxey+UtEcVvoLBhJbHnTI7hqBQ4wQaXdVd9fcv/r4prDoeIcLp1qqAuFWvSE2kh302s/0KwJ8cei06xiIKxGC89teOCHUCN6qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777145141; c=relaxed/simple;
	bh=RwbeFSMmGOLna3hWGX0T+aEMLiPduLbCZn+L5jovxr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWy8s3VjO+0dEK0CSzrMfTBImPzOH51OcJ6bZjZIweJ+mknOhSqB7ZM1nTtSjAh3OrNqN5lplQIpSxgxuN/gIRO9A+rMeUEa4cNNDx6bQPqSJ6IDKsu2aTqszOXsEWkpxYCf35ZcH/NoUn9YludOJf/f0mXC/kTCX3BFs3Z6MKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Gzx15jT8; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Gzx15jT8"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a4002b1183so1377435e87.3
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 12:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777145136; cv=none;
        d=google.com; s=arc-20240605;
        b=j89m3de/rqDYilxtPeaOpAIK/2KlNS3CofB4vCmKZAeInqucP8hzru6szRM47Azpvu
         X3+iEGnSbIDZcNJdZah/0CaL5gmkMTqi3H9CxliBnuZpTy3T11w0r56BiyjguHpIJ2mr
         MeBZLmHjURdTAtc2kciIIQHqoeca6fSANiraSFGRPUQFjd2Qeh1FmIWcBAxVBndwovRI
         HmlDw51z69EC6JNVrJVdEBc8lhbMtPgs/uYsXgqbF/K2YZe1/vXHycklph6PiUJXMM+V
         7YBI5AHE0xAkKNJP0c/5tJVdKdNx/YaMsznH53nDbGHbx5GOenyGSUgcYFxyAa+qT7vM
         vGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GafnImljcyhp91+LZSZ+T42awxIUt+AotHBCtLG8kLY=;
        fh=QhvBkiI8w1ZITUvSqC6Fx3q88tdGGy6pVHwXQPaDHwA=;
        b=Z9l/bWLjxsARfCV8x+fAT46zW4/laM+1jjwX6IiNOa6y7w0nGETQC/0iktVUL7sGDE
         RE8N5hb1rPt4FnPZS7SnB4tRo5mylJtl2aEiUYnB5lhI0nHVuS2Xb8R9FzhZIVXSQMZs
         QTI64ucUXf4AHCocQqjdME4goAeyhwTf5204b6Y13T45Q3zBIQZKcFEUQRXpLlaUi75R
         E6lXlUa4oXUlit2PZHh7j89VYn5Qg0dpNb0h2ixXJYp4tvk9XRF1LoRtMosLBJ79UfUD
         klIuPUK2yKBxy+1l9/6JY2HuNtGSeY1vv3JaxSZ0SymWY9Li414Nnqebw81FFKK1xgNI
         af6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777145136; x=1777749936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GafnImljcyhp91+LZSZ+T42awxIUt+AotHBCtLG8kLY=;
        b=Gzx15jT87xWCqN7N7t0B7BBPGMsrGage5pcrbRrHSO01hA/25ww2VqTFGGh43+C3HB
         eokw2y+f5F6kGZG0zLEg5/fo/g95i2d02KZBNZDZ95DC4fMLnSeZR++SLUt4QTAuzoUC
         5UWyT+7mxuKqSL+h7LP+N0Dt9qLQXIlfNWpDNaC3gSya4by/rkVJwHv/O/zbZEaAQdPJ
         IFsw+kwcnJREbnGGIVpfjmGzMcI4uXqW3yP6YYI0QABAnT20zstrl/dj1BCCn5+6yVQB
         jo4xGu2+gZI9oF6ph6urexyTPA/6w33PK/JGCjQMG5MVmoVAzgRH0f2cNcuR/MXkmsVF
         +Nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777145136; x=1777749936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GafnImljcyhp91+LZSZ+T42awxIUt+AotHBCtLG8kLY=;
        b=sK9zQO9sPiG9ZgWczeWpRkqMZIbqGvKepi4xHazStRnvhIj086ZRcr2dlJkMaX2EL0
         m6FoEobJRfeyDzKZKUuxS6dtNBGkwkeuRjzZCNzqfsPtZEPgAvSUDXnNVbtJYm9zi2I+
         0LkC6ucXbtlb4LfTPrCrNXEnyZZXbQC7dYFNowGbB+e3IyTDVGTwSbn4VVFtixDQ0JuV
         kaRfKcPrEKQa1vDbmL9jgqsO4OlvFoljKPX5igAVPtIBCH0QaiWJmeRdT8Is7c7DwmuV
         /puNaYJbZOnoMwufkMQF7dcYHqUK1V4PMg/jDHcDjLGbhhy8PV3RA94B6pSF2CrgmNGA
         x57w==
X-Forwarded-Encrypted: i=1; AFNElJ/ImhotHwlNLBxXN/X0aHMps9w4Ry8IG9pMzoLhfzhwoLX/nnGRsL9GS1gUe/DrtamIbE906F4OvNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+uh0Fb/2ADrktoZw3Zfd9Owxvy7MJbpgp0gKRVu+hJgLvhlSP
	LCfW395ELvIryZ803ADb+HOjF/ErXH7QTIHPbmwzNZmdMoaxvfzdfiaUSBcaH7uGpa36xegTo5P
	qjHF6ATXpOgsNffxsAHmsRBQfEq4F6tWbtyMfek1Kqg==
X-Gm-Gg: AeBDieseIs9fgDf0NjH3UwQFB5nsfYKXBqg/g82fkXxiPA/DXkUG0GbixvpmhUjS/Wx
	9J0EXXoOSOlvN4Pzl3G+QzvZcML8LP9wPrRgosJcI5bdCh3GBaOQjg6u6akQgNRKzlhWsm7KFei
	pmsJCeabO6xjPAegWgrdrqH55oiHsCCJBDAUaf5Ewt4xx1V4ybE0RCatKcjdQ8r/w8/rBWDreHo
	q0O0RQerPMifjU4sPiUKki+4SwOd7bpfXk7W+QqRXGbVA4Ep/YNxwsFch8uhoIETl1vXHAiCFMX
	dQ9IgsUyoQfWwMRJdFBsXxIPJ2ft+UNHXvri5mWRd9jDOcDC
X-Received: by 2002:a05:6512:8016:10b0:5a4:18cb:8850 with SMTP id
 2adb3069b0e04-5a418cb88e3mr3625887e87.6.1777145136103; Sat, 25 Apr 2026
 12:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419003557.45287-1-lucas.rabaquim@usp.br> <20260419123604.591dc3ec@jic23-huawei>
 <aeXZY2Nj71Em7Z6y@ashevche-desk.local>
In-Reply-To: <aeXZY2Nj71Em7Z6y@ashevche-desk.local>
From: LucasRabaquim <lucas.rabaquim@usp.br>
Date: Sat, 25 Apr 2026 16:24:58 -0300
X-Gm-Features: AQROBzCUBrQszcMslRHxviNRwO4tm2ugVuabMooT47BxZ_dceMOU1iE6DgfnGtI
Message-ID: <CAOWnv8HjVGVsg2d8kDt9LyUVp-HbnaWzAxZ_6egw+KtNmEpv7A@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: tsl2591: simplify tsl2591_persist
 functions via lookup table
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, Matheus Feitosa <matheus.feitosa@usp.br>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you, Jonathan, David, and Andy, for the feedback, and apologies
for our eagerness to send a new patch right after the first one.

Regarding the use of a u8 array indexed by
TSL2591_PRST_ALS_INT_CYCLE_*: we see it would work very well in
tsl2591_persist_cycle_to_lit(). However, we don't think the solution
applies to tsl2591_persist_lit_to_cycle(), since it would require
another array that, to use the index initialization, would allocate 61
memory positions with only 15 relevant values actually stored.

We thought of the following, albeit possibly fragile, solution to
follow Andy's suggestion:

static int tsl2591_persist_lit_to_cycle(const u8 als_persist)
{
    if(als_persist > 60 || als_persist < 1)
        return -EINVAL;
    if(als_persist % 5 =3D=3D 0) // Valid values between 5 and 60 inclusive
        return (als_persist/5) + 3;
    if(als_persist < 4) // Cases for 1, 2 and 3
        return als_persist;
    return -EINVAL;
}
Otherwise, to keep the array indexed by TSL2591_PRST_ALS_INT_CYCLE_*
approach we think it would still need a for-loop based solution for
tsl2591_persist_lit_to_cycle(). We would like to hear your thoughts
before committing to any direction for a possible new patch.

With Best Regards,
Lucas Rabaquim


Em seg., 20 de abr. de 2026 =C3=A0s 04:44, Andy Shevchenko
<andriy.shevchenko@intel.com> escreveu:
>
> On Sun, Apr 19, 2026 at 12:36:04PM +0100, Jonathan Cameron wrote:
> > On Sat, 18 Apr 2026 21:35:43 -0300
> > LucasRabaquim <lucas.rabaquim@usp.br> wrote:
>
> > First a general process thing.  Slow down!  You might well have
> > gotten more feedback on v1 if it had been on list without being
> > replaced for more than a day.  I'd advise generally not sending new
> > versions for at least a week so multiple reviewers have time to look
> > at the changes.
> >
> > In general the change looks good, but I'll leave it on list for
> > a while before considering picking it up.
>
> Indeed.
>
> ...
>
> > > +static const struct tsl2591_persist_entry tsl2591_persist_table[] =
=3D {
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_ANY,  1  },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_2,    2  },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_3,    3  },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_5,    5  },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_10,   10 },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_15,   15 },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_20,   20 },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_25,   25 },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_30,   30 },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_35,   35 },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_40,   40 },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_45,   45 },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_50,   50 },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_55,   55 },
> > > +   { TSL2591_PRST_ALS_INT_CYCLE_60,   60 },
> > > +};
>
> Instead, make this to be an index of the just an array of u8:s.
>
>         ...
>         [TSL2591_PRST_ALS_INT_CYCLE_30] =3D 30,
>         [TSL2591_PRST_ALS_INT_CYCLE_35] =3D 35,
>         ...
>
> ...
>
> > >  static int tsl2591_persist_cycle_to_lit(const u8 als_persist)
> > >  {
> > > -   switch (als_persist) {
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_ANY:
> > > -           return 1;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_2:
> > > -           return 2;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_3:
> > > -           return 3;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_5:
> > > -           return 5;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_10:
> > > -           return 10;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_15:
> > > -           return 15;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_20:
> > > -           return 20;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_25:
> > > -           return 25;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_30:
> > > -           return 30;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_35:
> > > -           return 35;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_40:
> > > -           return 40;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_45:
> > > -           return 45;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_50:
> > > -           return 50;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_55:
> > > -           return 55;
> > > -   case TSL2591_PRST_ALS_INT_CYCLE_60:
> > > -           return 60;
> > > -   default:
> > > -           return -EINVAL;
> > > +   int i;
> > > +
> > > +   for (i =3D 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
>
> Besides the style of
>
>         for (unsigned int i =3D 0; i < ARRAY_SIZE(tsl2591_persist_table);=
 i++) {
>
> > > +           if (als_persist =3D=3D tsl2591_persist_table[i].cycle)
> > > +                   return tsl2591_persist_table[i].lit;
> > >     }
>
> ...this loop now not needed at all.
>
>         if (als_persist < 1 || als_persist >=3D ARRAY_SIZE(tsl2591_persis=
t_table))
>                 return -EINVAL;
>
>         return tsl2591_persist_table[als_persist];
>
> > > +   return -EINVAL;
> > >  }
>
> ...
>
> > >  static int tsl2591_persist_lit_to_cycle(const u8 als_persist)
> > >  {
> > > -   switch (als_persist) {
> > > -   case 1:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_ANY;
> > > -   case 2:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_2;
> > > -   case 3:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_3;
> > > -   case 5:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_5;
> > > -   case 10:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_10;
> > > -   case 15:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_15;
> > > -   case 20:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_20;
> > > -   case 25:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_25;
> > > -   case 30:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_30;
> > > -   case 35:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_35;
> > > -   case 40:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_40;
> > > -   case 45:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_45;
> > > -   case 50:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_50;
> > > -   case 55:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_55;
> > > -   case 60:
> > > -           return TSL2591_PRST_ALS_INT_CYCLE_60;
> > > -   default:
> > > -           return -EINVAL;
> > > +   int i;
> > > +
> > > +   for (i =3D 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
> > > +           if (als_persist =3D=3D tsl2591_persist_table[i].lit)
> > > +                   return tsl2591_persist_table[i].cycle;
> > >     }
> > > +
> > > +   return -EINVAL;
> > >  }
>
> Ditto.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
