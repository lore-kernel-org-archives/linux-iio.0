Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6501277029
	for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2026 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783186231; cv=none; b=uoWFSCEX58L3QDY34JFjaqkevwpz0JMbWShlpZ7arFS9olDgQIHWdYAWQdhOCga3LTL6Tzgrn4jrP/BG7zuXkEAUeFsm5f5h4iVBAvShw23rHV/2qUb6G/5XW2L0Vy1N76UTKdYWijP0kyrE4OH51xsEcYMco32HBsBEumjGtlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783186231; c=relaxed/simple;
	bh=QTFOXL/7uxf5Vhh2+P3ga7eNXu/yhxwvoCw8hBStYkM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=eeh39kMUj74a4tidanb8mwhCHi79K7zrVbig91yeH5giV2ouF3O2Q1cbID6lxKfx8ijdvHZ4eahNCrW1A+/kaBN00lilifdkSzKnZSsJLsz05TOagGybz8AijwQj/xj3Kw53qOkBvOgLvdNgBhSMiIpfrA1dy6RCByS8SGC+UVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TUpm/wbp; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TUpm/wbp"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783186225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njzJqdpKKKXqA0+a5qBHy09jk5HzWBDgE2/TwwrdOYA=;
	b=TUpm/wbpG3Alc1Qo+pQ7NuVKHtgH44+IAwikQGyv0ATrmjWkMJlpyrmKIQ7ZnnRqCpMTl2
	t/UHXts6aUv/w9hV5O3CjlL398fqHeXz1AiEXctEd1sz9geS7tUs1xJm5pLE5i3o+yDoet
	oXgd/xFJOAc9EX4MI0FKuwehQr4dhRw=
Date: Sat, 04 Jul 2026 17:30:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Siratul Islam" <siratul.islam@linux.dev>
Message-ID: <f7aba67831fbee343c105bba4bb531ce6f1c1c50@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Stefan Popa" <stefan.popa@analog.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 "=?utf-8?B?TnVubyBTw6E=?=" <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Ciprian
 Hegbeli" <ciprian.hegbeli@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <akk9d-Zrx52C674x@ashevche-desk.local>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260703102941.1141341-3-stefan.popa@analog.com>
 <9878f042f424bfbd7fab24175298224b58e87779.camel@linux.dev>
 <akj3Ay8mwemRj-9U@ashevche-desk.local> <akkwWxCf10rfThMk@fedora>
 <akk9d-Zrx52C674x@ashevche-desk.local>
X-Migadu-Flow: FLOW_OUT

July 4, 2026 at 11:05 PM, "Andy Shevchenko" <andriy.shevchenko@intel.com =
mailto:andriy.shevchenko@intel.com?to=3D%22Andy%20Shevchenko%22%20%3Candr=
iy.shevchenko%40intel.com%3E > wrote:


>=20
>=20On Sat, Jul 04, 2026 at 10:32:32PM +0600, Siratul Islam wrote:
>=20
>=20>=20
>=20> On 26/07/04 03:05PM, Andy Shevchenko wrote:
> >  On Sat, Jul 04, 2026 at 01:42:39AM +0600, Siratul Islam wrote:
> >  > On Fri, 2026-07-03 at 13:29 +0300, Stefan Popa wrote:
> >=20
>=20...
>=20
...
>=20
> >=20
>=20> > > +static int max40080_get_range(struct max40080_state *st, unsig=
ned int *range)
> >  > > +{
> >  > > + int tmp;
> >  > > +
> >  > > + tmp =3D i2c_smbus_read_word_data(st->client, MAX40080_REG_CFG)=
;
> >  > I think tmp can be initialized, since it is only assigned once.
> >=20=20
>=20>  I don't get this comment. You mean switching to ret?
> >=20=20
>=20>  I meant tmp is assigned only once so the indirection here, i.e.
> >  declaring and assigning in two steps doesn't buy us anything. Instea=
d,
> >  it could be initialized like "int tmp =3D i2c_smbus_read_word_data()=
."
> >=20
>=20Ah, definitely no to this suggestion. It makes code harder to maintai=
n
> and the pattern you proposed is actually discouraged. You can search in
> mail archive and find like ~1-2 year old message from me with the detai=
led
> explanation why.
>=20
Thanks!=20I'll look into it. Learning a lot of stuff. But I'm trying to u=
nderstand where to draw the line though.
Like "struct xxx* data =3D iio_priv(indio_dev);" and "s64 ts =3D iio_get_=
time_ns(indio_dev);" are pretty common.=20
Do=20these calls make a special case for it?
> >=20
>=20> > > + if (tmp < 0)
> >  > > + return tmp;
> >  > > +
> >  > > + *range =3D FIELD_GET(MAX40080_RANGE_MSK, tmp);
> >  > > +
> >  > > + return 0;
> >  > > +}
> >=20
>=20--=20
>=20With Best Regards,
> Andy Shevchenko
>
