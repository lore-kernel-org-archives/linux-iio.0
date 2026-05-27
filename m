Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE732475CF;
	Wed, 27 May 2026 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900585; cv=none; b=SFArGDuxZh2Ctvbe/F8UqtC8M1JZBQAUW4p41kjY1aNRMykGYdDOEfEyRrHWtvrczLpNi0W6DAvfXTKD+JERqFYnNC503THesW5zBlQTqaXrW2zLkjka/1vPym2rFbYU67MQUuOTyMjqeXHkK4Y4H1M5MOQEoO2+j2vqqAsZadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900585; c=relaxed/simple;
	bh=1tvV81CUmqpLXmG0ia5PoWFydNTpDl8KUJHaUxwveA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1sI3SY7Zp4oQ5Ldk5tslpwAvkdcHkip8rTb9QgleUAN9gbg85yOxMRw9f10yDfltfN0ElxMQ3qfAR2xELVzZEhcidKXb3BzleC/qKIFMulShfEBJzuTDj2tJRv0YydSM9+xDZiML3pU3dwXuC70/tIwXTfMyrOqWqQQaDeFOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZNX2p+V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZNX2p+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035F11F000E9;
	Wed, 27 May 2026 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779900581;
	bh=L3cQfuTHaDnYrAyuoolNcAgiei11PyoBdHqg9uye0MU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QZNX2p+VhHavSEkX4I6s1y805Oc8SRXzZSNRQ+eqAHGcE88dJLAhdzY8vAvFQtPT2
	 pIqF4b8UV+/7Guil8tm0bIiiIEK+FROiHsketj9v8OlPNpWTgb3slhZEHrFd7aIpe5
	 YjUqFU2DKq6tplKYxE96y9cfDf5ipJAy/u5DZVPcBfXyo+WBXU26XwWetDozpdWtSh
	 94ZoWdxHR1kTotesu+z4kNaix1b5RW+obPJwE5ACTA+Hu08uZNvX+/Lb8hl1L5GrkO
	 P2Gs+0Sb1fMLce6qAqiepEEC7mCt1kFEg37zk9/OVx7U9fRrgJ8ERVnZEDPNhoyATo
	 L83u7hULQviqA==
Date: Wed, 27 May 2026 17:49:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Antoniu Miclaus" <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 9/9] iio: temperature: ltc2983: Add support for
 ADT7604
Message-ID: <20260527174931.55eaaa69@jic23-huawei>
In-Reply-To: <20260526084703.133327-1-liviu.stan@analog.com>
References: <20260525164013.118614-10-liviu.stan@analog.com>
	<20260526084703.133327-1-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 May 2026 11:47:01 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> On Mon, 25 May 2026 19:06:14 +0000 sashiko-bot@kernel.org wrote:
>=20
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> >=20
> > Pre-existing issues:
> > - [High] Integer truncation of `num_channels` leads to an out-of-bounds=
 write on the heap when parsing device tree children.
> > --
> >=20
> > commit 482bc8c51e04185002511817885173bd265542d8
> > Author: Liviu Stan <liviu.stan@analog.com>
> >=20
> > iio: temperature: ltc2983: Add support for ADT7604
> >=20
> > This commit adds support for the ADT7604 sensor, repurposing custom RTD
> > and thermistor sensor types as copper trace and leak detectors. It
> > introduces new structs, parser functions, and hardware register mappings
> > to handle these new types.
> >  =20
> > > diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperat=
ure/ltc2983.c
> > > index 130ab7fddc2fe..fc65d8352d120 100644
> > > --- a/drivers/iio/temperature/ltc2983.c
> > > +++ b/drivers/iio/temperature/ltc2983.c =20
> >=20
> > [ ... ]
> >  =20
> > > @@ -1348,7 +1672,7 @@ static int ltc2983_parse_fw(struct ltc2983_data=
 *st)
> > >  	if (!st->sensors)
> > >  		return -ENOMEM;
> > > =20
> > > -	st->iio_channels =3D st->num_channels;
> > > +	st->iio_channels =3D 0; =20
> >=20
> > [Severity: High]
> > This is a pre-existing issue, but does st->num_channels silently trunca=
te
> > the number of child nodes since it is defined as a u8?
> >=20
> > If a device tree is provided with 256 or more child nodes (e.g., 257
> > nodes via DT overlays), device_get_child_node_count() returns 257, but
> > st->num_channels truncates this to 1. This causes devm_kcalloc() to
> > allocate only a 1-element array for st->sensors.
> >=20
> > The device_for_each_child_node_scoped() loop directly following this wi=
ll
> > then iterate over the children and write into st->sensors[chan], result=
ing
> > in out-of-bounds writes on the heap. Could num_channels be changed to an
> > unsigned int to prevent this memory corruption?
> >  =20
> > >  	device_for_each_child_node_scoped(dev, child) {
> > >  		struct ltc2983_sensor sensor; =20
> >=20
> > --=20
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525164013.=
118614-1-liviu.stan@analog.com?part=3D9
> >  =20
>=20
> The hardware has 20 channels maximum, so num_channels as u8 can never ove=
rflow in practice.
>=20
All looks good to me so applied to the testing branch of iio.git.

Thanks,

Jonathan

> Thanks,
> Liviu

