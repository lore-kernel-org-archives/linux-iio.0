Return-Path: <SRS0=DmY4=NA=martingkelly.com=martin@kernel.org>
Subject: Re: [RFC][PATCH] iio:st_magn: enable device after trigger
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Denis Ciocca <denis.ciocca@st.com>
References: <20181015015336.21066-1-martin@martingkelly.com>
 <CAA2SeNLH1hTRz5tx0DCtniX2i8iPt=MzeYYO77Y+=Dg9ZOSL0w@mail.gmail.com>
From: Martin Kelly <martin@martingkelly.com>
Message-ID: <b5771fc2-0e1b-cb9f-e970-2ed1b768db33@martingkelly.com>
Date: Fri, 19 Oct 2018 21:08:05 -0700
MIME-Version: 1.0
In-Reply-To: <CAA2SeNLH1hTRz5tx0DCtniX2i8iPt=MzeYYO77Y+=Dg9ZOSL0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 10/15/18 12:19 AM, Lorenzo Bianconi wrote:
>> Currently, we enable the device before we enable the device trigger. At
>> high frequencies, this can cause interrupts that don't yet have a poll
>> function associated with them and are thus treated as spurious. At high
>> frequencies with level interrupts, this can even cause an interrupt storm
>> of repeated spurious interrupts (~100,000 on my Beagleboard with the
>> LSM9DS1 magnetometer). If these repeat too much, the interrupt will get
>> disabled and the device will stop functioning.
>>
>> To prevent these problems, enable the device prior to enabling the device
>> trigger, and disable the divec prior to disabling the trigger. This means
>> there's no window of time during which the device creates interrupts but we
>> have no trigger to answer them.
>>
> 
> I have just reviewed the code (not carried out any tests) and I guess this patch
> is correct. Moreover if the memory allocation in st_magn_buffer_postenable fails
> we will end up with a device generating interrupts without any buffer
> to collect data.
> I guess there is the same issue in st_magn_buffer_predisable(), if
> st_sensors_set_enable
> or iio_triggered_buffer_predisable fails, should we remove the data
> buffer? Maybe we
> just skip return code from st_sensors_set_enable.
> @Denis: any hints?
> 
> Regards,
> Lorenzo
> 

Dennis, any opinion?

>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
>> ---
>>   drivers/iio/magnetometer/st_magn_buffer.c | 12 +++---------
>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
>> index 0a9e8fadfa9d..37ab30566464 100644
>> --- a/drivers/iio/magnetometer/st_magn_buffer.c
>> +++ b/drivers/iio/magnetometer/st_magn_buffer.c
>> @@ -30,11 +30,6 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
>>          return st_sensors_set_dataready_irq(indio_dev, state);
>>   }
>>
>> -static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
>> -{
>> -       return st_sensors_set_enable(indio_dev, true);
>> -}
>> -
>>   static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>>   {
>>          int err;
>> @@ -50,7 +45,7 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>>          if (err < 0)
>>                  goto st_magn_buffer_postenable_error;
>>
>> -       return err;
>> +       return st_sensors_set_enable(indio_dev, true);
>>
>>   st_magn_buffer_postenable_error:
>>          kfree(mdata->buffer_data);
>> @@ -63,11 +58,11 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>>          int err;
>>          struct st_sensor_data *mdata = iio_priv(indio_dev);
>>
>> -       err = iio_triggered_buffer_predisable(indio_dev);
>> +       err = st_sensors_set_enable(indio_dev, false);
>>          if (err < 0)
>>                  goto st_magn_buffer_predisable_error;
>>
>> -       err = st_sensors_set_enable(indio_dev, false);
>> +       err = iio_triggered_buffer_predisable(indio_dev);
>>
>>   st_magn_buffer_predisable_error:
>>          kfree(mdata->buffer_data);
>> @@ -75,7 +70,6 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>>   }
>>
>>   static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
>> -       .preenable = &st_magn_buffer_preenable,
>>          .postenable = &st_magn_buffer_postenable,
>>          .predisable = &st_magn_buffer_predisable,
>>   };
>> --
>> 2.11.0
>>
