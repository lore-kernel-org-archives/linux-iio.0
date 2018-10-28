Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46903 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJ2BdL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Oct 2018 21:33:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id k64-v6so5007645oia.13
        for <linux-iio@vger.kernel.org>; Sun, 28 Oct 2018 09:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181028122629.10144-1-martin.blumenstingl@googlemail.com>
 <20181028122629.10144-3-martin.blumenstingl@googlemail.com> <alpine.DEB.2.21.1810281707160.28121@vps.pmeerw.net>
In-Reply-To: <alpine.DEB.2.21.1810281707160.28121@vps.pmeerw.net>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 28 Oct 2018 17:47:50 +0100
Message-ID: <CAFBinCArmv2UAJNA4zRvdgBKospr58D23H0cXM+9ksPP_4_xsg@mail.gmail.com>
Subject: Re: [PATCH 2/7] iio: adc: meson-saradc: add support for the chip's
 temperature sensor
To: pmeerw@pmeerw.net
Cc: linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
        lars@metafoo.de, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,

thank you for taking the time to review my patch!

On Sun, Oct 28, 2018 at 5:19 PM Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>
> On Sun, 28 Oct 2018, Martin Blumenstingl wrote:
>
> comments below
>
> > Channel 6 of the SAR ADC can be switched between two inputs:
> > SAR_ADC_CH6 input (an actual pad on the SoC) and the signal from the
> > temperature sensor inside the SoC.
> >
> > To get usable results from the temperature sensor we need to read the
> > corresponding calibration data from the eFuse and pass it to the SAR ADC
> > (bits [3:0]) and (on Meson8b and Meson8m2) to a scratch register in the
> > HHI region.
> > If the temperature sensor is not calibrated (the eFuse data contains a
> > bit for this) then the driver will return -ENOTSUPP when trying to read
> > the temperature.
> >
> > This only enables the temperature sensor for the Meson8, Meson8b and
> > Meson8m2 SoCs because on the newer, 64-bit SoCs (GXBB, GXL and GXM) the
> > temperature sensor inside SAR ADC is firmware-controlled (by BL30, we
> > can simply use the SCPI hwmon driver to get the chip temperature).
> >
> > To keep the devicetree interface backwards compatible we simply skip the
> > temperature sensor initialization if no eFuse nvmem cell is passed via
> > devicetree.
> >
> > The public documentation for the SAR ADC IP block does not explain how
> > to use the registers to read the temperature. The logic from this patch
> > is based on reading and understanding Amlogic's GPL kernel sources.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/iio/adc/meson_saradc.c | 274 +++++++++++++++++++++++++++++----
> >  1 file changed, 248 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> > index 028ccd218f82..df1e45805c23 100644
> > --- a/drivers/iio/adc/meson_saradc.c
> > +++ b/drivers/iio/adc/meson_saradc.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/io.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/of.h>
> >  #include <linux/of_irq.h>
> > @@ -25,6 +26,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/mfd/syscon.h>
> >
> >  #define MESON_SAR_ADC_REG0                                   0x00
> >       #define MESON_SAR_ADC_REG0_PANEL_DETECT                 BIT(31)
> > @@ -165,6 +167,17 @@
> >
> >  #define MESON_SAR_ADC_MAX_FIFO_SIZE                          32
> >  #define MESON_SAR_ADC_TIMEOUT                                        100 /* ms */
> > +#define MESON_SAR_ADC_VOLTAGE_AND_TEMP_CHANNEL                       6
> > +#define MESON_SAR_ADC_TEMP_OFFSET                            27
> > +
> > +/* temperature sensor calibration information in eFuse */
> > +#define MESON_SAR_ADC_EFUSE_BYTES                            4
> > +#define MESON_SARADC_EFUSE_BYTE3_UPPER_ADC_VAL                       GENMASK(6, 0)
> > +#define MESON_SARADC_EFUSE_BYTE3_IS_CALIBRATED                       BIT(7)
>
> MESON_SAR_ADC_ prefix for consistency?
I missed that, thanks

> > +
> > +#define MESON_HHI_DPLL_TOP_0                                 0x318
> > +#define MESON_HHI_DPLL_TOP_0_TSC_BIT4                                BIT(9)
>
> I guess these do not belog to the SAR ADC at all?
yes and no
these register are part of the HHI register region which is shared the:
- clock controller
- HDMI controller
- IIRC the HDMI PHY as well
- one TSC bit for the SAR ADC
- ...possibly more

currently there's no header file for all the HHI includes because (as
far as I'm aware) each register is only used by one IP block

> > +
> >  /* for use with IIO_VAL_INT_PLUS_MICRO */
> >  #define MILLION                                                      1000000
> >
> > @@ -175,16 +188,27 @@
> >       .address = _chan,                                               \
> >       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                  \
> >                               BIT(IIO_CHAN_INFO_AVERAGE_RAW),         \
> > -     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |          \
> > -                             BIT(IIO_CHAN_INFO_CALIBBIAS) |          \
> > +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),           \
> > +     .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_CALIBBIAS) |       \
> >                               BIT(IIO_CHAN_INFO_CALIBSCALE),          \
> >       .datasheet_name = "SAR_ADC_CH"#_chan,                           \
> >  }
> >
> > -/*
> > - * TODO: the hardware supports IIO_TEMP for channel 6 as well which is
> > - * currently not supported by this driver.
> > - */
> > +#define MESON_SAR_ADC_TEMP_CHAN(_chan) {                             \
> > +     .type = IIO_TEMP,                                               \
> > +     .indexed = 0,                                                   \
>
> .indexed = 0 not needed
OK, I will drop this

> > +     .channel = _chan,                                               \
> > +     .address = MESON_SAR_ADC_VOLTAGE_AND_TEMP_CHANNEL,              \
> > +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                  \
> > +                             BIT(IIO_CHAN_INFO_AVERAGE_RAW),         \
> > +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |         \
> > +                                     BIT(IIO_CHAN_INFO_SCALE) |      \
> > +                                     BIT(IIO_CHAN_INFO_ENABLE),      \
> > +     .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_CALIBBIAS) |       \
> > +                             BIT(IIO_CHAN_INFO_CALIBSCALE),          \
> > +     .datasheet_name = "TEMP_SENSOR",                                \
> > +}
> > +
> >  static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
> >       MESON_SAR_ADC_CHAN(0),
> >       MESON_SAR_ADC_CHAN(1),
> > @@ -197,6 +221,19 @@ static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
> >       IIO_CHAN_SOFT_TIMESTAMP(8),
> >  };
> >
> > +static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
> > +     MESON_SAR_ADC_CHAN(0),
> > +     MESON_SAR_ADC_CHAN(1),
> > +     MESON_SAR_ADC_CHAN(2),
> > +     MESON_SAR_ADC_CHAN(3),
> > +     MESON_SAR_ADC_CHAN(4),
> > +     MESON_SAR_ADC_CHAN(5),
> > +     MESON_SAR_ADC_CHAN(6),
> > +     MESON_SAR_ADC_CHAN(7),
> > +     MESON_SAR_ADC_TEMP_CHAN(8),
> > +     IIO_CHAN_SOFT_TIMESTAMP(9),
> > +};
> > +
> >  enum meson_sar_adc_avg_mode {
> >       NO_AVERAGING = 0x0,
> >       MEAN_AVERAGING = 0x1,
> > @@ -225,6 +262,11 @@ struct meson_sar_adc_param {
> >       u32                                     bandgap_reg;
> >       unsigned int                            resolution;
> >       const struct regmap_config              *regmap_config;
> > +     u8                                      temperature_trimming_bits;
> > +     unsigned int                            temperature_multiplier;
> > +     unsigned int                            temperature_divider;
> > +     const struct iio_chan_spec              *channels;
> > +     unsigned int                            num_channels;
> >  };
> >
> >  struct meson_sar_adc_data {
> > @@ -246,6 +288,10 @@ struct meson_sar_adc_priv {
> >       struct completion                       done;
> >       int                                     calibbias;
> >       int                                     calibscale;
> > +     struct regmap                           *tsc_regmap;
> > +     bool                                    temperature_sensor_calibrated;
> > +     u8                                      temperature_sensor_coefficient;
> > +     u16                                     temperature_sensor_adc_val;
> >  };
> >
> >  static const struct regmap_config meson_sar_adc_regmap_config_gxbb = {
> > @@ -389,9 +435,17 @@ static void meson_sar_adc_enable_channel(struct iio_dev *indio_dev,
> >                          MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_MUX_SEL_MASK,
> >                          regval);
> >
> > -     if (chan->address == 6)
> > -             regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
> > -                                MESON_SAR_ADC_DELTA_10_TEMP_SEL, 0);
> > +     if (chan->address == MESON_SAR_ADC_VOLTAGE_AND_TEMP_CHANNEL) {
>
> quite repetitive, maybe (just a suggestion)
>                 u8 val = chan->type == IIO_TEMP ? MESON_SAR_ADC_DELTA_10_TEMP_SEL : 0;
>                 regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
>                                    MESON_SAR_ADC_DELTA_10_TEMP_SEL, val);
thanks for the suggestion!
I already have a "regval" variable which we can use here
I'll simplify this in the next version - I'll keep the basic if/else
though instead of using a ternary operator (because "regval =
chan->type == IIO_TEMP ? MESON_SAR_ADC_DELTA_10_TEMP_SEL : 0;" would
exceed the line length limit of 80 chars)

> > +             if (chan->type == IIO_TEMP)
> > +                     regmap_update_bits(priv->regmap,
> > +                                        MESON_SAR_ADC_DELTA_10,
> > +                                        MESON_SAR_ADC_DELTA_10_TEMP_SEL,
> > +                                        MESON_SAR_ADC_DELTA_10_TEMP_SEL);
> > +             else
> > +                     regmap_update_bits(priv->regmap,
> > +                                        MESON_SAR_ADC_DELTA_10,
> > +                                        MESON_SAR_ADC_DELTA_10_TEMP_SEL, 0);
> > +     }
> >  }
[snip]


Regards
Martin
