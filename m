Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6DE217648
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659251; cv=none; b=d/0+wehrqRYhi2Z2wAaq7U2WLGwadjVjblhJcXSbAkRz2hiKgRTB7W4AczLD7d2zIHgL8ZHEaRJ3xDwxReMxJEFYKJqcQn+GCeHp3wExz44Vzlj+sZrRrR/jju2ZzFgmpj4d7YiXK6vxEXYXYcTp/jf7qiQrIBslUGreP6mQ6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659251; c=relaxed/simple;
	bh=08CBwNSSgBiOal2WtMi393bKTsGkbdSqACFq9WdNEL8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m0I13bSIZ/ba6j+/iQ/KFeB+zIhuSzXl7Fhg3UrYUCsC9id8JWD5bzAo3h4iD9TlBKAw3EZg9z7V+ca3bgLeYpfi7QmBC8kYSm9fFTB6pRY6BPZklqgcKdE/R1gOX7vrFoMIOaSc7HEHGCp6QkkyAeYva32/cHYvDF0RHQOPynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCodYy1Y; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCodYy1Y"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-481188b7760so33556755e9.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 09:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770659250; x=1771264050; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFqSPbMQY4EjZSJSplWP+ILGSKihZ3lOjOFtMZsQEWI=;
        b=VCodYy1YWvSgoZ2RI6BnGJ7e9OcTeuDHG2FTCOA8RsDZR8eY9NPLLhF9IBjox7/Cxk
         ohQSjK4M9WkyljW0ZgAVdn06/88mq0HBns58cnOuFxUGQsr06xamYN0JD8ONYL9MOHqg
         g948dAQUxf2orpoJuIgWSXo/mmIIH+pHCz6IPQuvjlF/loySnLvW0NDhFEQET36lnE9p
         /SMQta1dwdIh2zNk3aMgMmlIm4LZ14pdL9/hSoSK32mYILwgYgA9Xpk7pNUp2qcwfuVM
         LweT19iPhYDWqI7/qtx3vIVQtfn3LdejUbIiyco84YIp98qWczddKb0wS95pPXYKwhz8
         ThDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770659250; x=1771264050;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFqSPbMQY4EjZSJSplWP+ILGSKihZ3lOjOFtMZsQEWI=;
        b=a6UPQcBdAbqETjkYhM4NlRLG6MDmnIF8ARWvVirF2N1fupzbHVEhCNwLW5A8tyGtDV
         vOfdsRTNScr61N5heSnaJsSGdC4q1DrKaVaIE1QI4a9WetZFk9z6vx5EFy7Z6SgpZ9N7
         J8IFxdDuG+lkDXJ0VGrIrBmb6h4p+PVxOVKmajagewT3dD6Bqqm1ngp1PRZu2yQ0A+2/
         jrBp1w1UMj3UB/J1YKp+jJbcWCzrp6DtnalkLoDnrYzqvFHMKjxYcZJ+4kOW1JxwWU62
         +OdcLzSlSTRrJE92YA4++rqLxfgzwGTGPoPV5EF941jvVdqqR4Zcg6gVg7N+aTCcHYaN
         ULeg==
X-Forwarded-Encrypted: i=1; AJvYcCVWrv0ttKkUo7ePxhMFZo9jCQgIzsNUyuSf/X6S7S1GuvGFy+26Q1SwZIGP5Gd5uClWeCJJ0RHuQcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMkuny1QSk0+lYiQMGc9GzbQ8+yoJTNsRANqEmkUCGNl21PatR
	MQmAim+MU0kCv7soP+BIA6FwIWb55QDmH17I76dfsLktEpn+5VxMRIVi
X-Gm-Gg: AZuq6aIoYPfE5o7XeOJ14o8uNJkRZ4vzGC6yQIzXciw5myvZdCYS9IoqvUTZsVNDJBA
	W2qX+s3xJ+OeVbZzc659KphrrpbSo3uPu5QzBwOWL9U4cr8i7CnN5L2/klL3w+Sz7EPxHuWE19H
	Cpcg1tLtdkGrtVeIejCj3v9JU2P5EQAc3BWIC+2c0isFIuPdBBCWQ03F0e126OsR3RsjeSpwpID
	R+ljUfsm5Q6aqF3KRoT/DRFK+kNB92zpoou05lEuZxJ4VF5ZpvxAVzNSznH3a99hcBJxAjX4kUj
	rEl1DKH7y8t+HzOxeFbUat0n/e8NAW4c+XdKrB+1B6fiHsw7L/A3CV69zEm7UW4ZfGTpGl3lBKM
	qdwt1bmF+ophn7w4NQhP8P65EFPdJl63jjPZ9sbl7Acsw6m03qfjFFQn5orMx4HDCBSaM0iS0II
	VopJnOMz2ymSTFPcxzlHk=
X-Received: by 2002:a05:600c:3b99:b0:480:5951:fc1e with SMTP id 5b1f17b1804b1-48320933765mr165570205e9.11.1770659249660;
        Mon, 09 Feb 2026 09:47:29 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320978108sm141792595e9.7.2026.02.09.09.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 09:47:29 -0800 (PST)
Message-ID: <c25fced275d861f89f6885e83b9f9d3abfdc7810.camel@gmail.com>
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
Date: Mon, 09 Feb 2026 17:48:12 +0000
In-Reply-To: <be8457799b32d420228df5e2841c5547023ec515.camel@gmail.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
		 <550323d752213f177b7673bdd42e667f1d2228cb.1770393792.git.antoniu.miclaus@analog.com>
		 <c731b6fba72286707821ea6e7722835ba45f089c.camel@gmail.com>
		 <becd9db1-818f-4aa8-8362-91a711861839@baylibre.com>
	 <be8457799b32d420228df5e2841c5547023ec515.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-09 at 16:47 +0000, Nuno S=C3=A1 wrote:
> On Mon, 2026-02-09 at 09:28 -0600, David Lechner wrote:
> > On 2/8/26 3:24 AM, Nuno S=C3=A1 wrote:
> > > On Fri, 2026-02-06 at 18:07 +0200, Antoniu Miclaus wrote:
> > > > Add a new function to get an IIO backend by its index in the
> > > > io-backends device tree property. This is useful for multi-channel
> > > > devices that have multiple backends, where looking up by index is
> > > > more straightforward than using named backends.
> > > >=20
> > > > The new function directly uses the index to find the backend refere=
nce
> > > > in the io-backends property, avoiding the need for io-backend-names=
.
> > > >=20
> > > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > ---
> > > > =C2=A0drivers/iio/industrialio-backend.c | 51 +++++++++++++++++++++=
+++++++++
> > > > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 ++
> > > > =C2=A02 files changed, 53 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/indus=
trialio-
> > > > backend.c
> > > > index 447b694d6d5f..3b692d48481e 100644
> > > > --- a/drivers/iio/industrialio-backend.c
> > > > +++ b/drivers/iio/industrialio-backend.c
> > > > @@ -1008,6 +1008,57 @@ struct iio_backend *devm_iio_backend_get(str=
uct device *dev,
> > > > const char *name)
> > > > =C2=A0}
> > > > =C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
> > > > =C2=A0
> > > > +static struct iio_backend *
> > > > +__devm_iio_backend_fwnode_get_by_index(struct device *dev,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fwnode_handle *fwn=
ode,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int index)
> > > > +{
> > > > +	struct fwnode_handle *fwnode_back;
> > > > +	struct iio_backend *back;
> > > > +	int ret;
> > > > +
> > > > +	fwnode_back =3D fwnode_find_reference(fwnode, "", index);
> > > > +	if (IS_ERR(fwnode_back))
> > > > +		return dev_err_cast_probe(dev, fwnode_back,
> > > > +					=C2=A0 "Cannot get Firmware reference\n");
> > > > +
> > > > +	guard(mutex)(&iio_back_lock);
> > > > +	list_for_each_entry(back, &iio_back_list, entry) {
> > > > +		if (!device_match_fwnode(back->dev, fwnode_back))
> > > > +			continue;
> > > > +
> > > > +		fwnode_handle_put(fwnode_back);
> > > > +		ret =3D __devm_iio_backend_get(dev, back);
> > > > +		if (ret)
> > > > +			return ERR_PTR(ret);
> > > > +
> > > > +		back->idx =3D index;
> > > > +
> > > > +		return back;
> > > > +	}
> > > > +
> > > > +	fwnode_handle_put(fwnode_back);
> > > > +	return ERR_PTR(-EPROBE_DEFER);
> > > > +}
> > >=20
> > > I believe we don't necessarily need this. Why can't we use io-backend=
-names? I get
> > > that in here we just want something matching the number of channels w=
e have so giving
> > > names is probably does not add much added value. But still, I would p=
refer t have
> > > more simplicity in the API and it should be fairly easy for the front=
end to use the
> > > names argument.
> > >=20
> > > _ Nuno S=C3=A1
> > >=20
> >=20
> > IMHO, using names in this case would just be annoying because we would =
have to
> > sprintf the string to add the index to the string. And also have to spe=
nd time
> > coming up with more complex DT bindings. Using the index seems much sim=
pler.
> >=20
> > If you really feel strongly about it though, maybe we could make a
> > devm_iio_backend_fwnode_get_fmt() function instead that handles the
> > sprintf() part so that we only have to write that once?
> >=20
>=20
> uHu? Maybe I'm completely missing your point but what I had in mind was j=
ust something like:=C2=A0
>=20
>=20
> // from the frontend:
>=20
> static const char * const names[] =3D { "adc1", "adc2" }
>=20
> for (c =3D 0; c < ARRAY_SIZE(names); c++) {
> 	back =3D devm_iio_backend_get(dev, names[c]);
> }
>=20
> So yes, I agree we would have a bit more complex bindings and more comple=
xity in the
> frontend. But on the bright side, no need to change backend code at all. =
And the
> -names property is already used like the above fairly often If I'm not mi=
staken.
>=20
> But again, I can agree that for this usecase getting things by index make=
s sense. Given
> that we just want n backends for n channels, the name does not add much.
>=20

Given Krzysztof's feedback, let's not do the above. So, Antoniu, disregard =
my comments about using
io-backend-name.

- Nuno S=C3=A1
