Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001B40DFD7
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606400; cv=pass; b=PSRPpsU5dv0id5MJoPsK23X/XvBycdT1m6iY8qEqzXg0K/0O5uqIEUUJpqKy/7FpyUvh7CcYtL5FHuT7aZzNno35rFXBxUQI2dKiV3m2sdtbjhuw+bJLgEdMJc14LxA7G6JQZ6Q1tQtqZMQ5c65ln04BtouemAYWjI1n75QXPdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606400; c=relaxed/simple;
	bh=qFptuGNZkmWSENWkgWeSTiypA6pxk0Bss8JmWP01E2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF/ziDv4jXjgMkoP/4ZwIwzJk/ppf3iH7qvqgAobuYZVVlOam4piqP0GtrASr093S66LB4Jcq0LJFDFHsFIBkb/1q/Unb0c2K36r2rDFbhMiRjiglXqWbum2svTvHRzJQfyBr6LmsXVr4iGN916MCLNFzY6uV7tjC2WzZhrXYE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ217TpC; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ217TpC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0046078so20631925e9.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 06:46:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776606398; cv=none;
        d=google.com; s=arc-20240605;
        b=i6luL5kPPNhzGKa16lmyyhXGuDR0cD+hS+7Fpgs1iIe4kmw0fuLBCA1ai24D+I6/dK
         Z24KtWrJd8ElYx9t6BxmNQlFLV8nDdW9YhhgyvgZmSjK7FBZSTV0OPPyUDT8auFO9RLE
         zjG316fE5xeVvZDPsx0UrD1TDgYCa0XglsQ+UXiFlAFF5GLAjyfdE6Yo5oPOm8j1+wr7
         wPT249oqo+hgqEIlQltOIHIj9/sYLrFzQTbJWuanONfGLbhMM8RxkTqEgZGtLeJ1YTXk
         6Uj1cWa+t2NuPT36ippLbT6dT1SFToKCUusMF3+vJdoZmdYAW0DXtfuz3ZDuWKlilKJf
         QeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jsz5uA7mB3aQz6UuprfjwX+wOOHCxT6ua21vZZ7zV1o=;
        fh=47hdCVMZOkQuDtGUr9tu69odboGEq/XeHpfXU3peJy4=;
        b=R/aJcQSf3oD4dUBUI5KXMgPDEnKb3iKmKY2ff49cSSt8gt96Al1ZKIYl3kHBX2eKAT
         nAoLJsJgVWYOoO5nfJblQ1rosZWIqQhKjqEQr1YZlYeLFpkXSHBsn5W8qe0CicQp2sNl
         ydRb0fzgrqT4d49IJ+fkDkt3UywhiTXy5Z1dyjg+rqI9UzfLJROFwx5zXa13qua+3rv9
         TUALgvfOxpU65+DrSLFmwmeO4F/YmPfIYdKrR13Zn0/8PgI2dCSfZD4I8uwCTlqV/7e3
         nVTIKVsWD4EduTP7iHDwTF/9nofp0PUSjCcS+fqfgdpdynWc7phrUcrLjFDDJw1XuvZA
         6m8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606398; x=1777211198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsz5uA7mB3aQz6UuprfjwX+wOOHCxT6ua21vZZ7zV1o=;
        b=kZ217TpCkubuYMwnRHX511MtxPiavBgfcoPrPliI5XAUi4PmLXKRSuTrdZaNR8Mlt+
         gjzh5erYPTEQgBdOKsqRvGCq+GnFXWjG9wt3z6kRvyJAo3d9Q514xjWvEVaCQGdDllKy
         nwSEM8LkjTRiTRPRqLFk4bI2mv8om9FUY1Bq70Z67s26HoGPlvHUWAEpiybqr9bomOnh
         PQ3VyfmHvKus78h5Mo1MgAfbqerKT3axaQ72gzemIVXNM0oozn97PtoDZBhfczVW05yK
         7uflch10bugef1acDJ1+lwSpvNA973WkwtWNlDSQ+mdC8gSJ6uAEbuMzJT7/BJflt335
         Ia1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606398; x=1777211198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jsz5uA7mB3aQz6UuprfjwX+wOOHCxT6ua21vZZ7zV1o=;
        b=LKhHzmPjgrQgSh9k1p2wkQI8qzkHJ1WwgmJXC0x9gGiK19rYZW2/NwDocITSLzzxjt
         PO9HpSItENiP8XArhNvnWfEmgJbcjyCUEPT2KN3HX58uuB/L3JFUArcPQvMey8E8ZV+U
         uEPCoIzU3lg1w1tAZfNA38A+8v5eLe6TQkex8McwzBPyHslj33kqc9NeiEMLyP/h03O3
         jaxz6CdfI+aryhAIKPo0LrYziPCkFIUzc1I1nuv3dlRr1H9TH43vxGA7iy8d0Qzj/X3y
         DCZQmi4QR9vRDULdnbP/gmOHT3Ocs1MgfKFRm5f/MHFOgjTsjT+rTqYXiIsaBJ2v1Xyt
         xEjw==
X-Forwarded-Encrypted: i=1; AFNElJ8Cwbc5Mp7B4HW5W3YvxSId8g7TCtjrh8LsL1Vx2norwN7Xz2WOfD8/E4+A2/TT2zI0fPSAjRnMbKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqMhlLdRkNt2YuaDFtfMaMJXoIBl73FzNtF4YI832gRLdfkY5
	7FShyfLz3Zfkk518kmojZr5k6cAYakKkNM1ThqbWIRVE5RSthzyAtUE1HmJZDxG0CJxe+BUsrpv
	xijZKHd6c+HCWjUjgQ/O9vRVGhqxzvC0=
X-Gm-Gg: AeBDietYTB81H9w6omiqYmFF0yD/hwHNJcN/cKaxlxhMnAEepd2oNW++SF/OLZsvhi1
	FMet7cSlvAWkBiH9eTrBPUztzET9xMnVk1K61oHJZsIw1oZ3KrAJmykGijpe1pZRbNFnS+Nv3Sb
	ANmIMZWVkZBo1cmIOmZ8uJ8JP1BDu7M1kaVMU7QGI7lG2TXGlLZo4SBC4X3yB0esB7pGyrbjOkU
	D2APjPWPBOqwMCM8K82tbsw9KFLFUtONsLGVBEbLmwv4LxRf7+0o99ZABJZ2MNo4ItTSguLDKnv
	92K0BilWtMVqU8myvyc=
X-Received: by 2002:a5d:584b:0:b0:43d:300b:2285 with SMTP id
 ffacd0b85a97d-43fe3dc5c58mr14983269f8f.11.1776606397785; Sun, 19 Apr 2026
 06:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419083125.35572-1-clamor95@gmail.com> <20260419083125.35572-3-clamor95@gmail.com>
 <20260419143751.11ec0b69@jic23-huawei>
In-Reply-To: <20260419143751.11ec0b69@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 19 Apr 2026 16:46:25 +0300
X-Gm-Features: AQROBzDHUz7Bq4Yx9C52FIvc2ZHcHpmYflBENb0J-YXx8dYIQFe3jx1jZbIQtS0
Message-ID: <CAPVz0n048kPMAnGQpOk0_SPtQ+hz=-p6jdyRYPB5d+CD9i7_Cw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: tsl2772: add support for Avago APDS9900/9901
 ALS/Proximity sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 19 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:3=
8 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 19 Apr 2026 11:31:23 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > The Avago APDS990x has the same register set as the TAOS/AMS TSL2772 so
>
> A Sashiko review comment makes me wonder about one thing below if the
> register set does match.  Maybe it's a bit more subtle than this
> patch description suggests?
>
> > just add the correct bindings and the appropriate LUX table derived fro=
m
> > the values in the datasheet. Driver was tested on the LG Optimus Vu P89=
5.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/iio/light/tsl2772.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > index c8f15ba95267..8dab34bf00ca 100644
> > --- a/drivers/iio/light/tsl2772.c
> > +++ b/drivers/iio/light/tsl2772.c
> > @@ -127,6 +127,7 @@ enum {
> >       tmd2672,
> >       tsl2772,
> >       tmd2772,
> > +     apds990x,
> >       apds9930,
> >  };
> >
> > @@ -221,6 +222,12 @@ static const struct tsl2772_lux tmd2x72_lux_table[=
TSL2772_DEF_LUX_TABLE_SZ] =3D {
> >       {     0,      0 },
> >  };
> >
> > +static const struct tsl2772_lux apds990x_lux_table[TSL2772_DEF_LUX_TAB=
LE_SZ] =3D {
> > +     { 52000,  115960 },
> > +     { 36400,   73840 },
> > +     {     0,       0 },
> > +};
> > +
> >  static const struct tsl2772_lux apds9930_lux_table[TSL2772_DEF_LUX_TAB=
LE_SZ] =3D {
> >       { 52000,  96824 },
> >       { 38792,  67132 },
> > @@ -238,6 +245,7 @@ static const struct tsl2772_lux *tsl2772_default_lu=
x_table_group[] =3D {
> >       [tmd2672] =3D tmd2x72_lux_table,
> >       [tsl2772] =3D tsl2x72_lux_table,
> >       [tmd2772] =3D tmd2x72_lux_table,
> > +     [apds990x] =3D apds990x_lux_table,
> >       [apds9930] =3D apds9930_lux_table,
> >  };
> >
> > @@ -289,6 +297,7 @@ static const int tsl2772_int_time_avail[][6] =3D {
> >       [tmd2672] =3D { 0, 2730, 0, 2730, 0, 699000 },
> >       [tsl2772] =3D { 0, 2730, 0, 2730, 0, 699000 },
> >       [tmd2772] =3D { 0, 2730, 0, 2730, 0, 699000 },
> > +     [apds990x] =3D { 0, 2720, 0, 2720, 0, 696000 },
> >       [apds9930] =3D { 0, 2730, 0, 2730, 0, 699000 },
> >  };
> >
> > @@ -316,6 +325,7 @@ static const u8 device_channel_config[] =3D {
> >       [tmd2672] =3D PRX2,
> >       [tsl2772] =3D ALSPRX2,
> >       [tmd2772] =3D ALSPRX2,
> > +     [apds990x] =3D ALSPRX,
>
> This is different from tsl2772?

yes, lux table is different and made according to datasheet,
tsl2772_int_time_avail differs, ALSPRX configuration assumes that
proximity sensor needs no calibration which is true for apds9900/1
while tsl2772 needs calibration, device ID is different 0x20/0x29 for
apds and 0x30 for tsl2772

>
> >       [apds9930] =3D ALSPRX2,
> >  };
>
