Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47258 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKASBI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2015 13:01:08 -0500
Subject: Re: [PATCH v4] iio: accel: add Freescale MMA7455L/MMA7456L 3-axis
 accelerometer driver
To: Martin Kepplinger <martink@posteo.de>,
	Joachim Eastwood <manabian@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>
 <1446295756-14364-1-git-send-email-manabian@gmail.com>
 <56353491.5060503@posteo.de>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5636535E.9060501@kernel.org>
Date: Sun, 1 Nov 2015 18:01:02 +0000
MIME-Version: 1.0
In-Reply-To: <56353491.5060503@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/10/15 21:37, Martin Kepplinger wrote:
> Am 2015-10-31 um 13:49 schrieb Joachim Eastwood:
>> Add support for Freescale MMA7455L/MMA7456L 3-axis in 10-bit mode for
>> I2C and SPI bus. This rather simple driver that currently doesn't
>> support all the hardware features of MMA7455L/MMA7456L.
>>
>> Tested on Embedded Artist's LPC4357 Dev Kit with MMA7455L on I2C bus.
>>
>> Data sheets for the two devices can be found here:
>> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA7455L.pdf
>> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA7456L.pdf
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>> Hi,
>>
>> This version address the comments from Jonathan Cameron.
>>
>> Changes since v3:
>> * use IIO_CONST_ATTR on sampling_frequency_available
>> * allow changing of rate and scaling while buffer is running
>>
>> Changes since v2:
>> * fix id variable name in MODULE_DEVICE_TABLE
>> * make MMA7455_{I2C,SPI} symbols selectable
>> * rebase on linux-next (tag next-20151020)
>>
>> Changes since v1:
>> * limit retries to 3 in mma7455_drdy
>> * remove mma7455_show_scale_avail
>> * use chan->address instead of chan->scan_index for reg addr
>> * check that val2 is 0 when setting sample freq
>> * use __le16 to hint about endianess in mma7455_trigger_handler
>> * fix endianess in mma7455_read_raw function
>> * add mma7456 id
>> * split it into several source files to support both i2c and spi
>>
>>
>>  drivers/iio/accel/Kconfig        |  29 ++++
>>  drivers/iio/accel/Makefile       |   5 +
>>  drivers/iio/accel/mma7455.h      |  20 +++
>>  drivers/iio/accel/mma7455_core.c | 311 +++++++++++++++++++++++++++++++++++++++
>>  drivers/iio/accel/mma7455_i2c.c  |  57 +++++++
>>  drivers/iio/accel/mma7455_spi.c  |  53 +++++++
>>  6 files changed, 475 insertions(+)
>>  create mode 100644 drivers/iio/accel/mma7455.h
>>  create mode 100644 drivers/iio/accel/mma7455_core.c
>>  create mode 100644 drivers/iio/accel/mma7455_i2c.c
>>  create mode 100644 drivers/iio/accel/mma7455_spi.c
>>
>> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
>> index 969428dd6329..728a7761aaa6 100644
>> --- a/drivers/iio/accel/Kconfig
>> +++ b/drivers/iio/accel/Kconfig
>> @@ -107,6 +107,35 @@ config KXCJK1013
>>  	  To compile this driver as a module, choose M here: the module will
>>  	  be called kxcjk-1013.
>>  
>> +config MMA7455
>> +	tristate
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>> +
>> +config MMA7455_I2C
>> +	tristate "Freescale MMA7455L/MMA7456L Accelerometer I2C Driver"
>> +	depends on I2C
>> +	select MMA7455
>> +	select REGMAP_I2C
>> +	help
>> +	  Say yes here to build support for the Freescale MMA7455L and
>> +	  MMA7456L 3-axis accelerometer.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called mma7455_i2c.
>> +
>> +config MMA7455_SPI
>> +	tristate "Freescale MMA7455L/MMA7456L Accelerometer SPI Driver"
>> +	depends on SPI_MASTER
>> +	select MMA7455
>> +	select REGMAP_SPI
>> +	help
>> +	  Say yes here to build support for the Freescale MMA7455L and
>> +	  MMA7456L 3-axis accelerometer.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called mma7455_spi.
>> +
>>  config MMA8452
>>  	tristate "Freescale MMA8452Q and similar Accelerometers Driver"
>>  	depends on I2C
>> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
>> index 7925f166e6e9..7ea21f8b7d98 100644
>> --- a/drivers/iio/accel/Makefile
>> +++ b/drivers/iio/accel/Makefile
>> @@ -10,6 +10,11 @@ obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
>>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
>>  obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
>> +
>> +obj-$(CONFIG_MMA7455)		+= mma7455_core.o
>> +obj-$(CONFIG_MMA7455_I2C)	+= mma7455_i2c.o
>> +obj-$(CONFIG_MMA7455_SPI)	+= mma7455_spi.o
>> +
>>  obj-$(CONFIG_MMA8452)	+= mma8452.o
>>  
>>  obj-$(CONFIG_MMA9551_CORE)	+= mma9551_core.o
>> diff --git a/drivers/iio/accel/mma7455.h b/drivers/iio/accel/mma7455.h
>> new file mode 100644
>> index 000000000000..8fae9345da88
>> --- /dev/null
>> +++ b/drivers/iio/accel/mma7455.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * IIO accel header for Freescale MMA7455L 3-axis 10-bit accelerometer
>> + * Copyright 2015 Joachim Eastwood <manabian@gmail.com>
>> + *
> 
> Even though they are very similar (internal technological differences),
> you could mention both supported chips here and in the other files. Btw,
> I would also s/header/driver here.
> 
> That is, in case you get to do another version.
> 
Hi Martin,

I can see where you are coming from, but typically I'd actually advocate
mentioning the list of supported parts in as few a places as possible as
they tend to get out of sync if we end up with a driver supporting lots
of parts.  We have gotten round this in the past but saying something
like **** and similar or *** and compatible but that's always a bit clunky.

I'll switch header to driver in the application of the patch.

Jonathan

