Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56792 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdDNPgn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 11:36:43 -0400
Subject: Re: [PATCH v3 2/2] iio: dac: add support for stm32 DAC
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1491839390-2449-1-git-send-email-fabrice.gasnier@st.com>
 <1491839390-2449-3-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cd18dc1d-98c4-6555-bc7a-6d8d92841f03@kernel.org>
Date: Fri, 14 Apr 2017 16:36:39 +0100
MIME-Version: 1.0
In-Reply-To: <1491839390-2449-3-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/17 16:49, Fabrice Gasnier wrote:
> Add support for STMicroelectronics STM32 DAC. It's a 12-bit, voltage
> output digital-to-analog converter. It has two output channels, each
> with its own converter.
> It supports 8 bits or 12bits left/right aligned data format. Only
> 12bits right-aligned is used here. It has built-in noise or
> triangle waveform generator, and supports external triggers for
> conversions.
> Each channel can be used independently, with separate trigger, then
> separate IIO devices are used to handle this. Core driver is intended
> to share common resources such as clock, reset, reference voltage and
> registers.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
You did the constant attribute differently from how I would have done, but
it's a perfectly valid approach so that's fine with me. (I'll probably
regret that when it keeps getting copied form now on).

Looks good to me,

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Changes in v3:
> - Fix powerdown, no need for 'enable', use 'three_state' as standard name
>   for 'left floating' as per ABI documentation, instead of 'Hi-Z'.
> 
> Changes in v2:
> - Define 'Hi-Z'/'enable' powerdown modes instead of using 'enable'
>   attribute normally not used for DACs.
> - use 'reg' instead of 'st,dac-channel' property
> - Use macro to differentiate channels
> - Fix typos, remove leading '&' for functions
> - Add comments on single channel per device
> - Use devm_iio_device_register variant, removes need for .remove
> ---
>  drivers/iio/dac/Kconfig          |  15 ++
>  drivers/iio/dac/Makefile         |   2 +
>  drivers/iio/dac/stm32-dac-core.c | 180 +++++++++++++++++++++
>  drivers/iio/dac/stm32-dac-core.h |  51 ++++++
>  drivers/iio/dac/stm32-dac.c      | 334 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 582 insertions(+)
>  create mode 100644 drivers/iio/dac/stm32-dac-core.c
>  create mode 100644 drivers/iio/dac/stm32-dac-core.h
>  create mode 100644 drivers/iio/dac/stm32-dac.c
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index d3084028..7198648 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -274,6 +274,21 @@ config MCP4922
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mcp4922.
>  
> +config STM32_DAC
> +	tristate "STMicroelectronics STM32 DAC"
> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
> +	depends on REGULATOR
> +	select STM32_DAC_CORE
> +	help
> +	  Say yes here to build support for STMicroelectronics STM32 Digital
> +	  to Analog Converter (DAC).
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called stm32-dac.
> +
> +config STM32_DAC_CORE
> +	tristate
> +
>  config VF610_DAC
>  	tristate "Vybrid vf610 DAC driver"
>  	depends on OF
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index f01bf4a..afe8ae7 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -29,4 +29,6 @@ obj-$(CONFIG_MAX517) += max517.o
>  obj-$(CONFIG_MAX5821) += max5821.o
>  obj-$(CONFIG_MCP4725) += mcp4725.o
>  obj-$(CONFIG_MCP4922) += mcp4922.o
> +obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
> +obj-$(CONFIG_STM32_DAC) += stm32-dac.o
>  obj-$(CONFIG_VF610_DAC) += vf610_dac.o
> diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
> new file mode 100644
> index 0000000..75e4878
> --- /dev/null
> +++ b/drivers/iio/dac/stm32-dac-core.c
> @@ -0,0 +1,180 @@
> +/*
> + * This file is part of STM32 DAC driver
> + *
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
> + *
> + * License type: GPLv2
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.
> + * See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +
> +#include "stm32-dac-core.h"
> +
> +/**
> + * struct stm32_dac_priv - stm32 DAC core private data
> + * @pclk:		peripheral clock common for all DACs
> + * @rst:		peripheral reset control
> + * @vref:		regulator reference
> + * @common:		Common data for all DAC instances
> + */
> +struct stm32_dac_priv {
> +	struct clk *pclk;
> +	struct reset_control *rst;
> +	struct regulator *vref;
> +	struct stm32_dac_common common;
> +};
> +
> +static struct stm32_dac_priv *to_stm32_dac_priv(struct stm32_dac_common *com)
> +{
> +	return container_of(com, struct stm32_dac_priv, common);
> +}
> +
> +static const struct regmap_config stm32_dac_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = sizeof(u32),
> +	.max_register = 0x3fc,
> +};
> +
> +static int stm32_dac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct stm32_dac_priv *priv;
> +	struct regmap *regmap;
> +	struct resource *res;
> +	void __iomem *mmio;
> +	int ret;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mmio = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(mmio))
> +		return PTR_ERR(mmio);
> +
> +	regmap = devm_regmap_init_mmio(dev, mmio, &stm32_dac_regmap_cfg);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +	priv->common.regmap = regmap;
> +
> +	priv->vref = devm_regulator_get(dev, "vref");
> +	if (IS_ERR(priv->vref)) {
> +		ret = PTR_ERR(priv->vref);
> +		dev_err(dev, "vref get failed, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(priv->vref);
> +	if (ret < 0) {
> +		dev_err(dev, "vref enable failed\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_get_voltage(priv->vref);
> +	if (ret < 0) {
> +		dev_err(dev, "vref get voltage failed, %d\n", ret);
> +		goto err_vref;
> +	}
> +	priv->common.vref_mv = ret / 1000;
> +	dev_dbg(dev, "vref+=%dmV\n", priv->common.vref_mv);
> +
> +	priv->pclk = devm_clk_get(dev, "pclk");
> +	if (IS_ERR(priv->pclk)) {
> +		ret = PTR_ERR(priv->pclk);
> +		dev_err(dev, "pclk get failed\n");
> +		goto err_vref;
> +	}
> +
> +	ret = clk_prepare_enable(priv->pclk);
> +	if (ret < 0) {
> +		dev_err(dev, "pclk enable failed\n");
> +		goto err_vref;
> +	}
> +
> +	priv->rst = devm_reset_control_get(dev, NULL);
> +	if (!IS_ERR(priv->rst)) {
> +		reset_control_assert(priv->rst);
> +		udelay(2);
> +		reset_control_deassert(priv->rst);
> +	}
> +
> +	/* When clock speed is higher than 80MHz, set HFSEL */
> +	priv->common.hfsel = (clk_get_rate(priv->pclk) > 80000000UL);
> +	ret = regmap_update_bits(regmap, STM32_DAC_CR, STM32H7_DAC_CR_HFSEL,
> +				 priv->common.hfsel ? STM32H7_DAC_CR_HFSEL : 0);
> +	if (ret)
> +		goto err_pclk;
> +
> +	platform_set_drvdata(pdev, &priv->common);
> +
> +	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to populate DT children\n");
> +		goto err_pclk;
> +	}
> +
> +	return 0;
> +
> +err_pclk:
> +	clk_disable_unprepare(priv->pclk);
> +err_vref:
> +	regulator_disable(priv->vref);
> +
> +	return ret;
> +}
> +
> +static int stm32_dac_remove(struct platform_device *pdev)
> +{
> +	struct stm32_dac_common *common = platform_get_drvdata(pdev);
> +	struct stm32_dac_priv *priv = to_stm32_dac_priv(common);
> +
> +	of_platform_depopulate(&pdev->dev);
> +	clk_disable_unprepare(priv->pclk);
> +	regulator_disable(priv->vref);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id stm32_dac_of_match[] = {
> +	{ .compatible = "st,stm32h7-dac-core", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, stm32_dac_of_match);
> +
> +static struct platform_driver stm32_dac_driver = {
> +	.probe = stm32_dac_probe,
> +	.remove = stm32_dac_remove,
> +	.driver = {
> +		.name = "stm32-dac-core",
> +		.of_match_table = stm32_dac_of_match,
> +	},
> +};
> +module_platform_driver(stm32_dac_driver);
> +
> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics STM32 DAC core driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:stm32-dac-core");
> diff --git a/drivers/iio/dac/stm32-dac-core.h b/drivers/iio/dac/stm32-dac-core.h
> new file mode 100644
> index 0000000..daf0993
> --- /dev/null
> +++ b/drivers/iio/dac/stm32-dac-core.h
> @@ -0,0 +1,51 @@
> +/*
> + * This file is part of STM32 DAC driver
> + *
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
> + *
> + * License type: GPLv2
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.
> + * See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __STM32_DAC_CORE_H
> +#define __STM32_DAC_CORE_H
> +
> +#include <linux/regmap.h>
> +
> +/* STM32 DAC registers */
> +#define STM32_DAC_CR		0x00
> +#define STM32_DAC_DHR12R1	0x08
> +#define STM32_DAC_DHR12R2	0x14
> +#define STM32_DAC_DOR1		0x2C
> +#define STM32_DAC_DOR2		0x30
> +
> +/* STM32_DAC_CR bit fields */
> +#define STM32_DAC_CR_EN1		BIT(0)
> +#define STM32H7_DAC_CR_HFSEL		BIT(15)
> +#define STM32_DAC_CR_EN2		BIT(16)
> +
> +/**
> + * struct stm32_dac_common - stm32 DAC driver common data (for all instances)
> + * @regmap: DAC registers shared via regmap
> + * @vref_mv: reference voltage (mv)
> + * @hfsel: high speed bus clock selected
> + */
> +struct stm32_dac_common {
> +	struct regmap			*regmap;
> +	int				vref_mv;
> +	bool				hfsel;
> +};
> +
> +#endif
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> new file mode 100644
> index 0000000..50f8ec0
> --- /dev/null
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -0,0 +1,334 @@
> +/*
> + * This file is part of STM32 DAC driver
> + *
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Authors: Amelie Delaunay <amelie.delaunay@st.com>
> + *	    Fabrice Gasnier <fabrice.gasnier@st.com>
> + *
> + * License type: GPLv2
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.
> + * See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "stm32-dac-core.h"
> +
> +#define STM32_DAC_CHANNEL_1		1
> +#define STM32_DAC_CHANNEL_2		2
> +#define STM32_DAC_IS_CHAN_1(ch)		((ch) & STM32_DAC_CHANNEL_1)
> +
> +/**
> + * struct stm32_dac - private data of DAC driver
> + * @common:		reference to DAC common data
> + */
> +struct stm32_dac {
> +	struct stm32_dac_common *common;
> +};
> +
> +static int stm32_dac_is_enabled(struct iio_dev *indio_dev, int channel)
> +{
> +	struct stm32_dac *dac = iio_priv(indio_dev);
> +	u32 en, val;
> +	int ret;
> +
> +	ret = regmap_read(dac->common->regmap, STM32_DAC_CR, &val);
> +	if (ret < 0)
> +		return ret;
> +	if (STM32_DAC_IS_CHAN_1(channel))
> +		en = FIELD_GET(STM32_DAC_CR_EN1, val);
> +	else
> +		en = FIELD_GET(STM32_DAC_CR_EN2, val);
> +
> +	return !!en;
> +}
> +
> +static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
> +				      bool enable)
> +{
> +	struct stm32_dac *dac = iio_priv(indio_dev);
> +	u32 msk = STM32_DAC_IS_CHAN_1(ch) ? STM32_DAC_CR_EN1 : STM32_DAC_CR_EN2;
> +	u32 en = enable ? msk : 0;
> +	int ret;
> +
> +	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "%s failed\n", en ?
> +			"Enable" : "Disable");
> +		return ret;
> +	}
> +
> +	/*
> +	 * When HFSEL is set, it is not allowed to write the DHRx register
> +	 * during 8 clock cycles after the ENx bit is set. It is not allowed
> +	 * to make software/hardware trigger during this period either.
> +	 */
> +	if (en && dac->common->hfsel)
> +		udelay(1);
> +
> +	return 0;
> +}
> +
> +static int stm32_dac_get_value(struct stm32_dac *dac, int channel, int *val)
> +{
> +	int ret;
> +
> +	if (STM32_DAC_IS_CHAN_1(channel))
> +		ret = regmap_read(dac->common->regmap, STM32_DAC_DOR1, val);
> +	else
> +		ret = regmap_read(dac->common->regmap, STM32_DAC_DOR2, val);
> +
> +	return ret ? ret : IIO_VAL_INT;
> +}
> +
> +static int stm32_dac_set_value(struct stm32_dac *dac, int channel, int val)
> +{
> +	int ret;
> +
> +	if (STM32_DAC_IS_CHAN_1(channel))
> +		ret = regmap_write(dac->common->regmap, STM32_DAC_DHR12R1, val);
> +	else
> +		ret = regmap_write(dac->common->regmap, STM32_DAC_DHR12R2, val);
> +
> +	return ret;
> +}
> +
> +static int stm32_dac_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask)
> +{
> +	struct stm32_dac *dac = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return stm32_dac_get_value(dac, chan->channel, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = dac->common->vref_mv;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int stm32_dac_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val, int val2, long mask)
> +{
> +	struct stm32_dac *dac = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return stm32_dac_set_value(dac, chan->channel, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int stm32_dac_debugfs_reg_access(struct iio_dev *indio_dev,
> +					unsigned reg, unsigned writeval,
> +					unsigned *readval)
> +{
> +	struct stm32_dac *dac = iio_priv(indio_dev);
> +
> +	if (!readval)
> +		return regmap_write(dac->common->regmap, reg, writeval);
> +	else
> +		return regmap_read(dac->common->regmap, reg, readval);
> +}
> +
> +static const struct iio_info stm32_dac_iio_info = {
> +	.read_raw = stm32_dac_read_raw,
> +	.write_raw = stm32_dac_write_raw,
> +	.debugfs_reg_access = stm32_dac_debugfs_reg_access,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static const char * const stm32_dac_powerdown_modes[] = {
> +	"three_state",
> +};
> +
> +static int stm32_dac_get_powerdown_mode(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	return 0;
> +}
> +
> +static int stm32_dac_set_powerdown_mode(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					unsigned int type)
> +{
> +	return 0;
> +}
Slightly novel usage of the enum code, but I suppose it does no harm.
I'd have gone with an IIO_CONST_ATTR but this does line up nicely
with other drivers so other than taking a few more lines, not much wrong
with it as an approach.

> +
> +static ssize_t stm32_dac_read_powerdown(struct iio_dev *indio_dev,
> +					uintptr_t private,
> +					const struct iio_chan_spec *chan,
> +					char *buf)
> +{
> +	int ret = stm32_dac_is_enabled(indio_dev, chan->channel);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", ret ? 0 : 1);
> +}
> +
> +static ssize_t stm32_dac_write_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 const char *buf, size_t len)
> +{
> +	bool powerdown;
> +	int ret;
> +
> +	ret = strtobool(buf, &powerdown);
> +	if (ret)
> +		return ret;
> +
> +	ret = stm32_dac_set_enable_state(indio_dev, chan->channel, !powerdown);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static const struct iio_enum stm32_dac_powerdown_mode_en = {
> +	.items = stm32_dac_powerdown_modes,
> +	.num_items = ARRAY_SIZE(stm32_dac_powerdown_modes),
> +	.get = stm32_dac_get_powerdown_mode,
> +	.set = stm32_dac_set_powerdown_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info stm32_dac_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.read = stm32_dac_read_powerdown,
> +		.write = stm32_dac_write_powerdown,
> +		.shared = IIO_SEPARATE,
> +	},
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &stm32_dac_powerdown_mode_en),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", &stm32_dac_powerdown_mode_en),
> +	{},
> +};
> +
> +#define STM32_DAC_CHANNEL(chan, name) {			\
> +	.type = IIO_VOLTAGE,				\
> +	.indexed = 1,					\
> +	.output = 1,					\
> +	.channel = chan,				\
> +	.info_mask_separate =				\
> +		BIT(IIO_CHAN_INFO_RAW) |		\
> +		BIT(IIO_CHAN_INFO_SCALE),		\
> +	/* scan_index is always 0 as num_channels is 1 */ \
> +	.scan_type = {					\
> +		.sign = 'u',				\
> +		.realbits = 12,				\
> +		.storagebits = 16,			\
> +	},						\
> +	.datasheet_name = name,				\
> +	.ext_info = stm32_dac_ext_info			\
> +}
> +
> +static const struct iio_chan_spec stm32_dac_channels[] = {
> +	STM32_DAC_CHANNEL(STM32_DAC_CHANNEL_1, "out1"),
> +	STM32_DAC_CHANNEL(STM32_DAC_CHANNEL_2, "out2"),
> +};
> +
> +static int stm32_dac_chan_of_init(struct iio_dev *indio_dev)
> +{
> +	struct device_node *np = indio_dev->dev.of_node;
> +	unsigned int i;
> +	u32 channel;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "reg", &channel);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Failed to read reg property\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(stm32_dac_channels); i++) {
> +		if (stm32_dac_channels[i].channel == channel)
> +			break;
> +	}
> +	if (i >= ARRAY_SIZE(stm32_dac_channels)) {
> +		dev_err(&indio_dev->dev, "Invalid st,dac-channel\n");
> +		return -EINVAL;
> +	}
> +
> +	indio_dev->channels = &stm32_dac_channels[i];
> +	/*
> +	 * Expose only one channel here, as they can be used independently,
> +	 * with separate trigger. Then separate IIO devices are instantiated
> +	 * to manage this.
> +	 */
> +	indio_dev->num_channels = 1;
> +
> +	return 0;
> +};
> +
> +static int stm32_dac_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct iio_dev *indio_dev;
> +	struct stm32_dac *dac;
> +	int ret;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*dac));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	dac = iio_priv(indio_dev);
> +	dac->common = dev_get_drvdata(pdev->dev.parent);
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
> +	indio_dev->info = &stm32_dac_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = stm32_dac_chan_of_init(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static const struct of_device_id stm32_dac_of_match[] = {
> +	{ .compatible = "st,stm32-dac", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, stm32_dac_of_match);
> +
> +static struct platform_driver stm32_dac_driver = {
> +	.probe = stm32_dac_probe,
> +	.driver = {
> +		.name = "stm32-dac",
> +		.of_match_table = stm32_dac_of_match,
> +	},
> +};
> +module_platform_driver(stm32_dac_driver);
> +
> +MODULE_ALIAS("platform:stm32-dac");
> +MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics STM32 DAC driver");
> +MODULE_LICENSE("GPL v2");
> 

