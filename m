Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF319995E
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035985; cv=none; b=f4ZYg0qdWmL9hsVXmM9naW8Ug9//Ntl3miC2nbowkQgpqBJs7uMc2jgg+vfsQIUEXAAXjiZiNVfSHRQ/46nl5wC4cHp4o51eFUgB0YRcHFQQG2t3px1FTVlr12x8jcoaXXUyzDu4dAaJoBqaqU846YQ1RftI0MqJ4jkOr43UUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035985; c=relaxed/simple;
	bh=SzpSp+VXA4zWBS9DbIosMysHlaQ8gZEAIvX5KtIuql0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o2MtrtxDVv0utFy7s9qX9rDmX4XAr/iB3YZcjgLLx2bgJpGB2h9g0bxqajDBV8yc9U80VBd2IrIzh0Cq5n52sP8DfEEDul/6+Kqj7WlUXoC7QxltTouGOvQz+/q8HE3XIkVguPCGuMf45eUsnY4TCYcOG51WLkV7qpkzMhmYNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa5Me3WT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa5Me3WT"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so34748765e9.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 04:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770035983; x=1770640783; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U63mIoeeyh89+/QbADYp0nSmnUBKi2a+w9TzrwbveTE=;
        b=Fa5Me3WT3eqEl5quuS6p3j9HY8N5CKR3mMxY874vZYkYH/4w9YshLN639wSFLELVPe
         Aglvsa4D6EswLSAqd79Mx3Lb/r6x+QQKXRYshcu+c/xoV3IqmIDq2/QroGrUMR3LR2vJ
         e1xfrLpKz3I2Is+BXj9qrTb66dfVxtLHd00XMy+pAIRzAIcZ0H3dDSpnxc4AcQaqWmaz
         AuZH8Zvb65IOgsR57PoYOd814vlAd5RaJemNIKLZp5TuS8Aee+iumaWaV29BFlP6yuk9
         1tXi62hYud7dARX5mwi276yaS6OeDfs0QbskR+GI9wUZUAJDXgDb7GC0uKuD9quqWSy4
         PcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770035983; x=1770640783;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U63mIoeeyh89+/QbADYp0nSmnUBKi2a+w9TzrwbveTE=;
        b=P76X+EBCDAEhBdkxiFC92dHOpC471RhA94iALUnjmzYwMYXwm5IZg48Fjj/oxad42B
         4uJHAQvC9Px9fNYCKiEd2BHYt1tSG9t1/Hfbe9tuVu0fWGv/b/hr5C0c4bva3zGnBQDI
         AZo3mhObzgGZBW4JzVuAwme3s/72tFYuCfqFPuHCE3tv0cmpNQdFsRvEeuJZlOcgROQK
         q+m5hl2IYszEk8twkK4bQCPdSUVFCdDc8600PMBgZ09oaohpS2XBTPlX4ib7gL2JmO8m
         gJU1/Y7XO5QLB1jj0/VSZJFScVG8//Nvv1NPgX/SV8S1LKh8pHNDEmDK3ljE78GR49qo
         OCLQ==
X-Gm-Message-State: AOJu0YxIZ4Hp5PzZVadrxv9BnQNEopmvZUDiZrwS3JBnspdNGtLw2GBK
	kOmjkgBHsZRsKShTUQP4HfFrb1ya2ZPpJDiD34t0Ei9xo6XPisp34Vbm
X-Gm-Gg: AZuq6aIXnJFVvCSibO9oiKdRb9Tf5JvthRR48ajWPmRTOIwXd0rwLEp4qroTe6P6xdO
	SQSbmNkBKUmjzYK+qeUZdRxHrvNjoYgeAukIEcAByRlId0u7SqHUpVxivg3vfDWPrKSWyn4JJfa
	EEPv2vLcLXmvuZ+Q6crJ/nJxbM6nOKzJ5uEioLBl3Aq52gTGqbUZThI9t93REdPYHfwtG2Dm6I6
	HEEOHkRU4wfdvrsR3rgJQyQmv122D+sQ2ivdSXdwGlMMqWIdp63j0qPk0ddok8lKm1XHTjocGe4
	P7ss/kqGtUzkJPEvNnilAbsXdiLo7go7qO6SJI2B87zahRhz3R/TemWF7tB0ijjZUhdHo55CdST
	49zFdsxZrKq2++KuQVMkp6KuLufPCZ3myuCnQqCYPsVO6mvv508bKSeQ/4xc6Oh/a0TRko+q40K
	J+L5JkyZxsO2zwg3qgLVw=
X-Received: by 2002:a05:600c:198f:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-482db444e56mr141922565e9.0.1770035982458;
        Mon, 02 Feb 2026 04:39:42 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e490esm43778493f8f.9.2026.02.02.04.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 04:39:42 -0800 (PST)
Message-ID: <177d62446d9c2098bbfe8b0f7fd9418d5afb60fc.camel@gmail.com>
Subject: Re: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, David Lechner
 <dlechner@baylibre.com>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron	 <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Feb 2026 12:40:24 +0000
In-Reply-To: <30cf63eb-50ba-445d-a78b-d6532aacdc8e@vaisala.com>
References: 
	<20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
	 <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
	 <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
	 <812a8c408c2e3a87ebe1ddc983acdc2cebe3b36b.camel@gmail.com>
	 <30cf63eb-50ba-445d-a78b-d6532aacdc8e@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-02 at 13:08 +0200, Tomas Melin wrote:
> Hi,
>=20
> On 02/02/2026 12:28, Nuno S=C3=A1 wrote:
> > On Sat, 2026-01-31 at 14:30 -0600, David Lechner wrote:
>=20
> > >=20
> > > Do we actually need this one? Alternative could be, for example:
> > >=20
> > > int iio_backend_enable(struct iio_backend *back)
> > > {
> > > 	int ret;
> > >=20
> > > 	ret =3D iio_backend_op_call(back, enable);
> > > =09
> > > 	return ret =3D=3D -EOPNOTSUPP ? 0 : ret;
> > > }
> >=20
> > I would prefer not to assume we can ignore the backend not supporting
> > the call. It opens up the question for other operations.
> >=20
> > My preferred way for this kind of fundamental operation (enabling/disab=
ling)
> > would be to check with DT maintainers if we could have some kind of fix=
ed-backend
> > (fixed in the sense the HW is present but not controlled by Linux) dumm=
y device that
> > with implement a no-OP enable/disable().
>=20
> There is also use cases for the always_on cap with a configurable
> non-dummy backend. Some applications are such that the driver should
> leave the enabling/disabling up to the user space consuming the data.
> For this case it's great to have the frontend leave the backend enable
> alone using this capability.
>=20

I would argue the above would be something to take care at the frontend lev=
el. The way
I see it, the always_on cap is pretty much saying that we can't really cont=
rol the on/off state
of the backing device and we just assume it's on.=C2=A0

If we can control it but we need it always on (for some specific usecase), =
I would say that should
be handled at the frontend and just enable the backend once. Also note that=
 as of now, I think all
of the users (or most at least) we have just enable the backend during prob=
e and leave it on until
we unbind the device.

- Nuno S=C3=A1


