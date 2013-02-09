Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45372 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383Ab3BIPY4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Feb 2013 10:24:56 -0500
Message-ID: <51166A45.2000000@kernel.org>
Date: Sat, 09 Feb 2013 15:24:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis Ciocca <denis.ciocca@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH 2/2] iio:st_sensors fix build when !CONFIG_IIO_TRIGGER
References: <1360406967-25026-1-git-send-email-jic23@kernel.org> <1360406967-25026-3-git-send-email-jic23@kernel.org> <CAEE_umrne4=f5irjAspDbr4_+ZgB0BO0_0-tbhPnQHYHz=4c3w@mail.gmail.com>
In-Reply-To: <CAEE_umrne4=f5irjAspDbr4_+ZgB0BO0_0-tbhPnQHYHz=4c3w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/2013 11:53 AM, Denis Ciocca wrote:
>> Partly a case of removing unused headers and partly a case
>> of ifdefing out the iio_trigger_ops structures.  This has
>> come about because of an 'unusual' separation of code in this
>> driver.
> 
> Ok for me is ok.
> 
> Thanks Jonathan & Randy
I'll take that as an
Acked-by:
> 
> 
> 
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>>  drivers/iio/accel/st_accel_core.c       | 9 +++++++--
>>  drivers/iio/accel/st_accel_i2c.c        | 1 -
>>  drivers/iio/accel/st_accel_spi.c        | 1 -
>>  drivers/iio/gyro/st_gyro_core.c         | 9 +++++++--
>>  drivers/iio/gyro/st_gyro_i2c.c          | 1 -
>>  drivers/iio/gyro/st_gyro_spi.c          | 1 -
>>  drivers/iio/magnetometer/st_magn_core.c | 1 -
>>  drivers/iio/magnetometer/st_magn_i2c.c  | 1 -
>>  drivers/iio/magnetometer/st_magn_spi.c  | 1 -
>>  9 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
>> index a235de2..e0f5a3c 100644
>> --- a/drivers/iio/accel/st_accel_core.c
>> +++ b/drivers/iio/accel/st_accel_core.c
>> @@ -20,7 +20,7 @@
>>  #include <linux/irq.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>> -#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/trigger.h>
>>  #include <linux/iio/buffer.h>
>>
>>  #include <linux/iio/common/st_sensors.h>
>> @@ -419,10 +419,15 @@ static const struct iio_info accel_info = {
>>         .write_raw = &st_accel_write_raw,
>>  };
>>
>> +#ifdef CONFIG_IIO_TRIGGER
>>  static const struct iio_trigger_ops st_accel_trigger_ops = {
>>         .owner = THIS_MODULE,
>>         .set_trigger_state = ST_ACCEL_TRIGGER_SET_STATE,
>>  };
>> +#define ST_ACCEL_TRIGGER_OPS (&st_accel_trigger_ops)
>> +#else
>> +#define ST_ACCEL_TRIGGER_OPS NULL
>> +#endif
>>
>>  int st_accel_common_probe(struct iio_dev *indio_dev)
>>  {
>> @@ -455,7 +460,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>>                         goto st_accel_common_probe_error;
>>
>>                 err = st_sensors_allocate_trigger(indio_dev,
>> -                                                       &st_accel_trigger_ops);
>> +                                                ST_ACCEL_TRIGGER_OPS);
>>                 if (err < 0)
>>                         goto st_accel_probe_trigger_error;
>>         }
>> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
>> index 90b8ddf..ffc9d09 100644
>> --- a/drivers/iio/accel/st_accel_i2c.c
>> +++ b/drivers/iio/accel/st_accel_i2c.c
>> @@ -13,7 +13,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/i2c.h>
>>  #include <linux/iio/iio.h>
>> -#include <linux/iio/trigger.h>
>>
>>  #include <linux/iio/common/st_sensors.h>
>>  #include <linux/iio/common/st_sensors_i2c.h>
>> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
>> index dbd45c0..22b35bf 100644
>> --- a/drivers/iio/accel/st_accel_spi.c
>> +++ b/drivers/iio/accel/st_accel_spi.c
>> @@ -13,7 +13,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/iio/iio.h>
>> -#include <linux/iio/trigger.h>
>>
>>  #include <linux/iio/common/st_sensors.h>
>>  #include <linux/iio/common/st_sensors_spi.h>
>> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
>> index 0a09998..fa9b242 100644
>> --- a/drivers/iio/gyro/st_gyro_core.c
>> +++ b/drivers/iio/gyro/st_gyro_core.c
>> @@ -21,7 +21,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>> -#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/trigger.h>
>>  #include <linux/iio/buffer.h>
>>
>>  #include <linux/iio/common/st_sensors.h>
>> @@ -287,10 +287,15 @@ static const struct iio_info gyro_info = {
>>         .write_raw = &st_gyro_write_raw,
>>  };
>>
>> +#ifdef CONFIG_IIO_TRIGGER
>>  static const struct iio_trigger_ops st_gyro_trigger_ops = {
>>         .owner = THIS_MODULE,
>>         .set_trigger_state = ST_GYRO_TRIGGER_SET_STATE,
>>  };
>> +#define ST_GYRO_TRIGGER_OPS (&st_gyro_trigger_ops)
>> +#else
>> +#define ST_GYRO_TRIGGER_OPS NULL
>> +#endif
>>
>>  int st_gyro_common_probe(struct iio_dev *indio_dev)
>>  {
>> @@ -323,7 +328,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
>>                         goto st_gyro_common_probe_error;
>>
>>                 err = st_sensors_allocate_trigger(indio_dev,
>> -                                                       &st_gyro_trigger_ops);
>> +                                                 ST_GYRO_TRIGGER_OPS);
>>                 if (err < 0)
>>                         goto st_gyro_probe_trigger_error;
>>         }
>> diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
>> index a44b5b4..8a31050 100644
>> --- a/drivers/iio/gyro/st_gyro_i2c.c
>> +++ b/drivers/iio/gyro/st_gyro_i2c.c
>> @@ -13,7 +13,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/i2c.h>
>>  #include <linux/iio/iio.h>
>> -#include <linux/iio/trigger.h>
>>
>>  #include <linux/iio/common/st_sensors.h>
>>  #include <linux/iio/common/st_sensors_i2c.h>
>> diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
>> index 8b4dcc5..f354039 100644
>> --- a/drivers/iio/gyro/st_gyro_spi.c
>> +++ b/drivers/iio/gyro/st_gyro_spi.c
>> @@ -13,7 +13,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/iio/iio.h>
>> -#include <linux/iio/trigger.h>
>>
>>  #include <linux/iio/common/st_sensors.h>
>>  #include <linux/iio/common/st_sensors_spi.h>
>> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
>> index a69fbe1..16f0d6d 100644
>> --- a/drivers/iio/magnetometer/st_magn_core.c
>> +++ b/drivers/iio/magnetometer/st_magn_core.c
>> @@ -21,7 +21,6 @@
>>  #include <linux/delay.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>> -#include <linux/iio/trigger_consumer.h>
>>  #include <linux/iio/buffer.h>
>>
>>  #include <linux/iio/common/st_sensors.h>
>> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
>> index 710b256a5..e6adc4a 100644
>> --- a/drivers/iio/magnetometer/st_magn_i2c.c
>> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
>> @@ -13,7 +13,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/i2c.h>
>>  #include <linux/iio/iio.h>
>> -#include <linux/iio/trigger.h>
>>
>>  #include <linux/iio/common/st_sensors.h>
>>  #include <linux/iio/common/st_sensors_i2c.h>
>> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
>> index 94547e7..51adb79 100644
>> --- a/drivers/iio/magnetometer/st_magn_spi.c
>> +++ b/drivers/iio/magnetometer/st_magn_spi.c
>> @@ -13,7 +13,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/iio/iio.h>
>> -#include <linux/iio/trigger.h>
>>
>>  #include <linux/iio/common/st_sensors.h>
>>  #include <linux/iio/common/st_sensors_spi.h>
>> --
>> 1.8.1.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
