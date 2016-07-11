Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35643 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933677AbcGKIb2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2016 04:31:28 -0400
Received: by mail-lf0-f44.google.com with SMTP id f93so14094005lfi.2
        for <linux-iio@vger.kernel.org>; Mon, 11 Jul 2016 01:31:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <aa60431d268e961e1d0eb6cb589cf443@doppler.thel33t.co.uk>
References: <dc764217a7c6265d30a588e966f4b133@doppler.thel33t.co.uk>
 <c0d19ba9-4c6f-5728-7528-75c27f2f8047@kernel.org> <aa60431d268e961e1d0eb6cb589cf443@doppler.thel33t.co.uk>
From: Crt Mori <cmo@melexis.com>
Date: Mon, 11 Jul 2016 10:30:47 +0200
Message-ID: <CAKv63uvgCayndcK-uF69Uy4wvud5V06HEh3DP-J-LYnWL3y1sg@mail.gmail.com>
Subject: Re: Some advice required for IIO driver (cm3218)
To: Leigh Brown <leigh@solinno.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Leigh,
Short comments inline (from what I am certain).

Best regards,
Crt

On 11 July 2016 at 10:17, Leigh Brown <leigh@solinno.co.uk> wrote:
> Hi Jonathan,
>
> Thanks very much for replying to my email, I appreciate it is probably
> annoying having to
> repeat yourself to every newcomer.
>
> On 2016-07-10 16:17, Jonathan Cameron wrote:
>>
>> On 05/07/16 22:23, Leigh Brown wrote:
>>>
>>> Hi Guys,
>>>
>>> I just bought an Asus T100 transformer which has a cm3218 ALS and I'm
>>> keen to get it working.
>>
>> Cool.
>>>
>>> I've seen two drivers hanging around:
>>>
>>> 1.
>>> https://github.com/jfwells/linux-asus-t100ta/blob/master/cm3218_ambient_light_sensor_driver/cm3218.c
>>>
>>> 2. http://marc.info/?l=linux-iio&m=146038141909068&w=2
>>
>> Would be interesting if you could provide a few details on where these
>> two drivers are less than ideal.  Useful info to have when considering a
>> 3rd option ;)
>>
>> Also, ideally talk to Kevin to find out what the status of updates to the
>> above so you
>> can both avoid duplicating effort.
>
>
> Thanks, I will (Hi Kevin :-) )  My main problem with Kevin's driver is there
> is a whole load of
> IRQ handling and threshold maintenance that doesn't actually do anything.
> Plus, the processed
> value is wrong (certainly when I have compared output with my android
> phone).
>
>>> Neither worked really well so in the spirit of things I've created a
>>> third driver which I'm
>>> hoping to get into a state worth submitting (famous last words).  It's
>>> not ready for review
>>> yet (I've pasted it below for anyone who is interested) but I have a
>>> couple of questions  and
>>> I would be really grateful if someone could assist.
>>>
>>> Q1. What do IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_CALIBSCALE mean?
>>>
>>> This is slightly embarrassing, but I can't really figure out what they
>>> mean. I'd appreciate it
>>> if someone could supply a simple definition in relation to this driver.
>>
>> IIO_CHAN_INFO_SCALE is a scaling factor that is applied to
>> IIO_CHAN_INFO_RAW
>> output data in userspace as a linear scaling.  Basic rule of thumb is that
>> if
>> we can describe the conversion from raw data to our 'base units', here
>> illuminance
>> we leave it up to userspace to do the maths rather than doing it in
>> kernel.
>> If writable it is controlling the scaling of data coming of the ADC.
>> Clearly
>> we have no way of knowing if this is due to changes in say the ADC
>> reference
>> or due to analog front end changes.
>
>
> Just to clarify, in this case the relationship between the raw sensor value
> and the result in
> Lux *is* linear, so the driver should *not* provide the processed output,
> but instead provide
> the raw output and the scale?  Even though providing the processed output is
> pretty simple?
It might be simple in your case, but what if there was a need for
floating point calculations, etc.?
>
> Conversely, if it were *not* linear then you would not provide a scale
> attribute and instead
> just provide processed output?
Correct.
>
>
>> IIO_CHAN_INFO_CALIBSCALE is a scaling typically applied as an electrical
>> gain
>> inside the device as a form of 'trim'. It's about calibrating out part to
>> part variation.
>>
>> The key thing is that it needs to look like this is hardware trim to
>> userspace,
>> but it isn't necessarily an actual hardware applied gain.  In the
>> case of light sensors, the conversion from the raw ADC value to
>> illuminance in lux
>> is often non linear (and can involve several input sensors).  Thus we
>> often have
>> to provide an IIO_CHAN_INFO_PROCESSED output where the maths has
>> already been done
>> (it's too complex to sensibly describe to userspace).  In this
>> circumstance if
>> the device has registers to tell the software what it's calibration gain
>> is
>> (from factory calibration) but that is not applied in hardware
>> IIO_CHAN_INFO_CALIBSCALE may be used to control a scaling value
>> which might as well be implemented in hardware as it is always applied
>> before
>> userspace sees it.
>>
>> So as you may have noticed there is sometimes a bit of a gray area when
>> the
>> calibscale is being used for things that aren't actually controlling
>> hardware
>> amplifiers.
>>
>>> Q2. What's the best unit to return the processed ambient light sensor
>>> value?
>>>
>>> My first choice would be in milliLux,
>>
>> lux as per Documentation/ABI/testing/sysfs-bus-iio
>> is where you need to end up, but it is up to you whether you output in
>> millilux as IIO_CHAN_INFO_RAW and provide a scale of 0.001 or output
>> as IIO_CHAN_INFO_PROCESSED directly in lux.
>>
>>> my second would be in Lux using IIO_VAL_INT_PLUS_MICRO.
>>> The first requires less calculation in the driver, but I'm easy either
>>> way, as long as the
>>> value returned has all the significant bits in it.
>>>
>>> Q3. The device has a high sensitivity mode (either x1 or x2 sensitivity).
>>> I'd like to expose
>>> that feature in sysfs.  What would be the best description of it?
>>>
>>> I would suggest something on the lines of IIO_CHAN_INFO_SENSITIVITY.  If
>>> so, would the best
>>> thing to do be to submit a patch adding that to include/linux/iio/iio.h ?
>>
>> What does it really correspond to?  I'm guessing integration time...
>> There
>> are various ways of getting sensitivity and they have direct effects on
>> the noise characteristics, so we really want to know what is going on.
>>
>> (looking below I see there is a separate integration time control, so we
>> are talking either an electrical gain (amplifier) or something more
>> closely related to the diode itself.)
>> Could do it via scale.
>>
>>>
>>> Q4. Similarly, the device has the ability to specify how many samples are
>>> outside of the
>>> configured threshold before raising an interrupt.  What would be the best
>>> description of
>>> this?
>>>
>>> I'm thinking something on the lines of IIO_EV_INFO_CYCLE_DELAY or some
>>> such?  I'm not sure.
>>
>>
>> period.  See the ABI docs.  You'll need to provide it in seconds however
>> rather
>> than samples.
>
>
> Okay.  I have a question on this.  If you change the integration time, for
> example, then the
> period would change (as it is expressed in number of cycles, 1, 2, 4 or 8).
> So if you started
> with an integration time of 0.2s, and set period to 0.4s (2 cycles), that
> would be fine.  Then,
> if you change the integration time to 0.4s, then without changing anything
> else the period
> would jump to 0.8s.  In addition, the periods available would be different
> depending on the
> integration time.
>
> Is that the behaviour you would expect to see if the period is configured in
> seconds?
>
>>> Q5. The device is very simple and will continue to raise an interrupt
>>> every sample that is
>>> outside of the threshold.  To deal with this I have written code to
>>> change the range to not
>>> interrupt until the reading returns to within the defined threshold.  I
>>> was thinking of
>>> adding a hysteresis value to this.  What would be the preferred unit of
>>> this?  MilliLux/Lux
>>> or percent or something else?
>>
>> Match units with the channel.  Also we already have hysteresis defined for
>> events so use that.
>
>
> Based on your feedback that the driver should not perform the calculation
> (and rely on the
> scale attribute to allow userspace to perform the calculation), then it
> would follow that the
> upper and lower thresholds would also be exposed in raw values.  Again, the
> issue with that is
> that the scaling factor changes depending on the configuration (integration
> time and hardware
> sensitivity).
>
> Does that sound reasonable to you?  It would mean that user space would have
> to recalculate the
> thresholds after every change to the integration time or hardware
> sensitivity.  Currently my
> driver is doing that but I suppose the idea is to minimise that kind of
> thing in the driver?
>
>> Sometimes it gets fiddlier on light sensors (though I don't think so
>> here). Events can
>> be based on the outputs of one of the multiple diodes whose values are
>> combined to
>> calculate an illuminance value.  In those cases we have the unitless
>> 'intensity'
>> channel types so that the underlying ADC values can be exposed + the
>> events that operate
>> on them.  It's a pain for userspace to interpret this but we haven't yet
>> come
>> up with a better way to describe it.
>>
>>
>>>
>>> Apologies for the dumb questions, but if someone can point me in the
>>> right direction I'll
>>> try and get the driver into a good shape over the next week or so.
>>>
>>> Regards,
>>>
>>> Leigh.
>
> [snip driver]
>
> Regards,
>
> Leigh.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
