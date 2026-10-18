Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5373CFF79
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792339202; cv=pass; b=h1Qi2HJGuZmhcOxUw9fGgA6DDLJJ2MQOZRiaMLdStifI6CDW/Yfs1FiyTNjHDVwDysKH5X74i6kpoGqOxFlqeIdfw8cOMjcgsF+KNyN0cw4RpzUTUqKEiXDWGdG7zcah+M/ZFH0EkfRN5GL/tEERTG4O6q9s4vc1mF4UBawmpkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792339202; c=relaxed/simple;
	bh=JzcJJpy2gYrpseHQO+43yHXYRzGIqoHENqgeGBj30xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqTWtyINuAzBSGbscOL+gh+yzX6UvOY+UVkAO3XGrybjxua1M0zHwyt9CjoQP1TpQYybD/6sO4hkrRuVrq2nVLFSKdJjrMww/rqDLfonlnSSjsp4wl0UC2tdVyBcquKrEbZ0ZwiFiKNI0cFBMF+ZRoP/4EF/jT9OLfLIxs9VX8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oS4yhCi1; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS4yhCi1"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-483c607ccb4so900838fac.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 09:00:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792339200; cv=none;
        d=google.com; s=arc-20260327;
        b=lr3VgbPinTfU5FB7T/Sw2mR6Pmm/GA7ScrO43o31trGDweQe7JgoIAaDUU+kdECHw4
         MQpQD3s6vxBUx+TpTsKlFl7n4CTgMySXbMmfmYv4G0/YKoQNFaYy1K33U1iVrZMFaCLQ
         82V6781UiOadseb1sju2InJBT0K99HNDnv03ZKofZC6QkhUIwbePFUy/vM7HpuxR0PLX
         TT2tt1lQDLR+haZZxtaLL4TLaJ37xNcqEVlwVVUIuGDntpesTFM/xR/RHj6vDIgm/Pnm
         i6ayQwG2yi3lJu5KM7mPZrUMWGRC/ZpTYO+1copq/P6WfdkJUJkTxP0x2ddy8kMmItyd
         3aVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PtH3imBx8royFPRkx74DeIp02F8wZK8wqgF5zK1e9pE=;
        fh=/lO3yHFiyYsg3p1KcuBlYDfHRXxEV5gx3rlQh/HWlOc=;
        b=LjN0F+3FBMTPAx27dcl7bpnaQ6qiPsU95yMDpRJA26ZeP2TDoEqyVoN8+0sSRfNrQ6
         wd8GqP7YFfTVS+ysWIIxoZsBKcT+da5DhGgAX6y3TnCFt+7LRfyHF+6KQhPgqIQHML9v
         EkOAEj+eNZn6X+O5pp01pifGPq6uOETq2lHg7kqY4JA/+sWcp7R4hgsKLqgqM/+z0AzU
         mBZaZRC31E8HM0wFWfb5Xho4/EcLdB2o33f/vZkwUcIjF+C8TEryjlaFvw1m5uXHxW0C
         y8S2YesXlV48GBunveum2lV8JEFAO3gEGskLVEX8lXxNaFCHjE4NM+d14Wy8c4sgPvtP
         Lkmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792339200; x=1792944000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PtH3imBx8royFPRkx74DeIp02F8wZK8wqgF5zK1e9pE=;
        b=oS4yhCi1nmvpM+GJRWi5UUY7W3GJm1C0tNtgYv1RjbGBQj52jqt0zNqarucsXvIkyU
         hOiZbDJdxGElO4DwsDzYdN7UOhWYHXS6Sd5siqBhmfIxTtDYvKLE28p/MIBRfUo4ANBX
         AbWf4RB6lQ4Tfp/P0HY7wtiFFhsiGqhBylH5tbQDPqSoG3VPuzoIDm+Uf8nranH+9jsf
         cursgX1HqYHsp0zTG9+0El+6DGmLHqF6mhtiRvQF8/GRok8pU5P/UheoZY0N5yi08w68
         IwX04ODTtBjFD8VNgQWJcrE5qtwVJryRvdc+CsvuspKjJiax/Npi2srO++4CU707wISm
         7GyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792339200; x=1792944000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PtH3imBx8royFPRkx74DeIp02F8wZK8wqgF5zK1e9pE=;
        b=Pp3DUrq1+KEChdtFIv9yAd0H+e2ltyoXbZ7P5rQjn14io1O386jiXdCDMWJVtkd3vX
         jkD/d4n3L07D5BSXn5Plo0ACJi7gPwqMbzPtM6myxBmy01vc7yh6J0NOc3yq5HRNcag/
         sWf8vWM3ExN22bBmz5IjKR+YzjkBLSaLo32QfwY7xI7WSHULKqnwkPl+gh23l6qPy+0N
         kkTPmglK2gvKQrqCETZqYrOOaPKpaE1bCTHqME6/GShW1Iw88s+JJiaT8sGBoaAcmc6L
         Z4deXNErZtODqn2+VKe7DqgptES81mXYoec+QcyCZPvxWahJOWOMn9sgfYBlC0KROi2s
         pX5A==
X-Forwarded-Encrypted: i=1; AKwUvBwPNxWxsrRV9ACbWYyqwAbTq5jZn07I8E9QxHyF+ZH1xL8H+IsypOC8oH5HBB3p0TX9PgyacU5n974=@vger.kernel.org
X-Gm-Message-State: AFq9FYICjlLkRsCnqU7TLipI649Ztr54QHYUT//gxbnOgBEH3M4KTCYd
	CZsz6kLBc6yyVlFqGLOQ60N56natACt3Y+Zp89yFYXtfGujKFK5fuU9SjHjkrhSmYRCMKs33uSv
	E0KWF8v5NXQDUnyg6v13wt+KN30gaBx/c54o9
X-Gm-Gg: AYBFou0vF6jiNKKwbzcRPIHGNqKwGgzmJ7mSaoAURCwXQ2tU5r0yIkRk1YQyCezjlM6
	/Dx/g9tCgAXlymeopNxLHQzd82ABmQyBYtMln7YOGdyXyV5rn/sBVxtibbzYnFDb6xNp+xlHlDY
	iFkUHwL9mvo9JrtTRJWMv7nE62t2M93x50DiCzTDlfnvpS8JiQDXPB893xQPThupMEANnjkDo6C
	RGeqzHt+9Q+G5HTcloTEzvlGuq2UZUA5BLkijt40iaq6sKVVsjhIS463gIVxAuS+vm8Wfjnqg5c
	hSFs8WUXPrCI9KGjvp/2TmmW1HWgYZCmobuLJDN8Vu/2BoQ12NTagxVJQRZ0rYLI+1Nru8CiWAv
	v0//1LJ0uq6lNVw==
X-Received: by 2002:a05:6870:b520:b0:4a7:1cb0:6287 with SMTP id
 586e51a60fabf-4a7579e45f8mr4590240fac.17.1792339200348; Sun, 18 Oct 2026
 09:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014-tlv493d-scale-fix-v1-1-69a722176c06@gmail.com>
 <20261017230910.77d1637b@jic23-hlaptop> <CAFmh=S2O7TzFEe5WqH+Te9dQOK5TwAtjB-7GC7uDj7LGS9=w_Q@mail.gmail.com>
In-Reply-To: <CAFmh=S2O7TzFEe5WqH+Te9dQOK5TwAtjB-7GC7uDj7LGS9=w_Q@mail.gmail.com>
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Sun, 18 Oct 2026 21:29:49 +0530
X-Gm-Features: AclHuK-F7jJBC_8i46qI7Dk9IvquedrwAiAZVypGRkNENfn7t7YKgyI5OOzkNIE
Message-ID: <CAFmh=S2mXJLk=V_r_eie3=zDfXXRX+aUba=Kn+5h3PQ9pkwxnQ@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: tlv493d: fix magnetic field scale
To: Jonathan Cameron <jic23@kernel.org>
Cc: Viral Patel <viral8854@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM. Good catch. There seem to be miscalculated Gauss scale due to
multiple conversion factor.

Reviewed-by: Dixit Parmar <dixitparmar19@gmail.com>

On Sun, Oct 18, 2026 at 9:22=E2=80=AFPM Dixit Parmar <dixitparmar19@gmail.c=
om> wrote:
>
> This change looks correct, the Gauss scale value seem to be miscalculated=
 due to multiple conversations and different reference. Good catch.
>
> On Sunday, October 18, 2026, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> On Wed, 14 Oct 2026 23:07:36 +0530
>> Viral Patel <viral8854@gmail.com> wrote:
>>
>> > The TLV493D-A1B6 datasheet specifies a magnetic resolution of
>> > 98 uT/LSB (0.098 mT/LSB). IIO reports magnetic field in Gauss
>> > (1 mT =3D 10 G), so the scale should be 0.98 G/LSB.
>> >
>> > The driver currently reports 98/1000 =3D 0.098 G/LSB, which
>> > under-reports the magnetic field by a factor of 10. The comment
>> > also gives the resolution as 0.0098 mT (9.8 uT), mixing up units.
>> >
>> > Correct the scale value and the comment.
>> >
>> > Fixes: 106511d280c7 ("iio: magnetometer: add support for Infineon TLV4=
93D 3D Magentic sensor")
>> > Signed-off-by: Viral Patel <viral8854@gmail.com>
>>
>> I'll give some time for Dixit to take a look at this.
>>
>> Thanks,
>>
>> Jonathan
>>
>> > ---
>> > Found while comparing this driver against the TLE493D-W2B6 register
>> > map for a new driver I am working on. Compile-tested only; I do not
>> > have TLV493D-A1B6 hardware.
>> > ---
>> >  drivers/iio/magnetometer/tlv493d.c | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetom=
eter/tlv493d.c
>> > index 03415cc2c9b3..234e3ce63ff7 100644
>> > --- a/drivers/iio/magnetometer/tlv493d.c
>> > +++ b/drivers/iio/magnetometer/tlv493d.c
>> > @@ -299,11 +299,11 @@ static int tlv493d_read_raw(struct iio_dev *indi=
o_dev,
>> >               switch (chan->type) {
>> >               case IIO_MAGN:
>> >                       /*
>> > -                      * Magnetic field scale: 0.0098 mTesla (i.e. 9.8=
 =C2=B5T)
>> > -                      * Magnetic field in Gauss: mT * 10 =3D 0.098.
>> > +                      * Magnetic field scale: 0.098 mTesla (i.e. 98 =
=C2=B5T) per LSB.
>> > +                      * In Gauss (1 mT =3D 10 G): 0.98 G per LSB.
>> >                        */
>> >                       *val =3D 98;
>> > -                     *val2 =3D 1000;
>> > +                     *val2 =3D 100;
>> >                       return IIO_VAL_FRACTIONAL;
>> >               case IIO_TEMP:
>> >                       /*
>> >
>> > ---
>> > base-commit: ceb05f22e5cdc3f8bd3f7d5dcfc57843942191dd
>> > change-id: 20261014-tlv493d-scale-fix-5a0b83b52d2a
>> >
>> > Best regards,
>>
