Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05AE3242CA
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781337698; cv=none; b=RPFqBEoBD4esTRrDUjpqPNzb7sVQJJo76tukb6ID8JLJ7eUT3c+D5x3Sg74EoiFbMcXclNHyRQZ6Q2VBvVRj69VJ6mNi108ZqWDWELXKYxpJr+Yimm4S9jOz9joArpwrInx2Y7PkcO3PtlLUS6R0TG7aOvJyU7wiiI6vfQoar0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781337698; c=relaxed/simple;
	bh=hmE098zqkyUMeuxcAnU1aXWHJ5Q2VUM63pQU4VHVRMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5HTs+geb4aA97mA6HnInb+q38Of2nP51NiMWOxbMslJxC24Tj7eUHmMMuo/t81L/aJlwwoU22oGPWZehMMvczepdHddftACp3zDmE8eLOMWURvTW5K1kUCmQYQotbvD5rJlXWrR/mwVeWZEQNdjlUIhTM+As8qAnB7YpRUbIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-660390acd71so2367957d50.1
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 01:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781337697; x=1781942497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ihqJzJXJ9l3Qxo/0/OgruWARn9hNmcn+VQ3o7o0360=;
        b=SoZiw+L0aIXsweFqsLZapHn8pcgR/PL+m4P6lShbEUXxTJ2nbaRxNAFAjCoAkgsky+
         gzIHNA7t/z9dDBTVP+g0xS8aLwX3u/cXcs4+Mok5/d9j32aN6xY3p5TzgVuOEn8F647k
         Jx40BbP8GNAusz408lO2xDGTKWQKFGEo1VPDfK4fJKSBPsHRzufU7HVEUopQn8wIM8XE
         Ztj8YU+sPIQ4ovVsEOwGvSCpGl6tQIkqn/zAoNhoXtCdJtDUAH4lkit1vQ12oUshkZaW
         wR4AW5yvzTiWmUkWsIcivkR0MXtcXxr60m6IkGj9+rMGZjHFe1QfnHZoOx9GpqTfKIlN
         sMxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wSCpzz0Ga9yR6AJb4o3Ew/SEYE8ggXagLYgxaMXO33sUKtClgxAgKggmOxioVsN8FqRh+EKPILJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtUlzk1xWVojlbz96vKpGS7Vn0RZYVdSi8u5tQw7Rx+9cEGCRx
	ZxVLdaRmWTmlsIuyfOzpFmkkPQpaxZUkWgumYGIM2BtFEO6M/JvbRFUbPS70Luo9
X-Gm-Gg: Acq92OE6I0/Hpq+llgNhgMkQluERiJEeaMD5V0vg8Uzz7aYHPMPJhAHWuNQSRMSCkF4
	2ivRY7bh6NvATD0dMo66EOqM/8It3IqrL4vLYnCE0DOvSp5R5BiNPsu7N6ltRmUN5GOsNUkl64Q
	a9yYLl/O4Zn1mjH8EkxfwSnaO9l7dlCMTGXMTXMZOPWJS3XSov358FYxOQbOHp/mDDvA9Qxuy9+
	4XE0RgQWJ3+e9svKEI/EYge9/Mhuf1XDdURzhJeXvJs/Fhf71JHi2Ux04ioMF6ZQfKX6fRK+/re
	I1Fjt1amddXSikB6c4lqqbcj/VLaYUTsnx0wNrTVleQGT5FZ+MjJAAm0HgozonL5lqkfL4KNphd
	O5oZktlsCp5a5GWZmEbgOlAyvDPKX027YeOwvegfou0tqW8scp03FYJEW61CEuSS0JVcP5SlEfJ
	m7CAawSi74HvjqFnKQ3emBRezpNf4C/fBXzu2mRxU78oc6SpYE4rdNM/YlfFx+SAC8XATy0zuSe
	JAI6jpxQjEoVT7nlBFrwNN112C0fTSVwFnNphDj1lurYvDuS+ugsmOCMTP73DK1DafnaobkYvBd
	iijiC70b/eRkS7d2ntqDiD6VMRKXMd00lIa+7QiHNUCxlUmRWyRM81wGGg==
X-Received: by 2002:a05:690e:4246:b0:660:689b:1509 with SMTP id 956f58d0204a3-66276a747d6mr3308666d50.29.1781337696596;
        Sat, 13 Jun 2026 01:01:36 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66274c8975esm2240507d50.9.2026.06.13.01.01.35
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 01:01:35 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e0aa486af8so20273487b3.1
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 01:01:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Pq6HGVa4K6AQ79hokF1/aHq5X+mlfFfsvnuP0W+THDLFg6cDPdtX87jC/gLc4S2Td/s2EoVmgghk=@vger.kernel.org
X-Received: by 2002:a05:690c:45c2:b0:7db:da70:9f90 with SMTP id
 00721157ae682-7f7ce2fe2b2mr45671797b3.20.1781337695438; Sat, 13 Jun 2026
 01:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612124557.13750-1-email@sirat.me> <20260612124557.13750-4-email@sirat.me>
 <20260612154922.00003723@gmail.com>
In-Reply-To: <20260612154922.00003723@gmail.com>
From: Sirat <email@sirat.me>
Date: Sat, 13 Jun 2026 14:01:23 +0600
X-Gmail-Original-Message-ID: <CANn+LWKcujSMsFVP+zqJMkR_ezed1ULGkDLMa7ykdXG5yeny_g@mail.gmail.com>
X-Gm-Features: AVVi8CcHppHXWZsm-PVxaAYXoYZCxH0AIaI2SrRwJ9pW1lpPyBQhEz0SD3zp3SE
Message-ID: <CANn+LWKcujSMsFVP+zqJMkR_ezed1ULGkDLMa7ykdXG5yeny_g@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: magnetometer: add driver for QST QMC5883L Sensor
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 7:49=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmail=
.com> wrote:
>
> On Fri, 12 Jun 2026 18:45:27 +0600
> Siratul Islam <email@sirat.me> wrote:
>
> > Add driver for the QST QMC5883L 3-Axis Magnetic Sensor
> > connected via i2c.
> >
> > Signed-off-by: Siratul Islam <email@sirat.me>
> > ---
>
> Hi Siratul,
>
> various comments inline. I've probably missed a few things
> as I only took a quick look so feel free to call me out on that!
>
> Josh
>
Thanks for the review Josh!
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/qmc5883l.c
> > @@ -0,0 +1,512 @@
...
> > +
> > +/* POR completion time max per datasheet */
> > +#define QMC5883L_PORT_US     350
>
> If it's POR completion, why does the macro contain PORT instead?
> > +
PORT is the terminology used in the datasheet for this. (Power =E2=80=93On
=E2=80=93Reset time period (PORT)). So I went with it.
> > +
> > +static const int qmc5883l_rng_avail[] =3D {
> > +     0, QMC5883L_SCALE_2G,   /* 2G */
>
> These comments are redundant IMO, you're already mentioning
> the value in the macro name.
>
I actually made them macros when I noticed that I needed to use them
in multiple places. The comments are now redundant you are right.
Thanks for noticing.
> > +     0, QMC5883L_SCALE_8G,   /* 8G */
> > +static int qmc5883l_read_raw(struct iio_dev *indio_dev,
> > +                          const struct iio_chan_spec *chan, int *val,
>
> I'd put val on the same line as val2 and mask, more logical separation.
>
These are done by clang-format. But yes this change makes more sense. Thank=
s!
> > +
---
>
> > +     int ret;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     regmap =3D devm_regmap_init_i2c(client, &qmc5883l_regmap_config);
> > +     if (IS_ERR(regmap)) {
>
> No point in adding brackets if this is a single line if statement
> (checkpatch.pl should warn about this IMO).
>
It didn't warn me for this one for some reason. I'll fix it.
> > +             return dev_err_probe(dev, PTR_ERR(regmap),
> > +                                  "regmap initialization failed\n");
> --
> Kind regards
>
> CJD
>
