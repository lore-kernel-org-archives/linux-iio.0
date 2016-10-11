Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54066 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbcJKSnj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2016 14:43:39 -0400
Subject: Re: [PATCH v3 1/2] iio: humidity: add support to hts221 rh/temp combo
 device
To: Lorenzo BIANCONI <lorenzo.bianconi@st.com>
References: <1475912752-6444-1-git-send-email-lorenzo.bianconi@st.com>
 <1475912752-6444-2-git-send-email-lorenzo.bianconi@st.com>
 <4d5ba48f-972c-5174-664c-c94eed33c03f@kernel.org>
 <20161011131326.GA10648@ctocxl0005.cto.st.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1a950485-a4a8-067b-6348-2e35112ab74b@kernel.org>
Date: Tue, 11 Oct 2016 19:41:45 +0100
MIME-Version: 1.0
In-Reply-To: <20161011131326.GA10648@ctocxl0005.cto.st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/16 14:13, Lorenzo BIANCONI wrote:
> On Oct 09, Jonathan Cameron wrote:
>> On 08/10/16 08:45, Lorenzo Bianconi wrote:
>>> Add support to STM HTS221 humidity + temperature sensor
>>>
>>> http://www.st.com/resource/en/datasheet/hts221.pdf
>>>
>>> - continuous mode support
>>> - i2c support
>>> - spi support
>>> - trigger mode support
>>>
>>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> Hi Lorenzo,
> 
> Hi Jonathan,
> 
> Thanks for the review
> 
>>
>> This is coming together nicely.  Various minor bits inline.
>>
>> The combined buffering you now have has a few issues to do
>> with the fact that we need to push whole 'scans' i.e. all enabled
>> channels to the buffer every time we trigger.
>>
>> Firstly I'd drop the trigger entirely (or you could make it happen only
>> after the second channel arrives) and instead push directly to the buffer
>> from the main interrupt handler.  This is perfectly valid in IIO and lots
>> of devices do it (when their data stream doesn't align well with the trigger
>> concept - fifos being the classic case).
>>
>> Secondly you need to make sure you have a whole scan every time.  So if
>> both channels are enabled, then both must be present. Here they are
>> both always enabled so you need to push them both.
>>
>> Pitty you can't make it just interrupt on one of the channels as that would
>> make life much easier if it was always the second one.
> 
> We are lucky, I spoke with digital designer and he confirmed the H_DA bit
> (humidity data available) is routed to DRDY line. Since humidity sample is
> computed after temperature one, we can assume data channels are both available
> when drdy interrupt fires.
Cool (datasheet should mention that ;)
> Should we drop the trigger code and push directly to the buffer from the main
> interrupt handler anyhow or use the hts221_trigger_handler_thread() to check status
> register and read data samples and push in hts221_buffer_handler_thread()?
> With previous assumption this driver follow the typical trigger use case, do
> you agree?
Should do the trigger now we know it's not as hard as expected.

Jonathan
> 
>>
>> Could be cynical and only do anything with the interrupt clearing once both
>> bits are set, but that will cause grief with the IRQ_RISING case.
>> I'm guessing this is really only a level interrupt but we can get away with
>> the rising case as it is slow.
>> Otherwise you can read the status, be told that channel isn't ready yet
>> so don't read it (but read the other that is afterwards) and have the
>> first channel set in the meantime.  No interrupt then occurs.
>>
>> Might be safer to only allow the level interrupt (we went through this
>> with the mega st sensors driver as both Linus Waleij and I had those
>> wired up to edge triggered only interrupt chips and needed to bodge our way
>> around that). Have a look at how hideous that became  if you want to
>> groan - and that was the best we could do.
>>
>> If you do only allow the level case it's not a great help as you'll either
>> spin in and out of the interrupt handler whilst waiting for the second
>> channel or still have to cache the first value then wait for the second
>> to trigger the interrupt again.
>>
>> What fun.
>>
>> Thanks,
>>
>> Jonathan
>>> ---
>>>  drivers/iio/humidity/Kconfig                |   2 +
>>>  drivers/iio/humidity/Makefile               |   1 +
>>>  drivers/iio/humidity/hts221/Kconfig         |  23 +
>>>  drivers/iio/humidity/hts221/Makefile        |   6 +
>>>  drivers/iio/humidity/hts221/hts221.h        |  78 ++++
>>>  drivers/iio/humidity/hts221/hts221_buffer.c | 168 +++++++
>>>  drivers/iio/humidity/hts221/hts221_core.c   | 684 ++++++++++++++++++++++++++++
>>>  drivers/iio/humidity/hts221/hts221_i2c.c    | 110 +++++
>>>  drivers/iio/humidity/hts221/hts221_spi.c    | 125 +++++
>>>  9 files changed, 1197 insertions(+)
>>>  create mode 100644 drivers/iio/humidity/hts221/Kconfig
>>>  create mode 100644 drivers/iio/humidity/hts221/Makefile
>>>  create mode 100644 drivers/iio/humidity/hts221/hts221.h
>>>  create mode 100644 drivers/iio/humidity/hts221/hts221_buffer.c
>>>  create mode 100644 drivers/iio/humidity/hts221/hts221_core.c
>>>  create mode 100644 drivers/iio/humidity/hts221/hts221_i2c.c
>>>  create mode 100644 drivers/iio/humidity/hts221/hts221_spi.c
>>>
>>> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
>>> index b17e2e2..4ce75da 100644
>>> --- a/drivers/iio/humidity/Kconfig
>>> +++ b/drivers/iio/humidity/Kconfig
>>> @@ -69,4 +69,6 @@ config SI7020
>>>         To compile this driver as a module, choose M here: the module
>>>         will be called si7020.
>>>
>>> +source "drivers/iio/humidity/hts221/Kconfig"
>>> +
>> Not to my mind worthy of it's own directory.  Just pull it in directly under
>> the humidity dir.  It's a compact and well organised driver unlike
>> the beasts we tend to shove off into their own directory.
>>
>>>  endmenu
>>> diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
>>> index 4a73442..25e11f3 100644
>>> --- a/drivers/iio/humidity/Makefile
>>> +++ b/drivers/iio/humidity/Makefile
>>> @@ -5,6 +5,7 @@
>>>  obj-$(CONFIG_AM2315) += am2315.o
>>>  obj-$(CONFIG_DHT11) += dht11.o
>>>  obj-$(CONFIG_HDC100X) += hdc100x.o
>>> +obj-$(CONFIG_HTS221) += hts221/
>>>  obj-$(CONFIG_HTU21) += htu21.o
>>>  obj-$(CONFIG_SI7005) += si7005.o
>>>  obj-$(CONFIG_SI7020) += si7020.o
>>> diff --git a/drivers/iio/humidity/hts221/Kconfig b/drivers/iio/humidity/hts221/Kconfig
>>> new file mode 100644
>>> index 0000000..c10013d
>>> --- /dev/null
>>> +++ b/drivers/iio/humidity/hts221/Kconfig
>>> @@ -0,0 +1,23 @@
>>> +
>>> +config HTS221
>>> +     tristate "STMicroelectronics HTS221 sensor Driver"
>>> +     depends on (I2C || SPI)
>>> +     select IIO_BUFFER
>>> +     select IIO_TRIGGERED_BUFFER
>>> +     select HTS221_I2C if (I2C)
>>> +     select HTS221_SPI if (SPI_MASTER)
>>> +     help
>>> +       Say yes here to build support for STMicroelectronics HTS221
>>> +       temperature-humidity sensor
>>> +
>>> +       To compile this driver as a module, choose M here: the module
>>> +       will be called hts221.
>>> +
>>> +config HTS221_I2C
>>> +     tristate
>>> +     depends on HTS221
>>> +
>>> +config HTS221_SPI
>>> +     tristate
>>> +     depends on HTS221
>>> +
>>> diff --git a/drivers/iio/humidity/hts221/Makefile b/drivers/iio/humidity/hts221/Makefile
>>> new file mode 100644
>>> index 0000000..e1f5464
>>> --- /dev/null
>>> +++ b/drivers/iio/humidity/hts221/Makefile
>>> @@ -0,0 +1,6 @@
>>> +hts221-y := hts221_core.o \
>>> +         hts221_buffer.o
>>> +
>>> +obj-$(CONFIG_HTS221) += hts221.o
>>> +obj-$(CONFIG_HTS221_I2C) += hts221_i2c.o
>>> +obj-$(CONFIG_HTS221_SPI) += hts221_spi.o
>>> diff --git a/drivers/iio/humidity/hts221/hts221.h b/drivers/iio/humidity/hts221/hts221.h
>>> new file mode 100644
>>> index 0000000..6e06e6a
>>> --- /dev/null
>>> +++ b/drivers/iio/humidity/hts221/hts221.h
>>> @@ -0,0 +1,78 @@
>>> +/*
>>> + * STMicroelectronics hts221 sensor driver
>>> + *
>>> + * Copyright 2016 STMicroelectronics Inc.
>>> + *
>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>> + *
>>> + * Licensed under the GPL-2.
>>> + */
>>> +
>>> +#ifndef HTS221_H
>>> +#define HTS221_H
>>> +
>>> +#define HTS221_DEV_NAME              "hts221"
>>> +
>>> +#include <linux/iio/iio.h>
>>> +
>>> +#define HTS221_RX_MAX_LENGTH 8
>>> +#define HTS221_TX_MAX_LENGTH 8
>>> +
>>> +#define HTS221_DATA_SIZE     2
>>> +
>>> +struct hts221_transfer_buffer {
>>> +     u8 rx_buf[HTS221_RX_MAX_LENGTH];
>>> +     u8 tx_buf[HTS221_TX_MAX_LENGTH] ____cacheline_aligned;
>>> +};
>>> +
>>> +struct hts221_transfer_function {
>>> +     int (*read)(struct device *dev, u8 addr, int len, u8 *data);
>>> +     int (*write)(struct device *dev, u8 addr, int len, u8 *data);
>>> +};
>>> +
>>> +#define HTS221_AVG_DEPTH     8
>>> +struct hts221_avg_avl {
>>> +     u16 avg;
>>> +     u8 val;
>>> +};
>>> +
>>> +enum hts221_sensor_type {
>>> +     HTS221_SENSOR_H,
>>> +     HTS221_SENSOR_T,
>>> +     HTS221_SENSOR_MAX,
>>> +};
>>> +
>>> +struct hts221_sensor {
>>> +     struct hts221_dev *dev;
>>> +
>>> +     enum hts221_sensor_type type;
>>> +     u8 cur_avg_idx;
>>> +     int slope, b_gen;
>>> +};
>>> +
>>> +struct hts221_dev {
>>> +     const char *name;
>>> +     struct device *dev;
>>> +
>>> +     struct mutex lock;
>>> +
>>> +     u8 buffer[ALIGN(2 * HTS221_DATA_SIZE, sizeof(s64)) + sizeof(s64)];
>>> +     struct iio_trigger *trig;
>>> +     int irq;
>>> +
>>> +     struct hts221_sensor sensors[HTS221_SENSOR_MAX];
>>> +
>>> +     u8 odr;
>>> +
>>> +     const struct hts221_transfer_function *tf;
>>> +     struct hts221_transfer_buffer tb;
>>> +};
>>> +
>>> +int hts221_config_drdy(struct hts221_dev *dev, bool enable);
>>> +int hts221_probe(struct hts221_dev *dev);
>>> +int hts221_dev_power_on(struct hts221_dev *dev);
>>> +int hts221_dev_power_off(struct hts221_dev *dev);
>>> +int hts221_allocate_buffers(struct hts221_dev *dev);
>>> +int hts221_allocate_triggers(struct hts221_dev *dev);
>>> +
>>> +#endif /* HTS221_H */
>>> diff --git a/drivers/iio/humidity/hts221/hts221_buffer.c b/drivers/iio/humidity/hts221/hts221_buffer.c
>>> new file mode 100644
>>> index 0000000..69330b7
>>> --- /dev/null
>>> +++ b/drivers/iio/humidity/hts221/hts221_buffer.c
>>> @@ -0,0 +1,168 @@
>>> +/*
>>> + * STMicroelectronics hts221 sensor driver
>>> + *
>>> + * Copyright 2016 STMicroelectronics Inc.
>>> + *
>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>> + *
>>> + * Licensed under the GPL-2.
>>> + */
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/device.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/irqreturn.h>
>>> +
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/trigger.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/iio/events.h>
>>> +#include <linux/iio/trigger_consumer.h>
>>> +#include <linux/iio/triggered_buffer.h>
>>> +#include <linux/iio/buffer.h>
>>> +
>>> +#include "hts221.h"
>>> +
>>> +#define HTS221_REG_STATUS_ADDR               0x27
>>> +#define HTS221_RH_DRDY_MASK          BIT(1)
>>> +#define HTS221_TEMP_DRDY_MASK                BIT(0)
>>> +
>>> +static int hts221_trig_set_state(struct iio_trigger *trig, bool state)
>>> +{
>>> +     struct iio_dev *iio_dev = iio_trigger_get_drvdata(trig);
>>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>>> +
>>> +     return hts221_config_drdy(dev, state);
>>> +}
>>> +
>>> +static const struct iio_trigger_ops hts221_trigger_ops = {
>>> +     .owner = THIS_MODULE,
>>> +     .set_trigger_state = hts221_trig_set_state,
>>> +};
>>> +
>>> +static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
>>> +{
>>> +     struct hts221_dev *dev = (struct hts221_dev *)private;
>>> +     struct iio_dev *iio_dev = iio_priv_to_dev(dev);
>>> +     struct iio_chan_spec const *ch;
>>> +     int err, count = 0;
>>> +     u8 status;
>>> +
>>> +     err = dev->tf->read(dev->dev, HTS221_REG_STATUS_ADDR, sizeof(status),
>>> +                         &status);
>>> +     if (err < 0)
>>> +             return IRQ_HANDLED;
>>> +
>>> +     /* humidity data */
>>> +     if (status & HTS221_RH_DRDY_MASK) {
>>> +             ch = &iio_dev->channels[HTS221_SENSOR_H];
>>> +             err = dev->tf->read(dev->dev, ch->address, HTS221_DATA_SIZE,
>>> +                                 dev->buffer);
>>> +             if (err < 0)
>>> +                     return IRQ_HANDLED;
>>> +
>>> +             count++;
>>> +     }
>>> +
>>> +     /* temperature data */
>>> +     if (status & HTS221_TEMP_DRDY_MASK) {
>>> +             ch = &iio_dev->channels[HTS221_SENSOR_T];
>>> +             err = dev->tf->read(dev->dev, ch->address, HTS221_DATA_SIZE,
>>> +                                 dev->buffer + 2 * count);
>>> +             if (err < 0)
>>> +                     return IRQ_HANDLED;
>>> +
>>> +             count++;
>>> +     }
>>> +
>>> +     if (count > 0) {
>>> +             iio_trigger_poll_chained(dev->trig);
>>> +             return IRQ_HANDLED;
>> This is odd enough I'd kill off the trigger and have it run as
>> a direct buffer device.  There is no 'necessity' to have a trigger. It
>> just allows us to hang multiple devices together when sampling.
>>
>> As it runs here (I think) we will end up sometimes pushing one sample and
>> sometimes 2 depending on how quickly we get here after the interrupt.
>>
>> That makes for some nasty semantics for this trigger.
>>
>> Hence drop the trigger at which point it becomes unsual handling inside
>> the driver which is fine ;)
>>
>> You should cache values until you have a pair however otherwise any
>> client drivers will get their data turning up in partial scans which would
>> be a mess.  So only push to buffers complete 'scans' which will be both
>> channels if they are both enabled.
>>
>>> +     } else {
>>> +             return IRQ_NONE;
>>> +     }
>>> +}
>>> +
>>> +int hts221_allocate_triggers(struct hts221_dev *dev)
>>> +{
>>> +     struct iio_dev *iio_dev = iio_priv_to_dev(dev);
>>> +     unsigned long irq_type;
>>> +     int err;
>>> +
>>> +     irq_type = irqd_get_trigger_type(irq_get_irq_data(dev->irq));
>>> +
>>> +     switch (irq_type) {
>>> +     case IRQF_TRIGGER_HIGH:
>>> +     case IRQF_TRIGGER_RISING:
>>> +             break;
>>> +     default:
>>> +             dev_info(dev->dev,
>>> +                      "mode %lx unsupported, using IRQF_TRIGGER_RISING\n",
>>> +                      irq_type);
>>> +             irq_type = IRQF_TRIGGER_RISING;
>>> +             break;
>>> +     }
>>> +
>>> +     err = devm_request_threaded_irq(dev->dev, dev->irq, NULL,
>>> +                                     hts221_trigger_handler_thread,
>>> +                                     irq_type | IRQF_ONESHOT,
>>> +                                     dev->name, dev);
>>> +     if (err) {
>>> +             dev_err(dev->dev, "failed to request trigger irq %d\n",
>>> +                     dev->irq);
>>> +             return err;
>>> +     }
>>> +
>>> +     dev->trig = devm_iio_trigger_alloc(dev->dev, "%s-trigger",
>>> +                                        iio_dev->name);
>>> +     if (!dev->trig)
>>> +             return -ENOMEM;
>>> +
>>> +     iio_trigger_set_drvdata(dev->trig, iio_dev);
>>> +     dev->trig->ops = &hts221_trigger_ops;
>>> +     dev->trig->dev.parent = dev->dev;
>>> +     iio_dev->trig = iio_trigger_get(dev->trig);
>>> +
>>> +     return devm_iio_trigger_register(dev->dev, dev->trig);
>>> +}
>>> +
>>> +static int hts221_buffer_preenable(struct iio_dev *iio_dev)
>>> +{
>>> +     return hts221_dev_power_on(iio_priv(iio_dev));
>>> +}
>>> +
>>> +static int hts221_buffer_postdisable(struct iio_dev *iio_dev)
>>> +{
>>> +     return hts221_dev_power_off(iio_priv(iio_dev));
>>> +}
>>> +
>>> +static const struct iio_buffer_setup_ops hts221_buffer_ops = {
>>> +     .preenable = hts221_buffer_preenable,
>>> +     .postenable = iio_triggered_buffer_postenable,
>>> +     .predisable = iio_triggered_buffer_predisable,
>>> +     .postdisable = hts221_buffer_postdisable,
>>> +};
>>> +
>>> +static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
>>> +{
>>> +     struct iio_poll_func *pf = p;
>>> +     struct iio_dev *iio_dev = pf->indio_dev;
>>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>>> +
>> Suprised me that the read wasn't in here...
>>> +     iio_push_to_buffers_with_timestamp(iio_dev, dev->buffer,
>>> +                                        iio_get_time_ns(iio_dev));
>>> +     iio_trigger_notify_done(dev->trig);
>>> +
>>> +     return IRQ_HANDLED;
>>> +}
>>> +
>>> +int hts221_allocate_buffers(struct hts221_dev *dev)
>>> +{
>>> +     return devm_iio_triggered_buffer_setup(dev->dev, iio_priv_to_dev(dev),
>>> +                                     NULL, hts221_buffer_handler_thread,
>>> +                                     &hts221_buffer_ops);
>>> +}
>>> +
>>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>>> +MODULE_DESCRIPTION("STMicroelectronics hts221 buffer driver");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/iio/humidity/hts221/hts221_core.c b/drivers/iio/humidity/hts221/hts221_core.c
>>> new file mode 100644
>>> index 0000000..a537798
>>> --- /dev/null
>>> +++ b/drivers/iio/humidity/hts221/hts221_core.c
>>> @@ -0,0 +1,684 @@
>>> +/*
>>> + * STMicroelectronics hts221 sensor driver
>>> + *
>>> + * Copyright 2016 STMicroelectronics Inc.
>>> + *
>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>> + *
>>> + * Licensed under the GPL-2.
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/device.h>
>>> +#include <linux/iio/sysfs.h>
>>> +#include <linux/delay.h>
>>> +#include <asm/unaligned.h>
>>> +
>>> +#include "hts221.h"
>>> +
>>> +#define HTS221_REG_WHOAMI_ADDR               0x0f
>>> +#define HTS221_REG_WHOAMI_VAL                0xbc
>>> +
>>> +#define HTS221_REG_CNTRL1_ADDR               0x20
>>> +#define HTS221_REG_CNTRL2_ADDR               0x21
>>> +#define HTS221_REG_CNTRL3_ADDR               0x22
>>> +
>>> +#define HTS221_REG_AVG_ADDR          0x10
>>> +#define HTS221_REG_H_OUT_L           0x28
>>> +#define HTS221_REG_T_OUT_L           0x2a
>>> +
>>> +#define HTS221_HUMIDITY_AVG_MASK     0x07
>>> +#define HTS221_TEMP_AVG_MASK         0x38
>>> +
>>> +#define HTS221_ODR_MASK                      0x87
>>> +#define HTS221_BDU_MASK                      BIT(2)
>>> +
>>> +#define HTS221_DRDY_MASK             BIT(2)
>>> +
>>> +#define HTS221_ENABLE_SENSOR         BIT(7)
>>> +
>>> +#define HTS221_HUMIDITY_AVG_4                0x00 /* 0.4 %RH */
>>> +#define HTS221_HUMIDITY_AVG_8                0x01 /* 0.3 %RH */
>>> +#define HTS221_HUMIDITY_AVG_16               0x02 /* 0.2 %RH */
>>> +#define HTS221_HUMIDITY_AVG_32               0x03 /* 0.15 %RH */
>>> +#define HTS221_HUMIDITY_AVG_64               0x04 /* 0.1 %RH */
>>> +#define HTS221_HUMIDITY_AVG_128              0x05 /* 0.07 %RH */
>>> +#define HTS221_HUMIDITY_AVG_256              0x06 /* 0.05 %RH */
>>> +#define HTS221_HUMIDITY_AVG_512              0x07 /* 0.03 %RH */
>>> +
>>> +#define HTS221_TEMP_AVG_2            0x00 /* 0.08 degC */
>>> +#define HTS221_TEMP_AVG_4            0x08 /* 0.05 degC */
>>> +#define HTS221_TEMP_AVG_8            0x10 /* 0.04 degC */
>>> +#define HTS221_TEMP_AVG_16           0x18 /* 0.03 degC */
>>> +#define HTS221_TEMP_AVG_32           0x20 /* 0.02 degC */
>>> +#define HTS221_TEMP_AVG_64           0x28 /* 0.015 degC */
>>> +#define HTS221_TEMP_AVG_128          0x30 /* 0.01 degC */
>>> +#define HTS221_TEMP_AVG_256          0x38 /* 0.007 degC */
>>> +
>>> +/* calibration registers */
>>> +#define HTS221_REG_0RH_CAL_X_H               0x36
>>> +#define HTS221_REG_1RH_CAL_X_H               0x3a
>>> +#define HTS221_REG_0RH_CAL_Y_H               0x30
>>> +#define HTS221_REG_1RH_CAL_Y_H               0x31
>>> +#define HTS221_REG_0T_CAL_X_L                0x3c
>>> +#define HTS221_REG_1T_CAL_X_L                0x3e
>>> +#define HTS221_REG_0T_CAL_Y_H                0x32
>>> +#define HTS221_REG_1T_CAL_Y_H                0x33
>>> +#define HTS221_REG_T1_T0_CAL_Y_H     0x35
>>> +
>>> +struct hts221_odr {
>>> +     u8 hz;
>>> +     u8 val;
>>> +};
>>> +
>>> +struct hts221_avg {
>>> +     u8 addr;
>>> +     u8 mask;
>>> +     struct hts221_avg_avl avg_avl[HTS221_AVG_DEPTH];
>>> +};
>>> +
>>> +static const struct hts221_odr hts221_odr_table[] = {
>>> +     { 1, 0x01 },    /* 1Hz */
>>> +     { 7, 0x02 },    /* 7Hz */
>>> +     { 13, 0x03 },   /* 12.5Hz */
>>> +};
>>> +
>>> +static const struct hts221_avg hts221_avg_list[] = {
>>> +     {
>>> +             .addr = HTS221_REG_AVG_ADDR,
>>> +             .mask = HTS221_HUMIDITY_AVG_MASK,
>>> +             .avg_avl = {
>>> +                     { 4, HTS221_HUMIDITY_AVG_4 },
>>> +                     { 8, HTS221_HUMIDITY_AVG_8 },
>>> +                     { 16, HTS221_HUMIDITY_AVG_16 },
>>> +                     { 32, HTS221_HUMIDITY_AVG_32 },
>>> +                     { 64, HTS221_HUMIDITY_AVG_64 },
>>> +                     { 128, HTS221_HUMIDITY_AVG_128 },
>>> +                     { 256, HTS221_HUMIDITY_AVG_256 },
>>> +                     { 512, HTS221_HUMIDITY_AVG_512 },
>>> +             },
>>> +     },
>>> +     {
>>> +             .addr = HTS221_REG_AVG_ADDR,
>>> +             .mask = HTS221_TEMP_AVG_MASK,
>>> +             .avg_avl = {
>>> +                     { 2, HTS221_TEMP_AVG_2 },
>>> +                     { 4, HTS221_TEMP_AVG_4 },
>>> +                     { 8, HTS221_TEMP_AVG_8 },
>>> +                     { 16, HTS221_TEMP_AVG_16 },
>>> +                     { 32, HTS221_TEMP_AVG_32 },
>>> +                     { 64, HTS221_TEMP_AVG_64 },
>>> +                     { 128, HTS221_TEMP_AVG_128 },
>>> +                     { 256, HTS221_TEMP_AVG_256 },
>>> +             },
>>> +     },
>>> +};
>>> +
>>> +static const struct iio_chan_spec hts221_channels[] = {
>>> +     {
>>> +             .type = IIO_HUMIDITYRELATIVE,
>>> +             .address = HTS221_REG_H_OUT_L,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> +                                   BIT(IIO_CHAN_INFO_OFFSET) |
>>> +                                   BIT(IIO_CHAN_INFO_SCALE) |
>>> +                                   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>>> +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>> +             .scan_index = 0,
>>> +             .scan_type = {
>>> +                     .sign = 's',
>>> +                     .realbits = 16,
>>> +                     .storagebits = 16,
>>> +                     .endianness = IIO_LE,
>>> +             },
>>> +     },
>>> +     {
>>> +             .type = IIO_TEMP,
>>> +             .address = HTS221_REG_T_OUT_L,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> +                                   BIT(IIO_CHAN_INFO_OFFSET) |
>>> +                                   BIT(IIO_CHAN_INFO_SCALE) |
>>> +                                   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>>> +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>> +             .scan_index = 1,
>>> +             .scan_type = {
>>> +                     .sign = 's',
>>> +                     .realbits = 16,
>>> +                     .storagebits = 16,
>>> +                     .endianness = IIO_LE,
>>> +             },
>>> +     },
>>> +     IIO_CHAN_SOFT_TIMESTAMP(2),
>>> +};
>>> +
>>> +static int hts221_write_with_mask(struct hts221_dev *dev, u8 addr, u8 mask,
>>> +                               u8 val)
>>> +{
>>> +     u8 data;
>>> +     int err;
>>> +
>>> +     mutex_lock(&dev->lock);
>>> +
>>> +     err = dev->tf->read(dev->dev, addr, sizeof(data), &data);
>>> +     if (err < 0) {
>>> +             dev_err(dev->dev, "failed to read %02x register\n", addr);
>> Looks like a good spot for a goto error_unlock then return err at
>> the end of this function.
>>
>> Makes it slightly less likely someone will mess up the locking in the future.
>>> +             mutex_unlock(&dev->lock);
>>> +
>>> +             return err;
>>> +     }
>>> +
>>> +     data = (data & ~mask) | (val & mask);
>>> +
>>> +     err = dev->tf->write(dev->dev, addr, sizeof(data), &data);
>>> +     if (err < 0) {
>>> +             dev_err(dev->dev, "failed to write %02x register\n", addr);
>>> +             mutex_unlock(&dev->lock);
>>> +
>>> +             return err;
>>> +     }
>>> +
>>> +     mutex_unlock(&dev->lock);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int hts221_check_whoami(struct hts221_dev *dev)
>>> +{
>>> +     u8 data;
>>> +     int err;
>>> +
>>> +     err = dev->tf->read(dev->dev, HTS221_REG_WHOAMI_ADDR, sizeof(data),
>>> +                         &data);
>>> +     if (err < 0) {
>>> +             dev_err(dev->dev, "failed to read whoami register\n");
>>> +             return err;
>>> +     }
>>> +
>>> +     if (data != HTS221_REG_WHOAMI_VAL) {
>>> +             dev_err(dev->dev, "wrong whoami {%02x vs %02x}\n",
>>> +                     data, HTS221_REG_WHOAMI_VAL);
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +int hts221_config_drdy(struct hts221_dev *dev, bool enable)
>>> +{
>>> +     u8 val = enable ? BIT(2) : 0;
>> BIT(2)? As opposed to HTS221_DRDY_MASK
> 
> did not get you, what do you mean?
> 
>>> +
>>> +     return hts221_write_with_mask(dev, HTS221_REG_CNTRL3_ADDR,
>>> +                                   HTS221_DRDY_MASK, val);
>>> +}
>>> +
>>> +static int hts221_update_odr(struct hts221_dev *dev, u8 odr)
>>> +{
>>> +     int i, err;
>>> +     u8 val;
>>> +
>>> +     for (i = 0; i < ARRAY_SIZE(hts221_odr_table); i++)
>>> +             if (hts221_odr_table[i].hz == odr)
>>> +                     break;
>>> +
>>> +     if (i == ARRAY_SIZE(hts221_odr_table))
>>> +             return -EINVAL;
>>> +
>>> +     val = HTS221_ENABLE_SENSOR | HTS221_BDU_MASK | hts221_odr_table[i].val;
>>> +     err = hts221_write_with_mask(dev, HTS221_REG_CNTRL1_ADDR,
>>> +                                  HTS221_ODR_MASK, val);
>>> +     if (err < 0)
>>> +             return err;
>>> +
>>> +     dev->odr = odr;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int hts221_update_avg(struct hts221_sensor *sensor, u16 val)
>>> +{
>>> +     int i, err;
>>> +     const struct hts221_avg *avg = &hts221_avg_list[sensor->type];
>>> +
>>> +     for (i = 0; i < HTS221_AVG_DEPTH; i++)
>>> +             if (avg->avg_avl[i].avg == val)
>>> +                     break;
>>> +
>>> +     if (i == HTS221_AVG_DEPTH)
>>> +             return -EINVAL;
>>> +
>>> +     err = hts221_write_with_mask(sensor->dev, avg->addr, avg->mask,
>>> +                                  avg->avg_avl[i].val);
>>> +     if (err < 0)
>>> +             return err;
>>> +
>>> +     sensor->cur_avg_idx = i;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static ssize_t hts221_sysfs_sampling_freq(struct device *dev,
>>> +                                       struct device_attribute *attr,
>>> +                                       char *buf)
>>> +{
>>> +     int i;
>>> +     ssize_t len = 0;
>>> +
>>> +     for (i = 0; i < ARRAY_SIZE(hts221_odr_table); i++)
>>> +             len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
>>> +                              hts221_odr_table[i].hz);
>>> +     buf[len - 1] = '\n';
>>> +
>>> +     return len;
>>> +}
>>> +
>>> +static ssize_t
>>> +hts221_sysfs_rh_oversampling_avail(struct device *dev,
>>> +                                struct device_attribute *attr,
>>> +                                char *buf)
>>> +{
>>> +     const struct hts221_avg *avg = &hts221_avg_list[HTS221_SENSOR_H];
>>> +     ssize_t len = 0;
>>> +     int i;
>>> +
>>> +     for (i = 0; i < ARRAY_SIZE(avg->avg_avl); i++)
>>> +             len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
>>> +                              avg->avg_avl[i].avg);
>>> +     buf[len - 1] = '\n';
>>> +
>>> +     return len;
>>> +}
>>> +
>>> +static ssize_t
>>> +hts221_sysfs_temp_oversampling_avail(struct device *dev,
>>> +                                  struct device_attribute *attr,
>>> +                                  char *buf)
>>> +{
>>> +     const struct hts221_avg *avg = &hts221_avg_list[HTS221_SENSOR_T];
>>> +     ssize_t len = 0;
>>> +     int i;
>>> +
>>> +     for (i = 0; i < ARRAY_SIZE(avg->avg_avl); i++)
>>> +             len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
>>> +                              avg->avg_avl[i].avg);
>>> +     buf[len - 1] = '\n';
>>> +
>>> +     return len;
>>> +}
>>> +
>>> +int hts221_dev_power_on(struct hts221_dev *dev)
>>> +{
>>> +     struct hts221_sensor *sensor;
>>> +     int i, err, val;
>>> +
>>> +     for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>>> +             sensor = &dev->sensors[i];
>>> +             val = hts221_avg_list[i].avg_avl[sensor->cur_avg_idx].avg;
>>> +
>>> +             err = hts221_update_avg(sensor, val);
>>> +             if (err < 0)
>>> +                     return err;
>>> +     }
>>> +
>>> +     err = hts221_update_odr(dev, dev->odr);
>>> +     if (err < 0)
>>> +             return err;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +int hts221_dev_power_off(struct hts221_dev *dev)
>>> +{
>>> +     u8 data[] = {0x00, 0x00};
>>> +
>>> +     return dev->tf->write(dev->dev, HTS221_REG_CNTRL1_ADDR, sizeof(data),
>>> +                           data);
>>> +}
>>> +
>> Ouch to the next function.  That's irritatingly random difference between
>> the two calibrations. I'd almost be tempted to separate them entirely
>> and just have two functions.  The shared code isn't huge and the 16 vs 8 bit
>> cal values left me wondering what was going on in here for a few moments.
>>
>> What do you think?
> 
> ack. In v4 will have two separate calibration functions for temperature and
> humidity sensors
> 
>>> +static int hts221_parse_caldata(struct hts221_sensor *sensor)
>>> +{
>>> +     int err, *slope, *b_gen;
>>> +     u8 addr_x0, addr_x1;
>>> +     s16 cal_x0, cal_x1, cal_y0, cal_y1;
>>> +     struct hts221_dev *dev = sensor->dev;
>>> +
>>> +     switch (sensor->type) {
>>> +     case HTS221_SENSOR_H: {
>>> +             u8 data;
>>> +
>>> +             addr_x0 = HTS221_REG_0RH_CAL_X_H;
>>> +             addr_x1 = HTS221_REG_1RH_CAL_X_H;
>>> +             cal_y1 = 0;
>>> +             cal_y0 = 0;
>>> +
>>> +             err = dev->tf->read(dev->dev, HTS221_REG_0RH_CAL_Y_H,
>>> +                                 sizeof(data), &data);
>>> +             if (err < 0)
>>> +                     return err;
>>> +             cal_y0 = data;
>>> +
>>> +             err = dev->tf->read(dev->dev, HTS221_REG_1RH_CAL_Y_H,
>>> +                                 sizeof(data), &data);
>>> +             if (err < 0)
>>> +                     return err;
>>> +             cal_y1 = data;
>>> +
>>> +             break;
>>> +     }
>>> +     case HTS221_SENSOR_T: {
>>> +             u8 cal0, cal1;
>>> +
>>> +             addr_x0 = HTS221_REG_0T_CAL_X_L;
>>> +             addr_x1 = HTS221_REG_1T_CAL_X_L;
>>> +
>>> +             err = dev->tf->read(dev->dev, HTS221_REG_0T_CAL_Y_H,
>>> +                                 sizeof(cal0), &cal0);
>>> +             if (err < 0)
>>> +                     return err;
>>> +
>>> +             err = dev->tf->read(dev->dev, HTS221_REG_T1_T0_CAL_Y_H,
>>> +                                 sizeof(cal1), &cal1);
>>> +             if (err < 0)
>>> +                     return err;
>>> +             cal_y0 = (le16_to_cpu(cal1 & 0x3) << 8) | cal0;
>>> +
>>> +             err = dev->tf->read(dev->dev, HTS221_REG_1T_CAL_Y_H,
>>> +                                 sizeof(cal0), &cal0);
>>> +             if (err < 0)
>>> +                     return err;
>>> +
>>> +             err = dev->tf->read(dev->dev, HTS221_REG_T1_T0_CAL_Y_H,
>>> +                                 sizeof(cal1), &cal1);
>>> +             if (err < 0)
>>> +                     return err;
>>> +             cal_y1 = (((cal1 & 0xc) >> 2) << 8) | cal0;
>>> +             break;
>>> +     }
>>> +     default:
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     err = dev->tf->read(dev->dev, addr_x0, sizeof(cal_x0), (u8 *)&cal_x0);
>>> +     if (err < 0)
>>> +             return err;
>>> +     cal_x0 = le16_to_cpu(cal_x0);
>>> +
>>> +     err = dev->tf->read(dev->dev, addr_x1, sizeof(cal_x1), (u8 *)&cal_x1);
>>> +     if (err < 0)
>>> +             return err;
>>> +     cal_x1 = le16_to_cpu(cal_x1);
>>> +
>>> +     slope = &sensor->slope;
>>> +     b_gen = &sensor->b_gen;
>>> +
>>> +     *slope = ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0);
>>> +     *b_gen = (((s32)cal_x1 * cal_y0 - (s32)cal_x0 * cal_y1) * 1000) /
>>> +              (cal_x1 - cal_x0);
>>> +     *b_gen *= 8;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int hts221_read_raw(struct iio_dev *iio_dev,
>>> +                        struct iio_chan_spec const *ch,
>>> +                        int *val, int *val2, long mask)
>>> +{
>>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>>> +     int ret;
>>> +
>>> +     ret = iio_device_claim_direct_mode(iio_dev);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     switch (mask) {
>>> +     case IIO_CHAN_INFO_RAW: {
>>> +             u8 data[HTS221_DATA_SIZE];
>>> +
>>> +             ret = hts221_dev_power_on(dev);
>>> +             if (ret < 0)
>>> +                     goto out;
>>> +
>>> +             msleep(50);
>>> +
>>> +             ret = dev->tf->read(dev->dev, ch->address, sizeof(data), data);
>>> +             if (ret < 0)
>>> +                     goto out;
>>> +
>>> +             ret = hts221_dev_power_off(dev);
>>> +             if (ret < 0)
>>> +                     goto out;
>>> +
>>> +             *val = (s16)get_unaligned_le16(data);
>>> +             ret = IIO_VAL_INT;
>>> +
>>> +             break;
>>> +     }
>>> +     case IIO_CHAN_INFO_SCALE: {
>>> +             s64 tmp;
>>> +             s32 rem, div, data;
>>> +
>>> +             switch (ch->type) {
>>> +             case IIO_HUMIDITYRELATIVE:
>>> +                     data = dev->sensors[HTS221_SENSOR_H].slope;
>>> +                     div = (1 << 4) * 1000;
>>> +                     break;
>>> +             case IIO_TEMP:
>>> +                     data = dev->sensors[HTS221_SENSOR_T].slope;
>>> +                     div = (1 << 6) * 1000;
>>> +                     break;
>>> +             default:
>>> +                     goto out;
>>> +             }
>>> +
>>> +             tmp = div_s64(data * 1000000000LL, div);
>>> +             tmp = div_s64_rem(tmp, 1000000000LL, &rem);
>>> +
>>> +             *val = tmp;
>>> +             *val2 = rem;
>>> +             ret = IIO_VAL_INT_PLUS_NANO;
>>> +             break;
>>> +     }
>>> +     case IIO_CHAN_INFO_OFFSET: {
>>> +             s64 tmp;
>>> +             s32 rem, div, data;
>>> +
>>> +             switch (ch->type) {
>>> +             case IIO_HUMIDITYRELATIVE:
>>> +                     data = dev->sensors[HTS221_SENSOR_H].b_gen;
>>> +                     div = dev->sensors[HTS221_SENSOR_H].slope;
>>> +                     break;
>>> +             case IIO_TEMP:
>>> +                     data = dev->sensors[HTS221_SENSOR_T].b_gen;
>>> +                     div = dev->sensors[HTS221_SENSOR_T].slope;
>>> +                     break;
>>> +             default:
>> Is ret set in this path?
>> Hmm. there is more here than below, so perhaps the slightly ugly goto out
>> is the best option.  I'd be tempted to factor out the IIO_CHAN_INFO_OFFSET
>> block into it's own function though as it's complicated enough to mean
>> that would make it slightly cleaner to read perhaps...
>>
>> Probably worth doing for all the top level switch elements in here as
>> the whole function is a bit too bulky for my liking.
>>
>> Side effect that we can get rid of all the goto out stuff ;)
> 
> ack. v4 will have two separate functions for IIO_CHAN_INFO_SCALE
> and IIO_CHAN_INFO_OFFSET cases
> 
>>> +                     goto out;
>>> +             }
>>> +
>>> +             tmp = div_s64(data * 1000000000LL, div);
>>> +             tmp = div_s64_rem(tmp, 1000000000LL, &rem);
>>> +
>>> +             *val = tmp;
>>> +             *val2 = abs(rem);
>> Why abs? Remainder not guaranteed to be positive?
>>> +             ret = IIO_VAL_INT_PLUS_NANO;
>>> +             break;
>>> +     }
>>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>>> +             *val = dev->odr;
>>> +             ret = IIO_VAL_INT;
>>> +             break;
>>> +     case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
>>> +             u8 idx;
>>> +             const struct hts221_avg *avg;
>>> +
>>> +             switch (ch->type) {
>>> +             case IIO_HUMIDITYRELATIVE:
>>> +                     avg = &hts221_avg_list[HTS221_SENSOR_H];
>>> +                     idx = dev->sensors[HTS221_SENSOR_H].cur_avg_idx;
>>> +                     break;
>>> +             case IIO_TEMP:
>>> +                     avg = &hts221_avg_list[HTS221_SENSOR_T];
>>> +                     idx = dev->sensors[HTS221_SENSOR_T].cur_avg_idx;
>>> +                     break;
>>> +             default:
>> ret not set (I think) in this path. I'd set it explicitly here to
>> make it clear what is going on rather than doing an intiialize at the
>> beginning or anything horrible like that.
>>> +                     goto out;
>>> +             }
>>> +
>>> +             *val = avg->avg_avl[idx].avg;
>>> +             ret = IIO_VAL_INT;
>> Similar comment to I made on the next function (I always review
>> backwards as drivers make more sense 'top down'.)
>>> +             break;
>>> +     }
>>> +     default:
>>> +             ret = -EINVAL;
>>> +             break;
>>> +     }
>>> +
>>> +out:
>>> +     iio_device_release_direct_mode(iio_dev);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int hts221_write_raw(struct iio_dev *iio_dev,
>>> +                         struct iio_chan_spec const *chan,
>>> +                         int val, int val2, long mask)
>>> +{
>>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>>> +     int ret;
>>> +
>>> +     ret = iio_device_claim_direct_mode(iio_dev);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     switch (mask) {
>>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>>> +             ret = hts221_update_odr(dev, val);
>>> +             break;
>>> +     case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
>>> +             enum hts221_sensor_type type;
>>> +
>>> +             switch (chan->type) {
>>> +             case IIO_HUMIDITYRELATIVE:
>>> +                     type = HTS221_SENSOR_H;
>>> +                     break;
>>> +             case IIO_TEMP:
>>> +                     type = HTS221_SENSOR_T;
>>> +                     break;
>>> +             default:
>>> +                     ret = -EINVAL;
>>> +                     goto out;
>> Really minor personal taste bit coming up ;) Feel free to ignore this
>> one if you disagree!
>>
>> Personally I'm never that keen on goto's out of switch statements. They
>> make for slightly confusing code to follow.  (not too bad here though!)
>>
>> I'd be tempted to go with
>>                 case IIO_HUMIDITYRELATIVE:
>>                         ret = hts221_update_avg(&dev->sensors[HTS221_SENSOR_H],
>>                                                 val);
>>                         break;
>>                 case IIO_TEMP:
>>                         ret = hts221_update_avg(&dev->sensors[HTS221_SENSOR_T],
>>                                                 val);
>>                         break;
>>                 }
>>                 break;
>>
> 
> ack, cleaner in this way :)
> 
>>> +             }
>>> +
>>> +             ret = hts221_update_avg(&dev->sensors[type], val);
>>> +             break;
>>> +     }
>>> +     default:
>>> +             ret = -EINVAL;
>>> +             break;
>>> +     }
>>> +
>>> +out:
>>> +     iio_device_release_direct_mode(iio_dev);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int hts221_validate_trigger(struct iio_dev *iio_dev,
>>> +                                struct iio_trigger *trig)
>>> +{
>>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>>> +
>>> +     return dev->trig == trig ? 0 : -EINVAL;
>>> +}
>>> +
>>> +static IIO_DEVICE_ATTR(in_humidity_oversampling_ratio_available, S_IRUGO,
>>> +                    hts221_sysfs_rh_oversampling_avail, NULL, 0);
>>> +static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available, S_IRUGO,
>>> +                    hts221_sysfs_temp_oversampling_avail, NULL, 0);
>>> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hts221_sysfs_sampling_freq);
>>> +
>>> +static struct attribute *hts221_attributes[] = {
>>> +     &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>>> +     &iio_dev_attr_in_humidity_oversampling_ratio_available.dev_attr.attr,
>>> +     &iio_dev_attr_in_temp_oversampling_ratio_available.dev_attr.attr,
>>> +     NULL,
>>> +};
>>> +
>>> +static const struct attribute_group hts221_attribute_group = {
>>> +     .attrs = hts221_attributes,
>>> +};
>>> +
>>> +static const struct iio_info hts221_info = {
>>> +     .driver_module = THIS_MODULE,
>>> +     .attrs = &hts221_attribute_group,
>>> +     .read_raw = hts221_read_raw,
>>> +     .write_raw = hts221_write_raw,
>>> +     .validate_trigger = hts221_validate_trigger,
>>> +};
>>> +
>>> +static const unsigned long hts221_scan_masks[] = {0x3, 0x0};
>>> +
>>> +int hts221_probe(struct hts221_dev *dev)
>>> +{
>>> +     struct iio_dev *iio_dev = iio_priv_to_dev(dev);
>>
>> I'd prefer you pass in the iio_dev pointer and go the other way.
>> Mostly because that's the way round that most drivers do it so it
>> is the 'obviously correct' option.
>>
>> Took a lot of arguments to allow the iio_priv_to_dev function in
>> in the first place as it allows for this, but there are a few
>> tiny corners where it makes sense so we let it in.
>>
>>> +     int i, err;
>>> +
>>> +     mutex_init(&dev->lock);
>>> +
>>> +     err = hts221_check_whoami(dev);
>>> +     if (err < 0)
>>> +             return err;
>>> +
>>> +     err = hts221_update_odr(dev, 1);
>>> +     if (err < 0)
>>> +             return err;
>>> +
>>> +     dev->odr = hts221_odr_table[0].hz;
>>> +
>>> +     iio_dev->modes = INDIO_DIRECT_MODE;
>>> +     iio_dev->dev.parent = dev->dev;
>>> +     iio_dev->available_scan_masks = hts221_scan_masks;
>>> +     iio_dev->channels = hts221_channels;
>>> +     iio_dev->num_channels = ARRAY_SIZE(hts221_channels);
>>> +     iio_dev->name = HTS221_DEV_NAME;
>>> +     iio_dev->info = &hts221_info;
>>> +
>>> +     for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>>> +             dev->sensors[i].type = i;
>>> +             dev->sensors[i].dev = dev;
>>> +
>>> +             err = hts221_update_avg(&dev->sensors[i],
>>> +                                     hts221_avg_list[i].avg_avl[3].avg);
>>> +             if (err < 0)
>>> +                     goto power_off;
>>> +
>>> +             err = hts221_parse_caldata(&dev->sensors[i]);
>>> +             if (err < 0)
>>> +                     goto power_off;
>>> +     }
>>> +
>>> +     err = hts221_dev_power_off(dev);
>>> +     if (err < 0)
>>> +             return err;
>>> +
>>> +     if (dev->irq > 0) {
>>> +             err = hts221_allocate_buffers(dev);
>>> +             if (err < 0)
>>> +                     return err;
>>> +
>>> +             err = hts221_allocate_triggers(dev);
>>> +             if (err)
>>> +                     return err;
>>> +     }
>>> +
>>> +     return devm_iio_device_register(dev->dev, iio_dev);
>>> +
>>> +power_off:
>>> +     hts221_dev_power_off(dev);
>>> +
>>> +     return err;
>>> +}
>>> +EXPORT_SYMBOL(hts221_probe);
>>> +
>>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>>> +MODULE_DESCRIPTION("STMicroelectronics hts221 sensor driver");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/iio/humidity/hts221/hts221_i2c.c b/drivers/iio/humidity/hts221/hts221_i2c.c
>>> new file mode 100644
>>> index 0000000..fca9bad
>>> --- /dev/null
>>> +++ b/drivers/iio/humidity/hts221/hts221_i2c.c
>>> @@ -0,0 +1,110 @@
>>> +/*
>>> + * STMicroelectronics hts221 i2c driver
>>> + *
>>> + * Copyright 2016 STMicroelectronics Inc.
>>> + *
>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>> + *
>>> + * Licensed under the GPL-2.
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/slab.h>
>>> +#include "hts221.h"
>>> +
>>> +#define I2C_AUTO_INCREMENT   0x80
>>> +
>>> +static int hts221_i2c_read(struct device *dev, u8 addr, int len, u8 *data)
>>> +{
>>> +     struct i2c_msg msg[2];
>>> +     struct i2c_client *client = to_i2c_client(dev);
>>> +
>>> +     if (len > 1)
>>> +             addr |= I2C_AUTO_INCREMENT;
>>> +
>>> +     msg[0].addr = client->addr;
>>> +     msg[0].flags = client->flags;
>>> +     msg[0].len = 1;
>>> +     msg[0].buf = &addr;
>>> +
>>> +     msg[1].addr = client->addr;
>>> +     msg[1].flags = client->flags | I2C_M_RD;
>>> +     msg[1].len = len;
>>> +     msg[1].buf = data;
>>> +
>>> +     return i2c_transfer(client->adapter, msg, 2);
>>> +}
>>> +
>>> +static int hts221_i2c_write(struct device *dev, u8 addr, int len, u8 *data)
>>> +{
>>> +     u8 send[len + 1];
>>> +     struct i2c_msg msg;
>>> +     struct i2c_client *client = to_i2c_client(dev);
>>> +
>>> +     if (len > 1)
>>> +             addr |= I2C_AUTO_INCREMENT;
>>> +
>>> +     send[0] = addr;
>>> +     memcpy(&send[1], data, len * sizeof(u8));
>>> +
>>> +     msg.addr = client->addr;
>>> +     msg.flags = client->flags;
>>> +     msg.len = len + 1;
>>> +     msg.buf = send;
>>> +
>>> +     return i2c_transfer(client->adapter, &msg, 1);
>>> +}
>>> +
>>> +static const struct hts221_transfer_function hts221_transfer_fn = {
>>> +     .read = hts221_i2c_read,
>>> +     .write = hts221_i2c_write,
>>> +};
>>> +
>>> +static int hts221_i2c_probe(struct i2c_client *client,
>>> +                         const struct i2c_device_id *id)
>>> +{
>>> +     struct hts221_dev *dev;
>>> +     struct iio_dev *iio_dev;
>>> +
>>> +     iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev));
>>> +     if (!iio_dev)
>>> +             return -ENOMEM;
>>> +
>>> +     i2c_set_clientdata(client, iio_dev);
>>> +
>>> +     dev = iio_priv(iio_dev);
>>> +     dev->name = client->name;
>>> +     dev->dev = &client->dev;
>>> +     dev->irq = client->irq;
>>> +     dev->tf = &hts221_transfer_fn;
>>> +
>>> +     return hts221_probe(dev);
>>> +}
>>> +
>>> +static const struct of_device_id hts221_i2c_of_match[] = {
>>> +     { .compatible = "st,hts221", },
>>> +     {},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, hts221_i2c_of_match);
>>> +
>>> +static const struct i2c_device_id hts221_i2c_id_table[] = {
>>> +     { HTS221_DEV_NAME },
>>> +     {},
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, hts221_i2c_id_table);
>>> +
>>> +static struct i2c_driver hts221_driver = {
>>> +     .driver = {
>>> +             .name = "hts221_i2c",
>>> +             .of_match_table = of_match_ptr(hts221_i2c_of_match),
>>> +     },
>>> +     .probe = hts221_i2c_probe,
>>> +     .id_table = hts221_i2c_id_table,
>>> +};
>>> +module_i2c_driver(hts221_driver);
>>> +
>>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>>> +MODULE_DESCRIPTION("STMicroelectronics hts221 i2c driver");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/iio/humidity/hts221/hts221_spi.c b/drivers/iio/humidity/hts221/hts221_spi.c
>>> new file mode 100644
>>> index 0000000..f128165
>>> --- /dev/null
>>> +++ b/drivers/iio/humidity/hts221/hts221_spi.c
>>> @@ -0,0 +1,125 @@
>>> +/*
>>> + * STMicroelectronics hts221 spi driver
>>> + *
>>> + * Copyright 2016 STMicroelectronics Inc.
>>> + *
>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>> + *
>>> + * Licensed under the GPL-2.
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/spi/spi.h>
>>> +#include <linux/slab.h>
>>> +#include "hts221.h"
>>> +
>>> +#define SENSORS_SPI_READ     0x80
>>> +#define SPI_AUTO_INCREMENT   0x40
>>> +
>>> +static int hts221_spi_read(struct device *device, u8 addr, int len, u8 *data)
>>> +{
>>> +     int err;
>>> +     struct spi_device *spi = to_spi_device(device);
>>> +     struct iio_dev *iio_dev = spi_get_drvdata(spi);
>>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>>> +
>>> +     struct spi_transfer xfers[] = {
>>> +             {
>>> +                     .tx_buf = dev->tb.tx_buf,
>>> +                     .bits_per_word = 8,
>>> +                     .len = 1,
>>> +             },
>>> +             {
>>> +                     .rx_buf = dev->tb.rx_buf,
>>> +                     .bits_per_word = 8,
>>> +                     .len = len,
>>> +             }
>>> +     };
>>> +
>>> +     if (len > 1)
>>> +             addr |= SPI_AUTO_INCREMENT;
>>> +     dev->tb.tx_buf[0] = addr | SENSORS_SPI_READ;
>>> +
>>> +     err = spi_sync_transfer(spi, xfers,  ARRAY_SIZE(xfers));
>>> +     if (err < 0)
>>> +             return err;
>>> +
>>> +     memcpy(data, dev->tb.rx_buf, len * sizeof(u8));
>>> +
>>> +     return len;
>>> +}
>>> +
>>> +static int hts221_spi_write(struct device *device, u8 addr, int len, u8 *data)
>>> +{
>>> +     struct spi_device *spi = to_spi_device(device);
>>> +     struct iio_dev *iio_dev = spi_get_drvdata(spi);
>>> +     struct hts221_dev *dev = iio_priv(iio_dev);
>>> +
>>> +     struct spi_transfer xfers = {
>>> +             .tx_buf = dev->tb.tx_buf,
>>> +             .bits_per_word = 8,
>>> +             .len = len + 1,
>>> +     };
>>> +
>>> +     if (len >= HTS221_TX_MAX_LENGTH)
>>> +             return -ENOMEM;
>>> +
>>> +     if (len > 1)
>>> +             addr |= SPI_AUTO_INCREMENT;
>>> +     dev->tb.tx_buf[0] = addr;
>>> +     memcpy(&dev->tb.tx_buf[1], data, len);
>>> +
>>> +     return spi_sync_transfer(spi, &xfers, 1);
>>> +}
>>> +
>>> +static const struct hts221_transfer_function hts221_transfer_fn = {
>>> +     .read = hts221_spi_read,
>>> +     .write = hts221_spi_write,
>>> +};
>>> +
>>> +static int hts221_spi_probe(struct spi_device *spi)
>>> +{
>>> +     struct hts221_dev *dev;
>> I'd be tempted to rename this to something more specific (maybe
>> hts211_dev *hts221_instance or similar? You will probably come up with
>> something better than that!) as 'dev' is used extensively in
>> drivers for the struct device *dev pointer and this may prove
>> confusing when we come back to this driver in the future.
>>
>> Same throughout the driver obviously!
>>
>>> +     struct iio_dev *iio_dev;
>>> +
>>> +     iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*dev));
>>> +     if (!iio_dev)
>>> +             return -ENOMEM;
>>> +
>>> +     spi_set_drvdata(spi, iio_dev);
>>> +
>>> +     dev = iio_priv(iio_dev);
>>> +     dev->name = spi->modalias;
>>> +     dev->dev = &spi->dev;
>>> +     dev->irq = spi->irq;
>>> +     dev->tf = &hts221_transfer_fn;
>>> +
>>> +     return hts221_probe(dev);
>>> +}
>>> +
>>> +static const struct of_device_id hts221_spi_of_match[] = {
>>> +     { .compatible = "st,hts221", },
>>> +     {},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, hts221_spi_of_match);
>>> +
>>> +static const struct spi_device_id hts221_spi_id_table[] = {
>>> +     { HTS221_DEV_NAME },
>>> +     {},
>>> +};
>>> +MODULE_DEVICE_TABLE(spi, hts221_spi_id_table);
>>> +
>>> +static struct spi_driver hts221_driver = {
>>> +     .driver = {
>>> +             .name = "hts221_spi",
>>> +             .of_match_table = of_match_ptr(hts221_spi_of_match),
>>> +     },
>>> +     .probe = hts221_spi_probe,
>>> +     .id_table = hts221_spi_id_table,
>>> +};
>>> +module_spi_driver(hts221_driver);
>>> +
>>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>>> +MODULE_DESCRIPTION("STMicroelectronics hts221 spi driver");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
> 
> Regards,
> Lorenzo
> 
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

