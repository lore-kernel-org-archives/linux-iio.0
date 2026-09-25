Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F143644C3;
	Fri, 25 Sep 2026 02:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790305139; cv=none; b=tqnYtyG/qla9H42DZgr6VlW0154nSGot1lU1N4aC1pWNF7M8rk64iIhPdzHDRAZK13E7GIhvvePCC/NDKKLRx5BbSFzJHHyL5WVq/Zyj9Za4iEpPXF3moyW8yeU/MeuXJGU1UNNfBv5C9fgpuv3cKaOYl8jn6GhHSwJQ3eL0C1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790305139; c=relaxed/simple;
	bh=RBFCIXmvqlDheP5WIEQLbXuwS9V66DNQrsum6MO7DrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfysffTy4UDVqAYck5e7ZgI0yMXwR+Fnrv60413eaQCFAL/7tkiDnVKEBe7DSCMQAwkdN0A8LxS7+ck6Vdb+/Esv0iZnjJW7d7QzxfSetSk+1PyQoTskm+0WAwnRFHSzCY/dPiuffBW8Jsfosp/HbNOcXrNM9qAQPTLE1XuaVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elXytXMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elXytXMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17731F000FF;
	Fri, 25 Sep 2026 02:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790305137;
	bh=6QbF1KfDJCB9rgve07szBDgH+2dK6JMhCN9I6Z2GaKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=elXytXMmPT11ygAWkIdUyLd4GBGIHgabogKmaqUiw0X2RmcuFe2xsj8S6FMoXZFti
	 t9KjKqRk+KTOc7yzhZEVJDOx3eaEXLICeFvODyMsG7VrI/fw+ukt7s5jslDTZ5pE2p
	 p33qG0gj9f/SuL2fH4lPoDn1G2VM8XooRNUUIprYyUzUFD61x246t4jd0YU4GoXaQl
	 ZO8uA1UAflZNI451XTAd+nl2gdUD5H+9xHt/HXcLo9rvCHc+x7U8afmcLfvFFxFD5x
	 hA18AHwuPNsT4oJayI5Ic8FDSHZ8EQ1apbA9lTXBWGofx07c5PlSsGemQsDBCHE75s
	 wmPalfAD4N6Cw==
Date: Fri, 25 Sep 2026 03:58:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4080: enable address ascension for chip
 identification
Message-ID: <20260925035853.5b0ec67c@jic23-hlaptop>
In-Reply-To: <arKNNx-6RAXbus6R@nsa>
References: <20260922110958.1329-1-antoniu.miclaus@analog.com>
	<arKNNx-6RAXbus6R@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Sep 2026 15:15:19 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Tue, Sep 22, 2026 at 02:09:58PM +0300, Antoniu Miclaus wrote:
> > The two byte bulk read at AD4080_REG_PRODUCT_ID_L expects PRODUCT_ID_L
> > followed by PRODUCT_ID_H. After a software reset the AD408x defaults to
> > descending address mode, so the second byte comes from CHIP_TYPE (0x03)
> > instead. CHIP_TYPE reads 0x07 on all AD408x parts, so an AD4080 reports
> > 0x0750 rather than 0x0050 and every part logs "Unrecognized CHIP_ID".
> >=20
> > Set ADDR_ASC along with SDO_ENABLE before the read. This is the only
> > multi byte transfer in the driver, so no other access is affected.
> >=20
> > Fixes: b66cddc8be72 ("iio: adc: ad4080: fix chip identification")
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > --- =20
>=20
> You could also just use change AD4080_REG_PRODUCT_ID_L to
> AD4080_REG_PRODUCT_ID_H (maybe a slight smaller diff). Nut no strong
> feelings:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the testing branch of iio.git and marked for stable.
I think this one can wait for the merge window. In reality it
is likely so will all the other fixes I currently have on the iio-fixes
branch.

Thanks.

Jonathan

>=20
> >  drivers/iio/adc/ad4080.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> > index 4843ecdd91a8..4ed82aa42400 100644
> > --- a/drivers/iio/adc/ad4080.c
> > +++ b/drivers/iio/adc/ad4080.c
> > @@ -710,7 +710,8 @@ static int ad4080_setup_channel(struct ad4080_state=
 *st, unsigned int ch)
> >  		return ret;
> > =20
> >  	ret =3D regmap_write(st->regmap[ch], AD4080_REG_INTERFACE_CONFIG_A,
> > -			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE);
> > +			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE |
> > +			   AD4080_INTERFACE_CONFIG_A_ADDR_ASC);
> >  	if (ret)
> >  		return ret;
> > =20
> >=20
> > base-commit: dceba8e581e3e8f475da0efbd7a73f3d9524ddd2
> > --=20
> > 2.43.0
> >  =20

