Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACD5172CB
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787613; cv=pass; b=frstS0OmhJCm+bNsy/S140h4vGJPTsUaNu+xsBUcSly6Yxya59hSKSSozpwKN5ugGpsPC4HunGOW5qo2VYwdQZl4+FUXAKfAmGX3KjGH846TzhDlXOvCbSSBDYm7HuPXKumOGjsN331D+ogr6lUC+j+NSIn3YGsuD4TOyuFSwaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787613; c=relaxed/simple;
	bh=YwFLKTRtD485E9tMKuK2u3mAFkxgr0aAxTDkVA98D4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1dIRjj6i06tT8qbaP2xq2NSdu5GJ46IzSDDKhqnXi/8mO/7AVxplUw3V9RlotPui3YyNS0m/SDnT5IjsiRerGRcW2VImsA9Km3K4yYZsOPP6QXubny14C962Xz7LpVHmVIoxsD1O++K7dIM/hVJBfexALKkU2RiO+Cfp4B1mIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spahUrRI; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spahUrRI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so42129835e9.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790787609; cv=none;
        d=google.com; s=arc-20260327;
        b=Z45NUlTTJsx/9U/oobLdH06d9UPdefCQwteL5JOjdEfj+nZrWguORrYS332qG7afh4
         DzOf+XuT65SXBmlq1VUT0VL8Q/JJb59t/QX1oAgm7k/sVF3qKr1IeAYHIhZuEq5/xvhn
         SgCYPGUn6Qc/2FTwHK9etkQsakvpcqz++xKLwqIflGpSmbZSEVDcDDlTZXn30HfENLiF
         1wfpmN4doIZeYCRxlfwky9msIEnwcFyqXKyqjYwZ7hErXIPm7lz6wlWh+WF+WnaFsZfb
         Y951kQbmdFv+fEVdGqVi7xA/aZxmP7642vJmB4ZUbCWj8DG7lidF1kSlwJtKtbEwbyyL
         1eYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d/J1exTPTWXkJiVUl9p6jDIEpb+9AWn6n19nTgbowZw=;
        fh=tl7HczqnrreghG6Qa5QrXZWp/HVJAAPHNlcqoK4AyUc=;
        b=OE5DQRLbtp9a5rQp4mjQ9fnZK/smIFopgZKTOdnv3JwWoMTcP1tDp7C1PPC1y8QdJe
         Z6NciZPL3f3kJ+ya/GciUuJhaOf0GLxVDWBzl8l6f5uXYoSlxJa7QjYHmT04sCOMMOxO
         Ot98fo2S+B7N8Q5NlBAUX7MxjnyTnkILZ7p6UqEFl2zyXLVYQQ6MLUhy+b0UmWSgErw9
         mU/6rxaudkMRBfYR0y2bIZf599wOCkqv9PDeX20oxo+8NPsUpbSR6MQhu+hkodeWJZPi
         SwNETC2e7ErW9/uD7cckkZpTkrgoV5CmB/jFrO60Gc3gvt1zJfE7aBXfJ9nUmYIzwsme
         h3AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790787609; x=1791392409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d/J1exTPTWXkJiVUl9p6jDIEpb+9AWn6n19nTgbowZw=;
        b=spahUrRInjqDGGCVC2I/U7dc0ub9D2jo+Upg83f6FC+CFeNA2/k5Bk1+fJJD7FvFZx
         5ixDoCfl2yl8TVeXtKqWzfBhBkBNQNAuXT/ufFwt2Wd5jGOLOg22SWt/zgTycF1U3Mh4
         LysofWYUqZtBvTcvuzJdRdkPBj9JL/3xDEyH25hdZAG3XIope6rM/HDiqer5rXTjZVtn
         k4ZLvaF1jho5NXPSP9sKahqsdqS4eASzW3wgTvENPQHXfs+urwFvWycIPM3WLru1vUcZ
         eqjoVMg8TkAwaaHYxyepEK7itbKkk52yZjBOlJiLRiDJk/a4tWnXm6vZTialQtegKAUN
         6xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790787609; x=1791392409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d/J1exTPTWXkJiVUl9p6jDIEpb+9AWn6n19nTgbowZw=;
        b=mCYoUo0yQkBRCx4Xax0W0CLJFSLT5/lXtS+xPYj4SVqcRJ3GjWzfngfL6ocNHBVL+d
         gfwQBae40xqVpaFo3JSmL8QcX02joV5nK8ILobWZz6XI2xLtVWC6m9Mfs4nWHUKt5koI
         nMX1JeGzopGcPRVytnplrwFjEVSXX5XpJoknMiHiC6TAAjkg6ODM4Odptw1QGCMCFDTb
         wt/B/1J5plUr0Z6Na0ckhZJAKWClFSG8MH5q8CI/iqKZOdxTfJTRIdIlkCGJ+kDM+P7D
         25hzpasBx2ZmFjALVwf/NlDghQ0ecmlG5qq5gFyFscUw59YP2Rvk62V61/M2Yfkdw0zV
         Wu/A==
X-Forwarded-Encrypted: i=1; AKwUvBwX2Gz+09Wd1H4egk54uC5xNfOMCf3JzXMqS1RYeOaBdf42GRLHnB2rpl+UM2xF6ODJMd/orOWByOU=@vger.kernel.org
X-Gm-Message-State: AFuF++mH1YANHqvixg0br3OohJJ7zdL5sEwjhqnJ7cD+a6jnVjHll1CJ
	Hde8EelYNMlxLz0IJtsoteBSczHdbcAG4ZmXSlOWv8qUk2Syq4qBWlOfd1FLUuQp7V4+67wP6KM
	jjHSa0EeCM+eUOE01OFPW70dnCdb0p70=
X-Gm-Gg: AYBFou34haSQtS4V3q5a2fmBCBBCR7MKKNo2K9BIxxXC5BxllwaootnwPhK0QnGLwjP
	q0Pr09WTjtl7AdmqBt0uG/VUUHbv7XocN3607fVcIkv2J0nn9DQeKzDXqbmpwL985a+wQDcRBKC
	PYqSRoM0Xq0684qrzaQ4Cu3vXlfxT/dxcCAg7Rfc/LZlX9CDqshM3KWvMJeIxk99cujeFALqhEB
	jAtUqoF5D/xtqp1kBcWgJNGYbdzg1fmMT1wHo70YSEIHW8foIAstk0c+vB4NzjE2612AidUlfSh
	D4teuN3+322HGBBNPPmEHu5scB0JVwr120jA5FHWMLlikFbipNC0UrYL1nWOOw+bdRbkPhtqEmU
	eSRTnsIGQIzq2xg4SdWfbZBqitWFD7EsPMCDmo9g3AHG7BKbIfNiGzTB4DqwFE2mX1CQU/g==
X-Received: by 2002:a05:600c:3152:b0:49c:fc6c:be19 with SMTP id
 5b1f17b1804b1-4a01b12603amr36070955e9.31.1790787609394; Wed, 30 Sep 2026
 10:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260929124248.237032-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <arzVw02dIqn4M-VK@ashevche-desk.local>
In-Reply-To: <arzVw02dIqn4M-VK@ashevche-desk.local>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 30 Sep 2026 17:59:43 +0100
X-Gm-Features: AclHuK8eJrFqm5LeaZJBMYeX86u8m2nZ2ZLVvt1JxRR4ALOvCiQsOu3O-zn_iL8
Message-ID: <CA+V-a8uUtqBCDJC=Gy60Jx=a3au+9ZN1Dbbi6uGbzvHA3GJsXg@mail.gmail.com>
Subject: Re: [PATCH 3/8] iio: adc: rzt2h: Add chip-specific configuration
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you for the review.

On Wed, Sep 30, 2026 at 10:26=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Sep 29, 2026 at 01:42:43PM +0100, Prabhakar wrote:
>
> > Prepare the driver for supporting SoCs with ADC IP that is similar to t=
he
> > RZ/T2H ADC but may have different channel configurations.
> >
> > Introduce chip-specific configuration for the channel template and numb=
er
> > of channels, and use it when setting up the IIO channels and DMA layout=
.
>
> ...
>
> > +struct rzt2h_adc_chip_info {
> > +     const struct iio_chan_spec *chan_template;
>
> __counted_by_ptr() ?
>
I don't think __counted_by_ptr() applies here. chan_template points to
a single struct iio_chan_spec, not to an array of num_channels
entries.

> > +     unsigned int num_channels;
> > +     u8 features;
> > +};
>
> ...
>
> > +     chip_info =3D device_get_match_data(dev);
> > +     if (!chip_info)
> > +             return -ENODEV;
>
> -ENODATA
>
Ok.

Cheers,
Prabhakar
