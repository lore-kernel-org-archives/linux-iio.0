Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42387 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935166AbdCLUCl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2017 16:02:41 -0400
Subject: Re: [PATCH v2 1/2] iio: Allow triggers to be used as parent of others
 triggers
To: Jason Kridner <jkridner@gmail.com>
References: <1487254984-20122-1-git-send-email-benjamin.gaignard@st.com>
 <1487254984-20122-2-git-send-email-benjamin.gaignard@st.com>
 <e1602065-2817-d380-7f7a-3961070c384f@kernel.org>
 <3946A931-3146-47C4-BA21-0D382F526326@gmail.com>
 <60fd2423-b150-c543-9e12-aa66596a0c93@kernel.org>
 <69B3E027-9723-41FB-A89A-D8190A25490F@gmail.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        fabrice.gasnier@st.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linaro-kernel@lists.linaro.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e85b66c3-fd4c-43f7-4ea1-db3d20e95f43@kernel.org>
Date: Sun, 12 Mar 2017 20:02:36 +0000
MIME-Version: 1.0
In-Reply-To: <69B3E027-9723-41FB-A89A-D8190A25490F@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/03/17 15:29, Jason Kridner wrote:
> 
> 
>> On Mar 5, 2017, at 5:11 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>>> On 25/02/17 21:12, Jason Kridner wrote:
>>>
>>>
>>>>> On Feb 19, 2017, at 10:08 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>>>
>>>>> On 16/02/17 14:23, Benjamin Gaignard wrote:
>>>>> Add "parent_trigger" sysfs attribute to iio trigger to be able
>>>>> to set a parent to the current trigger.
>>>>> Parent trigger edges or levels could be used to control current
>>>>> trigger status for example to start, stop or reset it.
>>>> Reset needs a description as well. In this case I think it boils
>>>> down to syncing a periodic timer driven trigger.
>>>>>
>>>>> Introduce validate_trigger function in iio_trigger_ops which does
>>>>> the same than validate_device but with a trigger as second parameter.
>>>>> Driver must implement this function and add dev_attr_parent_trigger
>>>>> in their trigger attribute group to be able to use parent trigger
>>>>> feature.
>>>>>
>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>>> I think I'm fine with this but it's 'unusual' enough that I want
>>>> to get to the point where we have some more people involved in
>>>> the discussion.
>>>
>>> I like the idea of enabling triggers to set triggers, but I'd love to
>>> see something more generic. I've got the problem of trying to add
>>> some state control to IIO triggers to reduce userspace intractions,
>>> preferably without requiring users to create kernel drivers.
>>>
>>> To provide a more generic state machine, would injecting something
>>> like BPF to connect triggers be better?
>>
>> In the simple case that sounds over engineered to me.
>> Now for the more complex usecases (I guessing you are thinking
>> about trying to move control loop control in kernel) then
>> BPF or similar is certainly interesting.
> 
> That's certainly the idea. I'd like for systems like robots to be
> able to be made secure. Not that userspace can't be made secure, but
> the extra eyeballs, lower overhead and controlled access to hardware
> makes sense to think about kernel land.
I'll buy that it 'might' make sense.  Will be interesting to see how
this pans out.
>>
>> I've been thinking about it for more simple stuff such as
>> filtering data before passing to userspace but maybe there are
>> more general usecases.
> 
> My concern is if there's a complex coverage of several small use
> cases for filtering, etc, it'll just take us a lot longer to realize
> we ultimately need to solve the general case. I think filtering
> network traffic looks very similar and has lots of previous focus.
> We'd be leveraging an already existing infrastructure and can take
> steps to make the simple use cases easier to solve using the general
> infrastructure.
Whilst I'm happy with this in principle, it's still a pipe dream at
the moment and I'm not happy to hold up existing work on the basis
something better might come along.

Ultimately we need to cover all these simple cases as well with the
general system and I don't have particular issues with supporting
legacy systems along side something better.

So, I'm happy to support and work with you and others on a better
solution, but don't want to be in the position of telling people
who are doing good work within the existing constraints to back off
for an unknown time period.  The new stuff has to be in parallel.

Jonathan
> 

>> Jonathan
>>>>
>>>> Jonathan
>>>>>
>>>>> version 2:
>>>>> - add comment about parent trigger usage
>>>>> - parent trigger attribute must be set the driver no more by IIO core
>>>>> ---
>>>>> .../ABI/testing/sysfs-bus-iio-trigger-sysfs        | 10 ++++
>>>>> drivers/iio/industrialio-trigger.c                 | 68 ++++++++++++++++++++++
>>>>> include/linux/iio/trigger.h                        |  7 ++-
>>>>> 3 files changed, 84 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
>>>>> index 04ac623..9862562 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
>>>>> @@ -40,3 +40,13 @@ Description:
>>>>>       associated file, representing the id of the trigger that needs
>>>>>       to be removed. If the trigger can't be found, an invalid
>>>>>       argument message will be returned to the user.
>>>>> +
>>>>> +What:        /sys/bus/iio/devices/triggerX/parent_trigger
>>>>> +KernelVersion:    4.12
>>>>> +Contact:    linux-iio@vger.kernel.org
>>>>> +Description:
>>>>> +        This attribute is used to set a trigger as parent for the
>>>>> +        current trigger. If the trigger can't use the parent an
>>>>> +        invalid argument message will be returned.
>>>>> +        Parent trigger edges or levels could be used to control current
>>>>> +        trigger for example to start, stop or reset it.
>>>>> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
>>>>> index 978729f..238aa1a 100644
>>>>> --- a/drivers/iio/industrialio-trigger.c
>>>>> +++ b/drivers/iio/industrialio-trigger.c
>>>>> @@ -58,6 +58,74 @@ static ssize_t iio_trigger_read_name(struct device *dev,
>>>>>
>>>>> static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
>>>>>
>>>>> +/**
>>>>> + * iio_trigger_read_parent() - trigger consumer sysfs query parent trigger
>>>>> + * @dev:    device associated with an industrial I/O trigger
>>>>> + * @attr:    pointer to the device_attribute structure that
>>>>> + *        is being processed
>>>>> + * @buf:    buffer where the current trigger name will be printed into
>>>>> + *
>>>>> + * Return: a negative number on failure, the number of characters written
>>>>> + *       on success or 0 if no trigger is available
>>>>> + */
>>>>> +static ssize_t iio_trigger_read_parent(struct device *dev,
>>>>> +                       struct device_attribute *attr,
>>>>> +                       char *buf)
>>>>> +{
>>>>> +    struct iio_trigger *trig = to_iio_trigger(dev);
>>>>> +
>>>>> +    if (trig->parent_trigger)
>>>>> +        return sprintf(buf, "%s\n", trig->parent_trigger->name);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static struct iio_trigger *iio_trigger_find_by_name(const char *name,
>>>>> +                            size_t len);
>>>>> +
>>>>> +/**
>>>>> + * iio_trigger_write_parent() - trigger consumer sysfs set parent trigger
>>>>> + * @dev:    device associated with an industrial I/O trigger
>>>>> + * @attr:    device attribute that is being processed
>>>>> + * @buf:    string buffer that holds the name of the trigger
>>>>> + * @len:    length of the trigger name held by buf
>>>>> + *
>>>>> + * Return: negative error code on failure or length of the buffer
>>>>> + *       on success
>>>>> + */
>>>>> +static ssize_t iio_trigger_write_parent(struct device *dev,
>>>>> +                    struct device_attribute *attr,
>>>>> +                    const char *buf,
>>>>> +                    size_t len)
>>>>> +{
>>>>> +    struct iio_trigger *parent;
>>>>> +    struct iio_trigger *child = to_iio_trigger(dev);
>>>>> +    int ret;
>>>>> +
>>>>> +    if (!child->ops->validate_trigger)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (atomic_read(&child->use_count))
>>>>> +        return -EBUSY;
>>>>> +
>>>>> +    parent = iio_trigger_find_by_name(buf, len);
>>>>> +
>>>>> +    if (parent == child->parent_trigger)
>>>>> +        return len;
>>>>> +
>>>>> +    ret = child->ops->validate_trigger(child, parent);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +
>>>>> +    child->parent_trigger = parent;
>>>>> +
>>>>> +    return len;
>>>>> +}
>>>>> +
>>>>> +DEVICE_ATTR(parent_trigger, S_IRUGO | S_IWUSR,
>>>>> +        iio_trigger_read_parent, iio_trigger_write_parent);
>>>>> +EXPORT_SYMBOL_GPL(dev_attr_parent_trigger);
>>>>> +
>>>>> static struct attribute *iio_trig_dev_attrs[] = {
>>>>>   &dev_attr_name.attr,
>>>>>   NULL,
>>>>> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
>>>>> index ea08302..efa2983 100644
>>>>> --- a/include/linux/iio/trigger.h
>>>>> +++ b/include/linux/iio/trigger.h
>>>>> @@ -20,6 +20,7 @@ struct iio_subirq {
>>>>>
>>>>> struct iio_dev;
>>>>> struct iio_trigger;
>>>>> +extern struct device_attribute dev_attr_parent_trigger;
>>>>>
>>>>> /**
>>>>> * struct iio_trigger_ops - operations structure for an iio_trigger.
>>>>> @@ -29,6 +30,7 @@ struct iio_subirq {
>>>>> *            use count is zero (may be NULL)
>>>>> * @validate_device:    function to validate the device when the
>>>>> *            current trigger gets changed.
>>>>> + * @validate_trigger:    function to validate the parent trigger (may be NULL)
>>>>> *
>>>>> * This is typically static const within a driver and shared by
>>>>> * instances of a given device.
>>>>> @@ -39,9 +41,10 @@ struct iio_trigger_ops {
>>>>>   int (*try_reenable)(struct iio_trigger *trig);
>>>>>   int (*validate_device)(struct iio_trigger *trig,
>>>>>                  struct iio_dev *indio_dev);
>>>>> +    int (*validate_trigger)(struct iio_trigger *trig,
>>>>> +                struct iio_trigger *parent);
>>>>> };
>>>>>
>>>>> -
>>>>> /**
>>>>> * struct iio_trigger - industrial I/O trigger device
>>>>> * @ops:        [DRIVER] operations structure
>>>>> @@ -59,6 +62,7 @@ struct iio_trigger_ops {
>>>>> * @attached_own_device:[INTERN] if we are using our own device as trigger,
>>>>> *            i.e. if we registered a poll function to the same
>>>>> *            device as the one providing the trigger.
>>>>> + * @parent_trigger:    [INTERN] parent trigger
>>>>> **/
>>>>> struct iio_trigger {
>>>>>   const struct iio_trigger_ops    *ops;
>>>>> @@ -77,6 +81,7 @@ struct iio_trigger {
>>>>>   unsigned long pool[BITS_TO_LONGS(CONFIG_IIO_CONSUMERS_PER_TRIGGER)];
>>>>>   struct mutex            pool_lock;
>>>>>   bool                attached_own_device;
>>>>> +    struct iio_trigger        *parent_trigger;
>>>>> };
>>>>>
>>>>>
>>>>>
>>>>
>>>> _______________________________________________
>>>> linaro-kernel mailing list
>>>> linaro-kernel@lists.linaro.org
>>>> https://lists.linaro.org/mailman/listinfo/linaro-kernel
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

