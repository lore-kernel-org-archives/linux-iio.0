Return-Path: <SRS0=x+Q6=NI=martingkelly.com=martin@kernel.org>
Subject: Re: [PATCH] iio:st_magn: enable trigger before enabling sensor
To: Jonathan Cameron <jic23@kernel.org>, Denis Ciocca <denis.ciocca@st.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, lorenzo.bianconi83@gmail.com,
 pmeerw@pmeerw.net, knaack.h@gmx.de
References: <20181025223226.10292-1-denis.ciocca@st.com>
 <20181028162018.7d351195@archlinux>
From: Martin Kelly <martin@martingkelly.com>
Message-ID: <0b3bcaaf-cb86-a6f4-4a4e-f73e1ffd4077@martingkelly.com>
Date: Sun, 28 Oct 2018 12:07:18 -0700
MIME-Version: 1.0
In-Reply-To: <20181028162018.7d351195@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 10/28/18 9:20 AM, Jonathan Cameron wrote:
> On Thu, 25 Oct 2018 15:32:26 -0700
> Denis Ciocca <denis.ciocca@st.com> wrote:
> 
>>  From logical point of view driver should be ready to
>> receive irqs before enabling the sensor itself.
>> This patch is fixing also an issue related to
>> sensors that generate interrupts unconditionally,
>> (DRDY pads) when interrupt level is used.
>>
>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
>> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> A couple of very minor points inline.
> 
> Also, author should match the first sign off.  I kind of lost touch of
> how much got modified, but a Reported-by: or the one you occasionally get
> is Originated-by: for martin would be preferred if the changes are major,
> if they are minor, then the author should be martin with a sign off
> from Denis.
> 

I would say the changes are minor, although it's subjective exactly what 
"minor" vs. "major" are, of course. In this case, Denis added some 
goto-error cleanup that I had missed, but the bug fix was from the 
original patch.

> Also, as I understand it this is a fix for an issue seen, so make that
> clear in the naming of the patch and give a fixes-tag to indicate
> how far back we should apply this in stable.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>   drivers/iio/magnetometer/st_magn_buffer.c | 33 +++++++++++------------
>>   1 file changed, 16 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
>> index 0a9e8fadfa9d..097e6e88a464 100644
>> --- a/drivers/iio/magnetometer/st_magn_buffer.c
>> +++ b/drivers/iio/magnetometer/st_magn_buffer.c
>> @@ -30,11 +30,6 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
>>   	return st_sensors_set_dataready_irq(indio_dev, state);
>>   }
>>   
>> -static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
>> -{
>> -	return st_sensors_set_enable(indio_dev, true);
>> -}
>> -
>>   static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>>   {
>>   	int err;
>> @@ -42,40 +37,44 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>>   
>>   	mdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
>>   	if (mdata->buffer_data == NULL) {
>> -		err = -ENOMEM;
>> -		goto allocate_memory_error;
>> +		return -ENOMEM;
> I would have a very slight preference for that having been in a separate patch.
> Good cleanup but not part of the main point of this patch.
> 
>>   	}
>>   
>>   	err = iio_triggered_buffer_postenable(indio_dev);
>>   	if (err < 0)
>> -		goto st_magn_buffer_postenable_error;
>> +		goto st_magn_buffer_free_buffer_data;
>> +
>> +	err = st_sensors_set_enable(indio_dev, true);
>> +	if (err < 0)
>> +		goto st_magn_buffer_buffer_predisable;
>>   
>>   	return err;
>>   
>> -st_magn_buffer_postenable_error:
>> +st_magn_buffer_buffer_predisable:
>> +	iio_triggered_buffer_predisable(indio_dev);
>> +st_magn_buffer_free_buffer_data:
>>   	kfree(mdata->buffer_data);
>> -allocate_memory_error:
>>   	return err;
>>   }
>>   
>>   static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>>   {
>> -	int err;
>> +	int err = 0, err2;
>>   	struct st_sensor_data *mdata = iio_priv(indio_dev);
>>   
>> -	err = iio_triggered_buffer_predisable(indio_dev);
>> -	if (err < 0)
>> -		goto st_magn_buffer_predisable_error;
>> +	err2 = st_sensors_set_enable(indio_dev, false);
>> +	if (err2 < 0)
>> +		err = err2;
>>   
>> -	err = st_sensors_set_enable(indio_dev, false);
>> +	err2 = iio_triggered_buffer_predisable(indio_dev);
>> +	if (err2 < 0)
>> +		err = err2;
> There is a small argument that we should have some visibility of
> the value of the error from st_sensors_set_enable if both
> error paths trigger.  I think the suggestion made in the
> other review of an error comment would solve that fairly well.
> 
>>   
>> -st_magn_buffer_predisable_error:
>>   	kfree(mdata->buffer_data);
>>   	return err;
>>   }
>>   
>>   static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
>> -	.preenable = &st_magn_buffer_preenable,
>>   	.postenable = &st_magn_buffer_postenable,
>>   	.predisable = &st_magn_buffer_predisable,
>>   };
> 
