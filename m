Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Mon, 6 Jun 2011 12:56:02 +0100
Subject: RE: [PATCH] iio: trigger: Add filter callbacks
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713AAF3C9819@LIMKCMBX1.ad.analog.com>
References: <1307358075-25797-1-git-send-email-michael.hennerich@analog.com>
 <4DECBCCA.4020305@cam.ac.uk> <4DECBFE2.3020602@cam.ac.uk>
In-Reply-To: <4DECBFE2.3020602@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-06-06:
> On 06/06/11 12:40, Jonathan Cameron wrote:
>> On 06/06/11 12:01, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> Allow devices to reject triggers and vice versa.
>> The iio_trigger changes clash with a cleanup I just finished.
>> What mine is doing is adding an iio_trigger_ops structure which has
>> all of the per driver constant stuff (.owner and callbacks) lifted
>> from struct iio_trigger.
>>
>> I'll apply yours before mine and update those changes before posting.
>>
>> Basically what you have here is sound.  The bit that was in your
>> earlier patch will get eaten up by git anyway so that doesn't really
>> matter.
>>
>> Please adjust so as to pass back return values from the callbacks in
>> the error case.
>
> Actually, one more thing.  iio_validate_trigger in iio_dev is I guess
> constant per driver? (or at least a set of parts supported by a driver?)

sure

> If so, please put it in iio_info rather than iio_dev.
>
> Lets keep as much constant as possible!
>
> For that matter, they could both do with documenting in the kernel-doc
> for the structures as well.

Are you asking for an follow up patch?

> Jonathan
>>
>> Thanks,
>>
>> Jonathan
>>>
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>> ---
>>>  drivers/staging/iio/iio.h                  |    2 ++
>>>  drivers/staging/iio/industrialio-trigger.c |   16 +++++++++++++++-
>>>  drivers/staging/iio/trigger.h              |    2 ++
>>>  3 files changed, 19 insertions(+), 1 deletions(-)
>>> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
>>> index 78a0927..8ec4f41 100644
>>> --- a/drivers/staging/iio/iio.h
>>> +++ b/drivers/staging/iio/iio.h
>>> @@ -293,6 +293,8 @@ struct iio_dev {
>>>
>>>     u32                             *available_scan_masks;
>>>     struct iio_trigger              *trig;
>>> +   int (*iio_validate_trigger)     (struct iio_dev *indio_dev,
>>> +                                    struct iio_trigger *trig);
>>>     struct iio_poll_func            *pollfunc;
>>>
>>>     struct iio_chan_spec const *channels; diff --git
>>> a/drivers/staging/iio/industrialio-trigger.c
>>> b/drivers/staging/iio/industrialio-trigger.c
>>> index 6159023..1f6bc65 100644
>>> --- a/drivers/staging/iio/industrialio-trigger.c
>>> +++ b/drivers/staging/iio/industrialio-trigger.c
>>> @@ -294,6 +294,7 @@ struct iio_poll_func
>>>     pf->h =3D h;
>>>     pf->thread =3D thread;
>>>     pf->type =3D type;
>>> +   pf->private_data =3D private;
>> That's already in the patch you sent to Greg last week. I'm holding
>> that one in my local tree, and I'll guess Greg will pick it up and
>> push to Linus next time he is working with the staging tree.
>>
>>>
>>>     return pf;
>>>  }
>>> @@ -339,6 +340,8 @@ static ssize_t iio_trigger_write_current(struct
>>> device *dev,  {
>>>     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>>>     struct iio_trigger *oldtrig =3D dev_info->trig;
>>> +   struct iio_trigger *trig;
>>> +
>>>     mutex_lock(&dev_info->mlock);
>>>     if (dev_info->currentmode =3D=3D INDIO_RING_TRIGGERED) {
>>>             mutex_unlock(&dev_info->mlock);
>>> @@ -346,7 +349,18 @@ static ssize_t
>>> iio_trigger_write_current(struct
> device *dev,
>>>     }
>>>     mutex_unlock(&dev_info->mlock);
>>> -   dev_info->trig =3D iio_trigger_find_by_name(buf, len); +  trig =3D
>>> iio_trigger_find_by_name(buf, len); + +     if (trig &&
>>> dev_info->iio_validate_trigger &&
>>> +           dev_info->iio_validate_trigger(dev_info, trig)) +          =
     return -EINVAL;
>>> I'd rather see error returned from the callback passed on. + +      if
>>> (trig && trig->iio_validate_device &&
>>> +           trig->iio_validate_device(trig, dev_info)) +            ret=
urn -EINVAL; same
>>> here. + +   dev_info->trig =3D trig; +
>>>     if (oldtrig && dev_info->trig !=3D oldtrig)
>>>             iio_put_trigger(oldtrig);
>>>     if (dev_info->trig)
>>> diff --git a/drivers/staging/iio/trigger.h
>>> b/drivers/staging/iio/trigger.h index f329fe1..9218200 100644
>>> --- a/drivers/staging/iio/trigger.h
>>> +++ b/drivers/staging/iio/trigger.h
>>> @@ -48,6 +48,8 @@ struct iio_trigger {
>>>
>>>     int (*set_trigger_state)(struct iio_trigger *trig, bool state);
>>>     int (*try_reenable)(struct iio_trigger *trig);
>>> +   int (*iio_validate_device)(struct iio_trigger *trig,
>>> +                              struct iio_dev *indio_dev);
>>>
>>>     struct irq_chip                 subirq_chip;
>>>     int                             subirq_base;
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
