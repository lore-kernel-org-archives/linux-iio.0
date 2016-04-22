Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34631 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464AbcDVRAM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Apr 2016 13:00:12 -0400
MIME-Version: 1.0
In-Reply-To: <571A4831.2020604@denx.de>
References: <1461333147-11873-1-git-send-email-harald@ccbib.org>
	<1461333147-11873-2-git-send-email-harald@ccbib.org>
	<571A4831.2020604@denx.de>
Date: Fri, 22 Apr 2016 19:00:10 +0200
Message-ID: <CAL7P5jKYp0JrF2MHdLkLTBvgYb0KSDwPEMuNPGxcctcxCRnazg@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: mxs-lradc: Add regulators for current sources
From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: Harald Geyer <harald@ccbib.org>,
	Jonathan Cameron <jic23@kernel.org>,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

HI

On Fri, Apr 22, 2016 at 5:50 PM, Marek Vasut <marex@denx.de> wrote:
> On 04/22/2016 03:52 PM, Harald Geyer wrote:
>> The hardware has two current sources ISRC0 and ISRC1 to allow measuring
>> resistors without additional circuitry. This commit makes them available
>> as regulators.
>>
>> Tested on an imx233-olinuxino board.
>>
>> Signed-off-by: Harald Geyer <harald@ccbib.org>
>> ---
>> The current regulator API doesn't fit this type of device very well: Typically
>> consumers will want to set a defined current, ie. min_uA == max_uA, but they
>> can't without help from configuration data, because the valid values aren't
>> reported by the API for current regulators. I have been thinking about
>> extending the API, but currently AFAIK no such consumers exist and most
>> users, like myself, will force the regulator to a defined value in
>> devicetree anyway.
>
> I am tempted to block this patch and ask you to properly split the
> mxs-lradc driver into MFD with touchscreen and IIO part and only then
> add the regulator bits. The lradc is becoming a katamari of ad-hoc
> misplaced functionality.

I almost finished, I already split the driver into MFD, sorry for the delay.
Can this wait a little bit?

Thanks,
Ksenija

>>  .../bindings/staging/iio/adc/mxs-lradc.txt         |  29 ++++
>>  drivers/iio/adc/Kconfig                            |   1 +
>>  drivers/iio/adc/mxs-lradc.c                        | 152 +++++++++++++++++++++
>>  3 files changed, 182 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
>> index 555fb11..983952c 100644
>> --- a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
>> +++ b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
>> @@ -19,6 +19,15 @@ Optional properties:
>>  - fsl,settling: delay between plate switch to next sample. Allowed value is
>>                  1 ... 2047. It counts at 2 kHz and its default is
>>                  10 (= 5 ms)
>> +- ISRC0: A node describing the regulator of internal current source 0
>> +- ISRC1: A node describing the regulator of internal current source 1
>> +
>> +Required properties for the ISRCx sub-nodes:
>> +- regulator-max-microamp: See standard regulator binding documentation.
>> +                          Valid values are from 0 to 300 in steps of 20.
>> +
>> +Optional properties for the ISRCx sub-nodes:
>> +Any standard regulator properties that apply to current regulators.
>>
>>  Example for i.MX23 SoC:
>>
>> @@ -31,6 +40,16 @@ Example for i.MX23 SoC:
>>               fsl,ave-ctrl = <4>;
>>               fsl,ave-delay = <2>;
>>               fsl,settling = <10>;
>> +
>> +             isrc_lradc0: ISRC0 {
>> +                     regulator-max-microamp = <300>;
>> +             };
>> +
>> +             isrc_lradc1: ISRC1 {
>> +                     regulator-max-microamp = <120>;
>> +                     regulator-min-microamp = <120>;
>> +                     regulator-always-on;
>> +             };
>>       };
>>
>>  Example for i.MX28 SoC:
>> @@ -44,4 +63,14 @@ Example for i.MX28 SoC:
>>               fsl,ave-ctrl = <4>;
>>               fsl,ave-delay = <2>;
>>               fsl,settling = <10>;
>> +
>> +             isrc_lradc0: ISRC0 {
>> +                     regulator-max-microamp = <300>;
>> +             };
>> +
>> +             isrc_lradc6: ISRC1 {
>> +                     regulator-max-microamp = <120>;
>> +                     regulator-min-microamp = <120>;
>> +                     regulator-always-on;
>> +             };
>>       };
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 5937030..1968d1c 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -319,6 +319,7 @@ config MXS_LRADC
>>          tristate "Freescale i.MX23/i.MX28 LRADC"
>>          depends on (ARCH_MXS || COMPILE_TEST) && HAS_IOMEM
>>          depends on INPUT
>> +        depends on REGULATOR
>>          select STMP_DEVICE
>>          select IIO_BUFFER
>>          select IIO_TRIGGERED_BUFFER
>> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
>> index 33051b8..f22f339 100644
>> --- a/drivers/iio/adc/mxs-lradc.c
>> +++ b/drivers/iio/adc/mxs-lradc.c
>> @@ -40,6 +40,10 @@
>>  #include <linux/iio/triggered_buffer.h>
>>  #include <linux/iio/sysfs.h>
>>
>> +#include <linux/regulator/driver.h>
>> +#include <linux/regulator/machine.h>
>> +#include <linux/regulator/of_regulator.h>
>> +
>>  #define DRIVER_NAME          "mxs-lradc"
>>
>>  #define LRADC_MAX_DELAY_CHANS        4
>> @@ -261,6 +265,9 @@ struct mxs_lradc {
>>       unsigned                over_sample_delay;
>>       /* time in clocks to wait after the plates where switched */
>>       unsigned                settling_delay;
>> +
>> +     struct regulator_desc isrc0;
>> +     struct regulator_desc isrc1;
>>  };
>>
>>  #define      LRADC_CTRL0                             0x00
>> @@ -305,6 +312,11 @@ struct mxs_lradc {
>>  #define      LRADC_CTRL2                             0x20
>>  #define      LRADC_CTRL2_DIVIDE_BY_TWO_OFFSET        24
>>  #define      LRADC_CTRL2_TEMPSENSE_PWD               BIT(15)
>> +#define      LRADC_CTRL2_TEMP_SENSOR_IENABLE1        BIT(9)
>> +#define      LRADC_CTRL2_TEMP_SENSOR_IENABLE0        BIT(8)
>> +#define      LRADC_CTRL2_TEMP_ISRC1_OFFSET           4
>> +#define      LRADC_CTRL2_TEMP_ISRC0_OFFSET           0
>> +#define      LRADC_CTRL2_TEMP_ISRC_MASK              0x0f
>>
>>  #define      LRADC_STATUS                            0x40
>>  #define      LRADC_STATUS_TOUCH_DETECT_RAW           BIT(0)
>> @@ -1383,6 +1395,109 @@ static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
>>       .validate_scan_mask = &mxs_lradc_validate_scan_mask,
>>  };
>>
>> +static int mxs_lradc_regulator_is_enabled(struct regulator_dev *dev)
>> +{
>> +     struct mxs_lradc *lradc = rdev_get_drvdata(dev);
>> +     int reg = readl(lradc->base + LRADC_CTRL2);
>> +
>> +     if (dev->desc == &lradc->isrc0)
>> +             return reg & LRADC_CTRL2_TEMP_SENSOR_IENABLE0;
>> +     else if (dev->desc == &lradc->isrc1)
>> +             return reg & LRADC_CTRL2_TEMP_SENSOR_IENABLE1;
>> +
>> +     /* This should never happen */
>> +     return -ENODEV;
>> +}
>> +
>> +#define LRADC_REGVALUE2uA(regval, offset) \
>> +     (20 * ((regval >> offset) & LRADC_CTRL2_TEMP_ISRC_MASK))
>> +
>> +static int mxs_lradc_regulator_get_current_limit(struct regulator_dev *dev)
>> +{
>> +     struct mxs_lradc *lradc = rdev_get_drvdata(dev);
>> +     int reg = readl(lradc->base + LRADC_CTRL2);
>> +
>> +     if (dev->desc == &lradc->isrc0)
>> +             return LRADC_REGVALUE2uA(reg, LRADC_CTRL2_TEMP_ISRC0_OFFSET);
>> +     else if (dev->desc == &lradc->isrc1)
>> +             return LRADC_REGVALUE2uA(reg, LRADC_CTRL2_TEMP_ISRC1_OFFSET);
>> +
>> +     /* This should never happen */
>> +     return -ENODEV;
>> +}
>> +
>> +static int mxs_lradc_regulator_enable(struct regulator_dev *dev)
>> +{
>> +     struct mxs_lradc *lradc = rdev_get_drvdata(dev);
>> +
>> +     if (dev->desc == &lradc->isrc0)
>> +             mxs_lradc_reg_set(lradc, LRADC_CTRL2_TEMP_SENSOR_IENABLE0,
>> +                               LRADC_CTRL2);
>> +     else if (dev->desc == &lradc->isrc1)
>> +             mxs_lradc_reg_set(lradc, LRADC_CTRL2_TEMP_SENSOR_IENABLE1,
>> +                               LRADC_CTRL2);
>> +     else
>> +             /* This should never happen */
>> +             return -ENODEV;
>> +
>> +     return 0;
>> +}
>> +
>> +static int mxs_lradc_regulator_disable(struct regulator_dev *dev)
>> +{
>> +     struct mxs_lradc *lradc = rdev_get_drvdata(dev);
>> +
>> +     if (dev->desc == &lradc->isrc0)
>> +             mxs_lradc_reg_clear(lradc, LRADC_CTRL2_TEMP_SENSOR_IENABLE0,
>> +                                 LRADC_CTRL2);
>> +     else if (dev->desc == &lradc->isrc1)
>> +             mxs_lradc_reg_clear(lradc, LRADC_CTRL2_TEMP_SENSOR_IENABLE1,
>> +                                 LRADC_CTRL2);
>> +     else
>> +             /* This should never happen */
>> +             return -ENODEV;
>> +
>> +     return 0;
>> +}
>> +
>> +static int mxs_lradc_regulator_set_current_limit(struct regulator_dev *dev,
>> +                                              int min_uA, int max_uA)
>> +{
>> +     struct mxs_lradc *lradc = rdev_get_drvdata(dev);
>> +     int offset, value;
>> +
>> +     if (dev->desc == &lradc->isrc0)
>> +             offset = LRADC_CTRL2_TEMP_ISRC0_OFFSET;
>> +     else if (dev->desc == &lradc->isrc1)
>> +             offset = LRADC_CTRL2_TEMP_ISRC1_OFFSET;
>> +     else
>> +             /* This should never happen */
>> +             return -ENODEV;
>> +
>> +     value = min_uA / 20;
>> +     if (min_uA % 20)
>> +             value++;
>> +     if (value * 20 > max_uA)
>> +             return -EINVAL;
>> +     if (value & ~LRADC_CTRL2_TEMP_ISRC_MASK)
>> +             /* This should never happen */
>> +             return -EPERM;
>> +
>> +     mxs_lradc_reg_clear(lradc, LRADC_CTRL2_TEMP_ISRC_MASK << offset,
>> +                         LRADC_CTRL2);
>> +     mxs_lradc_reg_set(lradc, value << offset, LRADC_CTRL2);
>> +
>> +     return 0;
>> +}
>> +
>> +static struct regulator_ops mxs_lradc_regulator_current_ops = {
>> +     .enable = mxs_lradc_regulator_enable,
>> +     .is_enabled = mxs_lradc_regulator_is_enabled,
>> +     .disable = mxs_lradc_regulator_disable,
>> +     .get_current_limit = mxs_lradc_regulator_get_current_limit,
>> +     .set_current_limit = mxs_lradc_regulator_set_current_limit,
>> +};
>> +
>>  /*
>>   * Driver initialization
>>   */
>> @@ -1519,6 +1634,10 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
>>
>>       for (i = 0; i < LRADC_MAX_DELAY_CHANS; i++)
>>               mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(i));
>> +
>> +     mxs_lradc_reg_clear(lradc, LRADC_CTRL2_TEMP_SENSOR_IENABLE0 |
>> +                                     LRADC_CTRL2_TEMP_SENSOR_IENABLE1,
>> +                         LRADC_CTRL2);
>>  }
>>
>>  static const struct of_device_id mxs_lradc_dt_ids[] = {
>> @@ -1592,6 +1711,32 @@ static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
>>       return 0;
>>  }
>>
>> +static void mxs_lradc_reg_helper(struct device_node *np, const char *name,
>> +                              struct regulator_config *conf,
>> +                              struct regulator_desc *desc)
>> +{
>> +     struct regulator_dev *ret;
>> +
>> +     conf->of_node = of_get_child_by_name(np, name);
>> +     if (!conf->of_node)
>> +             return;
>> +
>> +     desc->name = name;
>> +     desc->owner = THIS_MODULE;
>> +     desc->type = REGULATOR_CURRENT;
>> +     desc->ops = &mxs_lradc_regulator_current_ops;
>> +
>> +     conf->init_data = of_get_regulator_init_data(conf->dev, conf->of_node,
>> +                                                  desc);
>> +     ret = devm_regulator_register(conf->dev, desc, conf);
>> +     if (IS_ERR(ret))
>> +             /* Just pretend the regulator isn't there */
>> +             dev_err(conf->dev, "Failed to register regulator %s: %ld\n",
>> +                     desc->name, PTR_ERR(ret));
>> +
>> +     of_node_put(conf->of_node);
>> +}
>> +
>>  static int mxs_lradc_probe(struct platform_device *pdev)
>>  {
>>       const struct of_device_id *of_id =
>> @@ -1603,6 +1748,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>>       struct mxs_lradc *lradc;
>>       struct iio_dev *iio;
>>       struct resource *iores;
>> +     struct regulator_config regconf;
>>       int ret = 0, touch_ret;
>>       int i, s;
>>       u64 scale_uv;
>> @@ -1727,6 +1873,12 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>>               goto err_ts;
>>       }
>>
>> +     /* Setup regulator devices for current source. */
>> +     regconf.dev = dev;
>> +     regconf.driver_data = lradc;
>> +     mxs_lradc_reg_helper(node, "ISRC0", &regconf, &lradc->isrc0);
>> +     mxs_lradc_reg_helper(node, "ISRC1", &regconf, &lradc->isrc1);
>> +
>>       return 0;
>>
>>  err_ts:
>>
>
>
> --
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
