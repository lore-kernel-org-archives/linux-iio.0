Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34385 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbdBYVWS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 16:22:18 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/2] iio: Allow triggers to be used as parent of others triggers
From: Jason Kridner <jkridner@gmail.com>
In-Reply-To: <e1602065-2817-d380-7f7a-3961070c384f@kernel.org>
Date: Sat, 25 Feb 2017 16:12:55 -0500
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        fabrice.gasnier@st.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linaro-kernel@lists.linaro.org
Message-Id: <3946A931-3146-47C4-BA21-0D382F526326@gmail.com>
References: <1487254984-20122-1-git-send-email-benjamin.gaignard@st.com> <1487254984-20122-2-git-send-email-benjamin.gaignard@st.com> <e1602065-2817-d380-7f7a-3961070c384f@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> On Feb 19, 2017, at 10:08 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>=20
>> On 16/02/17 14:23, Benjamin Gaignard wrote:
>> Add "parent_trigger" sysfs attribute to iio trigger to be able
>> to set a parent to the current trigger.
>> Parent trigger edges or levels could be used to control current
>> trigger status for example to start, stop or reset it.
> Reset needs a description as well. In this case I think it boils
> down to syncing a periodic timer driven trigger.
>>=20
>> Introduce validate_trigger function in iio_trigger_ops which does
>> the same than validate_device but with a trigger as second parameter.
>> Driver must implement this function and add dev_attr_parent_trigger
>> in their trigger attribute group to be able to use parent trigger
>> feature.
>>=20
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> I think I'm fine with this but it's 'unusual' enough that I want
> to get to the point where we have some more people involved in
> the discussion.

I like the idea of enabling triggers to set triggers, but I'd love to see so=
mething more generic. I've got the problem of trying to add some state contr=
ol to IIO triggers to reduce userspace intractions, preferably without requi=
ring users to create kernel drivers.=20

To provide a more generic state machine, would injecting something like BPF t=
o connect triggers be better?

>=20
> Jonathan
>>=20
>> version 2:
>> - add comment about parent trigger usage
>> - parent trigger attribute must be set the driver no more by IIO core
>> ---
>> .../ABI/testing/sysfs-bus-iio-trigger-sysfs        | 10 ++++
>> drivers/iio/industrialio-trigger.c                 | 68 +++++++++++++++++=
+++++
>> include/linux/iio/trigger.h                        |  7 ++-
>> 3 files changed, 84 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs b/Docu=
mentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
>> index 04ac623..9862562 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
>> @@ -40,3 +40,13 @@ Description:
>>        associated file, representing the id of the trigger that needs
>>        to be removed. If the trigger can't be found, an invalid
>>        argument message will be returned to the user.
>> +
>> +What:        /sys/bus/iio/devices/triggerX/parent_trigger
>> +KernelVersion:    4.12
>> +Contact:    linux-iio@vger.kernel.org
>> +Description:
>> +        This attribute is used to set a trigger as parent for the
>> +        current trigger. If the trigger can't use the parent an
>> +        invalid argument message will be returned.
>> +        Parent trigger edges or levels could be used to control current
>> +        trigger for example to start, stop or reset it.
>> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-trigger.c
>> index 978729f..238aa1a 100644
>> --- a/drivers/iio/industrialio-trigger.c
>> +++ b/drivers/iio/industrialio-trigger.c
>> @@ -58,6 +58,74 @@ static ssize_t iio_trigger_read_name(struct device *de=
v,
>>=20
>> static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
>>=20
>> +/**
>> + * iio_trigger_read_parent() - trigger consumer sysfs query parent trigg=
er
>> + * @dev:    device associated with an industrial I/O trigger
>> + * @attr:    pointer to the device_attribute structure that
>> + *        is being processed
>> + * @buf:    buffer where the current trigger name will be printed into
>> + *
>> + * Return: a negative number on failure, the number of characters writte=
n
>> + *       on success or 0 if no trigger is available
>> + */
>> +static ssize_t iio_trigger_read_parent(struct device *dev,
>> +                       struct device_attribute *attr,
>> +                       char *buf)
>> +{
>> +    struct iio_trigger *trig =3D to_iio_trigger(dev);
>> +
>> +    if (trig->parent_trigger)
>> +        return sprintf(buf, "%s\n", trig->parent_trigger->name);
>> +
>> +    return 0;
>> +}
>> +
>> +static struct iio_trigger *iio_trigger_find_by_name(const char *name,
>> +                            size_t len);
>> +
>> +/**
>> + * iio_trigger_write_parent() - trigger consumer sysfs set parent trigge=
r
>> + * @dev:    device associated with an industrial I/O trigger
>> + * @attr:    device attribute that is being processed
>> + * @buf:    string buffer that holds the name of the trigger
>> + * @len:    length of the trigger name held by buf
>> + *
>> + * Return: negative error code on failure or length of the buffer
>> + *       on success
>> + */
>> +static ssize_t iio_trigger_write_parent(struct device *dev,
>> +                    struct device_attribute *attr,
>> +                    const char *buf,
>> +                    size_t len)
>> +{
>> +    struct iio_trigger *parent;
>> +    struct iio_trigger *child =3D to_iio_trigger(dev);
>> +    int ret;
>> +
>> +    if (!child->ops->validate_trigger)
>> +        return -EINVAL;
>> +
>> +    if (atomic_read(&child->use_count))
>> +        return -EBUSY;
>> +
>> +    parent =3D iio_trigger_find_by_name(buf, len);
>> +
>> +    if (parent =3D=3D child->parent_trigger)
>> +        return len;
>> +
>> +    ret =3D child->ops->validate_trigger(child, parent);
>> +    if (ret)
>> +        return ret;
>> +
>> +    child->parent_trigger =3D parent;
>> +
>> +    return len;
>> +}
>> +
>> +DEVICE_ATTR(parent_trigger, S_IRUGO | S_IWUSR,
>> +        iio_trigger_read_parent, iio_trigger_write_parent);
>> +EXPORT_SYMBOL_GPL(dev_attr_parent_trigger);
>> +
>> static struct attribute *iio_trig_dev_attrs[] =3D {
>>    &dev_attr_name.attr,
>>    NULL,
>> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
>> index ea08302..efa2983 100644
>> --- a/include/linux/iio/trigger.h
>> +++ b/include/linux/iio/trigger.h
>> @@ -20,6 +20,7 @@ struct iio_subirq {
>>=20
>> struct iio_dev;
>> struct iio_trigger;
>> +extern struct device_attribute dev_attr_parent_trigger;
>>=20
>> /**
>>  * struct iio_trigger_ops - operations structure for an iio_trigger.
>> @@ -29,6 +30,7 @@ struct iio_subirq {
>>  *            use count is zero (may be NULL)
>>  * @validate_device:    function to validate the device when the
>>  *            current trigger gets changed.
>> + * @validate_trigger:    function to validate the parent trigger (may be=
 NULL)
>>  *
>>  * This is typically static const within a driver and shared by
>>  * instances of a given device.
>> @@ -39,9 +41,10 @@ struct iio_trigger_ops {
>>    int (*try_reenable)(struct iio_trigger *trig);
>>    int (*validate_device)(struct iio_trigger *trig,
>>                   struct iio_dev *indio_dev);
>> +    int (*validate_trigger)(struct iio_trigger *trig,
>> +                struct iio_trigger *parent);
>> };
>>=20
>> -
>> /**
>>  * struct iio_trigger - industrial I/O trigger device
>>  * @ops:        [DRIVER] operations structure
>> @@ -59,6 +62,7 @@ struct iio_trigger_ops {
>>  * @attached_own_device:[INTERN] if we are using our own device as trigge=
r,
>>  *            i.e. if we registered a poll function to the same
>>  *            device as the one providing the trigger.
>> + * @parent_trigger:    [INTERN] parent trigger
>>  **/
>> struct iio_trigger {
>>    const struct iio_trigger_ops    *ops;
>> @@ -77,6 +81,7 @@ struct iio_trigger {
>>    unsigned long pool[BITS_TO_LONGS(CONFIG_IIO_CONSUMERS_PER_TRIGGER)];
>>    struct mutex            pool_lock;
>>    bool                attached_own_device;
>> +    struct iio_trigger        *parent_trigger;
>> };
>>=20
>>=20
>>=20
>=20
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/linaro-kernel
