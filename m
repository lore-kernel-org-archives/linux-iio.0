Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40786 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab3GPHrN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 03:47:13 -0400
Message-ID: <51E4FA7F.10600@kernel.org>
Date: Tue, 16 Jul 2013 08:47:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add a comment to about alphabetical order to Kconfigs
 and Makefiles
References: <1373874302-28342-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1373874302-28342-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/15/2013 08:45 AM, Lars-Peter Clausen wrote:
> Keeping Makefile and Kconfig entries in alphabetical order usually works better
> than just appending new entries at the end, since it reduces the amount of
> conflicts. This patch adds a comment to the IIO Kconfig and Makefile files to
> document that the entries should be kept in alphabetical order.
> 
> Also reorder those  entries which weren't in alphabetical order yet.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/accel/Kconfig         | 16 +++++++++-------
>  drivers/iio/accel/Makefile        |  4 ++--
>  drivers/iio/adc/Kconfig           | 36 +++++++++++++++++++-----------------
>  drivers/iio/adc/Makefile          |  1 +
>  drivers/iio/amplifiers/Kconfig    |  2 ++
>  drivers/iio/amplifiers/Makefile   |  1 +
>  drivers/iio/common/Makefile       |  1 +
>  drivers/iio/dac/Kconfig           | 38 ++++++++++++++++++++------------------
>  drivers/iio/dac/Makefile          |  1 +
>  drivers/iio/frequency/Kconfig     |  1 +
>  drivers/iio/frequency/Makefile    |  1 +
>  drivers/iio/gyro/Kconfig          |  2 ++
>  drivers/iio/gyro/Makefile         |  1 +
>  drivers/iio/imu/Kconfig           |  2 ++
>  drivers/iio/imu/Makefile          |  1 +
>  drivers/iio/light/Kconfig         | 24 +++++++++++++-----------
>  drivers/iio/light/Makefile        |  3 ++-
>  drivers/iio/magnetometer/Kconfig  |  2 ++
>  drivers/iio/magnetometer/Makefile |  1 +
>  drivers/iio/pressure/Kconfig      |  2 ++
>  drivers/iio/pressure/Makefile     |  1 +
>  drivers/iio/trigger/Kconfig       |  2 ++
>  drivers/iio/trigger/Makefile      |  1 +
>  23 files changed, 88 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index a002675..61ca7ec 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -1,6 +1,8 @@
>  #
>  # Accelerometer drivers
>  #
> +# When adding new entries keep the list in alphabetical order
> +
>  menu "Accelerometers"
>  
>  config HID_SENSOR_ACCEL_3D
> @@ -14,13 +16,6 @@ config HID_SENSOR_ACCEL_3D
>  	  Say yes here to build support for the HID SENSOR
>  	  accelerometers 3D.
>  
> -config KXSD9
> -	tristate "Kionix KXSD9 Accelerometer Driver"
> -	depends on SPI
> -	help
> -	  Say yes here to build support for the Kionix KXSD9 accelerometer.
> -	  Currently this only supports the device via an SPI interface.
> -
>  config IIO_ST_ACCEL_3AXIS
>  	tristate "STMicroelectronics accelerometers 3-Axis Driver"
>  	depends on (I2C || SPI_MASTER) && SYSFS
> @@ -51,4 +46,11 @@ config IIO_ST_ACCEL_SPI_3AXIS
>  	depends on IIO_ST_ACCEL_3AXIS
>  	depends on IIO_ST_SENSORS_SPI
>  
> +config KXSD9
> +	tristate "Kionix KXSD9 Accelerometer Driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for the Kionix KXSD9 accelerometer.
> +	  Currently this only supports the device via an SPI interface.
> +
>  endmenu
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 87d8fa2..2f95a3d 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -2,7 +2,9 @@
>  # Makefile for industrial I/O accelerometer drivers
>  #
>  
> +# When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
> +obj-$(CONFIG_KXSD9)	+= kxsd9.o
>  
>  obj-$(CONFIG_IIO_ST_ACCEL_3AXIS) += st_accel.o
>  st_accel-y := st_accel_core.o
> @@ -10,5 +12,3 @@ st_accel-$(CONFIG_IIO_BUFFER) += st_accel_buffer.o
>  
>  obj-$(CONFIG_IIO_ST_ACCEL_I2C_3AXIS) += st_accel_i2c.o
>  obj-$(CONFIG_IIO_ST_ACCEL_SPI_3AXIS) += st_accel_spi.o
> -
> -obj-$(CONFIG_KXSD9)	+= kxsd9.o
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 2eced9d..dd6bd1b 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1,6 +1,8 @@
>  #
>  # ADC drivers
>  #
> +# When adding new entries keep the list in alphabetical order
> +
>  menu "Analog to digital converters"
>  
>  config AD_SIGMA_DELTA
> @@ -30,17 +32,20 @@ config AD7298
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7298.
>  
> -config AD7923
> -	tristate "Analog Devices AD7923 and similar ADCs driver"
> +config AD7476
> +	tristate "Analog Devices AD7476 and similar 1-channel ADCs driver"
>  	depends on SPI
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  Say yes here to build support for Analog Devices
> -	  AD7904, AD7914, AD7923, AD7924 4 Channel ADCs.
> +	  Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
> +	  AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
> +	  AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
> +
> +	  If unsure, say N (but it's safe to say "Y").
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called ad7923.
> +	  module will be called ad7476.
>  
>  config AD7791
>  	tristate "Analog Devices AD7791 ADC driver"
> @@ -66,33 +71,30 @@ config AD7793
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called AD7793.
>  
> -config AD7476
> -	tristate "Analog Devices AD7476 and similar 1-channel ADCs driver"
> +config AD7887
> +	tristate "Analog Devices AD7887 ADC driver"
>  	depends on SPI
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
> -	  AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
> -	  AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
> -
> +	  Say yes here to build support for Analog Devices
> +	  AD7887 SPI analog to digital converter (ADC).
>  	  If unsure, say N (but it's safe to say "Y").
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called ad7476.
> +	  module will be called ad7887.
>  
> -config AD7887
> -	tristate "Analog Devices AD7887 ADC driver"
> +config AD7923
> +	tristate "Analog Devices AD7923 and similar ADCs driver"
>  	depends on SPI
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices
> -	  AD7887 SPI analog to digital converter (ADC).
> -	  If unsure, say N (but it's safe to say "Y").
> +	  AD7904, AD7914, AD7923, AD7924 4 Channel ADCs.
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called ad7887.
> +	  module will be called ad7923.
>  
>  config AT91_ADC
>  	tristate "Atmel AT91 ADC"
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d184139..2a4324e 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for IIO ADC drivers
>  #
>  
> +# When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>  obj-$(CONFIG_AD7266) += ad7266.o
>  obj-$(CONFIG_AD7298) += ad7298.o
> diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> index 05d707e..e9c5f2c 100644
> --- a/drivers/iio/amplifiers/Kconfig
> +++ b/drivers/iio/amplifiers/Kconfig
> @@ -1,6 +1,8 @@
>  #
>  # Gain Amplifiers, etc.
>  #
> +# When adding new entries keep the list in alphabetical order
> +
>  menu "Amplifiers"
>  
>  config AD8366
> diff --git a/drivers/iio/amplifiers/Makefile b/drivers/iio/amplifiers/Makefile
> index a6ca366..8da4b78 100644
> --- a/drivers/iio/amplifiers/Makefile
> +++ b/drivers/iio/amplifiers/Makefile
> @@ -2,4 +2,5 @@
>  # Makefile iio/amplifiers
>  #
>  
> +# When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD8366) += ad8366.o
> diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
> index c2352be..3112df0 100644
> --- a/drivers/iio/common/Makefile
> +++ b/drivers/iio/common/Makefile
> @@ -6,5 +6,6 @@
>  # instead of duplicating in each module.
>  #
>  
> +# When adding new entries keep the list in alphabetical order
>  obj-y += hid-sensors/
>  obj-y += st_sensors/
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index b9fd4c7..3c6a78a 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -1,6 +1,8 @@
>  #
>  # DAC drivers
>  #
> +# When adding new entries keep the list in alphabetical order
> +
>  menu "Digital to analog converters"
>  
>  config AD5064
> @@ -48,13 +50,6 @@ config AD5421
>  	  To compile this driver as module choose M here: the module will be called
>  	  ad5421.
>  
> -config AD5624R_SPI
> -	tristate "Analog Devices AD5624/44/64R DAC spi driver"
> -	depends on SPI
> -	help
> -	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
> -	  AD5664R converters (DAC). This driver uses the common SPI interface.
> -
>  config AD5446
>  	tristate "Analog Devices AD5446 and similar single channel DACs driver"
>  	depends on (SPI_MASTER && I2C!=m) || I2C
> @@ -87,6 +82,24 @@ config AD5504
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5504.
>  
> +config AD5624R_SPI
> +	tristate "Analog Devices AD5624/44/64R DAC spi driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
> +	  AD5664R converters (DAC). This driver uses the common SPI interface.
> +
> +config AD5686
> +	tristate "Analog Devices AD5686R/AD5685R/AD5684R DAC SPI driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Analog Devices AD5686R, AD5685R,
> +	  AD5684R, AD5791 Voltage Output Digital to
> +	  Analog Converter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5686.
> +
>  config AD5755
>  	tristate "Analog Devices AD5755/AD5755-1/AD5757/AD5735/AD5737 DAC driver"
>  	depends on SPI_MASTER
> @@ -119,17 +132,6 @@ config AD5791
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5791.
>  
> -config AD5686
> -	tristate "Analog Devices AD5686R/AD5685R/AD5684R DAC SPI driver"
> -	depends on SPI
> -	help
> -	  Say yes here to build support for Analog Devices AD5686R, AD5685R,
> -	  AD5684R, AD5791 Voltage Output Digital to
> -	  Analog Converter.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ad5686.
> -
>  config AD7303
>  	tristate "Analog Devices AD7303 DAC driver"
>  	depends on SPI
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index c8d7ab6..bb84ad6 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for industrial I/O DAC drivers
>  #
>  
> +# When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD5360) += ad5360.o
>  obj-$(CONFIG_AD5380) += ad5380.o
>  obj-$(CONFIG_AD5421) += ad5421.o
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 6aaa33e..dc5e0b7 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -4,6 +4,7 @@
>  #	Clock Distribution device drivers
>  #	Phase-Locked Loop (PLL) frequency synthesizers
>  #
> +# When adding new entries keep the list in alphabetical order
>  
>  menu "Frequency Synthesizers DDS/PLL"
>  
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
> index 00d26e5..2bca03f 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -2,5 +2,6 @@
>  # Makefile iio/frequency
>  #
>  
> +# When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD9523) += ad9523.o
>  obj-$(CONFIG_ADF4350) += adf4350.o
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index 1fdcc84..5913735 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -1,6 +1,8 @@
>  #
>  # IIO Digital Gyroscope Sensor drivers configuration
>  #
> +# When adding new entries keep the list in alphabetical order
> +
>  menu "Digital gyroscope sensors"
>  
>  config ADIS16080
> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> index e9dc034..36091d5 100644
> --- a/drivers/iio/gyro/Makefile
> +++ b/drivers/iio/gyro/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for industrial I/O gyroscope sensor drivers
>  #
>  
> +# When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_ADIS16080) += adis16080.o
>  obj-$(CONFIG_ADIS16130) += adis16130.o
>  obj-$(CONFIG_ADIS16136) += adis16136.o
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 4f40a10..663e88a 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -1,6 +1,8 @@
>  #
>  # IIO imu drivers configuration
>  #
> +# When adding new entries keep the list in alphabetical order
> +
>  menu "Inertial measurement units"
>  
>  config ADIS16400
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index f2f56ce..114d2c1 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for Inertial Measurement Units
>  #
>  
> +# When adding new entries keep the list in alphabetical order
>  adis16400-y             := adis16400_core.o
>  adis16400-$(CONFIG_IIO_BUFFER) += adis16400_buffer.o
>  obj-$(CONFIG_ADIS16400) += adis16400.o
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 5ef1a39..3bd29f8 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -1,6 +1,8 @@
>  #
>  # Light sensors
>  #
> +# When adding new entries keep the list in alphabetical order
> +
>  menu "Light sensors"
>  
>  config ADJD_S311
> @@ -15,6 +17,17 @@ config ADJD_S311
>  	 This driver can also be built as a module.  If so, the module
>  	 will be called adjd_s311.
>  
> +config HID_SENSOR_ALS
> +	depends on HID_SENSOR_HUB
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select HID_SENSOR_IIO_COMMON
> +	select HID_SENSOR_IIO_TRIGGER
> +	tristate "HID ALS"
> +	help
> +	  Say yes here to build support for the HID SENSOR
> +	  Ambient light sensor.
> +
>  config SENSORS_LM3533
>  	tristate "LM3533 ambient light sensor"
>  	depends on MFD_LM3533
> @@ -52,15 +65,4 @@ config VCNL4000
>  	 To compile this driver as a module, choose M here: the
>  	 module will be called vcnl4000.
>  
> -config HID_SENSOR_ALS
> -	depends on HID_SENSOR_HUB
> -	select IIO_BUFFER
> -	select IIO_TRIGGERED_BUFFER
> -	select HID_SENSOR_IIO_COMMON
> -	select HID_SENSOR_IIO_TRIGGER
> -	tristate "HID ALS"
> -	help
> -	  Say yes here to build support for the HID SENSOR
> -	  Ambient light sensor.
> -
>  endmenu
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 040d9c7..edef939 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -2,8 +2,9 @@
>  # Makefile for IIO Light sensors
>  #
>  
> +# When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
> +obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
>  obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>  obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
>  obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
> -obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 4d55b1b..4fa923f 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -1,6 +1,8 @@
>  #
>  # Magnetometer sensors
>  #
> +# When adding new entries keep the list in alphabetical order
> +
>  menu "Magnetometer sensors"
>  
>  config AK8975
> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> index 7f328e3..f91b1b6 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for industrial I/O Magnetometer sensor drivers
>  #
>  
> +# When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AK8975)	+= ak8975.o
>  obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
>  
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 56ae890..26fdc0b 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -1,6 +1,8 @@
>  #
>  # Pressure drivers
>  #
> +# When adding new entries keep the list in alphabetical order
> +
>  menu "Pressure sensors"
>  
>  config IIO_ST_PRESS
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index d4bb33e..be71464 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for industrial I/O pressure drivers
>  #
>  
> +# When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
>  st_pressure-y := st_pressure_core.o
>  st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
> diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
> index 0a4a516..7999612 100644
> --- a/drivers/iio/trigger/Kconfig
> +++ b/drivers/iio/trigger/Kconfig
> @@ -1,6 +1,8 @@
>  #
>  # Industrial I/O standalone triggers
>  #
> +# When adding new entries keep the list in alphabetical order
> +
>  menu "Triggers - standalone"
>  
>  config IIO_INTERRUPT_TRIGGER
> diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
> index ce319a5..0694dae 100644
> --- a/drivers/iio/trigger/Makefile
> +++ b/drivers/iio/trigger/Makefile
> @@ -2,5 +2,6 @@
>  # Makefile for triggers not associated with iio-devices
>  #
>  
> +# When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
>  obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
> 
