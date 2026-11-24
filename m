Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795501204;
	b=XjEzWKt5VcE64DgY8QAY2b/KhsrjZKDkQ2F3dDsFnwH1jRrej5JnNJPiN8yFtofWgvx7
	 G5pFKVU2gUgy7tpZZ7DvkY7ndAuZ7nEoFOUteI+WJkbcRcf+reQeglSAU/H1A/ODlyCEB
	 ysr6AvAtVKaLxi3N9+kmOqcQBtCGwM4dpZhqwVUPN1NbLKCbl9nfVyZhxiD3bUENqWOVr
	 Pdh2GhUPGvg/3ndZvqjRWbY1YWq0EAQzoAjOlAeYbjiopUwx3yFEsmeT3+8LYneSVPX9d
	 98GmyTs07ELz0Pz1fuW1SYHPwg8iGsr74RFBhH12RY6oHXuzEXG9l9/D7nU40Kssr3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pI4cY4bgznXKJ4A1hmZr6uhBddx8lY/IEe8WYtmh65I=;
	b=uJCPc0WtrcX44ECw0Rn5JNoQLbGFPUR/shgFy/2Y9JvaaXNm25AjcE88LkFNF8grR4ZU
	 28Vx6f31pIxIU7A8kj+YbExqzvLopQK/TF1BFzWQmVRg3yWUVl7RyDQxJJmnNrB9K2+mu
	 KWjJBA+Zu2JooBmuNiJu7ATUdOHtLNXuQhtb5Fa46clph2kz/S+quGdPSjMhDP/YE2bAl
	 iBWyqDfqTEP17gaLms4m56fzSXNgVz3GHOdV4mVP83lH8Q7lJWID0OMhSBVSGStwNdFfO
	 Pp5xE4UItGw3KY+pVOO1S/G9hvel6SlmXhv4sP6tayadfQCPgozSolsw3Wc1abEbQXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gLQh06ZX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6A606A31E
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 06:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77F6A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gLQh06ZX
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b4f4095a7aso34479547b3.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:20:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795501202; cv=none;
        d=google.com; s=arc-20260327;
        b=Q6/Cfmtgd1DvTIIaz1i0AWAzbnmpeyA6mMP33cykUEk8yMEYCaQX2/iGlIYXZCcpTX
         xL8VvJKwjYl3IKXxHG2MgoyaXn4AYeP84ExhMXe+tHR3i4vrmozuWlr7csfLGjB0N1N0
         mZO+eYYUzRNbOWlWYvg/ylzWUShqrydG4lAhQjQcHAJoe+3PKHaP7QcmFyCJwTqtt4te
         4S9oKaahlNPVuRWBijgrug9+Ov4VbOklyGeYxAVFaxeThWgdpDC9/zMHh9x4FrcSOMZ2
         Os3WnPyeVVBP3J4UrRnqEQ1dPBIwip5zDXQwHyjto5yx5g6XOL6Lbjn+L5m0cWQ0kN0y
         IWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pI4cY4bgznXKJ4A1hmZr6uhBddx8lY/IEe8WYtmh65I=;
        fh=T83rzD/QwJFdAzPigUx5da1Sqjz4QT7nBwHy/Rb0diQ=;
        b=n65rTnZgsfr1Itx4Lqqjx1mszOOWczvU8ikDdlu/HdQFqOYApoVB/mZu3iRSyP0qUq
         f0wCgRNK5+CRXTm71hZw9n3+iO1+kX+0g6+SxRy6k9Z0nlGnumy+81o0vvFdx1SL2/ze
         7kPyITn33DXjtb+fl0LFURnEPKkL/1sQDPySO4GArLZ90/XfS6uf6kYBzwvjk+bJyHfr
         ubunCYJNZ3tRWkgnTCpVBZ1QUgOcwkPOVs9QKDSnChzAJuJaZGUWXUAEtz/jEqRulXzf
         lwUlos9lpu/u+Fwq2QYsPrAW5bobpDHxiTn6bkTlmgBM6n1/CRIg1JaaJr1qdu5Fc/p2
         ERRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795501202; x=1796106002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pI4cY4bgznXKJ4A1hmZr6uhBddx8lY/IEe8WYtmh65I=;
        b=gLQh06ZXN+nXp1eeOgp/W/m9EQcb4H6xxbAtyBqkY2Re512Zn0YieDfPUaKgVNKnaf
         wsyJvbnWySDCo2sf8C5Mg56I+TKOuiVvALTqyjKc1h3eZrL+J8OIfnMcfXINEb/5SB4g
         jYSFvQACzQeoK7mOXSeU5JhFzNnUPbcoC20xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795501202; x=1796106002;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pI4cY4bgznXKJ4A1hmZr6uhBddx8lY/IEe8WYtmh65I=;
        b=K3cvbR8M0k/PeSf5UnzEErQ1GxV9pR0l9Ersx5djWRtxOKeNQvi6tCGGwI/+gaRjvk
         +trcQMSZia0XSUGvERr69RbRbJVd4UpFCYv7HfTOMdgZVE1uQUEKYbGbGlsFl5JPF35W
         O9AeLuGj4p1vkkrU4l2I+6Q7NK5WCn19sZtwgeo1noLJ4mDoHz4jkHd9REoPC2GLAqYq
         N1KxXEpM9Dv09/knF2A3J2hM2N1LI9f4L12JklcvEB3DCNB6bkOnAmXFkFAt+wi3e4cR
         rWoCd4EI0q7ijgzyJgKA4X4I/vwQVd7IZDCeRsnBUMYWwWsTOMJcbIejWYQcs8ieUZWY
         dOSA==
X-Forwarded-Encrypted: i=1; AL+hErErvN3ZaSAPHniWdQtppOTP7HrUVgSP4X0uxd5wYvjXhH3crPuzq6b6EmDBxdI3g4TNM9+emooVO4g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8H978x7SKy5sVi4RNUiKQwIOODgIx/aYkrFmTeQZI3CzB5yOEB
	oy/opXTwYkmmBKDrO++5Q/bLjFOQlde24V5E8lfA6u+iifgKIpoEcecQ1FTUqjG4FtnTzLdNV2e
	tj/SKW0WO368mmMjmu4QjpVJ2w6xTjLg9xeojSdpH
X-Gm-Gg: AZFdTZeUFY3aW5WaF55p6he7J9HkaBIXzJY9i1AlcbETNHDKMB/e3P8V3JJwvDaLWMN
	xV6ohMYBpSJUg4h8coPoQ9t6jDpshJ/EGBty3Yl5iSeIPWIPXSvVXKFuyGqRXih5pDBahgYq8Rr
	6uuRR6gNeQDZ5FzVGvkzmjIFk/dBoyckdhWK4icGMCCldT0gfIdFei/aXI41NMd3n1KeZVGSvIE
	IL8Ym5uRwK5Qnlp3vNShpaUFfgMBsW5/826yKjKepvXULBsGBgW6YgOTAL75198gMWZRVfT2Rqq
	vCSQd/MepzQXBL/4gaMVKscsZaW7urhDpKVEcxy9KQ0BoXCdiN9VpjGxYZr9Hy9ed45SpuZOMKE
	HU+Ro/Kqpr8F7cSQNejSLY8k1BHth8xnUcNWGr8iin/k4Tg7fZAoY9lxpvcNvtS+H2oc=
X-Received: by 2002:a05:690c:2a87:b0:8b3:3fe5:f6b3 with SMTP id
 00721157ae682-8b520537719mr57934737b3.50.1795501202456; Mon, 23 Nov 2026
 22:20:02 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123113755.3033436-1-wenst@chromium.org> <20261123113755.3033436-2-wenst@chromium.org>
 <TYYPR01MB6603FFE6D156C9E84C9891DA86452@TYYPR01MB6603.jpnprd01.prod.outlook.com>
In-Reply-To: <TYYPR01MB6603FFE6D156C9E84C9891DA86452@TYYPR01MB6603.jpnprd01.prod.outlook.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 24 Nov 2026 14:19:51 +0800
X-Gm-Features: Aa3M54ojNfKajFSsYfJiknRIvLbdnHGoigTuXBmWZPLKOqIabbjntbCzug34xtM
Message-ID: <CAGXv+5E5fSyU6gEPk7BLQdz6wXpgSxaXShM_zTtjuim5W_pxdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: sequencing: Allow desc=NULL in enable/disable
 stub functions
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 8:36=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Chen-Yu Tsai,
>
> > -----Original Message-----
> > From: Chen-Yu Tsai <wenst@chromium.org>
> > Sent: 23 November 2026 11:38
> > Subject: [PATCH 1/2] power: sequencing: Allow desc=3DNULL in enable/dis=
able stub functions
> >
> > The non-stub versions of pwrseq_{enable,disable}() are no-ops when the =
descriptor is NULL; however the
> > stub versions always return -ENOSYS.
> >
> > This would require more code to deal with on the consumer side if the p=
ower sequencer is only needed
> > for a subset of the supported devices.
> > One such example is the rzt2h_adc driver. Only one of its two supported=
 hardware blocks requires a
> > power sequencer. The driver could be built without power sequencing sup=
port and the other supported
> > hardware block would still work (provided the Kconfig dependencies are =
changed).
> >
> > Align the pwrseq_{enable,disable}() stub functions so that they also re=
turn success on NULL
> > descriptors, acting as no-ops like their non-stub counterparts.
>
> Could this make debugging harder? If someone disables the pwrseq Kconfig =
option,
> the stub returns success, so the power sequence is silently skipped.
> The resulting failure (e.g. card not detected) would then look like a pro=
blem elsewhere.
>  Should the stub return an error such as -ENOSYS instead?

I think it depends on your code? The (devm_)pwrseq_get() stub still returns
ERR_PTR(-ENOSYS), and if you pass that to any of the other stub functions,
they also return -ENOSYS.

This change specifically targets code that expects pwrseq_enable(NULL) to
succeed.


ChenYu

> Cheers,
> Biju
>
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  include/linux/pwrseq/consumer.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/con=
sumer.h index
> > d24b5af3e49b..5b3c61e963eb 100644
> > --- a/include/linux/pwrseq/consumer.h
> > +++ b/include/linux/pwrseq/consumer.h
> > @@ -54,11 +54,15 @@ devm_pwrseq_get(struct device *dev, const char *tar=
get)
> >
> >  static inline int pwrseq_enable(struct pwrseq_desc *desc)  {
> > +     if (!desc)
> > +             return 0;
> >       return -ENOSYS;
> >  }
> >
> >  static inline int pwrseq_disable(struct pwrseq_desc *desc)  {
> > +     if (!desc)
> > +             return 0;
> >       return -ENOSYS;
> >  }
> >
> > --
> > 2.56.1.831.g720f3f5937-goog
> >
>
