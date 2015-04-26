Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41921 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbbDZRZ2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 13:25:28 -0400
Message-ID: <553D1F85.9090801@kernel.org>
Date: Sun, 26 Apr 2015 18:25:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis Ciocca <denis.ciocca@st.com>,
	Alban Bedel <alban.bedel@avionic-design.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee.jones@linaro.org>,
	Robert Dolca <robert.dolca@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio:st_sensors: Fix oops when probing SPI devices
References: <1429531038-20225-1-git-send-email-alban.bedel@avionic-design.de> <55386144.70605@st.com>
In-Reply-To: <55386144.70605@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/04/15 04:04, Denis Ciocca wrote:
> Hi Alban,
> 
> after several months I'm finally back. I already did this patch, but I had no time to submit. Thanks to your support it is ok for me!
> 
Welcome back ;)
> We need to propagate also the patch to fix previous kernel versions...
> 
> Acked-by: Denis Ciocca <denis.ciocca@st.com>
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

Jonathan
> 
> Denis
> 
> 
> On 04/20/2015 07:57 PM, Alban Bedel wrote:
>> In SPI mode the transfer buffer is locked with a mutex. However this
>> mutex is only initilized after the probe, but some transfer needs to
>> be done in the probe.
>>
>> To fix this bug we move the mutex initialization at the beginning of
>> the device probe.
>>
>> Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
>> ---
>>   drivers/iio/accel/st_accel_core.c               | 1 +
>>   drivers/iio/common/st_sensors/st_sensors_core.c | 2 --
>>   drivers/iio/gyro/st_gyro_core.c                 | 1 +
>>   drivers/iio/magnetometer/st_magn_core.c         | 1 +
>>   drivers/iio/pressure/st_pressure_core.c         | 1 +
>>   5 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
>> index 58d1d13..211b132 100644
>> --- a/drivers/iio/accel/st_accel_core.c
>> +++ b/drivers/iio/accel/st_accel_core.c
>> @@ -546,6 +546,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>>         indio_dev->modes = INDIO_DIRECT_MODE;
>>       indio_dev->info = &accel_info;
>> +    mutex_init(&adata->tb.buf_lock);
>>         st_sensors_power_enable(indio_dev);
>>   diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
>> index edd13d2..8dd0477 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
>> @@ -304,8 +304,6 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
>>       struct st_sensors_platform_data *of_pdata;
>>       int err = 0;
>>   -    mutex_init(&sdata->tb.buf_lock);
>> -
>>       /* If OF/DT pdata exists, it will take precedence of anything else */
>>       of_pdata = st_sensors_of_probe(indio_dev->dev.parent, pdata);
>>       if (of_pdata)
>> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
>> index 21395f2..ffe9664 100644
>> --- a/drivers/iio/gyro/st_gyro_core.c
>> +++ b/drivers/iio/gyro/st_gyro_core.c
>> @@ -400,6 +400,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
>>         indio_dev->modes = INDIO_DIRECT_MODE;
>>       indio_dev->info = &gyro_info;
>> +    mutex_init(&gdata->tb.buf_lock);
>>         st_sensors_power_enable(indio_dev);
>>   diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
>> index 8ade473..2e56f81 100644
>> --- a/drivers/iio/magnetometer/st_magn_core.c
>> +++ b/drivers/iio/magnetometer/st_magn_core.c
>> @@ -369,6 +369,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
>>         indio_dev->modes = INDIO_DIRECT_MODE;
>>       indio_dev->info = &magn_info;
>> +    mutex_init(&mdata->tb.buf_lock);
>>         st_sensors_power_enable(indio_dev);
>>   diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
>> index 97baf40d..e881fa6 100644
>> --- a/drivers/iio/pressure/st_pressure_core.c
>> +++ b/drivers/iio/pressure/st_pressure_core.c
>> @@ -417,6 +417,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>>         indio_dev->modes = INDIO_DIRECT_MODE;
>>       indio_dev->info = &press_info;
>> +    mutex_init(&press_data->tb.buf_lock);
>>         st_sensors_power_enable(indio_dev);
>>   
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

