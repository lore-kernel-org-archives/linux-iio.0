Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33441 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbdC0XOZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 19:14:25 -0400
Received: by mail-wr0-f173.google.com with SMTP id w43so65940591wrb.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2017 16:14:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <924b3014-a054-6eae-3506-1cf5129f7057@kernel.org>
References: <20170323184136.7349-1-raltherr@google.com> <20170323184136.7349-2-raltherr@google.com>
 <924b3014-a054-6eae-3506-1cf5129f7057@kernel.org>
From: Rick Altherr <raltherr@google.com>
Date: Mon, 27 Mar 2017 16:05:59 -0700
Message-ID: <CAPLgG=kVWufqR+bbhx77xXN36g1i42bng8aJum4AKq5YOm9Kmg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: Aspeed ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        David Lechner <david@lechnology.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-clk@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Alison Schofield <amsfield22@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Matt Ranostay <mranostay@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 25, 2017 at 10:32 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 23/03/17 18:41, Rick Altherr wrote:
>> Aspeed BMC SoCs include a 16 channel, 10-bit ADC. Low and high threshold
>> interrupts are supported by the hardware but are not currently implemented.
>>
>> Signed-off-by: Rick Altherr <raltherr@google.com>
> Nice little driver.
>
> I'd like input from clk maintainers on the clk stuff though before applying.
> Michael, Stephen MAINTAINERS suggests this is you two.  Any comments?
>
> Thanks,
>
> Jonathan
>
>> ---
>>
>> Changes in v4:
>> - Avoid copying per-model data to per-instance data
>>
>> Changes in v3:
>> - Drop model numbers from description as same IP is used in every generation
>> - Remove unused macros
>> - Shorten macro prefix to just ASPEED_
>> - Remove extraneous whitespace
>> - Rename 2nd argument of ASPEED_CHAN() to clarify purpose
>> - Use existing macros in place of magic constants
>> - Remove unnecessary logging in failure conditions during probe
>> - Disable ADC hardware during remove()
>> - Add a NULL terminator to of_match_table
>> - Add per-model data to accomodate slight variations (vref, min/max sample rate)
>> - Added missing Kconfig depends on COMMON_CLK
>>
>> Changes in v2:
>> - Rewritten as an IIO device
>> - Renamed register macros to describe the register's purpose
>> - Replaced awkward reading of 16-bit data registers with readw()
>> - Added Kconfig dependency on COMPILE_TEST
>>
>>  drivers/iio/adc/Kconfig      |  11 ++
>>  drivers/iio/adc/Makefile     |   1 +
>>  drivers/iio/adc/aspeed_adc.c | 284 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 296 insertions(+)
>>  create mode 100644 drivers/iio/adc/aspeed_adc.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 2268a6fb9865..236d05f99e80 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -130,6 +130,17 @@ config AD799X
>>         To compile this driver as a module, choose M here: the module will be
>>         called ad799x.
>>
>> +config ASPEED_ADC
>> +     tristate "Aspeed ADC"
>> +     depends on ARCH_ASPEED || COMPILE_TEST
>> +     depends on COMMON_CLK
>> +     help
>> +       If you say yes here you get support for the ADC included in Aspeed
>> +       BMC SoCs.
>> +
>> +       To compile this driver as a module, choose M here: the module will be
>> +       called aspeed_adc.
>> +
>>  config AT91_ADC
>>       tristate "Atmel AT91 ADC"
>>       depends on ARCH_AT91
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 73dbe399f894..306f10ffca74 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -14,6 +14,7 @@ obj-$(CONFIG_AD7791) += ad7791.o
>>  obj-$(CONFIG_AD7793) += ad7793.o
>>  obj-$(CONFIG_AD7887) += ad7887.o
>>  obj-$(CONFIG_AD799X) += ad799x.o
>> +obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
>>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
>>  obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
>>  obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
>> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
>> new file mode 100644
>> index 000000000000..e051fdf8ecbd
>> --- /dev/null
>> +++ b/drivers/iio/adc/aspeed_adc.c
>> @@ -0,0 +1,284 @@
>> +/*
>> + * Aspeed AST2400/2500 ADC
>> + *
>> + * Copyright (C) 2017 Google, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#include <asm/io.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/types.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/driver.h>
>> +
>> +#define ASPEED_RESOLUTION_BITS               10
>> +#define ASPEED_CLOCKS_PER_SAMPLE     12
>> +
>> +#define ASPEED_REG_ENGINE_CONTROL    0x00
>> +#define ASPEED_REG_INTERRUPT_CONTROL 0x04
>> +#define ASPEED_REG_VGA_DETECT_CONTROL        0x08
>> +#define ASPEED_REG_CLOCK_CONTROL     0x0C
>> +#define ASPEED_REG_MAX                       0xC0
>> +
>> +#define ASPEED_OPERATION_MODE_POWER_DOWN     (0x0 << 1)
>> +#define ASPEED_OPERATION_MODE_STANDBY                (0x1 << 1)
>> +#define ASPEED_OPERATION_MODE_NORMAL         (0x7 << 1)
>> +
>> +#define ASPEED_ENGINE_ENABLE         BIT(0)
>> +
>> +struct aspeed_adc_model_data {
>> +     const char *model_name;
>> +     unsigned int min_sampling_rate; // Hz
>> +     unsigned int max_sampling_rate; // Hz
>> +     unsigned int vref_voltage;      // mV
>> +};
>> +
>> +struct aspeed_adc_data {
>> +     struct device   *dev;
>> +     void __iomem    *base;
>> +     spinlock_t      clk_lock;
>> +     struct clk_hw   *clk_prescaler;
>> +     struct clk_hw   *clk_scaler;
>> +};
>> +
>> +#define ASPEED_CHAN(_idx, _data_reg_addr) {                  \
>> +     .type = IIO_VOLTAGE,                                    \
>> +     .indexed = 1,                                           \
>> +     .channel = (_idx),                                      \
>> +     .address = (_data_reg_addr),                            \
>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
>> +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |  \
>> +                             BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
>> +}
>> +
>> +static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
>> +     ASPEED_CHAN(0, 0x10),
>> +     ASPEED_CHAN(1, 0x12),
>> +     ASPEED_CHAN(2, 0x14),
>> +     ASPEED_CHAN(3, 0x16),
>> +     ASPEED_CHAN(4, 0x18),
>> +     ASPEED_CHAN(5, 0x1A),
>> +     ASPEED_CHAN(6, 0x1C),
>> +     ASPEED_CHAN(7, 0x1E),
>> +     ASPEED_CHAN(8, 0x20),
>> +     ASPEED_CHAN(9, 0x22),
>> +     ASPEED_CHAN(10, 0x24),
>> +     ASPEED_CHAN(11, 0x26),
>> +     ASPEED_CHAN(12, 0x28),
>> +     ASPEED_CHAN(13, 0x2A),
>> +     ASPEED_CHAN(14, 0x2C),
>> +     ASPEED_CHAN(15, 0x2E),
>> +};
>> +
>> +static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>> +                            struct iio_chan_spec const *chan,
>> +                            int *val, int *val2, long mask)
>> +{
>> +     struct aspeed_adc_data *data = iio_priv(indio_dev);
>> +     const struct aspeed_adc_model_data *model_data =
>> +                     of_device_get_match_data(data->dev);
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_RAW:
>> +             *val = readw(data->base + chan->address);
>> +             return IIO_VAL_INT;
>> +
>> +     case IIO_CHAN_INFO_SCALE:
>> +             *val = model_data->vref_voltage;
>> +             *val2 = ASPEED_RESOLUTION_BITS;
>> +             return IIO_VAL_FRACTIONAL_LOG2;
>> +
>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>> +             *val = clk_get_rate(data->clk_scaler->clk) /
>> +                             ASPEED_CLOCKS_PER_SAMPLE;
>> +             return IIO_VAL_INT;
>> +
>> +     default:
>> +             return -EPERM;
> Unusual, but I supose a valid choice.

I must have changed this one by accident.  It was EINVAL previously
and that is at least literally true.

>> +     }
>> +}
>> +
>> +static int aspeed_adc_write_raw(struct iio_dev *indio_dev,
>> +                             struct iio_chan_spec const *chan,
>> +                             int val, int val2, long mask)
>> +{
>> +     struct aspeed_adc_data *data = iio_priv(indio_dev);
>> +     const struct aspeed_adc_model_data *model_data =
>> +                     of_device_get_match_data(data->dev);
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>> +             if (val < model_data->min_sampling_rate ||
>> +                     val > model_data->max_sampling_rate)
>> +                     return -EINVAL;
>> +
>> +             clk_set_rate(data->clk_scaler->clk,
>> +                             val * ASPEED_CLOCKS_PER_SAMPLE);
>> +             return 0;
>> +
>> +     default:
>> +             return -EPERM;

Similar to above, EINVAL makes more sense as the default case.  EPERM
came from thinking about attempts to write INFO_SCALE or INFO_RAW.
Technically EINVAL is accurate but it's more a policy decision that
I'm not allowing writes to those.

>> +     }
>> +}
>> +
>> +static int aspeed_adc_reg_access(struct iio_dev *indio_dev,
>> +                              unsigned int reg, unsigned int writeval,
>> +                              unsigned int *readval)
>> +{
>> +     struct aspeed_adc_data *data = iio_priv(indio_dev);
>> +
>> +     if (!readval || reg % 4 || reg > ASPEED_REG_MAX)
>> +             return -EINVAL;
>> +
>> +     *readval = readl(data->base + reg);
>> +     return 0;
>> +}
>> +
>> +static const struct iio_info aspeed_adc_iio_info = {
>> +     .driver_module = THIS_MODULE,
>> +     .read_raw = aspeed_adc_read_raw,
>> +     .write_raw = aspeed_adc_write_raw,
>> +     .debugfs_reg_access = aspeed_adc_reg_access,
>> +};
>> +
>> +static int aspeed_adc_probe(struct platform_device *pdev)
>> +{
>> +     struct iio_dev *indio_dev;
>> +     struct aspeed_adc_data *data;
>> +     const struct aspeed_adc_model_data *model_data;
>> +     struct resource *res;
>> +     const char *clk_parent_name;
>> +     int ret;
>> +     u32 adc_engine_control_reg_val;
>> +
>> +     indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
>> +     if (!indio_dev)
>> +             return -ENOMEM;
>> +
>> +     data = iio_priv(indio_dev);
>> +     data->dev = &pdev->dev;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     data->base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(data->base))
>> +             return PTR_ERR(data->base);
>> +
>> +     /* Register ADC clock prescaler with source specified by device tree. */
>> +     spin_lock_init(&data->clk_lock);
>> +     clk_parent_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
>> +
>> +     data->clk_prescaler = clk_hw_register_divider(
>> +                             &pdev->dev, "prescaler", clk_parent_name, 0,
>> +                             data->base + ASPEED_REG_CLOCK_CONTROL,
>> +                             17, 15, 0, &data->clk_lock);
>> +     if (IS_ERR(data->clk_prescaler))
>> +             return PTR_ERR(data->clk_prescaler);
>> +
>> +     /*
>> +      * Register ADC clock scaler downstream from the prescaler. Allow rate
>> +      * setting to adjust the prescaler as well.
>> +      */
>> +     data->clk_scaler = clk_hw_register_divider(
>> +                             &pdev->dev, "scaler", "prescaler",
>> +                             CLK_SET_RATE_PARENT,
>> +                             data->base + ASPEED_REG_CLOCK_CONTROL,
>> +                             0, 10, 0, &data->clk_lock);
>> +     if (IS_ERR(data->clk_scaler)) {
>> +             ret = PTR_ERR(data->clk_scaler);
>> +             goto scaler_error;
>> +     }
>> +
>> +     /* Start all channels in normal mode. */
>> +     clk_prepare_enable(data->clk_scaler->clk);
>> +     adc_engine_control_reg_val = GENMASK(31, 16) |
>> +             ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE;
>> +     writel(adc_engine_control_reg_val,
>> +             data->base + ASPEED_REG_ENGINE_CONTROL);
>> +
>> +     model_data = of_device_get_match_data(&pdev->dev);
>> +     indio_dev->name = model_data->model_name;
>> +     indio_dev->dev.parent = &pdev->dev;
>> +     indio_dev->info = &aspeed_adc_iio_info;
>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>> +     indio_dev->channels = aspeed_adc_iio_channels;
>> +     indio_dev->num_channels = ARRAY_SIZE(aspeed_adc_iio_channels);
>> +
>> +     ret = iio_device_register(indio_dev);
>> +     if (ret)
>> +             goto iio_register_error;
>> +
>> +     return 0;
>> +
>> +iio_register_error:
>> +     writel(ASPEED_OPERATION_MODE_POWER_DOWN,
>> +             data->base + ASPEED_REG_ENGINE_CONTROL);
>> +     clk_disable_unprepare(data->clk_scaler->clk);
>> +     clk_hw_unregister_divider(data->clk_scaler);
>> +
>> +scaler_error:
>> +     clk_hw_unregister_divider(data->clk_prescaler);
>> +     return ret;
>> +}
>> +
>> +static int aspeed_adc_remove(struct platform_device *pdev)
>> +{
>> +     struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +     struct aspeed_adc_data *data = iio_priv(indio_dev);
>> +
>> +     iio_device_unregister(indio_dev);
>> +     writel(ASPEED_OPERATION_MODE_POWER_DOWN,
>> +             data->base + ASPEED_REG_ENGINE_CONTROL);
>> +     clk_disable_unprepare(data->clk_scaler->clk);
>> +     clk_hw_unregister_divider(data->clk_scaler);
>> +     clk_hw_unregister_divider(data->clk_prescaler);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct aspeed_adc_model_data ast2400_model_data = {
>> +     .model_name = "ast2400-adc",
>> +     .vref_voltage = 2500, // mV
>> +     .min_sampling_rate = 10000,
>> +     .max_sampling_rate = 500000,
>> +};
>> +
>> +static const struct aspeed_adc_model_data ast2500_model_data = {
>> +     .model_name = "ast2500-adc",
>> +     .vref_voltage = 1800, // mV
>> +     .min_sampling_rate = 1,
>> +     .max_sampling_rate = 1000000,
>> +};
>> +
>> +static const struct of_device_id aspeed_adc_matches[] = {
>> +     { .compatible = "aspeed,ast2400-adc", .data = &ast2400_model_data },
>> +     { .compatible = "aspeed,ast2500-adc", .data = &ast2500_model_data },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, aspeed_adc_matches);
>> +
>> +static struct platform_driver aspeed_adc_driver = {
>> +     .probe = aspeed_adc_probe,
>> +     .remove = aspeed_adc_remove,
>> +     .driver = {
>> +             .name = KBUILD_MODNAME,
>> +             .of_match_table = aspeed_adc_matches,
>> +     }
>> +};
>> +
>> +module_platform_driver(aspeed_adc_driver);
>> +
>> +MODULE_AUTHOR("Rick Altherr <raltherr@google.com>");
>> +MODULE_DESCRIPTION("Aspeed AST2400/2500 ADC Driver");
>> +MODULE_LICENSE("GPL");
>>
>
