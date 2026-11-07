Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794046437;
	b=lT2YR2wFNhWDpZV6Hz3aeSrrzlvVCdoDlDax6W9CjdIx055vIuD4AI9UrqSH0sDZKOgn
	 G0GAXU6qhOakNnIdFNn9Lvhz04MJTvJGl1zDSeoDXTgX2TDRggSZh3D+sCR3mGNeoLXzd
	 otkKHxI3MxPOnglekMoJqilZYxn09tpqnMQwkug7HHFagOu53nXPoKmbwQlSDlnp+ZL0l
	 5ME8CVVjKuHDSMOAualje5rP1hs3b8IvQS1HKkxmqy8SVp3UgeAMjrUwEVoSBv0tpyv5z
	 bnelzeTTbjuFXC8RfRoTQgu9DYyypshyISo/iuamLzmtn+GTqlYI19umWh8LkI3g6cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=k78g5WSNgz938dzM1WkRxWbXOTlco889sZR+tqZe4Xw=;
	b=dJPbl69/I7zGHCWG8vXoOhMy8c63zVz1gDpbjtNjzaFMqp1Ha+7yf6Jf6nwPW2cWGZ5W
	 uLFlCs4OQKn+MNb0gLbidE0j8Uv8KIubZi3VFvLXASI8oYEpEbo9i21dfPd3y6BRlEXVG
	 bWVh4z3R7yBB5Hcti3R78tmDZaqRCEpDDNiXqRbMKgZ+fH9ft8wsp65IFddwaPlQcHW+B
	 fdDK8+QI6ASoRLOKP6ThQXGND1RkeHbp8DegwR+U+u3v1iorfNn0B8KGpTzo2reQix5hs
	 K8WCBiNeswQ5YRqK4Xt+QWjO+zzf17b0BNrBuoFs7SXy4efK3qPm2YZUsroqQDhos7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=STv38oHW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7662606A336
	for <linux-iio@vger.kernel.org>; Sat,  7 Nov 2026 10:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7662606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=STv38oHW
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36fb88ea38cso523977eec.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Nov 2026 02:13:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794046436; cv=none;
        d=google.com; s=arc-20260327;
        b=qHc9xyf0qVYGuGNOMKCxN2nxBL4oVdnGNdW5Be2KSjasixnychpJc+oZJea19RW6og
         gp2BCBeVWVAa+juQD5Hah3V6O9mhHmXhwFw4lP2XfQJGDhnygRCWvpQA1U9ioY32y3CQ
         x/DaEJ60T/MTt26rHHOZth4cQRm8qq2mfis3do9vlOeb3vIIgqGd7fyt9JyTsHFCQ6qh
         wlG0mIvHQ2Y5x79yzgMhnWWFnNwDW5Ft5l9Z0V11tlxMnkl991Y5edn75Jj2Ni682KrA
         qutc3UEBsUUmUBcS8cjZMJSy4Z5bniNnADVmBwjKdGZ5C7SJO+UI4KX3el56fhfoR4I8
         44ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k78g5WSNgz938dzM1WkRxWbXOTlco889sZR+tqZe4Xw=;
        fh=coUoVwhUy75g6yd5nux+0I0h8BmvB9LxkDI/95L8kNo=;
        b=lXe9JAwBAAFQ85U6NhyKtVujKfLcF1wRoX2KNVPk/LWqutrbDpeAQ72eP18CkdNmE5
         UfU+Ha0zmvBjTdzif+omw8GYFR3o+FcCYO2gsOs0Kw+pRNABS4OIHOrkRUC2ynW41pac
         MnDP4uXKS9XwXfN8ZRkrgG06qNNLwo1m5tavNoS+/vZnottXcMuJNnjCMgH9zR3Am79B
         9/kcL01WXzaaVou6gzxYCZ5DbEQqusAz7ubmulTT/mSEimKUHyVEtaAjHmWjIXJjqZnh
         rR5CJB02tJn4/exWnQ8/3lb/qXTqc4ZVfp1yxORQn14glgobu06Szp/QZnnUYgyWiQEe
         3HzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794046436; x=1794651236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k78g5WSNgz938dzM1WkRxWbXOTlco889sZR+tqZe4Xw=;
        b=STv38oHWBm3TrNxUeMnYg5aD1OrKml1+khBJ8SmsZRR+6m3AurmhzGOXu2DAird0k6
         HPwKCvLnRUFUHb3iLp84oDifqjWUfY/0SAnSzzt+0YoN8mI7FqBmgFMsKigLSoZXfOM9
         mzNXbW6tcg+tShKsWPinsMJYrHppnfM5TT7yXjS/Qe0rhZu2YHFK6RTlkX6Jd/cUXiy4
         GrZyIA+tRCF2Nd36U3mG2vNzAstnGIMlELXHcbRqi2NcbJhv6EqoB11eXhU8KsExbJ+V
         5UQPiGoLs5OBS4CcVvhnn1bX2eZ/J45pKw+c/LPIavX+bND7vVM98QM88NsHCSezlQf0
         lIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794046436; x=1794651236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k78g5WSNgz938dzM1WkRxWbXOTlco889sZR+tqZe4Xw=;
        b=0qPokayVSViNSJCNzLXhTaJIlzXqOltmmzi3DTHTsMYoYGmiXhipkFbM22GtR36W2/
         QBMANvPuodNgDG/MYHKEAls/+rGstc2zgsBST9tOj0JL95a/J2JCChLLIY+hbYuWGZXb
         +OxCysM9jZX4dRmTAvjIeumobaVW67ipCoGhrbg8C1d6dG56PsUl0K3oj0g0YTMAEUGo
         +RQnpWzJHO26ZF0CbstKnzuh7seWBriCJ2gApoMpbCTysMlnEz7gH7nEI8wSWrMx+myH
         dWQTKmYMJYJXg44VNUYgHWUDlliH7utNil7zASyLRB0nw5FTKR2YnAf+EpanZdgOxtpM
         DIAg==
X-Forwarded-Encrypted: i=1; AKwUvBzFVPWmkDf7PO013gF0ocUH4h/26qKX7ApKDH+D/dUVQ5FY35slYkCNVYZ97G0uhmJal/GO1BRlCYA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qldDd9Qej5xWWF/LcI7daeDgsurkIWgV+lauQhT4We1hGClxc
	Z+cK7vXX3Zyq72JdklCz8ZyIeoiTe8Ts1Sf0zwdRvQ2gJwwuJEHxqQ/QREHcGGf/gPelXPUvH3R
	HNVWQ7SPhnrHMPx0IBBR/limbPUs2zRc=
X-Gm-Gg: AYBFou2ihDnOGYkmFrmw6bLoqANWY1NsDPMdc0+99v1hbssVmFUdmSb1NrV6vWqeRcO
	vLPXYU4nNXwwFoEIVisyewzdN6lFI+/bFJCvaFomSuBKC4/sCoDn9ngUM62sjVxBHFs0Pq/TeFj
	i/Tn7H9Vl4UWpZ0Q102yaxyVmYI5MgwsnVqz4Ody/ToQmGQv7anYaap2VdBO/tYaQjLXgYIMazb
	l1M2Xj3qxcnBTnLccDTO7BWcr8ndeh10LZQhOpkZIcu+S4lTKABDA3I3qbsWzUKJHOQ3w0BOoqZ
	MQRF/xTYF2FfPw3gElxicl9nkmg/Urer4oWBe4eIR15Kiwf/JgDqFenWIohZ15YXk9wCga7bO6x
	h/UNp7IUfdYwoHvxGL3wCZ7NPaLEJGtRjkexuFy7s0UnD1o6v8yKpSgllmylYv+jupqPnW8z7cf
	/eeKhFz/av2+0Cx0bobtXcK063N4Y/Ww==
X-Received: by 2002:a05:7301:d810:b0:36a:37:1404 with SMTP id
 5a478bee46e88-370f6018313mr2820026eec.13.1794046435857; Sat, 07 Nov 2026
 02:13:55 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106091943.35783-1-clamor95@gmail.com> <20261106091943.35783-3-clamor95@gmail.com>
 <20261107033029.0b2d3ee1@jic23-hlaptop>
In-Reply-To: <20261107033029.0b2d3ee1@jic23-hlaptop>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 7 Nov 2026 12:13:44 +0200
X-Gm-Features: AclHuK-9FSK6jNcHRsjMbOe31zQJwCb0DbuTYhYwvEmeWJ2hyCpsHkhiOXfzBM4
Message-ID: <CAPVz0n250nXs5A4BDY-sXW=eBLAzSn2x9CA-Zf692x6La3rFBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: light: ltr501: Switch to modern match mechanism
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Pan Chuang <panchuang@vivo.com>, Hemanth Selam <hemanth.selam@gmail.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 7 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 05:30=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri,  6 Nov 2026 11:19:41 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Remove the chip enum, break the chip list structure into individual
> > elements, and pass each element using i2c_get_match_data().
>
> Sashiko calls out that for ACPI this results in an ABI change.
> The original code did the ABI wrong but that unfortunately doesn't
> mean we can change this one as it is an artefact of a time when
> we weren't so careful about those names.
>
> So you'll need to put special handling back in for the ACPI parts
> and that name. Some other things in the existing code noted inline
> that would be nice to clean up whilst you are here.
>
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/iio/light/ltr501.c | 165 +++++++++++++++++--------------------
> >  1 file changed, 74 insertions(+), 91 deletions(-)
> >
> > diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> > index cc5d7af44d77c..d5ce6468a229b 100644
> > --- a/drivers/iio/light/ltr501.c
> > +++ b/drivers/iio/light/ltr501.c
>
> > +static const struct ltr501_chip_info ltr301_chip_info_tbl =3D {
> > +     .partid =3D 0x08,
> > +     .als_gain =3D ltr501_als_gain_tbl,
> > +     .als_gain_tbl_size =3D ARRAY_SIZE(ltr501_als_gain_tbl),
> > +     .als_mode_active =3D BIT(0) | BIT(1),
> > +     .als_gain_mask =3D BIT(3),
> > +     .als_gain_shift =3D 3,
> > +     .channels =3D ltr301_channels,
> > +     .no_channels =3D ARRAY_SIZE(ltr301_channels),
> > +};
> > +
> > +static const struct ltr501_chip_info ltr303_chip_info_tbl =3D {
> > +     .partid =3D 0x0A,
> > +     .als_gain =3D ltr559_als_gain_tbl,
> > +     .als_gain_tbl_size =3D ARRAY_SIZE(ltr559_als_gain_tbl),
> > +     .als_mode_active =3D BIT(0),
> > +     .als_gain_mask =3D BIT(2) | BIT(3) | BIT(4),
> > +     .als_gain_shift =3D 2,
> > +     .channels =3D ltr301_channels,
> > +     .no_channels =3D ARRAY_SIZE(ltr301_channels),
> > +};
> > +
> > +static const struct ltr501_chip_info ltr329_chip_info_tbl =3D {
> > +     .partid =3D 0x0A,
> > +     .als_gain =3D ltr559_als_gain_tbl,
> > +     .als_gain_tbl_size =3D ARRAY_SIZE(ltr559_als_gain_tbl),
> > +     .als_mode_active =3D BIT(0),
> > +     .als_gain_mask =3D BIT(2) | BIT(3) | BIT(4),
>
> As below.  Same for all the others.  That would be a separate
> cleanup patch though -> perhaps do it with getting rid of
> the als_gain_shift.
>

This is all out of scope of my series. I am not a code janitor!

> > +     .als_gain_shift =3D 2,
> > +     .no_irq_support =3D true,
> > +     .channels =3D ltr301_channels,
> > +     .no_channels =3D ARRAY_SIZE(ltr301_channels),
> > +};
> > +
> > +static const struct ltr501_chip_info ltr501_chip_info_tbl =3D {
> > +     .partid =3D 0x08,
> > +     .als_gain =3D ltr501_als_gain_tbl,
> > +     .als_gain_tbl_size =3D ARRAY_SIZE(ltr501_als_gain_tbl),
> > +     .ps_gain =3D ltr501_ps_gain_tbl,
> > +     .ps_gain_tbl_size =3D ARRAY_SIZE(ltr501_ps_gain_tbl),
> > +     .als_mode_active =3D BIT(0) | BIT(1),
> As below
> > +     .als_gain_mask =3D BIT(3),
> > +     .als_gain_shift =3D 3,
> > +     .channels =3D ltr501_channels,
> > +     .no_channels =3D ARRAY_SIZE(ltr501_channels),
> > +};
> > +
> > +static const struct ltr501_chip_info ltr559_chip_info_tbl =3D {
> > +     .partid =3D 0x09,
> > +     .als_gain =3D ltr559_als_gain_tbl,
> > +     .als_gain_tbl_size =3D ARRAY_SIZE(ltr559_als_gain_tbl),
> > +     .ps_gain =3D ltr559_ps_gain_tbl,
> > +     .ps_gain_tbl_size =3D ARRAY_SIZE(ltr559_ps_gain_tbl),
> > +     .als_mode_active =3D BIT(0),
> > +     .als_gain_mask =3D BIT(2) | BIT(3) | BIT(4),
> Is it really 3 separate bits, or GENMASK(4, 2) to
> represent a 3 bit shift?
>
> Whilst you are touching the driver can we get rid of the
> separate shift by using field_prep() field_get() using
> just the mask?
>
> > +     .als_gain_shift =3D 2,
> > +     .channels =3D ltr501_channels,
> > +     .no_channels =3D ARRAY_SIZE(ltr501_channels),
> >  };
> >
> >  static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8=
 ps_val)
> > @@ -1393,14 +1387,11 @@ static int ltr501_powerdown(struct ltr501_data =
*data)
> >
> >  static int ltr501_probe(struct i2c_client *client)
> >  {
> > -     const struct i2c_device_id *id =3D i2c_client_get_device_id(clien=
t);
> >       static const char * const regulator_names[] =3D { "vdd", "vddio" =
};
> >       struct ltr501_data *data;
> >       struct iio_dev *indio_dev;
> >       struct regmap *regmap;
> > -     const void *ddata =3D NULL;
> > -     int partid, chip_idx;
> > -     const char *name;
> > +     int partid;
> >       int ret;
> >
> >       indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> > @@ -1480,18 +1471,10 @@ static int ltr501_probe(struct i2c_client *clie=
nt)
> >       if (ret < 0)
> >               return ret;
> >
> > -     if (id) {
> > -             name =3D id->name;
> > -             chip_idx =3D id->driver_data;
> > -     } else {
> > -             name =3D iio_get_acpi_device_name_and_data(&client->dev, =
&ddata);
> > -             chip_idx =3D (intptr_t)ddata;
> > -     }
> > -     if (!name)
> > +     data->chip_info =3D i2c_get_match_data(client);
> > +     if (!data->chip_info)
> >               return -ENODEV;
>
> As above. Unfortunately at this point we'll still need to
> do some special handling to match the existing indio_dev->name.
>

const struct i2c_device_id *id =3D i2c_client_get_device_id(client);

...

indio_dev->name =3D id ? id->name :
iio_get_acpi_device_name_and_data(&client->dev, NULL);

Will this be acceptible?

> >
> > -     data->chip_info =3D &ltr501_chip_info_tbl[chip_idx];
> > -
> >       if ((partid >> 4) !=3D data->chip_info->partid)
> >               return -ENODEV;
> >
> > @@ -1502,7 +1485,7 @@ static int ltr501_probe(struct i2c_client *client=
)
> >       indio_dev->info =3D &ltr501_info;
> >       indio_dev->channels =3D data->chip_info->channels;
> >       indio_dev->num_channels =3D data->chip_info->no_channels;
> > -     indio_dev->name =3D name;
> > +     indio_dev->name =3D client->name;
> >       indio_dev->modes =3D INDIO_DIRECT_MODE;
> >
