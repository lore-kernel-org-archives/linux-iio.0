Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58553 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab3JAPWO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 11:22:14 -0400
Message-ID: <524AF6D0.5070000@kernel.org>
Date: Tue, 01 Oct 2013 17:22:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lukasz Czerwinski <l.czerwinski@samsung.com>, jic23@cam.ac.uk
CC: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: Re: [RFC v2 PATCH 01/14] iio: st_common: New interrupt interface
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com> <1380299538-22047-2-git-send-email-l.czerwinski@samsung.com> <524AEB97.1090806@kernel.org>
In-Reply-To: <524AEB97.1090806@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/13 16:34, Jonathan Cameron wrote:
> On 09/27/13 17:32, Lukasz Czerwinski wrote:
>> This patch adds two interrupts handling by the st_common library.
>> Additional second interrupt is used to indetify enabled event support for
>> chosen ST device. It supports board files and dt.
>>
>> For dt interface multiple interrupts are passed through interrupt-names
>> property.
>>
>> Read drdy_int_pin value is moved to the st_sensors_parse_platform_data()
>> in the st_sensors_i2c.c and st_sensors_spi.c Now drdy_int_pin can be
>> also configured via dt.
>>
>> Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> The code here is absolutely fine, though I would like some comments
> on this from Denis and/or Lee (as they are much more familiar with the driver
> than I am!
> 
> The one element that is problematic is the use of interrupt names in specifying
> the two interrupts.  Unforunately, for reasons that I think can be sumarized
> as historical precedence and avoiding complexity of passing in other OSes,
> the device tree powers that be are very anti doing multiple optional interrupts
> this way and consider interrupt-names to be merely for information rather than
> to be used to allow 'optional' interrupts.
> 
> 
> One thread on this is:
> 
> http://www.spinics.net/lists/linux-iio/msg09646.html
Now I'm confused.  You refer to that one clearly in your patch introduction.
Is this not still relying on the names field to work out which is which?

> 
> 
> Obviously this effects your later device tree bindings patches.
> 
>> ---
>>  drivers/iio/common/st_sensors/st_sensors_core.c |   36 +----------
>>  drivers/iio/common/st_sensors/st_sensors_i2c.c  |   75 +++++++++++++++++++++-
>>  drivers/iio/common/st_sensors/st_sensors_spi.c  |   77 ++++++++++++++++++++++-
>>  include/linux/iio/common/st_sensors.h           |   13 +++-
>>  include/linux/platform_data/st_sensors_pdata.h  |    2 +
>>  5 files changed, 160 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
>> index 7ba1ef2..697b16d 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
>> @@ -198,47 +198,13 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
>>  }
>>  EXPORT_SYMBOL(st_sensors_set_axis_enable);
>>  
>> -static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
>> -				       struct st_sensors_platform_data *pdata)
>> -{
>> -	struct st_sensor_data *sdata = iio_priv(indio_dev);
>> -
>> -	switch (pdata->drdy_int_pin) {
>> -	case 1:
>> -		if (sdata->sensor->drdy_irq.mask_int1 == 0) {
>> -			dev_err(&indio_dev->dev,
>> -					"DRDY on INT1 not available.\n");
>> -			return -EINVAL;
>> -		}
>> -		sdata->drdy_int_pin = 1;
>> -		break;
>> -	case 2:
>> -		if (sdata->sensor->drdy_irq.mask_int2 == 0) {
>> -			dev_err(&indio_dev->dev,
>> -					"DRDY on INT2 not available.\n");
>> -			return -EINVAL;
>> -		}
>> -		sdata->drdy_int_pin = 2;
>> -		break;
>> -	default:
>> -		dev_err(&indio_dev->dev, "DRDY on pdata not valid.\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>> -int st_sensors_init_sensor(struct iio_dev *indio_dev,
>> -					struct st_sensors_platform_data *pdata)
>> +int st_sensors_init_sensor(struct iio_dev *indio_dev)
>>  {
>>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>>  	int err = 0;
>>  
>>  	mutex_init(&sdata->tb.buf_lock);
>>  
>> -	if (pdata)
>> -		err = st_sensors_set_drdy_int_pin(indio_dev, pdata);
>> -
>>  	err = st_sensors_set_enable(indio_dev, false);
>>  	if (err < 0)
>>  		return err;
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
>> index 38af944..79a9e9e 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
>> @@ -12,17 +12,82 @@
>>  #include <linux/module.h>
>>  #include <linux/slab.h>
>>  #include <linux/iio/iio.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>>  
>>  #include <linux/iio/common/st_sensors_i2c.h>
>>  
>>  
>>  #define ST_SENSORS_I2C_MULTIREAD	0x80
>>  
>> -static unsigned int st_sensors_i2c_get_irq(struct iio_dev *indio_dev)
>> +static unsigned int st_sensors_i2c_get_data_rdy_irq(struct iio_dev *indio_dev)
>>  {
>>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>>  
>> -	return to_i2c_client(sdata->dev)->irq;
>> +	return sdata->irq_map[ST_SENSORS_INT1];
>> +}
>> +EXPORT_SYMBOL(st_sensors_i2c_get_data_rdy_irq);
>> +
>> +static unsigned int st_sensors_i2c_get_event_irq(struct iio_dev *indio_dev)
>> +{
>> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
>> +
>> +	return sdata->irq_map[ST_SENSORS_INT2];
>> +}
>> +EXPORT_SYMBOL(st_sensors_i2c_get_event_irq);
>> +
>> +static void st_sensors_parse_platform_data(struct i2c_client *client,
>> +		struct iio_dev *indio_dev)
>> +{
>> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
>> +	struct device_node *np = client->dev.of_node;
>> +	struct st_sensors_platform_data *pdata = client->dev.platform_data;
>> +
>> +	if (pdata)
>> +		sdata->drdy_int_pin = pdata->drdy_int_pin;
>> +	else if (np)
>> +		of_property_read_u8(np, "st,drdy-int-pin",
>> +			(u8 *)&sdata->drdy_int_pin);
>> +}
>> +
>> +static unsigned int st_sensors_i2c_map_irq(struct i2c_client *client,
>> +		unsigned int irq_num)
>> +{
>> +	struct device_node *np = client->dev.of_node;
>> +	struct st_sensors_platform_data *pdata = client->dev.platform_data;
>> +	int index = 0;
>> +
>> +	if (pdata)
>> +		return pdata->irqs[irq_num];
>> +	else if (np) {
>> +		switch (irq_num) {
>> +		case ST_SENSORS_INT1:
>> +			index = of_property_match_string(np,
>> +					"interrupt-names",
>> +					ST_SENSORS_DRDY_IRQ_NAME);
>> +			break;
>> +		case ST_SENSORS_INT2:
>> +			index = of_property_match_string(np,
>> +					"interrupt-names",
>> +					ST_SENSORS_EVENT_IRQ_NAME);
>> +		default:
>> +			break;
>> +		}
>> +		return index < 0 ? 0 : irq_of_parse_and_map(np, index);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void st_sensors_i2c_map_irqs(struct i2c_client *client,
>> +		struct iio_dev *indio_dev)
>> +{
>> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
>> +
>> +	sdata->irq_map[ST_SENSORS_INT1] =
>> +		st_sensors_i2c_map_irq(client, ST_SENSORS_INT1);
>> +
>> +	sdata->irq_map[ST_SENSORS_INT2] =
>> +		st_sensors_i2c_map_irq(client, ST_SENSORS_INT2);
>>  }
>>  
>>  static int st_sensors_i2c_read_byte(struct st_sensor_transfer_buffer *tb,
>> @@ -71,8 +136,12 @@ void st_sensors_i2c_configure(struct iio_dev *indio_dev,
>>  	indio_dev->dev.parent = &client->dev;
>>  	indio_dev->name = client->name;
>>  
>> +	st_sensors_parse_platform_data(client, indio_dev);
>> +
>>  	sdata->tf = &st_sensors_tf_i2c;
>> -	sdata->get_irq_data_ready = st_sensors_i2c_get_irq;
>> +	st_sensors_i2c_map_irqs(client, indio_dev);
>> +	sdata->get_irq_data_ready = st_sensors_i2c_get_data_rdy_irq;
>> +	sdata->get_irq_event = st_sensors_i2c_get_event_irq;
>>  }
>>  EXPORT_SYMBOL(st_sensors_i2c_configure);
>>  
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
>> index 251baf6..fc04cfc 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
>> @@ -8,10 +8,14 @@
>>   * Licensed under the GPL-2.
>>   */
>>  
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/slab.h>
>>  #include <linux/iio/iio.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>>  
>>  #include <linux/iio/common/st_sensors_spi.h>
>>  
>> @@ -19,11 +23,74 @@
>>  #define ST_SENSORS_SPI_MULTIREAD	0xc0
>>  #define ST_SENSORS_SPI_READ		0x80
>>  
>> -static unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev)
>> +static unsigned int st_sensors_spi_get_data_rdy_irq(struct iio_dev *indio_dev)
>>  {
>>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>>  
>> -	return to_spi_device(sdata->dev)->irq;
>> +	return sdata->irq_map[ST_SENSORS_INT1];
>> +}
>> +EXPORT_SYMBOL(st_sensors_spi_get_data_rdy_irq);
>> +
>> +static unsigned int st_sensors_spi_get_event_irq(struct iio_dev *indio_dev)
>> +{
>> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
>> +
>> +	return sdata->irq_map[ST_SENSORS_INT2];
>> +}
>> +EXPORT_SYMBOL(st_sensors_spi_get_event_irq);
>> +
>> +static void st_sensors_parse_platform_data(struct spi_device *spi,
>> +		struct iio_dev *indio_dev)
>> +{
>> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
>> +	struct device_node *np = spi->dev.of_node;
>> +	struct st_sensors_platform_data *pdata = spi->dev.platform_data;
>> +
>> +	if (pdata)
>> +		sdata->drdy_int_pin = pdata->drdy_int_pin;
>> +	else if (np)
>> +		of_property_read_u8(np, "drdy-int-pin",
>> +			(u8 *)&sdata->drdy_int_pin);
>> +}
>> +
>> +static unsigned int st_sensors_spi_map_irq(struct spi_device *spi,
>> +		unsigned int irq_num)
>> +{
>> +	struct device_node *np = spi->dev.of_node;
>> +	struct st_sensors_platform_data *pdata = spi->dev.platform_data;
>> +	int index = 0;
>> +
>> +	if (pdata)
>> +		return pdata->irqs[irq_num];
>> +	else if (np) {
>> +		switch (irq_num) {
>> +		case ST_SENSORS_INT1:
>> +			index = of_property_match_string(np,
>> +					"interrupt-names",
>> +					ST_SENSORS_DRDY_IRQ_NAME);
>> +			break;
>> +		case ST_SENSORS_INT2:
>> +			index = of_property_match_string(np,
>> +					"interrupt-names",
>> +					ST_SENSORS_EVENT_IRQ_NAME);
>> +		default:
>> +			break;
>> +		}
>> +		return index < 0 ? 0 : irq_of_parse_and_map(np, index);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void st_sensors_spi_map_irqs(struct spi_device *spi,
>> +		struct iio_dev *indio_dev)
>> +{
>> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
>> +
>> +	sdata->irq_map[ST_SENSORS_INT1] =
>> +		st_sensors_spi_map_irq(spi, ST_SENSORS_INT1);
>> +
>> +	sdata->irq_map[ST_SENSORS_INT2] =
>> +		st_sensors_spi_map_irq(spi, ST_SENSORS_INT2);
>>  }
>>  
>>  static int st_sensors_spi_read(struct st_sensor_transfer_buffer *tb,
>> @@ -111,8 +178,12 @@ void st_sensors_spi_configure(struct iio_dev *indio_dev,
>>  	indio_dev->dev.parent = &spi->dev;
>>  	indio_dev->name = spi->modalias;
>>  
>> +	st_sensors_parse_platform_data(spi, indio_dev);
>> +
>>  	sdata->tf = &st_sensors_tf_spi;
>> -	sdata->get_irq_data_ready = st_sensors_spi_get_irq;
>> +	st_sensors_spi_map_irqs(spi, indio_dev);
>> +	sdata->get_irq_data_ready = st_sensors_spi_get_data_rdy_irq;
>> +	sdata->get_irq_event = st_sensors_spi_get_event_irq;
>>  }
>>  EXPORT_SYMBOL(st_sensors_spi_configure);
>>  
>> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
>> index 3c005eb..3f4a0f7 100644
>> --- a/include/linux/iio/common/st_sensors.h
>> +++ b/include/linux/iio/common/st_sensors.h
>> @@ -41,6 +41,12 @@
>>  #define ST_SENSORS_MAX_NAME			17
>>  #define ST_SENSORS_MAX_4WAI			7
>>  
>> +#define ST_SENSORS_INT_MAX			2
>> +#define ST_SENSORS_INT1				0
>> +#define ST_SENSORS_INT2				1
>> +#define ST_SENSORS_DRDY_IRQ_NAME		"drdy-int"
>> +#define ST_SENSORS_EVENT_IRQ_NAME		"event-int"
>> +
>>  #define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
>>  					ch2, s, endian, rbits, sbits, addr) \
>>  { \
>> @@ -209,8 +215,10 @@ struct st_sensors {
>>   * @buffer_data: Data used by buffer part.
>>   * @odr: Output data rate of the sensor [Hz].
>>   * num_data_channels: Number of data channels used in buffer.
>> + * @irq_map: Container of mapped IRQs.
>>   * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
>>   * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
>> + * @get_irq_event: Function to get the IRQ used for event signal.
>>   * @tf: Transfer function structure used by I/O operations.
>>   * @tb: Transfer buffers and mutex used by I/O operations.
>>   */
>> @@ -229,10 +237,12 @@ struct st_sensor_data {
>>  
>>  	unsigned int odr;
>>  	unsigned int num_data_channels;
>> +	unsigned int irq_map[ST_SENSORS_INT_MAX];
>>  
>>  	u8 drdy_int_pin;
>>  
>>  	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
>> +	unsigned int (*get_irq_event) (struct iio_dev *indio_dev);
>>  
>>  	const struct st_sensor_transfer_function *tf;
>>  	struct st_sensor_transfer_buffer tb;
>> @@ -262,8 +272,7 @@ static inline void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
>>  }
>>  #endif
>>  
>> -int st_sensors_init_sensor(struct iio_dev *indio_dev,
>> -					struct st_sensors_platform_data *pdata);
>> +int st_sensors_init_sensor(struct iio_dev *indio_dev);
>>  
>>  int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable);
>>  
>> diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
>> index 7538391..991db72 100644
>> --- a/include/linux/platform_data/st_sensors_pdata.h
>> +++ b/include/linux/platform_data/st_sensors_pdata.h
>> @@ -19,6 +19,8 @@
>>   */
>>  struct st_sensors_platform_data {
>>  	u8 drdy_int_pin;
>> +
>> +	unsigned int irqs[2];
>>  };
>>  
>>  #endif /* ST_SENSORS_PDATA_H */
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
