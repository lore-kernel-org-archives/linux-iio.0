Return-Path: <SRS0=vZ7W=23=gmail.com=hkallweit1@kernel.org>
Subject: Re: [PATCH v2] iio: adc: meson-saradc: add calibration for meson gxbb
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <89a21983-b722-cbb8-42db-13c447f2e527@gmail.com>
 <CAFBinCBZECiOuhz9m2F-5gCLpHhiV6XcduER0ntUJe8CHMD=+Q@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <4a7abf38-e820-d31a-5f1f-a1afd6182891@gmail.com>
Date: Sat, 18 Mar 2017 19:30:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAFBinCBZECiOuhz9m2F-5gCLpHhiV6XcduER0ntUJe8CHMD=+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Am 18.03.2017 um 15:04 schrieb Martin Blumenstingl:
> Hi Heiner,
> 
> sorry for the delay, I've been very busy in the last two weeks.
> 
> On Sat, Mar 4, 2017 at 5:29 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> The calibration on Meson GXBB is different from the one on GXM/GXL.
>> This patch only supports GXBB as I don't have other spec and test hw.
>> Points 25% vref and 75% vref are used for calibration.
>>
>> Adding a calibration scale resulted in no improvement, therefore
>> only a simple calibration bias is supported.
>>
>> Successfully tested on a Odroid C2.  Calibbias is 8 on my system.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> v2:
>> - added calibration scale
> your calibration code seems to work fine, I tested this on a Khadas VIM Pro.
> 
> background info:
> on the Khadas VIM SAR_ADC_CH1 is wired to VCC through a resistor to
> indicate the hardware version, according to the schematics [0] on page
> 4 the expected ADC value is 512.
> 512 is due to a bug in Amlogic's Linux saradc driver as it only reads
> 10bit (while the actual hardware supports 12bit). so actually the
> expected ADC value is 2048 (512 << 2).
> I confirmed this in the vendor u-boot by running "aradc_12bit open 1;
> aradc_12bit read" which gives a value of approx. 2000 (u-boot's saradc
> driver doesn't support calibration, so we're pretty close).
> 
> before your patch I got a value of somewhere around 2000, with your
> patch I get values *very* close to 2048.
> thus:
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> some minor comments inline below
> 
>> ---
>>  drivers/iio/adc/meson_saradc.c | 74 ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 72 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>> index 23710088..d5aa0d04 100644
>> --- a/drivers/iio/adc/meson_saradc.c
>> +++ b/drivers/iio/adc/meson_saradc.c
>> @@ -173,7 +173,9 @@
>>         .channel = _chan,                                               \
>>         .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                  \
>>                                 BIT(IIO_CHAN_INFO_AVERAGE_RAW),         \
>> -       .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),           \
>> +       .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |          \
>> +                               BIT(IIO_CHAN_INFO_CALIBBIAS) |          \
>> +                               BIT(IIO_CHAN_INFO_CALIBSCALE),          \
>>         .datasheet_name = "SAR_ADC_CH"#_chan,                           \
>>  }
>>
>> @@ -233,6 +235,8 @@ struct meson_sar_adc_priv {
>>         struct clk                              *adc_div_clk;
>>         struct clk_divider                      clk_div;
>>         struct completion                       done;
>> +       int                                     calibbias;
>> +       int                                     calibscale;
>>  };
>>
>>  static const struct regmap_config meson_sar_adc_regmap_config = {
>> @@ -252,6 +256,16 @@ static unsigned int meson_sar_adc_get_fifo_count(struct iio_dev *indio_dev)
>>         return FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
>>  }
>>
>> +static int meson_sar_adc_calib_val(struct iio_dev *indio_dev, int val)
>> +{
>> +       struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>> +       int tmp;
>> +
>> +       tmp = div_s64((s64)val * priv->calibscale, 1000000) + priv->calibbias;
>> +
>> +       return clamp(tmp, 0, (1 << priv->data->resolution) - 1);
>> +}
>> +
> this logic is slightly different than in Amlogic's driver (which
> basically uses "val - actual_value_of(CHAN7_MUX_VDD_DIV2)" instead of
> "val"), see [1]. this does NOT mean that you have to change your code,
> although it would be nice if you could add a comment how this magic^W
> math works!
> 
The logic here is basically determined by the parameters CALIBSCALE and
CALIBBIAS in the core code.
The calibration function is: SCALE * val + BIAS
I'll add a comment to the calculation.

>>  static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
>>  {
>>         struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>> @@ -303,7 +317,7 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
>>         fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK,
>>                              regval);
>>         fifo_val &= GENMASK(priv->data->resolution - 1, 0);
>> -       *val = fifo_val;
>> +       *val = meson_sar_adc_calib_val(indio_dev, fifo_val);
>>
>>         return 0;
>>  }
>> @@ -529,6 +543,15 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
>>                 *val2 = priv->data->resolution;
>>                 return IIO_VAL_FRACTIONAL_LOG2;
>>
>> +       case IIO_CHAN_INFO_CALIBBIAS:
>> +               *val = priv->calibbias;
>> +               return IIO_VAL_INT;
>> +
>> +       case IIO_CHAN_INFO_CALIBSCALE:
>> +               *val = priv->calibscale / 1000000;
>> +               *val2 = priv->calibscale % 1000000;
> can we add a #define for 1000000? it's used very often in the driver
> which makes it a bit hard to read.
> 
I'll call the define MILLION to make clear it's not a factor that
can be simply changed. This would brake calculation of val2 for
IIO_CHAN_INFO_CALIBSCALE.

>> +               return IIO_VAL_INT_PLUS_MICRO;
>> +
>>         default:
>>                 return -EINVAL;
>>         }
>> @@ -754,6 +777,47 @@ static irqreturn_t meson_sar_adc_irq(int irq, void *data)
>>         return IRQ_HANDLED;
>>  }
>>
>> +static int meson_sar_adc_calib(struct iio_dev *indio_dev)
>> +{
>> +       struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>> +       int ret, nominal0, nominal1, value0, value1;
>> +
>> +       /* use points 25% and 75% for calibration */
>> +       nominal0 = (1 << priv->data->resolution) / 4;
>> +       nominal1 = (1 << priv->data->resolution) * 3 / 4;
>> +
>> +       meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_DIV4);
>> +       usleep_range(10, 20);
>> +       ret = meson_sar_adc_get_sample(indio_dev,
>> +                                      &meson_sar_adc_iio_channels[7],
>> +                                      MEAN_AVERAGING, EIGHT_SAMPLES, &value0);
>> +       if (ret < 0)
>> +               goto out;
>> +
>> +       meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_MUL3_DIV4);
>> +       usleep_range(10, 20);
>> +       ret = meson_sar_adc_get_sample(indio_dev,
>> +                                      &meson_sar_adc_iio_channels[7],
>> +                                      MEAN_AVERAGING, EIGHT_SAMPLES, &value1);
>> +       if (ret < 0)
>> +               goto out;
>> +
>> +       if (value1 <= value0) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       priv->calibscale = div_s64((nominal1 - nominal0) * 1000000LL,
>> +                                  value1 - value0);
>> +       priv->calibbias = nominal0 - div_s64((s64)value0 * priv->calibscale,
>> +                                            1000000);
>> +       ret = 0;
>> +out:
>> +       meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_CH7_INPUT);
>> +
>> +       return ret;
>> +}
>> +
>>  static const struct iio_info meson_sar_adc_iio_info = {
>>         .read_raw = meson_sar_adc_iio_info_read_raw,
>>         .driver_module = THIS_MODULE,
>> @@ -893,6 +957,8 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>>                 return PTR_ERR(priv->vref);
>>         }
>>
>> +       priv->calibscale = 1000000;
>> +
>>         ret = meson_sar_adc_init(indio_dev);
>>         if (ret)
>>                 goto err;
>> @@ -901,6 +967,10 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>>         if (ret)
>>                 goto err;
>>
>> +       ret = meson_sar_adc_calib(indio_dev);
>> +       if (ret)
>> +               goto err_hw;
>> +
> should we fail here if calibration did not work? we could use the
> non-calibrated value as fallback (I think all that would have to be
> done is changing this to not error out, as you're initializing
> calibscale above already, and calibbias will be 0 by default)
> 
Technically, if the calibration fails something is terribly wrong
and most likely all other further samplings will fail too.

But in general you're right, we have a fallback and there's no
urgent need to bail out. So I will change this to just print
a warning that the calibration failed.

>>         platform_set_drvdata(pdev, indio_dev);
>>
>>         ret = iio_device_register(indio_dev);
>> --
>> 2.12.0
>>
>>
> 
> if anyone is interested in before and after statistics:
> 
> values before your patch:
> /sys/bus/iio/devices/iio:device0/in_voltage0_mean_raw:3993
> /sys/bus/iio/devices/iio:device0/in_voltage0_raw:4009
> /sys/bus/iio/devices/iio:device0/in_voltage1_mean_raw:2001
> /sys/bus/iio/devices/iio:device0/in_voltage1_raw:1992
> /sys/bus/iio/devices/iio:device0/in_voltage2_mean_raw:487
> /sys/bus/iio/devices/iio:device0/in_voltage2_raw:408
> /sys/bus/iio/devices/iio:device0/in_voltage3_mean_raw:386
> /sys/bus/iio/devices/iio:device0/in_voltage3_raw:356
> /sys/bus/iio/devices/iio:device0/in_voltage4_mean_raw:466
> /sys/bus/iio/devices/iio:device0/in_voltage4_raw:476
> /sys/bus/iio/devices/iio:device0/in_voltage5_mean_raw:470
> /sys/bus/iio/devices/iio:device0/in_voltage5_raw:469
> /sys/bus/iio/devices/iio:device0/in_voltage6_mean_raw:2199
> /sys/bus/iio/devices/iio:device0/in_voltage6_raw:2197
> /sys/bus/iio/devices/iio:device0/in_voltage7_mean_raw:829
> /sys/bus/iio/devices/iio:device0/in_voltage7_raw:492
> /sys/bus/iio/devices/iio:device0/in_voltage_scale:0.439453125
> /sys/bus/iio/devices/iio:device0/name:meson-gxl-saradc
> 
> values after your patch:
> /sys/bus/iio/devices/iio:device0/in_voltage0_mean_raw:4095
> /sys/bus/iio/devices/iio:device0/in_voltage0_raw:4095
> /sys/bus/iio/devices/iio:device0/in_voltage1_mean_raw:2044
> /sys/bus/iio/devices/iio:device0/in_voltage1_raw:2044
> /sys/bus/iio/devices/iio:device0/in_voltage2_mean_raw:487
> /sys/bus/iio/devices/iio:device0/in_voltage2_raw:404
> /sys/bus/iio/devices/iio:device0/in_voltage3_mean_raw:383
> /sys/bus/iio/devices/iio:device0/in_voltage3_raw:373
> /sys/bus/iio/devices/iio:device0/in_voltage4_mean_raw:466
> /sys/bus/iio/devices/iio:device0/in_voltage4_raw:478
> /sys/bus/iio/devices/iio:device0/in_voltage5_mean_raw:470
> /sys/bus/iio/devices/iio:device0/in_voltage5_raw:472
> /sys/bus/iio/devices/iio:device0/in_voltage6_mean_raw:2269
> /sys/bus/iio/devices/iio:device0/in_voltage6_raw:2257
> /sys/bus/iio/devices/iio:device0/in_voltage7_mean_raw:837
> /sys/bus/iio/devices/iio:device0/in_voltage7_raw:488
> /sys/bus/iio/devices/iio:device0/in_voltage_calibbias:-12
> /sys/bus/iio/devices/iio:device0/in_voltage_calibscale:1.026566
> /sys/bus/iio/devices/iio:device0/in_voltage_scale:0.439453125
> /sys/bus/iio/devices/iio:device0/name:meson-gxl-saradc
> 
> many thanks again for this contribution Heiner!
> 
> 
> Regards,
> Martin
> 
> 
> [0] https://github.com/khadas/documents/blob/master/Vim_V12_Sch.pdf
> [1] https://github.com/khadas/linux/blob/9ff62f1c4e333feb64bc419191215cec2c7c7c73/drivers/amlogic/input/saradc/saradc.c#L174
> 
