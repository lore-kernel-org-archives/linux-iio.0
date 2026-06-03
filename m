Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD12F8EB7
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478415; cv=none; b=IhaTARI0SInDvBPzZoBA03gwHavaNeDhs0FIjBtCFB4Wx0bduV/FqUKbV++6RqUxooptnN+hNIkw+0wLanpI5bF8dqzvIDmc0P3+msAyRJx8U98eLZfgh76qv9NT9/ZeMhoP6YHObst2y19jNvM1xDCl0wfBfcZSC9MzmYLtdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478415; c=relaxed/simple;
	bh=B8nWa5m+gfh+e74pfi2m8v0AalhEF9irrUG9k6kZBb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyAGoqdy5CpgRo8Lq5C1UvpyFGKbMcFUPL5h6xG/wwolUix91N0L2tUiykK25K28kcdNDDxOfeNjfuZm4KX8EkS+U8Z3tgoJcxmUppubGtinf6PA4SirwcZt2/PLQrRJJKA1u4i1jQA6eVl13e2F/z6izUlYFzSRXENag8XVyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoF2y6zK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoF2y6zK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2931F00893;
	Wed,  3 Jun 2026 09:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780478413;
	bh=h0R/08BeDo7cvhJ6N3qiy8DrX9+ynx75WZDRdAfDTqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IoF2y6zKGuNKpZ96kTn5aOP/Y67jjFbsYQL6yn/rhH9FJFyiAjq4mlJ0Q41X4/sjn
	 WnRMzxQO4SabicuAhl4swaLzPARMmE/dnqLvuEwTPhcghoE8jwavLLue9S2gh86A+T
	 tJq7Q13azUXUEB60/pkvEo2F5CrqkxCbtIuCLZt149RMdNiCQgtATeOz5lLm7rEOHO
	 /m50udUoulEjvWUYlIQy2ptjECzX0aC3cunvr1J3ADroESuNO2nF+xqvlU5xBK5oUf
	 W3qxdb/8w6ItTql7zGXUlvT/Jv/C9LQ1bU3xoohPAsqqZJj5brlmScw6B0J5BxddGW
	 kcXPclMDj6SBQ==
Date: Wed, 3 Jun 2026 10:20:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Sam Moelius <sam.moelius@trailofbits.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, Jonathan Santos <Jonathan.Santos@analog.com>,
 Jorge Marques <jorge.marques@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Matti Vaittinen	 <mazziesaccount@gmail.com>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, Duje =?UTF-8?B?TWloYW5v?=
 =?UTF-8?B?dmnEhw==?=	 <duje@dujemihanovic.xyz>, Stefan Popa
 <stefan.popa@analog.com>, Julien Stephan	 <jstephan@baylibre.com>, "open
 list:IIO SUBSYSTEM AND DRIVERS"	 <linux-iio@vger.kernel.org>, Samuel
 Moelius <samuel.moelius@trailofbits.com>
Subject: Re: [PATCH] iio: adc: ad7380: select REGMAP
Message-ID: <20260603102007.51485e82@jic23-huawei>
In-Reply-To: <dc7f62261b4bf665482ecd791e425bbc68aae515.camel@gmail.com>
References: <20260602153926.1540911-1-sam.moelius@trailofbits.com>
	<dc7f62261b4bf665482ecd791e425bbc68aae515.camel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 02 Jun 2026 17:28:35 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2026-06-02 at 15:39 +0000, Sam Moelius wrote:
> > From: Samuel Moelius <samuel.moelius@trailofbits.com>
> >=20
> > The AD7380 driver uses generic regmap types and APIs. However, its Kcon=
fig entry
> > does not select REGMAP.
> >=20
> > As a result, AD7380 can be enabled from an allnoconfig-derived config w=
ith
> > SPI_MASTER=3Dy while REGMAP remains unset, causing ad7380.o to fail to =
build.
> >=20
> > Fixes: b095217c104b ("iio: adc: ad7380: new driver for AD7380 ADCs")
> >=20
> > Signed-off-by: Samuel Moelius <samuel.moelius@trailofbits.com>
> > --- =20
>=20
> Change looks good but it seems the commit message will fail checkpatch. W=
ith that:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> > =C2=A0drivers/iio/adc/Kconfig | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index a9dedbb8eb46..c79341848698 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -311,6 +311,7 @@ config AD7298
> > =C2=A0config AD7380
> > =C2=A0	tristate "Analog Devices AD7380 ADC driver"
> > =C2=A0	depends on SPI_MASTER
> > +	select REGMAP

Would REGMAP_SPI be the better choice?  I assume either works from
build point of view, but nicer to select all the support this actually need=
s.

> > =C2=A0	select SPI_OFFLOAD
> > =C2=A0	select IIO_BUFFER
> > =C2=A0	select IIO_BUFFER_DMAENGINE =20

