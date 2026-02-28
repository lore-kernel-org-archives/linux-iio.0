Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519F4156F45;
	Sat, 28 Feb 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296107; cv=none; b=bIUTxpqxzH5GF0FYYOBproK0uB1O5/EW8m4BdwAq3qOS5LcQpiXV7rR5fmHTZ7+m5NhF/3KHF4DFaK3Fa2Yw3H3du9ut6WehsyM5PtjV6b1D7/reC9HaXE9GkGdZ3xiIgMkc3KRexGWk8LDfq8LeG+0HLMOE8WoTCmpDDU4c56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296107; c=relaxed/simple;
	bh=EMzCFJtkwaltNHespJat+gi77mi0ddTsGoTWi2RFyZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpKYm9Y7RTkIjbV0WJi4LAzQ3D0+Zku/Iu3OagYX+jV+6Mt0VNv/JEepALSRa4k1r8bMRSbqd+eWpG2ZcKdeIQw7PLB4+DcjtS9YY0zvcvUlZylBSNNtMg3mGI5m3hf8eFBwVg0OOSLjBUDtBHtmDIoAG86D1lqAHFThQA0iwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ3iAEUg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ3iAEUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5F3C116D0;
	Sat, 28 Feb 2026 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772296107;
	bh=EMzCFJtkwaltNHespJat+gi77mi0ddTsGoTWi2RFyZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZ3iAEUgX8AxkHnx3MHkaCyOtibOPYAFGTH9e3QStgVRAhWoPccuR58BLDHdz+yBN
	 WXZi4GRmIEZB5tXNnKm+JXBer/lO2eLjAzm+5j2R9KG+HSy05PcVloxWPNFu6p8Pzc
	 MbGGq0pKyCECGyAIEklt9Yj7Iqbooo3yhXOZPUBYtxPhsMvaaG6W/Mka1dGtkI0Hg/
	 bKRQy+noH2dvnSPa3SYhiVrJ7yV19I5rGVZP1YgI2ihkrHXSNxZkPHlG9t6UbptjQX
	 1PKdZmbnjYUB90MjxbLf02sLXuQvyUKJ5iJhjzXaGEA6f+Kjm4mOHH2RvjEZRbJuVw
	 +QrQ8uoL2FMeg==
Date: Sat, 28 Feb 2026 16:28:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt 
 <marcelo.schmitt1@gmail.com>, Giorgi Tchankvetadze 
 <giorgitchankvetadze1997@gmail.com>, antoniu.miclaus@analog.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iio: adc: ad4030: fix calibscale read/write unit
 mismatch
Message-ID: <20260228162817.3d504e6e@jic23-huawei>
In-Reply-To: <446c20d78f9e990a90bf9d75ee82d056be6bfca8.camel@gmail.com>
References: <20260225113102.84568-2-giorgitchankvetadze1997@gmail.com>
	<aZ7iyJ2CdNB3L6ON@debian-BULLSEYE-live-builder-AMD64>
	<436cefe2-2ccb-41f6-89ec-921e234dfa32@baylibre.com>
	<446c20d78f9e990a90bf9d75ee82d056be6bfca8.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Feb 2026 09:32:45 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2026-02-25 at 09:20 -0600, David Lechner wrote:
> > On 2/25/26 5:53 AM, Marcelo Schmitt wrote: =20
> > > On 02/25, Giorgi Tchankvetadze wrote: =20
> > > > The read path returns calibscale in IIO_VAL_INT_PLUS_NANO but the w=
rite
> > > > path treats it as MICRO. Since no write_raw_get_fmt is provided, the
> > > > IIO core defaults to MICRO when parsing userspace input.
> > > >=20
> > > > This means reading calibscale and writing it back results in a ~100=
0x
> > > > gain error.
> > > >=20
> > > > Change the read path and available range to use MICRO to match the
> > > > write path. =20
> > >=20
> > > The updates to ad4030 driver will add write_raw_get_fmt() [1].
> > > [1]:
> > > https://lore.kernel.org/linux-iio/516cccc47e917bd26be29b016907f50a244=
a68b9.1771865684.git.marcelo.schmitt@analog.com/
> > >=20
> > > At first glance, I think this could instead add a case to write_raw_g=
et_fmt(),
> > > keeping calibscale nano precision (unless nano precision doesn't make=
 sense
> > > for ad4030 calibscale (don't recall from top of my mind)). =20
> >=20
> > Since this is a fix and needs to be backported, it probably make sense
> > to not depend on a patch that is adding new features.
> >  =20
>=20
> +1
>=20
> - Nuno S=C3=A1
>=20
> > I'm sure Jonathan will have an opinion about how he would like to handle
> > a conflict between the fixes and testing branches though.

Fixes in theory always go first.  That'll mean I end up holding the
other series back if this one is ready in the near future.

I'm not sure I fully understand the bug though!

Jonathan
