Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4DEF27AF.2040702@analog.com>
Date: Wed, 8 Jun 2011 09:41:35 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Subject: Re: [PATCH] iio: trigger: Add filter callbac
References: <1307389953-15467-1-git-send-email-michael.hennerich@analog.com> <4DEDE5C5.6080309@cam.ac.uk> <4DEDF4BB.3040900@analog.com> <4DEE50F5.6030409@cam.ac.uk>
In-Reply-To: <4DEE50F5.6030409@cam.ac.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/07/2011 06:25 PM, Jonathan Cameron wrote:
> On 06/07/11 10:51, Michael Hennerich wrote:
>> On 06/07/2011 10:48 AM, Jonathan Cameron wrote:
>>> On 06/06/11 20:52, michael.hennerich@analog.com wrote:
>>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>>
>>>> Allow devices to reject triggers and vice versa.
>>>>
>>>> Changes since V1:
>>>> Added kernel-doc
>>>> Moved callback into iio_info
>>>> Changed function naming
>>>> Revised return value passing
>>>> Included trigger.h to avoid warnings
>>>> Moved definition of struct iio_poll_func to avoid warnings
>>> This last change should be a separate patch.  If nothing else
>>> it ought to go into mainline asap, whereas the rest of this
>>> isn't quite so obviously a fix.  Also, what is the warning?
>>> (nought showing up here)
>> The warnings started with putting the callback into iio_info while it =
didn't warn in iio_dev.
>>
>> drivers/staging/iio/adc/../iio.h:263: warning: =91struct iio_trigger=92=
 declared inside parameter list
>> drivers/staging/iio/adc/../iio.h:263: warning: its scope is only this =
definition or declaration, which is probably not what you want
>> In file included from drivers/staging/iio/industrialio-trigger.c:19:
>>
>> So I included trigger.g in iio.h
> Firstly, please don't do that. I'd like to keep triggers as separate an=
d opaque to simple
> drivers as possible.  Hence just put a struct iio_trigger; somewhere ab=
ove where it is needed.
Ok - I'll add the forward declaration in favour of the include.
>> Then these warnings appeared -
>> The question is not why those appear - this is quite obvious..
>> However why haven't we seen these before???
> Weird indeed.  Please do fix them, but in a separate patch from the one=
 adding filtering.
Already done - just waiting for your Ack on the AD7793 driver so I can=20
send out the entire sequence.

0001-iio-trigger-Move-declaration-of-struct-iio_poll_func.patch
0002-iio-trigger-Add-filter-callback.patch
0003-iio-industrialio-core-iio_write_channel_info-accept-.patch
0004-IIO-ADC-New-driver-for-AD7792-AD7793-3-Channel-SPI-A.patch


> You can trigger the same warnings by putting iio.h after trigger.h in a=
ny of the drivers.
> Given the wonders of cut and paste that never happened before.  Someone=
 more bored
> than me can figure out what wonderful route meant these were defined wh=
en used...
>
>>
>> In file included from drivers/staging/iio/iio.h:18,
>> from drivers/staging/iio/industrialio-core.c:24:
>> drivers/staging/iio/trigger.h:101: warning: =91struct iio_poll_func=92=
 declared inside parameter list
>> drivers/staging/iio/trigger.h:101: warning: its scope is only this def=
inition or declaration, which is probably not what you want
>> drivers/staging/iio/trigger.h:110: warning: =91struct iio_poll_func=92=
 declared inside parameter list
>>
>> In file included from drivers/staging/iio/iio.h:18,
>> from drivers/staging/iio/industrialio-trigger.c:19:
>> drivers/staging/iio/trigger.h:101: warning: =91struct iio_poll_func=92=
 declared inside parameter list
>> drivers/staging/iio/trigger.h:101: warning: its scope is only this def=
inition or declaration, which is probably not what you want
>> drivers/staging/iio/trigger.h:110: warning: =91struct iio_poll_func=92=
 declared inside parameter list
>> drivers/staging/iio/industrialio-trigger.c:226: error: conflicting typ=
es for =91iio_trigger_attach_poll_func=92
>> drivers/staging/iio/trigger.h:100: error: previous declaration of =91i=
io_trigger_attach_poll_func=92 was here
>> drivers/staging/iio/industrialio-trigger.c:242: error: conflicting typ=
es for =91iio_trigger_attach_poll_func=92
>> drivers/staging/iio/trigger.h:100: error: previous declaration of =91i=
io_trigger_attach_poll_func=92 was here
>> drivers/staging/iio/industrialio-trigger.c:244: error: conflicting typ=
es for =91iio_trigger_dettach_poll_func=92
>> drivers/staging/iio/trigger.h:109: error: previous declaration of =91i=
io_trigger_dettach_poll_func=92 was here
>> drivers/staging/iio/industrialio-trigger.c:263: error: conflicting typ=
es for =91iio_trigger_dettach_poll_func=92
>> drivers/staging/iio/trigger.h:109: error: previous declaration of =91i=
io_trigger_dettach_poll_func=92 was here
>> make[4]: *** [drivers/staging/iio/industrialio-trigger.o] Error 1
>>
>>> Hence, if you have time please break that bit out.  Ack is
>>> for both patches if you do this.
>>>
>>> Otherwise, all looks good to me - I'll pull into my local
>>> tree to rebase the trigger cleanups on top, but feel free
>>> to push to Greg as well.  I'm waiting on a few tests of non
>>> ADI parts before pushing out the dev_data removal set.
>>>
>>> The addition of these functions would also be slightly nicer
>>> if in a set with a patch that actually uses them.
>> Well - AD7793 driver I'm going to send out for another round of review=
 will use them.
>>
>>> Thanks,
>>>
>>> Jonathan
>>>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
>>> Acked-by: Jonathan Cameron<jic23@cam.ac.uk>
>>>> ---
>>>>    drivers/staging/iio/iio.h                  |    6 +++
>>>>    drivers/staging/iio/industrialio-trigger.c |   20 ++++++++++-
>>>>    drivers/staging/iio/trigger.h              |   52 +++++++++++++++=
-------------
>>>>    3 files changed, 53 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
>>>> index 78a0927..9bf8b11 100644
>>>> --- a/drivers/staging/iio/iio.h
>>>> +++ b/drivers/staging/iio/iio.h
>>>> @@ -15,6 +15,7 @@
>>>>    #include<linux/irq.h>
>>>>    #include "sysfs.h"
>>>>    #include "chrdev.h"
>>>> +#include "trigger.h"
>>>>
>>>>    /* IIO TODO LIST */
>>>>    /*
>>>> @@ -224,6 +225,8 @@ static inline s64 iio_get_time_ns(void)
>>>>     *                   is event dependant. event_code specifies whi=
ch event.
>>>>     * @write_event_value:       write the value associate with the e=
vent.
>>>>     *                   Meaning is event dependent.
>>>> + * @validate_trigger:        function to validate the trigger when =
the
>>>> + *                   current trigger gets changed.
>>>>     **/
>>>>    struct iio_info {
>>>>         struct module                   *driver_module;
>>>> @@ -256,6 +259,9 @@ struct iio_info {
>>>>         int (*write_event_value)(struct iio_dev *indio_dev,
>>>>                                  int event_code,
>>>>                                  int val);
>>>> +     int (*validate_trigger)(struct iio_dev *indio_dev,
>>>> +                             struct iio_trigger *trig);
>>>> +
>>>>    };
>>>>
>>>>    /**
>>>> diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/st=
aging/iio/industrialio-trigger.c
>>>> index d504aa2..90ca2df 100644
>>>> --- a/drivers/staging/iio/industrialio-trigger.c
>>>> +++ b/drivers/staging/iio/industrialio-trigger.c
>>>> @@ -340,6 +340,9 @@ static ssize_t iio_trigger_write_current(struct =
device *dev,
>>>>    {
>>>>         struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>>>>         struct iio_trigger *oldtrig =3D dev_info->trig;
>>>> +     struct iio_trigger *trig;
>>>> +     int ret;
>>>> +
>>>>         mutex_lock(&dev_info->mlock);
>>>>         if (dev_info->currentmode =3D=3D INDIO_RING_TRIGGERED) {
>>>>                 mutex_unlock(&dev_info->mlock);
>>>> @@ -347,7 +350,22 @@ static ssize_t iio_trigger_write_current(struct=
 device *dev,
>>>>         }
>>>>         mutex_unlock(&dev_info->mlock);
>>>>
>>>> -     dev_info->trig =3D iio_trigger_find_by_name(buf, len);
>>>> +     trig =3D iio_trigger_find_by_name(buf, len);
>>>> +
>>>> +     if (trig&&   dev_info->info->validate_trigger) {
>>>> +             ret =3D dev_info->info->validate_trigger(dev_info, tri=
g);
>>>> +             if (ret)
>>>> +                     return ret;
>>>> +     }
>>>> +
>>>> +     if (trig&&   trig->validate_device) {
>>>> +             ret =3D trig->validate_device(trig, dev_info);
>>>> +             if (ret)
>>>> +                     return ret;
>>>> +     }
>>>> +
>>>> +     dev_info->trig =3D trig;
>>>> +
>>>>         if (oldtrig&&   dev_info->trig !=3D oldtrig)
>>>>                 iio_put_trigger(oldtrig);
>>>>         if (dev_info->trig)
>>>> diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/tri=
gger.h
>>>> index f329fe1..e0b58ed 100644
>>>> --- a/drivers/staging/iio/trigger.h
>>>> +++ b/drivers/staging/iio/trigger.h
>>>> @@ -29,6 +29,8 @@ struct iio_subirq {
>>>>     * @set_trigger_state:       [DRIVER] switch on/off the trigger o=
n demand
>>>>     * @try_reenable:    function to reenable the trigger when the
>>>>     *                   use count is zero (may be NULL)
>>>> + * @validate_device: function to validate the device when the
>>>> + *                   current trigger gets changed.
>>>>     * @subirq_chip:     [INTERN] associate 'virtual' irq chip.
>>>>     * @subirq_base:     [INTERN] base number for irqs provided by tr=
igger.
>>>>     * @subirqs:         [INTERN] information about the 'child' irqs.
>>>> @@ -48,6 +50,8 @@ struct iio_trigger {
>>>>
>>>>         int (*set_trigger_state)(struct iio_trigger *trig, bool stat=
e);
>>>>         int (*try_reenable)(struct iio_trigger *trig);
>>>> +     int (*validate_device)(struct iio_trigger *trig,
>>>> +                            struct iio_dev *indio_dev);
>>>>
>>>>         struct irq_chip                 subirq_chip;
>>>>         int                             subirq_base;
>>>> @@ -57,6 +61,30 @@ struct iio_trigger {
>>>>         struct mutex                    pool_lock;
>>>>    };
>>>>
>>>> +/**
>>>> + * struct iio_poll_func - poll function pair
>>>> + *
>>>> + * @private_data:            data specific to device (passed into p=
oll func)
>>>> + * @h:                               the function that is actually =
run on trigger
>>>> + * @thread:                  threaded interrupt part
>>>> + * @type:                    the type of interrupt (basically if on=
eshot)
>>>> + * @name:                    name used to identify the trigger cons=
umer.
>>>> + * @irq:                     the corresponding irq as allocated fro=
m the
>>>> + *                           trigger pool
>>>> + * @timestamp:                       some devices need a timestamp =
grabbed as soon
>>>> + *                           as possible after the trigger - hence =
handler
>>>> + *                           passes it via here.
>>>> + **/
>>>> +struct iio_poll_func {
>>>> +     void                            *private_data;
>>>> +     irqreturn_t (*h)(int irq, void *p);
>>>> +     irqreturn_t (*thread)(int irq, void *p);
>>>> +     int type;
>>>> +     char *name;
>>>> +     int irq;
>>>> +     s64 timestamp;
>>>> +};
>>>> +
>>>>    static inline struct iio_trigger *to_iio_trigger(struct device *d=
)
>>>>    {
>>>>         return container_of(d, struct iio_trigger, dev);
>>>> @@ -136,30 +164,6 @@ static inline void iio_trigger_put_irq(struct i=
io_trigger *trig, int irq)
>>>>         mutex_unlock(&trig->pool_lock);
>>>>    };
>>>>
>>>> -/**
>>>> - * struct iio_poll_func - poll function pair
>>>> - *
>>>> - * @private_data:            data specific to device (passed into p=
oll func)
>>>> - * @h:                               the function that is actually =
run on trigger
>>>> - * @thread:                  threaded interrupt part
>>>> - * @type:                    the type of interrupt (basically if on=
eshot)
>>>> - * @name:                    name used to identify the trigger cons=
umer.
>>>> - * @irq:                     the corresponding irq as allocated fro=
m the
>>>> - *                           trigger pool
>>>> - * @timestamp:                       some devices need a timestamp =
grabbed as soon
>>>> - *                           as possible after the trigger - hence =
handler
>>>> - *                           passes it via here.
>>>> - **/
>>>> -struct iio_poll_func {
>>>> -     void                            *private_data;
>>>> -     irqreturn_t (*h)(int irq, void *p);
>>>> -     irqreturn_t (*thread)(int irq, void *p);
>>>> -     int type;
>>>> -     char *name;
>>>> -     int irq;
>>>> -     s64 timestamp;
>>>> -};
>>>> -
>>>>    struct iio_poll_func
>>>>    *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
>>>>                     irqreturn_t (*thread)(int irq, void *p),
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
