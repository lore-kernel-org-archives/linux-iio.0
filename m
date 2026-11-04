Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751583;
	b=KbvIL/wA2kOqBwYak3+66qWCdF77aZBiST8xnNJvKQTAlXFhaNl7G1uMSQmrR6MtMaDo
	 TBvjxFgJt6c5DmQffJ/75jQ8XuipfZ+o9qZUz+LLsP11KHobOFZGvxeoqIGNbfAB2u3i9
	 VUVR/jLdnYg+4AtJHSIMs9bSfgyBTW5qrp7v31ZkNDK9jemaFMVkDdXLLsOHzIDHZx0ql
	 WjgtdzXE9Dyga/H5icC8XTVQ2GCfdTDvpoiHNjkuNyagYJ1PB7z9b6XBNClYWd1Qv4um9
	 KkBb8UPaCw4Mse303Howjy/7sFnEEzO3tEKnHbzDQJHbAFkMyE50tfkkQbBDas5MmzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751583;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=0ItBfrW6T5nMzkdXKiGCSfuf/xa8iYQADg+BPBvetAo=;
	b=pV2g7W7apSslTiU8UZJj21p4SylP3AGoRHLSOrtdRPUzAT3Lc0mHuI60de+D1ymqzXsT
	 t8SLiPNmPhQYg4lsG7WigEBrZROmMx0TDblyuB9tSx8rq1ucnAFXh/bCvEgQRj+ilPwJH
	 ndwBq+6lD0KyLkjMCIrRloNRTO+5JRGLu3uftnYGJRDV0IYh1PK/vIaYwFgZqwBflsf3h
	 uTcoQZ0cVpT6lF9tOWKpAW5W9TjcpBjQdEXNvL7q8UYFrjYDvYBh6N1dm6jJ7LVP8zLcP
	 XJTfAZ5EH/L/IuIdVfCeY1cxO3yxnvRAMeW82zKn1OjwPQCLdiG5VcCVTUTneQ3Gifg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=Bw3v76YO;
	arc=none smtp.remote-ip=109.224.244.24
Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch [109.224.244.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED9606A324;
	Wed,  4 Nov 2026 00:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DED9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=Bw3v76YO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1793751580; x=1794010780;
	bh=0ItBfrW6T5nMzkdXKiGCSfuf/xa8iYQADg+BPBvetAo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Bw3v76YOeHVBXomTxUM6r4KQxj9sxxCabXk4DTZ4GJjJlxwMALjZVyRYJr5lXMaBy
	 qn9g+Drfh5D0NaRsPUGsYOX6A5rHIrUCZDljNucwpYmjXW17imU+EUesg3S0PcJ3yK
	 Lt5+JK7i1eLSQcXEXqEK+CLC72oNUS0xNpeqfB0C6xKPWXOX/0Jf5wNbWlu7E+QIUU
	 8YORn1GSGU8N/irpk5orYXH50aOSTPH5VXmG2Zj3lFPpfSxUbRm/1tmdnLt+ytxHzr
	 SO24zDIcvwyUBXbJuKc8uSU9Yn0jGvRotoH+ad5W6OaTxjAVrTwas69uYw9WnNrOzR
	 GwHwE268CkwdA==
Date: Wed, 04 Nov 2026 00:19:33 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] iio: adc: mt6359-auxadc: mask conversion ready bit in mt6358_read_imp
Message-ID: <hAkgxe6jt5EJW-8bHBs53r3CWCxKxjjzGm6u-l-RzYaGedsBunJrv8nOB48zDSLaMD_jJqtC1Xt1wlz0zDdGF28li-clCdIjUzE9xSbh7Hk=@protonmail.com>
In-Reply-To: <20261103234540.46cc8c1b@jic23-hlaptop>
References: <20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com> <20261103-6768-6358-fixes-v1-2-2a868a33152b@protonmail.com> <20261103234540.46cc8c1b@jic23-hlaptop>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: c9cf3f3a78a2e0e449b8377418b2a0c862befc67
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, November 4th, 2026 at 1:45 AM, Jonathan Cameron <jic23@kernel=
.org> wrote:

> On Tue, 03 Nov 2026 18:32:08 +0200
> Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wro=
te:
>=20
> > From: Roman Vivchar <rva333@protonmail.com>
> >
> > In mt6358_read_imp() the raw ADC value is returned directly without
> > masking out ready bit, resulting in incorrect battery voltage reporting=
.
>=20
> Can you add where the ready bit is.  That might help someone
> looking at wrong values and wondering if this is what is causing them.

It's at the end of mt6359_auxadc_read_adc() function, which is included in
the commit message. Do you mean include the code part too?
"*out =3D val & GENMASK(chan->scan_type.realbits - 1, 0);"

> This one is pretty glaring as bugs go (given I think this means the
> top bit is set?) so any reason it wasn't obvious to anyone testing
> this device?

I can't really tell if the driver was properly tested. As far as I understa=
nd,
Chromebook devices use some embedded controller, which likely manages this
kind of stuff without PMIC ADC. There's no in-tree mobile SoCs with mt6357,
6358 or 6359, nor fuel gauge or thermal drivers (yet), so maybe that's why.

> Jonathan
>=20
>=20
> >
> > Apply the mask to strip the ready bit, matching the behavior in
> > mt6359_auxadc_read_adc() function.
> >
> > Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Aux=
iliary ADC")
> > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> > ---
> >  drivers/iio/adc/mt6359-auxadc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-a=
uxadc.c
> > index 951d236f972b..09432d0974cf 100644
> > --- a/drivers/iio/adc/mt6359-auxadc.c
> > +++ b/drivers/iio/adc/mt6359-auxadc.c
> > @@ -502,7 +502,7 @@ static int mt6358_read_imp(struct mt6359_auxadc *ad=
c_dev,
> >  =09mt6358_stop_imp_conv(adc_dev);
> >
> >  =09if (vbat)
> > -=09=09*vbat =3D val_v;
> > +=09=09*vbat =3D val_v & GENMASK(chan->scan_type.realbits - 1, 0);
> >  =09if (ibat)
> >  =09=09*ibat =3D 0;
> >
> >
>=20
>
