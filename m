Return-Path: <maxime.ripard@free-electrons.com>
Date: Mon, 18 Jul 2016 15:02:18 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
	lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: Re: [PATCH v2 3/4] mfd: add support for Allwinner SoCs ADC
Message-ID: <20160718130218.GG4199@lukather>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-4-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6BvahUXLYAruDZOj"
In-Reply-To: <1468576754-3273-4-git-send-email-quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>


--6BvahUXLYAruDZOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2016 at 11:59:13AM +0200, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. For now, only the ADC and the thermal
> sensor drivers are probed by the MFD, the touchscreen controller support
> will be added later.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>=20
> v2:
>  - add license headers,
>  - reorder alphabetically includes,
>  - add SUNXI_GPADC_ prefixes for defines,
>=20
>  drivers/mfd/Kconfig                 |  14 +++
>  drivers/mfd/Makefile                |   2 +
>  drivers/mfd/sunxi-gpadc-mfd.c       | 197 ++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/sunxi-gpadc-mfd.h |  23 +++++
>  4 files changed, 236 insertions(+)
>  create mode 100644 drivers/mfd/sunxi-gpadc-mfd.c
>  create mode 100644 include/linux/mfd/sunxi-gpadc-mfd.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 1bcf601..67b55d0 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -82,6 +82,20 @@ config MFD_ATMEL_FLEXCOM
>  	  by the probe function of this MFD driver according to a device tree
>  	  property.
> =20
> +config MFD_SUNXI_ADC
> +	tristate "ADC MFD core driver for sunxi platforms"
> +	select MFD_CORE
> +	select REGMAP_MMIO

It should also depends on the architectures supported (and probably COMPILE=
_TEST)

> +	help
> +	  Select this to get support for Allwinner SoCs (A10, A13 and A31) ADC.
> +	  This driver will only map the hardware interrupt and registers, you
> +	  have to select individual drivers based on this MFD to be able to use
> +	  the ADC or the thermal sensor. This will try to probe the ADC driver
> +	  sunxi-gpadc-iio and the hwmon driver iio_hwmon.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sunxi-gpadc-mfd.
> +
>  config MFD_ATMEL_HLCDC
>  	tristate "Atmel HLCDC (High-end LCD Controller)"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 42a66e1..dcf43cd 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -201,6 +201,8 @@ obj-$(CONFIG_MFD_DLN2)		+=3D dln2.o
>  obj-$(CONFIG_MFD_RT5033)	+=3D rt5033.o
>  obj-$(CONFIG_MFD_SKY81452)	+=3D sky81452.o
> =20
> +obj-$(CONFIG_MFD_SUNXI_ADC)	+=3D sunxi-gpadc-mfd.o
> +
>  intel-soc-pmic-objs		:=3D intel_soc_pmic_core.o intel_soc_pmic_crc.o
>  intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+=3D intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+=3D intel-soc-pmic.o
> diff --git a/drivers/mfd/sunxi-gpadc-mfd.c b/drivers/mfd/sunxi-gpadc-mfd.c
> new file mode 100644
> index 0000000..f0005a6
> --- /dev/null
> +++ b/drivers/mfd/sunxi-gpadc-mfd.c
> @@ -0,0 +1,197 @@
> +/* ADC MFD core driver for sunxi platforms
> + *
> + * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as publis=
hed by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/mfd/sunxi-gpadc-mfd.h>
> +
> +#define SUNXI_IRQ_FIFO_DATA	0
> +#define SUNXI_IRQ_TEMP_DATA	1
> +
> +static struct resource adc_resources[] =3D {
> +	{
> +		.name	=3D "FIFO_DATA_PENDING",
> +		.start	=3D SUNXI_IRQ_FIFO_DATA,
> +		.end	=3D SUNXI_IRQ_FIFO_DATA,
> +		.flags	=3D IORESOURCE_IRQ,
> +	}, {
> +		.name	=3D "TEMP_DATA_PENDING",
> +		.start	=3D SUNXI_IRQ_TEMP_DATA,
> +		.end	=3D SUNXI_IRQ_TEMP_DATA,
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +};
> +
> +static const struct regmap_irq sunxi_gpadc_mfd_regmap_irq[] =3D {
> +	REGMAP_IRQ_REG(SUNXI_IRQ_FIFO_DATA, 0, BIT(16)),
> +	REGMAP_IRQ_REG(SUNXI_IRQ_TEMP_DATA, 0, BIT(18)),
> +};
> +
> +static const struct regmap_irq_chip sunxi_gpadc_mfd_regmap_irq_chip =3D {
> +	.name =3D "sunxi_gpadc_mfd_irq_chip",
> +	.status_base =3D SUNXI_GPADC_TP_INT_FIFOS,
> +	.ack_base =3D SUNXI_GPADC_TP_INT_FIFOS,
> +	.mask_base =3D SUNXI_GPADC_TP_INT_FIFOC,
> +	.init_ack_masked =3D true,
> +	.mask_invert =3D true,
> +	.irqs =3D sunxi_gpadc_mfd_regmap_irq,
> +	.num_irqs =3D ARRAY_SIZE(sunxi_gpadc_mfd_regmap_irq),
> +	.num_regs =3D 1,
> +};
> +
> +static struct mfd_cell sun4i_gpadc_mfd_cells[] =3D {
> +	{
> +		.name	=3D "sun4i-a10-gpadc-iio",
> +		.resources =3D adc_resources,
> +		.num_resources =3D ARRAY_SIZE(adc_resources),
> +	}, {
> +		.name =3D "iio_hwmon",
> +	}
> +};
> +
> +static struct mfd_cell sun5i_gpadc_mfd_cells[] =3D {
> +	{
> +		.name	=3D "sun5i-a13-gpadc-iio",
> +		.resources =3D adc_resources,
> +		.num_resources =3D ARRAY_SIZE(adc_resources),
> +	}, {
> +		.name =3D "iio_hwmon",
> +	},
> +};
> +
> +static struct mfd_cell sun6i_gpadc_mfd_cells[] =3D {
> +	{
> +		.name	=3D "sun6i-a31-gpadc-iio",
> +		.resources =3D adc_resources,
> +		.num_resources =3D ARRAY_SIZE(adc_resources),
> +	}, {
> +		.name =3D "iio_hwmon",
> +	},
> +};
> +
> +static const struct regmap_config sunxi_gpadc_mfd_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.fast_io =3D true,
> +};
> +
> +static int sunxi_gpadc_mfd_probe(struct platform_device *pdev)
> +{
> +	struct sunxi_gpadc_mfd_dev *sunxi_gpadc_mfd_dev =3D NULL;
> +	struct resource *mem =3D NULL;
> +	unsigned int irq;
> +	int ret;
> +
> +	sunxi_gpadc_mfd_dev =3D devm_kzalloc(&pdev->dev,
> +					   sizeof(*sunxi_gpadc_mfd_dev),
> +					   GFP_KERNEL);
> +	if (!sunxi_gpadc_mfd_dev)
> +		return -ENOMEM;
> +
> +	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	sunxi_gpadc_mfd_dev->regs =3D devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(sunxi_gpadc_mfd_dev->regs))
> +		return PTR_ERR(sunxi_gpadc_mfd_dev->regs);
> +
> +	sunxi_gpadc_mfd_dev->dev =3D &pdev->dev;
> +	dev_set_drvdata(sunxi_gpadc_mfd_dev->dev, sunxi_gpadc_mfd_dev);
> +
> +	sunxi_gpadc_mfd_dev->regmap =3D
> +		devm_regmap_init_mmio(sunxi_gpadc_mfd_dev->dev,
> +				      sunxi_gpadc_mfd_dev->regs,
> +				      &sunxi_gpadc_mfd_regmap_config);

This is usually on a single line (even if it exceeds 80 chars). Or
maybe you can use a shorter variable name (like dev, or mfd).

> +	if (IS_ERR(sunxi_gpadc_mfd_dev->regmap)) {
> +		ret =3D PTR_ERR(sunxi_gpadc_mfd_dev->regmap);
> +		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	ret =3D regmap_add_irq_chip(sunxi_gpadc_mfd_dev->regmap, irq,
> +				  IRQF_ONESHOT, 0,
> +				  &sunxi_gpadc_mfd_regmap_irq_chip,
> +				  &sunxi_gpadc_mfd_dev->regmap_irqc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add irq chip: %d\n", ret);
> +		return ret;
> +	}

You should probably make sure that you clear all the interrupts before
enabling them.

> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "allwinner,sun4i-a10-ts"))
> +		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +				      sun4i_gpadc_mfd_cells,
> +				      ARRAY_SIZE(sun4i_gpadc_mfd_cells), NULL,
> +				      0, NULL);
> +	else if (of_device_is_compatible(pdev->dev.of_node,
> +					 "allwinner,sun5i-a13-ts"))
> +		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +				      sun5i_gpadc_mfd_cells,
> +				      ARRAY_SIZE(sun5i_gpadc_mfd_cells), NULL,
> +				      0, NULL);
> +	else if (of_device_is_compatible(pdev->dev.of_node,
> +					 "allwinner,sun6i-a31-ts"))
> +		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +				      sun6i_gpadc_mfd_cells,
> +				      ARRAY_SIZE(sun6i_gpadc_mfd_cells), NULL,
> +				      0, NULL);

This huge if / else can be removed by putting those structures in the
data pointer of of_device_id.

> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add MFD devices: %d\n", ret);
> +		regmap_del_irq_chip(irq, sunxi_gpadc_mfd_dev->regmap_irqc);
> +		return ret;
> +	}
> +
> +	dev_info(&pdev->dev, "successfully loaded\n");
> +
> +	return 0;
> +}
> +
> +static int sunxi_gpadc_mfd_remove(struct platform_device *pdev)
> +{
> +	struct sunxi_gpadc_mfd_dev *sunxi_gpadc_mfd_dev;
> +	unsigned int irq;
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	mfd_remove_devices(&pdev->dev);
> +	sunxi_gpadc_mfd_dev =3D dev_get_drvdata(&pdev->dev);
> +	regmap_del_irq_chip(irq, sunxi_gpadc_mfd_dev->regmap_irqc);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sunxi_gpadc_mfd_of_match[] =3D {
> +	{ .compatible =3D "allwinner,sun4i-a10-ts" },
> +	{ .compatible =3D "allwinner,sun5i-a13-ts" },
> +	{ .compatible =3D "allwinner,sun6i-a31-ts" },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, sunxi_gpadc_mfd_of_match);
> +
> +static struct platform_driver sunxi_gpadc_mfd_driver =3D {
> +	.driver =3D {
> +		.name =3D "sunxi-adc-mfd",
> +		.of_match_table =3D of_match_ptr(sunxi_gpadc_mfd_of_match),
> +	},
> +	.probe =3D sunxi_gpadc_mfd_probe,
> +	.remove =3D sunxi_gpadc_mfd_remove,
> +};
> +
> +module_platform_driver(sunxi_gpadc_mfd_driver);
> +
> +MODULE_DESCRIPTION("ADC MFD core driver for sunxi platforms");
> +MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/sunxi-gpadc-mfd.h b/include/linux/mfd/sunx=
i-gpadc-mfd.h
> new file mode 100644
> index 0000000..7155845
> --- /dev/null
> +++ b/include/linux/mfd/sunxi-gpadc-mfd.h
> @@ -0,0 +1,23 @@
> +/* Header of ADC MFD core driver for sunxi platforms
> + *
> + * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as publis=
hed by
> + * the Free Software Foundation.
> + */
> +
> +#ifndef __SUNXI_GPADC_MFD__H__
> +#define __SUNXI_GPADC_MFD__H__
> +
> +#define SUNXI_GPADC_TP_INT_FIFOC            0x10
> +#define SUNXI_GPADC_TP_INT_FIFOS            0x14

Why do you declare only these two registers there?

> +
> +struct sunxi_gpadc_mfd_dev {
> +	struct device			*dev;
> +	struct regmap			*regmap;
> +	struct regmap_irq_chip_data	*regmap_irqc;
> +	void __iomem			*regs;
> +};
> +
> +#endif
> --=20
> 2.5.0

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--6BvahUXLYAruDZOj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjNNaAAoJEBx+YmzsjxAghfoP+weUPXJNFARWnT4yK+/bb7SE
clXJdyZpF64L4zAAAjzwurM2uvfZKi4HVn5ymCuOGrIpNKREpfVi2z5dRjGi+rWd
DwBWufQW1ffc3vuM/OaHsbjWXKFvE4aSfLCMQ7SJPLudXq/z+T2BcaVFYFvGiN+u
f/bMALppmSa+fiiS+dnOO/dyN2oNT/wOFWuugTh5djTHuKWIbLhfbYUjlwG/xZOp
v2LqG686O1Gzb0Ea+jiM6lNSsUmC4Zl0necLo4XENmBpxjKqiEuct9A8v3hDstKv
oUW+1k9MrYILF+qMJi9l0z1D3GmjjkAQa2nysL9JYSPac6GRJ/1rKV0RQUmUyJ63
bJaAkFoyOjRKfX4MzZYt4A+l1cbgOAa88VZ/l1e5PQD4HPKW6NYdWwa7HP82h4cX
iNshvZsLPgQ2/SW4KYrBrWHPSqu2n4k+KkCKM49YFkW+RZF/GObzFbsMnDCwMdMt
+7EXtSUC7sUQnQGBUP5usK5DA3qH+54zY4pD95hGAihvrohhbYt/Ol1i1Tm5zxa5
ed4IRqrkZze+B/g+E/7YgUQJL5/7J/sqmhCdQXSPgZJ6GCGaofyPYllmUf4l/t8H
sbmDSusUb+JwLax8jxUhcEZpI5OjvdvqYUPK+czRp4VSctlZnX9vqBvLCi69G3ZY
5uUtApxjkHNq4O3ZBh84
=WJTt
-----END PGP SIGNATURE-----

--6BvahUXLYAruDZOj--
