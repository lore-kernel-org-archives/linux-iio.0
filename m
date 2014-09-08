Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:52059 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbaIHOzV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Sep 2014 10:55:21 -0400
Message-id: <540DC356.5040907@samsung.com>
Date: Mon, 08 Sep 2014 16:55:18 +0200
From: Karol Wrona <k.wrona@samsung.com>
MIME-version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [RFC/PATCH 0/6] iio: Add sensorhub driver
References: <1409756150-30889-1-git-send-email-k.wrona@samsung.com>
 <476dc5c4-557d-467c-9583-201b10b7e1df@email.android.com>
In-reply-to: <476dc5c4-557d-467c-9583-201b10b7e1df@email.android.com>
Content-type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/2014 09:52 PM, Jonathan Cameron wrote:
>
> On September 3, 2014 3:55:44 PM GMT+01:00, Karol Wrona <k.wrona@samsung.com> wrote:
>> Hello,
>>
>> This patchset adds support for sensorhub. It is an external mcu which
>> manages
>> and collects data from several sensors i.e. on Galaxy Gear 2 watch.
>>
>> It contains:
>> - spi driver for sensorhub device
>> - DT binding for the device
>> - IIO common utils for ssp sensors, a trigger module
>> - IIO accelerometer driver
>> - IIO gyroscope driver
>>
>> Generally this is an attempt to generalize sensors handling on some
>> Samsung
>> boards which have multiple sensors IC and also sensorhub does some data
>> processing itself.
>>
>> I would like to get your opinion about such solution. The idea is that
>> data communication layer gives control and data to proper IIO sensor
>> devices.
>> In this case I chose that sensor drivers are platform ones represented
>> by
>> child nodes of sensorhub in DT. These compatibles are used mainly to
>> match
>> sensor to driver. For example at this stage there is one accelerometer
>> but on
>> other board can have different one with changed data format etc. In
>> this case
>> ssp_accel_sensor driver could handle several physical devices of accel
>> class.
>> Unfortunately the firmware gives only an information about used sensor
>> type,
>> the driver can find out that there is an accelerometer on board but
>> nothing
>> specific about the sensor.
> Will look at this later... In the meantime..
Before code review I want to know your opinion if passing information
about sensors in that way is ok - It's a hack but currently the firmware
do not provide such information and I do not know if I will be able to
change it.
>> Other question:
>> The sensorhub can implement some devices which are non common for IIO
>> and hard
>> to standardise. These ones need two way communication (raw write will
>> not be
>> proper for that) and can produce data packets with flexible size to
>> 2KB).
>> I'm wondering if it is worth to look for solution in IIO and implement
>> something like IIO_BULK sensor with no standard channel description
>> or solve this problem using cdev. This is the reason why the part of
>> the
>> patchset is intended to be placed in misc.
> Out of curiosity, what are these other sensors, roughly?  If they are popular I am
>   sure there will be more out there soon!  Ideally we would work out how to standardize these. So convince is it can't be
>   done!
These are very specific for Galaxy Gear watch like movement detector, 
pedometer,
put down motion etc. The functionalities are mainly implemented by sensorhub
firmware, these ones are not physical chips. My first idea was to use 
IIO for typical
sensors only (I can have there a bunch of thermometers, accelerometers, 
lightsensors ...)
and one cdev for others. In this case data interpretation would be done 
by userspace.
So:
- these specific "sensors" will be only implemented on some Samsung's boards
and depend on firmware.
- there will be a lot of it  - most of them are represented by an 
integer value but there
are some which can send much more data.

>> Regards,
>> Karol
>>
>> Karol Wrona (6):
>>   iio:sensorhub: Add sensorhub common library
>>   misc: sensorhub: Add sensorhub driver
>>   sensorhub: Add sensorhub bindings
>>   iio: sensorhub: Add sensorhub iio commons
>>   iio: sensorhub: Add sensorhub accelerometer sensor
>>   iio: sensorhub: Add sensorhub gyroscope sensor
>>
>> .../devicetree/bindings/misc/sensorhub.txt         |   51 ++
>> drivers/iio/accel/Makefile                         |    2 +
>> drivers/iio/accel/ssp_accel_sensor.c               |  240 ++++++
>> drivers/iio/common/Kconfig                         |    1 +
>> drivers/iio/common/Makefile                        |    1 +
>> drivers/iio/common/ssp_sensors/Kconfig             |   15 +
>> drivers/iio/common/ssp_sensors/Makefile            |    6 +
>> .../iio/common/ssp_sensors/ssp-sensor-trigger.c    |   92 +++
>> drivers/iio/common/ssp_sensors/ssp_iio.c           |   35 +
>> drivers/iio/common/ssp_sensors/ssp_iio_sensor.h    |   62 ++
>> drivers/iio/gyro/Makefile                          |    2 +
>> drivers/iio/gyro/ssp_gyro_sensor.c                 |  225 ++++++
>> drivers/misc/Kconfig                               |    1 +
>> drivers/misc/Makefile                              |    1 +
>> drivers/misc/sensorhub/Kconfig                     |   13 +
>> drivers/misc/sensorhub/Makefile                    |    8 +
>> drivers/misc/sensorhub/ssp.h                       |  323 ++++++++
>> drivers/misc/sensorhub/ssp_data.c                  |   61 ++
>> drivers/misc/sensorhub/ssp_dev.c                   |  782
>> ++++++++++++++++++++
>> drivers/misc/sensorhub/ssp_firmware.c              |  571
>> ++++++++++++++
>> drivers/misc/sensorhub/ssp_spi.c                   |  700
>> ++++++++++++++++++
>> include/linux/iio/common/ssp_sensors.h             |   82 ++
>> 22 files changed, 3274 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/misc/sensorhub.txt
>> create mode 100644 drivers/iio/accel/ssp_accel_sensor.c
>> create mode 100644 drivers/iio/common/ssp_sensors/Kconfig
>> create mode 100644 drivers/iio/common/ssp_sensors/Makefile
>> create mode 100644 drivers/iio/common/ssp_sensors/ssp-sensor-trigger.c
>> create mode 100644 drivers/iio/common/ssp_sensors/ssp_iio.c
>> create mode 100644 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
>> create mode 100644 drivers/iio/gyro/ssp_gyro_sensor.c
>> create mode 100644 drivers/misc/sensorhub/Kconfig
>> create mode 100644 drivers/misc/sensorhub/Makefile
>> create mode 100644 drivers/misc/sensorhub/ssp.h
>> create mode 100644 drivers/misc/sensorhub/ssp_data.c
>> create mode 100644 drivers/misc/sensorhub/ssp_dev.c
>> create mode 100644 drivers/misc/sensorhub/ssp_firmware.c
>> create mode 100644 drivers/misc/sensorhub/ssp_spi.c
>> create mode 100644 include/linux/iio/common/ssp_sensors.h

