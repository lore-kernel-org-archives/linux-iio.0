Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35296 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbcJCKq2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2016 06:46:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id f193so9439364wmg.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Oct 2016 03:46:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1610030030020.13588@pmeerw.net>
References: <1475430497-7861-1-git-send-email-lorenzo.bianconi@st.com>
 <1475430497-7861-2-git-send-email-lorenzo.bianconi@st.com> <alpine.DEB.2.02.1610030030020.13588@pmeerw.net>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Mon, 3 Oct 2016 12:46:24 +0200
Message-ID: <CAA2SeN+PrJ3roP+W3uZ7C7OED6K5sS8OFtpTdZ+gpGwn3ceZcw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: humidity: add support to hts221 rh/temp combo device
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> On Sun, 2 Oct 2016, Lorenzo Bianconi wrote:
>
>> Add support to STM HTS221 humidity + temperature sensor
>
> comments below
> this sensor won't fit in the ST IIO framework?

Hi Peter,

Thanks for the review.
HTS221 does not fit well in st framework since it is a
humidity/temperature combo device and for calibration/oversampling
features.
I have merged your suggestions, just few comments inline.

Regards,
Lorenzo

>
>> http://www.st.com/resource/en/datasheet/hts221.pdf
>>
>> - continuos mode support
>> - i2c support
>> - spi support
>> - trigger mode support
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> ---
>>  drivers/iio/humidity/Kconfig                |   2 +
>>  drivers/iio/humidity/Makefile               |   1 +
>>  drivers/iio/humidity/hts221/Kconfig         |  23 +
>>  drivers/iio/humidity/hts221/Makefile        |   6 +
>>  drivers/iio/humidity/hts221/hts221.h        | 100 ++++
>>  drivers/iio/humidity/hts221/hts221_buffer.c | 191 ++++++++
>>  drivers/iio/humidity/hts221/hts221_core.c   | 687 ++++++++++++++++++++++++++++
>>  drivers/iio/humidity/hts221/hts221_i2c.c    | 119 +++++
>>  drivers/iio/humidity/hts221/hts221_spi.c    | 134 ++++++
>>  9 files changed, 1263 insertions(+)
>>  create mode 100644 drivers/iio/humidity/hts221/Kconfig
>>  create mode 100644 drivers/iio/humidity/hts221/Makefile
>>  create mode 100644 drivers/iio/humidity/hts221/hts221.h
>>  create mode 100644 drivers/iio/humidity/hts221/hts221_buffer.c
>>  create mode 100644 drivers/iio/humidity/hts221/hts221_core.c
>>  create mode 100644 drivers/iio/humidity/hts221/hts221_i2c.c
>>  create mode 100644 drivers/iio/humidity/hts221/hts221_spi.c
>>
>> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
>> index b17e2e2..4ce75da 100644
>> --- a/drivers/iio/humidity/Kconfig
>> +++ b/drivers/iio/humidity/Kconfig
>> @@ -69,4 +69,6 @@ config SI7020
>>         To compile this driver as a module, choose M here: the module
>>         will be called si7020.
>>
>> +source "drivers/iio/humidity/hts221/Kconfig"
>> +
>>  endmenu
>> diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
>> index 4a73442..bdd5cd0 100644
>> --- a/drivers/iio/humidity/Makefile
>> +++ b/drivers/iio/humidity/Makefile
>> @@ -8,3 +8,4 @@ obj-$(CONFIG_HDC100X) += hdc100x.o
>>  obj-$(CONFIG_HTU21) += htu21.o
>>  obj-$(CONFIG_SI7005) += si7005.o
>>  obj-$(CONFIG_SI7020) += si7020.o
>> +obj-$(CONFIG_IIO_HTS221) += hts221/
>
> should be alphabetic; do we need the IIO_ prefix
>
>> diff --git a/drivers/iio/humidity/hts221/Kconfig b/drivers/iio/humidity/hts221/Kconfig
>> new file mode 100644
>> index 0000000..95b40e0
>> --- /dev/null
>> +++ b/drivers/iio/humidity/hts221/Kconfig
>> @@ -0,0 +1,23 @@
>> +
>> +config IIO_HTS221
>> +     tristate "STMicroelectronics HTS221 sensor Driver"
>> +     depends on (I2C || SPI) && SYSFS
>
> SYSFS is a prerequisite of IIO
>
>> +     select IIO_BUFFER
>> +     select IIO_TRIGGERED_BUFFER
>> +     select IIO_HTS221_I2C if (I2C)
>> +     select IIO_HTS221_SPI if (SPI_MASTER)
>> +     help
>> +       Say yes here to build support for STMicroelectronics HTS221
>> +       temperature-humidity sensor
>> +
>> +       To compile this driver as a module, choose M here: the module
>> +       will be called hts221.
>> +
>> +config IIO_HTS221_I2C
>> +     tristate
>> +     depends on IIO_HTS221
>> +
>> +config IIO_HTS221_SPI
>> +     tristate
>> +     depends on IIO_HTS221
>> +
>> diff --git a/drivers/iio/humidity/hts221/Makefile b/drivers/iio/humidity/hts221/Makefile
>> new file mode 100644
>> index 0000000..6fdfc6a
>> --- /dev/null
>> +++ b/drivers/iio/humidity/hts221/Makefile
>> @@ -0,0 +1,6 @@
>> +hts221-y := hts221_core.o
>> +hts221-$(CONFIG_IIO_BUFFER) += hts221_buffer.o
>> +
>> +obj-$(CONFIG_IIO_HTS221) += hts221.o
>> +obj-$(CONFIG_IIO_HTS221_I2C) += hts221_i2c.o
>> +obj-$(CONFIG_IIO_HTS221_SPI) += hts221_spi.o
>> diff --git a/drivers/iio/humidity/hts221/hts221.h b/drivers/iio/humidity/hts221/hts221.h
>> new file mode 100644
>> index 0000000..ee8d2fb
>> --- /dev/null
>> +++ b/drivers/iio/humidity/hts221/hts221.h
>> @@ -0,0 +1,100 @@
>> +/*
>> + * STMicroelectronics hts221 sensor driver
>> + *
>> + * Copyright 2016 STMicroelectronics Inc.
>> + *
>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#ifndef HTS221_H
>> +#define HTS221_H
>> +
>> +#define HTS221_DEV_NAME              "hts221"
>> +
>> +#include <linux/iio/iio.h>
>> +
>> +#define HTS221_RX_MAX_LENGTH 500
>> +#define HTS221_TX_MAX_LENGTH 500
>
> really 500 bytes transfer size?
>
>> +
>> +struct hts221_transfer_buffer {
>> +     u8 rx_buf[HTS221_RX_MAX_LENGTH];
>> +     u8 tx_buf[HTS221_TX_MAX_LENGTH] ____cacheline_aligned;
>> +};
>> +
>> +struct hts221_transfer_function {
>> +     int (*read)(struct device *dev, u8 addr, int len, u8 *data);
>> +     int (*write)(struct device *dev, u8 addr, int len, u8 *data);
>> +};
>> +
>> +#define HTS221_AVG_DEPTH     8
>> +struct hts221_avg_avl {
>> +     u16 avg;
>> +     u8 val;
>> +};
>> +
>> +enum hts221_sensor_type {
>> +     HTS221_SENSOR_H,
>> +     HTS221_SENSOR_T,
>> +     HTS221_SENSOR_MAX,
>> +};
>> +
>> +struct hts221_sensor {
>> +     struct hts221_dev *dev;
>> +
>> +     enum hts221_sensor_type type;
>> +     u8 cur_avg_idx;
>> +     int slope, b_gen;
>> +};
>> +
>> +struct hts221_dev {
>> +     const char *name;
>> +     struct device *dev;
>> +
>> +     struct mutex lock;
>> +
>> +     u8 buffer[4];
>
> le16 buffer[2]

since we can avoid memcpy in hts221_buffer_handler_thread() and insert
timestamp sample in dev->buffer, maybe it is clearer to do something
like:

#define HTS221_DATA_SIZE 2

u8 buffer[ALIGN(2 * HTS221_DATA_SIZE, sizeof(s64)) + sizeof(s64)];

and use HTS221_DATA_SIZE as i2c/spi read len for output registers

>
>> +     struct iio_trigger *trig;
>> +     int irq;
>> +
>> +     struct hts221_sensor sensors[HTS221_SENSOR_MAX];
>> +
>> +     s64 hw_timestamp;
>> +     u8 odr;
>> +
>> +     const struct hts221_transfer_function *tf;
>> +     struct hts221_transfer_buffer tb;
>> +};
>> +
>> +int hts221_config_drdy(struct hts221_dev *dev, bool enable);
>> +int hts221_probe(struct hts221_dev *dev);
>> +int hts221_remove(struct hts221_dev *dev);
>> +int hts221_dev_power_on(struct hts221_dev *dev);
>> +int hts221_dev_power_off(struct hts221_dev *dev);
>> +#ifdef CONFIG_IIO_BUFFER
>> +int hts221_allocate_buffers(struct hts221_dev *dev);
>> +void hts221_deallocate_buffers(struct hts221_dev *dev);
>> +int hts221_allocate_triggers(struct hts221_dev *dev);
>> +void hts221_deallocate_triggers(struct hts221_dev *dev);
>> +#else
>> +static inline int hts221_allocate_buffers(struct hts221_dev *dev)
>> +{
>> +     return 0;
>> +}
>> +
>> +static inline void hts221_deallocate_buffers(struct hts221_dev *dev)
>> +{
>> +}
>> +
>> +static inline int hts221_allocate_triggers(struct hts221_dev *dev)
>> +{
>> +     return 0;
>> +}
>> +
>> +static inline void hts221_deallocate_triggers(struct hts221_dev *dev)
>> +{
>> +}
>> +#endif /* CONFIG_IIO_BUFFER */
>> +
>> +#endif /* HTS221_H */
>> diff --git a/drivers/iio/humidity/hts221/hts221_buffer.c b/drivers/iio/humidity/hts221/hts221_buffer.c
>> new file mode 100644
>> index 0000000..ab77e98
>> --- /dev/null
>> +++ b/drivers/iio/humidity/hts221/hts221_buffer.c
>> @@ -0,0 +1,191 @@
>> +/*
>> + * STMicroelectronics hts221 sensor driver
>> + *
>> + * Copyright 2016 STMicroelectronics Inc.
>> + *
>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irqreturn.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/iio/buffer.h>
>> +
>> +#include "hts221.h"
>> +
>> +#define HTS221_REG_STATUS_ADDR               0x27
>> +#define HTS221_RH_DRDY_MASK          0x2
>> +#define HTS221_TEMP_DRDY_MASK                0x1
>
> could use BIT() for the _MASKs
>
>> +
>> +int hts221_trig_set_state(struct iio_trigger *trig, bool state)
>
> static?
>
>> +{
>> +     struct iio_dev *iio_dev = iio_trigger_get_drvdata(trig);
>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>> +
>> +     return hts221_config_drdy(dev, state);
>> +}
>> +
>> +static const struct iio_trigger_ops hts221_trigger_ops = {
>> +     .owner = THIS_MODULE,
>> +     .set_trigger_state = hts221_trig_set_state,
>> +};
>> +
>> +static irqreturn_t hts221_trigger_handler_irq(int irq, void *private)
>> +{
>> +     struct hts221_dev *dev = (struct hts221_dev *)private;
>> +     struct iio_dev *iio_dev = iio_priv_to_dev(dev);
>> +
>> +     dev->hw_timestamp = iio_get_time_ns(iio_dev);
>> +
>> +     return IRQ_WAKE_THREAD;
>> +}
>> +
>> +static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
>> +{
>> +     struct hts221_dev *dev = (struct hts221_dev *)private;
>> +     struct iio_dev *iio_dev = iio_priv_to_dev(dev);
>> +     struct iio_chan_spec const *ch;
>> +     int err, count = 0;
>> +     u8 status;
>> +
>> +     err = dev->tf->read(dev->dev, HTS221_REG_STATUS_ADDR, 1, &status);
>> +     if (err < 0)
>> +             return IRQ_HANDLED;
>> +
>> +     /* humidity data */
>> +     if (status & HTS221_RH_DRDY_MASK) {
>> +             ch = &iio_dev->channels[HTS221_SENSOR_H];
>> +             err = dev->tf->read(dev->dev, ch->address, 2,
>
> 2 is sizeof(le16)

we can use HTS221_DATA_SIZE

>
>> +                                 dev->buffer);
>> +             if (err < 0)
>> +                     return IRQ_HANDLED;
>> +
>> +             count++;
>> +     }
>> +
>> +     /* temp data */
>
> temperature, to avoid confusion with temporary
>
>> +     if (status & HTS221_TEMP_DRDY_MASK) {
>> +             ch = &iio_dev->channels[HTS221_SENSOR_T];
>> +             err = dev->tf->read(dev->dev, ch->address, 2,
>> +                                 dev->buffer + 2 * count);
>> +             if (err < 0)
>> +                     return IRQ_HANDLED;
>> +
>> +             count++;
>> +     }
>> +
>> +     if (count > 0) {
>> +             iio_trigger_poll_chained(dev->trig);
>> +             return IRQ_HANDLED;
>> +     } else {
>> +             return IRQ_NONE;
>> +     }
>> +}
>> +
>> +int hts221_allocate_triggers(struct hts221_dev *dev)
>> +{
>> +     struct iio_dev *iio_dev = iio_priv_to_dev(dev);
>> +     unsigned long irq_type;
>> +     int err;
>> +
>> +     irq_type = irqd_get_trigger_type(irq_get_irq_data(dev->irq));
>> +
>> +     switch (irq_type) {
>> +     case IRQF_TRIGGER_HIGH:
>> +     case IRQF_TRIGGER_RISING:
>> +             break;
>> +     default:
>> +             dev_info(dev->dev,
>> +                      "mode %lx unsupported, using IRQF_TRIGGER_RISING\n",
>> +                      irq_type);
>> +             irq_type = IRQF_TRIGGER_RISING;
>> +             break;
>> +     }
>> +
>> +     err = devm_request_threaded_irq(dev->dev, dev->irq,
>> +                                     hts221_trigger_handler_irq,
>> +                                     hts221_trigger_handler_thread,
>> +                                     irq_type | IRQF_ONESHOT,
>> +                                     dev->name, dev);
>> +     if (err) {
>> +             dev_err(dev->dev, "failed to request trigger irq %d\n",
>> +                     dev->irq);
>> +             return err;
>> +     }
>> +
>> +     dev->trig = devm_iio_trigger_alloc(dev->dev, "%s-trigger",
>> +                                        iio_dev->name);
>> +     if (!dev->trig)
>> +             return -ENOMEM;
>> +
>> +     iio_trigger_set_drvdata(dev->trig, iio_dev);
>> +     dev->trig->ops = &hts221_trigger_ops;
>> +     dev->trig->dev.parent = dev->dev;
>> +     iio_dev->trig = iio_trigger_get(dev->trig);
>> +
>> +     return iio_trigger_register(dev->trig);
>> +}
>> +
>> +void hts221_deallocate_triggers(struct hts221_dev *dev)
>> +{
>> +     iio_trigger_unregister(dev->trig);
>> +}
>> +
>> +static int hts221_buffer_preenable(struct iio_dev *iio_dev)
>> +{
>> +     return hts221_dev_power_on(iio_priv(iio_dev));
>> +}
>> +
>> +static int hts221_buffer_postdisable(struct iio_dev *iio_dev)
>> +{
>> +     return hts221_dev_power_off(iio_priv(iio_dev));
>> +}
>> +
>> +static const struct iio_buffer_setup_ops hts221_buffer_ops = {
>> +     .preenable = hts221_buffer_preenable,
>> +     .postenable = iio_triggered_buffer_postenable,
>> +     .predisable = iio_triggered_buffer_predisable,
>> +     .postdisable = hts221_buffer_postdisable,
>> +};
>> +
>> +static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
>> +{
>> +     struct iio_poll_func *pf = p;
>> +     struct iio_dev *iio_dev = pf->indio_dev;
>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>> +     u8 out_data[ALIGN(4, sizeof(s64)) + sizeof(s64)];
>> +
>> +     memcpy(out_data, dev->buffer, sizeof(dev->buffer));
>
> couldn't dev->buffer be made large enough to avoid the copy operation?
>

ack

>> +     iio_push_to_buffers_with_timestamp(iio_dev, out_data,
>> +                                        dev->hw_timestamp);
>> +
>> +     iio_trigger_notify_done(dev->trig);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +int hts221_allocate_buffers(struct hts221_dev *dev)
>> +{
>> +     return iio_triggered_buffer_setup(iio_priv_to_dev(dev), NULL,
>> +                                       hts221_buffer_handler_thread,
>> +                                       &hts221_buffer_ops);
>> +}
>> +
>> +void hts221_deallocate_buffers(struct hts221_dev *dev)
>> +{
>> +     iio_triggered_buffer_cleanup(iio_priv_to_dev(dev));
>> +}
>> +
>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>> +MODULE_DESCRIPTION("STMicroelectronics hts221 buffer driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/humidity/hts221/hts221_core.c b/drivers/iio/humidity/hts221/hts221_core.c
>> new file mode 100644
>> index 0000000..f6f9c20
>> --- /dev/null
>> +++ b/drivers/iio/humidity/hts221/hts221_core.c
>> @@ -0,0 +1,687 @@
>> +/*
>> + * STMicroelectronics hts221 sensor driver
>> + *
>> + * Copyright 2016 STMicroelectronics Inc.
>> + *
>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/delay.h>
>> +#include <asm/unaligned.h>
>> +
>> +#include "hts221.h"
>> +
>> +#define HTS221_REG_WHOAMI_ADDR               0x0f
>> +#define HTS221_REG_WHOAMI_VAL                0xbc
>> +
>> +#define HTS221_REG_CNTRL1_ADDR               0x20
>> +#define HTS221_REG_CNTRL2_ADDR               0x21
>> +#define HTS221_REG_CNTRL3_ADDR               0x22
>> +
>
> maybe mention that H, T is humidity, temperature resp.
>
>> +#define HTS221_REG_H_AVG_ADDR                0x10
>> +#define HTS221_REG_T_AVG_ADDR                0x10
>
> same address twice?
>
>> +#define HTS221_REG_H_OUT_L           0x28
>> +#define HTS221_REG_T_OUT_L           0x2a
>> +
>> +#define HTS221_H_AVG_MASK            0x07
>> +#define HTS221_T_AVG_MASK            0x38
>> +
>> +#define ODR_MASK                     0x87
>> +#define BDU_MASK                     0x04
>
> HTS221_ prefix
>
>> +
>> +#define DRDY_MASK                    0x04
>> +
>> +#define ENABLE_SENSOR                        0x80
>
> prefix, use BIT()
>
>> +
>> +#define HTS221_H_AVG_4                       0x00 /* 0.4 %RH */
>> +#define HTS221_H_AVG_8                       0x01 /* 0.3 %RH */
>> +#define HTS221_H_AVG_16                      0x02 /* 0.2 %RH */
>> +#define HTS221_H_AVG_32                      0x03 /* 0.15 %RH */
>> +#define HTS221_H_AVG_64                      0x04 /* 0.1 %RH */
>> +#define HTS221_H_AVG_128             0x05 /* 0.07 %RH */
>> +#define HTS221_H_AVG_256             0x06 /* 0.05 %RH */
>> +#define HTS221_H_AVG_512             0x07 /* 0.03 %RH */
>> +
>> +#define HTS221_T_AVG_2                       0x00 /* 0.08 degC */
>> +#define HTS221_T_AVG_4                       0x08 /* 0.05 degC */
>> +#define HTS221_T_AVG_8                       0x10 /* 0.04 degC */
>> +#define HTS221_T_AVG_16                      0x18 /* 0.03 degC */
>> +#define HTS221_T_AVG_32                      0x20 /* 0.02 degC */
>> +#define HTS221_T_AVG_64                      0x28 /* 0.015 degC */
>> +#define HTS221_T_AVG_128             0x30 /* 0.01 degC */
>> +#define HTS221_T_AVG_256             0x38 /* 0.007 degC */
>> +
>> +/* caldata registers */
>
> calibration data?
>
>> +#define HTS221_REG_0RH_CAL_X_H               0x36
>> +#define HTS221_REG_1RH_CAL_X_H               0x3a
>> +#define HTS221_REG_0RH_CAL_Y_H               0x30
>> +#define HTS221_REG_1RH_CAL_Y_H               0x31
>> +#define HTS221_REG_0T_CAL_X_L                0x3c
>> +#define HTS221_REG_1T_CAL_X_L                0x3e
>> +#define HTS221_REG_0T_CAL_Y_H                0x32
>> +#define HTS221_REG_1T_CAL_Y_H                0x33
>> +#define HTS221_REG_T1_T0_CAL_Y_H     0x35
>> +
>> +struct hts221_odr {
>> +     u32 hz;
>
> maybe int, not u32

why int? hz can't be negative

>
>> +     u8 val;
>> +};
>> +
>> +struct hts221_avg {
>> +     u8 addr;
>> +     u8 mask;
>> +     struct hts221_avg_avl avg_avl[HTS221_AVG_DEPTH];
>> +};
>> +
>> +static const struct hts221_odr hts221_odr_table[] = {
>> +     { 1, 0x01 },    /* 1Hz */
>> +     { 7, 0x02 },    /* 7Hz */
>> +     { 13, 0x03 },   /* 12.5 HZ */
>
> HZ or Hz;
> consistent space
>
>> +};
>> +
>> +static const struct hts221_avg hts221_avg_list[] = {
>> +     {
>> +             .addr = HTS221_REG_H_AVG_ADDR,
>> +             .mask = HTS221_H_AVG_MASK,
>> +             .avg_avl = {
>> +                     { 4, HTS221_H_AVG_4 },
>> +                     { 8, HTS221_H_AVG_8 },
>> +                     { 16, HTS221_H_AVG_16 },
>> +                     { 32, HTS221_H_AVG_32 },
>> +                     { 64, HTS221_H_AVG_64 },
>> +                     { 128, HTS221_H_AVG_128 },
>> +                     { 256, HTS221_H_AVG_256 },
>> +                     { 512, HTS221_H_AVG_512 },
>> +             },
>> +     },
>> +     {
>> +             .addr = HTS221_REG_T_AVG_ADDR,
>> +             .mask = HTS221_T_AVG_MASK,
>> +             .avg_avl = {
>> +                     { 2, HTS221_T_AVG_2 },
>> +                     { 4, HTS221_T_AVG_4 },
>> +                     { 8, HTS221_T_AVG_8 },
>> +                     { 16, HTS221_T_AVG_16 },
>> +                     { 32, HTS221_T_AVG_32 },
>> +                     { 64, HTS221_T_AVG_64 },
>> +                     { 128, HTS221_T_AVG_128 },
>> +                     { 256, HTS221_T_AVG_256 },
>> +             },
>> +     },
>> +};
>> +
>> +static const struct iio_chan_spec hts221_channels[] = {
>> +     {
>> +             .type = IIO_HUMIDITYRELATIVE,
>> +             .address = HTS221_REG_H_OUT_L,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +                                   BIT(IIO_CHAN_INFO_OFFSET) |
>> +                                   BIT(IIO_CHAN_INFO_SCALE) |
>> +                                   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>> +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +             .scan_index = 0,
>> +             .scan_type = {
>> +                     .sign = 's',
>> +                     .realbits = 16,
>> +                     .storagebits = 16,
>> +                     .endianness = IIO_LE,
>> +             },
>> +     },
>> +     {
>> +             .type = IIO_TEMP,
>> +             .address = HTS221_REG_T_OUT_L,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +                                   BIT(IIO_CHAN_INFO_OFFSET) |
>> +                                   BIT(IIO_CHAN_INFO_SCALE) |
>> +                                   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>> +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +             .scan_index = 1,
>> +             .scan_type = {
>> +                     .sign = 's',
>> +                     .realbits = 16,
>> +                     .storagebits = 16,
>> +                     .endianness = IIO_LE,
>> +             },
>> +     },
>> +     IIO_CHAN_SOFT_TIMESTAMP(2),
>> +};
>> +
>> +static int hts221_write_with_mask(struct hts221_dev *dev, u8 addr, u8 mask,
>> +                               u8 val)
>> +{
>> +     u8 data;
>> +     int err;
>> +
>> +     mutex_lock(&dev->lock);
>> +
>> +     err = dev->tf->read(dev->dev, addr, 1, &data);
>> +     if (err < 0) {
>> +             dev_err(dev->dev, "failed to read %02x register\n", addr);
>> +             mutex_unlock(&dev->lock);
>> +
>> +             return err;
>> +     }
>> +
>> +     data = (data & ~mask) | (val & mask);
>> +
>> +     err = dev->tf->write(dev->dev, addr, 1, &data);
>> +     if (err < 0) {
>> +             dev_err(dev->dev, "failed to write %02x register\n", addr);
>> +             mutex_unlock(&dev->lock);
>> +
>> +             return err;
>> +     }
>> +
>> +     mutex_unlock(&dev->lock);
>> +
>> +     return 0;
>> +}
>> +
>> +static int hts221_check_whoami(struct hts221_dev *dev)
>> +{
>> +     u8 data;
>> +     int err;
>> +
>> +     err = dev->tf->read(dev->dev, HTS221_REG_WHOAMI_ADDR, 1, &data);
>
> 1 is sizeof(data)
>
>> +     if (err < 0) {
>> +             dev_err(dev->dev, "failed to read whoami register\n");
>> +             return err;
>> +     }
>> +
>> +     if (data != HTS221_REG_WHOAMI_VAL) {
>> +             dev_err(dev->dev, "wrong whoami {%02x-%02x}\n",
>
> %02x vs %02x
> or
> %02x != %02x
> would be a lot clearer
>
>> +                     data, HTS221_REG_WHOAMI_VAL);
>> +             return -ENODEV;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +int hts221_config_drdy(struct hts221_dev *dev, bool enable)
>> +{
>> +     u8 val = (enable) ? 0x04 : 0;
>
> parenthesis not needed; could use BIT() or #define for 0x04
>
>> +
>> +     return hts221_write_with_mask(dev, HTS221_REG_CNTRL3_ADDR,
>> +                                   DRDY_MASK, val);
>> +}
>> +
>> +static int hts221_update_odr(struct hts221_dev *dev, u8 odr)
>> +{
>> +     int i, err;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(hts221_odr_table); i++)
>> +             if (hts221_odr_table[i].hz == odr)
>> +                     break;
>> +
>> +     if (i == ARRAY_SIZE(hts221_odr_table))
>> +             return -EINVAL;
>> +
>> +     err = hts221_write_with_mask(dev, HTS221_REG_CNTRL1_ADDR, ODR_MASK,
>> +                                  ENABLE_SENSOR | BDU_MASK |
>> +                                  hts221_odr_table[i].val);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     dev->odr = odr;
>> +
>> +     return 0;
>> +}
>> +
>> +static int hts221_update_avg(struct hts221_sensor *sensor, u16 val)
>> +{
>> +     int i, err;
>> +     const struct hts221_avg *avg = &hts221_avg_list[sensor->type];
>> +
>> +     for (i = 0; i < HTS221_AVG_DEPTH; i++)
>> +             if (avg->avg_avl[i].avg == val)
>> +                     break;
>> +
>> +     if (i == HTS221_AVG_DEPTH)
>> +             return -EINVAL;
>> +
>> +     err = hts221_write_with_mask(sensor->dev, avg->addr, avg->mask,
>> +                                  avg->avg_avl[i].val);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     sensor->cur_avg_idx = i;
>> +
>> +     return 0;
>> +}
>> +
>> +static ssize_t hts221_sysfs_sampling_freq(struct device *dev,
>> +                                       struct device_attribute *attr,
>> +                                       char *buf)
>> +{
>> +     int i;
>> +     ssize_t len = 0;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(hts221_odr_table); i++)
>> +             len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
>> +                              hts221_odr_table[i].hz);
>> +     buf[len - 1] = '\n';
>> +
>> +     return len;
>> +}
>> +
>> +static ssize_t
>> +hts221_sysfs_rh_oversampling_avail(struct device *dev,
>> +                                struct device_attribute *attr,
>> +                                char *buf)
>> +{
>> +     struct hts221_avg const *avg = &hts221_avg_list[HTS221_SENSOR_H];
>> +     ssize_t len = 0;
>> +     int i;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(avg->avg_avl); i++)
>> +             len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
>> +                              avg->avg_avl[i].avg);
>> +     buf[len - 1] = '\n';
>> +
>> +     return len;
>> +}
>> +
>> +static ssize_t
>> +hts221_sysfs_temp_oversampling_avail(struct device *dev,
>> +                                  struct device_attribute *attr,
>> +                                  char *buf)
>> +{
>> +     struct hts221_avg const *avg = &hts221_avg_list[HTS221_SENSOR_T];
>> +     ssize_t len = 0;
>> +     int i;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(avg->avg_avl); i++)
>> +             len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
>> +                              avg->avg_avl[i].avg);
>> +     buf[len - 1] = '\n';
>> +
>> +     return len;
>> +}
>> +
>> +int hts221_dev_power_on(struct hts221_dev *dev)
>> +{
>> +     struct hts221_sensor *sensor;
>> +     int i, err, val;
>> +
>> +     for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>> +             sensor = &dev->sensors[i];
>> +             val = hts221_avg_list[i].avg_avl[sensor->cur_avg_idx].avg;
>> +
>> +             err = hts221_update_avg(sensor, val);
>> +             if (err < 0)
>> +                     return err;
>> +     }
>> +
>> +     err = hts221_update_odr(dev, dev->odr);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     return 0;
>> +}
>> +
>> +int hts221_dev_power_off(struct hts221_dev *dev)
>> +{
>> +     u8 data[] = {0x00, 0x00};
>> +
>> +     return dev->tf->write(dev->dev, HTS221_REG_CNTRL1_ADDR, 2, data);
>
> sizeof(data)
>
>> +}
>> +
>> +static int hts221_parse_caldata(struct hts221_sensor *sensor)
>> +{
>> +     int err, *slope, *b_gen;
>> +     u8 addr_x0, addr_x1;
>> +     s16 cal_x0, cal_x1, cal_y0, cal_y1;
>> +     struct hts221_dev *dev = sensor->dev;
>> +
>> +     switch (sensor->type) {
>> +     case HTS221_SENSOR_H:
>> +             addr_x0 = HTS221_REG_0RH_CAL_X_H;
>> +             addr_x1 = HTS221_REG_1RH_CAL_X_H;
>> +
>> +             cal_y1 = 0;
>> +             cal_y0 = 0;
>> +             err = dev->tf->read(dev->dev, HTS221_REG_0RH_CAL_Y_H, 1,
>> +                                 (u8 *)&cal_y0);
>> +             if (err < 0)
>> +                     return err;
>
> endianness?
> this wouldn't work on BE

right, fixed in v3

>
>> +
>> +             err = dev->tf->read(dev->dev, HTS221_REG_1RH_CAL_Y_H, 1,
>> +                                 (u8 *)&cal_y1);
>> +             if (err < 0)
>> +                     return err;
>> +             break;
>> +     case HTS221_SENSOR_T: {
>> +             u8 cal0, cal1;
>> +
>> +             addr_x0 = HTS221_REG_0T_CAL_X_L;
>> +             addr_x1 = HTS221_REG_1T_CAL_X_L;
>> +
>> +             err = dev->tf->read(dev->dev, HTS221_REG_0T_CAL_Y_H, 1,
>> +                                 &cal0);
>> +             if (err < 0)
>> +                     return err;
>> +
>> +             err = dev->tf->read(dev->dev, HTS221_REG_T1_T0_CAL_Y_H, 1,
>> +                                 &cal1);
>> +             if (err < 0)
>> +                     return err;
>> +             cal_y0 = (le16_to_cpu(cal1 & 0x3) << 8) | cal0;
>
> cal1 is a byte and is endianness corrected?!
> le16_to_cpu not needed

ack

>
>> +
>> +             err = dev->tf->read(dev->dev, HTS221_REG_1T_CAL_Y_H, 1,
>> +                                 &cal0);
>> +             if (err < 0)
>> +                     return err;
>> +
>> +             err = dev->tf->read(dev->dev, HTS221_REG_T1_T0_CAL_Y_H, 1,
>> +                                 &cal1);
>> +             if (err < 0)
>> +                     return err;
>> +             cal_y1 = (le16_to_cpu((cal1 & 0xc) >> 2) << 8) | cal0;
>> +             break;
>> +     }
>> +     default:
>> +             return -ENODEV;
>> +     }
>> +
>> +     err = dev->tf->read(dev->dev, addr_x0, 2, (u8 *)&cal_x0);
>> +     if (err < 0)
>> +             return err;
>
> cal_x0 is s16, maybe use le16
> why le32_to_cpu() then?

ack

>
>> +     cal_x0 = le32_to_cpu(cal_x0);
>> +
>> +     err = dev->tf->read(dev->dev, addr_x1, 2, (u8 *)&cal_x1);
>> +     if (err < 0)
>> +             return err;
>> +     cal_x1 = le32_to_cpu(cal_x1);
>> +
>> +     slope = &sensor->slope;
>> +     b_gen = &sensor->b_gen;
>> +
>> +     *slope = ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0);
>> +     *b_gen = (((s32)cal_x1 * cal_y0 - (s32)cal_x0 * cal_y1) * 1000) /
>> +              (cal_x1 - cal_x0);
>> +     *b_gen *= 8;
>> +
>> +     return 0;
>> +}
>> +
>> +static int hts221_read_raw(struct iio_dev *iio_dev,
>> +                        struct iio_chan_spec const *ch,
>> +                        int *val, int *val2, long mask)
>> +{
>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>> +     int ret;
>> +
>> +     ret = iio_device_claim_direct_mode(iio_dev);
>> +     if (ret)
>> +             return ret;
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_RAW: {
>> +             u8 data[2];
>
> le16 data
>
>> +
>> +             ret = hts221_dev_power_on(dev);
>> +             if (ret < 0)
>> +                     goto out;
>> +
>> +             msleep(50);
>> +
>> +             ret = dev->tf->read(dev->dev, ch->address, 2, data);
>
> sizeof(le16)

same as in hts221_trigger_handler_thread()

>
>> +             if (ret < 0)
>> +                     goto out;
>> +
>> +             ret = hts221_dev_power_off(dev);
>> +             if (ret < 0)
>> +                     goto out;
>> +
>> +             *val = (s16)get_unaligned_le16(data);
>> +             ret = IIO_VAL_INT;
>> +
>> +             break;
>> +     }
>> +     case IIO_CHAN_INFO_SCALE: {
>> +             s64 tmp;
>> +             s32 rem, div, data;
>> +
>> +             switch (ch->type) {
>> +             case IIO_HUMIDITYRELATIVE:
>> +                     data = dev->sensors[HTS221_SENSOR_H].slope;
>> +                     div = (1 << 4) * 1000;
>> +                     break;
>> +             case IIO_TEMP:
>> +                     data = dev->sensors[HTS221_SENSOR_T].slope;
>> +                     div = (1 << 6) * 1000;
>> +                     break;
>> +             default:
>> +                     goto out;
>> +             }
>> +
>> +             tmp = div_s64(data * 1000000000LL, div);
>> +             tmp = div_s64_rem(tmp, 1000000000LL, &rem);
>
> common code, could split out in separate function

is it worth defining a function for a couple of lines of code?

>
>> +
>> +             *val = tmp;
>> +             *val2 = rem;
>> +             ret = IIO_VAL_INT_PLUS_NANO;
>> +             break;
>> +     }
>> +     case IIO_CHAN_INFO_OFFSET: {
>> +             s64 tmp;
>> +             s32 rem, div, data;
>> +
>> +             switch (ch->type) {
>> +             case IIO_HUMIDITYRELATIVE:
>> +                     data = dev->sensors[HTS221_SENSOR_H].b_gen;
>> +                     div = dev->sensors[HTS221_SENSOR_H].slope;
>> +                     break;
>> +             case IIO_TEMP:
>> +                     data = dev->sensors[HTS221_SENSOR_T].b_gen;
>> +                     div = dev->sensors[HTS221_SENSOR_T].slope;
>> +                     break;
>> +             default:
>> +                     goto out;
>> +             }
>> +
>> +             tmp = div_s64(data * 1000000000LL, div);
>> +             tmp = div_s64_rem(tmp, 1000000000LL, &rem);
>> +
>> +             *val = tmp;
>> +             *val2 = abs(rem);
>> +             ret = IIO_VAL_INT_PLUS_NANO;
>> +             break;
>> +     }
>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>> +             *val = dev->odr;
>> +             ret = IIO_VAL_INT;
>> +             break;
>> +     case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
>> +             u8 idx;
>> +             struct hts221_avg const *avg;
>
> const struct is more popular
>
>> +
>> +             switch (ch->type) {
>> +             case IIO_HUMIDITYRELATIVE:
>> +                     avg = &hts221_avg_list[HTS221_SENSOR_H];
>> +                     idx = dev->sensors[HTS221_SENSOR_H].cur_avg_idx;
>> +                     break;
>> +             case IIO_TEMP:
>> +                     avg = &hts221_avg_list[HTS221_SENSOR_T];
>> +                     idx = dev->sensors[HTS221_SENSOR_T].cur_avg_idx;
>> +                     break;
>> +             default:
>> +                     goto out;
>> +             }
>> +
>> +             *val = avg->avg_avl[idx].avg;
>> +             ret = IIO_VAL_INT;
>> +             break;
>> +     }
>> +     default:
>> +             ret = -EINVAL;
>> +             break;
>> +     }
>> +
>> +out:
>> +     iio_device_release_direct_mode(iio_dev);
>> +
>> +     return ret;
>> +}
>> +
>> +static int hts221_write_raw(struct iio_dev *iio_dev,
>> +                         struct iio_chan_spec const *chan,
>> +                         int val, int val2, long mask)
>> +{
>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>> +     int ret;
>> +
>> +     ret = iio_device_claim_direct_mode(iio_dev);
>> +     if (ret)
>> +             return ret;
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>> +             ret = hts221_update_odr(dev, val);
>> +             break;
>> +     case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
>> +             enum hts221_sensor_type type;
>> +
>> +             switch (chan->type) {
>> +             case IIO_HUMIDITYRELATIVE:
>> +                     type = HTS221_SENSOR_H;
>> +                     break;
>> +             case IIO_TEMP:
>> +                     type = HTS221_SENSOR_T;
>> +                     break;
>> +             default:
>> +                     ret = -EINVAL;
>> +                     goto out;
>> +             }
>> +
>> +             ret = hts221_update_avg(&dev->sensors[type], val);
>> +             break;
>> +     }
>> +     default:
>> +             ret = -EINVAL;
>> +             break;
>> +     }
>> +
>> +out:
>> +     iio_device_release_direct_mode(iio_dev);
>> +
>> +     return ret;
>> +}
>> +
>> +static IIO_DEVICE_ATTR(in_humidity_oversampling_ratio_available, S_IRUGO,
>> +                    hts221_sysfs_rh_oversampling_avail, NULL, 0);
>> +static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available, S_IRUGO,
>> +                    hts221_sysfs_temp_oversampling_avail, NULL, 0);
>> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hts221_sysfs_sampling_freq);
>> +
>> +static struct attribute *hts221_attributes[] = {
>> +     &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>> +     &iio_dev_attr_in_humidity_oversampling_ratio_available.dev_attr.attr,
>> +     &iio_dev_attr_in_temp_oversampling_ratio_available.dev_attr.attr,
>> +     NULL,
>> +};
>> +
>> +static const struct attribute_group hts221_attribute_group = {
>> +     .attrs = hts221_attributes,
>> +};
>> +
>> +static const struct iio_info hts221_info = {
>> +     .driver_module = THIS_MODULE,
>> +     .attrs = &hts221_attribute_group,
>> +     .read_raw = hts221_read_raw,
>> +     .write_raw = hts221_write_raw,
>> +};
>> +
>> +static const unsigned long hts221_scan_masks[] = {0x3, 0x0};
>> +
>> +int hts221_probe(struct hts221_dev *dev)
>> +{
>> +     struct iio_dev *iio_dev = iio_priv_to_dev(dev);
>> +     int i, err;
>> +
>> +     mutex_init(&dev->lock);
>> +
>> +     err = hts221_check_whoami(dev);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     err = hts221_update_odr(dev, 1);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     dev->odr = hts221_odr_table[0].hz;
>> +
>> +     iio_dev->modes = INDIO_DIRECT_MODE;
>> +     iio_dev->dev.parent = dev->dev;
>> +     iio_dev->available_scan_masks = hts221_scan_masks;
>> +     iio_dev->channels = hts221_channels;
>> +     iio_dev->num_channels = ARRAY_SIZE(hts221_channels);
>> +     iio_dev->name = HTS221_DEV_NAME;
>> +     iio_dev->info = &hts221_info;
>> +
>> +     for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>> +             dev->sensors[i].type = i;
>> +             dev->sensors[i].dev = dev;
>> +
>> +             err = hts221_update_avg(&dev->sensors[i],
>> +                                     hts221_avg_list[i].avg_avl[3].avg);
>> +             if (err < 0)
>> +                     goto power_off;
>> +
>> +             err = hts221_parse_caldata(&dev->sensors[i]);
>> +             if (err < 0)
>> +                     goto power_off;
>> +     }
>> +
>> +     err = hts221_dev_power_off(dev);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     if (dev->irq > 0) {
>> +             err = hts221_allocate_buffers(dev);
>> +             if (err < 0)
>> +                     return err;
>> +
>> +             err = hts221_allocate_triggers(dev);
>> +             if (err) {
>> +                     hts221_deallocate_buffers(dev);
>> +                     return err;
>> +             }
>> +     }
>> +
>> +     return iio_device_register(iio_dev);
>> +
>> +power_off:
>> +     hts221_dev_power_off(dev);
>> +
>> +     return err;
>> +}
>> +EXPORT_SYMBOL(hts221_probe);
>> +
>> +int hts221_remove(struct hts221_dev *dev)
>> +{
>> +     struct iio_dev *iio_dev = iio_priv_to_dev(dev);
>> +     int err;
>> +
>> +     err = hts221_dev_power_off(dev);
>> +
>> +     iio_device_unregister(iio_dev);
>
> first unregister, then power off
> mirror the calls in _probe in reverse order
>
>> +
>> +     if (dev->irq > 0) {
>> +             hts221_deallocate_triggers(dev);
>> +             hts221_deallocate_buffers(dev);
>> +     }
>> +
>> +     return err;
>> +}
>> +EXPORT_SYMBOL(hts221_remove);
>> +
>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>> +MODULE_DESCRIPTION("STMicroelectronics hts221 sensor driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/humidity/hts221/hts221_i2c.c b/drivers/iio/humidity/hts221/hts221_i2c.c
>> new file mode 100644
>> index 0000000..28ea781
>> --- /dev/null
>> +++ b/drivers/iio/humidity/hts221/hts221_i2c.c
>> @@ -0,0 +1,119 @@
>> +/*
>> + * STMicroelectronics hts221 i2c driver
>> + *
>> + * Copyright 2016 STMicroelectronics Inc.
>> + *
>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/slab.h>
>> +#include "hts221.h"
>> +
>> +#define I2C_AUTO_INCREMENT   0x80
>> +
>> +static int hts221_i2c_read(struct device *dev, u8 addr, int len, u8 *data)
>> +{
>> +     struct i2c_msg msg[2];
>> +     struct i2c_client *client = to_i2c_client(dev);
>> +
>> +     if (len > 1)
>> +             addr |= I2C_AUTO_INCREMENT;
>> +
>> +     msg[0].addr = client->addr;
>> +     msg[0].flags = client->flags;
>> +     msg[0].len = 1;
>> +     msg[0].buf = &addr;
>> +
>> +     msg[1].addr = client->addr;
>> +     msg[1].flags = client->flags | I2C_M_RD;
>> +     msg[1].len = len;
>> +     msg[1].buf = data;
>> +
>> +     return i2c_transfer(client->adapter, msg, 2);
>> +}
>> +
>> +static int hts221_i2c_write(struct device *dev, u8 addr, int len, u8 *data)
>> +{
>> +     u8 send[len + 1];
>> +     struct i2c_msg msg;
>> +     struct i2c_client *client = to_i2c_client(dev);
>> +
>> +     if (len > 1)
>> +             addr |= I2C_AUTO_INCREMENT;
>> +
>> +     send[0] = addr;
>> +     memcpy(&send[1], data, len * sizeof(u8));
>> +
>> +     msg.addr = client->addr;
>> +     msg.flags = client->flags;
>> +     msg.len = len + 1;
>> +     msg.buf = send;
>> +
>> +     return i2c_transfer(client->adapter, &msg, 1);
>> +}
>> +
>> +static const struct hts221_transfer_function hts221_transfer_fn = {
>> +     .read = hts221_i2c_read,
>> +     .write = hts221_i2c_write,
>> +};
>> +
>> +static int hts221_i2c_probe(struct i2c_client *client,
>> +                         const struct i2c_device_id *id)
>> +{
>> +     struct hts221_dev *dev;
>> +     struct iio_dev *iio_dev;
>> +
>> +     iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev));
>> +     if (!iio_dev)
>> +             return -ENOMEM;
>> +
>> +     i2c_set_clientdata(client, iio_dev);
>> +
>> +     dev = iio_priv(iio_dev);
>> +     dev->name = client->name;
>> +     dev->dev = &client->dev;
>> +     dev->irq = client->irq;
>> +     dev->tf = &hts221_transfer_fn;
>> +
>> +     return hts221_probe(dev);
>> +}
>> +
>> +static int hts221_i2c_remove(struct i2c_client *client)
>> +{
>> +     struct iio_dev *iio_dev = i2c_get_clientdata(client);
>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>> +
>> +     return hts221_remove(dev);
>> +}
>> +
>> +static const struct of_device_id hts221_i2c_of_match[] = {
>> +     { .compatible = "st,hts221", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, hts221_i2c_of_match);
>> +
>> +static const struct i2c_device_id hts221_i2c_id_table[] = {
>> +     { HTS221_DEV_NAME },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(i2c, hts221_i2c_id_table);
>> +
>> +static struct i2c_driver hts221_driver = {
>> +     .driver = {
>> +             .name = "hts221_i2c",
>> +             .of_match_table = of_match_ptr(hts221_i2c_of_match),
>> +     },
>> +     .probe = hts221_i2c_probe,
>> +     .remove = hts221_i2c_remove,
>> +     .id_table = hts221_i2c_id_table,
>> +};
>> +module_i2c_driver(hts221_driver);
>> +
>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>> +MODULE_DESCRIPTION("STMicroelectronics hts221 i2c driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/humidity/hts221/hts221_spi.c b/drivers/iio/humidity/hts221/hts221_spi.c
>> new file mode 100644
>> index 0000000..f0f649e
>> --- /dev/null
>> +++ b/drivers/iio/humidity/hts221/hts221_spi.c
>> @@ -0,0 +1,134 @@
>> +/*
>> + * STMicroelectronics hts221 spi driver
>> + *
>> + * Copyright 2016 STMicroelectronics Inc.
>> + *
>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/slab.h>
>> +#include "hts221.h"
>> +
>> +#define SENSORS_SPI_READ     0x80
>> +#define SPI_AUTO_INCREMENT   0x40
>> +
>> +static int hts221_spi_read(struct device *device, u8 addr, int len, u8 *data)
>> +{
>> +     int err;
>> +     struct spi_device *spi = to_spi_device(device);
>> +     struct iio_dev *iio_dev = spi_get_drvdata(spi);
>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>> +
>> +     struct spi_transfer xfers[] = {
>> +             {
>> +                     .tx_buf = dev->tb.tx_buf,
>> +                     .bits_per_word = 8,
>> +                     .len = 1,
>> +             },
>> +             {
>> +                     .rx_buf = dev->tb.rx_buf,
>> +                     .bits_per_word = 8,
>> +                     .len = len,
>> +             }
>> +     };
>> +
>> +     if (len > 1)
>> +             addr |= SPI_AUTO_INCREMENT;
>> +     dev->tb.tx_buf[0] = addr | SENSORS_SPI_READ;
>> +
>> +     err = spi_sync_transfer(spi, xfers,  ARRAY_SIZE(xfers));
>> +     if (err < 0)
>> +             return err;
>> +
>> +     memcpy(data, dev->tb.rx_buf, len * sizeof(u8));
>> +
>> +     return len;
>> +}
>> +
>> +static int hts221_spi_write(struct device *device, u8 addr, int len, u8 *data)
>> +{
>> +     struct spi_device *spi = to_spi_device(device);
>> +     struct iio_dev *iio_dev = spi_get_drvdata(spi);
>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>> +
>> +     struct spi_transfer xfers = {
>> +             .tx_buf = dev->tb.tx_buf,
>> +             .bits_per_word = 8,
>> +             .len = len + 1,
>> +     };
>> +
>> +     if (len >= HTS221_TX_MAX_LENGTH)
>> +             return -ENOMEM;
>> +
>> +     if (len > 1)
>> +             addr |= SPI_AUTO_INCREMENT;
>> +     dev->tb.tx_buf[0] = addr;
>> +     memcpy(&dev->tb.tx_buf[1], data, len);
>> +
>> +     return spi_sync_transfer(spi, &xfers, 1);
>> +}
>> +
>> +static const struct hts221_transfer_function hts221_transfer_fn = {
>> +     .read = hts221_spi_read,
>> +     .write = hts221_spi_write,
>> +};
>> +
>> +static int hts221_spi_probe(struct spi_device *spi)
>> +{
>> +     struct hts221_dev *dev;
>> +     struct iio_dev *iio_dev;
>> +
>> +     iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*dev));
>> +     if (!iio_dev)
>> +             return -ENOMEM;
>> +
>> +     spi_set_drvdata(spi, iio_dev);
>> +
>> +     dev = iio_priv(iio_dev);
>> +     dev->name = spi->modalias;
>> +     dev->dev = &spi->dev;
>> +     dev->irq = spi->irq;
>> +     dev->tf = &hts221_transfer_fn;
>> +
>> +     return hts221_probe(dev);
>> +}
>> +
>> +static int hts221_spi_remove(struct spi_device *spi)
>> +{
>> +     struct iio_dev *iio_dev = spi_get_drvdata(spi);
>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>> +
>> +     return hts221_remove(dev);
>> +}
>> +
>> +static const struct of_device_id hts221_spi_of_match[] = {
>> +     { .compatible = "st,hts221", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, hts221_spi_of_match);
>> +
>> +static const struct spi_device_id hts221_spi_id_table[] = {
>> +     { HTS221_DEV_NAME },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(spi, hts221_spi_id_table);
>> +
>> +static struct spi_driver hts221_driver = {
>> +     .driver = {
>> +             .name = "hts221_spi",
>> +             .of_match_table = of_match_ptr(hts221_spi_of_match),
>> +     },
>> +     .probe = hts221_spi_probe,
>> +     .remove = hts221_spi_remove,
>> +     .id_table = hts221_spi_id_table,
>> +};
>> +module_spi_driver(hts221_driver);
>> +
>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>> +MODULE_DESCRIPTION("STMicroelectronics hts221 spi driver");
>> +MODULE_LICENSE("GPL v2");
>>
>
> --
>
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
