Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A535E1CE
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052579; cv=pass; b=GGLQCCaMALGwvnBDU5LPy6kEsjcriES/3ANTat/pnBs9I6LKO8c3l3Be+nKnBnk3tcb8JR4LtVE0sJvWf0EV2pPmt8bPfBbVXLKrSC/392HyIVu+vXOJGiA/Td2gE2w23he4Tby1K52V2D6ArMr/EcRZGZeyPJ1t73gM8zExwKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052579; c=relaxed/simple;
	bh=VX0GZld8TcpuuHGg4c1vdgycUrvDO2NLeGvlFPPDW2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQOWhf2/4PbrHmN88Hk/rlEXajIQ03V5EMvZgl8VnFJ5VooUnGywaQsmA23aye/m5lWqh0L20HqFASPgtHqizwqhhiQy3EAkNRFBB2MZ+zxASW2d5MGG0NE0BErLjGfwRo7TGML5/xkhfWgUYqEXGa9Is+vmo8OV2mX9EGAQs6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ag/qz1V0; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag/qz1V0"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137bd9ed2b1so967399c88.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 04:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780052575; cv=none;
        d=google.com; s=arc-20240605;
        b=UcOeWGL/X+GLgtq3m7uKy7EDvSpIkSh7w/Czf2XhnJOIRANLZMULh6EsZZT8lMgjYq
         f50nm90Rtvn1d8R/YqAxfFHGaW9/aCRm7ftOf2bYkhi51cBtmLFk36lMXuO0wbkESMkS
         +sAw0AG54CKR8XKB0w5b8d1IpcA4W0iR2pZcSi/fNsm7GAHzYVRac3CECAxAyRiMEZtX
         o56qor9mfEjdDYLjgRfC9MqgTafu4VEz0KDLQIBnSyfXoEe/Plb8rhosffYw74JVU4Dg
         G2hIewQRlkypdTYGmcwiTJ1M+AxdgmtFp7OMRRdd5jjq89JWrUpnYiZHKEzScLuxdH4e
         7L3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qf0EPFsEMgv7RinRHJC8+FSrNX+a+vtz20v10EwyVsU=;
        fh=0AFuh/3OkCUzmR9xDSMGLpkPxCNEoi6B88ePy3nPJCk=;
        b=WCFRSMpkqtvmZ6yk/bFJlRIKv2dWCCdaPj8JiCWE5An+dQsyB6g7Aa5x53b5BvBsJy
         gH3D93hyYy1Q5FH4CASxgjDw6P0vhleUi+ojzk80wrq1YJzEgBRBxiCF4fBFJ9bJtA25
         7Ojqdo2hv2mn3X4+jEtp6G/oFF0plwDgSxOE8ImjsRG9XW7JaoNaHW0Y4RlDQ0GAsKZZ
         5hMkee1lEFTp68uekitet0YkofHklNfPqhv+C0TLkFvLwnsR3J09Ed3mNv6vgGu+vDV7
         y2f7X+dA5LUZuwErTotCD6BGGmJBOvbS7o+2TFvelhM/LFReHVSbtEKZ3rPjmmRQbWef
         sn8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780052575; x=1780657375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qf0EPFsEMgv7RinRHJC8+FSrNX+a+vtz20v10EwyVsU=;
        b=Ag/qz1V0RHuzU2g6cEi1QeCR/yaPQ3rrFe4RWo3BqITNwBLsw52nwXWUEeBJJRA7gV
         oDH9BxJzCce69Dstm/ApyIL9MbV6rlWC5HAiX6YvuMlgVLwPU24thshD4UANWbIBG76T
         kPPZLP+sodhGOMriruD0laaf2jkZCvfmRssSKeQT1gZSKcMrnZ6L0YFIydRlcsRRq3gE
         CZ9QhItOrVlqkXcIGfz+vRVNevtSEE51l3ZvLeLsEMimZ5YgqPqzr3RU0ckX5hzpwrqN
         ADJg7+VEaY1lK1/0lqVKjxJNVGH0dBABGNX41xzhsMVyUyzHeRtozwn53Gc+SL6tob4/
         LPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780052575; x=1780657375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qf0EPFsEMgv7RinRHJC8+FSrNX+a+vtz20v10EwyVsU=;
        b=skBCSXngdSbjqXyJiCGCMmVHx1eKG2bhEEqYaqG5lTf4EFBwWZ3XHtiNWhfRoHdafI
         ddYdWYXe9ObieSGvR7PNLv60ijArDyAk8Ni9/6ONVyc2hKUHNATQM+Stt469LZbQpjzE
         DW7wibqvBtkKbweYuSFN5IytLRQlx1f/Bgbq3aHWPKY7wMTuX3eQ3BJ9yk15Me8KpmWU
         5RRm5qO/xboObDDQlzSmu8dFkPVSA9DOhT74gs67bldFrV8rXf27uyzY11TncuxH9FZA
         d4WARF7fdxcRopCcbDV9BFXGrhPptO6VOvzXAdhFGcZzFv3OesnDv+Ue3pEVXhkfSrcE
         7j0w==
X-Forwarded-Encrypted: i=1; AFNElJ8TFAvRYX7jE5KwaGtW/MGTUuXaW8bk6pgkWX8CM2Q0Lqn/IDRFE6JN8xogSq/ktepQJYNhUF/teKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfk544lcZS3+1PXlu1gfsHg4Q6foD+xpo8iYdd1C2mHBxUOuR1
	sL5nbYGRsgsuJrKylEFL+ph54rJ5jJGbp9sKROeIEzgxXd1J9XRAIqWh0bcdIxZb0SsmMSLjS+c
	GqSlszwqPHFrtNC4rwrURyfLoiOLZTUc=
X-Gm-Gg: Acq92OEj1ZkgqEeG8aNQWYlm0IxkxPuDpXfF426ayyK5EUAShA9qKVRS6bbImxUs4XB
	KfJFIj6Z/kAV4F9uawtsJ85j1Dt3EME80gq/FPeR8YRq2EKsNHLh+LqlRi6eejlIOR9lGviK0hd
	2g7haGWMAffQ5iULFI5i+O9VPLjT7jSovsy4GImXhq0HUP6PQJecpDwGzsd1LpYdocDVNIk9V1D
	8PNaRe3icfGJZbWGGfZaisQdJod3h6bEmrO2EEJF4uc8AnoYeN4WKXeXkZerG85tfrsbFvAGNgF
	4RChmZu/328DtS7cbeI=
X-Received: by 2002:a05:7301:5f89:b0:2f1:6252:f8fe with SMTP id
 5a478bee46e88-304ead9c0a3mr1051392eec.3.1780052575098; Fri, 29 May 2026
 04:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com> <20260528135123.103745-3-clamor95@gmail.com>
 <20260528155001.2bcb7003@jic23-huawei> <CAPVz0n0qCekQVGGyAyBuYv+RKC6bpydYBLJNGfPrgTYjtOJOuA@mail.gmail.com>
 <20260529100819.1823ebb3@jic23-huawei> <CAPVz0n0VHdUo5oHdALgcerLsykdz-2n7c+jxYHrMOV7Ra5x_qQ@mail.gmail.com>
 <20260529114828.5a87c732@jic23-huawei>
In-Reply-To: <20260529114828.5a87c732@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 14:02:43 +0300
X-Gm-Features: AVHnY4JFkCjq5u7WpABFbger7MZKVNNC_WAp1_zpv0s6179IZSDqS5525lREGVM
Message-ID: <CAPVz0n1u0z35rP8vUKjAzW_mrPm9yeMjK_-nKbyctUvQik6ECw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mfd: lm3533: Convert to use OF bindings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:4=
8 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, 29 May 2026 12:39:56 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
12:08 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, 28 May 2026 18:03:31 +0300
> > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > >
> > > > =D1=87=D1=82, 28 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=
=BE 17:50 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Thu, 28 May 2026 16:51:19 +0300
> > > > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > > > >
> > > > > > Since there are no users of this driver via platform data, remo=
ve the
> > > > > > platform data support and switch to using Device Tree bindings.
> > > > > > Additionally, optimize functions used only by platform data.
> > > > >
> > > > >
> > > > > At least the IIO ones would have made much the same amount of sen=
se for
> > > > > dt, just that they weren't having in the first place. I'd prefer =
that
> > >
> > > Gah. I write gibberish after too much reviewing.  having/helping!
> > >
> > > > > as a precursor patch to make the rest much more readable.
> > > > >
> > > >
> > > > I can add you preferences into this commit, I don't mind.
> > > >
> > > > > >
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > >
> > > > > I only looked in detail at the iio bit. A few changes requested.
> > > > >
> > > > > > ---
> > > > > >  drivers/iio/light/lm3533-als.c      |  95 ++++------
> > > > > >  drivers/leds/leds-lm3533.c          |  51 ++++--
> > > > > >  drivers/mfd/lm3533-core.c           | 268 ++++++++++----------=
--------
> > > > > >  drivers/video/backlight/lm3533_bl.c |  52 ++++--
> > > > > >  include/linux/mfd/lm3533.h          |  51 +-----
> > > > > >  5 files changed, 212 insertions(+), 305 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light=
/lm3533-als.c
> > > > > > index 99f0b903018c..cbd337b73bd9 100644
> > > > > > --- a/drivers/iio/light/lm3533-als.c
> > > > > > +++ b/drivers/iio/light/lm3533-als.c
> > > > >
> > > > > > @@ -714,59 +720,33 @@ static const struct attribute_group lm353=
3_als_attribute_group =3D {
> > > > > >       .attrs =3D lm3533_als_attributes
> > > > > >  };
> > > > > >
> > > > > > -static int lm3533_als_set_input_mode(struct lm3533_als *als, b=
ool pwm_mode)
> > > > > > +static int lm3533_als_setup(struct lm3533_als *als)
> > > > > >  {
> > > > > > -     u8 mask =3D LM3533_ALS_INPUT_MODE_MASK;
> > > > > > -     u8 val;
> > > > > > +     struct device *dev =3D &als->pdev.dev;
> > > > > >       int ret;
> > > > > >
> > > > > > -     if (pwm_mode)
> > > > > > -             val =3D mask;     /* pwm input */
> > > > > > -     else
> > > > > > -             val =3D 0;        /* analog input */
> > > > > > -
> > > > > > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, v=
al, mask);
> > > > > > -     if (ret) {
> > > > > > -             dev_err(&als->pdev->dev, "failed to set input mod=
e %d\n",
> > > > > > -                                                             p=
wm_mode);
> > > > > > -             return ret;
> > > > > > -     }
> > > > > > -
> > > > > > -     return 0;
> > > > > > -}
> > > > > > -
> > > > > > -static int lm3533_als_set_resistor(struct lm3533_als *als, u8 =
val)
> > > > > > -{
> > > > > > -     int ret;
> > > > > > -
> > > > > > -     if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RES=
ISTOR_MAX) {
> > > > > > -             dev_err(&als->pdev->dev, "invalid resistor value\=
n");
> > > > > > -             return -EINVAL;
> > > > > > -     }
> > > > > > -
> > > > > > -     ret =3D lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR=
_SELECT, val);
> > > > > > -     if (ret) {
> > > > > > -             dev_err(&als->pdev->dev, "failed to set resistor\=
n");
> > > > > > -             return ret;
> > > > > > -     }
> > > > > > +     device_property_read_u32(dev, "ti,resistor-value-ohm",
> > > > > > +                              &als->r_select);
> > > > > Does this have a default?  If so the pattern we've recently be se=
tting on for IIO
> > > > > is
> > > > >         if (device_property_present(dev, "ti,resistor-value-ohm")=
)
> > > > >                 ret =3D device_property_read_u32();
> > > > >                 if (ret) //corrupt property in some fashion
> > > > >                         return ret;
> > > > >         } else {
> > > > >                 //set default
> > > > >         }
> > > > > If there is no default then check it unconditionally.
> > > >
> > > > default value is LM3533_ALS_RESISTOR_MIN and if no property is pres=
ent
> > > > clamp will ensure that als->r_select will be set to
> > > > LM3533_ALS_RESISTOR_MIN
> > >
> > > I don't see that default in the binding doc and relying in the 0 bein=
g clamped
> > > isn't particularly readable - I'd set it explicitly.
> > >
> >
> > Oh, ye, my bad. Schema enforces one of props to be present and if pwn
> > is present then resistor is ignored. What if I move resistor reading,
> > clamping and conversion under !als->pwm_mode check? Then resistor must
> > be present and hence must be checked unconditionally.
>
> Sounds good.
>
> >
> > Additionally, I can comment original lm3533_als_setup with #if 0
> > #endif then git formatting will be much cleaner and easier to review,
> > and once we all come to result I will just remove entire commented
> > block and Lee can pick clean commits.
>
> No don't do that.  If you flatten the two helpers as a precursor patch
> then the changes in here will be easier to review anyway.
>

By "flatten the two helpers" you mean incorporate
lm3533_als_set_input_mode and lm3533_als_set_resistor into
lm3533_als_setup first and then convert it to use DT? I am asking,
just to be sure.

> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > -     return 0;
> > > > > > -}
> > > > > > +     als->r_select =3D clamp(als->r_select, LM3533_ALS_RESISTO=
R_MIN,
> > > > > > +                           LM3533_ALS_RESISTOR_MAX);
> > > > > > +     als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * als->r_sel=
ect);
> > > > > >
> > > > > > -static int lm3533_als_setup(struct lm3533_als *als,
> > > > > > -                         const struct lm3533_als_platform_data=
 *pdata)
> > > > > > -{
> > > > > > -     int ret;
> > > > > > +     als->pwm_mode =3D device_property_read_bool(dev, "ti,pwm-=
mode");
> > > > > >
> > > > > > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > > > > > +     ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF, als->p=
wm_mode ?
> > > > > > +                         LM3533_ALS_INPUT_MODE_MASK : 0,
> > > > >
> > > > > That's ugly.  Better as
> > > > >
> > > > >         ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF,
> > > > >                             als->pwm_mode ? LM3533_ALS_INPUT_MODE=
_MASK : 0,
> > > > >
> > > >
> > > > Yes sure, just followed 80 char limit.
> > > >
> > > > > Though if there wasn't a layer hiding the regmap, it could just h=
ave been
> > > > >
> > > > >         ret =3D regmap_assign_bits(lm3533->regmap, LM3533_REG_ALS=
_CONF,
> > > > >                                  LM3533_ALS_INPUT_MODE_MASK, als-=
>pwm_mode);;
> > > > >
> > > > > which would have been nicer.
> > > > >
> > > > > I'm not particularly keen on the swashing of the helpers being in=
 a patch
> > >
> > > smashing.  (this definitely wasn't my best effort at English!)
> > >
> > > > > that is about switching the binding type as feels largely unrelat=
ed.
> > > > > Should really have been a precursor, easier to review patch.
> > > > >
> > > >
> > > > Removing of lm3533_update layer is not the scope of this patchset.
> > >
> > > Understood.  I'm fine with just the refactor you are doing brought ou=
t as a precursor
> > > patch.
> > >
> >
> > I have looked into removing wrappers too. That seems to be less a
> > hassle that I anticipated, so I will include regmap switch in the v2.
>
> Ah ok. Even better.
>
> >
> > > >
> > > > >
> > > > > > +                         LM3533_ALS_INPUT_MODE_MASK);
> > > > > >       if (ret)
> > > > > > -             return ret;
> > > > > > +             return dev_err_probe(dev, ret, "failed to set inp=
ut mode %d\n",
> > > > > > +                                  als->pwm_mode);
> > > > > >
> > > > > >       /* ALS input is always high impedance in PWM-mode. */
> > > > > > -     if (!pdata->pwm_mode) {
> > > > > > -             ret =3D lm3533_als_set_resistor(als, pdata->r_sel=
ect);
> > > > > > +     if (!als->pwm_mode) {
> > > > > > +             ret =3D lm3533_write(lm3533, LM3533_REG_ALS_RESIS=
TOR_SELECT,
> > > > > > +                                (u8)als->r_select);
> > > > >
> > > > > Same applies here. Mostly an unrelated change as the only thing s=
witching that
> > > > > is related to the patch is one parameter.
> > > > >
> > > >
> > > > Removing of lm3533_write layer is not the scope of this patchset.
> > > >
> > > > > >               if (ret)
> > > > > > -                     return ret;
> > > > > > +                     return dev_err_probe(dev, ret, "failed to=
 set resistor\n");
> > > > > >       }
> > > > > >
> > > > > >       return 0;
> > > > >
> > > > > > @@ -852,25 +825,28 @@ static int lm3533_als_probe(struct platfo=
rm_device *pdev)
> > > > > >       indio_dev->channels =3D lm3533_als_channels;
> > > > > >       indio_dev->num_channels =3D ARRAY_SIZE(lm3533_als_channel=
s);
> > > > > >       indio_dev->name =3D dev_name(&pdev->dev);
> > > > > > -     iio_device_set_parent(indio_dev, pdev->dev.parent);
> > > > >
> > > > > I'm not sure why this was there in the first place.  Hence not su=
re if it
> > > > > is safe to remove.
> > > > >
> > > >
> > > > This is directly related to OF conversion. The iio_device_set_paren=
t
> > > > bound indio_dev to parent, and it causes problems with OF now since
> > > > als output has its own node and binding it to parent if wrong. Same
> > > > story for backlight and leds btw.
> > >
> > > Is there any risk anyone was using the canonical path to get to the i=
io dev?
> > > /sys/bus/platform/devices/..../iio\:deviceX
> > > This is technically an ABI change be it a subtle one.
> > >
> >
> > Linux kernel has no users of this driver, and it is in "stale" state
> > for more then 2 years (maybe even longer). I have cc'd Johan Hovold.
> >
> > https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
> >
> > This this 2 y. o. discussion and there were no actions ore movements.
> > I assume this driver in its current form has no more users. This does
> > not mean that it cannot be revived though.
>
> So, just to check, are you a user of this code or is this more trying to
> help out with old code?
>

I am not insane enough to get myself into all this conversion if I did
not need it. This is one of 2 remaining gaps in support of LG
P880/P895 I own and support. I would really like to finally mainline
all the patches I have locally since maintaining them becomes quite
troublesome with time and additional patches layering on top.

> Jonathan
>
> >
> > >
> > > >
> > > > >
> > > > > > diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3=
533.c
> > > > > > index 45795f2a1042..d707d43d5526 100644
> > > > > > --- a/drivers/leds/leds-lm3533.c
> > > > > > +++ b/drivers/leds/leds-lm3533.c
> > > > >
> > > > > >
> > > > > >       led->cb.dev =3D led->cdev.dev;
> > > > > >
> > > > > > -     ret =3D lm3533_led_setup(led, pdata);
> > > > > > +     device_property_read_u32(&pdev->dev, "led-max-microamp",
> > > > > > +                              &led->max_current);
> > > > >
> > > > > I'd prefer explicit setting of the default to be visible before t=
his, or
> > > > > the property_present pattern I mention in the IIO review above.
> > > > >
> > > >
> > > > clamp will ensure that led->max_current will be set to
> > > > LM3533_LED_MAX_CURRENT_MIN regardless if it it present
> > >
> > > As above, I'd prefer it set explicitly.
> > >
> >
> > I understand your position and I am not denying it for ALS part, but
> > LEDs don't belong to IIO subsystem and different subsystem maintainers
> > may have drastically different preferences and requirements (ugh, PTSD
> > in its full glory).
> >
> > > >
> > > > > > +     led->max_current =3D clamp(led->max_current, LM3533_LED_M=
AX_CURRENT_MIN,
> > > > > > +                              LM3533_LED_MAX_CURRENT_MAX);
> > > > >
> > > > > I didn't look any further (busy day!)
> > > >
> > >
>
