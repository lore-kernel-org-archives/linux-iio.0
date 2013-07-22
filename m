Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50659 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755305Ab3GVNSW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2013 09:18:22 -0400
Date: Mon, 22 Jul 2013 14:17:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Josh Wu <josh.wu@atmel.com>
Cc: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"nicolas.ferre@atmel.com" <nicolas.ferre@atmel.com>,
	"maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>,
	"plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/5] iio: at91: introduce touch screen support in iio
 adc driver
Message-ID: <20130722131747.GA32221@e106331-lin.cambridge.arm.com>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-6-git-send-email-josh.wu@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373789069-11604-6-git-send-email-josh.wu@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 14, 2013 at 09:04:29AM +0100, Josh Wu wrote:
> AT91 ADC hardware integrate touch screen support. So this patch add touch
> screen support for at91 adc iio driver.
> To enable touch screen support in adc, you need to add the dt parameters:
>   which type of touch are used? (4 or 5 wires), sample period time,
>   pen detect debounce time, average samples and pen detect resistor.
> 
> In the meantime, since touch screen will use a interal period trigger of adc,
> so it is conflict to other hardware triggers. Driver will disable the hardware
> trigger support if touch screen is enabled.
> 
> This driver has been tested in AT91SAM9X5-EK and SAMA5D3x-EK.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  .../devicetree/bindings/arm/atmel-adc.txt          |   13 +
>  arch/arm/mach-at91/include/mach/at91_adc.h         |   34 ++
>  drivers/iio/adc/at91_adc.c                         |  389 ++++++++++++++++++--
>  3 files changed, 412 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> index 0db2945..925d656 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> @@ -29,6 +29,19 @@ Optional properties:
>    - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
>    - atmel,adc-clock-rate: ADC clock rate. If not specified, use the default
>                           adc_op_clk.
> +  - atmel,adc-touchscreen-wires: Number of touch screen wires. Only support
> +                                4 and 5 wires touch screen.

Are 4 and 5 wire configurations that can exist, or the only ones
supported by the driver?

> +    NOTE: when adc touch screen enabled, the adc hardware trigger will be
> +          disabled. Since touch screen will occupied the trigger register.
> +  - atmel,adc-ts-pendet-debounce: Debounce time in microsecond for touch pen
> +                                 detect.

For consistency with the adc-touchscreen-wires property, and  other
properties with timing information, how about
atmel,adc-touchscreen-debounce-delay-us ?

> +  - atmel,adc-ts-sample-period-time: Sample Period Time in microsecond for
> +                                    touch screen

Again, please be consistent with ts or touchscreen. It may also be good
to have -us to make the units explicit (though it does leave the
property name being quite a mothful):

atmel,adc-touchscreen-sample-period-us ?

> +  - atmel,adc-ts-filter-average: Numbers of sampling data will be averaged.
> +    0 means no average. 1 means average two samples. 2 means average four
> +    samples. 3 means average eight samples.

Is this averaging done in the hardware, or the kernel driver?

If it's the latter, this can be left for the kernel to decide.

> +  - atmel,adc-ts-pendet-sensitivity: Pen Detection input pull-up resistor.
> +    It can be 0, 1, 2, 3.

I think "pendet" is a bit opaque. "pen-detect" may be better. What
physical property does this represent (are these discrete values, or an
enumeration)?

Thanks,
Mark.

> 
>  Optional trigger Nodes:
>    - Required properties:
> diff --git a/arch/arm/mach-at91/include/mach/at91_adc.h b/arch/arm/mach-at91/include/mach/at91_adc.h
> index ab273ee..6d6cc14 100644
> --- a/arch/arm/mach-at91/include/mach/at91_adc.h
> +++ b/arch/arm/mach-at91/include/mach/at91_adc.h
> @@ -57,10 +57,44 @@
>  #define AT91_ADC_IER           0x24            /* Interrupt Enable Register */
>  #define AT91_ADC_IDR           0x28            /* Interrupt Disable Register */
>  #define AT91_ADC_IMR           0x2C            /* Interrupt Mask Register */
> +#define                AT91_ADC_IER_PEN        (1 << 29)
> +#define                AT91_ADC_IER_NOPEN      (1 << 30)
> +#define                AT91_ADC_IER_XRDY       (1 << 20)
> +#define                AT91_ADC_IER_YRDY       (1 << 21)
> +#define                AT91_ADC_IER_PRDY       (1 << 22)
> +#define                AT91_ADC_ISR_PENS       (1 << 31)
> 
>  #define AT91_ADC_CHR(n)                (0x30 + ((n) * 4))      /* Channel Data Register N */
>  #define                AT91_ADC_DATA           (0x3ff)
> 
> +#define AT91_ADC_ACR           0x94    /* Analog Control Register */
> +#define                AT91_ADC_ACR_PENDETSENS (0x3 << 0)      /* pull-up resistor */
> +
> +#define AT91_ADC_TSMR          0xB0
> +#define                AT91_ADC_TSMR_TSMODE    (3 << 0)        /* Touch Screen Mode */
> +#define                        AT91_ADC_TSMR_TSMODE_NONE               (0 << 0)
> +#define                        AT91_ADC_TSMR_TSMODE_4WIRE_NO_PRESS     (1 << 0)
> +#define                        AT91_ADC_TSMR_TSMODE_4WIRE_PRESS        (2 << 0)
> +#define                        AT91_ADC_TSMR_TSMODE_5WIRE              (3 << 0)
> +#define                AT91_ADC_TSMR_TSAV      (3 << 4)        /* Averages samples */
> +#define                        AT91_ADC_TSMR_TSAV_(x)          ((x) << 4)
> +#define                AT91_ADC_TSMR_SCTIM     (0x0f << 16)    /* Switch closure time */
> +#define                AT91_ADC_TSMR_PENDBC    (0x0f << 28)    /* Pen Debounce time */
> +#define                        AT91_ADC_TSMR_PENDBC_(x)        ((x) << 28)
> +#define                AT91_ADC_TSMR_NOTSDMA   (1 << 22)       /* No Touchscreen DMA */
> +#define                AT91_ADC_TSMR_PENDET_DIS        (0 << 24)       /* Pen contact detection disable */
> +#define                AT91_ADC_TSMR_PENDET_ENA        (1 << 24)       /* Pen contact detection enable */
> +
> +#define AT91_ADC_TSXPOSR       0xB4
> +#define AT91_ADC_TSYPOSR       0xB8
> +#define AT91_ADC_TSPRESSR      0xBC
> +
>  #define AT91_ADC_VERSION       0xFC
> 
> +/* Trigger Register bit field */
> +#define                AT91_ADC_TRGR_TRGPER    (0xffff << 16)
> +#define                        AT91_ADC_TRGR_TRGPER_(x)        ((x) << 16)
> +#define                AT91_ADC_TRGR_TRGMOD    (0x7 << 0)
> +#define                        AT91_ADC_TRGR_MOD_PERIOD_TRIG   (5 << 0)
> +
>  #endif
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 8f1386f..ffc0e42 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -11,6 +11,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> @@ -39,12 +40,24 @@
>  #define at91_adc_writel(st, reg, val) \
>         (writel_relaxed(val, st->reg_base + reg))
> 
> +#define DRIVER_NAME            "at91_adc"
> +#define MAX_POS_BITS           12
> +
> +#define ZTHRESHOLD             9000
> +
>  struct at91_adc_caps {
> +       bool    has_12bits_xy;  /* true means use 12 bits. Otherwise 10 bits */
>         bool    has_tsmr;       /* only at91sam9x5, sama5d3 have TSMR reg */
>         u32     mr_prescal_mask;
>         u32     mr_startup_mask;
>  };
> 
> +enum atmel_adc_ts_type {
> +       ATMEL_ADC_TOUCHSCREEN_NONE = 0,
> +       ATMEL_ADC_TOUCHSCREEN_4WIRE,
> +       ATMEL_ADC_TOUCHSCREEN_5WIRE,
> +};
> +
>  struct at91_adc_state {
>         struct clk              *adc_clk;
>         u32                     adc_clk_rate;
> @@ -70,6 +83,29 @@ struct at91_adc_state {
>         bool                    low_res;        /* the resolution corresponds to the lowest one */
>         wait_queue_head_t       wq_data_avail;
>         struct at91_adc_caps    caps;
> +
> +       /*
> +        * Following ADC channels are shared by touchscreen:
> +        *
> +        * CH0 -- Touch screen XP/UL
> +        * CH1 -- Touch screen XM/UR
> +        * CH2 -- Touch screen YP/LL
> +        * CH3 -- Touch screen YM/Sense
> +        * CH4 -- Touch screen LR(5-wire only)
> +        *
> +        * The bitfields below represents the reserved channel in the
> +        * touchscreen mode.
> +        */
> +#define CHAN_MASK_TOUCHSCREEN_4WIRE    (0xf << 0)
> +#define CHAN_MASK_TOUCHSCREEN_5WIRE    (0x1f << 0)
> +       enum atmel_adc_ts_type  touchscreen_type;
> +       struct input_dev                *ts_input;
> +
> +       u8                      ts_filter_average;
> +       u16                     ts_pen_detect_debounce;
> +       u8                      ts_pen_detect_sensitivity;
> +       u16                     ts_sample_period_time;
> +       u16                     ts_sample_period_val;
>  };
> 
>  static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
> @@ -104,14 +140,10 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>         return IRQ_HANDLED;
>  }
> 
> -static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
> +/* Handler for classic adc channel eoc trigger */
> +void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
>  {
> -       struct iio_dev *idev = private;
>         struct at91_adc_state *st = iio_priv(idev);
> -       u32 status = at91_adc_readl(st, st->registers->status_register);
> -
> -       if (!(status & st->registers->drdy_mask))
> -               return IRQ_HANDLED;
> 
>         if (iio_buffer_enabled(idev)) {
>                 disable_irq_nosync(irq);
> @@ -121,6 +153,115 @@ static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
>                 st->done = true;
>                 wake_up_interruptible(&st->wq_data_avail);
>         }
> +}
> +
> +static int at91_ts_sample(struct at91_adc_state *st)
> +{
> +       unsigned int xscale, yscale, reg, z1, z2;
> +       unsigned int x, y, pres, xpos, ypos;
> +       unsigned int rxp = 1;
> +       unsigned int factor = 1000;
> +       struct iio_dev *idev = iio_priv_to_dev(st);
> +
> +       unsigned int xyz_mask_bits = st->caps.has_12bits_xy ? 12 : 10;
> +       unsigned int xyz_mask = (1 << xyz_mask_bits) - 1;
> +
> +       /* calculate position */
> +       /* x position = (x / xscale) * max, max = 2^MAX_POS_BITS - 1 */
> +       reg = at91_adc_readl(st, AT91_ADC_TSXPOSR);
> +       xpos = reg & xyz_mask;
> +       x = (xpos << MAX_POS_BITS) - xpos;
> +       xscale = (reg >> 16) & xyz_mask;
> +       if (xscale != 0)
> +               x /= xscale;
> +       else
> +               dev_err(&idev->dev, "xscale == 0!!!\n");
> +
> +       /* y position = (y / yscale) * max, max = 2^MAX_POS_BITS - 1 */
> +       reg = at91_adc_readl(st, AT91_ADC_TSYPOSR);
> +       ypos = reg & xyz_mask;
> +       y = (ypos << MAX_POS_BITS) - ypos;
> +       yscale = (reg >> 16) & xyz_mask;
> +       if (yscale != 0)
> +               y /= yscale;
> +       else
> +               dev_err(&idev->dev, "yscale == 0!!!\n");
> +
> +       /* calculate the pressure */
> +       reg = at91_adc_readl(st, AT91_ADC_TSPRESSR);
> +       z1 = reg & xyz_mask;
> +       z2 = (reg >> 16) & xyz_mask;
> +
> +       if (z1 != 0)
> +               pres = rxp * (x * factor / 1024) * (z2 * factor / z1 - factor)
> +                       / factor;
> +       else
> +               pres = ZTHRESHOLD;      /* no pen contacted */
> +
> +       dev_dbg(&idev->dev, "xpos = %d, xscale = %d, ypos = %d, yscale = %d, z1 = %d, z2 = %d, press = %d\n",
> +                               xpos, xscale, ypos, yscale, z1, z2, pres);
> +
> +       if (pres < ZTHRESHOLD) {
> +               dev_dbg(&idev->dev, "x = %d, y = %d, pressure = %d\n",
> +                                       x, y, pres / factor);
> +               input_report_abs(st->ts_input, ABS_X, x);
> +               input_report_abs(st->ts_input, ABS_Y, y);
> +               input_report_abs(st->ts_input, ABS_PRESSURE, pres);
> +               input_report_key(st->ts_input, BTN_TOUCH, 1);
> +               input_sync(st->ts_input);
> +       } else {
> +               dev_dbg(&idev->dev,
> +                               "pressure too low: not reporting\n");
> +       }
> +
> +       return 0;
> +}
> +
> +
> +static irqreturn_t at91_adc_interrupt(int irq, void *private)
> +{
> +       struct iio_dev *idev = private;
> +       struct at91_adc_state *st = iio_priv(idev);
> +       u32 status = at91_adc_readl(st, st->registers->status_register);
> +       const uint32_t ts_data_irq_mask =
> +               AT91_ADC_IER_XRDY |
> +               AT91_ADC_IER_YRDY |
> +               AT91_ADC_IER_PRDY;
> +
> +       if (status & st->registers->drdy_mask)
> +               handle_adc_eoc_trigger(irq, idev);
> +
> +       if (status & AT91_ADC_IER_PEN) {
> +               at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_PEN);
> +               at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_NOPEN |
> +                       ts_data_irq_mask);
> +               /* Set up period trigger for sampling */
> +               at91_adc_writel(st, st->registers->trigger_register,
> +                       AT91_ADC_TRGR_MOD_PERIOD_TRIG |
> +                       AT91_ADC_TRGR_TRGPER_(st->ts_sample_period_val));
> +       } else if (status & AT91_ADC_IER_NOPEN) {
> +               at91_adc_writel(st, st->registers->trigger_register, 0);
> +               at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_NOPEN |
> +                       ts_data_irq_mask);
> +               at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_PEN);
> +
> +               input_report_key(st->ts_input, BTN_TOUCH, 0);
> +               input_sync(st->ts_input);
> +       } else if ((status & ts_data_irq_mask) == ts_data_irq_mask) {
> +               /* Now all touchscreen data is ready */
> +
> +               if (status & AT91_ADC_ISR_PENS) {
> +                       /* validate data by pen contact */
> +                       at91_ts_sample(st);
> +               } else {
> +                       /* triggered by event that is no pen contact, just read
> +                        * them to clean the interrupt and discard all.
> +                        */
> +                       at91_adc_readl(st, AT91_ADC_TSXPOSR);
> +                       at91_adc_readl(st, AT91_ADC_TSYPOSR);
> +                       at91_adc_readl(st, AT91_ADC_TSPRESSR);
> +               }
> +       }
> 
>         return IRQ_HANDLED;
>  }
> @@ -130,6 +271,16 @@ static int at91_adc_channel_init(struct iio_dev *idev)
>         struct at91_adc_state *st = iio_priv(idev);
>         struct iio_chan_spec *chan_array, *timestamp;
>         int bit, idx = 0;
> +       unsigned long rsvd_mask = 0;
> +
> +       /* If touchscreen is enable, then reserve the adc channels */
> +       if (st->touchscreen_type == ATMEL_ADC_TOUCHSCREEN_4WIRE)
> +               rsvd_mask = CHAN_MASK_TOUCHSCREEN_4WIRE;
> +       else if (st->touchscreen_type == ATMEL_ADC_TOUCHSCREEN_5WIRE)
> +               rsvd_mask = CHAN_MASK_TOUCHSCREEN_5WIRE;
> +
> +       /* set up the channel mask to reserve touchscreen channels */
> +       st->channels_mask &= ~rsvd_mask;
> 
>         idev->num_channels = bitmap_weight(&st->channels_mask,
>                                            st->num_channels) + 1;
> @@ -561,6 +712,57 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>                 i++;
>         }
> 
> +       /* Check if touchscreen is enabled in DT. */
> +       ret = of_property_read_u32(node, "atmel,adc-touchscreen-wires", &prop);
> +       if (ret)
> +               dev_info(&idev->dev, "Touchscreen not enabled.\n");
> +       else if (prop == 4)
> +               st->touchscreen_type = ATMEL_ADC_TOUCHSCREEN_4WIRE;
> +       else if (prop == 5)
> +               st->touchscreen_type = ATMEL_ADC_TOUCHSCREEN_5WIRE;
> +       else
> +               dev_warn(&idev->dev, "Unsupported number of touchscreen wires (%d)\n",
> +                               prop);
> +
> +       if (st->touchscreen_type == ATMEL_ADC_TOUCHSCREEN_NONE)
> +               return 0;
> +
> +       /* Touch screen is enabled, so check touch screen dt parameters */
> +       if (of_property_read_u32(node, "atmel,adc-ts-filter-average", &prop)) {
> +               dev_err(&idev->dev, "Missing atmel,adc-ts-filtering-average property in the DT.\n");
> +               ret = -EINVAL;
> +               goto error_ret;
> +       }
> +       st->ts_filter_average = prop;
> +       if (st->ts_filter_average > 3) {
> +               dev_err(&idev->dev, "Invalid atmel,adc-ts-filtering-average property in the DT.\n");
> +               ret = -EINVAL;
> +               goto error_ret;
> +       }
> +
> +       prop = 0;
> +       of_property_read_u32(node, "atmel,adc-ts-pendet-debounce", &prop);
> +       st->ts_pen_detect_debounce = prop;
> +
> +       /* default sample period is 2ms. The real touch sample period should be
> +        * this period * TSFREQ.
> +        */
> +       prop = 2000;
> +       of_property_read_u32(node, "atmel,adc-ts-sample-period-time", &prop);
> +       st->ts_sample_period_time = prop;
> +
> +       if (of_property_read_u32(node, "atmel,adc-ts-pendet-sensitivity", &prop)) {
> +               dev_err(&idev->dev, "Missing atmel,adc-ts-pendet-sensitivity property in the DT.\n");
> +               ret = -EINVAL;
> +               goto error_ret;
> +       }
> +       st->ts_pen_detect_sensitivity = prop;
> +       if (st->ts_pen_detect_sensitivity > 3) {
> +               dev_err(&idev->dev, "Invalid atmel,adc-ts-pendet-sensitivity property in the DT.\n");
> +               ret = -EINVAL;
> +               goto error_ret;
> +       }
> +
>         return 0;
> 
>  error_ret:
> @@ -592,6 +794,114 @@ static const struct iio_info at91_adc_info = {
>         .read_raw = &at91_adc_read_raw,
>  };
> 
> +/* Touchscreen related functions */
> +static int atmel_ts_open(struct input_dev *dev)
> +{
> +       struct at91_adc_state *st = input_get_drvdata(dev);
> +
> +       at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_PEN);
> +       return 0;
> +}
> +
> +static void atmel_ts_close(struct input_dev *dev)
> +{
> +       struct at91_adc_state *st = input_get_drvdata(dev);
> +
> +       at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_PEN);
> +}
> +
> +static int at91_ts_hw_init(struct at91_adc_state *st, u32 adc_clk_khz)
> +{
> +       u32 reg = 0, pendbc;
> +       int i = 0;
> +
> +       if (st->touchscreen_type == ATMEL_ADC_TOUCHSCREEN_4WIRE)
> +               reg = AT91_ADC_TSMR_TSMODE_4WIRE_PRESS;
> +       else
> +               reg = AT91_ADC_TSMR_TSMODE_5WIRE;
> +
> +       /* a Pen Detect Debounce Time is necessary for the ADC Touch to avoid
> +        * pen detect noise.
> +        * The formula is : Pen Detect Debounce Time = (2 ^ pendbc) / ADCClock
> +        */
> +       pendbc = round_up(st->ts_pen_detect_debounce * adc_clk_khz / 1000, 1);
> +
> +       while (pendbc >> ++i)
> +               ;       /* Empty! Find the shift offset */
> +       if (abs(pendbc - (1 << i)) < abs(pendbc - (1 << (i - 1))))
> +               pendbc = i;
> +       else
> +               pendbc = i - 1;
> +
> +       if (st->caps.has_tsmr) {
> +               reg |= AT91_ADC_TSMR_TSAV_(st->ts_filter_average)
> +                               & AT91_ADC_TSMR_TSAV;
> +               reg |= AT91_ADC_TSMR_PENDBC_(pendbc) & AT91_ADC_TSMR_PENDBC;
> +               reg |= AT91_ADC_TSMR_NOTSDMA;
> +               reg |= AT91_ADC_TSMR_PENDET_ENA;
> +               reg |= 0x03 << 8;       /* TSFREQ, need bigger than TSAV */
> +
> +               at91_adc_writel(st, AT91_ADC_TSMR, reg);
> +       } else {
> +               /* TODO: for 9g45 which has no TSMR */
> +       }
> +
> +       /* Change adc internal resistor value for better pen detection,
> +        * default value is 100 kOhm.
> +        * 0 = 200 kOhm, 1 = 150 kOhm, 2 = 100 kOhm, 3 = 50 kOhm
> +        * option only available on ES2 and higher
> +        */
> +       at91_adc_writel(st, AT91_ADC_ACR, st->ts_pen_detect_sensitivity
> +                       & AT91_ADC_ACR_PENDETSENS);
> +
> +       /* Sample Peroid Time = (TRGPER + 1) / ADCClock */
> +       st->ts_sample_period_val = round_up((st->ts_sample_period_time *
> +                       adc_clk_khz / 1000) - 1, 1);
> +
> +       return 0;
> +}
> +
> +static int at91_ts_register(struct at91_adc_state *st)
> +{
> +       struct input_dev *input;
> +       struct iio_dev *idev = iio_priv_to_dev(st);
> +       int ret;
> +
> +       input = input_allocate_device();
> +       if (!input) {
> +               dev_err(&idev->dev, "Failed to allocate TS device!\n");
> +               return -ENOMEM;
> +       }
> +
> +       input->name = DRIVER_NAME;
> +       input->id.bustype = BUS_HOST;
> +       input->dev.parent = idev->dev.parent;
> +       input->open = atmel_ts_open;
> +       input->close = atmel_ts_close;
> +
> +       __set_bit(EV_ABS, input->evbit);
> +       __set_bit(EV_KEY, input->evbit);
> +       __set_bit(BTN_TOUCH, input->keybit);
> +       input_set_abs_params(input, ABS_X, 0, (1 << MAX_POS_BITS) - 1, 0, 0);
> +       input_set_abs_params(input, ABS_Y, 0, (1 << MAX_POS_BITS) - 1, 0, 0);
> +       input_set_abs_params(input, ABS_PRESSURE, 0, 0xffffff, 0, 0);
> +
> +       st->ts_input = input;
> +       input_set_drvdata(input, st);
> +
> +       ret = input_register_device(input);
> +       if (ret)
> +               input_free_device(st->ts_input);
> +
> +       return ret;
> +}
> +
> +static void at91_ts_unregister(struct at91_adc_state *st)
> +{
> +       input_unregister_device(st->ts_input);
> +       input_free_device(st->ts_input);
> +}
> +
>  /*
>   * Since atmel adc support different ip for touchscreen mode. Through the
>   * IP check, we will know the touchscreen capbilities.
> @@ -610,6 +920,7 @@ static void atmel_adc_get_cap(struct at91_adc_state *st)
>         /* keep only major version number */
>         switch (version & 0xf00) {
>         case 0x500:     /* SAMA5D3 */
> +               st->caps.has_12bits_xy = 1;
>         case 0x400:     /* AT91SAM9X5/9N12 */
>                 st->caps.has_tsmr = 1;
>                 st->caps.mr_startup_mask = AT91_ADC_STARTUP;
> @@ -683,7 +994,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>         at91_adc_writel(st, AT91_ADC_CR, AT91_ADC_SWRST);
>         at91_adc_writel(st, AT91_ADC_IDR, 0xFFFFFFFF);
>         ret = request_irq(st->irq,
> -                         at91_adc_eoc_trigger,
> +                         at91_adc_interrupt,
>                           0,
>                           pdev->dev.driver->name,
>                           idev);
> @@ -731,6 +1042,10 @@ static int at91_adc_probe(struct platform_device *pdev)
>         adc_clk = st->adc_clk_rate ?
>                 st->adc_clk_rate : clk_get_rate(st->adc_clk);
>         adc_clk_khz = adc_clk / 1000;
> +
> +       dev_dbg(&pdev->dev, "Master clock is set as: %d Hz, adc_clk should set as: %d Hz\n",
> +               mstrclk, adc_clk);
> +
>         prsc = (mstrclk / (2 * adc_clk)) - 1;
> 
>         if (!st->startup_time) {
> @@ -799,30 +1114,52 @@ static int at91_adc_probe(struct platform_device *pdev)
>         init_waitqueue_head(&st->wq_data_avail);
>         mutex_init(&st->lock);
> 
> -       ret = at91_adc_buffer_init(idev);
> -       if (ret < 0) {
> -               dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
> -               goto error_disable_adc_clk;
> -       }
> +       /*
> +        * Since touch screen will set trigger register as period trigger. So
> +        * when touch screen is enabled, then we have to disable hardware
> +        * trigger for classic adc.
> +        */
> +       if (!st->touchscreen_type) {
> +               ret = at91_adc_buffer_init(idev);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
> +                       goto error_disable_adc_clk;
> +               }
> 
> -       ret = at91_adc_trigger_init(idev);
> -       if (ret < 0) {
> -               dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
> -               goto error_unregister_buffer;
> +               ret = at91_adc_trigger_init(idev);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
> +                       at91_adc_buffer_remove(idev);
> +                       goto error_disable_adc_clk;
> +               }
> +       } else {
> +               if (!st->caps.has_tsmr) {
> +                       dev_err(&pdev->dev, "We don't support non-TSMR adc\n");
> +                       goto error_disable_adc_clk;
> +               }
> +
> +               ret = at91_ts_register(st);
> +               if (ret)
> +                       goto error_disable_adc_clk;
> +
> +               at91_ts_hw_init(st, adc_clk_khz);
>         }
> 
>         ret = iio_device_register(idev);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "Couldn't register the device.\n");
> -               goto error_remove_triggers;
> +               goto error_iio_device_register;
>         }
> 
>         return 0;
> 
> -error_remove_triggers:
> -       at91_adc_trigger_remove(idev);
> -error_unregister_buffer:
> -       at91_adc_buffer_remove(idev);
> +error_iio_device_register:
> +       if (!st->touchscreen_type) {
> +               at91_adc_trigger_remove(idev);
> +               at91_adc_buffer_remove(idev);
> +       } else {
> +               at91_ts_unregister(st);
> +       }
>  error_disable_adc_clk:
>         clk_disable_unprepare(st->adc_clk);
>  error_disable_clk:
> @@ -841,8 +1178,12 @@ static int at91_adc_remove(struct platform_device *pdev)
>         struct at91_adc_state *st = iio_priv(idev);
> 
>         iio_device_unregister(idev);
> -       at91_adc_trigger_remove(idev);
> -       at91_adc_buffer_remove(idev);
> +       if (!st->touchscreen_type) {
> +               at91_adc_trigger_remove(idev);
> +               at91_adc_buffer_remove(idev);
> +       } else {
> +               at91_ts_unregister(st);
> +       }
>         clk_disable_unprepare(st->adc_clk);
>         clk_disable_unprepare(st->clk);
>         free_irq(st->irq, idev);
> @@ -861,7 +1202,7 @@ static struct platform_driver at91_adc_driver = {
>         .probe = at91_adc_probe,
>         .remove = at91_adc_remove,
>         .driver = {
> -                  .name = "at91_adc",
> +                  .name = DRIVER_NAME,
>                    .of_match_table = of_match_ptr(at91_adc_dt_ids),
>         },
>  };
> --
> 1.7.10
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
