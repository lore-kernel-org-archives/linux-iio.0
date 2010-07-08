Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C35E8E0.8050905@cam.ac.uk>
Date: Thu, 08 Jul 2010 16:04:00 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: "Song, Barry" <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, manuel.stahl@iis.fraunhofer.de,
 jic23@hermes.cam.ac.uk
Subject: Re: [Uclinux-dist-devel] IIO ring buffer
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com> 	<4B82679F.3000807@cam.ac.uk> <AANLkTimmdhiZXBCTVvMNyjdf6n59wrWkLXPY1HkB14-p@mail.gmail.com> 	<4C065AE1.9090302@cam.ac.uk> <AANLkTikMRI4GgdJlOwtfDy_rMVGqn_A0vSRPIuASoLBP@mail.gmail.com> 	<4C24E4CC.6020508@cam.ac.uk> <AANLkTimTJyE4o0TwWshAaJyIS2lx_nLwdKS31Sw6jAMf@mail.gmail.com> 	<4C2878DC.7040908@cam.ac.uk> <AANLkTinTdyiv6c6lho50SpgDAJwCcUZ1jN5nQaT8oR_-@mail.gmail.com>
In-Reply-To: <AANLkTinTdyiv6c6lho50SpgDAJwCcUZ1jN5nQaT8oR_-@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

<snip>
>>>> The rest of your factoring out obviously requires the shared driver
>>>> state structure.  This all makes sense if we think that is a desirable
>>>> thing to do.
>>>>> +int iio_probe_common_trigger(struct iio_dev *indio_dev)
>>>>> +{
>>>>> +     int ret;
>>>>> +     struct iio_state *st = indio_dev->dev_data;
>>>>> +
>>>>> +     st->trig = iio_allocate_trigger();
>>>>> +     st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
>>>>> +     if (!st->trig->name) {
>>>>> +             ret = -ENOMEM;
>>>>> +             goto error_free_trig;
>>>>> +     }
>>>>> +     snprintf((char *)st->trig->name,
>>>>> +                     IIO_TRIGGER_NAME_LENGTH,
>>>>> +                     "iio-dev%d", indio_dev->id);
>>>>> +     st->trig->dev.parent = st->parent_dev;
>>>>> +     st->trig->owner = THIS_MODULE;
>>>>> +     st->trig->private_data = st;
>>>>> +     st->trig->set_trigger_state = &iio_common_trigger_set_state;
>>>>> +     st->trig->try_reenable = &iio_common_trigger_try_reen;
>>>>> +     st->trig->control_attrs = &iio_trigger_attr_group;
>>>>> +     ret = iio_trigger_register(st->trig);
>>>>> +
>>>>> +     /* select default trigger */
>>>>> +     indio_dev->trig = st->trig;
>>>>> +     if (ret)
>>>>> +             goto error_free_trig_name;
>>>>> +
>>>>> +     return 0;
>>>>> +
>>>>> +error_free_trig_name:
>>>>> +     kfree(st->trig->name);
>>>>> +error_free_trig:
>>>>> +     iio_free_trigger(st->trig);
>>>>> +
>>>>> +     return ret;
>>>>> +}
>>>>> +EXPORT_SYMBOL(iio_probe_common_trigger);
>>>>> +
>>>>
>>>>
>>>>> +void iio_remove_common_trigger(struct iio_dev *indio_dev)
>>>>> +{
>>>>> +     struct iio_state *state = indio_dev->dev_data;
>>>>> +
>>>>> +     iio_trigger_unregister(state->trig);
>>>>> +     kfree(state->trig->name);
>>>>> +     iio_free_trigger(state->trig);
>>>>> +}
>>>>> +EXPORT_SYMBOL(iio_remove_common_trigger);
>>>>
>>>> snipped rest as it is obvious boiler pate.
> 
> For this, how about we let bottom driver to implement
> set_trigger_state(), try_reenable(), and control_attrs of trigger, but
> probe() and remove() can be common like this:
> 
> drivers/staging/iio/ring_sw.h
> 
> struct iio_sw_ring_helper_state {
>        struct work_struct              work_trigger_to_ring;
>        struct iio_dev                  *indio_dev;
I'm not sure this wants to be in this struct.  The trigger and ring are intended
to be (more or less) completely separable.  If we do this, then we immediately
cannot use this code with devices not supplying a trigger, or those that are supplying
several different ones.

Again, you have highlighted an area with a lot of shared code, but perhaps some
care is needed to maximise the gain without restricting the generality of the code.
> +       struct iio_trigger              *trig;
>        int (*get_ring_element)(struct iio_sw_ring_helper_state *st, u8 *buf);
>        s64                             last_timestamp;
> };
> 
> drivers/staging/iio/ring_sw.c
> 
> +int iio_sw_probe_trigger(struct iio_dev *indio_dev, char *name,
> struct attribute_group *attr_group)
> +{
> +        int ret;
> +        struct iio_sw_ring_helper_state *st = (struct
> iio_sw_ring_helper_state *)indio_dev->dev_data;
> 
Perhaps we can give iio_allocate_trigger some parameters
and effectively move much of this shared functionality in there?
The tricky bit is the name, as it has different conventions for
the triggers that are not coming from devices (e.g. gpio)...
> +        st->trig = iio_allocate_trigger();
Aside: a kasprintf call can clean this next bit up.
> +        st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
> +        if (!st->trig->name) {
> +                ret = -ENOMEM;
> +                goto error_free_trig;
> +        }
> +       snprintf((char *)st->trig->name,
> +                        IIO_TRIGGER_NAME_LENGTH,
> +                        "%s%d", name, indio_dev->id);
> +        st->trig->dev.parent = st->parent_dev;
> +        st->trig->owner = THIS_MODULE;
The owner bit just went wrong if we do this as it is no longer the
device driver module.

> +        st->trig->private_data = st;
> +        st->trig->control_attrs = attr_group;
> +        ret = iio_trigger_register(st->trig);
> 
> +        indio_dev->trig = st->trig;
> +        if (ret)
> +                goto error_free_trig_name;
> 
> +        return 0;
> 
> +error_free_trig_name:
>         kfree(st->trig->name);
> +error_free_trig:
> +        iio_free_trigger(st->trig);
> 
> +        return ret;
> +}
> +EXPORT_SYMBOL(iio_sw_probe_trigger);
> 
> +void iio_sw_remove_trigger(struct iio_dev *indio_dev)
> +{
> +        struct iio_state *state = indio_dev->dev_data;
> +
> +        iio_trigger_unregister(state->trig);
> +        kfree(state->trig->name);
> +        iio_free_trigger(state->trig);
> +}
> +EXPORT_SYMBOL(iio_sw_remove_trigger);
> 
> name and attribute_group can be params for iio_sw_probe_trigger()
> since functions depend on them. But set_trigger_state(),
> try_reenable() can be given chip-special entries in bottom driver
> after  iio_sw_probe_trigger() returns successfully.
> 
Can we hold off on doing anything major in here for now. I'd like
to see a few more drivers doing event handling as well as triggers
as they quite often interact to a degree and may well complicate
things
 with unifying the trigger code. (not sure yet!)
<snip>

Thanks for looking at all the other patches. I'll send those
off to Greg shortly.

Jonathan
