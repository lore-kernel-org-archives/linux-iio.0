Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48850 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbcEAV02 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2016 17:26:28 -0400
Subject: Re: [RFC PATCH v1 1/9] iio:st_pressure:initial lps22hb sensor support
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1461056711.git.gregor.boirie@parrot.com>
 <64f4465fa47a34107b58ab29ad07e2817e3d9a92.1461056711.git.gregor.boirie@parrot.com>
 <a4333aa7-5403-3110-5c8f-e7ee977104eb@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7670eb99-fdec-f14d-c8ac-35b155398479@kernel.org>
Date: Sun, 1 May 2016 20:28:39 +0100
MIME-Version: 1.0
In-Reply-To: <a4333aa7-5403-3110-5c8f-e7ee977104eb@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/04/16 10:29, Jonathan Cameron wrote:
> On 19/04/16 10:18, Gregor Boirie wrote:
>> Initial support for ST LPS22HB pressure sensor. Datasheet:
>> http://www2.st.com/resource/en/datasheet/lps22hb.pdf
>>
>> Features:
>> * pressure data and timestamping channels
>> * sampling frequency selection
>> * interrupt based trigger
>> * over I2C or SPI
>>
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> Looks good to me.  I would however like an Ack from Denis if possible
> as this is his driver.  Same is true for this whole series.
Denis, are you likely to get a chance to look at this series?

No immediate rush if you are busy right now as we've almost certainly
missed the merge window anyway and there are open questions on approach
taken in patch 4.

Jonathan
> 
> Jonathan
>> ---
>>  .../devicetree/bindings/iio/st-sensors.txt         |  1 +
>>  drivers/iio/pressure/Kconfig                       |  2 +-
>>  drivers/iio/pressure/st_pressure.h                 |  1 +
>>  drivers/iio/pressure/st_pressure_core.c            | 93 +++++++++++++++++++++-
>>  drivers/iio/pressure/st_pressure_i2c.c             |  4 +
>>  drivers/iio/pressure/st_pressure_spi.c             |  1 +
>>  6 files changed, 97 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
>> index 637e283..2bb8931 100644
>> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
>> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
>> @@ -63,3 +63,4 @@ Pressure sensors:
>>  - st,lps001wp-press
>>  - st,lps25h-press
>>  - st,lps331ap-press
>> +- st,lps22hb-press
>> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
>> index 8de0192..d63d280 100644
>> --- a/drivers/iio/pressure/Kconfig
>> +++ b/drivers/iio/pressure/Kconfig
>> @@ -118,7 +118,7 @@ config IIO_ST_PRESS
>>  	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
>>  	help
>>  	  Say yes here to build support for STMicroelectronics pressure
>> -	  sensors: LPS001WP, LPS25H, LPS331AP.
>> +	  sensors: LPS001WP, LPS25H, LPS331AP, LPS22HB.
>>  
>>  	  This driver can also be built as a module. If so, these modules
>>  	  will be created:
>> diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
>> index f5f4149..903a21e 100644
>> --- a/drivers/iio/pressure/st_pressure.h
>> +++ b/drivers/iio/pressure/st_pressure.h
>> @@ -17,6 +17,7 @@
>>  #define LPS001WP_PRESS_DEV_NAME		"lps001wp"
>>  #define LPS25H_PRESS_DEV_NAME		"lps25h"
>>  #define LPS331AP_PRESS_DEV_NAME		"lps331ap"
>> +#define LPS22HB_PRESS_DEV_NAME		"lps22hb"
>>  
>>  /**
>>   * struct st_sensors_platform_data - default press platform data
>> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
>> index 9e9b72a..c0ff3bf 100644
>> --- a/drivers/iio/pressure/st_pressure_core.c
>> +++ b/drivers/iio/pressure/st_pressure_core.c
>> @@ -113,6 +113,26 @@
>>  #define ST_PRESS_LPS25H_OUT_XL_ADDR		0x28
>>  #define ST_TEMP_LPS25H_OUT_L_ADDR		0x2b
>>  
>> +/* CUSTOM VALUES FOR LPS22HB SENSOR */
>> +#define ST_PRESS_LPS22HB_WAI_EXP		0xb1
>> +#define ST_PRESS_LPS22HB_ODR_ADDR		0x10
>> +#define ST_PRESS_LPS22HB_ODR_MASK		0x70
>> +#define ST_PRESS_LPS22HB_ODR_AVL_1HZ_VAL	0x01
>> +#define ST_PRESS_LPS22HB_ODR_AVL_10HZ_VAL	0x02
>> +#define ST_PRESS_LPS22HB_ODR_AVL_25HZ_VAL	0x03
>> +#define ST_PRESS_LPS22HB_ODR_AVL_50HZ_VAL	0x04
>> +#define ST_PRESS_LPS22HB_ODR_AVL_75HZ_VAL	0x05
>> +#define ST_PRESS_LPS22HB_PW_ADDR		0x10
>> +#define ST_PRESS_LPS22HB_PW_MASK		0x70
>> +#define ST_PRESS_LPS22HB_BDU_ADDR		0x10
>> +#define ST_PRESS_LPS22HB_BDU_MASK		0x02
>> +#define ST_PRESS_LPS22HB_DRDY_IRQ_ADDR		0x12
>> +#define ST_PRESS_LPS22HB_DRDY_IRQ_INT1_MASK	0x04
>> +#define ST_PRESS_LPS22HB_DRDY_IRQ_INT2_MASK	0x08
>> +#define ST_PRESS_LPS22HB_IHL_IRQ_ADDR		0x12
>> +#define ST_PRESS_LPS22HB_IHL_IRQ_MASK		0x80
>> +#define ST_PRESS_LPS22HB_MULTIREAD_BIT		true
>> +
>>  static const struct iio_chan_spec st_press_1_channels[] = {
>>  	{
>>  		.type = IIO_PRESSURE,
>> @@ -183,6 +203,27 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
>>  	IIO_CHAN_SOFT_TIMESTAMP(1)
>>  };
>>  
>> +static const struct iio_chan_spec st_press_lps22hb_channels[] = {
>> +	{
>> +		.type = IIO_PRESSURE,
>> +		.channel2 = IIO_NO_MOD,
>> +		.address = ST_PRESS_1_OUT_XL_ADDR,
>> +		.scan_index = 0,
>> +		.scan_type = {
>> +			.sign = 'u',
>> +			.realbits = 24,
>> +			.storagebits = 24,
>> +			.endianness = IIO_LE,
>> +		},
>> +		.info_mask_separate =
>> +			BIT(IIO_CHAN_INFO_RAW) |
>> +			BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +		.modified = 0,
>> +	},
>> +	IIO_CHAN_SOFT_TIMESTAMP(1)
>> +};
>> +
>>  static const struct st_sensor_settings st_press_sensors_settings[] = {
>>  	{
>>  		.wai = ST_PRESS_LPS331AP_WAI_EXP,
>> @@ -326,6 +367,51 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>>  		.multi_read_bit = ST_PRESS_LPS25H_MULTIREAD_BIT,
>>  		.bootime = 2,
>>  	},
>> +	{
>> +		.wai = ST_PRESS_LPS22HB_WAI_EXP,
>> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>> +		.sensors_supported = {
>> +			[0] = LPS22HB_PRESS_DEV_NAME,
>> +		},
>> +		.ch = (struct iio_chan_spec *)st_press_lps22hb_channels,
>> +		.num_ch = ARRAY_SIZE(st_press_lps22hb_channels),
>> +		.odr = {
>> +			.addr = ST_PRESS_LPS22HB_ODR_ADDR,
>> +			.mask = ST_PRESS_LPS22HB_ODR_MASK,
>> +			.odr_avl = {
>> +				{ 1, ST_PRESS_LPS22HB_ODR_AVL_1HZ_VAL, },
>> +				{ 10, ST_PRESS_LPS22HB_ODR_AVL_10HZ_VAL, },
>> +				{ 25, ST_PRESS_LPS22HB_ODR_AVL_25HZ_VAL, },
>> +				{ 50, ST_PRESS_LPS22HB_ODR_AVL_50HZ_VAL, },
>> +				{ 75, ST_PRESS_LPS22HB_ODR_AVL_75HZ_VAL, },
>> +			},
>> +		},
>> +		.pw = {
>> +			.addr = ST_PRESS_LPS22HB_PW_ADDR,
>> +			.mask = ST_PRESS_LPS22HB_PW_MASK,
>> +			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>> +		},
>> +		.fs = {
>> +			.fs_avl = {
>> +				[0] = {
>> +					.num = ST_PRESS_FS_AVL_1260MB,
>> +					.gain = ST_PRESS_KPASCAL_NANO_SCALE,
>> +				},
>> +			},
>> +		},
>> +		.bdu = {
>> +			.addr = ST_PRESS_LPS22HB_BDU_ADDR,
>> +			.mask = ST_PRESS_LPS22HB_BDU_MASK,
>> +		},
>> +		.drdy_irq = {
>> +			.addr = ST_PRESS_LPS22HB_DRDY_IRQ_ADDR,
>> +			.mask_int1 = ST_PRESS_LPS22HB_DRDY_IRQ_INT1_MASK,
>> +			.mask_int2 = ST_PRESS_LPS22HB_DRDY_IRQ_INT2_MASK,
>> +			.addr_ihl = ST_PRESS_LPS22HB_IHL_IRQ_ADDR,
>> +			.mask_ihl = ST_PRESS_LPS22HB_IHL_IRQ_MASK,
>> +		},
>> +		.multi_read_bit = ST_PRESS_LPS22HB_MULTIREAD_BIT,
>> +	},
>>  };
>>  
>>  static int st_press_write_raw(struct iio_dev *indio_dev,
>> @@ -454,10 +540,9 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>>  	indio_dev->channels = press_data->sensor_settings->ch;
>>  	indio_dev->num_channels = press_data->sensor_settings->num_ch;
>>  
>> -	if (press_data->sensor_settings->fs.addr != 0)
>> -		press_data->current_fullscale =
>> -			(struct st_sensor_fullscale_avl *)
>> -				&press_data->sensor_settings->fs.fs_avl[0];
>> +	press_data->current_fullscale =
>> +		(struct st_sensor_fullscale_avl *)
>> +			&press_data->sensor_settings->fs.fs_avl[0];
>>  
>>  	press_data->odr = press_data->sensor_settings->odr.odr_avl[0].hz;
>>  
>> diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
>> index 8fcf976..ed18701 100644
>> --- a/drivers/iio/pressure/st_pressure_i2c.c
>> +++ b/drivers/iio/pressure/st_pressure_i2c.c
>> @@ -32,6 +32,10 @@ static const struct of_device_id st_press_of_match[] = {
>>  		.compatible = "st,lps331ap-press",
>>  		.data = LPS331AP_PRESS_DEV_NAME,
>>  	},
>> +	{
>> +		.compatible = "st,lps22hb-press",
>> +		.data = LPS22HB_PRESS_DEV_NAME,
>> +	},
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, st_press_of_match);
>> diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
>> index 40c0692..5505080 100644
>> --- a/drivers/iio/pressure/st_pressure_spi.c
>> +++ b/drivers/iio/pressure/st_pressure_spi.c
>> @@ -50,6 +50,7 @@ static const struct spi_device_id st_press_id_table[] = {
>>  	{ LPS001WP_PRESS_DEV_NAME },
>>  	{ LPS25H_PRESS_DEV_NAME },
>>  	{ LPS331AP_PRESS_DEV_NAME },
>> +	{ LPS22HB_PRESS_DEV_NAME },
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(spi, st_press_id_table);
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

