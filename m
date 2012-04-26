Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:53113 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562Ab2DZNsv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Apr 2012 09:48:51 -0400
Message-ID: <4F995235.6050607@free-electrons.com>
Date: Thu, 26 Apr 2012 15:48:37 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] IIO: Add frequency sysfs files to triggers
References: <1334851538-21408-1-git-send-email-maxime.ripard@free-electrons.com> <1334851538-21408-2-git-send-email-maxime.ripard@free-electrons.com> <4F966223.3020904@kernel.org>
In-Reply-To: <4F966223.3020904@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Le 24/04/2012 10:19, Jonathan Cameron a =E9crit :
> On 4/19/2012 5:05 PM, Maxime Ripard wrote:
>> This allows to easily set the frequency for hardware triggers suppor=
ting
>> it.
> Other than the missing docs for the new callback this is fine.

You're right, I will add it and send a new patch.

> I've highlighted some future issues inline but we can tackle them lat=
er.
>=20
> Ultimately from a maintenance point of view I'd like these to look mo=
re
> similar
> to the ones we have in the core (read_raw and write_raw). Those are f=
ar
> more
> flexible than we currently need here but that may change.

You mean with the various units multipliers ?

> I'm happy to have this as a stop gap

Great :)

>>
>> Signed-off-by: Maxime Ripard<maxime.ripard@free-electrons.com>
>> ---
>>   drivers/staging/iio/industrialio-trigger.c |   65
>> ++++++++++++++++++++++++++-
>>   drivers/staging/iio/trigger.h              |    9 ++++
>>   2 files changed, 71 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/industrialio-trigger.c
>> b/drivers/staging/iio/industrialio-trigger.c
>> index 47ecadd..457ab15 100644
>> --- a/drivers/staging/iio/industrialio-trigger.c
>> +++ b/drivers/staging/iio/industrialio-trigger.c
>> @@ -51,6 +51,42 @@ static ssize_t iio_trigger_read_name(struct devic=
e
>> *dev,
>>
>>   static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
>>
>> +static ssize_t iio_trigger_read_frequency(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      char *buf)
>> +{
>> +    struct iio_trigger *trig =3D dev_get_drvdata(dev);
>> +    return sprintf(buf, "%lu\n", trig->frequency);
> Strong assumption of integer value here.  I'd not be suprised if we g=
et
> fractional values on a few devices over time.  Maybe that's something=
 to
> fix when we do though!

Yeah, I was thinking at first to use Hz here, and that should only impl=
y
having integers because of the difference of scale, but maybe floats
would be nice too. I wonder if someone ever needs to do conversions at
such a low frequency, but I guess that a conversion every 2 seconds
doesn't look too unfamiliar for example.

>> +}
>> +
>> +static ssize_t iio_trigger_write_frequency(struct device *dev,
>> +                       struct device_attribute *attr,
>> +                       const char *buf,
>> +                       size_t len)
>> +{
>> +    struct iio_trigger *trig =3D dev_get_drvdata(dev);
>> +    unsigned long val;
>> +    int ret;
>> +
>> +    ret =3D kstrtoul(buf, 10,&val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    trig->frequency =3D val;
>> +
>> +    if (trig->ops->update_infos) {
>> +        ret =3D trig->ops->update_infos(trig, IIO_TRIGGER_INFO_FREQ=
UENCY);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    return len;
>> +}
>> +
>> +static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR,
>> +           iio_trigger_read_frequency,
>> +           iio_trigger_write_frequency);
>> +
>>   /**
>>    * iio_trigger_register_sysfs() - create a device for this trigger
>>    * @trig_info:    the trigger
>> @@ -59,9 +95,29 @@ static DEVICE_ATTR(name, S_IRUGO,
>> iio_trigger_read_name, NULL);
>>    **/
>>   static int iio_trigger_register_sysfs(struct iio_trigger *trig_inf=
o)
>>   {
> Doesn't change the fundamental path here, so fine.  Note however, tha=
t at
> somepoint we should ensure these are registered with the device so th=
at we
> are sure udev will get notification of their creation...
>> -    return sysfs_add_file_to_group(&trig_info->dev.kobj,
>> -                &dev_attr_name.attr,
>> -                       NULL);
>> +    int ret;
>> +    ret =3D sysfs_add_file_to_group(&trig_info->dev.kobj,
>> +                &dev_attr_name.attr,
>> +                      NULL);
>> +    if (ret)
>> +        goto name_error;
>> +
>> +    if (trig_info->info_mask&  IIO_TRIGGER_INFO_FREQUENCY) {
>> +        ret =3D sysfs_add_file_to_group(&trig_info->dev.kobj,
>> +                    &dev_attr_frequency.attr,
>> +                          NULL);
>> +        if (ret)
>> +            goto frequency_error;
>> +    }
>> +
>> +    return 0;
>> +
>> +frequency_error:
>> +    sysfs_remove_file_from_group(&trig_info->dev.kobj,
>> +                &dev_attr_name.attr,
>> +                     NULL);
>> +name_error:
>> +    return ret;
>>   }
>>
>>   static void iio_trigger_unregister_sysfs(struct iio_trigger *trig_=
info)
>> @@ -69,6 +125,9 @@ static void iio_trigger_unregister_sysfs(struct
>> iio_trigger *trig_info)
>>       sysfs_remove_file_from_group(&trig_info->dev.kobj,
>>                       &dev_attr_name.attr,
>>                          NULL);
>> +    sysfs_remove_file_from_group(&trig_info->dev.kobj,
>> +                    &dev_attr_frequency.attr,
>> +                       NULL);
>>   }
>>
>>   int iio_trigger_register(struct iio_trigger *trig_info)
>> diff --git a/drivers/staging/iio/trigger.h
>> b/drivers/staging/iio/trigger.h
>> index 1cfca23..a258ef8 100644
>> --- a/drivers/staging/iio/trigger.h
>> +++ b/drivers/staging/iio/trigger.h
>> @@ -16,6 +16,8 @@ struct iio_subirq {
>>       bool enabled;
>>   };
>>  =20
> Slight preference for BIT(0)
ACK.
>> +#define IIO_TRIGGER_INFO_FREQUENCY    (1<<  0)
>> +
>>   /**
>>    * struct iio_trigger_ops - operations structure for an iio_trigge=
r.
>>    * @owner:        used to monitor usage count of the trigger.
> Document the new callback please!
Yes, will do :)
>> @@ -32,6 +34,8 @@ struct iio_trigger_ops {
>>       struct module            *owner;
>>       int (*set_trigger_state)(struct iio_trigger *trig, bool state)=
;
>>       int (*try_reenable)(struct iio_trigger *trig);
>> +    int (*update_infos)(struct iio_trigger *trig,
>> +                const unsigned long info_mask);
>>       int (*validate_device)(struct iio_trigger *trig,
>>                      struct iio_dev *indio_dev);
>>   };
>> @@ -52,6 +56,9 @@ struct iio_trigger_ops {
>>    * @subirqs:        [INTERN] information about the 'child' irqs.
>>    * @pool:        [INTERN] bitmap of irqs currently in use.
>>    * @pool_lock:        [INTERN] protection of the irq pool.
>> + * @frequency:        [DRIVER] frequency of the trigger in Hz.
>> + * @info_mask:        [DRIVER] What informations are to be exported
>> in the
>> + *            sysfs directory: frequency, etc....
>>    **/
>>   struct iio_trigger {
>>       const struct iio_trigger_ops    *ops;
>> @@ -70,6 +77,8 @@ struct iio_trigger {
>>       struct iio_subirq subirqs[CONFIG_IIO_CONSUMERS_PER_TRIGGER];
>>       unsigned long
>> pool[BITS_TO_LONGS(CONFIG_IIO_CONSUMERS_PER_TRIGGER)];
>>       struct mutex            pool_lock;
>> +    unsigned long            frequency;
>> +    long                info_mask;
>>   };
>>
>>
>=20


--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
