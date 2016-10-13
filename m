Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36461 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754202AbcJMLmW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Oct 2016 07:42:22 -0400
Received: by mail-qk0-f193.google.com with SMTP id z190so5707025qkc.3
        for <linux-iio@vger.kernel.org>; Thu, 13 Oct 2016 04:40:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <040b1748-65e4-1e8e-3dbf-2e9857ea7668@kernel.org>
References: <1474919284-20898-1-git-send-email-lorenzo.bianconi@st.com>
 <1474919284-20898-2-git-send-email-lorenzo.bianconi@st.com> <040b1748-65e4-1e8e-3dbf-2e9857ea7668@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Thu, 13 Oct 2016 13:40:50 +0200
Message-ID: <CAA2SeN+FB8npc9LUN8RpuoanKh2X1XZwFJgLPGw4ZfQpdKiefQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: imu: add support to lsm6dsx driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> On 26/09/16 20:48, Lorenzo Bianconi wrote:
>> Add support to STM LSM6DS3-LSM6DSM 6-axis (acc + gyro) Mems sensor
>>
>> http://www.st.com/resource/en/datasheet/lsm6ds3.pdf
>> http://www.st.com/resource/en/datasheet/lsm6dsm.pdf
>>
>> - continuos mode support
>> - i2c support
>> - spi support
>> - trigger mode support
>> - supported devices: lsm6ds3, lsm6dsm
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Hi Jonathan,

> Given the structure of this driver, many comments will be similar
> to the other one you just submitted.
> I may not give much explanation for them if I covered it before!
>
> Very interesting device that stretches one or two corners of IIO ;)
>
> I would suggest adding fifo support before sending a final version
> of this driver.  It usually involves dropping the trigger (as triggers
> make little sense when you have fifo's involved).  Given how closely
> tied to the buffers the triggers currently are, I'd be tempted to
> drop them now - if you leave them in they become ABI and have to
> stay there for ever.
>
> Also interestingly I see the fifo is shared which is going to be
> interesting... It's actually big enough that you could run it
> as a hardware only fifo.  Probably easier to bounce it through a
> kfifo though as you can have diferent data rates from the
> different sensors.
>
> Hardware timestamping looks interesting.
>
> Anyhow, tricky bit of kit and not a bad first go at support for it.
>

I have integrated all comments you provided me, thanks.
Regarding the FIFO support I will take a look :)
I think it is better mark the device as SW buffer. Do you agree?
Despite that the FIFO is shared between accel and gyro sensors, we
need to define two kfifo buffers since sensors can run at different
ODR and we are not able to push a whole scan every time. Is there
better architecture?

Regards,
Lorenzo

> Looking forward to V2. Keep those fifos in mind as that's what
> makes this device interesting :)
>
> Jonathan
>> ---
>>  drivers/iio/imu/Kconfig                        |   1 +
>>  drivers/iio/imu/Makefile                       |   1 +
>>  drivers/iio/imu/st_lsm6dsx/Kconfig             |  23 +
>>  drivers/iio/imu/st_lsm6dsx/Makefile            |   6 +
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 105 ++++
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 241 +++++++++
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 705 +++++++++++++++++++++++++
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    | 137 +++++
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    | 155 ++++++
>>  9 files changed, 1374 insertions(+)
>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/Kconfig
>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/Makefile
>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>>
>> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
>> index 1f1ad41..156630a 100644
>> --- a/drivers/iio/imu/Kconfig
>> +++ b/drivers/iio/imu/Kconfig
>> @@ -39,6 +39,7 @@ config KMX61
>>         be called kmx61.
>>
>>  source "drivers/iio/imu/inv_mpu6050/Kconfig"
>> +source "drivers/iio/imu/st_lsm6dsx/Kconfig"
>>
>>  endmenu
>>
>> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
>> index c71bcd3..549621b 100644
>> --- a/drivers/iio/imu/Makefile
>> +++ b/drivers/iio/imu/Makefile
>> @@ -15,5 +15,6 @@ obj-$(CONFIG_IIO_ADIS_LIB) += adis_lib.o
>>
>>  obj-y += bmi160/
>>  obj-y += inv_mpu6050/
>> +obj-y += st_lsm6dsx/
>>
>>  obj-$(CONFIG_KMX61) += kmx61.o
>> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
>> new file mode 100644
>> index 0000000..5001f41
>> --- /dev/null
>> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
>> @@ -0,0 +1,23 @@
>> +
>> +config IIO_ST_LSM6DSX
>> +     tristate "STMicroelectronics LSM6DS3/LSM6DSM sensor driver"
>> +     depends on (I2C || SPI) && SYSFS
>> +     select IIO_BUFFER
>> +     select IIO_TRIGGERED_BUFFER
> Hmm. you select these but then have magic to allow them not be true.
> Drop the magic and keep them selected.
>> +     select IIO_ST_LSM6DSX_I2C if (I2C)
>> +     select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
>> +     help
>> +       Say yes here to build support for STMicroelectronics LSM6DSX imu
>> +       sensor. Supported devices: lsm6ds3, lsm6dsm
>> +
>> +       To compile this driver as a module, choose M here: the module
>> +       will be called st_lsm6dsx.
>> +
>> +config IIO_ST_LSM6DSX_I2C
>> +     tristate
>> +     depends on IIO_ST_LSM6DSX
>> +
>> +config IIO_ST_LSM6DSX_SPI
>> +     tristate
>> +     depends on IIO_ST_LSM6DSX
>> +
>> diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm6dsx/Makefile
>> new file mode 100644
>> index 0000000..257d6ee
>> --- /dev/null
>> +++ b/drivers/iio/imu/st_lsm6dsx/Makefile
>> @@ -0,0 +1,6 @@
>> +st_lsm6dsx-y := st_lsm6dsx_core.o
>> +st_lsm6dsx-$(CONFIG_IIO_BUFFER) += st_lsm6dsx_buffer.o
>> +
>> +obj-$(CONFIG_IIO_ST_LSM6DSX) += st_lsm6dsx.o
>> +obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) += st_lsm6dsx_i2c.o
>> +obj-$(CONFIG_IIO_ST_LSM6DSX_SPI) += st_lsm6dsx_spi.o
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> new file mode 100644
>> index 0000000..e79d301
>> --- /dev/null
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> @@ -0,0 +1,105 @@
>> +/*
>> + * STMicroelectronics st_lsm6dsx sensor driver
>> + *
>> + * Copyright 2016 STMicroelectronics Inc.
>> + *
>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> + * Denis Ciocca <denis.ciocca@st.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#ifndef ST_LSM6DSX_H
>> +#define ST_LSM6DSX_H
>> +
>> +#include <linux/device.h>
>> +
>> +#define ST_LSM6DS3_DEV_NAME  "lsm6ds3"
>> +#define ST_LSM6DSM_DEV_NAME  "lsm6dsm"
>> +
>> +#define ST_LSM6DSX_SAMPLE_SIZE       6
>> +
>> +#if defined(CONFIG_IIO_ST_LSM6DSX_SPI) || \
>> +     defined(CONFIG_IIO_ST_LSM6DSX_SPI_MODULE)
>> +#define ST_LSM6DSX_RX_MAX_LENGTH     12
>> +#define ST_LSM6DSX_TX_MAX_LENGTH     8193
> Why? Can't immediately see an readings that big...
>> +
>> +struct st_lsm6dsx_transfer_buffer {
>> +     u8 rx_buf[ST_LSM6DSX_RX_MAX_LENGTH];
>> +     u8 tx_buf[ST_LSM6DSX_TX_MAX_LENGTH] ____cacheline_aligned;
>> +};
>> +#endif /* CONFIG_IIO_ST_LSM6DSX_SPI */
>> +
>> +struct st_lsm6dsx_transfer_function {
>> +     int (*read)(struct device *dev, u8 addr, int len, u8 *data);
>> +     int (*write)(struct device *dev, u8 addr, int len, u8 *data);
>> +};
>> +
>> +enum st_lsm6dsx_sensor_id {
>> +     ST_LSM6DSX_ID_ACC,
>> +     ST_LSM6DSX_ID_GYRO,
>> +     ST_LSM6DSX_ID_MAX,
>> +};
>> +
>> +struct st_lsm6dsx_sensor {
>> +     enum st_lsm6dsx_sensor_id id;
>> +     struct st_lsm6dsx_dev *dev;
>> +     struct iio_trigger *trig;
>> +
>> +     u16 odr;
>> +     u32 gain;
>> +
>> +     u8 drdy_data_mask;
>> +     u8 drdy_irq_mask;
>> +};
>> +
>> +struct st_lsm6dsx_dev {
>> +     const char *name;
>> +     struct device *dev;
>> +     int irq;
>> +     struct mutex lock;
>> +
>> +     s64 hw_timestamp;
>> +
>> +     struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
>> +
>> +     const struct st_lsm6dsx_transfer_function *tf;
>> +#if defined(CONFIG_IIO_ST_LSM6DSX_SPI) || \
>> +     defined(CONFIG_IIO_ST_LSM6DSX_SPI_MODULE)
>> +     struct st_lsm6dsx_transfer_buffer tb;
>> +#endif /* CONFIG_IIO_ST_LSM6DSX_SPI */
> Hmm. This is a bigger space saving than I expected... Curious.
>> +};
>> +
>> +int st_lsm6dsx_probe(struct st_lsm6dsx_dev *dev);
>> +int st_lsm6dsx_remove(struct st_lsm6dsx_dev *dev);
>> +int st_lsm6dsx_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable);
>> +int st_lsm6dsx_write_with_mask(struct st_lsm6dsx_dev *dev, u8 addr, u8 mask,
>> +                            u8 val);
>> +#ifdef CONFIG_IIO_BUFFER
>> +int st_lsm6dsx_allocate_triggers(struct st_lsm6dsx_dev *dev);
>> +int st_lsm6dsx_deallocate_triggers(struct st_lsm6dsx_dev *dev);
>> +int st_lsm6dsx_allocate_buffers(struct st_lsm6dsx_dev *dev);
>> +int st_lsm6dsx_deallocate_buffers(struct st_lsm6dsx_dev *dev);
> For this device I wonder if it's worth the hassle of allowing it to be
> built without buffers.  Up to you but don't think I'd bother.
> Hmm. just saw the kconfig, this bit is never true. Drop it.
>> +#else
>> +static inline int st_lsm6dsx_allocate_triggers(struct st_lsm6dsx_dev *dev)
>> +{
>> +     return 0;
>> +}
>> +
>> +static inline int st_lsm6dsx_deallocate_triggers(struct st_lsm6dsx_dev *dev)
>> +{
>> +     return 0;
>> +}
>> +
>> +static inline int st_lsm6dsx_allocate_buffers(struct st_lsm6dsx_dev *dev)
>> +{
>> +     return 0;
>> +}
>> +
>> +static inline int st_lsm6dsx_deallocate_buffers(struct st_lsm6dsx_dev *dev)
>> +{
>> +     return 0;
>> +}
>> +#endif /* CONFIG_IIO_BUFFER */
>> +#endif /* ST_LSM6DSX_H */
>> +
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> new file mode 100644
>> index 0000000..5fcbb4d
>> --- /dev/null
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> @@ -0,0 +1,241 @@
>> +/*
>> + * STMicroelectronics st_lsm6dsx sensor driver
>> + *
>> + * Copyright 2016 STMicroelectronics Inc.
>> + *
>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> + * Denis Ciocca <denis.ciocca@st.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/slab.h>
>> +#include <linux/irqreturn.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/iio/buffer.h>
>> +#include "st_lsm6dsx.h"
>> +
>> +#define REG_INT1_ADDR                0x0d
>> +#define REG_DATA_AVL_ADDR    0x1e
>> +
>> +static int st_lsm6dsx_trig_set_state(struct iio_trigger *trig, bool state)
>> +{
>> +     u8 val = (state) ? 1 : 0;
> !!state is cleaner and more a common kernel idiom.
>> +     struct iio_dev *iio_dev = iio_trigger_get_drvdata(trig);
>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>> +
>> +     return st_lsm6dsx_write_with_mask(sensor->dev, REG_INT1_ADDR,
>> +                                       sensor->drdy_irq_mask, val);
>> +}
>> +
>> +static const struct iio_trigger_ops st_lsm6dsx_trigger_ops = {
>> +     .owner = THIS_MODULE,
>> +     .set_trigger_state = st_lsm6dsx_trig_set_state,
>> +};
>> +
>> +static irqreturn_t st_lsm6dsx_trigger_handler_th(int irq, void *private)
>> +{
>> +     struct st_lsm6dsx_dev *dev = (struct st_lsm6dsx_dev *)private;
>> +
>> +     dev->hw_timestamp = iio_get_time_ns(dev->iio_devs[0]);
> Same as for previous driver. Could have different timestamp settings for
> the two iio devices so you need to cache two copies until you know who
> generated it.
>
> Also, right now you aren't validating the triggers, so you are necessarily
> running on the dataready trigger. If you are not then taking the timestamp
> later is an elegant solution.  For now I'd just validate the trigger and
> device and we can look at relaxing that later as there are some fiddly
> corner cases.
>> +
>> +     return IRQ_WAKE_THREAD;
>> +}
>> +
>> +static irqreturn_t st_lsm6dsx_trigger_handler_bh(int irq, void *private)
> Given these are now threads, not sure the traditional bottom half label
> makes all that much sense..
>> +{
>> +     int i, err;
>> +     u8 avl_data;
>> +     struct st_lsm6dsx_sensor *sensor;
>> +     struct st_lsm6dsx_dev *dev = (struct st_lsm6dsx_dev *)private;
>> +
>> +     err = dev->tf->read(dev->dev, REG_DATA_AVL_ADDR, 1, &avl_data);
>> +     if (err < 0)
>> +             return IRQ_HANDLED;
>> +
>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>> +             sensor = iio_priv(dev->iio_devs[i]);
>> +
>> +             if (avl_data & sensor->drdy_data_mask)
>> +                     iio_trigger_poll_chained(sensor->trig);
>> +     }
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +int st_lsm6dsx_allocate_triggers(struct st_lsm6dsx_dev *dev)
>> +{
>> +     int i, err, count = 0;
>> +     struct st_lsm6dsx_sensor *sensor;
>> +     unsigned long irq_type;
>> +
>> +     irq_type = irqd_get_trigger_type(irq_get_irq_data(dev->irq));
>> +
>> +     switch (irq_type) {
>> +     case IRQF_TRIGGER_HIGH:
>> +     case IRQF_TRIGGER_LOW:
>> +     case IRQF_TRIGGER_RISING:
>> +             break;
>> +     default:
>> +             dev_info(dev->dev,
>> +                      "mode %lx unsupported, use IRQF_TRIGGER_RISING\n",
>> +                      irq_type);
>> +             irq_type = IRQF_TRIGGER_RISING;
>> +             break;
>> +     }
>> +
>> +     err = devm_request_threaded_irq(dev->dev, dev->irq,
>> +                                     st_lsm6dsx_trigger_handler_th,
>> +                                     st_lsm6dsx_trigger_handler_bh,
>> +                                     irq_type | IRQF_ONESHOT,
>> +                                     dev->name, dev);
>> +     if (err) {
>> +             dev_err(dev->dev, "failed to request trigger irq %d\n",
>> +                     dev->irq);
>> +             return err;
>> +     }
>> +
>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>> +             sensor = iio_priv(dev->iio_devs[i]);
>> +             sensor->trig = iio_trigger_alloc("%s-trigger",
>> +                                              dev->iio_devs[i]->name);
>> +             if (!sensor->trig) {
>> +                     err = -ENOMEM;
>> +                     goto iio_trigger_error;
>> +             }
>> +
>> +             iio_trigger_set_drvdata(sensor->trig, dev->iio_devs[i]);
>> +             sensor->trig->ops = &st_lsm6dsx_trigger_ops;
>> +             sensor->trig->dev.parent = dev->dev;
>> +
>> +             err = iio_trigger_register(sensor->trig);
>> +             if (err < 0) {
>> +                     dev_err(dev->dev, "failed to register iio trigger\n");
>> +                     goto iio_trigger_error;
>> +             }
>> +             dev->iio_devs[i]->trig = iio_trigger_get(sensor->trig);
>> +
>> +             count++;
>> +     }
>> +
>> +     return 0;
>> +
>> +iio_trigger_error:
>> +     for (i = count - 1; i >= 0; i--) {
>> +             sensor = iio_priv(dev->iio_devs[i]);
>> +             iio_trigger_unregister(sensor->trig);
>> +     }
>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>> +             sensor = iio_priv(dev->iio_devs[i]);
>> +             if (sensor->trig)
>> +                     iio_trigger_free(sensor->trig);
>> +     }
>> +
>> +     return err;
>> +}
>> +
>> +int st_lsm6dsx_deallocate_triggers(struct st_lsm6dsx_dev *dev)
>> +{
>> +     int i;
>> +     struct st_lsm6dsx_sensor *sensor;
>> +
>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>> +             sensor = iio_priv(dev->iio_devs[i]);
>> +             iio_trigger_unregister(sensor->trig);
>> +             iio_trigger_free(sensor->trig);
> There are devm versions of the register and allocate functions.
> Using them will simplify your error paths.  Rename the allocate
> trigger function to indicate it is managed however.
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
>> +{
>> +     return st_lsm6dsx_set_enable(iio_priv(iio_dev), true);
>> +}
>> +
>> +static int st_lsm6dsx_buffer_postdisable(struct iio_dev *iio_dev)
>> +{
>> +     return st_lsm6dsx_set_enable(iio_priv(iio_dev), false);
>> +}
>> +
>> +static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
>> +     .preenable = st_lsm6dsx_buffer_preenable,
>> +     .postenable = iio_triggered_buffer_postenable,
>> +     .predisable = iio_triggered_buffer_predisable,
>> +     .postdisable = st_lsm6dsx_buffer_postdisable,
>> +};
>> +
>> +static irqreturn_t st_lsm6dsx_buffer_handler_bh(int irq, void *p)
>> +{
>> +     int i, err, chan_byte, in = 0, out = 0;
>> +     struct iio_poll_func *pf = p;
>> +     struct iio_dev *iio_dev = pf->indio_dev;
>> +     struct iio_chan_spec const *ch = iio_dev->channels;
>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>> +     struct st_lsm6dsx_dev *dev = sensor->dev;
>> +     u8 out_data[iio_dev->scan_bytes], buffer[ST_LSM6DSX_SAMPLE_SIZE];
>> +
>> +     err = dev->tf->read(dev->dev, ch[0].address, ST_LSM6DSX_SAMPLE_SIZE,
>> +                         buffer);
>> +     if (err < 0)
>> +             goto out;
>> +
>> +     for (i = 0; i < iio_dev->num_channels; i++) {
>> +             chan_byte = ch[i].scan_type.storagebits >> 3;
>> +
> hmm. This is hand rolling a local demux to pull out only the elements you
> want?  Set available_scan_masks to 0x7 and then push the lot to the core.
> Core has a demux unit that does an efficient job of exactly what you have
> here.
>
>> +             if (test_bit(i, iio_dev->active_scan_mask)) {
>> +                     memcpy(&out_data[out], &buffer[in], chan_byte);
>> +                     out += chan_byte;
>> +             }
>> +             in += chan_byte;
>> +     }
>> +
>> +     iio_push_to_buffers_with_timestamp(iio_dev, out_data,
>> +                                        dev->hw_timestamp);
>> +
>> +out:
>> +     iio_trigger_notify_done(sensor->trig);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +int st_lsm6dsx_allocate_buffers(struct st_lsm6dsx_dev *dev)
>> +{
>> +     int i, err, count = 0;
>> +
>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>> +             err = iio_triggered_buffer_setup(dev->iio_devs[i], NULL,
>> +                                              st_lsm6dsx_buffer_handler_bh,
>> +                                              &st_lsm6dsx_buffer_ops);
>> +             if (err < 0)
>> +                     goto iio_buffer_error;
>> +             count++;
>> +     }
>> +
>> +     return 0;
>> +
>> +iio_buffer_error:
>> +     for (i = count - 1; i >= 0; i--)
>> +             iio_triggered_buffer_cleanup(dev->iio_devs[i]);
>> +
>> +     return err;
>> +}
>> +
>> +int st_lsm6dsx_deallocate_buffers(struct st_lsm6dsx_dev *dev)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++)
>> +             iio_triggered_buffer_cleanup(dev->iio_devs[i]);
> There is now a devm version of this which would simplify your error paths.
>> +
>> +     return 0;
>> +}
>> +
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> new file mode 100644
>> index 0000000..ed3e714
>> --- /dev/null
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> @@ -0,0 +1,705 @@
>> +/*
>> + * STMicroelectronics st_lsm6dsx sensor driver
>> + *
>> + * Copyright 2016 STMicroelectronics Inc.
>> + *
>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> + * Denis Ciocca <denis.ciocca@st.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/slab.h>
>> +#include <linux/delay.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <asm/unaligned.h>
> why?  Not immediately seeing anything that uses this...
>
>> +#include "st_lsm6dsx.h"
>> +
> All need appropriate prefix.
>> +#define REG_ACC_DRDY_IRQ_MASK        0x01
>> +#define REG_GYRO_DRDY_IRQ_MASK       0x02
>> +#define REG_WHOAMI_ADDR              0x0f
>> +#define REG_RESET_ADDR               0x12
>> +#define REG_RESET_MASK               0x01
>> +#define REG_BDU_ADDR         0x12
>> +#define REG_BDU_MASK         0x40
>> +#define REG_INT2_ON_INT1_ADDR        0x13
>> +#define REG_INT2_ON_INT1_MASK        0x20
>> +#define REG_ROUNDING_ADDR    0x16
>> +#define REG_ROUNDING_MASK    0x04
>> +#define REG_LIR_ADDR         0x58
>> +#define REG_LIR_MASK         0x01
>> +
>> +#define REG_ACC_ODR_ADDR     0x10
>> +#define REG_ACC_ODR_MASK     0xf0
>> +#define REG_ACC_FS_ADDR              0x10
>> +#define REG_ACC_FS_MASK              0x0c
>> +#define REG_ACC_OUT_X_L_ADDR 0x28
>> +#define REG_ACC_OUT_Y_L_ADDR 0x2a
>> +#define REG_ACC_OUT_Z_L_ADDR 0x2c
>> +
>> +#define REG_GYRO_ODR_ADDR    0x11
>> +#define REG_GYRO_ODR_MASK    0xf0
>> +#define REG_GYRO_FS_ADDR     0x11
>> +#define REG_GYRO_FS_MASK     0x0c
>> +#define REG_GYRO_OUT_X_L_ADDR        0x22
>> +#define REG_GYRO_OUT_Y_L_ADDR        0x24
>> +#define REG_GYRO_OUT_Z_L_ADDR        0x26
>> +
>> +#define ST_LSM6DS3_WHOAMI    0x69
>> +#define ST_LSM6DSM_WHOAMI    0x6a
>> +
>> +#define ST_LSM6DSX_ACC_FS_2G_GAIN    IIO_G_TO_M_S_2(61)
>> +#define ST_LSM6DSX_ACC_FS_4G_GAIN    IIO_G_TO_M_S_2(122)
>> +#define ST_LSM6DSX_ACC_FS_8G_GAIN    IIO_G_TO_M_S_2(244)
>> +#define ST_LSM6DSX_ACC_FS_16G_GAIN   IIO_G_TO_M_S_2(488)
>> +
>> +#define ST_LSM6DSX_DATA_ACC_AVL_MASK 0x01
>> +
>> +#define ST_LSM6DSX_GYRO_FS_245_GAIN  IIO_DEGREE_TO_RAD(4375)
>> +#define ST_LSM6DSX_GYRO_FS_500_GAIN  IIO_DEGREE_TO_RAD(8750)
>> +#define ST_LSM6DSX_GYRO_FS_1000_GAIN IIO_DEGREE_TO_RAD(17500)
>> +#define ST_LSM6DSX_GYRO_FS_2000_GAIN IIO_DEGREE_TO_RAD(70000)
>> +
>> +#define ST_LSM6DSX_DATA_GYRO_AVL_MASK        0x02
>> +
>> +struct st_lsm6dsx_odr {
>> +     u32 hz;
>> +     u8 val;
>> +};
>> +
>> +#define ST_LSM6DSX_ODR_LIST_SIZE     6
>> +struct st_lsm6dsx_odr_table_entry {
>> +     u8 addr;
>> +     u8 mask;
>> +     struct st_lsm6dsx_odr odr_avl[ST_LSM6DSX_ODR_LIST_SIZE];
>> +};
>> +
>> +static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
>> +     [ST_LSM6DSX_ID_ACC] = {
>> +             .addr = REG_ACC_ODR_ADDR,
>> +             .mask = REG_ACC_ODR_MASK,
>> +             .odr_avl[0] = {  13, 0x01 },
>> +             .odr_avl[1] = {  26, 0x02 },
>> +             .odr_avl[2] = {  52, 0x03 },
>> +             .odr_avl[3] = { 104, 0x04 },
>> +             .odr_avl[4] = { 208, 0x05 },
>> +             .odr_avl[5] = { 416, 0x06 },
>> +     },
>> +     [ST_LSM6DSX_ID_GYRO] = {
>> +             .addr = REG_GYRO_ODR_ADDR,
>> +             .mask = REG_GYRO_ODR_MASK,
>> +             .odr_avl[0] = {  13, 0x01 },
>> +             .odr_avl[1] = {  26, 0x02 },
>> +             .odr_avl[2] = {  52, 0x03 },
>> +             .odr_avl[3] = { 104, 0x04 },
>> +             .odr_avl[4] = { 208, 0x05 },
>> +             .odr_avl[5] = { 416, 0x06 },
>> +     }
>> +};
>> +
>> +struct st_lsm6dsx_fs {
>> +     u32 gain;
>> +     u8 val;
>> +};
>> +
>> +#define ST_LSM6DSX_FS_LIST_SIZE              4
>> +struct st_lsm6dsx_fs_table_entry {
>> +     u8 addr;
>> +     u8 mask;
>> +     struct st_lsm6dsx_fs fs_avl[ST_LSM6DSX_FS_LIST_SIZE];
>> +};
>> +
>> +static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
>> +     [ST_LSM6DSX_ID_ACC] = {
>> +             .addr = REG_ACC_FS_ADDR,
>> +             .mask = REG_ACC_FS_MASK,
>> +             .fs_avl[0] = {  ST_LSM6DSX_ACC_FS_2G_GAIN, 0x0 },
>> +             .fs_avl[1] = {  ST_LSM6DSX_ACC_FS_4G_GAIN, 0x2 },
>> +             .fs_avl[2] = {  ST_LSM6DSX_ACC_FS_8G_GAIN, 0x3 },
>> +             .fs_avl[3] = { ST_LSM6DSX_ACC_FS_16G_GAIN, 0x1 },
>> +     },
>> +     [ST_LSM6DSX_ID_GYRO] = {
>> +             .addr = REG_GYRO_FS_ADDR,
>> +             .mask = REG_GYRO_FS_MASK,
>> +             .fs_avl[0] = {  ST_LSM6DSX_GYRO_FS_245_GAIN, 0x0 },
>> +             .fs_avl[1] = {  ST_LSM6DSX_GYRO_FS_500_GAIN, 0x1 },
>> +             .fs_avl[2] = { ST_LSM6DSX_GYRO_FS_1000_GAIN, 0x2 },
>> +             .fs_avl[3] = { ST_LSM6DSX_GYRO_FS_2000_GAIN, 0x3 },
>> +     }
>> +};
>> +
>> +static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
>> +     {
>> +             .type = IIO_ACCEL,
>> +             .address = REG_ACC_OUT_X_L_ADDR,
>> +             .modified = 1,
>> +             .channel2 = IIO_MOD_X,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>> +             .scan_index = 0,
>> +             .scan_type = {
>> +                     .sign = 's',
>> +                     .realbits = 16,
>> +                     .storagebits = 16,
>> +                     .shift = 0,
>> +                     .endianness = IIO_LE,
>> +             },
>> +     },
>> +     {
>> +             .type = IIO_ACCEL,
>> +             .address = REG_ACC_OUT_Y_L_ADDR,
>> +             .modified = 1,
>> +             .channel2 = IIO_MOD_Y,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>> +             .scan_index = 1,
>> +             .scan_type = {
>> +                     .sign = 's',
>> +                     .realbits = 16,
>> +                     .storagebits = 16,
>> +                     .shift = 0,
>> +                     .endianness = IIO_LE,
>> +             },
>> +     },
>> +     {
>> +             .type = IIO_ACCEL,
>> +             .address = REG_ACC_OUT_Z_L_ADDR,
>> +             .modified = 1,
>> +             .channel2 = IIO_MOD_Z,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>> +             .scan_index = 2,
>> +             .scan_type = {
>> +                     .sign = 's',
>> +                     .realbits = 16,
>> +                     .storagebits = 16,
>> +                     .shift = 0,
>> +                     .endianness = IIO_LE,
>> +             },
>> +     },
>> +     IIO_CHAN_SOFT_TIMESTAMP(3),
>> +};
>> +
>> +static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
>> +     {
>> +             .type = IIO_ANGL_VEL,
>> +             .address = REG_GYRO_OUT_X_L_ADDR,
>> +             .modified = 1,
>> +             .channel2 = IIO_MOD_X,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>> +             .scan_index = 0,
>> +             .scan_type = {
>> +                     .sign = 's',
>> +                     .realbits = 16,
>> +                     .storagebits = 16,
>> +                     .shift = 0,
>> +                     .endianness = IIO_LE,
>> +             },
>> +     },
>> +     {
>> +             .type = IIO_ANGL_VEL,
>> +             .address = REG_GYRO_OUT_Y_L_ADDR,
>> +             .modified = 1,
>> +             .channel2 = IIO_MOD_Y,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>> +             .scan_index = 1,
>> +             .scan_type = {
>> +                     .sign = 's',
>> +                     .realbits = 16,
>> +                     .storagebits = 16,
>> +                     .shift = 0,
>> +                     .endianness = IIO_LE,
>> +             },
>> +     },
>> +     {
>> +             .type = IIO_ANGL_VEL,
>> +             .address = REG_GYRO_OUT_Z_L_ADDR,
>> +             .modified = 1,
>> +             .channel2 = IIO_MOD_Z,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>> +             .scan_index = 2,
>> +             .scan_type = {
>> +                     .sign = 's',
>> +                     .realbits = 16,
>> +                     .storagebits = 16,
>> +                     .shift = 0,
>> +                     .endianness = IIO_LE,
>> +             },
>> +     },
>> +     IIO_CHAN_SOFT_TIMESTAMP(3),
>> +};
>> +
>> +int st_lsm6dsx_write_with_mask(struct st_lsm6dsx_dev *dev, u8 addr, u8 mask,
>> +                            u8 val)
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
>> +     data = (data & ~mask) | ((val << __ffs(mask)) & mask);
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
>> +static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_dev *dev)
>> +{
>> +     u8 data;
>> +     int err;
>> +
>> +     err = dev->tf->read(dev->dev, REG_WHOAMI_ADDR, 1, &data);
>> +     if (err < 0) {
>> +             dev_err(dev->dev, "failed to read whoami register\n");
>> +             return err;
>> +     }
>> +
>> +     if (data != ST_LSM6DS3_WHOAMI &&
>> +         data != ST_LSM6DSM_WHOAMI) {
>> +             dev_err(dev->dev, "wrong whoami [%02x]\n", data);
>> +             return -ENODEV;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int st_lsm6dsx_set_fs(struct st_lsm6dsx_sensor *sensor, u32 gain)
>> +{
>> +     u8 val;
>> +     int i, err;
>> +     enum st_lsm6dsx_sensor_id id = sensor->id;
>> +
>> +     for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++)
>> +             if (st_lsm6dsx_fs_table[id].fs_avl[i].gain == gain)
>> +                     break;
>> +
>> +     if (i == ST_LSM6DSX_FS_LIST_SIZE)
>> +             return -EINVAL;
>> +
>> +     val = st_lsm6dsx_fs_table[id].fs_avl[i].val;
>> +     err = st_lsm6dsx_write_with_mask(sensor->dev,
>> +                                      st_lsm6dsx_fs_table[id].addr,
>> +                                      st_lsm6dsx_fs_table[id].mask, val);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     sensor->gain = gain;
>> +
>> +     return 0;
>> +}
>> +
>> +static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
>> +{
>> +     u8 val;
>> +     int i, err;
>> +     enum st_lsm6dsx_sensor_id id = sensor->id;
>> +     struct st_lsm6dsx_dev *dev = sensor->dev;
>> +
>> +     for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
>> +             if (st_lsm6dsx_odr_table[id].odr_avl[i].hz == odr)
>> +                     break;
>> +
>> +     if (i == ST_LSM6DSX_ODR_LIST_SIZE)
>> +             return -EINVAL;
>> +
>> +     disable_irq(dev->irq);
> Please explain why it is needed. Would not expect to need to mask an irq
> like this.  Should be preventing the hardware generating the interrupt
> (unless the hardware is odd).
>> +
>> +     val = st_lsm6dsx_odr_table[id].odr_avl[i].val;
>> +     err = st_lsm6dsx_write_with_mask(sensor->dev,
>> +                                      st_lsm6dsx_odr_table[id].addr,
>> +                                      st_lsm6dsx_odr_table[id].mask, val);
>> +     if (err < 0) {
>> +             enable_irq(dev->irq);
>> +             return err;
>> +     }
>> +
>> +     sensor->odr = odr;
>> +     enable_irq(dev->irq);
>> +
>> +     return 0;
>> +}
>> +
>> +int st_lsm6dsx_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
>> +{
>> +     enum st_lsm6dsx_sensor_id id = sensor->id;
>> +
>> +     if (enable)
>> +             return st_lsm6dsx_set_odr(sensor, sensor->odr);
>> +     else
>> +             return st_lsm6dsx_write_with_mask(sensor->dev,
>> +                                     st_lsm6dsx_odr_table[id].addr,
>> +                                     st_lsm6dsx_odr_table[id].mask, 0);
>> +}
>> +
>> +static int st_lsm6dsx_read_raw(struct iio_dev *iio_dev,
>> +                            struct iio_chan_spec const *ch,
>> +                            int *val, int *val2, long mask)
>> +{
>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_RAW: {
>> +             int err;
>> +             u8 data[2];
>> +             struct st_lsm6dsx_dev *dev;
>> +
>> +             mutex_lock(&iio_dev->mlock);
> iio_claim_direct_mode.  Should not be taking mlock directly under normal
> circumstances.
>> +
>> +             if (iio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
>> +                     mutex_unlock(&iio_dev->mlock);
>> +                     return -EBUSY;
>> +             }
>> +
>> +             dev = sensor->dev;
>> +             err = st_lsm6dsx_set_enable(sensor, true);
>> +             if (err < 0) {
>> +                     mutex_unlock(&iio_dev->mlock);
>> +                     return err;
>> +             }
>> +
>> +             msleep(120);
>> +
>> +             err = dev->tf->read(dev->dev, ch->address, 2, data);
>> +             if (err < 0) {
>> +                     mutex_unlock(&iio_dev->mlock);
>> +                     return err;
>> +             }
>> +
>> +             st_lsm6dsx_set_enable(sensor, false);
>> +
>> +             *val = (s16)get_unaligned_le16(data);
>> +             *val = *val >> ch->scan_type.shift;
>> +
>> +             mutex_unlock(&iio_dev->mlock);
>> +
>> +             return IIO_VAL_INT;
>> +     }
>> +     case IIO_CHAN_INFO_SCALE:
>> +             *val = 0;
>> +             *val2 = sensor->gain;
>> +             return IIO_VAL_INT_PLUS_MICRO;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
>> +                             struct iio_chan_spec const *chan,
>> +                             int val, int val2, long mask)
>> +{
>> +     int err;
>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_SCALE:
>> +             mutex_lock(&iio_dev->mlock);
>> +
>> +             if (iio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> claim_direct_mode should provide the same protections in a cleaner fashion.
>> +                     mutex_unlock(&iio_dev->mlock);
>> +                     return -EBUSY;
>> +             }
>> +             err = st_lsm6dsx_set_fs(sensor, val2);
>> +
>> +             mutex_unlock(&iio_dev->mlock);
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     return err < 0 ? err : 0;
>> +}
>> +
>> +static ssize_t
>> +st_lsm6dsx_sysfs_get_sampling_frequency(struct device *device,
>> +                                     struct device_attribute *attr,
>> +                                     char *buf)
>> +{
>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(device));
>> +
>> +     return sprintf(buf, "%d\n", sensor->odr);
>> +}
>> +
>> +static ssize_t
>> +st_lsm6dsx_sysfs_set_sampling_frequency(struct device *device,
>> +                                     struct device_attribute *attr,
>> +                                     const char *buf, size_t size)
>> +{
>> +     int err;
>> +     u32 odr;
>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(device));
>> +
>> +     err = kstrtoint(buf, 10, &odr);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     err = st_lsm6dsx_set_odr(sensor, odr);
>> +
>> +     return err < 0 ? err : size;
>> +}
>> +
>> +static ssize_t
>> +st_lsm6dsx_sysfs_sampling_frequency_avl(struct device *device,
>> +                                     struct device_attribute *attr,
>> +                                     char *buf)
>> +{
>> +     int i, len = 0;
>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(device));
>> +     enum st_lsm6dsx_sensor_id id = sensor->id;
>> +
>> +     for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
>> +             len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
>> +                              st_lsm6dsx_odr_table[id].odr_avl[i].hz);
>> +     buf[len - 1] = '\n';
>> +
>> +     return len;
>> +}
>> +
>> +static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *device,
>> +                                         struct device_attribute *attr,
>> +                                         char *buf)
>> +{
>> +     int i, len = 0;
>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(device));
>> +     enum st_lsm6dsx_sensor_id id = sensor->id;
>> +
>> +     for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++)
>> +             len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
>> +                              st_lsm6dsx_fs_table[id].fs_avl[i].gain);
>> +     buf[len - 1] = '\n';
>> +
>> +     return len;
>> +}
>> +
>> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
>> +                           st_lsm6dsx_sysfs_get_sampling_frequency,
>> +                           st_lsm6dsx_sysfs_set_sampling_frequency);
>> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sysfs_sampling_frequency_avl);
>> +static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
>> +                    st_lsm6dsx_sysfs_scale_avail, NULL, 0);
>> +static IIO_DEVICE_ATTR(in_anglvel_scale_available, S_IRUGO,
>> +                    st_lsm6dsx_sysfs_scale_avail, NULL, 0);
>> +
>> +static struct attribute *st_lsm6dsx_acc_attributes[] = {
>> +     &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>> +     &iio_dev_attr_sampling_frequency.dev_attr.attr,
> info_mask element.
>> +     &iio_dev_attr_in_accel_scale_available.dev_attr.attr,
>> +     NULL,
>> +};
>> +
>> +static const struct attribute_group st_lsm6dsx_acc_attribute_group = {
>> +     .attrs = st_lsm6dsx_acc_attributes,
>> +};
>> +
>> +static const struct iio_info st_lsm6dsx_acc_info = {
>> +     .driver_module = THIS_MODULE,
>> +     .attrs = &st_lsm6dsx_acc_attribute_group,
>> +     .read_raw = st_lsm6dsx_read_raw,
>> +     .write_raw = st_lsm6dsx_write_raw,
>> +};
>> +
>> +static struct attribute *st_lsm6dsx_gyro_attributes[] = {
>> +     &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>> +     &iio_dev_attr_sampling_frequency.dev_attr.attr,
> use the info_mask_shared_by_all element for sampling_frequency.
>
>> +     &iio_dev_attr_in_anglvel_scale_available.dev_attr.attr,
>> +     NULL,
>> +};
>> +
>> +static const struct attribute_group st_lsm6dsx_gyro_attribute_group = {
>> +     .attrs = st_lsm6dsx_gyro_attributes,
>> +};
>> +
>> +static const struct iio_info st_lsm6dsx_gyro_info = {
>> +     .driver_module = THIS_MODULE,
>> +     .attrs = &st_lsm6dsx_gyro_attribute_group,
>> +     .read_raw = st_lsm6dsx_read_raw,
>> +     .write_raw = st_lsm6dsx_write_raw,
>> +};
>> +
>> +static int st_lsm6dsx_init_device(struct st_lsm6dsx_dev *dev)
>> +{
>> +     int err;
>> +     u8 data;
>> +
>> +     data = REG_RESET_MASK;
>> +     err = dev->tf->write(dev->dev, REG_RESET_ADDR, 1, &data);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     msleep(200);
>> +
>> +     /* latch interrupts */
>> +     err = st_lsm6dsx_write_with_mask(dev, REG_LIR_ADDR, REG_LIR_MASK, 1);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     /* enable BDU */
>> +     err = st_lsm6dsx_write_with_mask(dev, REG_BDU_ADDR, REG_BDU_MASK, 1);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     err = st_lsm6dsx_write_with_mask(dev, REG_ROUNDING_ADDR,
>> +                                      REG_ROUNDING_MASK, 1);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     /* redirect INT2 on INT1 */
>> +     err = st_lsm6dsx_write_with_mask(dev, REG_INT2_ON_INT1_ADDR,
>> +                                      REG_INT2_ON_INT1_MASK, 1);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     return 0;
>> +}
>> +
>> +static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_dev *dev,
>> +                                            enum st_lsm6dsx_sensor_id id)
>> +{
>> +     struct iio_dev *iio_dev;
>> +     struct st_lsm6dsx_sensor *sensor;
>> +
>> +     iio_dev = iio_device_alloc(sizeof(*sensor));
>> +     if (!iio_dev)
>> +             return NULL;
>> +
>> +     iio_dev->modes = INDIO_DIRECT_MODE;
>> +     iio_dev->dev.parent = dev->dev;
>> +
>> +     sensor = iio_priv(iio_dev);
>> +     sensor->id = id;
>> +     sensor->dev = dev;
>> +     sensor->odr = st_lsm6dsx_odr_table[id].odr_avl[0].hz;
>> +     sensor->gain = st_lsm6dsx_fs_table[id].fs_avl[0].gain;
>> +
>> +     switch (id) {
>> +     case ST_LSM6DSX_ID_ACC:
>> +             iio_dev->channels = st_lsm6dsx_acc_channels;
>> +             iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_acc_channels);
>> +             iio_dev->name = "lsm6dsx_accel";
>> +             iio_dev->info = &st_lsm6dsx_acc_info;
>> +
>> +             sensor->drdy_data_mask = ST_LSM6DSX_DATA_ACC_AVL_MASK;
>> +             sensor->drdy_irq_mask = REG_ACC_DRDY_IRQ_MASK;
>> +             break;
>> +     case ST_LSM6DSX_ID_GYRO:
>> +             iio_dev->channels = st_lsm6dsx_gyro_channels;
>> +             iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_gyro_channels);
>> +             iio_dev->name = "lsm6dsx_gyro";
>> +             iio_dev->info = &st_lsm6dsx_gyro_info;
>> +
>> +             sensor->drdy_data_mask = ST_LSM6DSX_DATA_GYRO_AVL_MASK;
>> +             sensor->drdy_irq_mask = REG_GYRO_DRDY_IRQ_MASK;
>> +             break;
>> +     default:
>> +             iio_device_free(iio_dev);
>> +             return NULL;
>> +     }
>> +
>> +     return iio_dev;
>> +}
>> +
>> +int st_lsm6dsx_probe(struct st_lsm6dsx_dev *dev)
>> +{
>> +     int i, j, err;
>> +
>> +     mutex_init(&dev->lock);
>> +
>> +     err = st_lsm6dsx_check_whoami(dev);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>> +             dev->iio_devs[i] = st_lsm6dsx_alloc_iiodev(dev, i);
>> +             if (!dev->iio_devs[i]) {
>> +                     err = -ENOMEM;
>> +                     goto iio_device_free;
>> +             }
>> +     }
>> +
>> +     err = st_lsm6dsx_init_device(dev);
>> +     if (err < 0)
>> +             goto iio_device_free;
>> +
>> +     if (dev->irq > 0) {
>> +             err = st_lsm6dsx_allocate_buffers(dev);
>> +             if (err < 0)
>> +                     goto iio_device_free;
>> +
>> +             err = st_lsm6dsx_allocate_triggers(dev);
>> +             if (err < 0)
>> +                     goto deallocate_buffers;
>> +     }
>> +
>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>> +             err = iio_device_register(dev->iio_devs[i]);
>> +             if (err)
>> +                     goto iio_device_unregister;
>> +     }
>> +
>> +     return 0;
>> +
>> +iio_device_unregister:
>> +     for (j = i - 1; j >= 0; j--)
>> +             iio_device_unregister(dev->iio_devs[i]);
>> +     if (dev->irq > 0)
>> +             st_lsm6dsx_deallocate_triggers(dev);
>> +deallocate_buffers:
>> +     if (dev->irq > 0)
>> +             st_lsm6dsx_deallocate_buffers(dev);
>> +iio_device_free:
>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++)
>> +             if (dev->iio_devs[i])
>> +                     iio_device_free(dev->iio_devs[i]);
>> +
>> +     return err;
>> +}
>> +EXPORT_SYMBOL(st_lsm6dsx_probe);
>> +
>> +int st_lsm6dsx_remove(struct st_lsm6dsx_dev *dev)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++)
>> +             iio_device_unregister(dev->iio_devs[i]);
> I think you can devm the lot which will simplify
> thing some what.
>> +
>> +     if (dev->irq > 0) {
>> +             st_lsm6dsx_deallocate_triggers(dev);
>> +             st_lsm6dsx_deallocate_buffers(dev);
>> +     }
>> +
>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++)
>> +             iio_device_free(dev->iio_devs[i]);
> devm_iio_device_alloc then drop this.
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL(st_lsm6dsx_remove);
>> +
>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>> +MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>> new file mode 100644
>> index 0000000..88b6794
>> --- /dev/null
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>> @@ -0,0 +1,137 @@
>> +/*
>> + * STMicroelectronics st_lsm6dsx i2c driver
>> + *
>> + * Copyright 2016 STMicroelectronics Inc.
>> + *
>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> + * Denis Ciocca <denis.ciocca@st.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/slab.h>
>> +#include "st_lsm6dsx.h"
>> +
>> +static int st_lsm6dsx_i2c_read(struct device *dev, u8 addr, int len, u8 *data)
>> +{
>> +     struct i2c_msg msg[2];
>> +     struct i2c_client *client = to_i2c_client(dev);
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
>> +static int st_lsm6dsx_i2c_write(struct device *dev, u8 addr, int len, u8 *data)
>> +{
>> +     u8 send[len + 1];
>> +     struct i2c_msg msg;
>> +     struct i2c_client *client = to_i2c_client(dev);
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
>> +static const struct st_lsm6dsx_transfer_function st_lsm6dsx_transfer_fn = {
>> +     .read = st_lsm6dsx_i2c_read,
>> +     .write = st_lsm6dsx_i2c_write,
>> +};
>> +
>> +static int st_lsm6dsx_i2c_probe(struct i2c_client *client,
>> +                             const struct i2c_device_id *id)
>> +{
>> +     int err;
>> +     struct st_lsm6dsx_dev *dev;
>> +
>> +     dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>> +     if (!dev)
>> +             return -ENOMEM;
>> +
>> +     i2c_set_clientdata(client, dev);
>> +     dev->name = client->name;
>> +     dev->dev = &client->dev;
>> +     dev->irq = client->irq;
>> +     dev->tf = &st_lsm6dsx_transfer_fn;
>> +
>> +     err = st_lsm6dsx_probe(dev);
>> +     if (err < 0) {
>> +             kfree(dev);
>> +             return err;
>> +     }
>> +
>> +     dev_info(&client->dev, "sensor probed\n");
>> +
>> +     return 0;
>> +}
>> +
>> +static int st_lsm6dsx_i2c_remove(struct i2c_client *client)
>> +{
>> +     int err;
>> +     struct st_lsm6dsx_dev *dev = i2c_get_clientdata(client);
>> +
>> +     err = st_lsm6dsx_remove(dev);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     dev_info(&client->dev, "sensor removed\n");
>> +
>> +     return 0;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>> +     {
>> +             .compatible = "st,lsm6ds3",
>> +             .data = ST_LSM6DS3_DEV_NAME,
>> +     },
>> +     {
>> +             .compatible = "st,lsm6dsm",
>> +             .data = ST_LSM6DSM_DEV_NAME,
>> +     },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
>> +#endif /* CONFIG_OF */
>> +
>> +static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>> +     { ST_LSM6DS3_DEV_NAME },
>> +     { ST_LSM6DSM_DEV_NAME },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
>> +
>> +static struct i2c_driver st_lsm6dsx_driver = {
>> +     .driver = {
>> +             .name = "st_lsm6dsx_i2c",
>> +#ifdef CONFIG_OF
>> +             .of_match_table = st_lsm6dsx_i2c_of_match,
>> +#endif /* CONFIG_OF */
> same comments as for the spi version
>> +     },
>> +     .probe = st_lsm6dsx_i2c_probe,
>> +     .remove = st_lsm6dsx_i2c_remove,
>> +     .id_table = st_lsm6dsx_i2c_id_table,
>> +};
>> +module_i2c_driver(st_lsm6dsx_driver);
>> +
>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>> +MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i2c driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>> new file mode 100644
>> index 0000000..b5042b2
>> --- /dev/null
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>> @@ -0,0 +1,155 @@
>> +/*
>> + * STMicroelectronics st_lsm6dsx spi driver
>> + *
>> + * Copyright 2016 STMicroelectronics Inc.
>> + *
>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> + * Denis Ciocca <denis.ciocca@st.com>
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/slab.h>
>> +#include "st_lsm6dsx.h"
>> +
>> +#define SENSORS_SPI_READ     0x80
>> +
>> +static int st_lsm6dsx_spi_read(struct device *device, u8 addr, int len,
>> +                            u8 *data)
>> +{
>> +     int err;
>> +     struct spi_device *spi = to_spi_device(device);
>> +     struct st_lsm6dsx_dev *dev = spi_get_drvdata(spi);
>> +
>> +     struct spi_transfer xfers[] = {
>> +             {
>> +                     .tx_buf = dev->tb.tx_buf,
>> +                     .bits_per_word = 8,
>> +                     .len = 1,
>> +             },
>> +             {
> }, {
>> +                     .rx_buf = dev->tb.rx_buf,
>> +                     .bits_per_word = 8,
>> +                     .len = len,
>> +             }
>> +     };
>> +
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
>> +static int st_lsm6dsx_spi_write(struct device *device, u8 addr, int len,
>> +                             u8 *data)
>> +{
>> +     struct spi_device *spi = to_spi_device(device);
>> +     struct st_lsm6dsx_dev *dev = spi_get_drvdata(spi);
>> +
>> +     struct spi_transfer xfers = {
>> +             .tx_buf = dev->tb.tx_buf,
>> +             .bits_per_word = 8,
>> +             .len = len + 1,
>> +     };
>> +
>> +     if (len >= ST_LSM6DSX_TX_MAX_LENGTH)
>> +             return -ENOMEM;
>> +
>> +     dev->tb.tx_buf[0] = addr;
>> +     memcpy(&dev->tb.tx_buf[1], data, len);
>> +
>> +     return spi_sync_transfer(spi, &xfers, 1);
>> +}
>> +
>> +static const struct st_lsm6dsx_transfer_function st_lsm6dsx_transfer_fn = {
>> +     .read = st_lsm6dsx_spi_read,
>> +     .write = st_lsm6dsx_spi_write,
>> +};
>> +
>> +static int st_lsm6dsx_spi_probe(struct spi_device *spi)
>> +{
>> +     int err;
>> +     struct st_lsm6dsx_dev *dev;
> I'd rename.  Dev tends to mean a struct device which had
> me briefly confused.
>> +
>> +     dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>> +     if (!dev)
>> +             return -ENOMEM;
>> +
>> +     spi_set_drvdata(spi, dev);
>> +     dev->name = spi->modalias;
>> +     dev->dev = &spi->dev;
>> +     dev->irq = spi->irq;
>> +     dev->tf = &st_lsm6dsx_transfer_fn;
>> +
>> +     err = st_lsm6dsx_probe(dev);
>> +     if (err < 0) {
>> +             kfree(dev);
>> +             return err;
>> +     }
>> +
>> +     dev_info(&spi->dev, "sensor probed\n");
> drop
>> +
>> +     return 0;
>> +}
>> +
>> +static int st_lsm6dsx_spi_remove(struct spi_device *spi)
>> +{
>> +     int err;
>> +     struct st_lsm6dsx_dev *dev = spi_get_drvdata(spi);
>> +
>> +     err = st_lsm6dsx_remove(dev);
> return st_lsm6dsx_remove(spi_get_drvdata(spi));
>> +     if (err < 0)
>> +             return err;
>> +
>> +     dev_info(&spi->dev, "sensor removed\n");
> drop
>> +
>> +     return 0;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>> +     {
>> +             .compatible = "st,lsm6ds3",
>> +             .data = ST_LSM6DS3_DEV_NAME,
>> +     },
>> +     {
>> +             .compatible = "st,lsm6dsm",
>> +             .data = ST_LSM6DSM_DEV_NAME,
>> +     },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> Mess and complexity not worth the tiny space saving.
>> +#endif /* CONFIG_OF */
>> +
>> +static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>> +     { ST_LSM6DS3_DEV_NAME },
>> +     { ST_LSM6DSM_DEV_NAME },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
>> +
>> +static struct spi_driver st_lsm6dsx_driver = {
>> +     .driver = {
>> +             .name = "st_lsm6dsx_spi",
>> +#ifdef CONFIG_OF
>> +             .of_match_table = st_lsm6dsx_spi_of_match,
>> +#endif /* CONFIG_OF */
> clean this up as per comments in previous.
>> +     },
>> +     .probe = st_lsm6dsx_spi_probe,
>> +     .remove = st_lsm6dsx_spi_remove,
>> +     .id_table = st_lsm6dsx_spi_id_table,
>> +};
>> +module_spi_driver(st_lsm6dsx_driver);
>> +
>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>> +MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx spi driver");
>> +MODULE_LICENSE("GPL v2");
>>
>



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
