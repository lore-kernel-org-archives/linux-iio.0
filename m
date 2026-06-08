Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060413B14A2
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956124; cv=none; b=FyX/xc3UVnomcwLrjcmwj8UCiMUSVqTrHKN0u7UTJzXH93egRV+iT5+kt5guJB9RKyNDcDzgKABijB92mFxkgiEuE2olyp48YUwOISyxX2G9EyQN+57zMWuFC8A5wOQuNKMQHSyJgGlXfTGGyZauHfcyuVmYQno42tvmCOp0o4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956124; c=relaxed/simple;
	bh=aO4kFWNpehGDtdrzHRertaCSVfudQ0Ged89ZpzBeIng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtBkVGxIUNiAVJnKaWcHe+FHicyIOaRZFoGqoi1dSKgjZ4mFIne78M8QMZRlO5p41FQmzCzj6BNjvAdJwh1DPKggrUX81cKhgInHMqt88ZqjxcnRrbCPScHyzIigu9sIApRIxG2/xMiDYxjvLlVmfh/plCtMmhM+6EMEpZwXGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAGEsw7e; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAGEsw7e"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6cdd78fe6so2569747a34.2
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 15:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780956121; x=1781560921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLteftMqxSBpz8vFkaLokh0cQ8MaetWNL6B6He495r8=;
        b=kAGEsw7e8X7Z7cL+qxt/UsaXovjQ7gJmT87Pe8KVi+N5EcIQQOEwesEAlNPM2Goo1H
         I3l5ZOtIPlinv50YeVCWbczv8EmwBASx6EyCIXi3YmrSi+JpjdAi2Y3t9jtChhVuEF5b
         eZRQOsfoFpbzFLHMx2MhOI/Axc5kK3zTjyl22sr+ub4pDoUkw3s4cBc1OfO/k0Z5OfKa
         /Ra7PJswQrlOkkxTtXL7W7Y7iVVC0DXMg0gpJsyTd1zsx9IgIlU81UWapfGpC1sBqfow
         Yr9KrdjcEX0cukI+GtYghT9PcKGicJnZJahXcM7isa5CWELLuGUbl69SFi1KVWtdharc
         75hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956121; x=1781560921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mLteftMqxSBpz8vFkaLokh0cQ8MaetWNL6B6He495r8=;
        b=da1el04dXisk7jPRZHcnvTT3hDb7J2e4uEv0BHOLlV1Z6e0PGaXKodbTbHIkWLKhDi
         BNbmTqz4gds1XiH55WEVLdwJ8iAYj3lo2OesFcJKUxaagC0wJnv7ApmWDWz72ThbavT8
         Gw0DwSp0EZIsXC3EP2AjOFS0jIr4rFX31FXWD1kVmK/uRuN9f8oxVNf+s+NEhPA8P3UY
         +NMbCzsmhaFQPTjeBohqMnOhj0JPwC50hSTrBBB0st6P7SeOGUft20kM4AvD4/eBsH4P
         Z/HH6dr2NZAw5bOojG+Ex0DwrS4HfI0r6QIhoyxhXh4eQgURKFZoB/X3HpEvVNmxNbCV
         NvIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qiezYE/yjteuOVM21/CFJsfdKxSZcpZGqLP2xhhznix3FVi8LevkN8Oe9ABasGXv7/sRKt/BToXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZrg1bGE0Yz7K1a+m9hzeNUIhPDcz4EP/o5CpRXPxI5f3Z6xF0
	3iUjocI6eQNbPwI9HAB4eK6VQWJOPgAkQNXr3AOOZ+u2gNhm1Q/wiG6H
X-Gm-Gg: Acq92OF+1F1ogEK9GOp2dJW9Y9Pkgcv9+bvVSvaRv2wmeuy39j/+Nto6dWowrRLP1rz
	Me5Kv/f2GhAUSafZc9TPb76vLTjI3MZYiwy1IYcZFHfma+GJmJVD/1op/Nd/KoU0BzhtzqKAQhU
	mgpBJtO8y8LH4dtGOXVBayFkoc9cMMuuve7Y7HNwwp6fUIq1j/MDpLbmAqOHf3eWq8bQPnS25GN
	vuEqrgC35ZZgRSv5QWwSPeEor39AbtqycuE8fHNzoeJToh2NbBnq8QACi8qHSKLmTVQI0Fk7ikO
	bF3JrX4ZZ7MqQSrXIugznNqcoa78IQngmwi0laY/iouY4WZkAGTljuLOB8F6xWPnxdLGPlMrets
	VsaqYgt5LfKIRckHAk247sA6dcIM9dw5ahOLyoRSGKF4cdcNP1mnjFCAqjyVdpVDfskrsCVVjo2
	Hb+So/HX8hQ6z6v6f5wyH247XE8OCi5n20Dcd8ufLLZjfCSAVIWZplJSP2VV6XRHQ=
X-Received: by 2002:a05:6830:7010:b0:7e6:d54e:8fe3 with SMTP id 46e09a7af769-7e70c68cd34mr11040068a34.9.1780956120909;
        Mon, 08 Jun 2026 15:02:00 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e71fe69esm13605574a34.0.2026.06.08.15.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 15:02:00 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:01:58 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Sanjay Chitroda
 <sanjayembeddedse@gmail.com>, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: light: hid-sensor-als: use u32 instead of
 unsigned
Message-ID: <20260608170158.3e3b5512@linuxescape>
In-Reply-To: <20260608194047.23791938@jic23-huawei>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
	<20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
	<CAKqfh0Efa1+VShSW76tqaV8XtAZToRfsCy0cTi5sXOUm_nwLiw@mail.gmail.com>
	<CALoEA-yiDwjkKxUE3B=qiTdBhbvinfq-UN8h1H-HysXGm0prSg@mail.gmail.com>
	<20260608194047.23791938@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 19:40:47 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 8 Jun 2026 08:37:38 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>=20
> > On Sun, 7 Jun 2026 at 22:54, Maxwell Doose <m32285159@gmail.com> wrote:=
 =20
> > >
> > > On Sat, Jun 6, 2026 at 7:19=E2=80=AFAM Sanjay Chitroda
> > > <sanjayembeddedse@gmail.com> wrote:   =20
> > > >
> > > > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > > >
> > > > Prefer 'u32' instead of bare 'unsigned' variable to improve code
> > > > clarity and consistency with kernel style.
> > > >
> > > > Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > > > ---
> > > >  drivers/iio/light/hid-sensor-als.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >   =20
> > >
> > > Do we *need* u32 though? Usually these types are for places where we
> > > require specific bit-widths for a reason (e.g., reading a hardware
> > > register) but I'm not sure that's the case here. I could be totally
> > > wrong, in that case please correct me but otherwise I unfortunately
> > > don't see much value in this. That's just my personal opinion though,
> > > Jonathan may think otherwise.   =20
> >=20
> > Aside from the array of usage ids that are u32 defined here:
> > https://elixir.bootlin.com/linux/v7.1-rc6/source/drivers/iio/light/hid-=
sensor-als.c#L46
> >=20
> > there are additional structs used in the HID drivers that take u32 (I
> > had a similar
> > patch moving `unsigned` to `unsigned int`, but it was recommended to us=
e the
> > types that the structs use, hence u32).
> >  =20
> Here the reason for the change is even simpler. These are callbacks assig=
ned to:
>=20
> struct hid_sensor_hub_callbacks {
> 	struct platform_device *pdev;
> 	int (*suspend)(struct hid_sensor_hub_device *hsdev, void *priv);
> 	int (*resume)(struct hid_sensor_hub_device *hsdev, void *priv);
> 	int (*capture_sample)(struct hid_sensor_hub_device *hsdev,
> 			u32 usage_id, size_t raw_len, char *raw_data,
> 			void *priv);
> 	int (*send_event)(struct hid_sensor_hub_device *hsdev, u32 usage_id,
> 			 void *priv);
> };
>=20
> So given those signatures, these should always have been u32.
>

Ah then perhaps I was a bit harsh on Sanjay.

>
> I would like that clearly stated in the patch descriptions. Consistency
> is a bit too vague.
>

Agree though. But given this

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

--=20
best regards,
max
