Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39618 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932162AbcJIJqP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2016 05:46:15 -0400
Subject: Re: [PATCH 1/2] iio: humidity: add support to hts221 rh/temp combo
 device
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <1474919741-21316-1-git-send-email-lorenzo.bianconi@st.com>
 <1474919741-21316-2-git-send-email-lorenzo.bianconi@st.com>
 <0f6e72e2-fbb6-0c46-98d3-5fe5e6a39103@kernel.org>
 <20161001171503.GA22409@lorenzobianconi.net>
 <1fd8c57f-76be-909b-b332-996de74dd788@kernel.org>
 <CAA2SeNKDzm3sNOFUEbQMXGH03yfuYsQy4zbHN-0VbtPT7tTG=w@mail.gmail.com>
Cc: linux-iio@vger.kernel.org,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <aa819d1c-0c5c-8ee7-443b-67906dcc00dd@kernel.org>
Date: Sun, 9 Oct 2016 10:46:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAA2SeNKDzm3sNOFUEbQMXGH03yfuYsQy4zbHN-0VbtPT7tTG=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/10/16 10:37, Lorenzo Bianconi wrote:
>> On 01/10/16 18:15, Lorenzo Bianconi wrote:
>>> On Oct 01, Jonathan Cameron wrote:
>>>> On 26/09/16 20:55, Lorenzo Bianconi wrote:
>>>>> Add support to STM HTS221 humidity + temperature sensor
>>>>>
>>>>> http://www.st.com/resource/en/datasheet/hts221.pdf
>>>>>
>>>>> - continuos mode support
>>>>> - i2c support
>>>>> - spi support
>>>>> - trigger mode support
>>>>>
>>>>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>
>>> Hi Jonathan,
>>>
>>> thanks for the review :)
>>>
>>>> This is an odd device for something so seemingly simple.  It would have
>>>> been helpful to have a little bit of text explaining that here.
>>>>
>>>> Key point is that the two sensors both operate with data ready interrupts,
>>>> but not necessarily at the same frequency.  Hence the multiple IIO devices.
>>>> Why it makes sense to bother doing this in a device that runs at a 'maximum'
>>>> of 12.5Hz is beyond me but that's what the hardware does ;(
>>>>
>>>> Hmm. Good old hardware designers make something lovely and flexible.
>>>> Actual result, a bit of hardware that doesn't generate data in a form that
>>>> anyone actually wants to use.  Normally you explicitly want temperature and
>>>> humidity to be paired.
>>>>
>>>> One really stupid question that I can't figure out from the datasheet.
>>>> Do the average values effect the output rate?  (or are they a moving window).
>>>>
>>>> I think I'd have been cynical on this device and just not supported triggered
>>>> / buffered reading at all.  Used it in oneshot mode. It's slow, so not as
>>>> though we need to do buffered data flows.  Still if you want to do it the
>>>> hard way then fair enough!
>>>
>>> Running a couple of tests I verified the ODR is shared between humidity and
>>> temperature sensor, so I think we can use just one iio_dev structure for both
>>> sensors and define a temperature channel and humidity one.  This will simplify
>>> the triggered mode support. What do you think? Do you prefer to just support
>>> oneshot mode or modify the trigger/buffer support?
>> For this one a combined device would be nice.
>>
>> If it's straight forward then then modified trigger/buffer support option would be
>> the ideal. If not, I'd be happy enough with oneshot mode only at these rates.
>>
>> Up to you ;)
>>
>> Guessing you are several versions later you've already gone one way or the
>> other though.
>>
>> Sorry I didn't get to this during the week.
>>
> 
> No worries :)
> I sent out a v3 yesterday morning with trigger/buffer support since it
> was quite straight forward.
Cool - that would be the series I've left to last today as the one
that might take the most thinking about ;)

Lots of nice trivial stuff to allow me to wake up slowly before it.

Jonathan
> 
> Regards,
> Lorenzo
> 
>> Jonathan
>>>
>>> Best regards,
>>> Lorenzo
>>>
>>>>
>>>> Jonathan
>>>>> ---
>>>>>  drivers/iio/humidity/Kconfig                |   2 +
>>>>>  drivers/iio/humidity/Makefile               |   1 +
>>>>>  drivers/iio/humidity/hts221/Kconfig         |  23 +
>>>>>  drivers/iio/humidity/hts221/Makefile        |   6 +
>>>>>  drivers/iio/humidity/hts221/hts221.h        | 106 ++++
>>>>>  drivers/iio/humidity/hts221/hts221_buffer.c | 227 ++++++++
>>>>>  drivers/iio/humidity/hts221/hts221_core.c   | 804 ++++++++++++++++++++++++++++
>>>>>  drivers/iio/humidity/hts221/hts221_i2c.c    | 135 +++++
>>>>>  drivers/iio/humidity/hts221/hts221_spi.c    | 148 +++++
>>>>>  9 files changed, 1452 insertions(+)
>>>>>  create mode 100644 drivers/iio/humidity/hts221/Kconfig
>>>>>  create mode 100644 drivers/iio/humidity/hts221/Makefile
>>>>>  create mode 100644 drivers/iio/humidity/hts221/hts221.h
>>>>>  create mode 100644 drivers/iio/humidity/hts221/hts221_buffer.c
>>>>>  create mode 100644 drivers/iio/humidity/hts221/hts221_core.c
>>>>>  create mode 100644 drivers/iio/humidity/hts221/hts221_i2c.c
>>>>>  create mode 100644 drivers/iio/humidity/hts221/hts221_spi.c
>>>>>
>>>>> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
>>>>> index b17e2e2..4ce75da 100644
>>>>> --- a/drivers/iio/humidity/Kconfig
>>>>> +++ b/drivers/iio/humidity/Kconfig
>>>>> @@ -69,4 +69,6 @@ config SI7020
>>>>>       To compile this driver as a module, choose M here: the module
>>>>>       will be called si7020.
>>>>>
>>>>> +source "drivers/iio/humidity/hts221/Kconfig"
>>>>> +
>>>>>  endmenu
>>>>> diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
>>>>> index 4a73442..bdd5cd0 100644
>>>>> --- a/drivers/iio/humidity/Makefile
>>>>> +++ b/drivers/iio/humidity/Makefile
>>>>> @@ -8,3 +8,4 @@ obj-$(CONFIG_HDC100X) += hdc100x.o
>>>>>  obj-$(CONFIG_HTU21) += htu21.o
>>>>>  obj-$(CONFIG_SI7005) += si7005.o
>>>>>  obj-$(CONFIG_SI7020) += si7020.o
>>>>> +obj-$(CONFIG_IIO_HTS221) += hts221/
>>>>> diff --git a/drivers/iio/humidity/hts221/Kconfig b/drivers/iio/humidity/hts221/Kconfig
>>>>> new file mode 100644
>>>>> index 0000000..95b40e0
>>>>> --- /dev/null
>>>>> +++ b/drivers/iio/humidity/hts221/Kconfig
>>>>> @@ -0,0 +1,23 @@
>>>>> +
>>>>> +config IIO_HTS221
>>>>> +   tristate "STMicroelectronics HTS221 sensor Driver"
>>>>> +   depends on (I2C || SPI) && SYSFS
>>>>> +   select IIO_BUFFER
>>>>> +   select IIO_TRIGGERED_BUFFER
>>>>> +   select IIO_HTS221_I2C if (I2C)
>>>>> +   select IIO_HTS221_SPI if (SPI_MASTER)
>>>>> +   help
>>>>> +     Say yes here to build support for STMicroelectronics HTS221
>>>>> +     temperature-humidity sensor
>>>>> +
>>>>> +     To compile this driver as a module, choose M here: the module
>>>>> +     will be called hts221.
>>>>> +
>>>>> +config IIO_HTS221_I2C
>>>>> +   tristate
>>>>> +   depends on IIO_HTS221
>>>>> +
>>>>> +config IIO_HTS221_SPI
>>>>> +   tristate
>>>>> +   depends on IIO_HTS221
>>>>> +
>>>>> diff --git a/drivers/iio/humidity/hts221/Makefile b/drivers/iio/humidity/hts221/Makefile
>>>>> new file mode 100644
>>>>> index 0000000..6fdfc6a
>>>>> --- /dev/null
>>>>> +++ b/drivers/iio/humidity/hts221/Makefile
>>>>> @@ -0,0 +1,6 @@
>>>>> +hts221-y := hts221_core.o
>>>>> +hts221-$(CONFIG_IIO_BUFFER) += hts221_buffer.o
>>>>> +
>>>>> +obj-$(CONFIG_IIO_HTS221) += hts221.o
>>>>> +obj-$(CONFIG_IIO_HTS221_I2C) += hts221_i2c.o
>>>>> +obj-$(CONFIG_IIO_HTS221_SPI) += hts221_spi.o
>>>>> diff --git a/drivers/iio/humidity/hts221/hts221.h b/drivers/iio/humidity/hts221/hts221.h
>>>>> new file mode 100644
>>>>> index 0000000..23cf5b2
>>>>> --- /dev/null
>>>>> +++ b/drivers/iio/humidity/hts221/hts221.h
>>>>> @@ -0,0 +1,106 @@
>>>>> +/*
>>>>> + * STMicroelectronics hts221 sensor driver
>>>>> + *
>>>>> + * Copyright 2016 STMicroelectronics Inc.
>>>>> + *
>>>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>>> + *
>>>>> + * Licensed under the GPL-2.
>>>>> + */
>>>>> +
>>>>> +#ifndef HTS221_H
>>>>> +#define HTS221_H
>>>>> +
>>>>> +#define HTS221_DEV_NAME            "hts221"
>>>>> +
>>>>> +#include <linux/iio/iio.h>
>>>>> +
>>>>> +#if defined(CONFIG_IIO_HTS221_SPI) || \
>>>>> +   defined(CONFIG_IIO_HTS221_SPI_MODULE)
>>>>> +#define HTS221_RX_MAX_LENGTH       500
>>>>> +#define HTS221_TX_MAX_LENGTH       500
>>>>> +
>>>>> +struct hts221_transfer_buffer {
>>>>> +   u8 rx_buf[HTS221_RX_MAX_LENGTH];
>>>>> +   u8 tx_buf[HTS221_TX_MAX_LENGTH] ____cacheline_aligned;
>>>>> +};
>>>>> +#endif /* CONFIG_IIO_HTS221_SPI */
>>>>> +
>>>>> +struct hts221_transfer_function {
>>>>> +   int (*read)(struct device *dev, u8 addr, int len, u8 *data);
>>>>> +   int (*write)(struct device *dev, u8 addr, int len, u8 *data);
>>>>> +};
>>>>> +
>>>>> +#define HTS221_AVG_DEPTH   8
>>>>> +struct hts221_avg_avl {
>>>>> +   u16 avg;
>>>>> +   u8 val;
>>>>> +};
>>>>> +
>>>>> +enum hts221_sensor_type {
>>>>> +   HTS221_SENSOR_H,
>>>>> +   HTS221_SENSOR_T,
>>>>> +   HTS221_SENSOR_MAX,
>>>>> +};
>>>>> +
>>>>> +struct hts221_sensor {
>>>>> +   struct hts221_dev *dev;
>>>>> +   struct iio_trigger *trig;
>>>>> +
>>>>> +   enum hts221_sensor_type type;
>>>>> +   bool enabled;
>>>>> +   u8 odr, cur_avg_idx;
>>>>> +   int slope, b_gen;
>>>>> +
>>>>> +   u8 drdy_data_mask;
>>>>> +   u8 buffer[2];
>>>>> +};
>>>>> +
>>>>> +struct hts221_dev {
>>>>> +   const char *name;
>>>>> +   struct device *dev;
>>>>> +   int irq;
>>>>> +   struct mutex lock;
>>>>> +
>>>>> +   struct iio_dev *iio_devs[HTS221_SENSOR_MAX];
>>>>> +
>>>>> +   s64 hw_timestamp;
>>>>> +
>>>>> +   const struct hts221_transfer_function *tf;
>>>>> +#if defined(CONFIG_IIO_HTS221_SPI) || \
>>>>> +   defined(CONFIG_IIO_HTS221_SPI_MODULE)
>>>>> +   struct hts221_transfer_buffer tb;
>>>>> +#endif /* CONFIG_IIO_HTS221_SPI */
>>>> I'd be cynical. It's tiny, leave this there even in the i2c case...
>>>>> +};
>>>>> +
>>>>> +int hts221_config_drdy(struct hts221_sensor *sensor, bool enable);
>>>>> +int hts221_probe(struct hts221_dev *dev);
>>>>> +int hts221_remove(struct hts221_dev *dev);
>>>>> +int hts221_sensor_power_on(struct hts221_sensor *sensor);
>>>>> +int hts221_sensor_power_off(struct hts221_sensor *sensor);
>>>>> +#ifdef CONFIG_IIO_BUFFER
>>>>> +int hts221_allocate_buffers(struct hts221_dev *dev);
>>>>> +void hts221_deallocate_buffers(struct hts221_dev *dev);
>>>>> +int hts221_allocate_triggers(struct hts221_dev *dev);
>>>>> +void hts221_deallocate_triggers(struct hts221_dev *dev);
>>>>> +#else
>>>>> +static inline int hts221_allocate_buffers(struct hts221_dev *dev)
>>>>> +{
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>> +static inline void hts221_deallocate_buffers(struct hts221_dev *dev)
>>>>> +{
>>>>> +}
>>>>> +
>>>>> +static inline int hts221_allocate_triggers(struct hts221_dev *dev)
>>>>> +{
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>> +static inline void hts221_deallocate_triggers(struct hts221_dev *dev)
>>>>> +{
>>>>> +}
>>>>> +#endif /* CONFIG_IIO_BUFFER */
>>>>> +
>>>>> +#endif /* HTS221_H */
>>>>> diff --git a/drivers/iio/humidity/hts221/hts221_buffer.c b/drivers/iio/humidity/hts221/hts221_buffer.c
>>>>> new file mode 100644
>>>>> index 0000000..31ac29c
>>>>> --- /dev/null
>>>>> +++ b/drivers/iio/humidity/hts221/hts221_buffer.c
>>>>> @@ -0,0 +1,227 @@
>>>>> +/*
>>>>> + * STMicroelectronics hts221 sensor driver
>>>>> + *
>>>>> + * Copyright 2016 STMicroelectronics Inc.
>>>>> + *
>>>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>>> + *
>>>>> + * Licensed under the GPL-2.
>>>>> + */
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/device.h>
>>>>> +#include <linux/interrupt.h>
>>>>> +#include <linux/irqreturn.h>
>>>>> +
>>>>> +#include <linux/iio/iio.h>
>>>>> +#include <linux/iio/trigger.h>
>>>>> +#include <linux/interrupt.h>
>>>>> +#include <linux/iio/events.h>
>>>>> +#include <linux/iio/trigger_consumer.h>
>>>>> +#include <linux/iio/triggered_buffer.h>
>>>>> +#include <linux/iio/buffer.h>
>>>>> +
>>>>> +#include "hts221.h"
>>>>> +
>>>>> +#define REG_STATUS_ADDR            0x27
>>>>> +
>>>>> +int hts221_trig_set_state(struct iio_trigger *trig, bool state)
>>>>> +{
>>>>> +   struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>>>>> +   struct hts221_sensor *sensor = iio_priv(indio_dev);
>>>>> +
>>>>> +   return hts221_config_drdy(sensor, state);
>>>>> +}
>>>>> +
>>>>> +static const struct iio_trigger_ops hts221_trigger_ops = {
>>>>> +   .owner = THIS_MODULE,
>>>>> +   .set_trigger_state = hts221_trig_set_state,
>>>>> +};
>>>>> +
>>>>> +static irqreturn_t hts221_trigger_handler_th(int irq, void *private)
>>>>> +{
>>>>> +   struct hts221_dev *dev = (struct hts221_dev *)private;
>>>>> +
>>>>> +   dev->hw_timestamp = iio_get_time_ns(dev->iio_devs[0]);
>>>> Hmm. Might be on the wrong clock base for the particular device.
>>>> You'll probably have to grab one for each of the IIO devices then
>>>> use the right one later.
>>>>> +
>>>>> +   return IRQ_WAKE_THREAD;
>>>>> +}
>>>>> +
>>>>> +static irqreturn_t hts221_trigger_handler_bh(int irq, void *private)
>>>>> +{
>>>>> +   u8 status;
>>>>> +   int i, err;
>>>>> +   struct hts221_sensor *sensor;
>>>>> +   struct iio_chan_spec const *ch;
>>>>> +   struct hts221_dev *dev = (struct hts221_dev *)private;
>>>>> +
>>>>> +   err = dev->tf->read(dev->dev, REG_STATUS_ADDR, 1, &status);
>>>>> +   if (err < 0)
>>>>> +           return IRQ_HANDLED;
>>>>> +
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>>>>> +           sensor = iio_priv(dev->iio_devs[i]);
>>>>> +
>>>>> +           if (status & sensor->drdy_data_mask) {
>>>>> +                   ch = dev->iio_devs[i]->channels;
>>>>> +                   err = dev->tf->read(dev->dev, ch[0].address, 2,
>>>>> +                                       sensor->buffer);
>>>>> +                   if (err < 0)
>>>>> +                           continue;
>>>>> +
>>>>> +                   iio_trigger_poll_chained(sensor->trig);
>>>>> +           }
>>>>> +   }
>>>>> +
>>>>> +   return IRQ_HANDLED;
>>>> Shouldn't return IRQ handled if it wasn't us... i.e. no bits are set.
>>>> Someone may want to support shared irqs in the future.
>>>>> +}
>>>>> +
>>>>> +int hts221_allocate_triggers(struct hts221_dev *dev)
>>>>> +{
>>>>> +   int i, err, count = 0;
>>>>> +   unsigned long irq_type;
>>>>> +   struct hts221_sensor *sensor;
>>>>> +
>>>>> +   irq_type = irqd_get_trigger_type(irq_get_irq_data(dev->irq));
>>>>> +
>>>>> +   switch (irq_type) {
>>>>> +   case IRQF_TRIGGER_HIGH:
>>>>> +   case IRQF_TRIGGER_RISING:
>>>>> +           break;
>>>>> +   default:
>>>>> +           dev_info(dev->dev,
>>>>> +                    "mode %lx unsupported, use IRQF_TRIGGER_RISING\n",
>>>> using (use would tell them to change it, not that the driver is going to
>>>> do it on it's own).
>>>>> +                    irq_type);
>>>>> +           irq_type = IRQF_TRIGGER_RISING;
>>>>> +           break;
>>>>> +   }
>>>>> +
>>>>> +   err = devm_request_threaded_irq(dev->dev, dev->irq,
>>>>> +                                   hts221_trigger_handler_th,
>>>>> +                                   hts221_trigger_handler_bh,
>>>>> +                                   irq_type | IRQF_ONESHOT,
>>>>> +                                   dev->name, dev);
>>>>> +   if (err) {
>>>>> +           dev_err(dev->dev, "failed to request trigger irq %d\n",
>>>>> +                   dev->irq);
>>>>> +           return err;
>>>>> +   }
>>>>> +
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>>>>> +           sensor = iio_priv(dev->iio_devs[i]);
>>>>> +           sensor->trig = iio_trigger_alloc("%s-trigger",
>>>>> +                                            dev->iio_devs[i]->name);
>>>>> +           if (!sensor->trig) {
>>>>> +                   err = -ENOMEM;
>>>>> +                   goto iio_trigger_error;
>>>>> +           }
>>>>> +
>>>>> +           iio_trigger_set_drvdata(sensor->trig, dev->iio_devs[i]);
>>>>> +           sensor->trig->ops = &hts221_trigger_ops;
>>>>> +           sensor->trig->dev.parent = dev->dev;
>>>>> +
>>>>> +           err = iio_trigger_register(sensor->trig);
>>>>> +           if (err < 0) {
>>>>> +                   dev_err(dev->dev, "failed to register iio trigger\n");
>>>>> +                   goto iio_trigger_error;
>>>>> +           }
>>>>> +           dev->iio_devs[i]->trig = iio_trigger_get(sensor->trig);
>>>>> +           count++;
>>>>> +   }
>>>>> +
>>>>> +   return 0;
>>>>> +
>>>>> +iio_trigger_error:
>>>>> +   for (i = count - 1; i >= 0; i--) {
>>>>> +           sensor = iio_priv(dev->iio_devs[i]);
>>>>> +           iio_trigger_unregister(sensor->trig);
>>>>> +   }
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>>>>> +           sensor = iio_priv(dev->iio_devs[i]);
>>>>> +           iio_trigger_free(sensor->trig);
>>>>> +   }
>>>>> +
>>>>> +   return err;
>>>>> +}
>>>>> +
>>>>> +void hts221_deallocate_triggers(struct hts221_dev *dev)
>>>>> +{
>>>>> +   int i;
>>>>> +   struct hts221_sensor *sensor;
>>>>> +
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>>>>> +           sensor = iio_priv(dev->iio_devs[i]);
>>>>> +           iio_trigger_unregister(sensor->trig);
>>>>> +           iio_trigger_free(sensor->trig);
>>>>> +   }
>>>>> +}
>>>>> +
>>>>> +static int hts221_buffer_preenable(struct iio_dev *indio_dev)
>>>>> +{
>>>>> +   return hts221_sensor_power_on(iio_priv(indio_dev));
>>>>> +}
>>>>> +
>>>>> +static int hts221_buffer_postdisable(struct iio_dev *indio_dev)
>>>>> +{
>>>>> +   return hts221_sensor_power_off(iio_priv(indio_dev));
>>>>> +}
>>>>> +
>>>>> +static const struct iio_buffer_setup_ops hts221_buffer_ops = {
>>>>> +   .preenable = hts221_buffer_preenable,
>>>>> +   .postenable = iio_triggered_buffer_postenable,
>>>>> +   .predisable = iio_triggered_buffer_predisable,
>>>>> +   .postdisable = hts221_buffer_postdisable,
>>>>> +};
>>>>> +
>>>>> +static irqreturn_t hts221_buffer_handler_bh(int irq, void *p)
>>>>> +{
>>>>> +   struct iio_poll_func *pf = p;
>>>>> +   struct iio_dev *iio_dev = pf->indio_dev;
>>>>> +   struct hts221_sensor *sensor = iio_priv(iio_dev);
>>>>> +   u8 out_data[iio_dev->scan_bytes];
>>>>> +
>>>>> +   if (iio_dev->active_scan_mask &&
>>>>> +       test_bit(0, iio_dev->active_scan_mask))
>>>>> +           memcpy(out_data, sensor->buffer, 2);
>>>>> +
>>>>> +   iio_push_to_buffers_with_timestamp(iio_dev, out_data,
>>>>> +                                      sensor->dev->hw_timestamp);
>>>>> +
>>>>> +   iio_trigger_notify_done(sensor->trig);
>>>>> +
>>>>> +   return IRQ_HANDLED;
>>>>> +}
>>>>> +
>>>>> +int hts221_allocate_buffers(struct hts221_dev *dev)
>>>>> +{
>>>>> +   int i, err, count = 0;
>>>>> +
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>>>>> +           err = iio_triggered_buffer_setup(dev->iio_devs[i], NULL,
>>>>> +                                            hts221_buffer_handler_bh,
>>>>> +                                            &hts221_buffer_ops);
>>>>> +           if (err < 0)
>>>>> +                   goto iio_buffer_error;
>>>>> +           count++;
>>>>> +   }
>>>>> +
>>>>> +   return 0;
>>>>> +
>>>>> +iio_buffer_error:
>>>>> +   for (i = count - 1; i >= 0; i--)
>>>>> +           iio_triggered_buffer_cleanup(dev->iio_devs[i]);
>>>>> +
>>>>> +   return err;
>>>>> +}
>>>>> +
>>>>> +void hts221_deallocate_buffers(struct hts221_dev *dev)
>>>>> +{
>>>>> +   int i;
>>>>> +
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++)
>>>>> +           iio_triggered_buffer_cleanup(dev->iio_devs[i]);
>>>>> +}
>>>>> +
>>>>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>>>>> +MODULE_DESCRIPTION("STMicroelectronics hts221 buffer driver");
>>>>> +MODULE_LICENSE("GPL v2");
>>>>> diff --git a/drivers/iio/humidity/hts221/hts221_core.c b/drivers/iio/humidity/hts221/hts221_core.c
>>>>> new file mode 100644
>>>>> index 0000000..0beac47
>>>>> --- /dev/null
>>>>> +++ b/drivers/iio/humidity/hts221/hts221_core.c
>>>>> @@ -0,0 +1,804 @@
>>>>> +/*
>>>>> + * STMicroelectronics hts221 sensor driver
>>>>> + *
>>>>> + * Copyright 2016 STMicroelectronics Inc.
>>>>> + *
>>>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>>> + *
>>>>> + * Licensed under the GPL-2.
>>>>> + */
>>>>> +
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/device.h>
>>>>> +#include <linux/iio/sysfs.h>
>>>>> +#include <linux/delay.h>
>>>>> +#include <asm/unaligned.h>
>>>>> +
>>>>> +#include "hts221.h"
>>>>> +
>>>>> +#define REG_WHOAMI_ADDR            0x0f
>>>>> +#define REG_WHOAMI_VAL             0xbc
>>>>> +
>>>>> +#define REG_CNTRL1_ADDR            0x20
>>>>> +#define REG_CNTRL2_ADDR            0x21
>>>>> +#define REG_CNTRL3_ADDR            0x22
>>>>> +
>>>>> +#define REG_H_AVG_ADDR             0x10
>>>>> +#define REG_T_AVG_ADDR             0x10
>>>>> +#define REG_H_OUT_L                0x28
>>>>> +#define REG_T_OUT_L                0x2a
>>>>> +
>>>>> +#define H_AVG_MASK         0x07
>>>>> +#define T_AVG_MASK         0x38
>>>>> +
>>>>> +#define ODR_MASK           0x87
>>>>> +#define BDU_MASK           0x04
>>>>> +
>>>>> +#define DRDY_MASK          0x04
>>>>> +
>>>>> +#define ENABLE_SENSOR              0x80
>>>>> +
>>>> A more unique prefix for all defines will make future clashes far less likely.
>>>> so HTS221_H_AVG_4 etc
>>>>> +#define H_AVG_4                    0x00 /* 0.4 %RH */
>>>>> +#define H_AVG_8                    0x01 /* 0.3 %RH */
>>>>> +#define H_AVG_16           0x02 /* 0.2 %RH */
>>>>> +#define H_AVG_32           0x03 /* 0.15 %RH */
>>>>> +#define H_AVG_64           0x04 /* 0.1 %RH */
>>>>> +#define H_AVG_128          0x05 /* 0.07 %RH */
>>>>> +#define H_AVG_256          0x06 /* 0.05 %RH */
>>>>> +#define H_AVG_512          0x07 /* 0.03 %RH */
>>>>> +
>>>>> +#define T_AVG_2                    0x00 /* 0.08 degC */
>>>>> +#define T_AVG_4                    0x08 /* 0.05 degC */
>>>>> +#define T_AVG_8                    0x10 /* 0.04 degC */
>>>>> +#define T_AVG_16           0x18 /* 0.03 degC */
>>>>> +#define T_AVG_32           0x20 /* 0.02 degC */
>>>>> +#define T_AVG_64           0x28 /* 0.015 degC */
>>>>> +#define T_AVG_128          0x30 /* 0.01 degC */
>>>>> +#define T_AVG_256          0x38 /* 0.007 degC */
>>>>> +
>>>>> +/* caldata registers */
>>>>> +#define REG_0RH_CAL_X_H            0x36
>>>>> +#define REG_1RH_CAL_X_H            0x3a
>>>>> +#define REG_0RH_CAL_Y_H            0x30
>>>>> +#define REG_1RH_CAL_Y_H            0x31
>>>>> +#define REG_0T_CAL_X_L             0x3c
>>>>> +#define REG_1T_CAL_X_L             0x3e
>>>>> +#define REG_0T_CAL_Y_H             0x32
>>>>> +#define REG_1T_CAL_Y_H             0x33
>>>>> +#define REG_T1_T0_CAL_Y_H  0x35
>>>>> +
>>>>> +struct hts221_odr {
>>>>> +   u32 hz;
>>>>> +   u8 val;
>>>>> +};
>>>>> +
>>>>> +struct hts221_avg {
>>>>> +   u8 addr;
>>>>> +   u8 mask;
>>>>> +   struct hts221_avg_avl avg_avl[HTS221_AVG_DEPTH];
>>>>> +};
>>>>> +
>>>>> +static const struct hts221_odr hts221_odr_table[] = {
>>>>> +   { 1, 0x01 },    /* 1Hz */
>>>>> +   { 7, 0x02 },    /* 7Hz */
>>>>> +   { 13, 0x03 },   /* 12.5 HZ */
>>>>> +};
>>>>> +
>>>>> +static const struct hts221_avg hts221_avg_list[] = {
>>>>> +   {
>>>>> +           .addr = REG_H_AVG_ADDR,
>>>>> +           .mask = H_AVG_MASK,
>>>>> +           .avg_avl = {
>>>>> +                   { 4, H_AVG_4 },
>>>>> +                   { 8, H_AVG_8 },
>>>>> +                   { 16, H_AVG_16 },
>>>>> +                   { 32, H_AVG_32 },
>>>>> +                   { 64, H_AVG_64 },
>>>>> +                   { 128, H_AVG_128 },
>>>>> +                   { 256, H_AVG_256 },
>>>>> +                   { 512, H_AVG_512 },
>>>>> +           },
>>>>> +   },
>>>>> +   {
>>>>> +           .addr = REG_T_AVG_ADDR,
>>>>> +           .mask = T_AVG_MASK,
>>>>> +           .avg_avl = {
>>>>> +                   { 2, T_AVG_2 },
>>>>> +                   { 4, T_AVG_4 },
>>>>> +                   { 8, T_AVG_8 },
>>>>> +                   { 16, T_AVG_16 },
>>>>> +                   { 32, T_AVG_32 },
>>>>> +                   { 64, T_AVG_64 },
>>>>> +                   { 128, T_AVG_128 },
>>>>> +                   { 256, T_AVG_256 },
>>>>> +           },
>>>>> +   },
>>>>> +};
>>>>> +
>>>>> +static const struct iio_chan_spec hts221_h_channels[] = {
>>>>> +   {
>>>>> +           .type = IIO_HUMIDITYRELATIVE,
>>>>> +           .address = REG_H_OUT_L,
>>>>> +           .modified = 0,
>>>>> +           .channel2 = IIO_NO_MOD,
>>>>> +           .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>>> +                                 BIT(IIO_CHAN_INFO_OFFSET) |
>>>>> +                                 BIT(IIO_CHAN_INFO_SCALE),
>>>>> +           .scan_index = 0,
>>>>> +           .scan_type = {
>>>>> +                   .sign = 's',
>>>>> +                   .realbits = 16,
>>>>> +                   .storagebits = 16,
>>>>> +                   .endianness = IIO_LE,
>>>>> +           },
>>>>> +   },
>>>>> +   IIO_CHAN_SOFT_TIMESTAMP(1),
>>>>> +};
>>>>> +
>>>>> +static const struct iio_chan_spec hts221_t_channels[] = {
>>>>> +   {
>>>>> +           .type = IIO_TEMP,
>>>>> +           .address = REG_T_OUT_L,
>>>> No need to specify modified or channel2 as they will be allocated to 0 anyway
>>>> and there is no semantic meaning in setting them again (unlike scan_index where
>>>> there is)
>>>>> +           .modified = 0,
>>>>> +           .channel2 = IIO_NO_MOD,
>>>>> +           .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>>> +                                 BIT(IIO_CHAN_INFO_OFFSET) |
>>>>> +                                 BIT(IIO_CHAN_INFO_SCALE),
>>>>> +           .scan_index = 0,
>>>>> +           .scan_type = {
>>>>> +                   .sign = 's',
>>>>> +                   .realbits = 16,
>>>>> +                   .storagebits = 16,
>>>>> +                   .endianness = IIO_LE,
>>>>> +           },
>>>>> +   },
>>>>> +   IIO_CHAN_SOFT_TIMESTAMP(1),
>>>>> +};
>>>>> +
>>>>> +static int hts221_write_with_mask(struct hts221_dev *dev, u8 addr, u8 mask,
>>>>> +                             u8 val)
>>>>> +{
>>>>> +   u8 data;
>>>>> +   int err;
>>>>> +
>>>>> +   mutex_lock(&dev->lock);
>>>>> +
>>>>> +   err = dev->tf->read(dev->dev, addr, 1, &data);
>>>>> +   if (err < 0) {
>>>>> +           dev_err(dev->dev, "failed to read %02x register\n", addr);
>>>>> +           mutex_unlock(&dev->lock);
>>>>> +
>>>>> +           return err;
>>>>> +   }
>>>>> +
>>>>> +   data = (data & ~mask) | (val & mask);
>>>>> +
>>>>> +   err = dev->tf->write(dev->dev, addr, 1, &data);
>>>>> +   if (err < 0) {
>>>>> +           dev_err(dev->dev, "failed to write %02x register\n", addr);
>>>>> +           mutex_unlock(&dev->lock);
>>>>> +
>>>>> +           return err;
>>>>> +   }
>>>>> +
>>>>> +   mutex_unlock(&dev->lock);
>>>>> +
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>> +static int hts221_check_whoami(struct hts221_dev *dev)
>>>>> +{
>>>>> +   u8 data;
>>>>> +   int err;
>>>>> +
>>>>> +   err = dev->tf->read(dev->dev, REG_WHOAMI_ADDR, 1, &data);
>>>>> +   if (err < 0) {
>>>>> +           dev_err(dev->dev, "failed to read whoami register\n");
>>>>> +           return err;
>>>>> +   }
>>>>> +
>>>>> +   if (data != REG_WHOAMI_VAL) {
>>>>> +           dev_err(dev->dev, "wrong whoami {%02x-%02x}\n",
>>>>> +                   data, REG_WHOAMI_VAL);
>>>>> +           return -ENODEV;
>>>>> +   }
>>>>> +
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>> +int hts221_config_drdy(struct hts221_sensor *sensor, bool enable)
>>>>> +{
>>>>> +   int i;
>>>>> +   struct hts221_sensor *cur_sensor;
>>>>> +   struct hts221_dev *dev = sensor->dev;
>>>>> +
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>>>>> +           cur_sensor = iio_priv(dev->iio_devs[i]);
>>>>> +
>>>>> +           if (cur_sensor == sensor)
>>>>> +                   continue;
>>>>> +
>>>>> +           if (!cur_sensor->enabled)
>>>>> +                   break;
>>>>> +   }
>>>>> +
>>>>> +   if (i < HTS221_SENSOR_MAX) {
>>>>> +           u8 val = (enable) ? 0x04 : 0;
>>>>> +
>>>>> +           return hts221_write_with_mask(dev, REG_CNTRL3_ADDR,
>>>>> +                                         DRDY_MASK, val);
>>>>> +   } else {
>>>>> +           return 0;
>>>>> +   }
>>>>> +}
>>>>> +
>>>>> +static int hts221_update_odr(struct hts221_dev *dev, u8 odr)
>>>>> +{
>>>>> +   int i;
>>>>> +
>>>>> +   for (i = 0; i < ARRAY_SIZE(hts221_odr_table); i++)
>>>>> +           if (hts221_odr_table[i].hz == odr)
>>>>> +                   break;
>>>>> +
>>>>> +   if (i == ARRAY_SIZE(hts221_odr_table))
>>>>> +           return -EINVAL;
>>>>> +
>>>>> +   return hts221_write_with_mask(dev, REG_CNTRL1_ADDR, ODR_MASK,
>>>>> +                                 ENABLE_SENSOR | BDU_MASK |
>>>>> +                                 hts221_odr_table[i].val);
>>>>> +}
>>>>> +
>>>>> +static int hts221_sensor_update_odr(struct hts221_sensor *sensor, u8 odr)
>>>>> +{
>>>>> +   int i;
>>>>> +   struct hts221_sensor *cur_sensor;
>>>>> +
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>>>>> +           cur_sensor = iio_priv(sensor->dev->iio_devs[i]);
>>>>> +
>>>>> +           if (cur_sensor == sensor)
>>>>> +                   continue;
>>>>> +
>>>>> +           if (cur_sensor->enabled && cur_sensor->odr >= odr)
>>>>> +                   return 0;
>>>>> +   }
>>>>> +
>>>>> +   return hts221_update_odr(sensor->dev, odr);
>>>>> +}
>>>>> +
>>>>> +static int hts221_update_avg(struct hts221_sensor *sensor, u16 val)
>>>>> +{
>>>>> +   int i, err;
>>>>> +   const struct hts221_avg *avg = &hts221_avg_list[sensor->type];
>>>>> +
>>>>> +   for (i = 0; i < HTS221_AVG_DEPTH; i++)
>>>>> +           if (avg->avg_avl[i].avg == val)
>>>>> +                   break;
>>>>> +
>>>>> +   if (i == HTS221_AVG_DEPTH)
>>>>> +           return -EINVAL;
>>>>> +
>>>>> +   err = hts221_write_with_mask(sensor->dev, avg->addr, avg->mask,
>>>>> +                                avg->avg_avl[i].val);
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +
>>>>> +   sensor->cur_avg_idx = i;
>>>>> +
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>> +static ssize_t
>>>>> +hts221_sysfs_get_h_avg_val(struct device *device,
>>>>> +                      struct device_attribute *attr, char *buf)
>>>>> +{
>>>>> +   int idx, val;
>>>>> +   struct iio_dev *indio_dev = dev_get_drvdata(device);
>>>>> +   struct hts221_sensor *sensor = iio_priv(indio_dev);
>>>>> +
>>>>> +   idx = sensor->cur_avg_idx;
>>>>> +   val = hts221_avg_list[HTS221_SENSOR_H].avg_avl[idx].avg;
>>>>> +
>>>>> +   return sprintf(buf, "%d\n", val);
>>>>> +}
>>>>> +
>>>>> +static ssize_t
>>>>> +hts221_sysfs_set_h_avg_val(struct device *device,
>>>>> +                      struct device_attribute *attr,
>>>>> +                      const char *buf, size_t size)
>>>>> +{
>>>>> +   int err;
>>>>> +   unsigned int val;
>>>>> +   struct iio_dev *indio_dev = dev_get_drvdata(device);
>>>>> +   struct hts221_sensor *sensor = iio_priv(indio_dev);
>>>>> +
>>>>> +   err = kstrtoint(buf, 10, &val);
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +
>>>>> +   err = hts221_update_avg(sensor, (u16)val);
>>>>> +
>>>>> +   return err < 0 ? err : size;
>>>>> +}
>>>>> +
>>>>> +static ssize_t
>>>>> +hts221_sysfs_get_t_avg_val(struct device *device,
>>>>> +                      struct device_attribute *attr, char *buf)
>>>>> +{
>>>>> +   int idx, val;
>>>>> +   struct iio_dev *indio_dev = dev_get_drvdata(device);
>>>>> +   struct hts221_sensor *sensor = iio_priv(indio_dev);
>>>>> +
>>>>> +   idx = sensor->cur_avg_idx;
>>>>> +   val = hts221_avg_list[HTS221_SENSOR_T].avg_avl[idx].avg;
>>>>> +
>>>>> +   return sprintf(buf, "%d\n", val);
>>>>> +}
>>>>> +
>>>>> +static ssize_t
>>>>> +hts221_sysfs_set_t_avg_val(struct device *device,
>>>>> +                      struct device_attribute *attr,
>>>>> +                      const char *buf, size_t size)
>>>>> +{
>>>>> +   int err;
>>>>> +   unsigned int val;
>>>>> +   struct iio_dev *indio_dev = dev_get_drvdata(device);
>>>>> +   struct hts221_sensor *sensor = iio_priv(indio_dev);
>>>>> +
>>>>> +   err = kstrtoint(buf, 10, &val);
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +
>>>>> +   err = hts221_update_avg(sensor, (u16)val);
>>>>> +
>>>>> +   return err < 0 ? err : size;
>>>>> +}
>>>>> +
>>>>> +static ssize_t hts221_sysfs_sampling_freq(struct device *dev,
>>>>> +                                     struct device_attribute *attr,
>>>>> +                                     char *buf)
>>>>> +{
>>>>> +   int i;
>>>>> +   ssize_t len = 0;
>>>>> +
>>>>> +   for (i = 0; i < ARRAY_SIZE(hts221_odr_table); i++)
>>>>> +           len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
>>>>> +                            hts221_odr_table[i].hz);
>>>>> +   buf[len - 1] = '\n';
>>>>> +
>>>>> +   return len;
>>>>> +}
>>>>> +
>>>>> +static ssize_t
>>>>> +hts221_sysfs_get_sampling_frequency(struct device *device,
>>>>> +                               struct device_attribute *attr, char *buf)
>>>>> +{
>>>>> +   struct iio_dev *indio_dev = dev_get_drvdata(device);
>>>>> +   struct hts221_sensor *sensor = iio_priv(indio_dev);
>>>>> +
>>>>> +   return sprintf(buf, "%d\n", sensor->odr);
>>>>> +}
>>>>> +
>>>>> +static ssize_t
>>>>> +hts221_sysfs_set_sampling_frequency(struct device *device,
>>>>> +                               struct device_attribute *attr,
>>>>> +                               const char *buf, size_t size)
>>>>> +{
>>>>> +   int err;
>>>>> +   unsigned int odr;
>>>>> +   struct iio_dev *indio_dev = dev_get_drvdata(device);
>>>>> +   struct hts221_sensor *sensor = iio_priv(indio_dev);
>>>>> +
>>>>> +   err = kstrtoint(buf, 10, &odr);
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +
>>>>> +   err = hts221_sensor_update_odr(sensor, odr);
>>>>> +   if (!err)
>>>>> +           sensor->odr = odr;
>>>>> +
>>>>> +   return err < 0 ? err : size;
>>>>> +}
>>>>> +
>>>>> +int hts221_sensor_power_on(struct hts221_sensor *sensor)
>>>>> +{
>>>>> +   int err, idx, val;
>>>>> +
>>>>> +   idx = sensor->cur_avg_idx;
>>>>> +   val = hts221_avg_list[sensor->type].avg_avl[idx].avg;
>>>>> +   err = hts221_update_avg(sensor, val);
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +
>>>>> +   err = hts221_sensor_update_odr(sensor, sensor->odr);
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +
>>>>> +   sensor->enabled = true;
>>>>> +
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>> +static int hts221_dev_power_off(struct hts221_dev *dev)
>>>>> +{
>>>>> +   u8 data[] = {0x00, 0x00};
>>>>> +
>>>>> +   return dev->tf->write(dev->dev, REG_CNTRL1_ADDR, 2, data);
>>>>> +}
>>>>> +
>>>>> +int hts221_sensor_power_off(struct hts221_sensor *sensor)
>>>>> +{
>>>>> +   int i;
>>>>> +   struct hts221_sensor *cur_sensor;
>>>>> +   struct hts221_dev *dev = sensor->dev;
>>>>> +
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>>>>> +           cur_sensor = iio_priv(dev->iio_devs[i]);
>>>>> +           if (cur_sensor == sensor)
>>>>> +                   continue;
>>>>> +
>>>>> +           if (cur_sensor->enabled)
>>>>> +                   break;
>>>>> +   }
>>>>> +
>>>>> +   if (i == HTS221_SENSOR_MAX)
>>>>> +           hts221_dev_power_off(dev);
>>>>> +
>>>>> +   sensor->enabled = false;
>>>>> +
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>> +static int hts221_parse_caldata(struct hts221_sensor *sensor)
>>>>> +{
>>>>> +   int err, *slope, *b_gen;
>>>>> +   u8 addr_x0, addr_x1;
>>>>> +   s16 cal_x0, cal_x1, cal_y0, cal_y1;
>>>>> +   struct hts221_dev *dev = sensor->dev;
>>>>> +
>>>>> +   switch (sensor->type) {
>>>>> +   case HTS221_SENSOR_H:
>>>>> +           addr_x0 = REG_0RH_CAL_X_H;
>>>>> +           addr_x1 = REG_1RH_CAL_X_H;
>>>>> +
>>>>> +           cal_y1 = 0;
>>>>> +           cal_y0 = 0;
>>>>> +           err = dev->tf->read(dev->dev, REG_0RH_CAL_Y_H, 1,
>>>>> +                               (u8 *)&cal_y0);
>>>>> +           if (err < 0)
>>>>> +                   return err;
>>>>> +
>>>>> +           err = dev->tf->read(dev->dev, REG_1RH_CAL_Y_H, 1,
>>>>> +                               (u8 *)&cal_y1);
>>>>> +           if (err < 0)
>>>>> +                   return err;
>>>>> +           break;
>>>>> +   case HTS221_SENSOR_T: {
>>>>> +           u8 cal0, cal1;
>>>>> +
>>>>> +           addr_x0 = REG_0T_CAL_X_L;
>>>>> +           addr_x1 = REG_1T_CAL_X_L;
>>>>> +
>>>>> +           err = dev->tf->read(dev->dev, REG_0T_CAL_Y_H, 1, &cal0);
>>>>> +           if (err < 0)
>>>>> +                   return err;
>>>>> +
>>>>> +           err = dev->tf->read(dev->dev, REG_T1_T0_CAL_Y_H, 1, &cal1);
>>>>> +           if (err < 0)
>>>>> +                   return err;
>>>>> +           cal_y0 = (le16_to_cpu(cal1 & 0x3) << 8) | cal0;
>>>>> +
>>>>> +           err = dev->tf->read(dev->dev, REG_1T_CAL_Y_H, 1, &cal0);
>>>>> +           if (err < 0)
>>>>> +                   return err;
>>>>> +
>>>>> +           err = dev->tf->read(dev->dev, REG_T1_T0_CAL_Y_H, 1, &cal1);
>>>>> +           if (err < 0)
>>>>> +                   return err;
>>>>> +           cal_y1 = (le16_to_cpu((cal1 & 0xc) >> 2) << 8) | cal0;
>>>>> +           break;
>>>>> +   }
>>>>> +   default:
>>>>> +           return -ENODEV;
>>>>> +   }
>>>>> +
>>>>> +   err = dev->tf->read(dev->dev, addr_x0, 2, (u8 *)&cal_x0);
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +   cal_x0 = le32_to_cpu(cal_x0);
>>>>> +
>>>>> +   err = dev->tf->read(dev->dev, addr_x1, 2, (u8 *)&cal_x1);
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +   cal_x1 = le32_to_cpu(cal_x1);
>>>>> +
>>>>> +   slope = &sensor->slope;
>>>>> +   b_gen = &sensor->b_gen;
>>>>> +
>>>>> +   *slope = ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0);
>>>>> +   *b_gen = (((s32)cal_x1 * cal_y0 - (s32)cal_x0 * cal_y1) * 1000) /
>>>>> +            (cal_x1 - cal_x0);
>>>>> +   *b_gen *= 8;
>>>>> +
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>> +static int hts221_read_raw(struct iio_dev *indio_dev,
>>>>> +                      struct iio_chan_spec const *ch,
>>>>> +                      int *val, int *val2, long mask)
>>>>> +{
>>>>> +   int ret;
>>>>> +   struct hts221_sensor *sensor = iio_priv(indio_dev);
>>>>> +   struct hts221_dev *dev = sensor->dev;
>>>>> +
>>>>> +   switch (mask) {
>>>>> +   case IIO_CHAN_INFO_RAW: {
>>>>> +           u8 data[2];
>>>>> +
>>>>> +           mutex_lock(&indio_dev->mlock);
>>>> Use the iio_claim_direct_mode functions rather than hand rolling it.
>>>>
>>>>> +           if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
>>>>> +                   mutex_unlock(&indio_dev->mlock);
>>>>> +                   return -EBUSY;
>>>>> +           }
>>>>> +
>>>> I'd roll this up into a separate function with the unlocking outside.
>>>> Will lead to neater code.
>>>>> +           ret = hts221_sensor_power_on(sensor);
>>>>> +           if (ret < 0) {
>>>>> +                   mutex_unlock(&indio_dev->mlock);
>>>>> +                   return ret;
>>>>> +           }
>>>>> +
>>>>> +           msleep(50);
>>>>> +
>>>>> +           ret = dev->tf->read(dev->dev, ch->address, 2, data);
>>>>> +           if (ret < 0) {
>>>>> +                   mutex_unlock(&indio_dev->mlock);
>>>>> +                   return ret;
>>>>> +           }
>>>>> +
>>>>> +           ret = hts221_sensor_power_off(sensor);
>>>>> +           if (ret < 0) {
>>>>> +                   mutex_unlock(&indio_dev->mlock);
>>>>> +                   return ret;
>>>>> +           }
>>>>> +
>>>>> +           *val = (s16)get_unaligned_le16(data);
>>>>> +           ret = IIO_VAL_INT;
>>>>> +           mutex_unlock(&indio_dev->mlock);
>>>>> +
>>>>> +           break;
>>>>> +   }
>>>>> +   case IIO_CHAN_INFO_SCALE: {
>>>>> +           s64 tmp;
>>>>> +           s32 rem, div, data = sensor->slope;
>>>>> +
>>>>> +           switch (ch->type) {
>>>>> +           case IIO_HUMIDITYRELATIVE: {
>>>>> +                   div = (1 << 4) * 1000;
>>>>> +                   break;
>>>>> +           }
>>>>> +           case IIO_TEMP: {
>>>>> +                   div = (1 << 6) * 1000;
>>>>> +                   break;
>>>>> +           }
>>>>> +           default:
>>>>> +                   return -EINVAL;
>>>>> +           }
>>>>> +
>>>>> +           tmp = div_s64(data * 1000000000LL, div);
>>>>> +           tmp = div_s64_rem(tmp, 1000000000LL, &rem);
>>>>> +
>>>>> +           *val = tmp;
>>>>> +           *val2 = rem;
>>>>> +           ret = IIO_VAL_INT_PLUS_NANO;
>>>>> +           break;
>>>>> +   }
>>>>> +   case IIO_CHAN_INFO_OFFSET: {
>>>>> +           s64 tmp;
>>>>> +           s32 rem, div = sensor->slope, data = sensor->b_gen;
>>>>> +
>>>>> +           tmp = div_s64(data * 1000000000LL, div);
>>>>> +           tmp = div_s64_rem(tmp, 1000000000LL, &rem);
>>>>> +
>>>>> +           *val = tmp;
>>>>> +           *val2 = abs(rem);
>>>>> +           ret = IIO_VAL_INT_PLUS_NANO;
>>>>> +           break;
>>>>> +   }
>>>>> +   default:
>>>>> +           ret = -EINVAL;
>>>>> +           break;
>>>>> +   }
>>>>> +
>>>>> +   return ret;
>>>>> +}
>>>>> +
>>>>> +static IIO_CONST_ATTR(humidityrelative_avg_sample_available,
>>>>> +                 "4 8 16 32 64 128 256 512");
>>>>> +static IIO_DEVICE_ATTR(humidityrelative_avg_sample, S_IWUSR | S_IRUGO,
>>>>> +                  hts221_sysfs_get_h_avg_val,
>>>>> +                  hts221_sysfs_set_h_avg_val, 0);
>>>>> +static IIO_CONST_ATTR(temp_avg_sample_available,
>>>>> +                 "2 4 8 16 32 64 128 256");
>>>>> +static IIO_DEVICE_ATTR(temp_avg_sample, S_IWUSR | S_IRUGO,
>>>>> +                  hts221_sysfs_get_t_avg_val,
>>>>> +                  hts221_sysfs_set_t_avg_val, 0);
>>>>> +
>>>>> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hts221_sysfs_sampling_freq);
>>>>> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
>>>>> +                         hts221_sysfs_get_sampling_frequency,
>>>>> +                         hts221_sysfs_set_sampling_frequency);
>>>>> +
>>>>> +static struct attribute *hts221_h_attributes[] = {
>>>>> +   &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>>>>> +   &iio_dev_attr_sampling_frequency.dev_attr.attr,
>>>> Please use the info_mask_shared_by_all element for sampling_frequency.
>>>>
>>>>> +   &iio_const_attr_humidityrelative_avg_sample_available.dev_attr.attr,
>>>>> +   &iio_dev_attr_humidityrelative_avg_sample.dev_attr.attr,
>>>> This is oversampling whatever they have decided to call it in the
>>>> datasheet.  ABI for that is standard...  The sampling frequency and
>>>> this will be annoying tied together but keeping to standard abi will
>>>> make it worth the pain..  Usual trick is to cache the requested
>>>> sampling frequency and go for the best match possible when the oversampling
>>>> ratio is changed.
>>>>
>>>>> +   NULL,
>>>>> +};
>>>>> +
>>>>> +static const struct attribute_group hts221_h_attribute_group = {
>>>>> +   .attrs = hts221_h_attributes,
>>>>> +};
>>>>> +
>>>>> +static const struct iio_info hts221_h_info = {
>>>>> +   .driver_module = THIS_MODULE,
>>>>> +   .attrs = &hts221_h_attribute_group,
>>>>> +   .read_raw = &hts221_read_raw,
>>>>> +};
>>>>> +
>>>>> +static struct attribute *hts221_t_attributes[] = {
>>>>> +   &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>>>>> +   &iio_dev_attr_sampling_frequency.dev_attr.attr,
>>>>> +   &iio_const_attr_temp_avg_sample_available.dev_attr.attr,
>>>>> +   &iio_dev_attr_temp_avg_sample.dev_attr.attr,
>>>>> +   NULL,
>>>>> +};
>>>>> +
>>>>> +static const struct attribute_group hts221_t_attribute_group = {
>>>>> +   .attrs = hts221_t_attributes,
>>>>> +};
>>>>> +
>>>>> +static const struct iio_info hts221_t_info = {
>>>>> +   .driver_module = THIS_MODULE,
>>>>> +   .attrs = &hts221_t_attribute_group,
>>>>> +   .read_raw = hts221_read_raw,
>>>>> +};
>>>>> +
>>>>> +static struct iio_dev *hts221_alloc_iio_sensor(struct hts221_dev *dev,
>>>>> +                                          enum hts221_sensor_type type)
>>>>> +{
>>>>> +   struct iio_dev *iio_dev;
>>>>> +   struct hts221_sensor *sensor;
>>>>> +
>>>>> +   iio_dev = iio_device_alloc(sizeof(*sensor));
>>>>> +   if (!iio_dev)
>>>>> +           return NULL;
>>>>> +
>>>>> +   iio_dev->modes = INDIO_DIRECT_MODE;
>>>>> +   iio_dev->dev.parent = dev->dev;
>>>>> +
>>>>> +   sensor = iio_priv(iio_dev);
>>>>> +   sensor->type = type;
>>>>> +   sensor->dev = dev;
>>>>> +   sensor->odr = hts221_odr_table[0].hz;
>>>>> +
>>>>> +   switch (type) {
>>>>> +   case HTS221_SENSOR_H:
>>>>> +           iio_dev->channels = hts221_h_channels;
>>>>> +           iio_dev->num_channels = ARRAY_SIZE(hts221_h_channels);
>>>>> +           iio_dev->name = "hts221_rh";
>>>>> +           iio_dev->info = &hts221_h_info;
>>>>> +           sensor->drdy_data_mask = 0x02;
>>>>> +           break;
>>>>> +   case HTS221_SENSOR_T:
>>>>> +           iio_dev->channels = hts221_t_channels;
>>>>> +           iio_dev->num_channels = ARRAY_SIZE(hts221_t_channels);
>>>>> +           iio_dev->name = "hts221_temp";
>>>>> +           iio_dev->info = &hts221_t_info;
>>>>> +           sensor->drdy_data_mask = 0x01;
>>>>> +           break;
>>>>> +   default:
>>>>> +           iio_device_free(iio_dev);
>>>>> +           return NULL;
>>>>> +   }
>>>>> +
>>>>> +   return iio_dev;
>>>>> +}
>>>>> +
>>>>> +int hts221_probe(struct hts221_dev *dev)
>>>>> +{
>>>>> +   int i, err, count = 0;
>>>>> +   struct hts221_sensor *sensor;
>>>>> +
>>>>> +   mutex_init(&dev->lock);
>>>>> +
>>>>> +   err = hts221_check_whoami(dev);
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +
>>>>> +   err = hts221_update_odr(dev, 1);
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>>>>> +           dev->iio_devs[i] = hts221_alloc_iio_sensor(dev, i);
>>>>> +           if (!dev->iio_devs[i]) {
>>>>> +                   err = -ENOMEM;
>>>>> +                   goto power_off;
>>>>> +           }
>>>>> +           sensor = iio_priv(dev->iio_devs[i]);
>>>>> +
>>>>> +           err = hts221_update_avg(sensor,
>>>>> +                                   hts221_avg_list[i].avg_avl[3].avg);
>>>>> +           if (err < 0)
>>>>> +                   goto power_off;
>>>>> +
>>>>> +           err = hts221_parse_caldata(sensor);
>>>>> +           if (err < 0)
>>>>> +                   goto power_off;
>>>>> +   }
>>>>> +
>>>>> +   err = hts221_dev_power_off(dev);
>>>>> +   if (err < 0)
>>>>> +           goto iio_device_free;
>>>>> +
>>>>> +   if (dev->irq > 0) {
>>>>> +           err = hts221_allocate_buffers(dev);
>>>>> +           if (err < 0)
>>>>> +                   goto iio_device_free;
>>>>> +
>>>>> +           err = hts221_allocate_triggers(dev);
>>>>> +           if (err) {
>>>>> +                   hts221_deallocate_buffers(dev);
>>>>> +                   goto iio_device_free;
>>>>> +           }
>>>>> +   }
>>>>> +
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++) {
>>>>> +           err = iio_device_register(dev->iio_devs[i]);
>>>>> +           if (err < 0)
>>>>> +                   goto iio_register_err;
>>>>> +           count++;
>>>>> +   }
>>>>> +
>>>>> +   return 0;
>>>>> +
>>>>> +iio_register_err:
>>>>> +   for (i = count - 1; i >= 0; i--)
>>>>> +           iio_device_unregister(dev->iio_devs[i]);
>>>>> +power_off:
>>>>> +   hts221_dev_power_off(dev);
>>>>> +iio_device_free:
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++)
>>>>> +           if (dev->iio_devs[i])
>>>>> +                   iio_device_free(dev->iio_devs[i]);
>>>>> +
>>>>> +   return err;
>>>>> +}
>>>>> +EXPORT_SYMBOL(hts221_probe);
>>>>> +
>>>>> +int hts221_remove(struct hts221_dev *dev)
>>>>> +{
>>>>> +   int i, err;
>>>>> +
>>>>> +   err = hts221_dev_power_off(dev);
>>>>> +
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++)
>>>>> +           iio_device_unregister(dev->iio_devs[i]);
>>>> Ideal would be for remove to precisely reverse the ordering
>>>> of probe. That includes running these loops the other way around.
>>>>> +
>>>>> +   if (dev->irq > 0) {
>>>>> +           hts221_deallocate_triggers(dev);
>>>>> +           hts221_deallocate_buffers(dev);
>>>>> +   }
>>>>> +
>>>>> +   for (i = 0; i < HTS221_SENSOR_MAX; i++)
>>>>> +           iio_device_free(dev->iio_devs[i]);
>>>> Nothing prevents you using devm_iio_device_alloc thus
>>>> allowing you to drop the need to free here and in the error path
>>>> above.
>>>>
>>>>> +
>>>>> +   return err;
>>>>> +}
>>>>> +EXPORT_SYMBOL(hts221_remove);
>>>>> +
>>>>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>>>>> +MODULE_DESCRIPTION("STMicroelectronics hts221 sensor driver");
>>>>> +MODULE_LICENSE("GPL v2");
>>>>> diff --git a/drivers/iio/humidity/hts221/hts221_i2c.c b/drivers/iio/humidity/hts221/hts221_i2c.c
>>>>> new file mode 100644
>>>>> index 0000000..c02c6d2
>>>>> --- /dev/null
>>>>> +++ b/drivers/iio/humidity/hts221/hts221_i2c.c
>>>>> @@ -0,0 +1,135 @@
>>>>> +/*
>>>>> + * STMicroelectronics hts221 i2c driver
>>>>> + *
>>>>> + * Copyright 2016 STMicroelectronics Inc.
>>>>> + *
>>>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>>> + *
>>>>> + * Licensed under the GPL-2.
>>>>> + */
>>>>> +
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/i2c.h>
>>>>> +#include <linux/slab.h>
>>>>> +#include "hts221.h"
>>>>> +
>>>>> +#define I2C_AUTO_INCREMENT 0x80
>>>>> +
>>>>> +static int hts221_i2c_read(struct device *dev, u8 addr, int len, u8 *data)
>>>>> +{
>>>>> +   struct i2c_msg msg[2];
>>>>> +   struct i2c_client *client = to_i2c_client(dev);
>>>>> +
>>>>> +   if (len > 1)
>>>>> +           addr |= I2C_AUTO_INCREMENT;
>>>>> +
>>>>> +   msg[0].addr = client->addr;
>>>>> +   msg[0].flags = client->flags;
>>>>> +   msg[0].len = 1;
>>>>> +   msg[0].buf = &addr;
>>>>> +
>>>>> +   msg[1].addr = client->addr;
>>>>> +   msg[1].flags = client->flags | I2C_M_RD;
>>>>> +   msg[1].len = len;
>>>>> +   msg[1].buf = data;
>>>>> +
>>>>> +   return i2c_transfer(client->adapter, msg, 2);
>>>>> +}
>>>>> +
>>>>> +static int hts221_i2c_write(struct device *dev, u8 addr, int len, u8 *data)
>>>>> +{
>>>>> +   u8 send[len + 1];
>>>>> +   struct i2c_msg msg;
>>>>> +   struct i2c_client *client = to_i2c_client(dev);
>>>>> +
>>>>> +   if (len > 1)
>>>>> +           addr |= I2C_AUTO_INCREMENT;
>>>>> +
>>>>> +   send[0] = addr;
>>>>> +   memcpy(&send[1], data, len * sizeof(u8));
>>>>> +
>>>>> +   msg.addr = client->addr;
>>>>> +   msg.flags = client->flags;
>>>>> +   msg.len = len + 1;
>>>>> +   msg.buf = send;
>>>>> +
>>>>> +   return i2c_transfer(client->adapter, &msg, 1);
>>>>> +}
>>>>> +
>>>>> +static const struct hts221_transfer_function hts221_transfer_fn = {
>>>>> +   .read = hts221_i2c_read,
>>>>> +   .write = hts221_i2c_write,
>>>>> +};
>>>>> +
>>>>> +static int hts221_i2c_probe(struct i2c_client *client,
>>>>> +                       const struct i2c_device_id *id)
>>>>> +{
>>>>> +   int err;
>>>>> +   struct hts221_dev *dev;
>>>>> +
>>>>> +   dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>>>> +   if (!dev)
>>>>> +           return -ENOMEM;
>>>>> +
>>>>> +   i2c_set_clientdata(client, dev);
>>>>> +   dev->name = client->name;
>>>>> +   dev->dev = &client->dev;
>>>>> +   dev->irq = client->irq;
>>>>> +   dev->tf = &hts221_transfer_fn;
>>>>> +
>>>>> +   err = hts221_probe(dev);
>>>>> +   if (err < 0) {
>>>>> +           kfree(dev);
>>>>> +           return err;
>>>>> +   }
>>>>> +
>>>>> +   dev_info(&client->dev, "sensor probed\n");
>>>>> +
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>> +static int hts221_i2c_remove(struct i2c_client *client)
>>>>> +{
>>>>> +   int err;
>>>>> +   struct hts221_dev *dev = i2c_get_clientdata(client);
>>>>> +
>>>>> +   err = hts221_remove(dev);
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +
>>>>> +   dev_info(&client->dev, "sensor removed\n");
>>>> Again, too much info.
>>>>> +
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>> +#ifdef CONFIG_OF
>>>>> +static const struct of_device_id hts221_i2c_of_match[] = {
>>>>> +   { .compatible = "st,hts221", },
>>>>> +   {},
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, hts221_i2c_of_match);
>>>>> +#endif /* CONFIG_OF */
>>>>> +
>>>>> +static const struct i2c_device_id hts221_i2c_id_table[] = {
>>>>> +   { HTS221_DEV_NAME },
>>>>> +   {},
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(i2c, hts221_i2c_id_table);
>>>>> +
>>>>> +static struct i2c_driver hts221_driver = {
>>>>> +   .driver = {
>>>>> +           .name = "hts221_i2c",
>>>>> +#ifdef CONFIG_OF
>>>>> +           .of_match_table = hts221_i2c_of_match,
>>>>> +#endif /* CONFIG_OF */
>>>> As with SPI, there are cleaner ways of doing this. Look at
>>>> other drivers.
>>>>> +   },
>>>>> +   .probe = hts221_i2c_probe,
>>>>> +   .remove = hts221_i2c_remove,
>>>>> +   .id_table = hts221_i2c_id_table,
>>>>> +};
>>>>> +module_i2c_driver(hts221_driver);
>>>>> +
>>>>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>>>>> +MODULE_DESCRIPTION("STMicroelectronics hts221 i2c driver");
>>>>> +MODULE_LICENSE("GPL v2");
>>>>> diff --git a/drivers/iio/humidity/hts221/hts221_spi.c b/drivers/iio/humidity/hts221/hts221_spi.c
>>>>> new file mode 100644
>>>>> index 0000000..10056c5
>>>>> --- /dev/null
>>>>> +++ b/drivers/iio/humidity/hts221/hts221_spi.c
>>>>> @@ -0,0 +1,148 @@
>>>>> +/*
>>>>> + * STMicroelectronics hts221 spi driver
>>>>> + *
>>>>> + * Copyright 2016 STMicroelectronics Inc.
>>>>> + *
>>>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>>> + *
>>>>> + * Licensed under the GPL-2.
>>>>> + */
>>>>> +
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/spi/spi.h>
>>>>> +#include <linux/slab.h>
>>>>> +#include "hts221.h"
>>>>> +
>>>>> +#define SENSORS_SPI_READ   0x80
>>>>> +#define SPI_AUTO_INCREMENT 0x40
>>>>> +
>>>>> +static int hts221_spi_read(struct device *device, u8 addr, int len, u8 *data)
>>>>> +{
>>>>> +   int err;
>>>>> +   struct spi_device *spi = to_spi_device(device);
>>>>> +   struct hts221_dev *dev = spi_get_drvdata(spi);
>>>>> +
>>>>> +   struct spi_transfer xfers[] = {
>>>>> +           {
>>>>> +                   .tx_buf = dev->tb.tx_buf,
>>>>> +                   .bits_per_word = 8,
>>>>> +                   .len = 1,
>>>>> +           },
>>>>> +           {
>>>>> +                   .rx_buf = dev->tb.rx_buf,
>>>>> +                   .bits_per_word = 8,
>>>>> +                   .len = len,
>>>>> +           }
>>>>> +   };
>>>>> +
>>>>> +   if (len > 1)
>>>>> +           addr |= SPI_AUTO_INCREMENT;
>>>>> +   dev->tb.tx_buf[0] = addr | SENSORS_SPI_READ;
>>>>> +
>>>>> +   err = spi_sync_transfer(spi, xfers,  ARRAY_SIZE(xfers));
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +
>>>>> +   memcpy(data, dev->tb.rx_buf, len * sizeof(u8));
>>>>> +
>>>>> +   return len;
>>>>> +}
>>>>> +
>>>>> +static int hts221_spi_write(struct device *device, u8 addr, int len, u8 *data)
>>>>> +{
>>>>> +   struct spi_device *spi = to_spi_device(device);
>>>>> +   struct hts221_dev *dev = spi_get_drvdata(spi);
>>>>> +
>>>>> +   struct spi_transfer xfers = {
>>>>> +           .tx_buf = dev->tb.tx_buf,
>>>>> +           .bits_per_word = 8,
>>>>> +           .len = len + 1,
>>>>> +   };
>>>>> +
>>>>> +   if (len >= HTS221_TX_MAX_LENGTH)
>>>>> +           return -ENOMEM;
>>>>> +
>>>>> +   if (len > 1)
>>>>> +           addr |= SPI_AUTO_INCREMENT;
>>>>> +   dev->tb.tx_buf[0] = addr;
>>>>> +   memcpy(&dev->tb.tx_buf[1], data, len);
>>>>> +
>>>>> +   return spi_sync_transfer(spi, &xfers, 1);
>>>>> +}
>>>>> +
>>>>> +static const struct hts221_transfer_function hts221_transfer_fn = {
>>>>> +   .read = hts221_spi_read,
>>>>> +   .write = hts221_spi_write,
>>>>> +};
>>>>> +
>>>>> +static int hts221_spi_probe(struct spi_device *spi)
>>>>> +{
>>>>> +   int err;
>>>>> +   struct hts221_dev *dev;
>>>>> +
>>>>> +   dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>>>> +   if (!dev)
>>>>> +           return -ENOMEM;
>>>>> +
>>>>> +   spi_set_drvdata(spi, dev);
>>>>> +   dev->name = spi->modalias;
>>>>> +   dev->dev = &spi->dev;
>>>>> +   dev->irq = spi->irq;
>>>>> +   dev->tf = &hts221_transfer_fn;
>>>>> +
>>>>> +   err = hts221_probe(dev);
>>>>> +   if (err < 0) {
>>>>> +           kfree(dev);
>>>> Having dropped th dv_info, can use drop this return outside the brackets.
>>>>> +           return err;
>>>>> +   }
>>>>> +
>>>>> +   dev_info(&spi->dev, "sensor probed\n");
>>>> No useful information that isn't available elsewhere, please drop this
>>>> dev_info.
>>>>> +
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>> +static int hts221_spi_remove(struct spi_device *spi)
>>>>> +{
>>>>> +   int err;
>>>>> +   struct hts221_dev *dev = spi_get_drvdata(spi);
>>>>> +
>>>>> +   err = hts221_remove(dev);
>>>>> +   if (err < 0)
>>>>> +           return err;
>>>>> +
>>>>> +   dev_info(&spi->dev, "sensor removed\n");
>>>> No useful information that can't be trivially obtained from sysfs, so drop
>>>> this dev_info.
>>>>> +
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>> Not worth the ifdefs to save a tiny amount of space here.
>>>>> +#ifdef CONFIG_OF
>>>>> +static const struct of_device_id hts221_spi_of_match[] = {
>>>>> +   { .compatible = "st,hts221", },
>>>>> +   {},
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, hts221_spi_of_match);
>>>>> +#endif /* CONFIG_OF */
>>>>> +
>>>>> +static const struct spi_device_id hts221_spi_id_table[] = {
>>>>> +   { HTS221_DEV_NAME },
>>>>> +   {},
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(spi, hts221_spi_id_table);
>>>>> +
>>>>> +static struct spi_driver hts221_driver = {
>>>>> +   .driver = {
>>>>> +           .name = "hts221_spi",
>>>>> +#ifdef CONFIG_OF
>>>>> +           .of_match_table = hts221_spi_of_match,
>>>>> +#endif /* CONFIG_OF */
>>>> use the of_match_pointer macro that I think has the same effect
>>>> and is cleaner.
>>>>> +   },
>>>>> +   .probe = hts221_spi_probe,
>>>>> +   .remove = hts221_spi_remove,
>>>>> +   .id_table = hts221_spi_id_table,
>>>>> +};
>>>>> +module_spi_driver(hts221_driver);
>>>>> +
>>>>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>>>>> +MODULE_DESCRIPTION("STMicroelectronics hts221 spi driver");
>>>>> +MODULE_LICENSE("GPL v2");
>>>>>
>>>>
>>>
>>
> 
> 
> 

