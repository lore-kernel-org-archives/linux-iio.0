Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37102 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWK5C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Oct 2018 06:57:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so19931848pgq.4
        for <linux-iio@vger.kernel.org>; Mon, 22 Oct 2018 19:35:47 -0700 (PDT)
Subject: Re: [RFC][PATCH] iio:st_magn: enable device after trigger
To: Denis CIOCCA <denis.ciocca@st.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20181015015336.21066-1-martin@martingkelly.com>
 <CAA2SeNLH1hTRz5tx0DCtniX2i8iPt=MzeYYO77Y+=Dg9ZOSL0w@mail.gmail.com>
 <811d448f-2e66-8dac-fe25-19a754d0fe99@martingkelly.com>
 <c7340331e1c34227b1d513c1054ff8a8@SFHDAG2NODE1.st.com>
From: Martin Kelly <martin@martingkelly.com>
Message-ID: <054c7b6f-c3fe-4e13-d638-b1618003c4fc@martingkelly.com>
Date: Mon, 22 Oct 2018 19:35:45 -0700
MIME-Version: 1.0
In-Reply-To: <c7340331e1c34227b1d513c1054ff8a8@SFHDAG2NODE1.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/18 8:56 PM, Denis CIOCCA wrote:
> Hi Martin,
> 
> I performed few tests today.
> 
> Here is my thoughts:
> 
> 1. Interrupts SHOULD be used in level. 99% of our devices set interrupt level when new data are generated and reset the status of the pad after an i2c read of the output registers is performed. If i2c read fails or sensor disable fails, interrupt is kept set. That's why interrupts should always be treated in level mode. There are instead other devices (such as lsm6dsm) where pads can be configured to generate pulsed interrupts of 75us width, in this case interrupts are continually generated independently from output reads. This latest case should be treated instead in edge mode.
> LSM9DS1 magn is compatible with LIS3MDL, that is working as described in the first case.
> 
> 2. From logical point of view driver should be ready to receive irqs before enabling the sensor itself. Your suggestion is 'logically' a better implementation.
> 
> 3. About spurious / storm interrupts. From my tests with the  oscillope, with high odrs (80Hz), interrupts in fact are generated before irq is requested. This is generally not an issue. Introduction of
> 
> iio: st_sensors: harden interrupt handling
> 90efe05562921768d34e44c0292703ea3168ba8d
> 
> has generated a problem though.
> 
> Irq_thread function is checking the status of hw_irq_trigger variable that is set executing st_magn_trig_set_state function.
> So, if between request_irq and st_magn_trig_set_state interrupts are received, irq_thread treats those as IRQ_NONE. Many of those (because of level) cause disabling of the IRQ.
> 
> To summarize, your patch (with few modifications) are valid to me, even for other sensors but is not covering all cases. For example if sensor fails the disable interrupts are still generated and new enable could cause the same issue.
> 
> I've modified the patch you propose because is not covering failures, I'll try to send the patch tomorrow since I am having problems with git-send-email through company proxy :(
> 

Thank you for the very thorough analysis. It sounds like you observed 
the same behavior that I did (CPU spike and interrupts running as fast 
as possible, returning IRQ_NONE). It's especially noticeable with high 
ODRs but occurs all the time.

I look forward to your patch!

> Feedback are very welcome!
> 
> Best Regards,
> Denis
> 
> 
> -----Original Message-----
> From: Denis CIOCCA
> Sent: Saturday, October 20, 2018 4:22 PM
> To: 'Martin Kelly' <martin@martingkelly.com>
> Cc: linux-iio@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> Subject: RE: [RFC][PATCH] iio:st_magn: enable device after trigger
> 
> Hi Martin,
> 
> I am performing few tests. I'll give you a feedback tomorrow!
> 
> Thanks,
> Denis
> 
> 
> -----Original Message-----
> From: Martin Kelly <martin@martingkelly.com>
> Sent: Friday, October 19, 2018 9:08 PM
> To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> Cc: linux-iio@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Denis CIOCCA <denis.ciocca@st.com>
> Subject: Re: [RFC][PATCH] iio:st_magn: enable device after trigger
> 
> On 10/15/18 12:19 AM, Lorenzo Bianconi wrote:
>>> Currently, we enable the device before we enable the device trigger.
>>> At high frequencies, this can cause interrupts that don't yet have a
>>> poll function associated with them and are thus treated as spurious.
>>> At high frequencies with level interrupts, this can even cause an
>>> interrupt storm of repeated spurious interrupts (~100,000 on my
>>> Beagleboard with the
>>> LSM9DS1 magnetometer). If these repeat too much, the interrupt will
>>> get disabled and the device will stop functioning.
>>>
>>> To prevent these problems, enable the device prior to enabling the
>>> device trigger, and disable the divec prior to disabling the trigger.
>>> This means there's no window of time during which the device creates
>>> interrupts but we have no trigger to answer them.
>>>
>>
>> I have just reviewed the code (not carried out any tests) and I guess
>> this patch is correct. Moreover if the memory allocation in
>> st_magn_buffer_postenable fails we will end up with a device
>> generating interrupts without any buffer to collect data.
>> I guess there is the same issue in st_magn_buffer_predisable(), if
>> st_sensors_set_enable or iio_triggered_buffer_predisable fails, should
>> we remove the data buffer? Maybe we just skip return code from
>> st_sensors_set_enable.
>> @Denis: any hints?
>>
>> Regards,
>> Lorenzo
>>
> 
> Denis, any opinion?
> 
>>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
>>> ---
>>>    drivers/iio/magnetometer/st_magn_buffer.c | 12 +++---------
>>>    1 file changed, 3 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/iio/magnetometer/st_magn_buffer.c
>>> b/drivers/iio/magnetometer/st_magn_buffer.c
>>> index 0a9e8fadfa9d..37ab30566464 100644
>>> --- a/drivers/iio/magnetometer/st_magn_buffer.c
>>> +++ b/drivers/iio/magnetometer/st_magn_buffer.c
>>> @@ -30,11 +30,6 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
>>>           return st_sensors_set_dataready_irq(indio_dev, state);
>>>    }
>>>
>>> -static int st_magn_buffer_preenable(struct iio_dev *indio_dev) -{
>>> -       return st_sensors_set_enable(indio_dev, true);
>>> -}
>>> -
>>>    static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>>>    {
>>>           int err;
>>> @@ -50,7 +45,7 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>>>           if (err < 0)
>>>                   goto st_magn_buffer_postenable_error;
>>>
>>> -       return err;
>>> +       return st_sensors_set_enable(indio_dev, true);
>>>
>>>    st_magn_buffer_postenable_error:
>>>           kfree(mdata->buffer_data);
>>> @@ -63,11 +58,11 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>>>           int err;
>>>           struct st_sensor_data *mdata = iio_priv(indio_dev);
>>>
>>> -       err = iio_triggered_buffer_predisable(indio_dev);
>>> +       err = st_sensors_set_enable(indio_dev, false);
>>>           if (err < 0)
>>>                   goto st_magn_buffer_predisable_error;
>>>
>>> -       err = st_sensors_set_enable(indio_dev, false);
>>> +       err = iio_triggered_buffer_predisable(indio_dev);
>>>
>>>    st_magn_buffer_predisable_error:
>>>           kfree(mdata->buffer_data);
>>> @@ -75,7 +70,6 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>>>    }
>>>
>>>    static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
>>> -       .preenable = &st_magn_buffer_preenable,
>>>           .postenable = &st_magn_buffer_postenable,
>>>           .predisable = &st_magn_buffer_predisable,
>>>    };
>>> --
>>> 2.11.0
>>>
>
