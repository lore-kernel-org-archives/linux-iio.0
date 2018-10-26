Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33220 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJZLK0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Oct 2018 07:10:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id a15-v6so1332529pfn.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Oct 2018 19:35:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] iio:magnetometer: st_magn: add LSM9DS1 support
To: Denis CIOCCA <denis.ciocca@st.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
References: <20181024013948.16326-1-martin@martingkelly.com>
 <CAA2SeN+FiBEWJnbzGZssGQB3zq5RqQgQ-1D2YQvJeZwsfkS7gQ@mail.gmail.com>
 <86c25419092243fc91ff33854d814efa@SFHDAG2NODE1.st.com>
From: Martin Kelly <martin@martingkelly.com>
Message-ID: <69487cfc-33b3-dae3-6385-a6e63c1b3c3a@martingkelly.com>
Date: Thu, 25 Oct 2018 19:35:15 -0700
MIME-Version: 1.0
In-Reply-To: <86c25419092243fc91ff33854d814efa@SFHDAG2NODE1.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/25/18 2:13 PM, Denis CIOCCA wrote:
> Hi Martin, Lorenzo,
> 
> Inline my comments.
> 
> -----Original Message-----
> From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> Sent: Thursday, October 25, 2018 1:17 AM
> To: Martin Kelly <martin@martingkelly.com>
> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; Denis CIOCCA <denis.ciocca@st.com>; Jonathan Cameron <jic23@kernel.org>; robh+dt@kernel.org; mark.rutland@arm.com
> Subject: Re: [PATCH 1/2] iio:magnetometer: st_magn: add LSM9DS1 support
> 
>>
>> From: Martin Kelly <martin@martingkelly.com>
>>
>> Update the sensor settings to support the LSM9DS1 sensor. Although the
>> LSM9DS1 accelerometer and gyroscope are coupled together to use the
>> same FIFO, the magnetometer is separate and can be cleanly supported
>> without refactoring the existing driver.
>>
>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
>> ---
>>   drivers/iio/magnetometer/st_magn.h      |  1 +
>>   drivers/iio/magnetometer/st_magn_core.c | 68
>> +++++++++++++++++++++++++++++++++
>> drivers/iio/magnetometer/st_magn_spi.c  |  5 +++
>>   3 files changed, 74 insertions(+)
>>
>> diff --git a/drivers/iio/magnetometer/st_magn.h
>> b/drivers/iio/magnetometer/st_magn.h
>> index 8fe51ce427bd..3a4abcd1f106 100644
>> --- a/drivers/iio/magnetometer/st_magn.h
>> +++ b/drivers/iio/magnetometer/st_magn.h
>> @@ -20,6 +20,7 @@
>>   #define LIS3MDL_MAGN_DEV_NAME          "lis3mdl"
>>   #define LSM303AGR_MAGN_DEV_NAME                "lsm303agr_magn"
>>   #define LIS2MDL_MAGN_DEV_NAME          "lis2mdl"
>> +#define LSM9DS1_MAGN_DEV_NAME          "lsm9ds1"
> 
> It should be "lsm9ds1_magn" since lsm9ds1 identify A+G+M. As you can see in lsm303xxx series.
> 
> 
>>
>>   int st_magn_common_probe(struct iio_dev *indio_dev);  void
>> st_magn_common_remove(struct iio_dev *indio_dev); diff --git
>> a/drivers/iio/magnetometer/st_magn_core.c
>> b/drivers/iio/magnetometer/st_magn_core.c
>> index 72f6d1335a04..dfbdeb428467 100644
>> --- a/drivers/iio/magnetometer/st_magn_core.c
>> +++ b/drivers/iio/magnetometer/st_magn_core.c
>> @@ -378,6 +378,74 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>>                  .multi_read_bit = false,
>>                  .bootime = 2,
>>          },
>> +       {
>> +               .wai = 0x3d,
>> +               .wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>> +               .sensors_supported = {
>> +                       [0] = LSM9DS1_MAGN_DEV_NAME,
> 
> according to the following register map I guess we can simply add lsm9ds1-magn device name in lis3mdl sensors_supported list
> 
> Agree with Lorenzo
> 

Ah, I didn't notice that, thanks! The one difference between the two is 
that LIS3MDL doesn't specify .bdu, but I'll add that in as a separate 
patch in v2.

> 
>> +               },
>> +               .ch = (struct iio_chan_spec *)st_magn_2_16bit_channels,
>> +               .odr = {
>> +                       /* Fast ODR mode currently not supported. */
>> +                       .addr = 0x20,
>> +                       .mask = 0x1c,
>> +                       .odr_avl = {
>> +                               { .hz = 5, .value = 0x03 },
>> +                               { .hz = 10, .value = 0x04 },
>> +                               { .hz = 20, .value = 0x05 },
>> +                               { .hz = 40, .value = 0x06 },
>> +                               { .hz = 80, .value = 0x07 },
>> +                       },
>> +               },
>> +               .pw = {
>> +                       .addr = 0x22,
>> +                       .mask = 0x03,
>> +                       .value_on = 0x00,
>> +                       .value_off = 0x03,
>> +               },
>> +               .fs = {
>> +                       .addr = 0x21,
>> +                       .mask = 0x60,
>> +                       .fs_avl = {
>> +                               [0] = {
>> +                                       .num = ST_MAGN_FS_AVL_4000MG,
>> +                                       .value = 0x00,
>> +                                       .gain = 140,
>> +                               },
>> +                               [1] = {
>> +                                       .num = ST_MAGN_FS_AVL_8000MG,
>> +                                       .value = 0x01,
>> +                                       .gain = 290,
>> +                               },
>> +                               [2] = {
>> +                                       .num = ST_MAGN_FS_AVL_12000MG,
>> +                                       .value = 0x02,
>> +                                       .gain = 430,
>> +                               },
>> +                               [3] = {
>> +                                       .num = ST_MAGN_FS_AVL_16000MG,
>> +                                       .value = 0x03,
>> +                                       .gain = 580,
>> +                               },
>> +                       },
>> +               },
>> +               .bdu = {
>> +                       .addr = 0x24,
>> +                       .mask = 0x40,
>> +               },
>> +               .drdy_irq = {
>> +                       .stat_drdy = {
>> +                               .addr = ST_SENSORS_DEFAULT_STAT_ADDR,
>> +                               .mask = 0x07,
>> +                       },
>> +               },
>> +               .sim = {
>> +                       .addr = 0x22,
>> +                       .value = BIT(2),
>> +               },
>> +               .multi_read_bit = true,
>> +               .bootime = 2,
>> +       },
>>   };
>>
>>   static int st_magn_read_raw(struct iio_dev *indio_dev, diff --git
>> a/drivers/iio/magnetometer/st_magn_spi.c
>> b/drivers/iio/magnetometer/st_magn_spi.c
>> index 7b7cd08fcc32..433456920673 100644
>> --- a/drivers/iio/magnetometer/st_magn_spi.c
>> +++ b/drivers/iio/magnetometer/st_magn_spi.c
>> @@ -37,6 +37,10 @@ static const struct of_device_id st_magn_of_match[] = {
>>                  .compatible = "st,lis2mdl",
>>                  .data = LIS2MDL_MAGN_DEV_NAME,
>>          },
>> +       {
>> +               .compatible = "st,lsm9ds1",
> 
> As suggested from Lorenzo, it should be "st,lsm9ds1-magn"
> 
> 
>> +               .data = LSM9DS1_MAGN_DEV_NAME,
>> +       },
>>          {}
>>   };
>>   MODULE_DEVICE_TABLE(of, st_magn_of_match); @@ -79,6 +83,7 @@ static
>> const struct spi_device_id st_magn_id_table[] = {
>>          { LIS3MDL_MAGN_DEV_NAME },
>>          { LSM303AGR_MAGN_DEV_NAME },
>>          { LIS2MDL_MAGN_DEV_NAME },
>> +       { LSM9DS1_MAGN_DEV_NAME },
>>          {},
>>   };
>>   MODULE_DEVICE_TABLE(spi, st_magn_id_table);
>> --
> 
> I guess you missed the i2c counterpart.
> 

Yeah, I misread the datasheet as supporting only SPI for the 
magnetometer. I tested with I2C and it's working now in my v2 patch.

> Regards,
> Lorenzo
> 
>> 2.11.0
>>
> 
> 
> --
> UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch; unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp; umount; make clean; sleep
> 
