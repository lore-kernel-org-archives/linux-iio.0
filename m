Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0072.outbound.protection.outlook.com ([104.47.42.72]:22092
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752149AbeEPQ1o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 May 2018 12:27:44 -0400
Subject: Re: [PATCH 5/5] iio: imu: inv_mpu6050: new timestamp mechanism
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org
References: <1526331955-11869-1-git-send-email-jmaneyrol@invensense.com>
 <1526331955-11869-5-git-send-email-jmaneyrol@invensense.com>
 <c34a1949-da29-4b7b-a1d4-0cf787913c6d@xevo.com>
 <e932fe24-4812-d512-c63f-ce9bf69a6137@invensense.com>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <75b0c02e-2388-6ae0-2a27-f1fdb1d503cf@xevo.com>
Date: Wed, 16 May 2018 09:27:35 -0700
MIME-Version: 1.0
In-Reply-To: <e932fe24-4812-d512-c63f-ce9bf69a6137@invensense.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/16/2018 12:33 AM, Jean-Baptiste Maneyrol wrote:
> 
> 
> On 15/05/2018 21:31, Martin Kelly wrote:
>> CAUTION: This email originated from outside of the organization. 
>> Please make sure the sender is who they say they are and do not click 
>> links or open attachments unless you recognize the sender and know the 
>> content is safe.
>>
>>
>> On 05/14/2018 02:05 PM, Jean-Baptiste Maneyrol wrote:
>>> Check validity of interrupt timestamps by computing time between
>>> 2 interrupts. If it matches the chip frequency modulo 4%, it is
>>> used as the data timestamp and also for estimating the chip
>>> frequency measured from the system. Otherwise timestamp is
>>> computed using the estimated chip frequency.
>>>
>>> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>>> ---
>>>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  7 +++
>>>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  8 +++
>>>   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 78 
>>> +++++++++++++++++++++++++++++-
>>>   3 files changed, 92 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c 
>>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> index 9e5c5e7..ade6294 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> @@ -295,6 +295,13 @@ static int inv_mpu6050_init_config(struct 
>>> iio_dev *indio_dev)
>>>       memcpy(&st->chip_config, hw_info[st->chip_type].config,
>>>              sizeof(struct inv_mpu6050_chip_config));
>>>
>>> +     /*
>>> +      * Internal chip period is 1ms (1kHz).
>>> +      * Let's use at the beginning the theorical value before measuring
>>> +      * with interrupt timestamps.
>>> +      */
>>> +     st->chip_period = NSEC_PER_MSEC;
>>> +
>>>       return inv_mpu6050_set_power_itg(st, false);
>>>
>>>   error_power_off:
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h 
>>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> index 09a7e1c..b78640c 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> @@ -125,6 +125,9 @@ struct inv_mpu6050_hw {
>>>    *  @map            regmap pointer.
>>>    *  @irq            interrupt number.
>>>    *  @irq_mask               the int_pin_cfg mask to configure 
>>> interrupt type.
>>> + *  @chip_period:    chip internal period estimation (~1kHz).
>>> + *  @it_timestamp:   timestamp from previous interrupt.
>>> + *  @data_timestamp: timestamp for next data sample.
>>>    */
>>>   struct inv_mpu6050_state {
>>>       struct mutex lock;
>>> @@ -142,6 +145,9 @@ struct inv_mpu6050_state {
>>>       int irq;
>>>       u8 irq_mask;
>>>       unsigned skip_samples;
>>> +     s64 chip_period;
>>> +     s64 it_timestamp;
>>> +     s64 data_timestamp;
>>>   };
>>>
>>>   /*register and associated bit definition*/
>>> @@ -223,6 +229,8 @@ struct inv_mpu6050_state {
>>>   #define INV_MPU6050_LATCH_INT_EN    0x20
>>>   #define INV_MPU6050_BIT_BYPASS_EN   0x2
>>>
>>> +/* Allowed timestamp period jitter in percent */
>>> +#define INV_MPU6050_TS_PERIOD_JITTER 4
>>>
>>>   /* init parameters */
>>>   #define INV_MPU6050_INIT_FIFO_RATE           50
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c 
>>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>>> index 7a4aaed..e06e509 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>>> @@ -23,12 +23,86 @@
>>>   #include <asm/unaligned.h>
>>>   #include "inv_mpu_iio.h"
>>>
>>> +/**
>>> + *  inv_mpu6050_add_timestamp() - Add a new interrupt timestamp
>>> + *
>>> + *  @st:             driver state
>>> + *  @timestamp:              the interrupt timestamp
>>> + *  @nb:             number of data set in the fifo
>>> + *
>>> + *  This function uses interrupt timestamps to estimate the chip 
>>> period and
>>> + *  to choose the data timestamp to come.
>>> + */
>>> +static void inv_mpu6050_add_timestamp(struct inv_mpu6050_state *st,
>>> +                                   s64 timestamp, size_t nb)
>>
>> I think it would be clearer if this were called something like
>> inv_mpu6050_update_ts_estimate(), as we're not really attaching a
>> timestamp to a sample here (what I first thought) but are just updating
>> our estimation data.
> In fact, we are adding a new timestamp for estimating the chip internal 
> frequency. But a better name would be good I agree.
> 
>>
>>> +{
>>> +     /* Period boundaries for accepting timestamp */
>>> +     const s64 period_min =
>>> +             (NSEC_PER_MSEC * (100 - INV_MPU6050_TS_PERIOD_JITTER)) 
>>> / 100;
>>> +     const s64 period_max =
>>> +             (NSEC_PER_MSEC * (100 + INV_MPU6050_TS_PERIOD_JITTER)) 
>>> / 100;
>>> +     const unsigned divider = st->chip_config.divider + 1;
>>
>> I think this variable is better named fifo_rate to avoid confusion with
>> st->chip_config.divider (and if we refactor to calculate it with a
>> function, we should call that function here).
> This is not fifo rate, but the real frequency divider, which is chip 
> divider + 1. Here fifo_rate = 1KHz / divider. If you have an idea about 
> a better name, I'm interested.
> 

A few ideas:

- Rename st->chip_config.divider to st->chip_config.freq_divider (and 
set it to 1 higher). When setting it in the chip registers, subtract 1. 
This would avoid the repeated code of "st->chip_config.divider + 1" and 
make it clearer exactly what the divider is.

- Call the variable freq_divider (as opposed to chip_divider, say).

- Use a get_freq_divider() function to get the frequency divider from 
the st->chip_config.divider (the chip divider), with a comment in the 
function explaining how the two are 1 different from each other.

I think basically anything that lets the reader understand the 
relationship between the dividers without combing through the datasheet 
would be helpful.

>>
>>> +     s64 val;
>>> +     bool use_it_timestamp = false;
>>> +
>>> +     if (st->it_timestamp == 0)  > +         /* not initialized, 
>>> forced to use it timestamp */
>>
>> nit: should probably be "forced to use it_timestamp"
> it_timestamp is the it (means interrupt) timestamp.
> 

I was actually just referring to "it timestamp" vs "it_timestamp" (since 
"it_timestamp" is the variable). That said, as a small change, I think 
"int_timestamp" would be clearer than "it_timestamp".

>>
>>> +             use_it_timestamp = true;
>>> +     } else if (nb == 1) {
>>> +             /*
>>> +              * Validate the use of it timestamp by checking if 
>>> interrupt
>>> +              * has been delayed.
>>> +              * nb > 1 means interrupt was delayed for more than 1 
>>> sample,
>>> +              * so it's obviously not good.
>>> +              * Compute the chip period between 2 interrupts for 
>>> validating.
>>> +              */
>>> +             val = (timestamp - st->it_timestamp) / divider;
>>> +             if (val > period_min && val < period_max) {
>>> +                     /* update chip period and use it timestamp */
>>> +                     st->chip_period = (st->chip_period + val) / 2;
>>> +                     use_it_timestamp = true;
>>> +             }
>>> +     }
>>> +
>>> +     if (use_it_timestamp) {
>>> +             /* manage case of multiple samples in the fifo (nb > 1) */
>>> +             val = (nb - 1) * st->chip_period * divider;
>>> +             st->data_timestamp = timestamp - val;
>>
>> Since this is complex code, I think naming "val" something more
>> descriptive would be helpful for understanding. A would suggest a name
>> like "gap_estimate", but others would work too.
> I can declare 2 variables with better names instead.
> 

That sounds good.

>>
>>> +     }
>>> +
>>> +     /* save it timestamp */
>>> +     st->it_timestamp = timestamp;
>>> +}
>>> +
>>> +/**
>>> + *  inv_mpu6050_get_timestamp() - Return the current data timestamp
>>> + *
>>> + *  @st:             driver state
>>> + *  @return:         current data timestamp
>>> + *
>>> + *  This function returns the current data timestamp and prepares 
>>> for next one.
>>> + */
>>> +static s64 inv_mpu6050_get_timestamp(struct inv_mpu6050_state *st)
>>> +{
>>> +     const unsigned divider = st->chip_config.divider + 1;
>>
>> Same here; I think this should be called fifo_rate.
> Real frequency divider like above.
> 
>>
>>> +     s64 ts;
>>> +
>>> +     /* return current data timestamp and increment */
>>> +     ts = st->data_timestamp;
>>> +     st->data_timestamp += st->chip_period * divider;
>>> +
>>> +     return ts;
>>> +}
>>> +
>>>   int inv_reset_fifo(struct iio_dev *indio_dev)
>>>   {
>>>       int result;
>>>       u8 d;
>>>       struct inv_mpu6050_state  *st = iio_priv(indio_dev);
>>>
>>> +     /* reset it timestamp validation */
>>> +     st->it_timestamp = 0;
>>> +
>>>       /* disable interrupt */
>>>       result = regmap_write(st->map, st->reg->int_enable, 0);
>>>       if (result) {
>>> @@ -97,7 +171,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>>>       int result;
>>>       u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
>>>       u16 fifo_count;
>>> -     s64 timestamp = pf->timestamp;
>>> +     s64 timestamp;
>>>       int int_status;
>>>       size_t i, nb;
>>>
>>> @@ -140,6 +214,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>>>       fifo_count = get_unaligned_be16(&data[0]);
>>>       /* compute and process all complete datum */
>>>       nb = fifo_count / bytes_per_datum;
>>> +     inv_mpu6050_add_timestamp(st, pf->timestamp, nb);
>>>       for (i = 0; i < nb; ++i) {
>>>               result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
>>>                                         data, bytes_per_datum);
>>> @@ -150,6 +225,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>>>                       st->skip_samples--;
>>>                       continue;
>>>               }
>>> +             timestamp = inv_mpu6050_get_timestamp(st);
>>>               iio_push_to_buffers_with_timestamp(indio_dev, data, 
>>> timestamp);
>>>       }
>>>
>>>
