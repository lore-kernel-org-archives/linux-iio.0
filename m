Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38080 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdBSOUr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 09:20:47 -0500
Subject: Re: [RFC v2 3/7] IIO: ADC: add sigma delta modulator support
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-4-git-send-email-arnaud.pouliquen@st.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel@stlinux.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        olivier moysan <olivier.moysan@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <46e0c35c-6f77-3fde-161c-4db32a124aa7@kernel.org>
Date: Sun, 19 Feb 2017 14:20:43 +0000
MIME-Version: 1.0
In-Reply-To: <1487003909-11710-4-git-send-email-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/02/17 16:38, Arnaud Pouliquen wrote:
> Add dummy driver to support sigma delta modulators.
Interesting to see how you are pulling this together.

Trivial bits inline.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  drivers/iio/adc/Kconfig         |  11 ++++
>  drivers/iio/adc/Makefile        |   1 +
>  drivers/iio/adc/simple_sd_adc.c | 112 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+)
>  create mode 100644 drivers/iio/adc/simple_sd_adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index e0b3c09..d4366ac 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -419,6 +419,17 @@ config ROCKCHIP_SARADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rockchip_saradc.
>  
> +config SIMPLE_SD_ADC
> +	tristate "Simple sigma delta modulator"
> +	depends on OF
> +        select IIO_BUFFER
> +        select IIO_TRIGGERED_BUFFER
> +	help
> +	  Select this option to enables generic sigma delta modulator.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called simple-sd-adc.
> +
>  config STM32_ADC_CORE
>  	tristate "STMicroelectronics STM32 adc core"
>  	depends on ARCH_STM32 || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 8e02a94..bd67144 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> +obj-$(CONFIG_SIMPLE_SD_ADC) += simple_sd_adc.o
> diff --git a/drivers/iio/adc/simple_sd_adc.c b/drivers/iio/adc/simple_sd_adc.c
> new file mode 100644
> index 0000000..4bc8b3c
> --- /dev/null
> +++ b/drivers/iio/adc/simple_sd_adc.c
> @@ -0,0 +1,112 @@
> +/*
> + * simple sigma delta modulator driver
> + *
> + * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
> + * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>.
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
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +
> +#include <linux/iio/triggered_buffer.h>
> +
> +static int simple_sd_of_xlate(struct iio_dev *iio,
> +			      const struct of_phandle_args *iiospec)
> +{
> +	dev_dbg(&iio->dev, "%s:\n", __func__);
> +	if (iiospec->args[0] != 0) {
> +		dev_err(&iio->dev, "Only one channel supported\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info simple_sd_iio_info = {
> +	.of_xlate = simple_sd_of_xlate,
> +};
> +
> +static const struct iio_buffer_setup_ops simple_sd_buffer_ops;
I guess we insist on having some setup ops. We could relax
that reasonably easily if this is going to become remotely
common (perhaps by providing such a default in the core).
> +
> +static int simple_sd_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *iio;
> +	struct iio_chan_spec *ch;
> +
> +	dev_dbg(&pdev->dev, "%s:\n", __func__);
it's an RFC so fair enough, but please remember to drop this
sort of output in the final version.

> +	iio = devm_iio_device_alloc(dev, 0);
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	/* Define one channel */
> +	ch = devm_kzalloc(&iio->dev, sizeof(*ch), GFP_KERNEL);
> +	if (!ch)
> +		return -ENOMEM;
> +
> +	iio->dev.parent = dev;
> +	iio->dev.of_node = dev->of_node;
> +	iio->name = dev_name(dev);
> +	iio->info = &simple_sd_iio_info;
> +	iio->modes = INDIO_BUFFER_HARDWARE;
> +
> +	ch->type = IIO_VOLTAGE;
> +	ch->indexed = 1;
> +	ch->scan_index = 0;
> +	ch->scan_type.sign = 'u';
> +	ch->scan_type.realbits = 1;
> +	ch->scan_type.storagebits = 1;
> +	ch->scan_type.shift = 0;
> +
> +	iio->num_channels = 1;
Static data (at lease currently) so do it as static const iio_chan_spec etc.
Interesting to see it being described like this.

I'd drop storagebits as it isn't 'stored' as such so this feels wrong and shift
is the default so drop that too.

> +	iio->channels = ch;
> +
> +	platform_set_drvdata(pdev, iio);
> +
> +	return iio_device_register(iio);
> +}
> +
> +static int simple_sd_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *iio = platform_get_drvdata(pdev);
> +
> +	iio_device_unregister(iio);
Having just the iio_device_unregister in a remove is a clear
indication that you could have gotten away with
devm_iio_device_register and dropped the remove entirely
as there would be nothing to do.
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sd_adc_of_match[] = {
> +	{ .compatible = "sd-modulator" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adc081c_of_match);
> +
> +static struct platform_driver simple_sd_adc = {
> +	.driver = {
> +		.name = "simple_sd_adc",
> +		.of_match_table = of_match_ptr(sd_adc_of_match),
> +	},
> +	.probe = simple_sd_probe,
> +	.remove = simple_sd_remove,
> +};
> +
> +module_platform_driver(simple_sd_adc);
> +
> +MODULE_DESCRIPTION("simple signma delta modulator");
> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
> +MODULE_LICENSE("GPL v2");
> 

