Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35196 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756667AbdDFHzI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Apr 2017 03:55:08 -0400
Received: by mail-io0-f194.google.com with SMTP id f103so3575424ioi.2
        for <linux-iio@vger.kernel.org>; Thu, 06 Apr 2017 00:55:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491460627-18685-6-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1491460627-18685-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1491460627-18685-6-git-send-email-mikko.koivunen@fi.rohmeurope.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 6 Apr 2017 10:55:06 +0300
Message-ID: <CAEnQRZCsho7KCjO0wkKJRa5WGR9CT6oz6EbuO7VMgQ-RKiHuxg@mail.gmail.com>
Subject: Re: [PATCH 6/6] iio: light: rpr0521 triggered buffer added
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Apr 6, 2017 at 9:37 AM, Mikko Koivunen
<mikko.koivunen@fi.rohmeurope.com> wrote:
> Driver sets up and uses triggered buffer if there is irq defined for device in
> device tree. Trigger producer triggers from rpr0521 drdy interrupt line.
> Trigger consumer reads rpr0521 data to scan buffer.
> Depends on previous commits of _scale and _offset.
>
> Tested on LeMaker HiKey with AOSP7.1, IIO_HAL and kernel 4.4.
> Builds OK with torvalds/linux 4.9
> checkpatch.pl OK.
>

Comments like this will not matter for commit history. It's only
useful now, so I would suggest adding them under the scissor line.

> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
> ---
^ this is the scissor line.

>  drivers/iio/light/rpr0521.c | 316 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 311 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index fa642b7..22cb097 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -9,9 +9,11 @@
>   *
>   * IIO driver for RPR-0521RS (7-bit I2C slave address 0x38).
>   *
> - * TODO: illuminance channel, PM support, buffer
> + * TODO: illuminance channel, PM support
>   */
>
> +#define RPR0521_TRIGGERS

Why do we need this define?

> +
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
> @@ -20,6 +22,12 @@
>  #include <linux/acpi.h>
>
>  #include <linux/iio/iio.h>
> +#ifdef RPR0521_TRIGGERS
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#endif
>  #include <linux/iio/sysfs.h>
>  #include <linux/pm_runtime.h>
>
> @@ -30,6 +38,7 @@
>  #define RPR0521_REG_PXS_DATA           0x44 /* 16-bit, little endian */
>  #define RPR0521_REG_ALS_DATA0          0x46 /* 16-bit, little endian */
>  #define RPR0521_REG_ALS_DATA1          0x48 /* 16-bit, little endian */
> +#define RPR0521_REG_INTERRUPT          0x4A
>  #define RPR0521_PS_OFFSET_LSB          0x53
>  #define RPR0521_PS_OFFSET_MSB          0x54
>
> @@ -44,16 +53,33 @@
>  #define RPR0521_ALS_DATA1_GAIN_SHIFT   2
>  #define RPR0521_PXS_GAIN_MASK          GENMASK(5, 4)
>  #define RPR0521_PXS_GAIN_SHIFT         4
> +#define RPR0521_PXS_PERSISTENCE_MASK   GENMASK(3, 0)
> +#define RPR0521_INTERRUPT_INT_TRIG_PS_MASK     BIT(0)
> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_MASK    BIT(1)
> +#define RPR0521_INTERRUPT_INT_LATCH_MASK       BIT(2)
> +#define RPR0521_INTERRUPT_INT_REASSERT_MASK    BIT(3)
> +#define RPR0521_INTERRUPT_INT_MODE_MASK                GENMASK(5, 4)
>
>  #define RPR0521_MODE_ALS_ENABLE                BIT(7)
>  #define RPR0521_MODE_ALS_DISABLE       0x00
>  #define RPR0521_MODE_PXS_ENABLE                BIT(6)
>  #define RPR0521_MODE_PXS_DISABLE       0x00
> +#define RPR0521_PXS_PERSISTENCE_DRDY   0x00
> +#define RPR0521_INTERRUPT_INT_TRIG_PS_ENABLE   BIT(0)
> +#define RPR0521_INTERRUPT_INT_TRIG_PS_DISABLE  0x00
> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_ENABLE  BIT(1)
> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE 0x00
> +#define RPR0521_INTERRUPT_INT_LATCH_DISABLE    BIT(2)
> +#define RPR0521_INTERRUPT_INT_LATCH_ENABLE     0x00
> +#define RPR0521_INTERRUPT_INT_REASSERT_ENABLE  BIT(3)
> +#define RPR0521_INTERRUPT_INT_REASSERT_DISABLE 0x00
> +#define RPR0521_INTERRUPT_INT_PS_OUTSIDE_DETECT        BIT(5)
>
>  #define RPR0521_MANUFACT_ID            0xE0
>  #define RPR0521_DEFAULT_MEAS_TIME      0x06 /* ALS - 100ms, PXS - 100ms */
>
>  #define RPR0521_DRV_NAME               "RPR0521"
> +#define RPR0521_IRQ_NAME               "rpr0521_event"
>  #define RPR0521_REGMAP_NAME            "rpr0521_regmap"
>
>  #define RPR0521_SLEEP_DELAY_MS 2000
> @@ -169,6 +195,11 @@ struct rpr0521_data {
>         bool als_dev_en;
>         bool pxs_dev_en;
>
> +#ifdef RPR0521_TRIGGERS
> +       struct iio_trigger *drdy_trigger0;
> +       bool drdy_trigger_on;
> +       u16 *scan_buffer;
> +#endif
>         /* optimize runtime pm ops - enable device only if needed */
>         bool als_ps_need_en;
>         bool pxs_ps_need_en;
> @@ -194,6 +225,13 @@ struct rpr0521_data {
>         .attrs = rpr0521_attributes,
>  };
>
> +/* Order of the channel data in buffer */
> +enum rpr0521_scan_index_order {
> +       RPR0521_CHAN_INDEX_PXS,
> +       RPR0521_CHAN_INDEX_BOTH,
> +       RPR0521_CHAN_INDEX_IR,
> +};
> +
>  static const struct iio_chan_spec rpr0521_channels[] = {
>         {
>                 .type = IIO_PROXIMITY,
> @@ -202,6 +240,13 @@ struct rpr0521_data {
>                         BIT(IIO_CHAN_INFO_OFFSET) |
>                         BIT(IIO_CHAN_INFO_SCALE),
>                 .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +               .scan_index = RPR0521_CHAN_INDEX_PXS,
> +               .scan_type = {
> +                       .sign = 'u',
> +                       .realbits = 16,
> +                       .storagebits = 16,
> +                       .shift = 0,
> +               },
>         },
>         {
>                 .type = IIO_INTENSITY,
> @@ -211,6 +256,13 @@ struct rpr0521_data {
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>                         BIT(IIO_CHAN_INFO_SCALE),
>                 .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +               .scan_index = RPR0521_CHAN_INDEX_BOTH,
> +               .scan_type = {
> +                       .sign = 'u',
> +                       .realbits = 16,
> +                       .storagebits = 16,
> +                       .shift = 0,
> +               },
>         },
>         {
>                 .type = IIO_INTENSITY,
> @@ -220,9 +272,155 @@ struct rpr0521_data {
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>                         BIT(IIO_CHAN_INFO_SCALE),
>                 .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +               .scan_index = RPR0521_CHAN_INDEX_IR,
> +               .scan_type = {
> +                       .sign = 'u',
> +                       .realbits = 16,
> +                       .storagebits = 16,
> +                       .shift = 0,
> +               },
>         },
>  };
>
> +#ifdef RPR0521_TRIGGERS
> +static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
> +                                  u8 device_mask);
> +static int rpr0521_als_enable(struct rpr0521_data *data, u8 status);
> +static int rpr0521_pxs_enable(struct rpr0521_data *data, u8 status);
> +
> +/* IRQ to trigger -handler */
> +static irqreturn_t rpr0521_drdy_irq_handler(int irq, void *private)
> +{
> +       struct iio_dev *indio_dev = private;
> +       struct rpr0521_data *data = iio_priv(indio_dev);
> +
> +       /* Notify trigger0 consumers/subscribers */
> +       if (data->drdy_trigger_on)
> +               iio_trigger_poll(data->drdy_trigger0);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct rpr0521_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       u8 buffer[16]; /* 3 16-bit channels + padding + ts */
> +
> +       ret = regmap_bulk_read(data->regmap,
> +               RPR0521_REG_PXS_DATA,
> +               &buffer,
> +               (3*2)+1);       /* 3 * 16-bit + (discarded) int clear reg. */
> +       if (ret < 0)
> +               goto done;
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev,
> +               buffer,
> +               pf->timestamp);
> +done:
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int rpr0521_write_int_enable(struct rpr0521_data *data)
> +{
> +       int err;
> +
> +       /* Interrupt after each measurement */
> +       err = regmap_update_bits(data->regmap, RPR0521_REG_PXS_CTRL,
> +               RPR0521_PXS_PERSISTENCE_MASK,
> +               RPR0521_PXS_PERSISTENCE_DRDY);

Is there any reason to continue if regmap_update_bits fails?

err = err || regmap_update_bits(), this looks strange :).

Daniel.
