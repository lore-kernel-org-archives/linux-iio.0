Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B823093D3;
	Sun,  2 Aug 2026 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785697513; cv=none; b=AGsRg/XXrT9809v9V75/GF3HL2Rzzb3FZIXgCZ89kcmRYjg2eM0kOxyNUEGuQCk4a5R/zwH5sqMu2WXZLNs8p6INE3pRhbHcE4e8tNpSRPL/M3hrrltNc3ifj5hNDbnRV/Z9CBqI/6uqSInzL5cQgFq9zjqrG7fe4/ZHR1hhO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785697513; c=relaxed/simple;
	bh=w67aoVsBn/Vqw2lcENpnqIFmssJmTYIR/Ch57P92ioc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5FwoufU6QzmpIi0W5qzkXfmKQ9D3HSfnTNElMjj+OhN32W2ZFXBYpb7sDCitU7wKQoF2KOTMu+1VTdRDYgOisRfhWSOQB5fOkLX2GXg50N20gJHZjrJoZ1GGXgJDuotC4mTA9tjgI7EfzZk3lK6bAHdaGUGsNnJ0cobN1Ivxrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1spDSRf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1spDSRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE6C1F000E9;
	Sun,  2 Aug 2026 19:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785697511;
	bh=3W8VYnHpKJP0B2AFARzuxHuP2Of/uzZg0uo8Zhf5Tjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F1spDSRf6OqTvyL4gfrex16jQsgj6bt0jyse+q033U7z+EwjjAl1Yh6K8SJRh63Zk
	 vx5s/ZMbocCjSum0vvl4mSK5uXoGcrEpVSQrk91cbg8JGmzWoAmxUKfc8uu2pufBCo
	 5spBb7f1VTqPZhfT0MyKx7Z5GS7ne5Mrc+kEkkBALh4+aXXoBICDRwvhKFk0vjcuHg
	 HROob0pd01/cZqmHNNiluyB7drMB67W0ovDQfSM/OBnjf/g+acZfiT7NEjG/9lttkw
	 7lm1YIfIRV6qaqYPBKvo6kEM3NG6n0720HP48Pv8AYTDe3f/28bJsl31joWXf6LBkk
	 6tBHpBBXexzBg==
Date: Sun, 2 Aug 2026 20:05:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukas Metz <lukas.metz@gmx.net>, Siratul Islam
 <siratul.islam@linux.dev>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <20260802200504.06e1f94c@jic23-huawei>
In-Reply-To: <50fee508-db53-46c3-b245-22893023f370@baylibre.com>
References: <20260802-dac8163-work-v3-0-3ecc7bc66d0d@gmx.net>
	<20260802-dac8163-work-v3-2-3ecc7bc66d0d@gmx.net>
	<50fee508-db53-46c3-b245-22893023f370@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Aug 2026 12:19:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/2/26 11:07 AM, Lukas Metz wrote:
> > The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-output,
> > dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
> > respectively. These devices include a 2.5-V, 4-ppm/=C2=B0C internal
> > reference, giving a full-scale output voltage range of 2.5 V or 5 V.
> >=20
> > Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
> > ---
> >  MAINTAINERS                  |   1 +
> >  drivers/iio/dac/Kconfig      |  16 ++
> >  drivers/iio/dac/Makefile     |   1 +
> >  drivers/iio/dac/ti-dac8163.c | 449 +++++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 467 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 314f235332f5..5512f5eaab44 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -26399,6 +26399,7 @@ M:	Lukas Metz <lukas.metz@gmx.net>
> >  L:	linux-iio@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> > +F:	drivers/iio/dac/ti-dac8163.c
> > =20
> >  TI DATA TRANSFORM AND HASHING ENGINE (DTHE) V2 CRYPTO DRIVER
> >  M:	T Pratham <t-pratham@ti.com>
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > index db9f5c711b3d..aa80b871995b 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -632,6 +632,22 @@ config TI_DAC7612
> > =20
> >  	  If compiled as a module, it will be called ti-dac7612.
> > =20
> > +config TI_DAC8163
> > +	tristate "Texas Instruments 12/14/16-bit 2-channel DAC driver"
> > +	depends on SPI_MASTER
> > +	select REGMAP_SPI
> > +	help
> > +	  Driver for the Texas Instruments digital-to-analog converter
> > +	  family dacxx6x compatible with the following variants
> > +	  - DAC7562 (2 channels, 12 bits, resets to zero)
> > +	  - DAC7563 (2 channels, 12 bits, resets to mid-scale)
> > +	  - DAC8162 (2 channels, 14 bits, resets to zero)
> > +	  - DAC8163 (2 channels, 14 bits, resets to mid-scale)
> > +	  - DAC8562 (2 channels, 16 bits, resets to zero)
> > +	  - DAC8563 (2 channels, 16 bits, resets to mid-scale)
> > +
> > +	  If compiled as a module, it will be called ti-dac8163.
> > +
> >  config VF610_DAC
> >  	tristate "Vybrid vf610 DAC driver"
> >  	depends on HAS_IOMEM
> > diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> > index 2a80bbf4e80a..359cde446623 100644
> > --- a/drivers/iio/dac/Makefile
> > +++ b/drivers/iio/dac/Makefile
> > @@ -62,4 +62,5 @@ obj-$(CONFIG_TI_DAC082S085) +=3D ti-dac082s085.o
> >  obj-$(CONFIG_TI_DAC5571) +=3D ti-dac5571.o
> >  obj-$(CONFIG_TI_DAC7311) +=3D ti-dac7311.o
> >  obj-$(CONFIG_TI_DAC7612) +=3D ti-dac7612.o
> > +obj-$(CONFIG_TI_DAC8163) +=3D ti-dac8163.o
> >  obj-$(CONFIG_VF610_DAC) +=3D vf610_dac.o
> > diff --git a/drivers/iio/dac/ti-dac8163.c b/drivers/iio/dac/ti-dac8163.c
> > new file mode 100644
> > index 000000000000..35af7828dc22
> > --- /dev/null
> > +++ b/drivers/iio/dac/ti-dac8163.c
> > @@ -0,0 +1,449 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * DAC8163 IIO driver (SPI)
> > + * https://www.ti.com/de/lit/gpn/dac8163
> > + */
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/stddef.h>
> > +#include <linux/types.h>
> > +#include <linux/units.h>
> > +
> > +#include <linux/iio/iio.h>
> > +
> > +#define COMMAND_MASK GENMASK(6, 3)
> > +#define ADDRESS_MASK GENMASK(2, 0)
> > +
> > +#define CMD_WRITE_INPUT_REG	0x0
> > +#define CMD_UPDATE_DAC		0x1
> > +#define CMD_WRITE_UPDATE_ALL	0x2
> > +#define CMD_WRITE_UPDATE	0x3
> > +#define CMD_POWER_MODE		0x4
> > +#define CMD_SOFT_RST		0x5
> > +#define CMD_LDAC_MODE		0x6
> > +#define CMD_REF			0x7
These are very generic names and that's where we risk shadowing
a define somewhere else.  I'd prefix them all with
DAC8163 even though it leads to some longer lines.

> > +
> > +#define LDAC_CHANNEL_A_MASK BIT(0)
> > +#define LDAC_CHANNEL_B_MASK BIT(1)
> > +#define VREF_MASK	    BIT(0)

> > +
> > +	if (device_property_present(&spi->dev, "vrefin-supply")) {
> > +		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev,
> > +							     "vrefin");
> > +		if (ret < 0)
> > +			return dev_err_probe(&spi->dev, ret,
> > +					     "failed to get vrefin voltage\n");
> > +
> > +		st->vref_mV =3D ret / (MICRO / MILLI);
> > +		internal_reference =3D false;
> > +		st->gain =3D 1;
> > +	} else {
> > +		st->vref_mV =3D DAC8163_INTERNAL_REF_mV;
> > +		internal_reference =3D true;
> > +		st->gain =3D 2;
> > +	}
> > +
> > +	ret =3D regmap_write(st->regmap, FIELD_PREP(COMMAND_MASK, CMD_SOFT_RS=
T),
> > +			   FULL_RESET);
> > +	if (ret < 0)
> > +		return dev_err_probe(&spi->dev, ret,
> > +				     "failed to reset device\n");
> > +
> > +	ret =3D regmap_write(st->regmap, FIELD_PREP(COMMAND_MASK, CMD_LDAC_MO=
DE),
> > +			   FIELD_PREP(LDAC_CHANNEL_A_MASK, LDAC_INACTIVE) |
> > +			   FIELD_PREP(LDAC_CHANNEL_B_MASK, LDAC_INACTIVE)); =20
>=20
>=20
> I know I have said many times before not to hide FIELD_PREP() in a macro.
> However, that was for register _values_, not register _addresseses_.
>=20
> In this case, I think we can make an exception for the address like:
>=20
> #define DAC8163_REG(cmd, addr) \
> 	(FIELD_PREP(COMMAND_MASK, (cmd)) | FIELD_PREP(ADDRESS_MASK, (addr)))

This makes sense but given it will then be the only place COMMAND_MASK
and ADDRESS_MASK are used, roll the GENMASK in there.

The generic nature of those macro names suggests to me we might
well get a naming clash with a header define in the long run so
i was going to suggest prefixing them.  Just not having them does
the job as well.
>=20
> So we can write it like:
>=20
> 	ret =3D regmap_write(st->regmap, DAC8163_REG(CMD_LDAC_MODE, 0),
> 			   FIELD_PREP(LDAC_CHANNEL_A_MASK, LDAC_INACTIVE) |
> 			   FIELD_PREP(LDAC_CHANNEL_B_MASK, LDAC_INACTIVE));
>=20
> Having FIELD_PREP() on all of the register addresses throught this patch
> was really throwing me off and gets quite verbose and repetitive.
>=20
> > +	if (ret < 0)


