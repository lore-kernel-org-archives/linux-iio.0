Return-Path: <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v2 3/4] mfd: add support for Allwinner SoCs ADC
To: Maxime Ripard <maxime.ripard@free-electrons.com>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-4-git-send-email-quentin.schulz@free-electrons.com>
 <20160718130218.GG4199@lukather>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org, lee.jones@linaro.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 thomas.petazzoni@free-electrons.com, antoine.tenart@free-electrons.com
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <578E1736.20209@free-electrons.com>
Date: Tue, 19 Jul 2016 14:04:06 +0200
MIME-Version: 1.0
In-Reply-To: <20160718130218.GG4199@lukather>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sjaw9J6jcX7sqNgobBSR8tm1OtqtK3hMp"
List-ID: <linux-iio@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sjaw9J6jcX7sqNgobBSR8tm1OtqtK3hMp
Content-Type: multipart/mixed; boundary="h10aX1CHHEHmwQ5GJhJtah2rG2p64tK3o"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org, lee.jones@linaro.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 thomas.petazzoni@free-electrons.com, antoine.tenart@free-electrons.com
Message-ID: <578E1736.20209@free-electrons.com>
Subject: Re: [PATCH v2 3/4] mfd: add support for Allwinner SoCs ADC
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-4-git-send-email-quentin.schulz@free-electrons.com>
 <20160718130218.GG4199@lukather>
In-Reply-To: <20160718130218.GG4199@lukather>

--h10aX1CHHEHmwQ5GJhJtah2rG2p64tK3o
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 18/07/2016 15:02, Maxime Ripard wrote:
> On Fri, Jul 15, 2016 at 11:59:13AM +0200, Quentin Schulz wrote:
>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>> controller and a thermal sensor. For now, only the ADC and the thermal=

>> sensor drivers are probed by the MFD, the touchscreen controller suppo=
rt
>> will be added later.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
[...]
>> +config MFD_SUNXI_ADC
>> +	tristate "ADC MFD core driver for sunxi platforms"
>> +	select MFD_CORE
>> +	select REGMAP_MMIO
>=20
> It should also depends on the architectures supported (and probably COM=
PILE_TEST)
>=20

ACK.

[...]
>> +
>> +	sunxi_gpadc_mfd_dev->regmap =3D
>> +		devm_regmap_init_mmio(sunxi_gpadc_mfd_dev->dev,
>> +				      sunxi_gpadc_mfd_dev->regs,
>> +				      &sunxi_gpadc_mfd_regmap_config);
>=20
> This is usually on a single line (even if it exceeds 80 chars). Or
> maybe you can use a shorter variable name (like dev, or mfd).
>=20

I'll go with a shorter name.

>> +	if (IS_ERR(sunxi_gpadc_mfd_dev->regmap)) {
>> +		ret =3D PTR_ERR(sunxi_gpadc_mfd_dev->regmap);
>> +		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	irq =3D platform_get_irq(pdev, 0);
>> +	ret =3D regmap_add_irq_chip(sunxi_gpadc_mfd_dev->regmap, irq,
>> +				  IRQF_ONESHOT, 0,
>> +				  &sunxi_gpadc_mfd_regmap_irq_chip,
>> +				  &sunxi_gpadc_mfd_dev->regmap_irqc);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to add irq chip: %d\n", ret);
>> +		return ret;
>> +	}
>=20
> You should probably make sure that you clear all the interrupts before
> enabling them.
>=20

ACK. Thanks, didn't think of that.

>> +	if (of_device_is_compatible(pdev->dev.of_node,
>> +				    "allwinner,sun4i-a10-ts"))
>> +		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> +				      sun4i_gpadc_mfd_cells,
>> +				      ARRAY_SIZE(sun4i_gpadc_mfd_cells), NULL,
>> +				      0, NULL);
>> +	else if (of_device_is_compatible(pdev->dev.of_node,
>> +					 "allwinner,sun5i-a13-ts"))
>> +		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> +				      sun5i_gpadc_mfd_cells,
>> +				      ARRAY_SIZE(sun5i_gpadc_mfd_cells), NULL,
>> +				      0, NULL);
>> +	else if (of_device_is_compatible(pdev->dev.of_node,
>> +					 "allwinner,sun6i-a31-ts"))
>> +		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> +				      sun6i_gpadc_mfd_cells,
>> +				      ARRAY_SIZE(sun6i_gpadc_mfd_cells), NULL,
>> +				      0, NULL);
>=20
> This huge if / else can be removed by putting those structures in the
> data pointer of of_device_id.
>=20

Indeed. It is what I am using for the ADC driver, don't know why I
didn't think of this for the MFD as well.

[...]
>> diff --git a/include/linux/mfd/sunxi-gpadc-mfd.h b/include/linux/mfd/s=
unxi-gpadc-mfd.h
>> new file mode 100644
>> index 0000000..7155845
>> --- /dev/null
>> +++ b/include/linux/mfd/sunxi-gpadc-mfd.h
>> @@ -0,0 +1,23 @@
>> +/* Header of ADC MFD core driver for sunxi platforms
>> + *
>> + * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
>> + *
>> + * This program is free software; you can redistribute it and/or modi=
fy it
>> + * under the terms of the GNU General Public License version 2 as pub=
lished by
>> + * the Free Software Foundation.
>> + */
>> +
>> +#ifndef __SUNXI_GPADC_MFD__H__
>> +#define __SUNXI_GPADC_MFD__H__
>> +
>> +#define SUNXI_GPADC_TP_INT_FIFOC            0x10
>> +#define SUNXI_GPADC_TP_INT_FIFOS            0x14
>=20
> Why do you declare only these two registers there?
>=20

Because these are used by the MFD while the others not. Maybe it's
better to put all register and bit defines in sunxi-gpadc-mfd.h? Anyway,
just found out it would be clearer to use the defines for the interrupts
rather than directly "BIT(x)". So that makes two more defines here.
Should we put everything in sunxi-gpadc-mfd.h since the MFD is needed
for the ADC, (future) touchscreen and iio_hwmon drivers?



--h10aX1CHHEHmwQ5GJhJtah2rG2p64tK3o--

--sjaw9J6jcX7sqNgobBSR8tm1OtqtK3hMp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXjhc6AAoJEIS4mnU+4PGjleQP/0o6DNBD7hLPolo0dq9XmX5S
ViAsDZGlbzYwTcw47DV24z3IUUGX9A2pXxleCl2YK9KLfNfBNbxiC6iRC+m26LNF
iUwK8VaGuQN0VhuZzCJdiMxFbZ/tbByYIGlli4CbLcMfFviARQYBKNeAQcKCmxh1
wa7J9wg0VC8t4pj9LHXyPLki6XwwNeVlNZIF9lQWGp2q/+pYNy3SpJP6fUmRUiA9
iqUv6dScX6LT+Z32pFYqWgjcjwgZQLBNuDyD3XQNjjN5hKd8kXM6Lw1zM1x8zDYw
rK0MND6Rlg+YHzoRMaF0aRIqWEXBgqg+NA349Lr1Auzkumb+iU4fl15cIDMpw7ZW
u3YtSudwRoIgO4WItHyaCX3f3Kuww//6T229yAlPZUh4RpXDz+y199JTuhLLPGaj
feie6aC82ejLIMoHi/NJTJT/2vuURNvo5FC8+s7JsSYdKgo2NSPiqVW5nqLgbrGS
k02/mn7TIThMRfkjBU0gFDCYCMs/jXo7KEs4IfVR5K0hnN6Q84bcGu/FOtVeIwCB
TVZeLtbKJzmQ04guecBsgvFNNXiIaz9HwlpWrcjLIe8+5JRIN5UPSqONvvDmc+1k
i+3Smqy+92dXPk/I3LXpSVBo9lQzGrS0BjAnFdp2aVrcSVe48vWdqnUl1kaQrfIt
HWuw7c0CrwJfRXq+wxCj
=RrKG
-----END PGP SIGNATURE-----

--sjaw9J6jcX7sqNgobBSR8tm1OtqtK3hMp--
