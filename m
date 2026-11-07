Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794046220;
	b=QcBjd8pbwN5hNhDFG59t3LSxPIxk//jxLjGkcHImYp4hm3w5prdwB3vttGSnWi1pjlN8
	 /VdYmDJRsxXZ7v9KWjMai+/oMk5fNe4cF/fErMnB9Hg6qCoYjnUQfwxZpksmXAqeZm0JN
	 L+eVbcv577xmyu/7Lj9YJve/g8bl+uj0JX4PZXXdR4NSx678s1VKqwiAuLKanbeHASFiy
	 Ezz1Puzrn6qXLK3xiEtms0NlMT7XDu5wYNssYsCLVTyOz+kIuKWD/KO7jkqPbCXyA4A2+
	 EI5K779wj0KfqIP6b90w/0RmIcN/zKjQRq8RQHlDxSRzaveHilwosi1cPHziAUkQ+Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hCl9zuACLpk26Br6YG5VYwrXg2uXCdyvVsty0gFOsYM=;
	b=BfE9biNRPGWEBX58eWu1m3wzYQle7k5VB2ChrrBVDTu+/hr3erzOGXLFFWH5FbQid9q/
	 WCu3lWmKUYHSkSD+7JD1VhNqp//BHL9uyzhD5A052/iPZLfgeiokiV02l5n3Nd/JjOeCC
	 7oqAma/k0msvQ5M88b61IyWBLNQKjIyuMqrYT6f5zT+ck9Zp2UebFNzQUq8VNb+On30Eu
	 kcGVNjmBqXtYzd/+58JA9IhlybgWvX3yKOfQAed134gJdvbPBauoJtCFXu9Ny6NymSQr4
	 teTC6UjeAPcy/id8S1rMRF8f4HTkQPbZfWCzrfe04UGObkf2Esmqbzq6Vwas/xwy9oA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mqF2/7px";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49C606A32C
	for <linux-iio@vger.kernel.org>; Sat,  7 Nov 2026 10:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E49C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mqF2/7px
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3704d30b84fso1111638eec.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Nov 2026 02:10:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794046218; cv=none;
        d=google.com; s=arc-20260327;
        b=neYmjezKAnRKD87e0lsKNUFEVs2rWi+hRJpm4enaog5w7XY5D0Pdl4UOb6sNmhxoqr
         XwveRfLYkXC4nS7oL+M0Wn2olDAdklzaAhReSzuQwhVdIAOkavOOf8YbubqeCG4biplB
         fldwf9GEd4Q/tCCI8jZB5GiM68Z1Ee6K2gDNqR5WuR7A+0anhTkke3FCdtKygperkjw+
         qU7eQntxBWzpXCSV0X5q9+LvR35ibfySRX/dWCE2CYnCyEwahTkj/H8ze/RnHzz4TRVY
         JTxQofBP+ViZVnewmwfwG/nf16p0u6y0jX37XCtzSfYxIRfzv3whIVt9g75artLNeZf4
         HvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hCl9zuACLpk26Br6YG5VYwrXg2uXCdyvVsty0gFOsYM=;
        fh=GzpQ2iC04hiZ+tC2YTh1CuOiwrJfV9auTAd0mI95lD0=;
        b=SZe/45tu755iNb2sJ3mdFZhKR3prLbHk8+TmkyFP2/guXDghC3d6LaIz0ybAAcS/EC
         RGRG8i9E/ciu7EjWQu9fEuhjzGfwV4CmQuIzUFtGA/DuRV1NNHih1crmrlhA9TpFHiTN
         9jCB0bcbzo/CWWJ38M1jb+lygy+1akykVtn2KyXKFntonqktxr+FK3XKexzpV1s4ecIG
         r+Yvtttx/F2urFDfrnAaXxW9bUZFZXXVCPOVVZWmcR0TB0jt5UhqK0nk22/M/HCemcMf
         7W1njmoC6DUaXUt3EtbmmETdCTeqj91rK+fTgqiWwbTxwC5E9RSvndRAPySoFdDL+26k
         2kXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794046218; x=1794651018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hCl9zuACLpk26Br6YG5VYwrXg2uXCdyvVsty0gFOsYM=;
        b=mqF2/7pxuXrGosqT4DSNgVNPbzJ1NtX5iQs53NhZwR8xxSI+D/6MVM5o9f3tM6ezCj
         HFepsPHsxY5rx7ezV1SRLR0YGB+WJbLgrd7zYAwnJkQNV60XYEX8qaVUMIw+JNYBWSX5
         htJ8T56C5i/RPYPGMmqpVY3yLilgi5V0zbGaDu9QSJ1F+Xv9kwZhW8TMj0Eg+jXr8G2B
         8MB0Jj3py6gnDGYajJ9nwG4vk1rQMTLbMYIFRY7b3p38oXFyHz3uhdh/xRw3TKXc7ke9
         0JT1LcdgMqyFUTgxmTQov5ZeZp86W90n0xUqnqFr+sTiC6RcdYUVMf9MiVyOjvmopNDX
         r6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794046218; x=1794651018;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hCl9zuACLpk26Br6YG5VYwrXg2uXCdyvVsty0gFOsYM=;
        b=wJKv6vhieWO3gpth1Mh31Kw4HQt2Bpwg6HiZdvmpx8DFip2QJcPS81ligjLaW+wvd1
         /iP46K3I43rz2TgEyUAsOdRWWA1NMqL8WeRtMwpHAEy+2C1m9wqtZ9oRcGunjXNN/ee0
         WNOetXJnuICidB6Zfbk6jJVWQL9JSx1fd3xe6UjZiKaRdyc2NkXJdNLcY7PbVqa3BQQp
         2in5AZ35hp6SRYybvERCWf54sx6J+n8ndKs+OMx7c716GnOxAWCqMXRlgN7gmyCJGHos
         yAsK40G/br527GGQZng7EbW2Mjeb4YkVffcfuWWW2WHI98irNtUmnOX+FKh83y2/NcGV
         DXqw==
X-Forwarded-Encrypted: i=1; AL+hErHW6+bEDw48yPGQKHmoY5NkKyCDhBIFEy3FwqdFYfuHe+UgZ9jXe8NIMdCPPcpTtB2YxtemxlxUsuU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dBTPOclsX1wc6pmfUYBxXEjxiRw38NM7WvI572WNpKB+MhAMa
	m51GQHxz7DxqwBnF49rcDMNJMfEze33fKP6xC7aXMKxoDubR32GnYv7QCBEzIIK2Hr1m2nRj1k3
	akjvglAFyfaTSQUxVohqr5Owtyb5Jt0u02xKd
X-Gm-Gg: AYBFou1vbRyov0SEUFi+M68dsbDBJWC8NP/Xl0AUYOwr0n4fFws9L1WE0aF9kxztgty
	cjA5rNvbPeedSukm6NnRLSNX4vKjZA/PB4SsrMQtdFK0Bq7zramkQqyr00JBf9Mw2dOK55GjkuC
	AfpSDpMCj8Jl5uz0Xw/jszM86yUbZ8xfBedKnst4vs09hfvCF9A7vZUbPV52H7yGpdeMYjeenrj
	SQn64EmcHYxUANUVhzt+MdjAqzG+SOWVpY8ciPOf6UfHfy7R/EXkJloY3WXW1A2MfdGG9A0UuIk
	XHiBbBDC0vvA9dI/9gacvjkh4BWBHy6fiCy7v0tiytfsxOr7AL4Ch/62PWDA3VYIkqcIN5pLY/T
	4MQ4hkGyLox1gwuL0xbeGhFS+IOkmMxdnPqgkPRqiuimRrYmjNTir6LajphqH9FK5doAG6pzWdY
	/3/C7kz5Nte1MamHpIEJy61UjkPicHSw==
X-Received: by 2002:a05:7301:da8c:b0:36a:6106:4f63 with SMTP id
 5a478bee46e88-36f74e581c7mr6838802eec.16.1794046217888; Sat, 07 Nov 2026
 02:10:17 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106091943.35783-1-clamor95@gmail.com> <20261106091943.35783-2-clamor95@gmail.com>
 <20261107032042.0dd311fe@jic23-hlaptop>
In-Reply-To: <20261107032042.0dd311fe@jic23-hlaptop>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 7 Nov 2026 12:10:06 +0200
X-Gm-Features: AclHuK9Ans9GsBXt-Xcq71SJaLUNKPLtu1bbEbUNSMYW5pmtGCOH2bEC3JfY9dQ
Message-ID: <CAPVz0n33sktTgdWge64c+XVSDiijXgyY-uRfcpywhJ6LHjPPEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] iio: light: ltr501: Switch to read_avail() op from
 manual attribute registration
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

=D1=81=D0=B1, 7 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 05:20=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri,  6 Nov 2026 11:19:40 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Switch to the read_avail() operation from manual attribute group
> > registration. This eliminates the need for per-chip attribute_group
> > structures and related ltr501_chip_info iio_info entries.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Given you were quick off the mark on sashiko on v1, I guess
> you already saw:
> https://sashiko.dev/#/patchset/20261106091943.35783-1-clamor95%40gmail.co=
m
>
> It seems correct that you'll only get one attribute where there were two
> before.  I suspect it's as simple as the mask should be set of
> shared_by_type_available not shared_by_all for scale and shared_by_all
> for only sampling frequency and integration time.
>
> The current code is odd in having per type sampling_freq and integration
> time as both apply to the light channel as well I think.  Not vital
> to fix that though so I'd just split the mask to make it work for both
> as it does today.
>

-       .info_mask_shared_by_all_available =3D (_shared), \
+       .info_mask_shared_by_type_available =3D (_avail_type), \
+       .info_mask_shared_by_all_available =3D (_avail_all), \
...

 static const struct iio_chan_spec ltr501_channels[] =3D {
        LTR501_LIGHT_CHANNEL(),
-       LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0=
,
+       LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0,
IIO_MOD_LIGHT_BOTH, 0, 0, 0,
                                 ltr501_als_event_spec,
                                 ARRAY_SIZE(ltr501_als_event_spec)),
        LTR501_INTENSITY_CHANNEL(1, LTR501_ALS_DATA1, IIO_MOD_LIGHT_IR,
                                 BIT(IIO_CHAN_INFO_SCALE) |
                                 BIT(IIO_CHAN_INFO_INT_TIME) |
                                 BIT(IIO_CHAN_INFO_SAMP_FREQ),
-                                NULL, 0),
+                                BIT(IIO_CHAN_INFO_SCALE),
+                                BIT(IIO_CHAN_INFO_INT_TIME) |
+                                BIT(IIO_CHAN_INFO_SAMP_FREQ), NULL, 0),
        {
                .type =3D IIO_PROXIMITY,
                .address =3D LTR501_PS_DATA,
                .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
                        BIT(IIO_CHAN_INFO_SCALE),
+               .info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
                .scan_index =3D 2,
                .scan_type =3D {

IIO_CHAN_INFO_SCALE is by type and IIO_CHAN_INFO_INT_TIME and
IIO_CHAN_INFO_SAMP_FREQ by all

> The current way the two Intensity channels is done is very odd.
> The .info_mask_shared_by_type should be the same for both of them
> (only one set of attrs will be created).
> Ideally fix that as a precursor patch (don't label it as a fix
> though as it's just a code consistency thing rather than actually
> resulting in a change.)
>

No more precursor patches! I am just a random contributor, not a
driver author, not a subsystem maintainer, not even a random code
janitor. Stop using me for random unrelated fixes!

>
> > ---
> >  drivers/iio/light/ltr501.c | 153 +++++++++++++------------------------
> >  1 file changed, 52 insertions(+), 101 deletions(-)
> >
>
> >  static const struct iio_info ltr501_info =3D {
> >       .read_raw =3D ltr501_read_raw,
> >       .write_raw =3D ltr501_write_raw,
> > -     .attrs =3D &ltr501_attribute_group,
> > -     .read_event_value       =3D &ltr501_read_event,
> > -     .write_event_value      =3D &ltr501_write_event,
> > -     .read_event_config      =3D &ltr501_read_event_config,
> > -     .write_event_config     =3D &ltr501_write_event_config,
> > -};
> > -
> > -static const struct iio_info ltr301_info_no_irq =3D {
> > -     .read_raw =3D ltr501_read_raw,
> > -     .write_raw =3D ltr501_write_raw,
> > -     .attrs =3D &ltr301_attribute_group,
> > -};
> > -
> > -static const struct iio_info ltr301_info =3D {
> > -     .read_raw =3D ltr501_read_raw,
> > -     .write_raw =3D ltr501_write_raw,
> > -     .attrs =3D &ltr301_attribute_group,
> > -     .read_event_value       =3D &ltr501_read_event,
> > -     .write_event_value      =3D &ltr501_write_event,
> > -     .read_event_config      =3D &ltr501_read_event_config,
> > -     .write_event_config     =3D &ltr501_write_event_config,
> > +     .read_avail =3D ltr501_read_avail,
> > +     .read_event_value =3D &ltr501_read_event,
> > +     .write_event_value =3D &ltr501_write_event,
> > +     .read_event_config =3D &ltr501_read_event_config,
> > +     .write_event_config =3D &ltr501_write_event_config,
>
> I'd prefer a precursor patch tidying up the indent as that should make
> the diff on this patch easier to read.
>

NO, either this, or I can drop alignment adjustment and you can fix it
on your own whenever you like.

>
> >  };
>
