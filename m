Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C011E1DE5;
	Sun, 26 Jul 2026 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785059969; cv=none; b=pAvajMB7gHwxMGJjnvKxN1vSHUS0TP+jXuxLADoLA7O85Kc24yj8n8+cjIpChx2SJm/DHSl+tLMayLZ5YWoi8yR8+ZvKo3F/k5zlxi9cR1iWeLajbScE4i91sb9gmA5TegWzK2Asyhr7WciBEmvXBst7KLjgGXLB0s9Brysa8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785059969; c=relaxed/simple;
	bh=tvcKytaHRkT6941rbzRwqc1wJE8yqzbnu0SBrJTW1Ko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ikcYMx5TJ/jTBbJN8Kq4xeAhNj2MNJyno9K8g8Qoo8UsfwItege/bkZirQosJJ8QgxKBNuU4Qpex+3ImjpjMjyuUaRJOTxexN92UT+VsX0eHI54vfjC9b/HUdAlZs4ruJdvh/tYrNTTXafkgLrGH3dM4syM5gmgz9crUlnYYMb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+V6Eltj; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+V6Eltj"
Message-ID: <196a781d5ff487fb890abc8c3ed2ae07f8614b38.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785059964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvcKytaHRkT6941rbzRwqc1wJE8yqzbnu0SBrJTW1Ko=;
	b=A+V6Eltj9T2DU0S7tdXl/SLh6KWvh2o0KMHm2G1VfJvy/IOciOw8K3yxR2SECGNHLk51Wu
	C6RNgRdfTLyKJjhigPGGToPbtX0xURTvIWm1d/ldLB4EdDpFpqjLGcgpN9X/JhpLQMIgyN
	MtqztQ1ydGkhcMvGG6VShFJlSlbUyCU=
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: add maxim,max40080
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, 	dlechner@baylibre.com, ciprian.hegbeli@analog.com,
 u.kleine-koenig@baylibre.com
Date: Sun, 26 Jul 2026 15:59:09 +0600
In-Reply-To: <20260726003152.1d9f36d5@jic23-huawei>
References: <20260723065036.2683075-1-stefan.popa@analog.com>
		<20260723065036.2683075-2-stefan.popa@analog.com>
		<a79b2fd8d08d4594bbb472b005534d7c91d86e49.camel@linux.dev>
	 <20260726003152.1d9f36d5@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Sun, 2026-07-26 at 00:31 +0100, Jonathan Cameron wrote:
> On Thu, 23 Jul 2026 22:23:39 +0600
> Siratul Islam <siratul.islam@linux.dev> wrote:
>=20
> > On Thu, 2026-07-23 at 09:50 +0300, Stefan Popa wrote:
> > > Add device tree bindings for the Maxim MAX40080 bidirectional
> > > current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.
> > >=20
> > > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > > ---
> > > =C2=A0=20
> > ...
> > > +
> > > +title: Maxim MAX40080 bidirectional current-sense amplifier
> > > +
> > > +maintainers:
> > > +=C2=A0 - Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> > > +=C2=A0 - Stefan Popa <stefan.popa@analog.com>
> > > +
> > > +description: |
> > > +=C2=A0 The MAX40080 is a high-precision, bidirectional current-sense=
 amplifier with
> > > +=C2=A0 an integrated 12-bit ADC and an I2C/SMBus interface. It measu=
res the voltage
> > > +=C2=A0 across an external shunt resistor and the input bus voltage, =
and stores the
> > > +=C2=A0 results in an internal FIFO.
> > > +
> > > +=C2=A0 Datasheet:
> > > +=C2=A0=C2=A0=C2=A0 https://www.analog.com/en/products/max40080.html=
=C2=A0=20
> > This URL links to a product page rather than a datasheet as the tag sug=
gests.
> > Would be difficult to fetch using CLI tools.
> > Were you supposed to use something like
> > "https://www.analog.com/media/en/technical-documentation/data-sheets/MA=
X40080.pdf"?
>=20
> I think the argument for using product pages is that they are stable and =
datasheet
> paths sometimes change.
>=20
> For ADI there is a neater form as well that is supposed to be stable (and
> has been for last few years at least)
> https://www.analog.com/max40080
> Works for any product and takes you to the equilvalent product page to th=
e
> link above.
>=20
> So whilst you make a good point I think we will have to let Analog decide
> on a standard way to link to their product info / datasheets.=C2=A0 That =
is
> on the perhaps optimistic basis they have more insight into stable choice=
s
> than we do!
>=20
I was just nitpicking because it said "Datasheet" to point to a link which =
was not a=20
datasheet.

But yes, a standard way to link all their products (like https://www.analog=
.com/max40080)
makes more=C2=A0sense. I just checked and currently some adi devices use pr=
oduct page links,
some use PDF links and some don't include any links at all.
> >=20
> > > +
> > > =C2=A0=20
> > ...
...
> > >=20
> >=20
--
Best regards,
Sirat
