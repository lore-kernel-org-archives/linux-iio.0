Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:19969 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757299AbbA2SrC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jan 2015 13:47:02 -0500
Message-id: <54CA8021.2020909@samsung.com>
Date: Thu, 29 Jan 2015 19:46:57 +0100
From: Karol Wrona <k.wrona@samsung.com>
MIME-version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Karol Wrona <wrona.vy@gmail.com>
Subject: Re: [PATCH v5 1/5] iio: common: ssp_sensors: Add sensorhub driver
References: <1422453954-27317-1-git-send-email-k.wrona@samsung.com>
 <1422453954-27317-2-git-send-email-k.wrona@samsung.com>
 <54CA7D85.20409@kernel.org>
In-reply-to: <54CA7D85.20409@kernel.org>
Content-type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/29/2015 07:35 PM, Jonathan Cameron wrote:
> On 28/01/15 14:05, Karol Wrona wrote:
>> Sensorhub  is MCU dedicated to collect data and manage several sensors.
>> Sensorhub is a spi device which provides a layer for IIO devices. It provides
>> some data parsing and common mechanism for sensorhub sensors.
>>
>> Adds common sensorhub library for sensorhub driver and iio drivers
>> which uses sensorhub MCU to communicate with sensors.
>>
>> Signed-off-by: Karol Wrona <k.wrona@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> A couple of build errors from this one...
> 
> I've fixed them up and applied to the togreg branch of iio.git.
> Pushed out as testing.  If you get a chance to check I didn't
> mess anything up that would be great.
>> ---
>>  drivers/iio/common/Kconfig               |    1 +
>>  drivers/iio/common/Makefile              |    1 +
>>  drivers/iio/common/ssp_sensors/Kconfig   |   26 ++
>>  drivers/iio/common/ssp_sensors/Makefile  |    8 +
>>  drivers/iio/common/ssp_sensors/ssp.h     |  257 +++++++++++
>>  drivers/iio/common/ssp_sensors/ssp_dev.c |  712 ++++++++++++++++++++++++++++++
>>  drivers/iio/common/ssp_sensors/ssp_spi.c |  608 +++++++++++++++++++++++++
>>  include/linux/iio/common/ssp_sensors.h   |   82 ++++
>>  8 files changed, 1695 insertions(+)
>>  create mode 100644 drivers/iio/common/ssp_sensors/Kconfig
>>  create mode 100644 drivers/iio/common/ssp_sensors/Makefile
>>  create mode 100644 drivers/iio/common/ssp_sensors/ssp.h
>>  create mode 100644 drivers/iio/common/ssp_sensors/ssp_dev.c
>>  create mode 100644 drivers/iio/common/ssp_sensors/ssp_spi.c
>>  create mode 100644 include/linux/iio/common/ssp_sensors.h
>>
>> diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
>> index 0b6e97d..790f106 100644
>> --- a/drivers/iio/common/Kconfig
>> +++ b/drivers/iio/common/Kconfig
>> @@ -3,4 +3,5 @@
>>  #
>>  
>>  source "drivers/iio/common/hid-sensors/Kconfig"
>> +source "drivers/iio/common/ssp_sensors/Kconfig"
>>  source "drivers/iio/common/st_sensors/Kconfig"
>> diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
>> index 3112df0..b1e4d9c 100644
>> --- a/drivers/iio/common/Makefile
>> +++ b/drivers/iio/common/Makefile
>> @@ -8,4 +8,5 @@
>>  
>>  # When adding new entries keep the list in alphabetical order
>>  obj-y += hid-sensors/
>> +obj-y += ssp_sensors/
>>  obj-y += st_sensors/
>> diff --git a/drivers/iio/common/ssp_sensors/Kconfig b/drivers/iio/common/ssp_sensors/Kconfig
>> new file mode 100644
>> index 0000000..0ea4faf
>> --- /dev/null
>> +++ b/drivers/iio/common/ssp_sensors/Kconfig
>> @@ -0,0 +1,26 @@
>> +#
>> +# SSP sensor drivers and commons configuration
>> +#
>> +menu "SSP Sensor Common"
>> +
>> +config IIO_SSP_SENSORS_COMMONS
>> +	tristate "Commons for all SSP Sensor IIO drivers"
>> +	depends on IIO_SSP_SENSORHUB
>> +	select IIO_BUFFER
>> +	select IIO_KFIFO_BUF
>> +	help
>> +	  Say yes here to build commons for SSP sensors.
>> +	  To compile this as a module, choose M here: the module
>> +	  will be called ssp_iio.
>> +
>> +config IIO_SSP_SENSORHUB
>> +	tristate "Samsung Sensorhub driver"
>> +	depends on SPI
>> +	select MFD_CORE
>> +	help
>> +	  SSP driver for sensorhub. +	  If you say yes here you get ssp support for sensorhub.
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called sensorhub.
>> +
>> +endmenu
>> diff --git a/drivers/iio/common/ssp_sensors/Makefile b/drivers/iio/common/ssp_sensors/Makefile
>> new file mode 100644
>> index 0000000..1e0389e
>> --- /dev/null
>> +++ b/drivers/iio/common/ssp_sensors/Makefile
>> @@ -0,0 +1,8 @@
>> +#
>> +# Makefile for SSP sensor drivers and commons.
>> +#
>> +
>> +sensorhub-objs				:= ssp_dev.o ssp_spi.o
>> +obj-$(CONFIG_IIO_SSP_SENSORHUB)		+= sensorhub.o
>> +
>> +obj-$(CONFIG_IIO_SSP_SENSORS_COMMONS) 	+= ssp_iio.o
> This file isn't in this patch.

Thanks for doing that.
I had to mess sth up during rebase.

[...]
