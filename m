Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:33001 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab1IWOha (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2011 10:37:30 -0400
Message-ID: <4E7C9B9D.3080407@cam.ac.uk>
Date: Fri, 23 Sep 2011 15:45:49 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>,
	"manuel.stahl@iis.fraunhofer.de" <manuel.stahl@iis.fraunhofer.de>
Subject: Re: [PATCH 2/4] staging:iio:imu:adis16344 support
References: <1310399887-4049-1-git-send-email-jic23@cam.ac.uk> <1310399887-4049-3-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917713EA0CD0E5B@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713EA0CD0E5B@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I know this was a while ago, but I have a feeling I may have made up
this part number and it is infact called an adis16334?

Can anyone shed any light on this?

Whatever happened, I'll put together a patch changing the naming given it
is clearly wrong!
> Jonathan Cameron wrote on 2011-07-11:
>> Simple device. Note the sparse scan mask used.
>>
>> Done from datasheet as very similar to existing parts.
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> 
>> ---
>>  drivers/staging/iio/imu/adis16400_core.c |   46
>>  +++++++++++++++++++++++++++++- 1 files changed, 45 insertions(+), 1
>>  deletions(-)
>> diff --git a/drivers/staging/iio/imu/adis16400_core.c
>> b/drivers/staging/iio/imu/adis16400_core.c index 66fc156..f034330 100644
>> --- a/drivers/staging/iio/imu/adis16400_core.c +++
>> b/drivers/staging/iio/imu/adis16400_core.c @@ -35,6 +35,7 @@
>>
>>  enum adis16400_chip_variant {        ADIS16300, +    ADIS16344,      ADIS16350,
>>       ADIS16360,      ADIS16362, @@ -458,7 +459,7 @@ static u8
>>  adis16400_addresses[17][2] = {       [temp2] = { ADIS16350_ZTEMP_OUT },
>>       [in1] = { ADIS16400_AUX_ADC, 0 },       [incli_x] = { ADIS16300_PITCH_OUT,
>>  0 },
>> -     [incli_y] = { ADIS16300_ROLL_OUT, 0 }
>> +     [incli_y] = { ADIS16300_ROLL_OUT, 0 },
>>  };
>>
>>  static int adis16400_write_raw(struct iio_dev *indio_dev, @@ -690,6
>>  +691,38 @@ static struct iio_chan_spec adis16300_channels[] = {
>>       IIO_CHAN_SOFT_TIMESTAMP(14) };
>> +static const struct iio_chan_spec adis16344_channels[] = {
>> +     IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_X, +                (1 <<
>> IIO_CHAN_INFO_CALIBBIAS_SEPARATE) | +          (1 <<
>> IIO_CHAN_INFO_SCALE_SHARED), +                 gyro_x, ADIS16400_SCAN_GYRO_X,
>> IIO_ST('s', 14, 16, 0), 0), + IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0,
>> IIO_MOD_Y, +           (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) | +             (1 <<
>> IIO_CHAN_INFO_SCALE_SHARED), +                 gyro_y, ADIS16400_SCAN_GYRO_Y,
>> IIO_ST('s', 14, 16, 0), 0), + IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0,
>> IIO_MOD_Z, +           (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) | +             (1 <<
>> IIO_CHAN_INFO_SCALE_SHARED), +                 gyro_z, ADIS16400_SCAN_GYRO_Z,
>> IIO_ST('s', 14, 16, 0), 0), + IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0,
>> IIO_MOD_X, +           (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) | +             (1 <<
>> IIO_CHAN_INFO_SCALE_SHARED), +                 accel_x, ADIS16400_SCAN_ACC_X,
>> IIO_ST('s', 14, 16, 0), 0), + IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0,
>> IIO_MOD_Y, +           (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) | +             (1 <<
>> IIO_CHAN_INFO_SCALE_SHARED), +                 accel_y, ADIS16400_SCAN_ACC_Y,
>> IIO_ST('s', 14, 16, 0), 0), + IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0,
>> IIO_MOD_Z, +           (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) | +             (1 <<
>> IIO_CHAN_INFO_SCALE_SHARED), +                 accel_z, ADIS16400_SCAN_ACC_Z,
>> IIO_ST('s', 14, 16, 0), 0), + IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
>> +              (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) | +                (1 <<
>> IIO_CHAN_INFO_SCALE_SEPARATE), +               temp0, ADIS16350_SCAN_TEMP_X,
>> IIO_ST('s', 12, 16, 0), 0), + IIO_CHAN_SOFT_TIMESTAMP(12) +}; +
>>  static struct attribute *adis16400_attributes[] = {
>>       &iio_dev_attr_sampling_frequency.dev_attr.attr,
>>       &iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> @@ -714,6 +747,16 @@ static struct adis16400_chip_info
>> adis16400_chips[] = {
>>               (1 << ADIS16300_SCAN_INCLI_X) | (1 << ADIS16300_SCAN_INCLI_Y) |                 (1
>>  << 14),      },
>> +     [ADIS16344] = {
>> +             .channels = adis16344_channels,
>> +             .num_channels = ARRAY_SIZE(adis16344_channels),
>> +             .gyro_scale_micro = 873,
>> +             .accel_scale_micro = 981,
>> +             .default_scan_mask = (1 << ADIS16400_SCAN_GYRO_X) |
>> +             (1 << ADIS16400_SCAN_GYRO_Y) | (1 << ADIS16400_SCAN_GYRO_Z)
>> |
>> +             (1 << ADIS16400_SCAN_ACC_X) | (1 << ADIS16400_SCAN_ACC_Y) |
>> +             (1 << ADIS16400_SCAN_ACC_Z),
>> +     },
>>       [ADIS16350] = {
>>               .channels = adis16350_channels,
>>               .num_channels = ARRAY_SIZE(adis16350_channels), @@ -869,6
>> +912,7 @@ err_ret:
>>
>  static const struct spi_device_id adis16400_id[] = {   {"adis16300",
>  ADIS16300}, +  {"adis16344", ADIS16344},       {"adis16350", ADIS16350},
>         {"adis16354", ADIS16350},       {"adis16355", ADIS16350},
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 
> 

