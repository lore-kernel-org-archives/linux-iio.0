Return-Path: <SRS0=3Myq=56=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170625171404.4ee965c7@kernel.org>
References: <20170625152413.22325-1-lorenzo.bianconi@st.com>
 <20170625152413.22325-2-lorenzo.bianconi@st.com> <20170625171404.4ee965c7@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sun, 25 Jun 2017 18:20:33 +0200
Message-ID: <CAA2SeNKs8VZehYWpGjnPzTn4N5dzK6VxQs5=e51p2cXVWzPkig@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] iio: accel: st_accel_spi: add OF capability to st_accel_spi
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Sun, 25 Jun 2017 17:24:10 +0200
> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
>
>> Add device tree support for LIS3DH, LSM330D, LSM330DL, LSM330DLC,
>> LIS331DLH, LSM330, LSM303AGR, LIS2DH12, LIS3L02DQ, LNG2DM accel sensors.
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> ---
>>  drivers/iio/accel/st_accel_spi.c | 67 +++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 59 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
>> index d13742edee0e..a8b61daa83d7 100644
>> --- a/drivers/iio/accel/st_accel_spi.c
>> +++ b/drivers/iio/accel/st_accel_spi.c
>> @@ -18,6 +18,63 @@
>>  #include <linux/iio/common/st_sensors_spi.h>
>>  #include "st_accel.h"
>>
>> +#ifdef CONFIG_OF
>> +/*
>> + * For new single-chip sensors use <device_name> as compatible string.
>> + * For old single-chip devices keep <device_name>-accel to maintain
>> + * compatibility
>> + */
>> +static const struct of_device_id st_accel_of_match[] = {
>> +     {
>> +             .compatible = "st,lis302dl-spi"
> Leaving this without some explanation of why it doesn't have
> .data set requires a comment at least. It will result
> in the name never being set - or ending up as
> the default spi->modalias anyway.. Presumably not what is
> desired?
>
> If I have missed something about why this works, please
> add a comment here in v3 to explain it.

Right, it will not work, but it needs a device (lis3lv02dl) that is
not currently support in st_accel_spi.
So I preferred to fix OF capability for currently supported devices
and add missing ones (LIS3LV02DL, LIS331DL and H3LIS331DL)
in a subsequent patch. What do you think? Is it better to squash the
two patches together?

Regards,
Lorenzo

>> +     },
>> +     {
>> +             .compatible = "st,lis3dh-accel",
>> +             .data = LIS3DH_ACCEL_DEV_NAME,
>> +     },
>> +     {
>> +             .compatible = "st,lsm330d-accel",
>> +             .data = LSM330D_ACCEL_DEV_NAME,
>> +     },
>> +     {
>> +             .compatible = "st,lsm330dl-accel",
>> +             .data = LSM330DL_ACCEL_DEV_NAME,
>> +     },
>> +     {
>> +             .compatible = "st,lsm330dlc-accel",
>> +             .data = LSM330DLC_ACCEL_DEV_NAME,
>> +     },
>> +     {
>> +             .compatible = "st,lis331dlh-accel",
>> +             .data = LIS331DLH_ACCEL_DEV_NAME,
>> +     },
>> +     {
>> +             .compatible = "st,lsm330-accel",
>> +             .data = LSM330_ACCEL_DEV_NAME,
>> +     },
>> +     {
>> +             .compatible = "st,lsm303agr-accel",
>> +             .data = LSM303AGR_ACCEL_DEV_NAME,
>> +     },
>> +     {
>> +             .compatible = "st,lis2dh12-accel",
>> +             .data = LIS2DH12_ACCEL_DEV_NAME,
>> +     },
>> +     {
>> +             .compatible = "st,lis3l02dq",
>> +             .data = LIS3L02DQ_ACCEL_DEV_NAME,
>> +     },
>> +     {
>> +             .compatible = "st,lng2dm-accel",
>> +             .data = LNG2DM_ACCEL_DEV_NAME,
>> +     },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(of, st_accel_of_match);
>> +#else
>> +#define st_accel_of_match    NULL
>> +#endif
>> +
>>  static int st_accel_spi_probe(struct spi_device *spi)
>>  {
>>       struct iio_dev *indio_dev;
>> @@ -30,6 +87,8 @@ static int st_accel_spi_probe(struct spi_device *spi)
>>
>>       adata = iio_priv(indio_dev);
>>
>> +     st_sensors_of_name_probe(&spi->dev, st_accel_of_match,
>> +                              spi->modalias, sizeof(spi->modalias));
>>       st_sensors_spi_configure(indio_dev, spi, adata);
>>
>>       err = st_accel_common_probe(indio_dev);
>> @@ -61,14 +120,6 @@ static const struct spi_device_id st_accel_id_table[] = {
>>  };
>>  MODULE_DEVICE_TABLE(spi, st_accel_id_table);
>>
>> -#ifdef CONFIG_OF
>> -static const struct of_device_id st_accel_of_match[] = {
>> -     { .compatible = "st,lis302dl-spi" },
>> -     {}
>> -};
>> -MODULE_DEVICE_TABLE(of, st_accel_of_match);
>> -#endif
>> -
>>  static struct spi_driver st_accel_driver = {
>>       .driver = {
>>               .name = "st-accel-spi",
>



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
