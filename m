Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43659 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdCYRUf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 13:20:35 -0400
Subject: Re: [PATCH v2 2/2] iio: Aspeed AST2400/AST2500 ADC
To: Joel Stanley <joel@jms.id.au>, Rick Altherr <raltherr@google.com>
References: <20170321204828.31303-1-raltherr@google.com>
 <20170321204828.31303-2-raltherr@google.com>
 <CACPK8XeR=mDhJgGSO04jLAjdOH_oFuvbYC9Ge7J6HQuiLZ4MZQ@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Message-ID: <ce9b53d1-dd91-fa29-5206-f5728a40ad62@kernel.org>
Date: Sat, 25 Mar 2017 17:20:31 +0000
MIME-Version: 1.0
In-Reply-To: <CACPK8XeR=mDhJgGSO04jLAjdOH_oFuvbYC9Ge7J6HQuiLZ4MZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/03/17 09:47, Joel Stanley wrote:
> On Wed, Mar 22, 2017 at 7:18 AM, Rick Altherr <raltherr@google.com> wrote:
>> Aspeed AST2400/AST2500 BMC SoCs include a 16 channel, 10-bit ADC. Low
>> and high threshold interrupts are supported by the hardware but are not
>> currently implemented.
>>
>> Signed-off-by: Rick Altherr <raltherr@google.com>
> 
> Looks good Rick. I gave it a review from the perspective of the Aspeed
> soc. I also gave it a spin on the Aspeed AST2500 EVB which mostly
> worked, but uncovered some things that need addressing.
Few follow ups inline...  Busy week so I'm playing catch up on this.
> 
> My device tree additions looked like this:
> 
>   adc: adc@1e6e9000 {
>           compatible = "aspeed,ast2500-adc";
>           reg = <0x1e6e9000 0xb0>;
>           clocks = <&clk_apb>;
>           #io-channel-cells = <1>;
> 
>           pinctrl-names = "default";
>           pinctrl-0 = <&pinctrl_adc0_default>;
>   };
> 
>   iio-hwmon {
>           compatible = "iio-hwmon";
>           io-channels = <&adc 0>;
>   };
> 
> I got this output from lm-sensors when booted:
> 
> iio_hwmon-isa-0000
> Adapter: ISA adapter
> in1:          +1.28 V
> 
> I then wired up ADC0 to ADC_12V_TW on the EVB. The above changed to:
> 
>  iio_hwmon-isa-0000
> Adapter: ISA adapter
> in1:          +1.80 V
> 
> ADC_12V_TW is the 12V rail sampled through a voltage divider. The
> voltage should be: 12 * 680 / ( 5600 + 680) = 1.299
> 
> cat /sys/bus/iio/devices/iio:device0/in_voltage1_raw
> 738
> 
> 738 / 1023 * 1.8 = 1.2975
> 
> Looks like the first channel is working! However our reference is
> incorrect. Your driver has ASPEED_ADC_REF_VOLTAGE but doesn't use it.
> It does hardcode 2500 in the aspeed_adc_read_raw callback:
> 
>           case IIO_CHAN_INFO_SCALE:
>                   *val = 2500; // mV
>                   *val2 = 10;
>                   return IIO_VAL_FRACTIONAL_LOG2;
> 
> Should this value the the constant you define?
> 
> Regardless, I don't think the reference voltage should be a constant.
> This is going to vary from system to system. Can we put it in the
> device tree? I notice other devices have vref-supply in their
> bindings.
> 
> I noticed that in_voltage_scale is writable. However, it did not
> accept any of the values I give it. Is this because we do not handle
> it in aspeed_adc_write_raw?
Yeah, that's an ugly quirk of IIO I wish we had done differently.
We don't have separate masks for read and write attributes, so there is
no way to have the attributes for the file set correctly.

> 
> I suggest we add the reference in the device tree bindings, and also
> allow the value to be updated from userspace.
Not keen on updating from userspace, but indeed to providing it from
device tree.  If there is a board out there where it is wrong the devicetree
should be fixed rather than applying a userspace hack.  It's not as though
this device is likely to be accurate enough to warant a calibration procedure.
> 
>> ---
>>
>> Changes in v2:
>> - Rewritten as an IIO device
>> - Renamed register macros to describe the register's purpose
>> - Replaced awkward reading of 16-bit data registers with readw()
>> - Added Kconfig dependency on COMPILE_TEST
>>
>>  drivers/iio/adc/Kconfig      |  10 ++
>>  drivers/iio/adc/Makefile     |   1 +
>>  drivers/iio/adc/aspeed_adc.c | 271 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 282 insertions(+)
>>  create mode 100644 drivers/iio/adc/aspeed_adc.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 2268a6fb9865..9672d799a3fb 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -130,6 +130,16 @@ config AD799X
>>           To compile this driver as a module, choose M here: the module will be
>>           called ad799x.
>>
>> +config ASPEED_ADC
>> +       tristate "Aspeed AST2400/AST2500 ADC"
> 
> You could just say Aspeed ADC to save us having to update it when the
> ast2600 comes out.
That's fine (and definitely a good thing if we end up supporting 20 different
variants in a few years time) but make sure to add it to the help text below
so there is something to grep for.
> 
>> +       depends on ARCH_ASPEED || COMPILE_TEST
>> +       help
>> +         If you say yes here you get support for the Aspeed AST2400/AST2500
>> +         ADC.
>> +
>> +         To compile this driver as a module, choose M here: the module will be
>> +         called aspeed_adc.
> 
> Don't forget to test compiling as a module.
> 
> 
>> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
>> new file mode 100644
>> index 000000000000..9220909aefd4
>> --- /dev/null
> 
>> +#define ASPEED_ADC_NUM_CHANNELS                        16
>> +#define ASPEED_ADC_REF_VOLTAGE                 2500 /* millivolts */
>> +#define ASPEED_ADC_RESOLUTION_BITS             10
>> +#define ASPEED_ADC_MIN_SAMP_RATE               10000
>> +#define ASPEED_ADC_MAX_SAMP_RATE               500000
>> +#define ASPEED_ADC_CLOCKS_PER_SAMPLE           12
>> +
>> +#define ASPEED_ADC_REG_ENGINE_CONTROL          0x00
>> +#define ASPEED_ADC_REG_INTERRUPT_CONTROL       0x04
>> +#define ASPEED_ADC_REG_VGA_DETECT_CONTROL      0x08
>> +#define ASPEED_ADC_REG_CLOCK_CONTROL           0x0C
>> +#define ASPEED_ADC_REG_MAX                     0xC0
>> +
>> +#define ASPEED_ADC_OPERATION_MODE_POWER_DOWN   (0x0 << 1)
>> +#define ASPEED_ADC_OPERATION_MODE_STANDBY      (0x1 << 1)
>> +#define ASPEED_ADC_OPERATION_MODE_NORMAL       (0x7 << 1)
>> +
>> +#define ASPEED_ADC_ENGINE_ENABLE       BIT(0)
> 
> Nit: You could chose to label these with a shorter prefix. Drop the
> aspeed or adc, or both.
> 
>> +
>> +static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>> +                              struct iio_chan_spec const *chan,
>> +                              int *val, int *val2, long mask)
>> +{
>> +       struct aspeed_adc_data *data = iio_priv(indio_dev);
>> +
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_RAW:
>> +               *val = readw(data->base + chan->address);
>> +               return IIO_VAL_INT;
>> +
>> +       case IIO_CHAN_INFO_SCALE:
>> +               *val = 2500; // mV
>> +               *val2 = 10;
> 
> What does 10 mean?
> 
>> +               return IIO_VAL_FRACTIONAL_LOG2;
>> +
>> +       case IIO_CHAN_INFO_SAMP_FREQ:
>> +               *val = clk_get_rate(data->clk_scaler->clk) /
>> +                               ASPEED_ADC_CLOCKS_PER_SAMPLE;
>> +               return IIO_VAL_INT;
>> +
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +}
>> +
>> +static int aspeed_adc_write_raw(struct iio_dev *indio_dev,
>> +                               struct iio_chan_spec const *chan,
>> +                               int val, int val2, long mask)
>> +{
>> +       struct aspeed_adc_data *data = iio_priv(indio_dev);
>> +
>> +       switch (mask) {
> 
> Handle IIO_CHAN_INFO_SCALE here too.
> 
>> +       case IIO_CHAN_INFO_SAMP_FREQ:
>> +               if (val < ASPEED_ADC_MIN_SAMP_RATE ||
>> +                   val > ASPEED_ADC_MAX_SAMP_RATE)
>> +                       return -EINVAL;
>> +
>> +               clk_set_rate(data->clk_scaler->clk,
>> +                               val * ASPEED_ADC_CLOCKS_PER_SAMPLE);
>> +               return 0;
>> +
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +}
>> +
>> +static int aspeed_adc_reg_access(struct iio_dev *indio_dev,
>> +                                unsigned int reg, unsigned int writeval,
>> +                                unsigned int *readval)
>> +{
>> +       struct aspeed_adc_data *data = iio_priv(indio_dev);
>> +
>> +       if (!readval || reg % 4 || reg > ASPEED_ADC_REG_MAX)
>> +               return -EINVAL;
>> +
>> +       *readval = readl(data->base + reg);
>> +       return 0;
>> +}
>> +
>> +static const struct iio_info aspeed_adc_iio_info = {
>> +       .driver_module = THIS_MODULE,
>> +       .read_raw = &aspeed_adc_read_raw,
>> +       .write_raw = &aspeed_adc_write_raw,
>> +       .debugfs_reg_access = &aspeed_adc_reg_access,
>> +};
>> +
>> +static int aspeed_adc_probe(struct platform_device *pdev)
>> +{
>> +       struct iio_dev *indio_dev;
>> +       struct aspeed_adc_data *data;
>> +       struct resource *res;
>> +       const char *clk_parent_name;
>> +       int ret;
>> +       u32 adc_engine_control_reg_val;
>> +
>> +       indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
>> +       if (!indio_dev) {
>> +               dev_err(&pdev->dev, "Failed allocating iio device\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       data = iio_priv(indio_dev);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       data->base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(data->base)) {
>> +               dev_err(&pdev->dev, "Failed allocating device resources\n");
> 
> The function you're calling will do that for you
> 
> http://lxr.free-electrons.com/source/lib/devres.c?v=4.10#L134
> 
> Just return the error here. I'd consider dropping the dev_errs for the
> other cases in the probe. We still get a reasonable error message
> without printing something ourselves. For example, when bailing out
> with ENOMEM:
> 
> [    5.510000] aspeed_adc: probe of 1e6e9000.adc failed with error -12
> 
> 
>> +               ret = PTR_ERR(data->base);
>> +               goto resource_error;
>> +       }
>> +
>> +       /* Register ADC clock prescaler with source specified by device tree. */
>> +       spin_lock_init(&data->clk_lock);
>> +       clk_parent_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
>> +
>> +       data->clk_prescaler = clk_hw_register_divider(
>> +                               &pdev->dev, "prescaler", clk_parent_name, 0,
>> +                               data->base + ASPEED_ADC_REG_CLOCK_CONTROL,
>> +                               17, 15, 0, &data->clk_lock);
> 
> I couldn't see any other drivers that use these functions outside of
> drivers/clk. I like what you've done here, but someone who understands
> the clock framework should take a look.
Agreed on both counts.
> 
> 
>> +       if (IS_ERR(data->clk_prescaler)) {
>> +               dev_err(&pdev->dev, "Failed allocating prescaler clock\n");
>> +               ret = PTR_ERR(data->clk_prescaler);
>> +               goto prescaler_error;
>> +       }
>> +
>> +       /*
>> +        * Register ADC clock scaler downstream from the prescaler. Allow rate
>> +        * setting to adjust the prescaler as well.
>> +        */
>> +       data->clk_scaler = clk_hw_register_divider(
>> +                               &pdev->dev, "scaler", "prescaler",
>> +                               CLK_SET_RATE_PARENT,
>> +                               data->base + ASPEED_ADC_REG_CLOCK_CONTROL,
>> +                               0, 10, 0, &data->clk_lock);
>> +       if (IS_ERR(data->clk_scaler)) {
>> +               dev_err(&pdev->dev, "Failed allocating scaler clock\n");
>> +               ret = PTR_ERR(data->clk_scaler);
>> +               goto scaler_error;
>> +       }
>> +
>> +       /* Start all channels in normal mode. */
>> +       clk_prepare_enable(data->clk_scaler->clk);
>> +       adc_engine_control_reg_val = GENMASK(31, 16) |
>> +               ASPEED_ADC_OPERATION_MODE_NORMAL | ASPEED_ADC_ENGINE_ENABLE;
>> +       writel(adc_engine_control_reg_val,
>> +               data->base + ASPEED_ADC_REG_ENGINE_CONTROL);
>> +
>> +       indio_dev->name = dev_name(&pdev->dev);
>> +       indio_dev->dev.parent = &pdev->dev;
>> +       indio_dev->info = &aspeed_adc_iio_info;
>> +       indio_dev->modes = INDIO_DIRECT_MODE;
>> +       indio_dev->channels = aspeed_adc_iio_channels;
>> +       indio_dev->num_channels = ARRAY_SIZE(aspeed_adc_iio_channels);
> 
> Should we be able to enable just the channels that we want? Perhaps
> only the ones that are requested through the device tree?
That is sometimes done for SoC ADCs as often people don't wire all
the channels out on a given board.  Lots of examples in tree...
Leads to a slightly more fiddly driver, but not too bad.
> 
>> +
>> +       ret = iio_device_register(indio_dev);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Could't register the device.\n");
>> +               goto iio_register_error;
>> +       }
>> +
>> +       return 0;
>> +
>> +iio_register_error:
>> +       writel(0x0, data->base + ASPEED_ADC_REG_ENGINE_CONTROL);
> 
> Should this be done in remove as well?
> 
>> +       clk_disable_unprepare(data->clk_scaler->clk);
>> +       clk_hw_unregister_divider(data->clk_scaler);
>> +
>> +scaler_error:
>> +       clk_hw_unregister_divider(data->clk_prescaler);
>> +
>> +prescaler_error:
>> +resource_error:
>> +       return ret;
> 
> You could just return from the error where it happens in the case
> where no cleanup is required.
> 
>> +}
>> +
>> +static int aspeed_adc_remove(struct platform_device *pdev)
>> +{
>> +       struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +       struct aspeed_adc_data *data = iio_priv(indio_dev);
>> +
>> +       iio_device_unregister(indio_dev);
>> +       clk_disable_unprepare(data->clk_scaler->clk);
>> +       clk_hw_unregister_divider(data->clk_scaler);
>> +       clk_hw_unregister_divider(data->clk_prescaler);
>> +
>> +       return 0;
>> +}
>> +
>> +const struct of_device_id aspeed_adc_matches[] = {
>> +       { .compatible = "aspeed,ast2400-adc" },
>> +       { .compatible = "aspeed,ast2500-adc" },
>> +};
> 
> This is missing a null entry to terminate.
> 
>> +MODULE_DEVICE_TABLE(of, aspeed_adc_matches);
>> +
>> +static struct platform_driver aspeed_adc_driver = {
>> +       .probe = aspeed_adc_probe,
>> +       .remove = aspeed_adc_remove,
>> +       .driver = {
>> +               .name = KBUILD_MODNAME,
>> +               .of_match_table = aspeed_adc_matches,
>> +       }
>> +};
>> +
>> +module_platform_driver(aspeed_adc_driver);
>> +
>> +MODULE_AUTHOR("Rick Altherr <raltherr@google.com>");
>> +MODULE_DESCRIPTION("Aspeed AST2400/2500 ADC Driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.12.1.500.gab5fba24ee-goog
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

