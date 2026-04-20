Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A659369985;
	Mon, 20 Apr 2026 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695364; cv=none; b=NEJQYWZ+DS3do9S9KPVAVZPtFoSuIuF6JRpG+qAmLFzMSpVcsj3Ov5eBYDE0IJPdmmCGg8M/1mH71Ypm43svr0HFsJ8oSYvSUhtDh7QYdiK912M4xnmRDDJU2pys1fLx0uV6Bf8sFzG+fZMR32jHapaVsd8w8wPik8aZn1ardR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695364; c=relaxed/simple;
	bh=u6CGPbYIUFBlDeQlxXS9BykZ8po11VxJ9EOIf0MxH8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGtTQiJyS9mqkf0XsPxa07h6dfW0V6UY8OWDBlHEYH6Auj8M9anOWSWvAMAnJonuUUbB+boPbGzTN5vFS4JJUMAvvk4itk89j49mTTkSX1vaO5e1lOZP8/noLopPjw9x+Mto2JfxtMe9wDbBWIMARD7sMmGpu0PDR4lK6bVUxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKmBLDl/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKmBLDl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCEFC19425;
	Mon, 20 Apr 2026 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776695364;
	bh=u6CGPbYIUFBlDeQlxXS9BykZ8po11VxJ9EOIf0MxH8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jKmBLDl/JL0CIZtS0Aig4AtG3f7d3iiY+OBvQswodFGW2rdLw7Xdz1Iy2ol6I10OK
	 0IXr7PcxXPX1Yj+pfcEzLowXgs6GxNcIZEOZjhRcwWZDu5FCBBj9nIOgg1//CCkv8W
	 xXidE012VEeXAOI382+gYvsvZNKUTnU71uN00is0UdPfcq+n2GvcED8N9K/fL3IvDn
	 Rz04Svyv/3uSHiDGJJVgSBL70ppWYLzfey39IIzRzD2soJj/cug6fXt/zYG2N+wYqN
	 FPKyAasHNC2KZCozLweq2vk2SG9uxfYjPL48B7DZaEeWIst1Ok8FsFQAKC54AtWEkB
	 pOuDOU5YdADcQ==
Date: Mon, 20 Apr 2026 15:29:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260420152914.323238fe@jic23-huawei>
In-Reply-To: <SN6SPR01MB0090FF0C73500BB51F63D7FB9B232@SN6SPR01MB0090.namprd03.prod.outlook.com>
References: <20260328114050.46848-1-antoniu.miclaus@analog.com>
	<20260412193349.6a3fea03@jic23-huawei>
	<SN6SPR01MB0090FF0C73500BB51F63D7FB9B232@SN6SPR01MB0090.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Apr 2026 08:51:46 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> --
> Antoniu Micl=C4=83u=C5=9F
>=20
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, April 12, 2026 9:34 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; David Lechner <dlechner@baylibre.com>;
> > Sa, Nuno <Nuno.Sa@analog.com>; Rob Herring <robh@kernel.org>; Krzysztof
> > Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> > Olivier Moysan <olivier.moysan@foss.st.com>; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v8 0/3] iio: adc: ad4080: add support for AD4880 du=
al-
> > channel ADC
> >=20
> > [External]
> >=20
> > On Sat, 28 Mar 2026 13:40:47 +0200
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >  =20
> > > Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> > > integrated fully differential amplifiers (FDA).
> > >
> > > Architecture notes:
> > >
> > > The AD4880 is modeled as a single IIO device rather than two independ=
ent
> > > devices because the channels share power supplies, a voltage referenc=
e,
> > > the CNV conversion clock, and a single interleaved data output stream.
> > > Splitting them into separate IIO devices would make synchronized
> > > dual-channel capture impossible from userspace.
> > >
> > > An MFD approach does not apply here either - the channels are not
> > > functionally distinct sub-devices but identical ADC paths sharing a
> > > common data interface.
> > >
> > > Each channel has fully independent configuration registers accessible
> > > through separate SPI chip selects, so per-channel regmaps are used wi=
th
> > > no locking between them. The data path has no software involvement at
> > > runtime: the CNV clock triggers simultaneous conversions and the devi=
ce
> > > outputs an interleaved bitstream captured directly by the IIO backend
> > > (FPGA). spi_new_ancillary_device() handles the configuration path;
> > > the IIO backend handles the data path.
> > >
> > > The debugfs_reg_access callback is not exposed for the dual-channel
> > > variant since the IIO framework provides a single (reg, val) interface
> > > with no channel parameter, and exposing only one channel would be
> > > misleading.
> > >
> > > The AD4880 is a fairly unique part - having separate SPI config
> > > interfaces per channel with a shared interleaved data output is not
> > > a common pattern. =20
> > I tried applying this and it's not going in cleanly (I didn't check
> > exactly why).  Please could you send a rebased version.  The togreg
> > branch should be fine I think, but maybe sanity check it against
> > my current testing branch as well. =20
>=20
> The AD4880 driver has a cross-tree dependency on two SPI patches that are=
 queued in spi/for-7.1:
>=20
> - ffef4123043c ("spi: allow ancillary devices to share parent's chip sele=
cts")
> - 463279e58811 ("spi: add devm_spi_new_ancillary_device()")
>=20
> The driver uses devm_spi_new_ancillary_device() with multi-CS to create a=
n ancillary SPI device for the second channel's configuration interface, so=
 it won't build against togreg alone.
>=20
> What approach do you suggest in this situation?
Ah.  Makes sense.

Given timing, wait and if I look to have forgotten this ping me around
rc2 when I should have that 7.1 material in my base tree anyway.

thanks,

Jonathan
>=20
> >=20
> > Whilst this driver is making a few more assumptions about the backend
> > than I'd ideally like, I think it is reasonable to postpone any handling
> > for truely separate backends until (maybe) someone needs it.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > >
> > > Changes in v8:
> > >   - Drop fwnode_handle cleanup patch (now in jic23/testing)
> > >   - Clarify backend buffer comment to describe FPGA architecture
> > >     (two axi_ad408x IP instances with a packer block)
> > >   - Make filter_type a per-channel array instead of a single variable
> > >   - Restore debugfs_reg_access for AD4880 (uses channel 0 regmap),
> > >     based on sashiko's review
> > >
> > > Antoniu Miclaus (3):
> > >   iio: backend: add devm_iio_backend_get_by_index()
> > >   dt-bindings: iio: adc: ad4080: add AD4880 support
> > >   iio: adc: ad4080: add support for AD4880 dual-channel ADC
> > >
> > >  .../bindings/iio/adc/adi,ad4080.yaml          |  53 +++-
> > >  drivers/iio/adc/ad4080.c                      | 251 ++++++++++++++--=
--
> > >  drivers/iio/industrialio-backend.c            |  53 ++--
> > >  include/linux/iio/backend.h                   |   1 +
> > >  4 files changed, 282 insertions(+), 76 deletions(-)
> > > =20
>=20

