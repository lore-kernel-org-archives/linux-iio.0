Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76F47DF8F
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507760; cv=pass; b=YD7zBGYMzLVYY9P/NjOlBp7r6O8JVmLCdkJHF/2rEfgaNnTU0FRQDVZu6ixpus7nv2fR+lwkdAxXtMQl7ZfFSClBHQhIWpU8Kk5USYZ5HzF7F6yx0ZeU5fcvEk63NfaOpDh1MBb3qCM7TWMXjjRmhcELBlTfABFQo3DXFyJI8c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507760; c=relaxed/simple;
	bh=VhKJ1KbUeNyfvfJOTbQSrZ0W+8GsmJ3GdF4nX7bigIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ug5vVKikdiEti3EhzNff/b+zNzBNCWnehKAMLF4oFIi3oKhDKq/4g21+0JQxx27r/q2SNaWk+K5BpIZyfaaryoWYdVnnSK5Nx/sWfp2lVYOD5cv/6kaW/YZnhOMcGcBPDcn7x16f9xS0N4Jf41DLPIr/Ur64aIjuLqkY4GLCS60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oEPRQhtM; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEPRQhtM"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7e3b2a435ecso39730757b3.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 10:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780507754; cv=none;
        d=google.com; s=arc-20240605;
        b=IFmwQzBDIHIXJt5r+5nVAnxQLiGE0uBOqPPJOK9TMR+a4uAYUixfyYuQCPkNBeJB+E
         pJO9y+67RYe9a6smkyd2LdjCohOIdXeV8/6L4XjRgjT3rJViAHj/fYiJ19Tl1wklkan1
         Aja7cNaKi6O4s8rxCx9D4hHBGHcaH6+2HDyL7rqBK1RyjITUlUBMMB7SM6bRoo4Nn8g5
         Gm4/Gp3ssToAoJppjH/Lf3BrFHtHBo6R2FNx2p4BgJ1yWZq1jo5rL69TRJuHfwAUOEXw
         8SWl+Q8z/deKQx4eSBUy+VbGWxgiIdPw5JpP5ynIrsXxfziu1A996wblMSbuiaehWE64
         D5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DpIsA3VOKnatsnifn6CyS5jKOPFL99jjiouFP9ItdpA=;
        fh=BznOjutc77aTGqqdl+7giS+rtuEz3pZ1EtXfNy5RXWU=;
        b=ezHautZJC7gCXdBliGyKf28yGGRDpw8QJklZy7Zt0yqYaPpiqe5E7KNBsuZoxjuKqo
         PZkHc2T8UONeTLGvpXlPToT9dgYqPk9Oe+FIaydac5LUaAT94+6Vg+peOkuIPIYYqeb3
         wnmD76YVlArYG7m4f3SHiYQgNQWphuyhEHcpMK7DnetOkjJ9ZrAG4RsZUDYpoS/FTtTw
         3IzpAktC9Ua6EGNai7le5VzZrlNQQoxontMqTZJ6F7MX7HRQe86BiiANInGQyw3C6iHm
         wgw14LLQMOLCwiqiztxBgFC0NiNbXHotdpxJIXSUO/D7TEAh3F5Ds9g3zNezwIGN6aZQ
         59Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780507754; x=1781112554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpIsA3VOKnatsnifn6CyS5jKOPFL99jjiouFP9ItdpA=;
        b=oEPRQhtMNqXBe07AZgLG443/6nwcBMNjmIysiEe16eSGBF/UwLqJVCQvi1XeUO8PhB
         RtDo7H930oqrTCrcqptzHot1nucDXyylibGlJqFAVReuUedqsW7ZkYfNANQ2OH2NHqtL
         mghXYmRIIrQoSx2C4jHbbF5NmUwGY6mzlHRBhTItdI95l1tiNOcnj9/OLgBwUe6kQBxX
         CmkMX9fKVeg0tfIjgmL6sNGVDNDWX4gd4G3gziBbPfJql8CUODGhnCRJtjD1UcZx8nTz
         wdy/z5nP2tGag9RZlSuN4N10PM+T71Mh9G+ombOHOn4N8eBbgxNXgvOuBIGZ3lUr8Gqm
         dBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780507754; x=1781112554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DpIsA3VOKnatsnifn6CyS5jKOPFL99jjiouFP9ItdpA=;
        b=Fqbye0hTaqiOJRPy23TyiCHeMgUsd0G4/6w0ShtnD4wXd5dddiHjwuCVtFfQcndtPj
         DQ0LIwu0+aBhKnt0238jj9TM0D6gPjZbHTZTuGI7ppsTA5HjtLfTF8A4sNnDYsyaaYwm
         aTNXFsmN9wh4PemmvkdBJrJO2Nb9W8tfrmOslttJAEu2LcVkSS4CIsjR2DDUm9zlqQWH
         uGmVfUKGdLzZf6BPIuA7EkZ/n3X6hpdjqEJh316ulyHcWVxTw8L6JTgPxrEx3GE4EmC+
         FHzsM4XFAUqcn0ATsLqnStRtJqH0YUlyigCIKFIqPTRMRiX+5GONsezgyWyj7Qfd/m8U
         THHw==
X-Forwarded-Encrypted: i=1; AFNElJ+jJ3hChxxRa3ssByy32kKH6xPyDQptaE+m0/S4K50p4faHqEhWlqiA4DVdRo8lABOo79yFu5+BkpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTzFoqsIG1BfABPVYT9n5TnOPgwr63s+LZ654QMw7vUGf6Gkga
	KyY9knWeKoRYOwSqeDM+3lkewehBylTfbK6gkvjtQRM9XrzYwzEw46z/aLcsEShZhK+WnZn3Fui
	dW17D+M85jtw8QyqfIBnOCCJwCHaw4bFRbWIJ3QE=
X-Gm-Gg: Acq92OExa+Y1odlveVHSh29q7qeM9PKLvuxT1ONTApq4IWiU/RDd6GmMYH9iUj3gyit
	eJhdoxKX7xHUz/RqekECSceD9yNhD9vwsDubMzyEq/dWVCCX6QG6SAO6r6sLbGCFtBpJrtrhAZd
	qnvMK3uurPhFqckrZPV8aFTivyJCq8c4G7B+9r6CN42qDBMwJzI254PZ3w3+1s7vc0Rq8EBYG2/
	aNuO0zsT/dS3Pnv1WkRrBTlSeXjXqYswHnPlP0uGe5/p1jVVsLVYZJSyfsTidjzL27GFGJb4TDc
	nHcivbxi7FDwOPbOI8Q5ScoGsfdHJUlgFzcJs3cJ9NtklQD3uy8+
X-Received: by 2002:a05:690c:310:b0:7dd:b286:dfdb with SMTP id
 00721157ae682-7ea4c4a3cadmr41141637b3.41.1780507753801; Wed, 03 Jun 2026
 10:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603145134.58956-1-m32285159@gmail.com> <20260603174447.63a181d5@jic23-huawei>
In-Reply-To: <20260603174447.63a181d5@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 3 Jun 2026 12:27:18 -0500
X-Gm-Features: AVHnY4Kc5x-51yo4-l5H_3oC3klGwT7VpA8TqXSGfJAQxkfMaF29bmqacrsvhh0
Message-ID: <CAKqfh0G4xDUh7ZR=f760yOAqYqjSLhWGw4UP8KiRM=nnZhg6BQ@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: scd30: Use devm_mutex_init() over non-devm mutex_init()
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 11:44=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed,  3 Jun 2026 09:51:33 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > The current code uses mutex_init() instead of devm_mutex_init(), which
> > is incorrect as the rest of the file uses the devm automatic resource
> > management API. Fix this so that the mutex is set up in the same way as
> > the rest of the device data structure.
> >
> > Fixes: 64b3d8b1b0f5c ("iio: chemical: scd30: add core driver")
> Hi Maxwell,
>
> No to this being a fix.  This enhances one corner case of debug, slightly=
.
> So to me it isn't worth a fixes tag.
>

Can drop. I guess I was just erring on the side of "we're fixing the
original maintainer's/contributor's mistake when they did devm" but I
guess that's a fallacy since the only way any issues could arise is if
the device gets deregistered and reregistered.

> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > ---
> >  drivers/iio/chemical/scd30_core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/s=
cd30_core.c
> > index db5cc295aeab..f00979c0c196 100644
> > --- a/drivers/iio/chemical/scd30_core.c
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -714,7 +714,10 @@ int scd30_probe(struct device *dev, int irq, const=
 char *name, void *priv,
> >       state->pressure_comp =3D SCD30_PRESSURE_COMP_DEFAULT;
> >       state->meas_interval =3D SCD30_MEAS_INTERVAL_DEFAULT;
> >       state->command =3D command;
> > -     mutex_init(&state->lock);
> > +     ret =3D devm_mutex_init(dev, &state->lock);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to init mutex\n");
> The only thing it can return is -ENOMEM I think. Which doesn't print anyt=
hing
> so
>         if (ret)
>                 return ret;
>
> is enough.
>

If I'm not wrong (and after a quick google search), I think it also
may return -EINVAL but then that means the device struct is invalid.
Still may be worth doing dev_err_probe(dev, ret, "Failed to init mutex
with error %d", ret); or something along those lines. If you want I
can get this out today or I can also wait for more reviewer feedback,
but your recommended changes seem pretty simple. TBH though I'd still
argue for the case of either dev_err_probe() or dev_warn() since not
having an initialized mutex is certainly an error.

--=20
best regards,
max
