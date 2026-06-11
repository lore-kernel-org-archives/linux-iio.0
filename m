Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08FE3F0774
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181238; cv=pass; b=NyOmhMPqsUSsmLzGrc1wxacYBy8TaT5kHYF5g5qYQoh+qWXpFKiWdF+SCHy82v8lr/91ztD+OHESlOrcxOlwukkbGb7FF80vUuQI1eFDwEAGlQJccayAhnx9RKKtFKNimmbJhRqN39IrNyR/kvphmGQ7YvF7fjadQWuw9vZXKiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181238; c=relaxed/simple;
	bh=L22iIiqclocvOudTWkPISdls3zO04nkf5zEFM94Gfhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPdXLit3Z8RcXNBY+wKxmHeV4L2Bob6MR7z0DpN98JmIaDy9379J6uS2L2NDMBlRId/Ng6avEjsQ3sDBQsIN1WbGjv8k6NszUYWUQOGB0jtZmPddv2Jy4hDcHsFrCEcHgPVdCo0crpq/e13uzUxLtvMNhQ9CI9TMsrwDVmQY5HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDu0fAqG; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDu0fAqG"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13809ed8fbeso3052176c88.0
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 05:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781181237; cv=none;
        d=google.com; s=arc-20240605;
        b=aO2Qbp4f/gHIGaVzPlnnCRis5WpficFXcQtKyL5aY8NWjan6/OwuLbrvxVXX2pqfXx
         9pTNhW/eZTfSLqIhs4Uju2ZTEX/SHA7cpRwYWmda831lSj5NuhZbYR/yVscow96oNely
         UPycLxsB+5UtxpKNCdYf/NAn9NYsXQ62xYFXkvNFDgXSQhtlGyRaIbjcvMNexzGcJxPW
         GfQPaxjMpCWXhzB2qwcgpjDza8/FO+8mjaapAGGDnHOlATqvaOMMSG30tL4C3EdrSlsU
         0bswrKkblGz1V5qP53zVnZwRWySWTsyuz9D349phNo62cYk28KdiFfEGHOrROeIqD8lR
         hmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ofA25PebqL4AsSYn/VWzRODqpKmh1tVfH1mE+QYxUbM=;
        fh=RcI7lt+C5o8szbMmgWtCxUilOIX5SbWwt3FS9VNJ6XA=;
        b=W9d+V9PHYsyj1Xti8iOmy1oL2Zk45xMlRMsNN+zasH2MgLxAecCTvm0vyofmhNHSDG
         q1gLIgJ2Ph9sR4h9piGZ/I7IQP4weFe1QwGAnuhVzRgrWQbkJmLsr9NghIGe3f3LYM86
         /ua5BgOpuQ1I0j0RcFflTCzSzldzHi/txrHB2k0x8KAIv7Z3e+4gqzaa2xQCxL2RB2c3
         8NUkmmqNOblG2s2ZYkehBN2wbNx8dGTSAzsJ5pbpw7qZdiDtk9eXJ7ekf79we1HNgLaH
         V4LRQhmEofqomJvVBqk8NQVh5/bwVlMjFxHBNjZVR4aZVTtcFe85h/oNfZxijHYGRRnz
         ayMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781181237; x=1781786037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofA25PebqL4AsSYn/VWzRODqpKmh1tVfH1mE+QYxUbM=;
        b=oDu0fAqGLc15HSViIqhHK3eGlstvY2ZUf7YvgQkx7b/q6iRWhSuUKkQCbTtle2QEZi
         PXF8UWXM1NossznlpNcC818lenPYJ/hop38uSGIfgqwgaz2nVZV4S/9MSY0bJjZDIfAx
         tqh9VLntTjcB/P3hgofxBOU1pTZxzmKlmPO8FTy6hu5Ag5QjfvN4gvMgwMR4Y+hxQgR3
         I15fpSg1BXU23WScjg3GstcfCVDmQDhTuR58SAuKtbgpwXx8hq2sA8IUaMHZcxL/d7Ul
         xUqYDvf6oRzMk6+F6MXcV10HGBz/0XmAYOLULZoC9i9Klcu6iQqBv+38kw5sx1bDT0FT
         0LLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781181237; x=1781786037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ofA25PebqL4AsSYn/VWzRODqpKmh1tVfH1mE+QYxUbM=;
        b=IqNykOx2GHsCRudaxlPDx03rdl94IrGoA04+TelvIzCKqnvrHRevZM3ZKVJ7PbpMBL
         siX82CW5cmlYhQmbF0Yltf2FwXndqKwpN4SrJhgsbTUkyDThI8lIsgEGeDPceYIarllM
         0qEyp3NX5c1wim0z8PogmSHL6M+vS/gfIYxLfXGGIM4LUek1S75fQY5lVvS+HT+maTSx
         /sYraJH0GCnMUvnjAQdo4l3FEOALQE+fvBG0bFxd+2J0OriUd1YuojcC6cSpQShtGdl0
         yougiCLwah9EUb0JaMvMl77dCRB2pUkPKh+OD29tR0mlX37MMpfORe7RXzqoYPeX0Aeu
         iHhw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ssvkj0WJw0rsorCs3dwL8aG/PicGH1yjnprjKVkyHNyWulEvdjnjtHYq9R+HD9vP4YkEnBCOvGf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVS3MIq2t3lJWxbKRrMoGzpgj9QLrRkzv0F56DUMU3B9u2gqf
	/OZv5kUJAqOaObdWTkGQhAxWFp4nJydPks6jLGuZotvoEjWpfZ6dtp9AbaNIP36EZ9c/G0FRRYZ
	Nzm91KIgvMqS4GWgUifxtH9YaO2C2M5w=
X-Gm-Gg: Acq92OHIyazHO03rZ/ZusA45oRLATiSffDbcH1EuwufRvczedevBOtw2rYpzDdoOXUi
	k2RpUXzbEWkNn5MgKJImX6spEap+zxiBOs+O0FB42KcOu+UlNJtzqLpwwz3ZeRfIA9a649AzrX/
	rzN371p4qZAOebMmZaI5xW6nzxnjbLpCEA+R6vgy17cNitN5ugsmbg9gGDik5Ooe9uQuJ9gRqXI
	p786pKupXnMnY50wlf0qbQVdph8FDxGUr0W36C8NpXw1hRUNsIhzaJHvaegQ/thfCJdZpV/1J3a
	TL4jEYosYKgMR4JQFf8=
X-Received: by 2002:a05:7300:6da6:b0:2d1:d434:cfe3 with SMTP id
 5a478bee46e88-3080411cef8mr2308986eec.0.1781181236808; Thu, 11 Jun 2026
 05:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-15-clamor95@gmail.com>
 <aihoH9Pmzufa9pnE@ashevche-desk.local> <CAPVz0n0m+i7wexfC0BWwvdOuJxDk_=x+EpxEbNmoHN1AsEmfNg@mail.gmail.com>
 <aimy3BxBaXQ3Uigd@ashevche-desk.local>
In-Reply-To: <aimy3BxBaXQ3Uigd@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 11 Jun 2026 15:33:42 +0300
X-Gm-Features: AVVi8CeX4OO_pI5sFq7qWhCQuBWbqnNi5DWXxYDyaE3k8yybACe4K7ODLE9J31I
Message-ID: <CAPVz0n0bpo6PAfdN+LGEgPYhEx8mqtu_SL=WnDxhWn-Cq4rQKA@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] video: leds: backlight: lm3533: Support getting
 LED sources from DT
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 10 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 21:5=
4 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 10, 2026 at 05:45:28PM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 2=
2:23 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > On Sat, Jun 06, 2026 at 07:57:38AM +0300, Svyatoslav Ryhel wrote:
> > > > Add Control Bank to HVLED/LVLED muxing support based on the led-sou=
rces
> > > > defined in the device tree.
>
> ...
>
> > > > +     int ret, i;
> > >
> > > No need to add 'i'.
> >
> > This is personal preference as well. There is no strict rule that
> > iteration variable must be defined strictly in the for loop.
>
> This is a preference by Linus who is the leader of the project.
> Also in IIO we have some set of maintainer preferences.
>

Well, this is not meant for IIO, though it seems that Lee is also in
favor if this approach.

> > > > +             for (i =3D 0; i < led->num_leds; i++) {
> > >
> > >                 for (unsigned int i =3D 0; i < led->num_leds; i++) {
> > >
> > > > +                     if (led->leds[i] >=3D LM3533_LVCTRLBANK_MAX)
> > > > +                             continue;
> > > > +
> > > > +                     output_cfg_shift =3D led->leds[i] * 2;
> > > > +                     output_cfg_val |=3D led->id << output_cfg_shi=
ft;
> > > > +                     output_cfg_mask |=3D OUTPUT_LVLED_MASK << out=
put_cfg_shift;
> > > > +             }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
