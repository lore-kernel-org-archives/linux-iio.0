Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F45935AC05;
	Thu, 23 Jul 2026 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784849605; cv=none; b=P7a+fmD9Tq28OeyN58t6icQ8Nq4PnvpRroMHLWs4/ndKLtU2l/IynE1IvspVzwCT6F6hQGaQHF8vymhGTjaG8FDojzYF7zre/elB5QFG/pgoihrjnSs1S1eZXIYI/qFOJkN6cmYk8YbyhSUUdL2dNe6K0plsTEsQediV0UOQHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784849605; c=relaxed/simple;
	bh=dZS9L5bJT61VsgIRXo+CL/gAFFWBhn/SmK6jEL1c4Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwDQDKn+QM2bYeSswEk20g3T1YxDWy7f1mWyFfH0GJ2iDt3qpnah1FnlpNUGqODDX6nCOFqMtLdgJBkhxG0qtQRpj1ajszb4OYW6V9e6FVhHvtP3XVEzZrMTRj+hU90ByGyT7im+a0VKaEUveF1wDCC3oDdDcJpfQBm9LxDabEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP3iGOow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP3iGOow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C141F000E9;
	Thu, 23 Jul 2026 23:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784849604;
	bh=6hOuiVtpOmjud8nVP8D0b7gfS5u51FHiuBzAgZZAgdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OP3iGOowe1R/Iu4O3g4RHbcDWi9KxnEFmrM8A8RX8MRDjCy3SudrUGLazwcti8S8R
	 BDu7O5gTDDtMSxoCpLqI8aMuV1JLLjd2lTnj/mfc+sD1W8OZpd6YAYNNLRLtI8lFhn
	 swEhByHBJVsykKD7+7rYfmShQJJRHmFJ9yKFpYOiEhqgJwOA4nPGydGpCdL5gOF/O7
	 Mt5lilKwZxfJk+0i9q3iF+bq0NEMs5fW+P9QPqBHalUnuPeeNLbcySvVgHtDF+3T/5
	 XZS0YH4N/MzRZIOJFUeZGSACTsoksjeoS+P7/IY97TXZFGWcA0U2vCo+40rHr4aK9m
	 u/8rRKrK/y/ig==
Date: Fri, 24 Jul 2026 00:33:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Siratul Islam <siratul.islam@linux.dev>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Ciprian
 Hegbeli <ciprian.hegbeli@analog.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <20260724003318.26157427@jic23-huawei>
In-Reply-To: <al3-oTXgPQ0eQLF4@nsa>
References: <20260715063652.368501-1-stefan.popa@analog.com>
	<20260715063652.368501-3-stefan.popa@analog.com>
	<gnkthebcxlpbwvbo774hap4mphqro4gxho4zemj6p3ixa2qp7g@ncb5o7tw5wf3>
	<20260718004145.079c5262@jic23-huawei>
	<al3-oTXgPQ0eQLF4@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jul 2026 12:08:16 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, Jul 18, 2026 at 12:41:57AM +0100, Jonathan Cameron wrote:
> > On Wed, 15 Jul 2026 16:23:11 +0200
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > Hi Stefan,
> > >=20
> > > Some comments from me
> > >=20
> > > On Wed, Jul 15, 2026 at 09:36:17AM +0300, Stefan Popa wrote: =20
> > > > The MAX40080 is a bidirectional current-sense amplifier with an
> > > > integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> > > > voltage across an external shunt resistor and the input bus voltage,
> > > > storing the results in an internal FIFO.
> > > >=20
> > > > No existing IIO driver covers this device or a register-compatible =
part.
> > > > The closest relatives target different silicon with incompatible re=
gister
> > > > maps and feature sets: max9611 is a unidirectional high-side sensor=
 with a
> > > > die-temperature channel and MUX-selected gain and no FIFO/PEC, while
> > > > max34408 is an 8-bit multi-channel current monitor. The MAX40080 ha=
s a
> > > > device-specific register map with bidirectional 13-bit current, a 6=
4-entry
> > > > FIFO, PEC, a single-measurement mode triggered by an SMBus Quick Co=
mmand,
> > > > and two selectable input ranges, so it warrants its own driver.
> > > >=20
> > > > Add a direct-mode IIO driver exposing the current and voltage chann=
els
> > > > with raw and scale attributes, a configurable oversampling (digital
> > > > averaging) ratio, and PEC-protected register access. The two select=
able
> > > > current-sense ranges are exposed through scale/scale_available; the
> > > > current scale is derived from the shunt-resistor-micro-ohms device-=
tree
> > > > property.
> > > >=20
> > > > Link: https://www.analog.com/media/en/technical-documentation/data-=
sheets/MAX40080.pdf
> > > >=20
> > > > Co-developed-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> > > > Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> > > > Signed-off-by: Stefan Popa <stefan.popa@analog.com> =20
> >=20
> > A couple of follow ups even though v4 is on list. =20
> >=20
> > That should indicate clearly why you should slow down and let people
> > get to earlier versions.
> >=20
> > Jonathan
> >  =20
> > > > diff --git a/drivers/iio/adc/max40080.c b/drivers/iio/adc/max40080.c
> > > > new file mode 100644
> > > > index 0000000000000..a0c1144cfda7c
> > > > --- /dev/null
> > > > +++ b/drivers/iio/adc/max40080.c
> > > > @@ -0,0 +1,630 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * MAX40080 Digital Current-Sense Amplifier driver
> > > > + *
> > > > + * Copyright 2026 Analog Devices, Inc.
> > > > + */
> > > > +
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/bitops.h>
> > > > +#include <linux/cleanup.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/iopoll.h>
> > > > +#include <linux/math64.h>
> > > > +#include <linux/module.h>   =20
> > >=20
> > > Typically I would say you're missing mod_devicetable.h but now we hav=
e:
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/t=
ree/include/linux/device-id
> > >=20
> > > You might need to base your series on linux-next though. =20
> >=20
> > I merged rc2 into the IIO togreg (and so testing as well) branches to r=
esolve
> > merge conflicts with that series.  Upshot is just don't bother
> > including mod_devicetable.h in any new code.  Also don't worry
> > about including any of the linux/device-id headers unless you don't
> > get them via i2c.h, spi.h etc
> >  =20
> > >  =20
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/pm.h>
> > > > +#include <linux/property.h>
> > > > +#include <linux/time.h>
> > > > +static int max40080_read_iv_once(struct max40080_state *st, u32 *i=
v)
> > > > +{
> > > > +	u8 buf[4];
> > > > +	int ret;
> > > > +
> > > > +	ret =3D i2c_smbus_read_i2c_block_data(st->client, MAX40080_REG_IV,
> > > > +					    sizeof(buf), buf);   =20
> > >=20
> > > It's not clear to me that i2c will use safe buffer all the time (from=
 a
> > > quick look). So I would say to make this DMA safe the usual way we do=
 in
> > > IIO. =20
> >=20
> > I2c always bounces unless you use specific dmasafe functions to indicate
> > that your particular buffer is DMA safe. =20
>=20
> To me it was not clear because of:
>=20
> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/i2c/i2c-core-smb=
us.c#L604
>=20
> In the above case it looks like the buffer is just passed to the
> controller and it won't fallback for the emaluted case where
> i2c_smbus_try_get_dmabuf() seems to be always called.
>=20
> Having said the above and looking (briefly)  at the .smbus_xfer_atomic() =
users, not
> sure it will be such an issue.

I believe it's always been a requirement for i2c controllers to assume
they don't get dma safe buffers.  If they want them (and maybe want to avoid
the penalty of moving something DMA safe) then they should use
i2c_get_dma_safe_msg_buf()=20

Now, it may be that, lots drivers just bounce always because no one updated=
 them for
the optimization.  No idea!

Also possible that this handling is not strictly enforced. Hopefully it is
or a lot of drivers are broken.

Jonathan


>=20
> - Nuno S=C3=A1
> >  =20
> > >  =20
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +	if (ret !=3D sizeof(buf))
> > > > +		return -EIO;
> > > > +
> > > > +	*iv =3D get_unaligned_le32(buf);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +   =20
>=20

