Return-Path: <heiko@sntech.de>
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?utf-8?B?ZWRkaWUo6JSh5p6rKQ==?= <cf@rock-chips.com>, huangtao@rock-chips.com, Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 1/2] iio: adc: add driver for Rockchip saradc
Date: Sun, 13 Jul 2014 14:33:19 +0200
Message-ID: <1669488.HHBBlHNMv1@diego>
In-Reply-To: <53C2770C.3050701@gmx.de>
References: <2959154.xc8BQActsn@diego> <2263220.rhyqmTfAiL@diego> <53C2770C.3050701@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-iio@vger.kernel.org>

Am Sonntag, 13. Juli 2014, 14:09:48 schrieb Hartmut Knaack:
> Heiko St=FCbner schrieb:
> > The ADC is a 3-channel signal-ended 10-bit Successive Approximation=

> > Register (SAR) A/D Converter. It uses the supply and ground as its
> > reference and converts the analog input signal into 10-bit binary d=
igital
> > codes.
> Is there a datasheet available anywhere, or just under some NDA? I've=
 got
> some comments in line, which might be answered by reading the datashe=
et.

Sadly, there is no datasheet available to the public.


> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >=20
> >  changes since v2:
> > - address more comments from Peter Meerwald
> >=20
> >   mainly the missing info_mask_shared_by_type element
> > =20
> >  changes since v1:
> > - address comments from Peter Meerwald
> >=20
> > drivers/iio/adc/Kconfig           |  10 ++
> >=20
> >  drivers/iio/adc/Makefile          |   1 +
> >  drivers/iio/adc/rockchip_saradc.c | 314
> >  ++++++++++++++++++++++++++++++++++++++ 3 files changed, 325
> >  insertions(+)
> >  create mode 100644 drivers/iio/adc/rockchip_saradc.c
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index a80d236..5d36bdb 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -187,6 +187,16 @@ config NAU7802
> >=20
> >  =09  To compile this driver as a module, choose M here: the
> >  =09  module will be called nau7802.
> >=20
> > +config ROCKCHIP_SARADC
> > +=09tristate "Rockchip SARADC driver"
> > +=09depends on ARCH_ROCKCHIP || (OF && COMPILE_TEST)
> > +=09help
> > +=09  Say yes here to build support for the SARADC found in SoCs fr=
om
> > +=09  Rockchip.
> > +
> > +=09  To compile this driver as a module, choose M here: the
> > +=09  module will be called rockchip_saradc.
> > +
> >=20
> >  config TI_ADC081C
> > =20
> >  =09tristate "Texas Instruments ADC081C021/027"
> >  =09depends on I2C
> >=20
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 9d60f2d..8e2932d 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -20,6 +20,7 @@ obj-$(CONFIG_MCP320X) +=3D mcp320x.o
> >=20
> >  obj-$(CONFIG_MCP3422) +=3D mcp3422.o
> >  obj-$(CONFIG_MEN_Z188_ADC) +=3D men_z188_adc.o
> >  obj-$(CONFIG_NAU7802) +=3D nau7802.o
> >=20
> > +obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> >=20
> >  obj-$(CONFIG_TI_ADC081C) +=3D ti-adc081c.o
> >  obj-$(CONFIG_TI_AM335X_ADC) +=3D ti_am335x_adc.o
> >  obj-$(CONFIG_TWL4030_MADC) +=3D twl4030-madc.o
> >=20
> > diff --git a/drivers/iio/adc/rockchip_saradc.c
> > b/drivers/iio/adc/rockchip_saradc.c new file mode 100644
> > index 0000000..8fc5867
> > --- /dev/null
> > +++ b/drivers/iio/adc/rockchip_saradc.c
> > @@ -0,0 +1,314 @@
> > +/*
> > + * Rockchip Successive Approximation Register (SAR) A/D Converter
> > + * Copyright (C) 2014 ROCKCHIP, Inc.
>=20
> Does this mean, that you are working for Rockchip?

I'm doing consulting on the mainline integration and the code is largel=
y the=20
one taken from the upstream tree and only cleaned up in places.


>=20
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License as publish=
ed by
> > + * the Free Software Foundation; either version 2 of the License, =
or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,=

> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/iio/iio.h>
> > +
> > +#define SARADC_DATA=09=09=090x00
> > +#define SARADC_DATA_MASK=09=090x3ff
> > +
> > +#define SARADC_STAS=09=09=090x04
> > +#define SARADC_STAS_BUSY=09=09BIT(0)
> > +
> > +#define SARADC_CTRL=09=09=090x08
> > +#define SARADC_CTRL_IRQ_STATUS=09=09BIT(6)
> > +#define SARADC_CTRL_IRQ_ENABLE=09=09BIT(5)
> > +#define SARADC_CTRL_POWER_CTRL=09=09BIT(3)
> > +#define SARADC_CTRL_CHN_MASK=09=090x7
> > +
> > +#define SARADC_DLY_PU_SOC=09=090x0c
> > +#define SARADC_DLY_PU_SOC_MASK=09=090x3f
> > +
> > +#define SARADC_BITS=09=09=0910
> > +#define SARADC_TIMEOUT=09=09=09msecs_to_jiffies(100)
> > +
> > +struct rockchip_saradc {
> > +=09void __iomem=09=09*regs;
> > +=09struct clk=09=09*pclk;
> > +=09struct clk=09=09*clk;
> > +=09struct completion=09completion;
> > +=09struct regulator=09*vref;
> > +=09int=09=09=09vref_mv;
> > +=09u16=09=09=09last_val;
> > +};
> > +
> > +static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
> > +=09=09=09=09    struct iio_chan_spec const *chan,
> > +=09=09=09=09    int *val, int *val2, long mask)
> > +{
> > +=09struct rockchip_saradc *info =3D iio_priv(indio_dev);
> > +
> > +=09switch (mask) {
> > +=09case IIO_CHAN_INFO_RAW:
> > +=09=09mutex_lock(&indio_dev->mlock);
> > +
> > +=09=09/* Select the channel to be used and trigger conversion */
> > +=09=09writel_relaxed(0x08, info->regs + SARADC_DLY_PU_SOC);
>=20
> This could need a bit more explanation. Maybe represent the magic val=
ue of
> 0x8 with a more self explaining definition.

This actually isn't a magic value, but the "delay between power up and =
start=20
command" in clock periods. But you're right, this might benefit from a =
better=20
explaination, as the channel selection and start is done by the setting=
 below.


> > +=09=09writel(SARADC_CTRL_POWER_CTRL
> > +=09=09=09=09| (chan->channel & SARADC_CTRL_CHN_MASK)
> > +=09=09=09=09| SARADC_CTRL_IRQ_ENABLE,
> > +=09=09       info->regs + SARADC_CTRL);
> > +
> > +=09=09if (!wait_for_completion_timeout(&info->completion,
> > +=09=09=09=09=09=09 SARADC_TIMEOUT)) {
> > +=09=09=09writel_relaxed(0, info->regs + SARADC_CTRL);
> > +=09=09=09mutex_unlock(&indio_dev->mlock);
> > +=09=09=09return -ETIMEDOUT;
> > +=09=09}
> > +
> > +=09=09*val =3D info->last_val;
> > +=09=09mutex_unlock(&indio_dev->mlock);
> > +=09=09return IIO_VAL_INT;
> > +=09case IIO_CHAN_INFO_SCALE:
> > +=09=09*val =3D info->vref_mv;
> > +=09=09*val2 =3D SARADC_BITS;
> > +=09=09return IIO_VAL_FRACTIONAL_LOG2;
>=20
> Are there only fixed voltage regulators used, or are there chances th=
at
> variable voltage regulators could be used for vref? In the second cas=
e, it
> would be better to determine the current regulator voltage here.

The voltage regulators used are generally variable, but set to a fixed =
setting=20
that is not supposed to be changed.

Nevertheless I think you're right and the driver could be prepared for =
the=20
case where the voltage might really change.


> > +=09default:
> > +=09=09return -EINVAL;
> > +=09}
> > +}
> > +
> > +static irqreturn_t rockchip_saradc_isr(int irq, void *dev_id)
> > +{
> > +=09struct rockchip_saradc *info =3D (struct rockchip_saradc *)dev_=
id;
> > +
> > +=09/* Read value */
> > +=09info->last_val =3D readl_relaxed(info->regs + SARADC_DATA);
> > +=09info->last_val &=3D SARADC_DATA_MASK;
> > +
> > +=09/* Clear irq & power down adc */
> > +=09writel_relaxed(0, info->regs + SARADC_CTRL);
> > +
> > +=09complete(&info->completion);
> > +
> > +=09return IRQ_HANDLED;
> > +}
> > +
> > +static const struct iio_info rockchip_saradc_iio_info =3D {
> > +=09.read_raw =3D rockchip_saradc_read_raw,
> > +=09.driver_module =3D THIS_MODULE,
> > +};
> > +
> > +#define ADC_CHANNEL(_index, _id) {=09=09=09=09\
> > +=09.type =3D IIO_VOLTAGE,=09=09=09=09=09\
> > +=09.indexed =3D 1,=09=09=09=09=09=09\
> > +=09.channel =3D _index,=09=09=09=09=09\
> > +=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=09=09\
> > +=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),=09\
> > +=09.datasheet_name =3D _id,=09=09=09=09=09\
> > +}
> > +
> > +static const struct iio_chan_spec rockchip_saradc_iio_channels[] =3D=
 {
> > +=09ADC_CHANNEL(0, "adc0"),
> > +=09ADC_CHANNEL(1, "adc1"),
> > +=09ADC_CHANNEL(2, "adc2"),
> > +};
> > +
> > +static int rockchip_saradc_probe(struct platform_device *pdev)
> > +{
> > +=09struct rockchip_saradc *info =3D NULL;
> > +=09struct device_node *np =3D pdev->dev.of_node;
> > +=09struct iio_dev *indio_dev =3D NULL;
> > +=09struct resource=09*mem;
> > +=09int ret =3D -ENODEV;
> > +=09int irq;
> > +=09u32 rate;
> > +
> > +=09if (!np)
> > +=09=09return ret;
>=20
> return -ENODEV is usually used, and a bit more obvious. That would al=
so make
> the initialization of ret obsolete.

ok


Thanks for the review
Heiko

> > +
> > +=09indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*info));=

> > +=09if (!indio_dev) {
> > +=09=09dev_err(&pdev->dev, "failed allocating iio device\n");
> > +=09=09return -ENOMEM;
> > +=09}
> > +=09info =3D iio_priv(indio_dev);
> > +
> > +=09mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +=09info->regs =3D devm_request_and_ioremap(&pdev->dev, mem);
> > +=09if (!info->regs)
> > +=09=09return -ENOMEM;
> > +
> > +=09irq =3D platform_get_irq(pdev, 0);
> > +=09if (irq < 0) {
> > +=09=09dev_err(&pdev->dev, "no irq resource?\n");
> > +=09=09return irq;
> > +=09}
> > +
> > +=09ret =3D devm_request_irq(&pdev->dev, irq, rockchip_saradc_isr,
> > +=09=09=09       0, dev_name(&pdev->dev), info);
> > +=09if (ret < 0) {
> > +=09=09dev_err(&pdev->dev, "failed requesting irq %d\n", irq);
> > +=09=09return ret;
> > +=09}
> > +
> > +=09init_completion(&info->completion);
> > +
> > +=09info->pclk =3D devm_clk_get(&pdev->dev, "apb_pclk");
> > +=09if (IS_ERR(info->pclk)) {
> > +=09=09dev_err(&pdev->dev, "failed to get pclk\n");
> > +=09=09return PTR_ERR(info->pclk);
> > +=09}
> > +
> > +=09info->clk =3D devm_clk_get(&pdev->dev, "saradc");
> > +=09if (IS_ERR(info->clk)) {
> > +=09=09dev_err(&pdev->dev, "failed to get adc clock\n");
> > +=09=09return PTR_ERR(info->clk);
> > +=09}
> > +
> > +=09info->vref =3D devm_regulator_get(&pdev->dev, "vref");
> > +=09if (IS_ERR(info->vref)) {
> > +=09=09dev_err(&pdev->dev, "failed to get regulator, %ld\n",
> > +=09=09=09PTR_ERR(info->vref));
> > +=09=09return PTR_ERR(info->vref);
> > +=09}
> > +
> > +=09/* use a default of 1MHz for the converter clock */
> > +=09if (of_property_read_u32(np, "clock-frequency", &rate))
> > +=09=09rate =3D 1000000;
> > +
> > +=09ret =3D clk_set_rate(info->clk, rate);
> > +=09if (ret) {
> > +=09=09dev_err(&pdev->dev, "failed to set adc clk rate, %d\n", ret)=
;
> > +=09=09return ret;
> > +=09}
> > +
> > +=09ret =3D regulator_enable(info->vref);
> > +=09if (ret) {
> > +=09=09dev_err(&pdev->dev, "failed to enable vref regulator\n");
> > +=09=09return ret;
> > +=09}
> > +
> > +=09ret =3D regulator_get_voltage(info->vref);
> > +=09if (ret < 0) {
> > +=09=09dev_err(&pdev->dev, "failed to get regulator voltage\n");
> > +=09=09goto err_reg_voltage;
> > +=09}
> > +=09info->vref_mv =3D ret / 1000;
> > +
> > +=09ret =3D clk_prepare_enable(info->pclk);
> > +=09if (ret) {
> > +=09=09dev_err(&pdev->dev, "failed to enable pclk\n");
> > +=09=09goto err_reg_voltage;
> > +=09}
> > +
> > +=09ret =3D clk_prepare_enable(info->clk);
> > +=09if (ret) {
> > +=09=09dev_err(&pdev->dev, "failed to enable converter clock\n");
> > +=09=09goto err_pclk;
> > +=09}
> > +
> > +=09platform_set_drvdata(pdev, indio_dev);
> > +
> > +=09indio_dev->name =3D dev_name(&pdev->dev);
> > +=09indio_dev->dev.parent =3D &pdev->dev;
> > +=09indio_dev->dev.of_node =3D pdev->dev.of_node;
> > +=09indio_dev->info =3D &rockchip_saradc_iio_info;
> > +=09indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +=09indio_dev->channels =3D rockchip_saradc_iio_channels;
> > +=09indio_dev->num_channels =3D ARRAY_SIZE(rockchip_saradc_iio_chan=
nels);
> > +
> > +=09ret =3D iio_device_register(indio_dev);
> > +=09if (ret)
> > +=09=09goto err_clk;
> > +
> > +=09return 0;
> > +
> > +err_clk:
> > +=09clk_disable_unprepare(info->clk);
> > +err_pclk:
> > +=09clk_disable_unprepare(info->pclk);
> > +err_reg_voltage:
> > +=09regulator_disable(info->vref);
> > +=09return ret;
> > +}
> > +
> > +static int rockchip_saradc_remove(struct platform_device *pdev)
> > +{
> > +=09struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> > +=09struct rockchip_saradc *info =3D iio_priv(indio_dev);
> > +
> > +=09iio_device_unregister(indio_dev);
> > +=09clk_disable_unprepare(info->clk);
> > +=09clk_disable_unprepare(info->pclk);
> > +=09regulator_disable(info->vref);
> > +
> > +=09return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int rockchip_saradc_suspend(struct device *dev)
> > +{
> > +=09struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +=09struct rockchip_saradc *info =3D iio_priv(indio_dev);
> > +
> > +=09clk_disable_unprepare(info->clk);
> > +=09clk_disable_unprepare(info->pclk);
> > +=09regulator_disable(info->vref);
> > +
> > +=09return 0;
> > +}
> > +
> > +static int rockchip_saradc_resume(struct device *dev)
> > +{
> > +=09struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +=09struct rockchip_saradc *info =3D iio_priv(indio_dev);
> > +=09int ret;
> > +
> > +=09ret =3D regulator_enable(info->vref);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09ret =3D clk_prepare_enable(info->pclk);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09ret =3D clk_prepare_enable(info->clk);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09return ret;
> > +}
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(rockchip_saradc_pm_ops,
> > +=09=09=09 rockchip_saradc_suspend, rockchip_saradc_resume);
> > +
> > +static const struct of_device_id rockchip_saradc_match[] =3D {
> > +=09{ .compatible =3D "rockchip,saradc" },
> > +=09{},
> > +};
> > +MODULE_DEVICE_TABLE(of, rockchip_saradc_match);
> > +
> > +static struct platform_driver rockchip_saradc_driver =3D {
> > +=09.probe=09=09=3D rockchip_saradc_probe,
> > +=09.remove=09=09=3D rockchip_saradc_remove,
> > +=09.driver=09=09=3D {
> > +=09=09.name=09=3D "rockchip-saradc",
> > +=09=09.owner=09=3D THIS_MODULE,
> > +=09=09.of_match_table =3D rockchip_saradc_match,
> > +=09=09.pm=09=3D &rockchip_saradc_pm_ops,
> > +=09},
> > +};
> > +
> > +module_platform_driver(rockchip_saradc_driver);
