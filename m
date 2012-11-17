Return-Path: <jic23@kernel.org>
Message-ID: <50A77657.8010004@kernel.org>
Date: Sat, 17 Nov 2012 11:34:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 drivers@analog.com
Subject: Re: [PATCH 4/5] staging:iio:ad7298: Squash everything into one file
References: <1352985328-24322-1-git-send-email-lars@metafoo.de> <1352985328-24322-4-git-send-email-lars@metafoo.de> <50A772E4.60600@kernel.org>
In-Reply-To: <50A772E4.60600@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/17/2012 11:20 AM, Jonathan Cameron wrote:
> On 11/15/2012 01:15 PM, Lars-Peter Clausen wrote:
>> The recent cleanups have decimated the drivers code size by quite a bit. It is
>> only a few hundred lines in total now. Putting everything into one file also
>> allows to reduce the code size a bit more by removing a few lines of boilerplate
>> code. The only functional change made by this patch is that we now always
>> include buffer support, instead of making it optional. This is more consistent
>> with what we do for other drivers.
>>
> added to togreg branch of iio.git
Actually scratch that - my build test hadn't finished and I jumped the gun.

You have a reference to ad7887 bleeding in from somewhere in the makefile.
I've fixed it up before pushing out


>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  drivers/staging/iio/adc/Kconfig                    |   3 +-
>>  drivers/staging/iio/adc/Makefile                   |   3 +-
>>  .../staging/iio/adc/{ad7298_core.c => ad7298.c}    | 121 ++++++++++++++++++++-
>>  drivers/staging/iio/adc/ad7298.h                   |  53 ---------
>>  drivers/staging/iio/adc/ad7298_ring.c              | 108 ------------------
>>  5 files changed, 121 insertions(+), 167 deletions(-)
>>  rename drivers/staging/iio/adc/{ad7298_core.c => ad7298.c} (64%)
>>  delete mode 100644 drivers/staging/iio/adc/ad7298_ring.c
>>
>> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
>> index 0177f1e..5086a46 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -13,7 +13,8 @@ config AD7291
>>  config AD7298
>>  	tristate "Analog Devices AD7298 ADC driver"
>>  	depends on SPI
>> -	select IIO_TRIGGERED_BUFFER if IIO_BUFFER
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>>  	help
>>  	  Say yes here to build support for Analog Devices AD7298
>>  	  8 Channel ADC with temperature sensor.
>> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
>> index 12b4bd3..e867d01 100644
>> --- a/drivers/staging/iio/adc/Makefile
>> +++ b/drivers/staging/iio/adc/Makefile
>> @@ -12,8 +12,7 @@ ad799x-y := ad799x_core.o
>>  ad799x-$(CONFIG_AD799X_RING_BUFFER) += ad799x_ring.o
>>  obj-$(CONFIG_AD799X) += ad799x.o
>>  
>> -ad7298-y := ad7298_core.o
>> -ad7298-$(CONFIG_IIO_BUFFER) += ad7298_ring.o
>> +obj-$(CONFIG_AD7887) += ad7887.o
>>  obj-$(CONFIG_AD7298) += ad7298.o
>>  
>>  obj-$(CONFIG_AD7291) += ad7291.o
>> diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298.c
>> similarity index 64%
>> rename from drivers/staging/iio/adc/ad7298_core.c
>> rename to drivers/staging/iio/adc/ad7298.c
>> index b74b76f..2742a9d 100644
>> --- a/drivers/staging/iio/adc/ad7298_core.c
>> +++ b/drivers/staging/iio/adc/ad7298.c
>> @@ -15,13 +15,49 @@
>>  #include <linux/err.h>
>>  #include <linux/delay.h>
>>  #include <linux/module.h>
>> +#include <linux/interrupt.h>
>>  
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>>  #include <linux/iio/buffer.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>>  
>>  #include "ad7298.h"
>>  
>> +#define AD7298_WRITE	(1 << 15) /* write to the control register */
>> +#define AD7298_REPEAT	(1 << 14) /* repeated conversion enable */
>> +#define AD7298_CH(x)	(1 << (13 - (x))) /* channel select */
>> +#define AD7298_TSENSE	(1 << 5) /* temperature conversion enable */
>> +#define AD7298_EXTREF	(1 << 2) /* external reference enable */
>> +#define AD7298_TAVG	(1 << 1) /* temperature sensor averaging enable */
>> +#define AD7298_PDD	(1 << 0) /* partial power down enable */
>> +
>> +#define AD7298_MAX_CHAN		8
>> +#define AD7298_BITS		12
>> +#define AD7298_STORAGE_BITS	16
>> +#define AD7298_INTREF_mV	2500
>> +
>> +#define AD7298_CH_TEMP		9
>> +
>> +#define RES_MASK(bits)	((1 << (bits)) - 1)
>> +
>> +struct ad7298_state {
>> +	struct spi_device		*spi;
>> +	struct regulator		*reg;
>> +	unsigned			ext_ref;
>> +	struct spi_transfer		ring_xfer[10];
>> +	struct spi_transfer		scan_single_xfer[3];
>> +	struct spi_message		ring_msg;
>> +	struct spi_message		scan_single_msg;
>> +	/*
>> +	 * DMA (thus cache coherency maintenance) requires the
>> +	 * transfer buffers to live in their own cache lines.
>> +	 */
>> +	unsigned short			rx_buf[12] ____cacheline_aligned;
>> +	unsigned short			tx_buf[2];
>> +};
>> +
>>  #define AD7298_V_CHAN(index)						\
>>  	{								\
>>  		.type = IIO_VOLTAGE,					\
>> @@ -66,6 +102,84 @@ static const struct iio_chan_spec ad7298_channels[] = {
>>  	IIO_CHAN_SOFT_TIMESTAMP(8),
>>  };
>>  
>> +/**
>> + * ad7298_update_scan_mode() setup the spi transfer buffer for the new scan mask
>> + **/
>> +static int ad7298_update_scan_mode(struct iio_dev *indio_dev,
>> +	const unsigned long *active_scan_mask)
>> +{
>> +	struct ad7298_state *st = iio_priv(indio_dev);
>> +	int i, m;
>> +	unsigned short command;
>> +	int scan_count;
>> +
>> +	/* Now compute overall size */
>> +	scan_count = bitmap_weight(active_scan_mask, indio_dev->masklength);
>> +
>> +	command = AD7298_WRITE | st->ext_ref;
>> +
>> +	for (i = 0, m = AD7298_CH(0); i < AD7298_MAX_CHAN; i++, m >>= 1)
>> +		if (test_bit(i, active_scan_mask))
>> +			command |= m;
>> +
>> +	st->tx_buf[0] = cpu_to_be16(command);
>> +
>> +	/* build spi ring message */
>> +	st->ring_xfer[0].tx_buf = &st->tx_buf[0];
>> +	st->ring_xfer[0].len = 2;
>> +	st->ring_xfer[0].cs_change = 1;
>> +	st->ring_xfer[1].tx_buf = &st->tx_buf[1];
>> +	st->ring_xfer[1].len = 2;
>> +	st->ring_xfer[1].cs_change = 1;
>> +
>> +	spi_message_init(&st->ring_msg);
>> +	spi_message_add_tail(&st->ring_xfer[0], &st->ring_msg);
>> +	spi_message_add_tail(&st->ring_xfer[1], &st->ring_msg);
>> +
>> +	for (i = 0; i < scan_count; i++) {
>> +		st->ring_xfer[i + 2].rx_buf = &st->rx_buf[i];
>> +		st->ring_xfer[i + 2].len = 2;
>> +		st->ring_xfer[i + 2].cs_change = 1;
>> +		spi_message_add_tail(&st->ring_xfer[i + 2], &st->ring_msg);
>> +	}
>> +	/* make sure last transfer cs_change is not set */
>> +	st->ring_xfer[i + 1].cs_change = 0;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ad7298_trigger_handler() bh of trigger launched polling to ring buffer
>> + *
>> + * Currently there is no option in this driver to disable the saving of
>> + * timestamps within the ring.
>> + **/
>> +static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct ad7298_state *st = iio_priv(indio_dev);
>> +	s64 time_ns = 0;
>> +	int b_sent;
>> +
>> +	b_sent = spi_sync(st->spi, &st->ring_msg);
>> +	if (b_sent)
>> +		goto done;
>> +
>> +	if (indio_dev->scan_timestamp) {
>> +		time_ns = iio_get_time_ns();
>> +		memcpy((u8 *)st->rx_buf + indio_dev->scan_bytes - sizeof(s64),
>> +			&time_ns, sizeof(time_ns));
>> +	}
>> +
>> +	iio_push_to_buffers(indio_dev, (u8 *)st->rx_buf);
>> +
>> +done:
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>  static int ad7298_scan_direct(struct ad7298_state *st, unsigned ch)
>>  {
>>  	int ret;
>> @@ -231,7 +345,8 @@ static int __devinit ad7298_probe(struct spi_device *spi)
>>  	spi_message_add_tail(&st->scan_single_xfer[1], &st->scan_single_msg);
>>  	spi_message_add_tail(&st->scan_single_xfer[2], &st->scan_single_msg);
>>  
>> -	ret = ad7298_register_ring_funcs_and_init(indio_dev);
>> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>> +			&ad7298_trigger_handler, NULL);
>>  	if (ret)
>>  		goto error_disable_reg;
>>  
>> @@ -242,7 +357,7 @@ static int __devinit ad7298_probe(struct spi_device *spi)
>>  	return 0;
>>  
>>  error_cleanup_ring:
>> -	ad7298_ring_cleanup(indio_dev);
>> +	iio_triggered_buffer_cleanup(indio_dev);
>>  error_disable_reg:
>>  	if (st->ext_ref)
>>  		regulator_disable(st->reg);
>> @@ -261,7 +376,7 @@ static int __devexit ad7298_remove(struct spi_device *spi)
>>  	struct ad7298_state *st = iio_priv(indio_dev);
>>  
>>  	iio_device_unregister(indio_dev);
>> -	ad7298_ring_cleanup(indio_dev);
>> +	iio_triggered_buffer_cleanup(indio_dev);
>>  	if (st->ext_ref) {
>>  		regulator_disable(st->reg);
>>  		regulator_put(st->reg);
>> diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
>> index 6523e01..c8ac969 100644
>> --- a/drivers/staging/iio/adc/ad7298.h
>> +++ b/drivers/staging/iio/adc/ad7298.h
>> @@ -9,23 +9,6 @@
>>  #ifndef IIO_ADC_AD7298_H_
>>  #define IIO_ADC_AD7298_H_
>>  
>> -#define AD7298_WRITE	(1 << 15) /* write to the control register */
>> -#define AD7298_REPEAT	(1 << 14) /* repeated conversion enable */
>> -#define AD7298_CH(x)	(1 << (13 - (x))) /* channel select */
>> -#define AD7298_TSENSE	(1 << 5) /* temperature conversion enable */
>> -#define AD7298_EXTREF	(1 << 2) /* external reference enable */
>> -#define AD7298_TAVG	(1 << 1) /* temperature sensor averaging enable */
>> -#define AD7298_PDD	(1 << 0) /* partial power down enable */
>> -
>> -#define AD7298_MAX_CHAN		8
>> -#define AD7298_BITS		12
>> -#define AD7298_STORAGE_BITS	16
>> -#define AD7298_INTREF_mV	2500
>> -
>> -#define AD7298_CH_TEMP		9
>> -
>> -#define RES_MASK(bits)	((1 << (bits)) - 1)
>> -
>>  /**
>>   * struct ad7298_platform_data - Platform data for the ad7298 ADC driver
>>   * @ext_ref: Whether to use an external reference voltage.
>> @@ -34,40 +17,4 @@ struct ad7298_platform_data {
>>  	bool ext_ref;
>>  };
>>  
>> -struct ad7298_state {
>> -	struct spi_device		*spi;
>> -	struct regulator		*reg;
>> -	unsigned			ext_ref;
>> -	struct spi_transfer		ring_xfer[10];
>> -	struct spi_transfer		scan_single_xfer[3];
>> -	struct spi_message		ring_msg;
>> -	struct spi_message		scan_single_msg;
>> -	/*
>> -	 * DMA (thus cache coherency maintenance) requires the
>> -	 * transfer buffers to live in their own cache lines.
>> -	 */
>> -	unsigned short			rx_buf[12] ____cacheline_aligned;
>> -	unsigned short			tx_buf[2];
>> -};
>> -
>> -#ifdef CONFIG_IIO_BUFFER
>> -int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev);
>> -void ad7298_ring_cleanup(struct iio_dev *indio_dev);
>> -int ad7298_update_scan_mode(struct iio_dev *indio_dev,
>> -	const unsigned long *active_scan_mask);
>> -#else /* CONFIG_IIO_BUFFER */
>> -
>> -static inline int
>> -ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>> -{
>> -	return 0;
>> -}
>> -
>> -static inline void ad7298_ring_cleanup(struct iio_dev *indio_dev)
>> -{
>> -}
>> -
>> -#define ad7298_update_scan_mode NULL
>> -
>> -#endif /* CONFIG_IIO_BUFFER */
>>  #endif /* IIO_ADC_AD7298_H_ */
>> diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
>> deleted file mode 100644
>> index e387712..0000000
>> --- a/drivers/staging/iio/adc/ad7298_ring.c
>> +++ /dev/null
>> @@ -1,108 +0,0 @@
>> -/*
>> - * AD7298 SPI ADC driver
>> - *
>> - * Copyright 2011-2012 Analog Devices Inc.
>> - *
>> - * Licensed under the GPL-2.
>> - */
>> -
>> -#include <linux/interrupt.h>
>> -#include <linux/kernel.h>
>> -#include <linux/slab.h>
>> -#include <linux/spi/spi.h>
>> -
>> -#include <linux/iio/iio.h>
>> -#include <linux/iio/buffer.h>
>> -#include <linux/iio/trigger_consumer.h>
>> -#include <linux/iio/triggered_buffer.h>
>> -
>> -#include "ad7298.h"
>> -
>> -/**
>> - * ad7298_update_scan_mode() setup the spi transfer buffer for the new scan mask
>> - **/
>> -int ad7298_update_scan_mode(struct iio_dev *indio_dev,
>> -	const unsigned long *active_scan_mask)
>> -{
>> -	struct ad7298_state *st = iio_priv(indio_dev);
>> -	int i, m;
>> -	unsigned short command;
>> -	int scan_count;
>> -
>> -	/* Now compute overall size */
>> -	scan_count = bitmap_weight(active_scan_mask, indio_dev->masklength);
>> -
>> -	command = AD7298_WRITE | st->ext_ref;
>> -
>> -	for (i = 0, m = AD7298_CH(0); i < AD7298_MAX_CHAN; i++, m >>= 1)
>> -		if (test_bit(i, active_scan_mask))
>> -			command |= m;
>> -
>> -	st->tx_buf[0] = cpu_to_be16(command);
>> -
>> -	/* build spi ring message */
>> -	st->ring_xfer[0].tx_buf = &st->tx_buf[0];
>> -	st->ring_xfer[0].len = 2;
>> -	st->ring_xfer[0].cs_change = 1;
>> -	st->ring_xfer[1].tx_buf = &st->tx_buf[1];
>> -	st->ring_xfer[1].len = 2;
>> -	st->ring_xfer[1].cs_change = 1;
>> -
>> -	spi_message_init(&st->ring_msg);
>> -	spi_message_add_tail(&st->ring_xfer[0], &st->ring_msg);
>> -	spi_message_add_tail(&st->ring_xfer[1], &st->ring_msg);
>> -
>> -	for (i = 0; i < scan_count; i++) {
>> -		st->ring_xfer[i + 2].rx_buf = &st->rx_buf[i];
>> -		st->ring_xfer[i + 2].len = 2;
>> -		st->ring_xfer[i + 2].cs_change = 1;
>> -		spi_message_add_tail(&st->ring_xfer[i + 2], &st->ring_msg);
>> -	}
>> -	/* make sure last transfer cs_change is not set */
>> -	st->ring_xfer[i + 1].cs_change = 0;
>> -
>> -	return 0;
>> -}
>> -
>> -/**
>> - * ad7298_trigger_handler() bh of trigger launched polling to ring buffer
>> - *
>> - * Currently there is no option in this driver to disable the saving of
>> - * timestamps within the ring.
>> - **/
>> -static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>> -{
>> -	struct iio_poll_func *pf = p;
>> -	struct iio_dev *indio_dev = pf->indio_dev;
>> -	struct ad7298_state *st = iio_priv(indio_dev);
>> -	s64 time_ns = 0;
>> -	int b_sent;
>> -
>> -	b_sent = spi_sync(st->spi, &st->ring_msg);
>> -	if (b_sent)
>> -		goto done;
>> -
>> -	if (indio_dev->scan_timestamp) {
>> -		time_ns = iio_get_time_ns();
>> -		memcpy((u8 *)st->rx_buf + indio_dev->scan_bytes - sizeof(s64),
>> -			&time_ns, sizeof(time_ns));
>> -	}
>> -
>> -	iio_push_to_buffers(indio_dev, (u8 *)st->rx_buf);
>> -
>> -done:
>> -	iio_trigger_notify_done(indio_dev->trig);
>> -
>> -	return IRQ_HANDLED;
>> -}
>> -
>> -int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>> -{
>> -	return iio_triggered_buffer_setup(indio_dev, NULL,
>> -			&ad7298_trigger_handler, NULL);
>> -}
>> -
>> -void ad7298_ring_cleanup(struct iio_dev *indio_dev)
>> -{
>> -	iio_triggered_buffer_cleanup(indio_dev);
>> -}
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
