Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC635958
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596373; cv=pass; b=Y3iTt9kHCxwgniar5vXsTew0BVtztEvJEEyhLDoTeMooHq7j1aQyHPQHVGtW/krJOkp1XtUdD7bRPJwVzXUziaHB5g2eVtx/PfKVMkLUpeVlT9OHZIuqqfwdUpCqD+qaMPoFjOzDLTWXsCgcCYbmaUTcNrXsaOj3JNYC3VEAeVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596373; c=relaxed/simple;
	bh=ww0lp/s4DDO/bQDaSXr71dgA8Ot+19yi41OR5HwoSnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGWHwOvYYDngeALbKHWU+K9od751yp2Gv33hZiFz0tFifyW0S7kbCKyyRKSC2K5y1PwddYbJKJ+b/OKx/hgLcPjm5x99PTIb9aJb6dFCa2MrLv5gJwS8zl1Td9F+r2/1caJNNyHVUwLS/ItvfAuP2Vg9ziZLAfBwiLcaRJoE7MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewFZCZ1y; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewFZCZ1y"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44e5624c053so3156223f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 07:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778596371; cv=none;
        d=google.com; s=arc-20240605;
        b=E1GK2ace8SKJS7JjA9JUtwxG3jNT3KjRjTIG61NmXTWfQtPphGcRwbrzFV8d/laLXM
         luBgPy9SKHfDzh8o9Hjgtc9Y0OlJvHPCMVA3jf5zLI5CDaLYEoezcyGOKgXrab21/cz+
         aYCKfwQByTAjSpnavN4Ya35QPNHrfywaFpu7/iAIEApI/2nFsf7fQ8c8jxhD6q0NwwHc
         bSv9swkCsJbZEHOpUYpPZblbYLK9E09xSQmn0JWw8xTyNk6fnmA/1Lb/Q2NYvI4qNoBK
         yQK54rqMugSvDRPVb1JmW+R1yLDR1VAJKQ7lTful1WrGU5R/cPZimDZ3sos4zGtgrhJ+
         +anQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6MlM5wUGx485QzAn2NXoCRvb41cIVUvziG4iX0p2cOg=;
        fh=kVFxVnLAZKDA55//Qwy/wRQXGJ3cEteWRcfScv6o1ck=;
        b=k6TQcv5bpF820vClrBITKQAMDEae5KgVO2f8uxDxgMj3G9Lzul+osmAbenNDb/RDjL
         s/p3SPWVGKQgvdXvUj/xZzEkRuELjnUPUdKBQQ3qNZZfMANQROHKpv2WMaCODp8I+20p
         sUU0helAz2FF0J/S87pXUpUAkIIq6+/KiCbE0GUFGOlpE40MuPJ27ljSxBf2Fcee2wCG
         VVaYGly05HbcUM06gEzSyL01ySlBhHbMzjHMh8hb5PlrCNVbazXOXJ9ebgIlkCfcxBNn
         spVh0fyKZE/F3uajDLbplypfK+XhYfIc8MKbgHLzyGPAQy8KJYRcEA8KVo0XWYR3WREo
         CmxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778596371; x=1779201171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6MlM5wUGx485QzAn2NXoCRvb41cIVUvziG4iX0p2cOg=;
        b=ewFZCZ1y8JX9qorKMbOdWeCIxTrc3KQXjdQ4s58b4fO2OFcqMFJHE3BBMA0YlLho2R
         wNfb6QMNEaMQBEahwTJHdF3BoG8lMxy/u5Ca8/9boO+DbsO9eS4XEuunm8Hjw9ipXIza
         m3doz564+P/xgLFIPMcVcmaWb49npfgU7w9pQrm0PAH0wJroZeaeVCrqMe8K0inHc31l
         WTJO/pEW2X8APMlaUJkPeGMnrtyOs4zI/imUiatHBTyyw7gAHc8ZzQMIXw0+Gn/P63NB
         E6cntZxEFDfrnl8tMwdRAQhn3HcbkAv2uKShHaRDT6d5v2xeu61C2KdoiKRxJnx6gx5+
         k2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596371; x=1779201171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MlM5wUGx485QzAn2NXoCRvb41cIVUvziG4iX0p2cOg=;
        b=M3fYd3azMMswMF//+QpLTCYyWl+5BFh9/cVvz7I0zlsan/9z4Zx7SixDjPjeNMSbDC
         4y839YpZvkEiIiGn8BJdDPlDn35OJXpR2H/T9yqMMT8TvSAAx3vvPkJRsXUwgPv8QzAi
         mi494J38ny6iJbbaLFTwadCPIldU3Z+gwuhHxMqjwORJyJKQGkIdEquF8LJCZPFDfmjQ
         Xyo8/eVwXHqa11wIRFsfoyRZ5UIzjNuC7BlpYclPeUhQR8u7LOsd2EQW5aXxjM9J2B3V
         cP2m+74SGTPnn5Ek43+xwlUoWv+cLKkgh9GzK4p+3+6RswoXTPPO5/h7Bv3GmdgmCnDh
         hnsw==
X-Forwarded-Encrypted: i=1; AFNElJ+NdtMZ0LAwgwHS/hRcaE85LCOBajOmHc0o8HBawY3nUNOZZ2S/89JV2o6weg4SdqOd/Y96Oi+ivW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDKWNTIqfusF/eLIPM8bQ1XUrxDZ9r3K998+0qWPQMMZkn9dl5
	7j3b+ppeDJoOy56FyG9YpGXNKyRSgDgE3rxYjvG87/nMZSBQjBR5N3YZRgWeXuJuYfQMbERm16S
	r0UkwSpzQ8uZ/rk3LYfxo+sHsNZYi+pI=
X-Gm-Gg: Acq92OHB88FAoNjUpebIADmZ2GlP9ezRHkcdMaQB3AcAOMLr4llrhHKR7ZZ5MouVvQu
	I0ujgntBsT+Whq0+1PRwld23dFpqRkNYoxzlWaZP3wtjkeLAbncj3aDhHUEK8VfbzbQFhAaKa+A
	QVAnMDx3leP+BwlxiCSs+3CMuhaHV/gMYLWnct/6WYEJY1J3HDorpWG+748q5IAUTPociiPkj0u
	as3hrRkl++KiYXG8p4AFRzHWjrytCOfwNYzRKywiN8pjL3W9g8HtEo8C7RjskFVb2RYKNWFaM+o
	t6TsNeDKYpeHjBeUBS1xMqW+jprDPcnjr0hE0SpDIG8M606VRfmmHk0n2bn+WR9oV9jvdU1fhw7
	iV7TV23jqIy7qrg2E/8lb756RqI0pv0LkGtAJ0DFAA8VeCZoGbQi8dnWsjdJ1eiR4znfNAf962p
	N405skH6x1VbEFqLSl
X-Received: by 2002:a05:6000:2302:b0:43d:e31:68d1 with SMTP id
 ffacd0b85a97d-4515ce1c906mr48049632f8f.21.1778596370384; Tue, 12 May 2026
 07:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
 <20260512-opt3001-cleanup-v2-9-8018cf3a8a0a@gmail.com> <20260512152600.764ff7c7@jic23-huawei>
In-Reply-To: <20260512152600.764ff7c7@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 12 May 2026 16:32:40 +0200
X-Gm-Features: AVHnY4LWMxlwUxzEBhPGTZkPoOyJgyZki74OgGtbsNpZvQsAfqW1-xkXSB886U0
Message-ID: <CALoEA-xE59nXP6AAYp_60Wt_Y+7ZnRsw0y3Hssk6pecM8rhH7Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] iio: light: opt3001: switch driver to managed resources
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 16:26, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 12 May 2026 12:57:29 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Move the driver to use devm_* functions to automate resource
> > management and simplify error handling. This also allows removal
> > of the opt3001_remove() function.
> >
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Some trivial stuff inline.  I'll probably wait for sashiko to catch up with
> it's backlog and get to this one.  If nothing comes up there or in other reviews
> I'm fine tweaking the stuff below whilst applying the series.
>
> Jonathan
>
> > ---
> >  drivers/iio/light/opt3001.c | 75 +++++++++++++++++++++++----------------------
> >  1 file changed, 39 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> > index 39ea60c0af2c1ec7473d49b73778cac1f9bb6086..1319e5941b66bd82e4dc2badf5ea27cacbcfd54a 100644
> > --- a/drivers/iio/light/opt3001.c
> > +++ b/drivers/iio/light/opt3001.c
> > @@ -702,6 +702,31 @@ static int opt3001_read_id(struct opt3001 *opt)
> >       return 0;
> >  }
> >
> > +static void opt3001_power_off(void *data)
> > +{
> > +     struct opt3001 *opt = data;
> > +     struct i2c_client *client = opt->client;
> > +     struct device *dev = opt->dev;
> > +
> Really trivial but why the blank line here?  If nothing else comes up
> I might bother dropping it whilst picking up the series.

Oh, that must've been an accident.

> > +     int ret;
> > +     u16 reg;
> Obviously not a change you made - but none the less reg is a bad name.
> It is often used for register address rather than value.  So better as
> regval.  Again maybe I'll tweak this if nothing comes up but if you
> do another version for other reasons nice to change it.

Fair enough, reg is a bit of a bad name for a variable. As per Sashiko
catching up - it has 10 pages of entries to go, so here's hoping it goes
fast.

-- 
Kind regards

CJD
