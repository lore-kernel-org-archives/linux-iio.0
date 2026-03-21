Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D2317144;
	Sat, 21 Mar 2026 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774097668; cv=none; b=VewdWXrF7LmvKHIu9aCS7oswJhH8fJKI8iLcbIFe3cKiofnEP6tbM1VmBqYOpoSqzgo25uSn2S/+BXAtNbtWgva1FpzSSAwEiJM+rdRr4g7O9P57IM+d4K8rCJqV1WbghUF5g1FxHReO8hnoVFUy9mRadB1u5gCn92yqH7qTYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774097668; c=relaxed/simple;
	bh=jrLD4Ihw/EhAD6iXD3Cnj5ghSiLBeJJdaG98/dV0WQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKCp77kTUQ4PYS4gmgpaqlpIJXHEJrdDHdTa371QcxRRt69mYHjWSdh21avJA0Ohy4TQ+NyZGRdTYfe3brYrpsvlVyEtYr7SS0tXRiN9FBbdlMfUuKY2ot/N1iWg57P9N36xhPmVwEtKIMUyOFDaDzjho7p+6FiPVeuJhk6iIfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb2/dF86; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb2/dF86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A879AC19421;
	Sat, 21 Mar 2026 12:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774097668;
	bh=jrLD4Ihw/EhAD6iXD3Cnj5ghSiLBeJJdaG98/dV0WQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pb2/dF86I7w2qAf9MBFxWMl46KvXJx4gTfztsemMbjIo8JTYPe0KXal2nuYmhnhqu
	 aleXAIMwlsS1MOm7V0Ps7y7Y0XXbHaOwS/A2jFLohegNfqwgivY/XCFxtfrtUVkNgB
	 Z44vd0MLeAcHvabXBp11/aYR9qgknNhPMIx3ZccexdjsLHbgCUYOEJP2NiTlsW1iBN
	 DpxTiipxPRWxMcBVlF5BiQsS70hvroUg+zpWRb9HgNDpog7UiH5cOBC2ZvmVgwX0B8
	 BKxzV8VPc2Ku7N/bkG4urmjXgcTgo8wyw84N3cHb26svcRyaslhKmuybEL/YZID0nE
	 EC8kotJ5MT3+w==
Date: Sat, 21 Mar 2026 12:54:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Carlos Jones Jr <carlosjr.jones@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Liam Beguin <liambeguin@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Tobias Sperling
 <tobias.sperling@softing.com>, Jorge Marques <jorge.marques@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ltc2309: add support for LTC2305
Message-ID: <20260321125417.5ad7622d@jic23-huawei>
In-Reply-To: <ab1eQ55b_8JiyAGA@ashevche-desk.local>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
	<20260320140819.191700-4-carlosjr.jones@analog.com>
	<ab1eQ55b_8JiyAGA@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Mar 2026 16:48:35 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Mar 20, 2026 at 10:08:19PM +0800, Carlos Jones Jr wrote:
> > The LTC2305 is a 2-channel, 12-bit, fast ADC with an I2C interface,
> > compatible with the LTC2309 (which has 8 channels).
> >=20
> > This patch adds support for the LTC2305 by using the chip_info
> > structure to handle the different channel configurations between the
> > two variants. The LTC2305 exposes 2 single-ended channels and 2
> > differential combinations.
> >=20
> > The LTC2305 requires a 1.6=CE=BCs delay between I2C write and read
> > operations, which is implemented using chip-specific timing to avoid
> > affecting existing LTC2309 functionality. =20
>=20
> ...
>=20
> >  config LTC2309
> > -	tristate "Linear Technology LTC2309 ADC driver"
> > +	tristate "Linear Technology LTC2309 and similar ADC driver"
> >  	depends on I2C
> >  	help
> > -	  Say yes here to build support for Linear Technology LTC2309, a low
> > -	  noise, low power, 8-channel, 12-bit SAR ADC
> > +	  Say yes here to build support for Linear Technology LTC2309 and
> > +	  similar low noise, low power SAR ADCs. =20
>=20
> No, in Kconfig help text (and possibly title above) we have to be crystal
> clear for user what IPs (chips, SoCs, et cetera) are being supported by
> the driver. There is no go for 'and similar'.

One follow up comment is format the resulting description as a list
as it reduces churn in the long run.  e.g. how AD7173 does it.


