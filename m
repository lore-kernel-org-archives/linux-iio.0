Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58307 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab3JAPIt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 11:08:49 -0400
Message-ID: <524AF3AA.9060801@kernel.org>
Date: Tue, 01 Oct 2013 17:09:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lukasz Czerwinski <l.czerwinski@samsung.com>, jic23@cam.ac.uk
CC: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: Re: [RFC v2 PATCH 06/14] iio: st_common: Add threshold events support
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com> <1380299538-22047-7-git-send-email-l.czerwinski@samsung.com>
In-Reply-To: <1380299538-22047-7-git-send-email-l.czerwinski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/27/13 17:32, Lukasz Czerwinski wrote:
> This patch adds threshold events support for the ST common
> library.
>
> Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Hi Lukasz,

Note that we are moving over to a more adaptable way of event registration.
This driver will need updating to match that, but this review is conducted
against the old method.

If you are happy to do the update, that's great. If not such is life and
someone else will have to pick it up before we can drop the old method.

A few minor bits inline.
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c |  209 ++++++++++++++++++++++-
>  include/linux/iio/common/st_sensors.h           |   74 ++++++++
>  2 files changed, 282 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 697b16d..98fb425 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -13,7 +13,9 @@
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
>  #include <asm/unaligned.h>
> +#include <linux/interrupt.h>
>
>  #include <linux/iio/common/st_sensors.h>
>
> @@ -339,7 +341,12 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
>
>  		*val = *val >> ch->scan_type.shift;
>
> -		err = st_sensors_set_enable(indio_dev, false);
> +		/*
> +		 * When events are enabled sensor should be always enabled.
> +		 * It prevents unnecessary sensor off.
> +		 */
> +		if (!sdata->events_flag)
> +			err = st_sensors_set_enable(indio_dev, false);
>  	}
>  out:
>  	mutex_unlock(&indio_dev->mlock);
> @@ -465,6 +472,206 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
>  }
>  EXPORT_SYMBOL(st_sensors_sysfs_scale_avail);
>
This should get simpler after Lars' series but will still be a little
ugly. Ah well, only occurs in relatively slow paths.

> +static struct st_sensor_event *st_sensor_find_event_data(struct
> +		st_sensor_data * sdata, u64 event_code)
> +{
> +	int mod = IIO_EVENT_CODE_EXTRACT_MODIFIER(event_code);
> +	int chan_type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code);
> +	int type = IIO_EVENT_CODE_EXTRACT_TYPE(event_code);
> +	int dir = IIO_EVENT_CODE_EXTRACT_DIR(event_code);
> +	struct st_sensor_event_irq *irq = &sdata->sensor->event_irq;
> +	struct st_sensor_event *event;
> +	int i;
> +
If either of these two tests fails and you get here, hasn't
something gone horribly wrong?
> +	if (!irq)
> +		return NULL;
> +
> +	if (irq->event_count == 0)
> +		return NULL;
> +
> +	for (i = 0; i < irq->event_count; i++) {
> +		event = &irq->events[i];
> +
> +		if (event->modifier == mod &&
> +			event->chan_type == chan_type &&
> +			event->event_type == type &&
> +			event->direction == dir)
> +				return event;
> +	}
> +	return NULL;
> +}
> +
> +int st_sensors_read_event_config(struct iio_dev *indio_dev,
> +				u64 event_code)
> +{
> +	struct st_sensor_data *sdata  = iio_priv(indio_dev);
> +	struct st_sensor_event *event =
> +		st_sensor_find_event_data(sdata, event_code);
> +
> +	if (!event || !sdata->events_enabled)
> +		return -EINVAL;
> +
> +	return (bool)(sdata->events_flag & (1 << event->bit));
> +}
> +EXPORT_SYMBOL(st_sensors_read_event_config);
> +
> +int st_sensors_write_event_config(struct iio_dev *indio_dev,
> +				  u64 event_code,
> +				  int state)
> +{
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	struct st_sensor_event *event =
> +		st_sensor_find_event_data(sdata, event_code);
> +	int unsigned mask;
> +	int err;
> +
> +	if (!event | !sdata->events_enabled)
> +		return -EINVAL;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	mask = (1 << event->bit);
> +	err =  st_sensors_write_data_with_mask(indio_dev,
> +			sdata->sensor->event_irq.ctrl_reg.addr,
> +			mask, (bool)state);
> +	if (err < 0)
> +		goto exit;
> +
> +	if (state)
> +		sdata->events_flag |= mask;
> +	else
> +		sdata->events_flag &= ~mask;
> +
> +	err = st_sensors_set_enable(indio_dev, (bool)sdata->events_flag);
> +
> +exit:
> +	mutex_unlock(&indio_dev->mlock);
> +	return err;
> +}
> +EXPORT_SYMBOL(st_sensors_write_event_config);
> +
> +int st_sensors_read_event_value(struct iio_dev *indio_dev,
> +				  u64 event_code,
> +				  int *val)
> +{
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	struct st_sensor_event *event =
> +		st_sensor_find_event_data(sdata, event_code);
> +	u8 byte;
> +	int err;
> +
> +	if (!event | !sdata->events_enabled)
> +		return -EINVAL;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	err = sdata->tf->read_byte(&sdata->tb, sdata->dev,
> +			event->event_ths_reg.addr, &byte);
> +	if (!err)
> +		*val = byte;
> +
> +	mutex_unlock(&indio_dev->mlock);
> +	return err;
> +}
> +EXPORT_SYMBOL(st_sensors_read_event_value);
> +
> +int st_sensors_write_event_value(struct iio_dev *indio_dev,
> +				  u64 event_code,
> +				  int val)
> +{
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	struct st_sensor_event *event =
> +		st_sensor_find_event_data(sdata, event_code);
> +	int err;
> +
> +	if (!event | !sdata->events_enabled)
> +		return -EINVAL;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	err =  st_sensors_write_data_with_mask(indio_dev,
> +			event->event_ths_reg.addr,
> +			event->event_ths_reg.mask,
> +			(u8)val);
> +
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(st_sensors_write_event_value);
> +
> +static irqreturn_t st_sensor_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	struct st_sensor_event_irq *irq_data =
> +		&sdata->sensor->event_irq;
> +	struct st_sensor_event *event;
> +	s64 timestamp = iio_get_time_ns();
> +	u8 status, mask, i;
> +	int err = -EIO;
> +
I'm a little worried by this.  How would we ever get here
without sdata pointing anywhere?  If this is dropped,
remember to drop the -EIO above as well.

> +	if (sdata)
> +		err = sdata->tf->read_byte(&sdata->tb,
> +				sdata->dev,
> +				irq_data->status_reg.addr,
> +				&status);
> +
> +	if (err < 0)
  	   	return IRQ_HANDLED;
> +		goto exit;
> +
> +	for (i = 0; i < irq_data->event_count; i++) {
> +		event = &irq_data->events[i];
> +		mask = (1 << event->bit);
> +		if (status & mask)
> +			iio_push_event(indio_dev,
> +				IIO_MOD_EVENT_CODE(event->chan_type,
> +					0,
> +					event->modifier,
> +					event->event_type,
> +					event->direction),
> +				timestamp);
> +	}
> +
> +exit:
> +	return IRQ_HANDLED;
> +}
> +
> +int st_sensors_request_event_irq(struct iio_dev *indio_dev)
> +{
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +
> +	return request_threaded_irq(sdata->get_irq_event(indio_dev),
> +			NULL,
> +			st_sensor_event_handler,
> +			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
Naming wise, the device name is a bit generic, perhaps
have  -event on the end?

Also, for symmetry I'd normally expect to see a matching
st_sensors_free_event_irq.

Clearly it would be trivial, but it make the code more
'obviously' right which is always a good thing.

> +			dev_name(&indio_dev->dev),
> +			indio_dev);
> +}
> +
> +int st_sensors_enable_events(struct iio_dev *indio_dev)
> +{
> +	int err;
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	struct st_sensor_event_irq *irq = &sdata->sensor->event_irq;
> +
> +	err = st_sensors_write_data_with_mask(indio_dev,
> +			irq->addr,
> +			irq->mask,
> +			1);
> +
> +	if (err < 0)
  	return err; is cleaner here rather than the goto given
there is no cleaning up to do.
> +		goto error;
> +
> +	err = st_sensors_write_data_with_mask(indio_dev,
> +			irq->ctrl_reg.addr,
> +			irq->ctrl_reg.mask,
> +			irq->ctrl_reg.val);
> +error:
> +	return err;
> +}
> +EXPORT_SYMBOL(st_sensors_enable_events);
> +
>  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>  MODULE_DESCRIPTION("STMicroelectronics ST-sensors core");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 3f4a0f7..178dec8 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -14,6 +14,7 @@
>  #include <linux/i2c.h>
>  #include <linux/spi/spi.h>
>  #include <linux/irqreturn.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/bitops.h>
>  #include <linux/regulator/consumer.h>
> @@ -25,6 +26,7 @@
>
>  #define ST_SENSORS_ODR_LIST_MAX			10
>  #define ST_SENSORS_FULLSCALE_AVL_MAX		10
> +#define ST_SENSORS_EVENTS_MAX			10
>
>  #define ST_SENSORS_NUMBER_ALL_CHANNELS		4
>  #define ST_SENSORS_ENABLE_ALL_AXIS		0x07
> @@ -47,6 +49,10 @@
>  #define ST_SENSORS_DRDY_IRQ_NAME		"drdy-int"
>  #define ST_SENSORS_EVENT_IRQ_NAME		"event-int"
>
> +#define ST_SENSORS_LSM_EVENT_MASK \
> +		(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) | \
> +		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
> +
>  #define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
>  					ch2, s, endian, rbits, sbits, addr) \
>  { \
> @@ -63,6 +69,7 @@
>  		.storagebits = sbits, \
>  		.endianness = endian, \
>  	}, \
> +	.event_mask = ST_SENSORS_LSM_EVENT_MASK, \
>  }
>
>  #define ST_SENSOR_DEV_ATTR_SAMP_FREQ() \
> @@ -114,6 +121,12 @@ struct st_sensor_fullscale {
>  	struct st_sensor_fullscale_avl fs_avl[ST_SENSORS_FULLSCALE_AVL_MAX];
>  };
>
> +struct st_sensor_register {
> +	u8 addr;
> +	u8 mask;
> +	u8 val;
> +};
> +
>  /**
>   * struct st_sensor_bdu - ST sensor device block data update
>   * @addr: address of the register.
> @@ -144,6 +157,46 @@ struct st_sensor_data_ready_irq {
>  };
>
>  /**
> + * struct st_sensor_event - event data.
> + * @bit: position of bit in status register related to event
> + * @chan: channel number.
> + * @chan_type: channel type.
> + * @modifier: modifier for the channel.
> + * @event_type: type of the event.
> + * @direction: direction of the event.
> + * @event_ths_reg:  represents the threshold
> + *	register of event.
> + */
> +struct st_sensor_event {
> +	u8 bit;

The approach used in Lars' new approach to the
event callbacks makes this simpler by using
a pointer to the relevant channel.  Otherwise
this is very similar which should make lifte
easy when converting over.

> +	enum iio_chan_type chan_type;
> +	enum iio_modifier modifier;
> +	enum iio_event_type event_type;
> +	enum iio_event_direction direction;
> +	struct st_sensor_register event_ths_reg;
> +};
> +
> +/**
> + * struct st_sensor_event_irq -ST sensor event interrupt.
> + * @addr: address of the interrupt register.
> + * @mask: mask to write on/off value.
> + * @event_count: number of events declared in @events array.
> + * @ctrl_reg: represents the control register
> + *	of event system
> + * @status_reg: status register of event subsystem.
> + * @events array: driver events declared by user
> + */
> +struct st_sensor_event_irq {
> +	u8 addr;
> +	u8 mask;
> +	u8 event_count;
> +	struct st_sensor_register ctrl_reg;
> +	struct st_sensor_register status_reg;
> +	struct st_sensor_event events[ST_SENSORS_EVENTS_MAX];
> +};
> +
One blank line is all that is needed here.
> +
> +/**
>   * struct st_sensor_transfer_buffer - ST sensor device I/O buffer
>   * @buf_lock: Mutex to protect rx and tx buffers.
>   * @tx_buf: Buffer used by SPI transfer function to send data to the sensors.
> @@ -184,6 +237,7 @@ struct st_sensor_transfer_function {
>   * @fs: Full scale register and full scale list available.
>   * @bdu: Block data update register.
>   * @drdy_irq: Data ready register of the sensor.
> + * @event_irq: Event register of the sensor.
>   * @multi_read_bit: Use or not particular bit for [I2C/SPI] multi-read.
>   * @bootime: samples to discard when sensor passing from power-down to power-up.
>   */
> @@ -198,6 +252,7 @@ struct st_sensors {
>  	struct st_sensor_fullscale fs;
>  	struct st_sensor_bdu bdu;
>  	struct st_sensor_data_ready_irq drdy_irq;
> +	struct st_sensor_event_irq event_irq;
>  	bool multi_read_bit;
>  	unsigned int bootime;
>  };
> @@ -212,9 +267,11 @@ struct st_sensors {
>   * @vdd_io: Pointer to sensor's Vdd-IO power supply
>   * @enabled: Status of the sensor (false->off, true->on).
>   * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
> + * @events_enable: Status of the sensor events (false->off, true->on).
>   * @buffer_data: Data used by buffer part.
>   * @odr: Output data rate of the sensor [Hz].
>   * num_data_channels: Number of data channels used in buffer.
> + * @events_flag: Data used by event part.
>   * @irq_map: Container of mapped IRQs.
>   * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
>   * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
> @@ -232,11 +289,13 @@ struct st_sensor_data {
>
>  	bool enabled;
>  	bool multiread_bit;
> +	bool events_enabled;
>
>  	char *buffer_data;
>
>  	unsigned int odr;
>  	unsigned int num_data_channels;
> +	unsigned int events_flag;
>  	unsigned int irq_map[ST_SENSORS_INT_MAX];
>
>  	u8 drdy_int_pin;
> @@ -302,4 +361,19 @@ ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
>  ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
>  				struct device_attribute *attr, char *buf);
>
> +int st_sensors_read_event_config(struct iio_dev *indio_dev,
> +				u64 event_code);
> +
> +int st_sensors_write_event_config(struct iio_dev *indio_dev,
> +				  u64 event_code, int state);
> +
> +int st_sensors_read_event_value(struct iio_dev *indio_dev,
> +				  u64 event_code, int *val);
> +
> +int st_sensors_write_event_value(struct iio_dev *indio_dev,
> +				  u64 event_code, int val);
> +
> +int st_sensors_request_event_irq(struct iio_dev *indio_dev);
> +
> +int st_sensors_enable_events(struct iio_dev *indio_dev);
>  #endif /* ST_SENSORS_H */
>
