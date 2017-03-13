Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48105 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdCMUvp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:51:45 -0400
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: adc: Replace mlock with
 driver private lock
To: Gargi Sharma <gs051095@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>
References: <1489351546-21008-1-git-send-email-gs051095@gmail.com>
 <alpine.DEB.2.20.1703122154130.7649@hadrien>
 <CAOCi2DH9bNChZj4kyt3t1eK7R7uSv77zeVc2PkPYxoRDDHZLsA@mail.gmail.com>
 <alpine.DEB.2.20.1703122235320.7649@hadrien>
 <20170312221350.GA14070@d830.WORKGROUP>
 <CAOCi2DEyu6_bBjsrSFzf0VcXcUnZ3LugLf==R9zsSmj+1JdFKw@mail.gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>,
        outreachy-kernel@googlegroups.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <35231dfd-af42-bbd3-3be6-4e03a728a92f@kernel.org>
Date: Mon, 13 Mar 2017 20:51:42 +0000
MIME-Version: 1.0
In-Reply-To: <CAOCi2DEyu6_bBjsrSFzf0VcXcUnZ3LugLf==R9zsSmj+1JdFKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/03/17 08:40, Gargi Sharma wrote:
> On Mon, Mar 13, 2017 at 3:43 AM, Alison Schofield <amsfield22@gmail.com> wrote:
>> On Sun, Mar 12, 2017 at 10:37:39PM +0100, Julia Lawall wrote:
>>>
>>>
>>> On Mon, 13 Mar 2017, Gargi Sharma wrote:
>>>
>>>> On Mon, Mar 13, 2017 at 2:26 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>>>>
>>>>>
>>>>> On Mon, 13 Mar 2017, Gargi Sharma wrote:
>>>>>
>>>>>> The IIO subsystem is redefining iio_dev->mlock to be used by
>>>>>> the IIO core only for protecting device operating mode changes.
>>>>>> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
>>>>>>
>>>>>> In this driver, mlock was being used to protect hardware state
>>>>>> changes.  Replace it with a lock in the devices global data.
>>>>>> This was done using Coccinelle Script.
>>>>>>
>>>>>> @r1@
>>>>>> identifier xxx_state;
>>>>>> @@
>>>>>> struct xxx_state {
>>>>>> ...
>>>>>> + struct mutex          lock; /* protect sensor state */
>>>>>> };
>>>>>>
>>>>>> @r2@
>>>>>> expression e;
>>>>>> @@
>>>>>> - mutex_lock(e);
>>>>>> + mutex_lock(&st->lock);
>>>>>>
>>>>>> @r3@
>>>>>> expression e;
>>>>>> @@
>>>>>> - mutex_unlock(e);
>>>>>> + mutex_unlock(&st->lock);
>>>>>
>>>>>
>>>>> This rule is probably hjelpful in practice, but is very unsafe.  Is there
>>>>> any way that you can characterize the kind of structure you want to add a
>>>>> new lock to?  And likewise, what lock and unlock calls you want to
>>>>> replace?  And what is st?
>>>>>
>>>> Hi!
>>>>
>>>> I wanted to do the following things, but was getting a parse error with the
>>>> Coccinelle Script.
>>>>
>>>> st is a structure of type xxx_state. If I inherit xxx_state from r1,
>>>> to r2 and write
>>>> the following in the cocci script, for some reason it was not parsing
>>>> the structure at all.
>>>>
>>>> @r2@
>>>> expression e1,e2;
>>>> xxx_state << r1.xxx_state;
>>>
>>> << is the way you inherit a metavariable in script code.  The first script
>>> language available was python and it was considered to be odd to ask
>>> people to put types on variables to be used in python code.  In any case,
>>> all kinds of terms are represented as strings, so the tpye would not be
>>> very useful.
>>>
>>> When you are in pattern matching (SmPL) code, metavariables are inherited
>>> as
>>>
>>> identifier r1.xxx_state;
>>>
>>> (or whatever is the appropriate type)
>>>
>>> julia
>>>
>>>> identifier i;
>>>> position p;
>>>> @@
>>>> struct xxx_state i@p = e1;        //If the script is only till this
>>>>                                                  // point and there is an * in
>>>>                                                  // the beginning, the rule
>>>>                                                  //does not detect a structure.
>>>> mutex_lock
>>>> (
>>>> - e1
>>>> + &i->lock                              //this gives a parsing error
>>>> );
>>>>
>>>>
>>>>> julia
>>>>>
>>
>> Gargi,
>>
>> Please insert the new lock above the __cacheline_aligned struct
>> member.
> 
> I will do that, but is there any reason why the lock should be above
> ____cacheline_aligned struct member?
Yes.  It's in fact very important that nothing comes after that.

Will leave the why as an exercise for the reader.   I'll give the
hit of spi drivers that do DMA...
> 
>>
>> I like the automated editing because it certainly cuts down on typos,
>> and even with this one, you can just move the new lock field upon
>> inspection.  Sadly, I don't think the script will apply too widely
>> because the use of "_state" for driver global data isn't a standard,
>> nor availability of that struct in the functions needing the locking.
> I only saw three files that had the mlock and they followed the structure
> with _state as suffix and only had mutex_lock for &indio_dev->mlock.
> Hence, I went ahead with the script even though I knew it wasn't probably
> very safe.
>>
>> That sadness expressed ;) we do have a boatload of drivers upstream
>> that will eventually make this migration, so the value of the cocci
>> script would go beyond these 15 staging drivers. That's valuable.
> 
> An autmoated script can work if there is a pattern all the file containing
> the mlocks possess. I believe for the staging driver all the structures
> have a _state as prefix and the mutex lock is held on those structures.
>>
>> Let's make sure anything done with any automated tools is walked
>> through thoroughly.
> Yes of course! My intention for a script was to make the transition to
> private locks a little less hassle free if possible. :)
> 
> Thanks!
> Gargi
> Per the task description: this is not intended
>> as a search&replace exercise.
>>
>> alisons
>>
>>
>>>>>>
>>>>>> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
>>>>>> ---
>>>>>>  drivers/staging/iio/adc/ad7280a.c | 21 +++++++++++----------
>>>>>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
>>>>>> index ee679ac..27a3ce3 100644
>>>>>> --- a/drivers/staging/iio/adc/ad7280a.c
>>>>>> +++ b/drivers/staging/iio/adc/ad7280a.c
>>>>>> @@ -136,6 +136,7 @@ struct ad7280_state {
>>>>>>       unsigned char                   cb_mask[AD7280A_MAX_CHAIN];
>>>>>>
>>>>>>       __be32                          buf[2] ____cacheline_aligned;
>>>>>> +     struct mutex                    lock;  /* protect sensor state */
>>>>>>  };
>>>>>>
>>>>>>  static void ad7280_crc8_build_table(unsigned char *crc_tab)
>>>>>> @@ -410,7 +411,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
>>>>>>       devaddr = this_attr->address >> 8;
>>>>>>       ch = this_attr->address & 0xFF;
>>>>>>
>>>>>> -     mutex_lock(&indio_dev->mlock);
>>>>>> +     mutex_lock(&st->lock);
>>>>>>       if (readin)
>>>>>>               st->cb_mask[devaddr] |= 1 << (ch + 2);
>>>>>>       else
>>>>>> @@ -418,7 +419,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
>>>>>>
>>>>>>       ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE,
>>>>>>                          0, st->cb_mask[devaddr]);
>>>>>> -     mutex_unlock(&indio_dev->mlock);
>>>>>> +     mutex_unlock(&st->lock);
>>>>>>
>>>>>>       return ret ? ret : len;
>>>>>>  }
>>>>>> @@ -433,10 +434,10 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
>>>>>>       int ret;
>>>>>>       unsigned int msecs;
>>>>>>
>>>>>> -     mutex_lock(&indio_dev->mlock);
>>>>>> +     mutex_lock(&st->lock);
>>>>>>       ret = ad7280_read(st, this_attr->address >> 8,
>>>>>>                         this_attr->address & 0xFF);
>>>>>> -     mutex_unlock(&indio_dev->mlock);
>>>>>> +     mutex_unlock(&st->lock);
>>>>>>
>>>>>>       if (ret < 0)
>>>>>>               return ret;
>>>>>> @@ -466,11 +467,11 @@ static ssize_t ad7280_store_balance_timer(struct device *dev,
>>>>>>       if (val > 31)
>>>>>>               return -EINVAL;
>>>>>>
>>>>>> -     mutex_lock(&indio_dev->mlock);
>>>>>> +     mutex_lock(&st->lock);
>>>>>>       ret = ad7280_write(st, this_attr->address >> 8,
>>>>>>                          this_attr->address & 0xFF,
>>>>>>                          0, (val & 0x1F) << 3);
>>>>>> -     mutex_unlock(&indio_dev->mlock);
>>>>>> +     mutex_unlock(&st->lock);
>>>>>>
>>>>>>       return ret ? ret : len;
>>>>>>  }
>>>>>> @@ -655,7 +656,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
>>>>>>
>>>>>>       val = clamp(val, 0L, 0xFFL);
>>>>>>
>>>>>> -     mutex_lock(&indio_dev->mlock);
>>>>>> +     mutex_lock(&st->lock);
>>>>>>       switch ((u32)this_attr->address) {
>>>>>>       case AD7280A_CELL_OVERVOLTAGE:
>>>>>>               st->cell_threshhigh = val;
>>>>>> @@ -674,7 +675,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
>>>>>>       ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
>>>>>>                          this_attr->address, 1, val);
>>>>>>
>>>>>> -     mutex_unlock(&indio_dev->mlock);
>>>>>> +     mutex_unlock(&st->lock);
>>>>>>
>>>>>>       return ret ? ret : len;
>>>>>>  }
>>>>>> @@ -792,13 +793,13 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
>>>>>>
>>>>>>       switch (m) {
>>>>>>       case IIO_CHAN_INFO_RAW:
>>>>>> -             mutex_lock(&indio_dev->mlock);
>>>>>> +             mutex_lock(&st->lock);
>>>>>>               if (chan->address == AD7280A_ALL_CELLS)
>>>>>>                       ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
>>>>>>               else
>>>>>>                       ret = ad7280_read_channel(st, chan->address >> 8,
>>>>>>                                                 chan->address & 0xFF);
>>>>>> -             mutex_unlock(&indio_dev->mlock);
>>>>>> +             mutex_unlock(&st->lock);
>>>>>>
>>>>>>               if (ret < 0)
>>>>>>                       return ret;
>>>>>> --
>>>>>> 2.7.4
>>>>>>
>>>>>> --
>>>>
>>>
>>> --
>>> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
>>> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
>>> To post to this group, send email to outreachy-kernel@googlegroups.com.
>>> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/alpine.DEB.2.20.1703122235320.7649%40hadrien.
>>> For more options, visit https://groups.google.com/d/optout.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

