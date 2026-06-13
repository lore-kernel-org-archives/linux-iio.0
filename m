Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11E385D75
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781340463; cv=none; b=BMqm7brjSUgk+MO2UQyzlWSbEndv6CUV25xdZU7THdb5oioEtGqYWEegVSpYXGqiQXGraHZODlJoGPtQrz/THBqqmCipUIGRKtz7pe6mOMcLMASLE8uU9DGkIq4Sid07nauO+vwpNO2YdME+l8TXpIFIFynJT/t8187EV2Kkmtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781340463; c=relaxed/simple;
	bh=RO5qDwNntsWRVf3hk2MbhYoXXAqEmMOVwsDvzO/JX+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCQsfbifih5ZvlxzXIkjFQJQESMVuxZR40+Yj0lqtc3jDEp9cFR+l6HoLIqL99guggMNe7ecQl+GIKc44tBYZkXaYjs3DvZvUnsW8EL6SCppj+ChbwXpITv4OprxakPHJ0uvDYa6FR+k/YgMtU7MqNVqh135aaw3EkGUfVxjxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dc2b658544so12143197b3.2
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 01:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781340459; x=1781945259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jGiCJ3o3O6zZWSIlnyakLQENXzMeJV1nXpt/hPjZYFY=;
        b=ah18EoQh3ljHDeaZuWS7zygnkjacwu+ha0yFdUi6iPk3unsLNewjkgBZKgtaiEA9K0
         3oVncFtoJCAh+kEnlW6vAURZGPaULEzthkxkTLZvQC//cjQlNVF4o5WMR+3dquLGVMjZ
         Gh1eHwkUk5a30u5Stwkh42XWB1WFf/PUC2k4dYhNB97dypdY9vnygjmXgd1StI+Hl1Jf
         WuIlnjVBB9YiWRW0/F9Kjw3+20uf4Q/XbkaI5FYm0L1oKozAlbjywD9Fme2cjm1AnqbZ
         t4e9zWtzcrXpfm751z2HK+Sx3Q2GisNI7U6OWCT0xLL7E8XOxPGaCFKJQW72R3lZKh6q
         eUfA==
X-Forwarded-Encrypted: i=1; AFNElJ9Qpd3OuFbPJ7OeasrUMDwfNZwMpVS416QW+/CKCzrJhJGNMRbC/mfdToC30NwOwFRVVir1wRspFRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIzFGXMubUCPsVn9B4CYi5qZ926PY9bcttXzS4Z5WEsjryI/Zh
	typ1ICAr/FeScPKqvjEat/0LLpnwOC37G6FDd+GJSgQsb2VBiYyCu/BfyEJXYS/b
X-Gm-Gg: Acq92OHjXDVYZgEHD3FzD6XFthwkFASWeBUNVXRwx8qLM2G5p0pZ+urt8QslxvrMQpf
	Jb+c52LWB4NktFhYlzDyXmdYCGNBTr0rvOQweTVb0PY31SOP0EtrnSJKGd/wNbThfNf5taAA6nh
	gj60pV+rVZmlLtqI3L8CVvhurPDhOO6sjI0+Z5zBHvUqqoL+QSyEQodmIBX/wNoRWXUsqhywIIJ
	f8Z33r4Zd+ec+dC55EOFTL/i1AJ0YIASRVl4pW7W7zStWsvp2ZkmCjIGo3iHRoZiaG+HLTCgsOy
	Vzofc3b9gy32bVrSTJ1h1vOvugY8I+10zfKPhNEh+/eQBTXQLNhS5DlFcJ0Rc29+0a+UpebI7zq
	DQkaigJ9jC2KrMCwITm+y6DR7mHoobSWEM3apSOiS8pv2SsrG5LjzOOU90SfS7VMQf4MUBo4cHn
	uUNdDeMof8h60oWbFuoIh0zEkZuNBS0jV6S7HOe6agluKIkRRJYaXWfuINJS/aFwJ5RCJ8ghw9j
	Ll52ZK93mHJC8xuABIWNNMZOjp+eJbU/oHmv7rleyUa/+LcjYPakAPVhj3NXb7Np4kNJ0+/x1eU
	4nsAgvavAvqH8cvYxzhlvUvFjApYf23pvEx2LtzJKteZroyxeT73lbh9Ew==
X-Received: by 2002:a05:690c:c501:b0:7b1:fa45:72e3 with SMTP id 00721157ae682-7f7b56466c2mr63363547b3.4.1781340458732;
        Sat, 13 Jun 2026 01:47:38 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f76e8991ccsm20251067b3.16.2026.06.13.01.47.38
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 01:47:38 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7dc2b658544so12143177b3.2
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 01:47:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9baVg9eQUzNLMJmZe5z5ThkayMLqe3zuyiSJjJtsZbcrmDue0fWYb/2i1ZLsthaSliavZic0ffld0=@vger.kernel.org
X-Received: by 2002:a05:690c:8d13:b0:7f8:7e31:28a9 with SMTP id
 00721157ae682-7f87e312c90mr32729197b3.49.1781340457950; Sat, 13 Jun 2026
 01:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612124557.13750-1-email@sirat.me> <20260612124557.13750-4-email@sirat.me>
 <20260612180235.3e505c66@jic23-huawei>
In-Reply-To: <20260612180235.3e505c66@jic23-huawei>
From: Sirat <email@sirat.me>
Date: Sat, 13 Jun 2026 14:47:25 +0600
X-Gmail-Original-Message-ID: <CANn+LWJoSiCY8cTBNZd9w0H-b-D6C7rH2j8QmB57eTKO0g-x_A@mail.gmail.com>
X-Gm-Features: AVVi8CfiNR2HD_SQ5WBiWnwoLYHNxM04uaXSAZAXJUuauVTe4aUCPJODiEkEFXs
Message-ID: <CANn+LWJoSiCY8cTBNZd9w0H-b-D6C7rH2j8QmB57eTKO0g-x_A@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: magnetometer: add driver for QST QMC5883L Sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 11:02=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Fri, 12 Jun 2026 18:45:27 +0600
> Siratul Islam <email@sirat.me> wrote:
>
> > Add driver for the QST QMC5883L 3-Axis Magnetic Sensor
> > connected via i2c.
> >
> > Signed-off-by: Siratul Islam <email@sirat.me>
>
> Trying to avoid repeating stuff Joshua already covered.
> Various comments inline.
>
> Thanks,
>
> Jonathan
>
> > diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetom=
eter/qmc5883l.c
> > new file mode 100644
> > index 000000000000..055e51570635
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/qmc5883l.c
...
> > +#define QMC5883L_OSR_512     FIELD_PREP_CONST(QMC5883L_OSR_MASK, 0x00)
> > +#define QMC5883L_OSR_256     FIELD_PREP_CONST(QMC5883L_OSR_MASK, 0x01)
> > +#define QMC5883L_OSR_128     FIELD_PREP_CONST(QMC5883L_OSR_MASK, 0x02)
> > +#define QMC5883L_OSR_64              FIELD_PREP_CONST(QMC5883L_OSR_MAS=
K, 0x03)
> These are used for matching - normally we'd add defines for the filed val=
ue and
> then use FIELD_GET() to extract it for matching.
> e.g.
> #define QMC5883L_OSR_512                0x0
> #define QMC5883L_OSR_256                0x1
> rather these.
>
I thought using _CONST would be better for compile time checks and not
needing to use FIELD_GET everywhere. The values 0x01, 0x02 don't have
a lot of meaning in a vacuum. But of course you would have more
experience about it and I'd love to know why we shouldn't use const.
> > +
...

> > +static const int qmc5883l_rng_avail[] =3D {
> > +     0, QMC5883L_SCALE_2G,   /* 2G */
>
> I'm not sure the defines really help. Perhaps push the value down here
> and then look it up from this array when matching.
>
But then the array will be serving more than 1 purpose? kind of like a
side effect I think.
>
...
> > +
> > +     /* DRDY pin no used in this version of the driver */
> > +     ret =3D regmap_write(data->regmap, QMC5883L_REG_CTRL2,
> > +                        QMC5883L_INT_DISABLE);
> I don't mind if these sorts of cases go a little over 80 chars as sometim=
es
> it helps readability.
>
I try to disable clang-format for cases like this. It's an oversight on my =
side.
>
> Does it really reset with interrupts on?  That's odd.  Mind you the
> INT_ENB sounds like it would be an enable but as you have named it here
> it is actually a disable so all bets are off when it comes to sensible ;)
>
The datasheet says "The interrupt can be disabled by set 0AH[0] =3D 1"
which I took as it's enabled by default.
I explicitly disable it just to be safe.
>
...
> > +static const struct of_device_id qmc5883l_match[] =3D {
> > +     { .compatible =3D "qstcorp,qmc5883l" },
> > +     { },
>
> As below, no comma.
>
I did it so that clang-format doesn't wrap it all in 1 line. I forgot
to remove the comma before sending the patch. Sorry.
> > +};
>

Thanks
Sirat
