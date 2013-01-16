Return-Path: <lars@metafoo.de>
Message-ID: <50F6B43F.4080306@metafoo.de>
Date: Wed, 16 Jan 2013 15:07:59 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/15] staging:iio:adis16400: Code style cleanup
References: <1358340531-31350-1-git-send-email-lars@metafoo.de> <50F6A410.80708@jic23.retrosnub.co.uk> <50F6A6FC.6020800@metafoo.de> <201301161457.59987.manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <201301161457.59987.manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/16/2013 02:57 PM, Manuel Stahl wrote:
> Hi everyone,
> 
> just cought that one up.
> I think there was a strong policy to use u8 etc in the kernel. Linus wrote something about it some time ago.
> 

That's what the advocates of u8, etc like to tell ;)


> Am Mittwoch, 16. Januar 2013, 14:11:24 schrieb Lars-Peter Clausen:
>> On 01/16/2013 01:58 PM, Jonathan Cameron wrote:
>>> On 16/01/13 12:48, Lars-Peter Clausen wrote:
>>>> Do a set of minor miscellaneous code style cleanups for the adis16400 before
>>>> moving it out of staging. Delete outdated comments, removed excess
>>>> whitespace,
>>>> add missing whitespace, replace u{8,16} with uint{8,16}_t.
>>>
>>> Is there a move that I've missed to move away from u8 and friends?
>>
>> Unfortunately not. I think the policy is more or less use whichever you
>> like. But I definitely prefer uint16_t and friends since it's the official C
>> type for that type. Also most of the other adis drivers including the
>> library use uint{8,16,32}_t so it's only consistent.
>>
>> I wouldn't have done this if it had been the only style issue, but since the
>> file needed a cleanup anyway I thought I'd include this as well.
>>
>> - Lars
>>
>>>>
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>> ---
>>>>   drivers/staging/iio/imu/adis16400_core.c | 81
>>>> +++++++++++++++-----------------
>>>>   1 file changed, 37 insertions(+), 44 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/iio/imu/adis16400_core.c
>>>> b/drivers/staging/iio/imu/adis16400_core.c
>>>> index c08490b..1bbe5ee 100644
>>>> --- a/drivers/staging/iio/imu/adis16400_core.c
>>>> +++ b/drivers/staging/iio/imu/adis16400_core.c
>>>> @@ -45,7 +45,7 @@ enum adis16400_chip_variant {
>>>>   static int adis16334_get_freq(struct adis16400_state *st)
>>>>   {
>>>>       int ret;
>>>> -    u16 t;
>>>> +    uint16_t t;
>>>>
>>>>       ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
>>>>       if (ret < 0)
>>>> @@ -78,12 +78,13 @@ static int adis16334_set_freq(struct adis16400_state
>>>> *st, unsigned int freq)
>>>>   static int adis16400_get_freq(struct adis16400_state *st)
>>>>   {
>>>>       int sps, ret;
>>>> -    u16 t;
>>>> +    uint16_t t;
>>>>
>>>>       ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
>>>>       if (ret < 0)
>>>>           return ret;
>>>> -    sps =  (t & ADIS16400_SMPL_PRD_TIME_BASE) ? 53 : 1638;
>>>> +
>>>> +    sps = (t & ADIS16400_SMPL_PRD_TIME_BASE) ? 53 : 1638;
>>>>       sps /= (t & ADIS16400_SMPL_PRD_DIV_MASK) + 1;
>>>>
>>>>       return sps;
>>>> @@ -97,6 +98,7 @@ static int adis16400_set_freq(struct adis16400_state
>>>> *st, unsigned int freq)
>>>>       if (t > 0)
>>>>           t--;
>>>>       t &= ADIS16400_SMPL_PRD_DIV_MASK;
>>>> +
>>>>       if ((t & ADIS16400_SMPL_PRD_DIV_MASK) >= 0x0A)
>>>>           st->adis.spi->max_speed_hz = ADIS16400_SPI_SLOW;
>>>>       else
>>>> @@ -111,13 +113,13 @@ static ssize_t adis16400_read_frequency(struct
>>>> device *dev,
>>>>   {
>>>>       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>>>       struct adis16400_state *st = iio_priv(indio_dev);
>>>> -    int ret, len = 0;
>>>> +    int ret;
>>>>
>>>>       ret = st->variant->get_freq(st);
>>>>       if (ret < 0)
>>>>           return ret;
>>>> -    len = sprintf(buf, "%d\n", ret);
>>>> -    return len;
>>>> +
>>>> +    return sprintf(buf, "%d\n", ret);
>>>>   }
>>>>
>>>>   static const unsigned adis16400_3db_divisors[] = {
>>>> @@ -134,8 +136,8 @@ static const unsigned adis16400_3db_divisors[] = {
>>>>   static int adis16400_set_filter(struct iio_dev *indio_dev, int sps, int
>>>> val)
>>>>   {
>>>>       struct adis16400_state *st = iio_priv(indio_dev);
>>>> +    uint16_t val16;
>>>>       int i, ret;
>>>> -    u16 val16;
>>>>
>>>>       for (i = ARRAY_SIZE(adis16400_3db_divisors) - 1; i >= 1; i--) {
>>>>           if (sps / adis16400_3db_divisors[i] >= val)
>>>> @@ -152,26 +154,22 @@ static int adis16400_set_filter(struct iio_dev
>>>> *indio_dev, int sps, int val)
>>>>   }
>>>>
>>>>   static ssize_t adis16400_write_frequency(struct device *dev,
>>>> -        struct device_attribute *attr,
>>>> -        const char *buf,
>>>> -        size_t len)
>>>> +    struct device_attribute *attr, const char *buf, size_t len)
>>>>   {
>>>>       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>>>       struct adis16400_state *st = iio_priv(indio_dev);
>>>>       long val;
>>>>       int ret;
>>>>
>>>> -    ret = strict_strtol(buf, 10, &val);
>>>> +    ret = kstrtol(buf, 10, &val);
>>>>       if (ret)
>>>>           return ret;
>>>> +
>>>>       if (val == 0)
>>>>           return -EINVAL;
>>>>
>>>>       mutex_lock(&indio_dev->mlock);
>>>> -
>>>>       st->variant->set_freq(st, val);
>>>> -
>>>> -    /* Also update the filter */
>>>>       mutex_unlock(&indio_dev->mlock);
>>>>
>>>>       return ret ? ret : len;
>>>> @@ -182,9 +180,9 @@ static int adis16400_stop_device(struct iio_dev
>>>> *indio_dev)
>>>>   {
>>>>       struct adis16400_state *st = iio_priv(indio_dev);
>>>>       int ret;
>>>> -    u16 val = ADIS16400_SLP_CNT_POWER_OFF;
>>>>
>>>> -    ret = adis_write_reg_16(&st->adis, ADIS16400_SLP_CNT, val);
>>>> +    ret = adis_write_reg_16(&st->adis, ADIS16400_SLP_CNT,
>>>> +            ADIS16400_SLP_CNT_POWER_OFF);
>>>>       if (ret)
>>>>           dev_err(&indio_dev->dev,
>>>>               "problem with turning device off: SLP_CNT");
>>>> @@ -194,10 +192,10 @@ static int adis16400_stop_device(struct iio_dev
>>>> *indio_dev)
>>>>
>>>>   static int adis16400_initial_setup(struct iio_dev *indio_dev)
>>>>   {
>>>> -    int ret;
>>>> -    u16 prod_id, smp_prd;
>>>> -    unsigned int device_id;
>>>>       struct adis16400_state *st = iio_priv(indio_dev);
>>>> +    uint16_t prod_id, smp_prd;
>>>> +    unsigned int device_id;
>>>> +    int ret;
>>>>
>>>>       /* use low spi speed for init if the device has a slow mode */
>>>>       if (st->variant->flags & ADIS16400_HAS_SLOW_MODE)
>>>> @@ -224,8 +222,8 @@ static int adis16400_initial_setup(struct iio_dev
>>>> *indio_dev)
>>>>                       device_id, prod_id);
>>>>
>>>>           dev_info(&indio_dev->dev, "%s: prod_id 0x%04x at CS%d (irq %d)\n",
>>>> -               indio_dev->name, prod_id,
>>>> -               st->adis.spi->chip_select, st->adis.spi->irq);
>>>> +            indio_dev->name, prod_id,
>>>> +            st->adis.spi->chip_select, st->adis.spi->irq);
>>>>       }
>>>>       /* use high spi speed if possible */
>>>>       if (st->variant->flags & ADIS16400_HAS_SLOW_MODE) {
>>>> @@ -247,7 +245,7 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
>>>>                     adis16400_read_frequency,
>>>>                     adis16400_write_frequency);
>>>>
>>>> -static const u8 adis16400_addresses[] = {
>>>> +static const uint8_t adis16400_addresses[] = {
>>>>       [ADIS16400_SCAN_GYRO_X] = ADIS16400_XGYRO_OFF,
>>>>       [ADIS16400_SCAN_GYRO_Y] = ADIS16400_YGYRO_OFF,
>>>>       [ADIS16400_SCAN_GYRO_Z] = ADIS16400_ZGYRO_OFF,
>>>> @@ -257,15 +255,12 @@ static const u8 adis16400_addresses[] = {
>>>>   };
>>>>
>>>>   static int adis16400_write_raw(struct iio_dev *indio_dev,
>>>> -                   struct iio_chan_spec const *chan,
>>>> -                   int val,
>>>> -                   int val2,
>>>> -                   long mask)
>>>> +    struct iio_chan_spec const *chan, int val, int val2, long info)
>>>>   {
>>>>       struct adis16400_state *st = iio_priv(indio_dev);
>>>>       int ret, sps;
>>>>
>>>> -    switch (mask) {
>>>> +    switch (info) {
>>>>       case IIO_CHAN_INFO_CALIBBIAS:
>>>>           mutex_lock(&indio_dev->mlock);
>>>>           ret = adis_write_reg_16(&st->adis,
>>>> @@ -273,8 +268,10 @@ static int adis16400_write_raw(struct iio_dev
>>>> *indio_dev,
>>>>           mutex_unlock(&indio_dev->mlock);
>>>>           return ret;
>>>>       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>>>> -        /* Need to cache values so we can update if the frequency
>>>> -           changes */
>>>> +        /*
>>>> +         * Need to cache values so we can update if the frequency
>>>> +         * changes.
>>>> +         */
>>>>           mutex_lock(&indio_dev->mlock);
>>>>           st->filt_int = val;
>>>>           /* Work out update to current value */
>>>> @@ -293,16 +290,13 @@ static int adis16400_write_raw(struct iio_dev
>>>> *indio_dev,
>>>>   }
>>>>
>>>>   static int adis16400_read_raw(struct iio_dev *indio_dev,
>>>> -                  struct iio_chan_spec const *chan,
>>>> -                  int *val,
>>>> -                  int *val2,
>>>> -                  long mask)
>>>> +    struct iio_chan_spec const *chan, int *val, int *val2, long info)
>>>>   {
>>>>       struct adis16400_state *st = iio_priv(indio_dev);
>>>> +    int16_t val16;
>>>>       int ret;
>>>> -    s16 val16;
>>>>
>>>> -    switch (mask) {
>>>> +    switch (info) {
>>>>       case IIO_CHAN_INFO_RAW:
>>>>           return adis_single_conversion(indio_dev, chan, 0, val);
>>>>       case IIO_CHAN_INFO_SCALE:
>>>> @@ -721,13 +715,14 @@ static const struct adis_data adis16400_data = {
>>>>
>>>>   static int adis16400_probe(struct spi_device *spi)
>>>>   {
>>>> -    int ret;
>>>>       struct adis16400_state *st;
>>>> -    struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
>>>> -    if (indio_dev == NULL) {
>>>> -        ret =  -ENOMEM;
>>>> -        goto error_ret;
>>>> -    }
>>>> +    struct iio_dev *indio_dev;
>>>> +    int ret;
>>>> +
>>>> +    indio_dev = iio_device_alloc(sizeof(*st));
>>>> +    if (indio_dev == NULL)
>>>> +        return -ENOMEM;
>>>> +
>>>>       st = iio_priv(indio_dev);
>>>>       /* this is only used for removal purposes */
>>>>       spi_set_drvdata(spi, indio_dev);
>>>> @@ -767,14 +762,12 @@ error_cleanup_buffer:
>>>>       adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
>>>>   error_free_dev:
>>>>       iio_device_free(indio_dev);
>>>> -error_ret:
>>>>       return ret;
>>>>   }
>>>>
>>>> -/* fixme, confirm ordering in this function */
>>>>   static int adis16400_remove(struct spi_device *spi)
>>>>   {
>>>> -    struct iio_dev *indio_dev =  spi_get_drvdata(spi);
>>>> +    struct iio_dev *indio_dev = spi_get_drvdata(spi);
>>>>       struct adis16400_state *st = iio_priv(indio_dev);
>>>>
>>>>       iio_device_unregister(indio_dev);
>>>>
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
