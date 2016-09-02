Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33293 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbcIBHWU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 03:22:20 -0400
Received: by mail-pa0-f66.google.com with SMTP id vy10so5219471pac.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Sep 2016 00:22:08 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] iio: trigger: allow immutable triggers to be assigned
From: Matt Ranostay <mranostay@gmail.com>
In-Reply-To: <alpine.DEB.2.02.1609020910130.7602@pmeerw.net>
Date: Fri, 2 Sep 2016 00:22:04 -0700
Cc: linux-iio@vger.kernel.org, jic23@kernel.org,
        Matt Ranostay <matt@ranostay.consulting>
Message-Id: <6A3E511D-228A-487D-B71A-31936C365FEF@gmail.com>
References: <1472797685-12212-1-git-send-email-matt@ranostay.consulting> <alpine.DEB.2.02.1609020910130.7602@pmeerw.net>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> On Sep 2, 2016, at 00:19, Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote=
:
>=20
>=20
> nitpicking ahead
>=20
>> There are times when a trigger consumer shouldn't be allowed to change
>> triggers after intialization.
>=20
>> This is useful with use of callback buffers pushing ADC data back to the
>> trigger providers iio device.
>=20
> not clear, grammar

Gah will fix
>=20
>>=20
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> ---
>>=20
>> Changes from v1:
>> * use bool instead of int for trig_readonly property
>>=20
>> drivers/iio/industrialio-trigger.c | 20 ++++++++++++++++++++
>> include/linux/iio/iio.h            |  2 ++
>> include/linux/iio/trigger.h        |  9 +++++++++
>> 3 files changed, 31 insertions(+)
>>=20
>> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-trigger.c
>> index 7ad82fdd3e5b..a3ae3873f998 100644
>> --- a/drivers/iio/industrialio-trigger.c
>> +++ b/drivers/iio/industrialio-trigger.c
>> @@ -119,6 +119,22 @@ void iio_trigger_unregister(struct iio_trigger *trig=
_info)
>> }
>> EXPORT_SYMBOL(iio_trigger_unregister);
>>=20
>> +int iio_trigger_set_immutable(struct iio_dev *dst, struct iio_trigger *t=
rig)
>=20
> dst is not an obvious choice for the iio_dev variable, how about=20
> indio_dev?

Makes sense since there is no src field=20
>=20
>> +{
>> +    if (!dst || !trig)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&dst->mlock);
>> +    WARN_ON(dst->trig_readonly);
>> +
>> +    dst->trig =3D iio_trigger_get(trig);
>> +    dst->trig_readonly =3D true;
>> +    mutex_unlock(&dst->mlock);
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(iio_trigger_set_immutable);
>> +
>> /* Search for trigger by name, assuming iio_trigger_list_lock held */
>> static struct iio_trigger *__iio_trigger_find_by_name(const char *name)
>> {
>> @@ -384,6 +400,10 @@ static ssize_t iio_trigger_write_current(struct devi=
ce *dev,
>>        mutex_unlock(&indio_dev->mlock);
>>        return -EBUSY;
>>    }
>> +    if (indio_dev->trig_readonly) {
>> +        mutex_unlock(&indio_dev->mlock);
>> +        return -EPERM;
>> +    }
>>    mutex_unlock(&indio_dev->mlock);
>>=20
>>    trig =3D iio_trigger_find_by_name(buf, len);
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index 854e2dad1e0d..786952cd509f 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -483,6 +483,7 @@ struct iio_buffer_setup_ops {
>>  * @scan_timestamp:    [INTERN] set if any buffers have requested timesta=
mp
>>  * @scan_index_timestamp:[INTERN] cache of the index to the timestamp
>>  * @trig:        [INTERN] current device trigger (buffer modes)
>> + * @trig_readonly    [INTERN] mark the current trigger immutable
>>  * @pollfunc:        [DRIVER] function run on trigger being received
>>  * @pollfunc_event:    [DRIVER] function run on events trigger being rece=
ived
>>  * @channels:        [DRIVER] channel specification structure table
>> @@ -523,6 +524,7 @@ struct iio_dev {
>>    bool                scan_timestamp;
>>    unsigned            scan_index_timestamp;
>>    struct iio_trigger        *trig;
>> +    bool                trig_readonly;
>>    struct iio_poll_func        *pollfunc;
>>    struct iio_poll_func        *pollfunc_event;
>>=20
>> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
>> index 1c9e028e0d4a..9e22284a4122 100644
>> --- a/include/linux/iio/trigger.h
>> +++ b/include/linux/iio/trigger.h
>> @@ -132,6 +132,15 @@ int iio_trigger_register(struct iio_trigger *trig_in=
fo);
>> void iio_trigger_unregister(struct iio_trigger *trig_info);
>>=20
>> /**
>> + * iio_trigger_set_immutable() - set an immutable trigger on destination=

>> + *
>> + * @dst - destination device for trigger
>> + * @trig - trigger to assign to destination
>> + *
>> + **/
>> +int iio_trigger_set_immutable(struct iio_dev *dst, struct iio_trigger *t=
rig);
>> +
>> +/**
>>  * iio_trigger_poll() - called on a trigger occurring
>>  * @trig:    trigger which occurred
>>  *
>=20
> --=20
>=20
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)
