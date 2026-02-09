Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04653859CF
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655586; cv=none; b=V43j/ykIFOaHCHjB6Dfq4WhohwM7ZoV51qxh3Og6MaTWuG0mmPJYrxqa1b1mc6qz+SJw5KbJbpn1eRw3txgaNNycPTIqxhbs+XIXMCpPBpn4HtC2it3x/pIrteB5w5SdDWk4ol27HPF1XBL/0VWqRFti1pZUBB9xaEE5gfgBEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655586; c=relaxed/simple;
	bh=CwohizHSnVaA2NNgNrCByNQlZ1oJaWWA0GxEuHaseKg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ea5g4bI41N/5JrmC94h7aAixrChk0L0s5gDYSZAdVE2F4+OIUMHJ6jjWt8gCyUK9UAvDuRY+BVoS8HzNy5XDZb1v0GuS4nB4IAIK5hlHbW8GPGbpMJxIPnPq8Y9P4Z8puWlWV7I88lGt/o/c59LX4Dm5QiA9RS0ZldHja8cygC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtyEMc4G; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtyEMc4G"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so47160315e9.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 08:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770655584; x=1771260384; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLb8ag3ra6IO++ksPTcs7qsE4fbhw6boR1CyaCV8y8M=;
        b=CtyEMc4GwyVBEzvrQEIciduy2i4+EtGAxYgjt3wFjCosVAoyBNl7oOKNDjIz9W3sT7
         84syF377CGo9ImIx2b9ZGlR0qZ/wIsbxCHqENnSUfjviyYRz6wb5nE7mgS3ZdafYH0hw
         b4D0E1IbYYVS8y9XAYyKMDuKhHAx/y6yYFL73FJbDPOZuXq0ztVG4OoG7zG+Lr8hOfa0
         iKubVufqn/GVW7UuRmuR5Ry+bJ0NyuZQnzgREWMmzepaNbBZV5zXGddC3+uzz7TVSOgc
         2ZTlXC+1EBoh1THLXy9T+l+m+w/102Mjkj6HfGrORZA2qt0FtOoTzaL/vifxxdBH2Fdv
         1IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770655584; x=1771260384;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLb8ag3ra6IO++ksPTcs7qsE4fbhw6boR1CyaCV8y8M=;
        b=O1Z6CNUDzOS1wo0k6ZK/jm/u/C/yrkOVAnOiePK9FXPeCEODYnlO8vqAMuuhOuGHdE
         isggwRtnSnb7ktRtHtpdcWHPraQKOlggN5jxuRDV5XM8pSfZbyFLv7PdMXF4kj4xMNC3
         fG82Oze66ZbVkFRRQb0PhI8FrAlYWDwAia/hsPZYlE3Yk69kkBDkDyG+V6sqDwV1tO12
         Uv0+1uurhOmnV9M8ZIUPP88+60onyWxwW7mdH9Tuuda3+2gc8fpHsSzVG9eSkd6PHqb0
         J4mf7j2iL9ZEMaA14v4VARdCThFdLBI7ygXWM196AQ3nf72OjUQl0Egy7ufDI+Y15T/B
         8huw==
X-Forwarded-Encrypted: i=1; AJvYcCVfdSxP9UebonWOaQ9BhEv0vOdpdh8G3EkP3ZF3Siovf4quDNfesnGuslKuR2y0uCUjNeqRhPIVO1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6dTYFTwvOqCm77Gky1clV5dg3GTiUE9vv/OHCdl+tTnhtLpn
	dJ59i1Wc/5oiQzDPHFv38ypk3dwv5IfUkl7YJFqWTa46KfHuKvk+GAel
X-Gm-Gg: AZuq6aIB7qwGvut4+FRW84ZdhiClsmSO4eLEVFSXeu5m3JoPC6ZnvuuCIGrTTHCr08F
	D4DmzAljTJXq+//jIf/RsxLLSTw/iydfO5rMhrLdivURiieA5JJuvGfU+/toGuCXRznlHg88y1w
	V+vA+dGVi2Ga+CpREvKZ7nJTP/QZHlvYWX57+rgryauUG9Rr88sRZLKc2xXCdZZSFuehOEwLxDP
	hJYsCBYpTm8iEEcypISryqcuX/x+9bpR+9e1OgjY3Nq4CRgs1zayTceRmHNLg6iR74wi5M9HX44
	39v2qEz0wX952Uzf77ywxkMxJyZBMeeUxC3MBu2Z5WDdiwWLLDVFJMH2Rfpqd6IzbvOS812brkX
	ZOUYUcVR8Vt2mYGvtq6YlfNdR9iLhjLBDSEFoppHpRYo9wgYLaF9Nyrz62otlOAuDJlP6N7g+7V
	JSe+G4uS7oFERYnFkixULs4B1KR80q9O4=
X-Received: by 2002:a05:600c:45cb:b0:477:8985:4036 with SMTP id 5b1f17b1804b1-483201dd216mr157441135e9.1.1770655584079;
        Mon, 09 Feb 2026 08:46:24 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d78cfsm1924275e9.1.2026.02.09.08.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 08:46:23 -0800 (PST)
Message-ID: <be8457799b32d420228df5e2841c5547023ec515.camel@gmail.com>
Subject: Re: [PATCH v2 2/4] iio: backend: add devm_iio_backend_get_by_index()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Mark Brown	
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Date: Mon, 09 Feb 2026 16:47:06 +0000
In-Reply-To: <becd9db1-818f-4aa8-8362-91a711861839@baylibre.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
	 <550323d752213f177b7673bdd42e667f1d2228cb.1770393792.git.antoniu.miclaus@analog.com>
	 <c731b6fba72286707821ea6e7722835ba45f089c.camel@gmail.com>
	 <becd9db1-818f-4aa8-8362-91a711861839@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-09 at 09:28 -0600, David Lechner wrote:
> On 2/8/26 3:24 AM, Nuno S=C3=A1 wrote:
> > On Fri, 2026-02-06 at 18:07 +0200, Antoniu Miclaus wrote:
> > > Add a new function to get an IIO backend by its index in the
> > > io-backends device tree property. This is useful for multi-channel
> > > devices that have multiple backends, where looking up by index is
> > > more straightforward than using named backends.
> > >=20
> > > The new function directly uses the index to find the backend referenc=
e
> > > in the io-backends property, avoiding the need for io-backend-names.
> > >=20
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > > =C2=A0drivers/iio/industrialio-backend.c | 51 +++++++++++++++++++++++=
+++++++
> > > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 ++
> > > =C2=A02 files changed, 53 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industr=
ialio-
> > > backend.c
> > > index 447b694d6d5f..3b692d48481e 100644
> > > --- a/drivers/iio/industrialio-backend.c
> > > +++ b/drivers/iio/industrialio-backend.c
> > > @@ -1008,6 +1008,57 @@ struct iio_backend *devm_iio_backend_get(struc=
t device *dev,
> > > const char *name)
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
> > > =C2=A0
> > > +static struct iio_backend *
> > > +__devm_iio_backend_fwnode_get_by_index(struct device *dev,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fwnode_handle *fwnod=
e,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int index)
> > > +{
> > > +	struct fwnode_handle *fwnode_back;
> > > +	struct iio_backend *back;
> > > +	int ret;
> > > +
> > > +	fwnode_back =3D fwnode_find_reference(fwnode, "io-backends", index)=
;
> > > +	if (IS_ERR(fwnode_back))
> > > +		return dev_err_cast_probe(dev, fwnode_back,
> > > +					=C2=A0 "Cannot get Firmware reference\n");
> > > +
> > > +	guard(mutex)(&iio_back_lock);
> > > +	list_for_each_entry(back, &iio_back_list, entry) {
> > > +		if (!device_match_fwnode(back->dev, fwnode_back))
> > > +			continue;
> > > +
> > > +		fwnode_handle_put(fwnode_back);
> > > +		ret =3D __devm_iio_backend_get(dev, back);
> > > +		if (ret)
> > > +			return ERR_PTR(ret);
> > > +
> > > +		back->idx =3D index;
> > > +
> > > +		return back;
> > > +	}
> > > +
> > > +	fwnode_handle_put(fwnode_back);
> > > +	return ERR_PTR(-EPROBE_DEFER);
> > > +}
> >=20
> > I believe we don't necessarily need this. Why can't we use io-backend-n=
ames? I get
> > that in here we just want something matching the number of channels we =
have so giving
> > names is probably does not add much added value. But still, I would pre=
fer t have
> > more simplicity in the API and it should be fairly easy for the fronten=
d to use the
> > names argument.
> >=20
> > _ Nuno S=C3=A1
> >=20
>=20
> IMHO, using names in this case would just be annoying because we would ha=
ve to
> sprintf the string to add the index to the string. And also have to spend=
 time
> coming up with more complex DT bindings. Using the index seems much simpl=
er.
>=20
> If you really feel strongly about it though, maybe we could make a
> devm_iio_backend_fwnode_get_fmt() function instead that handles the
> sprintf() part so that we only have to write that once?
>=20

uHu? Maybe I'm completely missing your point but what I had in mind was jus=
t something like:=C2=A0


// from the frontend:

static const char * const names[] =3D { "adc1", "adc2" }

for (c =3D 0; c < ARRAY_SIZE(names); c++) {
	back =3D devm_iio_backend_get(dev, names[c]);
}

So yes, I agree we would have a bit more complex bindings and more complexi=
ty in the
frontend. But on the bright side, no need to change backend code at all. An=
d the
-names property is already used like the above fairly often If I'm not mist=
aken.

But again, I can agree that for this usecase getting things by index makes =
sense. Given
that we just want n backends for n channels, the name does not add much.

- Nuno S=C3=A1
