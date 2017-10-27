Return-Path: <SRS0=wbiz=B2=pmeerw.net=pmeerw@kernel.org>
Date: Fri, 27 Oct 2017 14:06:39 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
    devicetree@vger.kernel.org, Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Subject: Re: [PATCH 1/2] iio: light: add support to UVIS25 sensor
In-Reply-To: <CAA2SeN+z6njqtUFK-qJ7aAhLQbDEn8PzGBQXji6a1NrJCSyNeA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1710271403560.18486@vps.pmeerw.net>
References: <20171025181609.3803-1-lorenzo.bianconi@st.com> <20171025181609.3803-2-lorenzo.bianconi@st.com> <20171026183540.288dfdea@archlinux> <alpine.DEB.2.20.1710262040480.688@vps.pmeerw.net>
 <CAA2SeN+z6njqtUFK-qJ7aAhLQbDEn8PzGBQXji6a1NrJCSyNeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> thanks for the review, just a comment inline.

just ignore me when I say silly stuff :)

you are right about iio_device_claim_direct_mode() locking of course

> >> On Wed, 25 Oct 2017 20:16:08 +0200
> >> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
> >>
> >> Really minor English comment to start.
> >> add support 'for' UVIS25 sensor
> >>
> >>
> >>
> >> > add support to STMicroelectronics UVIS25 uv sensor
> >> > http://www.st.com/resource/en/datasheet/uvis25.pdf
> >> >
> >> > - continuos mode support
> >> > - i2c support
> >> > - spi support
> >> > - trigger mode support
> >> > - system PM support
> >>
> >> The autoincrement bit in the addresses is a little unusual, but
> >> if feels like this could be neater done using regmap than
> >> by spinning your own infrastructure.
> >>
> >> If there is no nasty side effect in always setting autoincrement
> >> then you should be fine just putting that in write_flag_mask and
> >> read_flag_mask.
> >>
> >> I've suggested an alternative for the interrupt handling.
> >> Not sure it won't end up more hideous than what you have
> >> but worth playing with perhaps.  Tryrenable was always
> >> there for triggers to deal with odd race conditions
> >> (originally it was a level interrupt connected to an
> >> edge sensitive pxa27x input on the first board I had ;)
> >>
> >> Might work here at the cost of an extra few reads.
> >>
> >> Jonathan
> >> >
> >> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> >> > ---
> >> >  drivers/iio/light/Kconfig            |  22 +++
> >> >  drivers/iio/light/Makefile           |   6 +
> >> >  drivers/iio/light/st_uvis25.h        |  63 +++++++++
> >> >  drivers/iio/light/st_uvis25_buffer.c | 147 +++++++++++++++++++
> >> >  drivers/iio/light/st_uvis25_core.c   | 264 +++++++++++++++++++++++++++++++++++
> >> >  drivers/iio/light/st_uvis25_i2c.c    |  76 ++++++++++
> >> >  drivers/iio/light/st_uvis25_spi.c    | 109 +++++++++++++++
> >> >  7 files changed, 687 insertions(+)
> >> >  create mode 100644 drivers/iio/light/st_uvis25.h
> >> >  create mode 100644 drivers/iio/light/st_uvis25_buffer.c
> >> >  create mode 100644 drivers/iio/light/st_uvis25_core.c
> >> >  create mode 100644 drivers/iio/light/st_uvis25_i2c.c
> >> >  create mode 100644 drivers/iio/light/st_uvis25_spi.c
> >> >
> >> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> >> > index 2356ed9285df..3c5492ec9df6 100644
> >> > --- a/drivers/iio/light/Kconfig
> >> > +++ b/drivers/iio/light/Kconfig
> >> > @@ -334,6 +334,28 @@ config STK3310
> >> >      Choosing M will build the driver as a module. If so, the module
> >> >      will be called stk3310.
> >> >
> >> > +config ST_UVIS25
> >> > +   tristate "STMicroelectronics UVIS25 sensor driver"
> >> > +   depends on (I2C || SPI)
> >> > +   select IIO_BUFFER
> >> > +   select IIO_TRIGGERED_BUFFER
> >> > +   select ST_UVIS25_I2C if (I2C)
> >> > +   select ST_UVIS25_SPI if (SPI_MASTER)
> >> > +   help
> >> > +     Say yes here to build support for STMicroelectronics UVIS25
> >> > +     uv sensor
> >> > +
> >> > +     To compile this driver as a module, choose M here: the module
> >> > +     will be called st_uvis25.
> >> > +
> >> > +config ST_UVIS25_I2C
> >> > +   tristate
> >> > +   depends on ST_UVIS25
> >> > +
> >> > +config ST_UVIS25_SPI
> >> > +   tristate
> >> > +   depends on ST_UVIS25
> >> > +
> >> >  config TCS3414
> >> >     tristate "TAOS TCS3414 digital color sensor"
> >> >     depends on I2C
> >> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> >> > index fa32fa459e2e..971d316cba5f 100644
> >> > --- a/drivers/iio/light/Makefile
> >> > +++ b/drivers/iio/light/Makefile
> >> > @@ -32,6 +32,12 @@ obj-$(CONFIG_RPR0521)            += rpr0521.o
> >> >  obj-$(CONFIG_SENSORS_TSL2563)      += tsl2563.o
> >> >  obj-$(CONFIG_SI1145)               += si1145.o
> >> >  obj-$(CONFIG_STK3310)          += stk3310.o
> >> > +
> >> > +st_uvis25-y := st_uvis25_core.o st_uvis25_buffer.o
> >
> > does the driver name start with S or U w.r.t alphabetic ordering?
> >
> 
> driver name starts with S.
> 
> >> Why bother with the split?  I'd just have one file for both of
> >> these.  There isn't enough code to justify it for readability reasons.
> >>
> >> I thought I was going to find it as a config dependency
> >> (was going to suggest you always built if it was ;)
> >>
> >> > +obj-$(CONFIG_ST_UVIS25)            += st_uvis25.o
> >> > +obj-$(CONFIG_ST_UVIS25_I2C)        += st_uvis25_i2c.o
> >> > +obj-$(CONFIG_ST_UVIS25_SPI)        += st_uvis25_spi.o
> >> > +
> >> >  obj-$(CONFIG_TCS3414)              += tcs3414.o
> >> >  obj-$(CONFIG_TCS3472)              += tcs3472.o
> >> >  obj-$(CONFIG_TSL2583)              += tsl2583.o
> >> > diff --git a/drivers/iio/light/st_uvis25.h b/drivers/iio/light/st_uvis25.h
> >> > new file mode 100644
> >> > index 000000000000..d444a73e743f
> >> > --- /dev/null
> >> > +++ b/drivers/iio/light/st_uvis25.h
> >> > @@ -0,0 +1,63 @@
> >> > +/*
> >> > + * STMicroelectronics uvis25 sensor driver
> >> > + *
> >> > + * Copyright 2017 STMicroelectronics Inc.
> >> > + *
> >> > + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> >> > + *
> >> > + * Licensed under the GPL-2.
> >> > + */
> >> > +
> >> > +#ifndef ST_UVIS25_H
> >> > +#define ST_UVIS25_H
> >> > +
> >> > +#define ST_UVIS25_DEV_NAME         "uvis25"
> >> > +
> >> > +#include <linux/iio/iio.h>
> >> > +
> >> > +#define ST_UVIS25_RX_MAX_LENGTH            8
> >> > +#define ST_UVIS25_TX_MAX_LENGTH            8
> >> > +
> >> > +struct st_uvis25_transfer_buffer {
> >> > +   u8 rx_buf[ST_UVIS25_RX_MAX_LENGTH];
> >> > +   u8 tx_buf[ST_UVIS25_TX_MAX_LENGTH] ____cacheline_aligned;
> >> > +};
> >> > +
> >> > +struct st_uvis25_transfer_function {
> >> > +   int (*read)(struct device *dev, u8 addr, int len, u8 *data);
> >> > +   int (*write)(struct device *dev, u8 addr, int len, u8 *data);
> >> > +};
> >> > +
> >> > +/**
> >> > + * struct st_uvis25_hw - ST UVIS25 sensor instance
> >> > + * @dev: Pointer to instance of struct device (I2C or SPI).
> >> > + * @lock: Mutex to protect read and write operations.
> >> > + * @trig: The trigger in use by the driver.
> >> > + * @enabled: Status of the sensor (false->off, true->on).
> >> > + * @irq: Device interrupt line (I2C or SPI).
> >> > + * @tf: Transfer function structure used by I/O operations.
> >> > + * @tb: Transfer buffers used by SPI I/O operations.
> >> > + */
> >> > +struct st_uvis25_hw {
> >> > +   struct device *dev;
> >> > +
> >> > +   struct mutex lock;
> >> > +   struct iio_trigger *trig;
> >> > +   bool enabled;
> >> > +   int irq;
> >> > +
> >> > +   const struct st_uvis25_transfer_function *tf;
> >> > +   struct st_uvis25_transfer_buffer tb;
> >> > +};
> >> > +
> >> > +extern const struct dev_pm_ops st_uvis25_pm_ops;
> >> > +
> >> > +int st_uvis25_write_with_mask(struct st_uvis25_hw *hw, u8 addr,
> >> > +                         u8 mask, u8 val);
> >> > +int st_uvis25_set_enable(struct st_uvis25_hw *hw, bool enable);
> >> > +int st_uvis25_probe(struct device *dev, int irq,
> >> > +               const struct st_uvis25_transfer_function *tf_ops);
> >> > +int st_uvis25_allocate_buffer(struct iio_dev *iio_dev);
> >> > +int st_uvis25_allocate_trigger(struct iio_dev *iio_dev);
> >> > +
> >> > +#endif /* ST_UVIS25_H */
> >> > diff --git a/drivers/iio/light/st_uvis25_buffer.c b/drivers/iio/light/st_uvis25_buffer.c
> >> > new file mode 100644
> >> > index 000000000000..06b95287ca98
> >> > --- /dev/null
> >> > +++ b/drivers/iio/light/st_uvis25_buffer.c
> >> > @@ -0,0 +1,147 @@
> >> > +/*
> >> > + * STMicroelectronics uvis25 sensor driver
> >> > + *
> >> > + * Copyright 2017 STMicroelectronics Inc.
> >> > + *
> >> > + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> >> > + *
> >> > + * Licensed under the GPL-2.
> >> > + */
> >> > +#include <linux/kernel.h>
> >> > +#include <linux/module.h>
> >> > +#include <linux/device.h>
> >> > +#include <linux/interrupt.h>
> >> > +#include <linux/irqreturn.h>
> >> > +#include <linux/iio/trigger.h>
> >> > +#include <linux/iio/trigger_consumer.h>
> >> > +#include <linux/iio/triggered_buffer.h>
> >> > +#include <linux/iio/buffer.h>
> >> > +
> >> > +#include "st_uvis25.h"
> >> > +
> >> > +#define ST_UVIS25_REG_CTRL3_ADDR   0x22
> >> > +#define ST_UVIS25_REG_HL_MASK              BIT(7)
> >> > +#define ST_UVIS25_REG_STATUS_ADDR  0x27
> >> > +#define ST_UVIS25_REG_UV_DA_MASK   BIT(0)
> >> > +
> >> > +static irqreturn_t st_uvis25_trigger_handler_thread(int irq, void *private)
> >> > +{
> >> > +   struct st_uvis25_hw *hw = private;
> >> > +   u8 status;
> >> > +   int err;
> >> > +
> >> > +   err = hw->tf->read(hw->dev, ST_UVIS25_REG_STATUS_ADDR, sizeof(status),
> >> > +                      &status);
> >> > +   if (err < 0)
> >> > +           return IRQ_HANDLED;
> >> > +
> >> > +   if (!(status & ST_UVIS25_REG_UV_DA_MASK))
> >> > +           return IRQ_NONE;
> >> > +
> >> > +   iio_trigger_poll_chained(hw->trig);
> >> > +
> >> > +   return IRQ_HANDLED;
> >> > +}
> >> > +
> >> > +int st_uvis25_allocate_trigger(struct iio_dev *iio_dev)
> >> > +{
> >> > +   struct st_uvis25_hw *hw = iio_priv(iio_dev);
> >> > +   bool irq_active_low = false;
> >> > +   unsigned long irq_type;
> >> > +   int err;
> >> > +
> >> > +   irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
> >> > +
> >> > +   switch (irq_type) {
> >> > +   case IRQF_TRIGGER_HIGH:
> >> > +   case IRQF_TRIGGER_RISING:
> >> > +           break;
> >> > +   case IRQF_TRIGGER_LOW:
> >> > +   case IRQF_TRIGGER_FALLING:
> >> > +           irq_active_low = true;
> >> > +           break;
> >> > +   default:
> >
> > maybe just failing is the better/simpler option
> >
> 
> ack
> 
> >> > +           dev_info(hw->dev,
> >> > +                    "mode %lx unsupported, using IRQF_TRIGGER_RISING\n",
> >> > +                    irq_type);
> >> > +           irq_type = IRQF_TRIGGER_RISING;
> >> > +           break;
> >> > +   }
> >> > +
> >> > +   err = st_uvis25_write_with_mask(hw, ST_UVIS25_REG_CTRL3_ADDR,
> >> > +                                   ST_UVIS25_REG_HL_MASK, irq_active_low);
> >> > +   if (err < 0)
> >> > +           return err;
> >> > +
> >> > +   err = devm_request_threaded_irq(hw->dev, hw->irq, NULL,
> >> > +                                   st_uvis25_trigger_handler_thread,
> >> > +                                   irq_type | IRQF_ONESHOT,
> >> > +                                   iio_dev->name, hw);
> >> > +   if (err) {
> >> > +           dev_err(hw->dev, "failed to request trigger irq %d\n",
> >> > +                   hw->irq);
> >> > +           return err;
> >> > +   }
> >> > +
> >> > +   hw->trig = devm_iio_trigger_alloc(hw->dev, "%s-trigger",
> >> > +                                     iio_dev->name);
> >> > +   if (!hw->trig)
> >> > +           return -ENOMEM;
> >> > +
> >> > +   iio_trigger_set_drvdata(hw->trig, iio_dev);
> >> > +   hw->trig->dev.parent = hw->dev;
> >> > +
> >> > +   return devm_iio_trigger_register(hw->dev, hw->trig);
> >> > +}
> >> > +
> >> > +static int st_uvis25_buffer_preenable(struct iio_dev *iio_dev)
> >> > +{
> >> > +   return st_uvis25_set_enable(iio_priv(iio_dev), true);
> >> > +}
> >> > +
> >> > +static int st_uvis25_buffer_postdisable(struct iio_dev *iio_dev)
> >> > +{
> >> > +   return st_uvis25_set_enable(iio_priv(iio_dev), false);
> >> > +}
> >> > +
> >> > +static const struct iio_buffer_setup_ops st_uvis25_buffer_ops = {
> >> > +   .preenable = st_uvis25_buffer_preenable,
> >> > +   .postenable = iio_triggered_buffer_postenable,
> >> > +   .predisable = iio_triggered_buffer_predisable,
> >> > +   .postdisable = st_uvis25_buffer_postdisable,
> >> > +};
> >> > +
> >> > +static irqreturn_t st_uvis25_buffer_handler_thread(int irq, void *p)
> >> > +{
> >> > +   u8 buffer[ALIGN(sizeof(u8), sizeof(s64)) + sizeof(s64)];
> >> > +   struct iio_poll_func *pf = p;
> >> > +   struct iio_dev *iio_dev = pf->indio_dev;
> >> > +   struct st_uvis25_hw *hw = iio_priv(iio_dev);
> >> > +   int err;
> >> > +
> >> > +   err = hw->tf->read(hw->dev, iio_dev->channels[0].address, sizeof(u8),
> >
> > maybe just use a #define for 0x28 given that there is just one channel
> >
> 
> ack
> 
> >> > +                      buffer);
> >> > +   if (err < 0)
> >> > +           goto out;
> >> > +
> >> > +   iio_push_to_buffers_with_timestamp(iio_dev, buffer,
> >> > +                                      iio_get_time_ns(iio_dev));
> >> > +
> >> > +out:
> >> > +   iio_trigger_notify_done(hw->trig);
> >> > +
> >> > +   return IRQ_HANDLED;
> >> > +}
> >> > +
> >> > +int st_uvis25_allocate_buffer(struct iio_dev *iio_dev)
> >> > +{
> >> > +   struct st_uvis25_hw *hw = iio_priv(iio_dev);
> >> > +
> >> > +   return devm_iio_triggered_buffer_setup(hw->dev, iio_dev, NULL,
> >> > +                                          st_uvis25_buffer_handler_thread,
> >> > +                                          &st_uvis25_buffer_ops);
> >> > +}
> >> > +
> >> > +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
> >> > +MODULE_DESCRIPTION("STMicroelectronics uvis25 buffer driver");
> >> > +MODULE_LICENSE("GPL v2");
> >> > diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
> >> > new file mode 100644
> >> > index 000000000000..08247092dfff
> >> > --- /dev/null
> >> > +++ b/drivers/iio/light/st_uvis25_core.c
> >> > @@ -0,0 +1,264 @@
> >> > +/*
> >> > + * STMicroelectronics uvis25 sensor driver
> >> > + *
> >> > + * Copyright 2017 STMicroelectronics Inc.
> >> > + *
> >> > + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> >> > + *
> >> > + * Licensed under the GPL-2.
> >> > + */
> >> > +
> >> > +#include <linux/kernel.h>
> >> > +#include <linux/module.h>
> >> > +#include <linux/device.h>
> >> > +#include <linux/iio/sysfs.h>
> >> > +#include <linux/delay.h>
> >> > +#include <linux/pm.h>
> >> > +#include <linux/interrupt.h>
> >> > +
> >> > +#include "st_uvis25.h"
> >> > +
> >> > +#define ST_UVIS25_REG_WHOAMI_ADDR  0x0f
> >> > +#define ST_UVIS25_REG_WHOAMI_VAL   0xca
> >> > +#define ST_UVIS25_REG_CTRL1_ADDR   0x20
> >> > +#define ST_UVIS25_REG_ODR_MASK             BIT(0)
> >> > +#define ST_UVIS25_REG_BDU_MASK             BIT(1)
> >> > +#define ST_UVIS25_REG_CTRL2_ADDR   0x21
> >> > +#define ST_UVIS25_REG_BOOT_MASK            BIT(7)
> >> > +
> >> > +static const struct iio_chan_spec st_uvis25_channels[] = {
> >> > +   {
> >> > +           .type = IIO_UVINDEX,
> >> > +           .address = 0x28,
> >
> > this should use a #define for the register address
> >
> 
> ack
> 
> >> > +           .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> >> > +           .scan_index = 0,
> >> > +           .scan_type = {
> >> > +                   .sign = 'u',
> >> > +                   .realbits = 8,
> >> > +                   .storagebits = 8,
> >> > +           },
> >> > +   },
> >> > +   IIO_CHAN_SOFT_TIMESTAMP(1),
> >> > +};
> >> > +
> >> > +static int st_uvis25_check_whoami(struct st_uvis25_hw *hw)
> >> > +{
> >> > +   u8 data;
> >> > +   int err;
> >> > +
> >> > +   err = hw->tf->read(hw->dev, ST_UVIS25_REG_WHOAMI_ADDR, sizeof(data),
> >> > +                      &data);
> >> > +   if (err < 0) {
> >> > +           dev_err(hw->dev, "failed to read whoami register\n");
> >> > +           return err;
> >> > +   }
> >> > +
> >> > +   if (data != ST_UVIS25_REG_WHOAMI_VAL) {
> >> > +           dev_err(hw->dev, "wrong whoami {%02x vs %02x}\n",
> >> > +                   data, ST_UVIS25_REG_WHOAMI_VAL);
> >> > +           return -ENODEV;
> >> > +   }
> >> > +
> >> > +   return 0;
> >> > +}
> >> > +
> >> > +int st_uvis25_write_with_mask(struct st_uvis25_hw *hw, u8 addr, u8 mask, u8 val)
> >> > +{
> >> > +   u8 data;
> >> > +   int err;
> >> > +
> >> > +   mutex_lock(&hw->lock);
> >>
> >> This stuff comes for free in regmap...
> >>
> >> > +
> >> > +   err = hw->tf->read(hw->dev, addr, sizeof(data), &data);
> >> > +   if (err < 0) {
> >> > +           dev_err(hw->dev, "failed to read %02x register\n", addr);
> >> > +           goto unlock;
> >> > +   }
> >> > +
> >> > +   data = (data & ~mask) | ((val << __ffs(mask)) & mask);
> >> > +
> >> > +   err = hw->tf->write(hw->dev, addr, sizeof(data), &data);
> >> > +   if (err < 0)
> >> > +           dev_err(hw->dev, "failed to write %02x register\n", addr);
> >> > +
> >> > +unlock:
> >> > +   mutex_unlock(&hw->lock);
> >> > +
> >> > +   return err < 0 ? err : 0;
> >> > +}
> >> > +
> >> > +int st_uvis25_set_enable(struct st_uvis25_hw *hw, bool enable)
> >> > +{
> >> > +   int err;
> >> > +
> >> > +   err = st_uvis25_write_with_mask(hw, ST_UVIS25_REG_CTRL1_ADDR,
> >> > +                                   ST_UVIS25_REG_ODR_MASK, enable);
> >> > +   if (err < 0)
> >> > +           return err;
> >> > +
> >> > +   hw->enabled = enable;
> >> > +
> >> > +   return 0;
> >> > +}
> >> > +
> >> > +static int st_uvis25_read_oneshot(struct st_uvis25_hw *hw, u8 addr, int *val)
> >> > +{
> >> > +   u8 data;
> >> > +   int err;
> >> > +
> >> > +   err = st_uvis25_set_enable(hw, true);
> >> > +   if (err < 0)
> >> > +           return err;
> >> > +
> >> > +   msleep(1500);
> >>
> >> Could drive this off the interrupt rather than disabling the interrupt?
> >> Would that be a little neater (simple completion here).
> >>
> >> > +
> >> > +   err = hw->tf->read(hw->dev, addr, sizeof(data), &data);
> >> > +   if (err < 0)
> >> > +           return err;
> >>
> >> Is there a potential race here if for some reason we managed to
> >> got to sleep for another conversion?  I think to be completely
> >> safe you need force an additional read after the disable (or
> >> will that fail to clear the data ready?
> >>
> >> > +
> >> > +   st_uvis25_set_enable(hw, false);
> >> > +
> >> > +   *val = data;
> >> > +
> >> > +   return IIO_VAL_INT;
> >> > +}
> >> > +
> >> > +static int st_uvis25_read_raw(struct iio_dev *iio_dev,
> >> > +                         struct iio_chan_spec const *ch,
> >> > +                         int *val, int *val2, long mask)
> >> > +{
> >> > +   int ret;
> >> > +
> >> > +   ret = iio_device_claim_direct_mode(iio_dev);
> >
> > need a lock here I think as most other drivers do
> >
> 
> iio_device_claim_direct_mode already grabs indio_dev->mlock

right, other drivers take a lock for various reasons (some before some 
after iio_device_claim_direct_mode(), hm)
 
> >> > +   if (ret)
> >> > +           return ret;
> >> > +
> >> > +   switch (mask) {
> >> > +   case IIO_CHAN_INFO_PROCESSED: {
> >> > +           struct st_uvis25_hw *hw = iio_priv(iio_dev);
> >> > +
> >> > +           /*
> >> > +            * mask irq line during oneshot read since the sensor
> >> > +            * does not export the capability to disable data-ready line
> >> > +            * in the register map and it is enabled by default.
> >> > +            * If the line is unmasked during read_raw() it will be set
> >> > +            * active and never reset since the trigger is disabled
> >> > +            */
> >>
> >> Nasty but well documented...
> >>
> >> I wonder if there is a nicer way to handle this... If we leave it on
> >> the issues is that we end up with the status being checked by the interrupt
> >> handler for the trigger (harmless if a waste of time) then the trigger
> >> being fired (with nothing associated with it).  No consumers are attached
> >> so we call notify done for all of them and finally that will result in
> >> a try reenable. You could supply one of those that results in a read
> >> to the device.  It think that would always deal with your case of
> >> the data ready getting stuck high..
> >>
> >> (Not totally sure though as it's been a while since I dealt with a
> >> sensor with this particular issue).
> >>
> >> > +           if (hw->irq > 0)
> >> > +                   disable_irq(hw->irq);
> >> > +           ret = st_uvis25_read_oneshot(hw, ch->address, val);
> >> > +           if (hw->irq > 0)
> >> > +                   enable_irq(hw->irq);
> >> > +           break;
> >> > +   }
> >> > +   default:
> >> > +           ret = -EINVAL;
> >> > +           break;
> >> > +   }
> >> > +
> >> > +   iio_device_release_direct_mode(iio_dev);
> >> > +
> >> > +   return ret;
> >> > +}
> >> > +
> >> > +static const struct iio_info st_uvis25_info = {
> >> > +   .read_raw = st_uvis25_read_raw,
> >> > +};
> >> > +
> >> > +static const unsigned long st_uvis25_scan_masks[] = { 0x1, 0x0 };
> >> > +
> >> > +static int st_uvis25_init_sensor(struct st_uvis25_hw *hw)
> >> > +{
> >> > +   int err;
> >> > +
> >> > +   err = st_uvis25_write_with_mask(hw, ST_UVIS25_REG_CTRL2_ADDR,
> >> > +                                   ST_UVIS25_REG_BOOT_MASK, 1);
> >> > +   if (err < 0)
> >> > +           return err;
> >> > +
> >> > +   msleep(2000);
> >> > +
> >> > +   return st_uvis25_write_with_mask(hw, ST_UVIS25_REG_CTRL1_ADDR,
> >> > +                                    ST_UVIS25_REG_BDU_MASK, 1);
> >> > +}
> >> > +
> >> > +int st_uvis25_probe(struct device *dev, int irq,
> >> > +               const struct st_uvis25_transfer_function *tf_ops)
> >> > +{
> >> > +   struct st_uvis25_hw *hw;
> >> > +   struct iio_dev *iio_dev;
> >> > +   int err;
> >> > +
> >> > +   iio_dev = devm_iio_device_alloc(dev, sizeof(*hw));
> >> > +   if (!iio_dev)
> >> > +           return -ENOMEM;
> >> > +
> >> > +   dev_set_drvdata(dev, (void *)iio_dev);
> >> > +
> >> > +   hw = iio_priv(iio_dev);
> >> > +   hw->dev = dev;
> >> > +   hw->irq = irq;
> >> > +   hw->tf = tf_ops;
> >> > +
> >> > +   mutex_init(&hw->lock);
> >> > +
> >> > +   err = st_uvis25_check_whoami(hw);
> >> > +   if (err < 0)
> >> > +           return err;
> >> > +
> >> > +   iio_dev->modes = INDIO_DIRECT_MODE;
> >> > +   iio_dev->dev.parent = hw->dev;
> >> > +   iio_dev->available_scan_masks = st_uvis25_scan_masks;
> >
> > I wonder if available_scan_masks are needed as there is only one
> > channel... what for?
> >
> 
> ack
> 
> >> > +   iio_dev->channels = st_uvis25_channels;
> >> > +   iio_dev->num_channels = ARRAY_SIZE(st_uvis25_channels);
> >> > +   iio_dev->name = ST_UVIS25_DEV_NAME;
> >> > +   iio_dev->info = &st_uvis25_info;
> >> > +
> >> > +   err = st_uvis25_init_sensor(hw);
> >> > +   if (err < 0)
> >> > +           return err;
> >> > +
> >> > +   if (hw->irq > 0) {
> >> > +           err = st_uvis25_allocate_buffer(iio_dev);
> >> > +           if (err < 0)
> >> > +                   return err;
> >> > +
> >> > +           err = st_uvis25_allocate_trigger(iio_dev);
> >> > +           if (err)
> >> > +                   return err;
> >> > +   }
> >> > +
> >> > +   return devm_iio_device_register(hw->dev, iio_dev);
> >> > +}
> >> > +EXPORT_SYMBOL(st_uvis25_probe);
> >> > +
> >> > +static int __maybe_unused st_uvis25_suspend(struct device *dev)
> >> > +{
> >> > +   struct iio_dev *iio_dev = dev_get_drvdata(dev);
> >> > +   struct st_uvis25_hw *hw = iio_priv(iio_dev);
> >> > +
> >> > +   return st_uvis25_write_with_mask(hw, ST_UVIS25_REG_CTRL1_ADDR,
> >> > +                                    ST_UVIS25_REG_ODR_MASK, 0);
> >> > +}
> >> > +
> >> > +static int __maybe_unused st_uvis25_resume(struct device *dev)
> >> > +{
> >> > +   struct iio_dev *iio_dev = dev_get_drvdata(dev);
> >> > +   struct st_uvis25_hw *hw = iio_priv(iio_dev);
> >> > +   int err = 0;
> >> > +
> >> > +   if (hw->enabled)
> >> > +           err = st_uvis25_write_with_mask(hw, ST_UVIS25_REG_CTRL1_ADDR,
> >> > +                                           ST_UVIS25_REG_ODR_MASK, 1);
> >> > +
> >> > +   return err;
> >> > +}
> >> > +
> >> > +const struct dev_pm_ops st_uvis25_pm_ops = {
> >> > +   SET_SYSTEM_SLEEP_PM_OPS(st_uvis25_suspend, st_uvis25_resume)
> >> > +};
> >> > +EXPORT_SYMBOL(st_uvis25_pm_ops);
> >> > +
> >> > +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
> >> > +MODULE_DESCRIPTION("STMicroelectronics uvis25 sensor driver");
> >> > +MODULE_LICENSE("GPL v2");
> >> > diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
> >> > new file mode 100644
> >> > index 000000000000..0d70d866a190
> >> > --- /dev/null
> >> > +++ b/drivers/iio/light/st_uvis25_i2c.c
> >> > @@ -0,0 +1,76 @@
> >> > +/*
> >> > + * STMicroelectronics uvis25 i2c driver
> >> > + *
> >> > + * Copyright 2017 STMicroelectronics Inc.
> >> > + *
> >> > + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> >> > + *
> >> > + * Licensed under the GPL-2.
> >> > + */
> >> > +
> >> > +#include <linux/kernel.h>
> >> > +#include <linux/module.h>
> >> > +#include <linux/acpi.h>
> >> > +#include <linux/i2c.h>
> >> > +#include <linux/slab.h>
> >> > +
> >> > +#include "st_uvis25.h"
> >> > +
> >> > +#define I2C_AUTO_INCREMENT 0x80
> >> > +
> >> > +static int st_uvis25_i2c_read(struct device *dev, u8 addr, int len, u8 *data)
> >> > +{
> >> > +   if (len > 1)
> >> > +           addr |= I2C_AUTO_INCREMENT;
> >> > +
> >> > +   return i2c_smbus_read_i2c_block_data_or_emulated(to_i2c_client(dev),
> >> > +                                                    addr, len, data);
> >> > +}
> >> > +
> >> > +static int st_uvis25_i2c_write(struct device *dev, u8 addr, int len, u8 *data)
> >> > +{
> >> > +   if (len > 1)
> >> > +           addr |= I2C_AUTO_INCREMENT;
> >> > +
> >> > +   return i2c_smbus_write_i2c_block_data(to_i2c_client(dev), addr,
> >> > +                                         len, data);
> >> > +}
> >> > +
> >> > +static const struct st_uvis25_transfer_function st_uvis25_transfer_fn = {
> >> > +   .read = st_uvis25_i2c_read,
> >> > +   .write = st_uvis25_i2c_write,
> >> > +};
> >> > +
> >> > +static int st_uvis25_i2c_probe(struct i2c_client *client,
> >> > +                          const struct i2c_device_id *id)
> >> > +{
> >> > +   return st_uvis25_probe(&client->dev, client->irq,
> >> > +                          &st_uvis25_transfer_fn);
> >> > +}
> >> > +
> >> > +static const struct of_device_id st_uvis25_i2c_of_match[] = {
> >> > +   { .compatible = "st,uvis25", },
> >> > +   {},
> >> > +};
> >> > +MODULE_DEVICE_TABLE(of, st_uvis25_i2c_of_match);
> >> > +
> >> > +static const struct i2c_device_id st_uvis25_i2c_id_table[] = {
> >> > +   { ST_UVIS25_DEV_NAME },
> >> > +   {},
> >> > +};
> >> > +MODULE_DEVICE_TABLE(i2c, st_uvis25_i2c_id_table);
> >> > +
> >> > +static struct i2c_driver st_uvis25_driver = {
> >> > +   .driver = {
> >> > +           .name = "st_uvis25_i2c",
> >> > +           .pm = &st_uvis25_pm_ops,
> >> > +           .of_match_table = of_match_ptr(st_uvis25_i2c_of_match),
> >> > +   },
> >> > +   .probe = st_uvis25_i2c_probe,
> >> > +   .id_table = st_uvis25_i2c_id_table,
> >> > +};
> >> > +module_i2c_driver(st_uvis25_driver);
> >> > +
> >> > +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
> >> > +MODULE_DESCRIPTION("STMicroelectronics uvis25 i2c driver");
> >> > +MODULE_LICENSE("GPL v2");
> >> > diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
> >> > new file mode 100644
> >> > index 000000000000..be67d9e7564b
> >> > --- /dev/null
> >> > +++ b/drivers/iio/light/st_uvis25_spi.c
> >> > @@ -0,0 +1,109 @@
> >> > +/*
> >> > + * STMicroelectronics uvis25 spi driver
> >> > + *
> >> > + * Copyright 2017 STMicroelectronics Inc.
> >> > + *
> >> > + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> >> > + *
> >> > + * Licensed under the GPL-2.
> >> > + */
> >> > +
> >> > +#include <linux/kernel.h>
> >> > +#include <linux/module.h>
> >> > +#include <linux/spi/spi.h>
> >> > +#include <linux/slab.h>
> >> > +
> >> > +#include "st_uvis25.h"
> >> > +
> >> > +#define SENSORS_SPI_READ   0x80
> >> > +#define SPI_AUTO_INCREMENT 0x40
> >> > +
> >> > +static int st_uvis25_spi_read(struct device *dev, u8 addr, int len, u8 *data)
> >>
> >> Hmm.. Maybe a good case for regmap?
> >>
> >> > +{
> >> > +   struct spi_device *spi = to_spi_device(dev);
> >> > +   struct iio_dev *iio_dev = spi_get_drvdata(spi);
> >> > +   struct st_uvis25_hw *hw = iio_priv(iio_dev);
> >> > +   int err;
> >> > +
> >> > +   struct spi_transfer xfers[] = {
> >> > +           {
> >> > +                   .tx_buf = hw->tb.tx_buf,
> >> > +                   .bits_per_word = 8,
> >> > +                   .len = 1,
> >> > +           },
> >> > +           {
> >> > +                   .rx_buf = hw->tb.rx_buf,
> >> > +                   .bits_per_word = 8,
> >> > +                   .len = len,
> >> > +           }
> >> > +   };
> >> > +
> >> > +   if (len > 1)
> >> > +           addr |= SPI_AUTO_INCREMENT;
> >> > +   hw->tb.tx_buf[0] = addr | SENSORS_SPI_READ;
> >> > +
> >> > +   err = spi_sync_transfer(spi, xfers,  ARRAY_SIZE(xfers));
> >> > +   if (err < 0)
> >> > +           return err;
> >> > +
> >> > +   memcpy(data, hw->tb.rx_buf, len * sizeof(u8));
> >> > +
> >> > +   return len;
> >> > +}
> >> > +
> >> > +static int st_uvis25_spi_write(struct device *dev, u8 addr, int len, u8 *data)
> >> > +{
> >> > +   struct iio_dev *iio_dev;
> >> > +   struct st_uvis25_hw *hw;
> >> > +   struct spi_device *spi;
> >> > +
> >> > +   if (len >= ST_UVIS25_TX_MAX_LENGTH)
> >> > +           return -ENOMEM;
> >> > +
> >> > +   spi = to_spi_device(dev);
> >> > +   iio_dev = spi_get_drvdata(spi);
> >> > +   hw = iio_priv(iio_dev);
> >> Could could just explicitly have the elements of this chain
> >> that are used in local variables.
> >>
> >> hw = iio_priv(spi_get_drvdata(spi));
> >>
> >> up to you though..
> >> > +
> >> > +   hw->tb.tx_buf[0] = addr;
> >> > +   memcpy(&hw->tb.tx_buf[1], data, len);
> >> > +
> >> > +   return spi_write(spi, hw->tb.tx_buf, len + 1);
> >> > +}
> >> > +
> >> > +static const struct st_uvis25_transfer_function st_uvis25_transfer_fn = {
> >> > +   .read = st_uvis25_spi_read,
> >> > +   .write = st_uvis25_spi_write,
> >> > +};
> >> > +
> >> > +static int st_uvis25_spi_probe(struct spi_device *spi)
> >> > +{
> >> > +   return st_uvis25_probe(&spi->dev, spi->irq,
> >> > +                          &st_uvis25_transfer_fn);
> >> > +}
> >> > +
> >> > +static const struct of_device_id st_uvis25_spi_of_match[] = {
> >> > +   { .compatible = "st,uvis25", },
> >> > +   {},
> >> > +};
> >> > +MODULE_DEVICE_TABLE(of, st_uvis25_spi_of_match);
> >> > +
> >> > +static const struct spi_device_id st_uvis25_spi_id_table[] = {
> >> > +   { ST_UVIS25_DEV_NAME },
> >> > +   {},
> >> > +};
> >> > +MODULE_DEVICE_TABLE(spi, st_uvis25_spi_id_table);
> >> > +
> >> > +static struct spi_driver st_uvis25_driver = {
> >> > +   .driver = {
> >> > +           .name = "st_uvis25_spi",
> >> > +           .pm = &st_uvis25_pm_ops,
> >> > +           .of_match_table = of_match_ptr(st_uvis25_spi_of_match),
> >> > +   },
> >> > +   .probe = st_uvis25_spi_probe,
> >> > +   .id_table = st_uvis25_spi_id_table,
> >> > +};
> >> > +module_spi_driver(st_uvis25_driver);
> >> > +
> >> > +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
> >> > +MODULE_DESCRIPTION("STMicroelectronics uvis25 spi driver");
> >> > +MODULE_LICENSE("GPL v2");
> >
> > --
> >
> > Peter Meerwald-Stadler
> > Mobile: +43 664 24 44 418
> 
> 
> 
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
