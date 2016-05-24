Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34992 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbcEXGxY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 May 2016 02:53:24 -0400
Received: by mail-lf0-f66.google.com with SMTP id p10so504225lfb.2
        for <linux-iio@vger.kernel.org>; Mon, 23 May 2016 23:53:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6ad02a26-6649-7987-df7c-80d5244d5a0d@kernel.org>
References: <1463709181-17528-1-git-send-email-mranostay@gmail.com>
 <1463709181-17528-3-git-send-email-mranostay@gmail.com> <6ad02a26-6649-7987-df7c-80d5244d5a0d@kernel.org>
From: Matt Ranostay <mranostay@gmail.com>
Date: Mon, 23 May 2016 23:52:42 -0700
Message-ID: <CAKzfze80ghtbkH8FBu4G-PxgFKdCMKeYFhC3_bkX1NQXGzRDHA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: electricalconductivity: add
 IIO_ELECTRICALCONDUCTIVITY type
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, May 22, 2016 at 12:47 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 20/05/16 02:53, Matt Ranostay wrote:
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>>  drivers/iio/industrialio-core.c         | 1 +
>>  include/uapi/linux/iio/types.h          | 1 +
>>  3 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index df44998..adfdf95 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -1565,3 +1565,10 @@ Description:
>>               * X is in the plane of the propellers, perpendicular to Y axis,
>>                 and positive towards the starboard side of the UAV ;
>>               * Z is perpendicular to propellers plane and positive upwards.
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/in_electricalconductivity_raw
>> +KernelVersion:       4.8
>> +Contact:     linux-iio@vger.kernel.org
>> +Description:
>> +             Raw (unscaled no offset etc.) electric conductivity reading that
>> +             maps to microsiemens per centimeter.
> Rather than seimens per m?  Seems like the units are a mess when measuring this and
> we do in theory aim for the basic SI units where possible...
>

Yeah seems most meters output this when they mean EC to be
microsiemens per cm....
I have no issue making this a siemens per meter and update the scaling
in the other patchset.

Thoughts?


> Otherwise, this looks fine to me.
>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index e6319a9..2a85bd8 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -80,6 +80,7 @@ static const char * const iio_chan_type_name_spec[] = {
>>       [IIO_RESISTANCE] = "resistance",
>>       [IIO_PH] = "ph",
>>       [IIO_UVINDEX] = "uvindex",
>> +     [IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
>>  };
>>
>>  static const char * const iio_modifier_names[] = {
>> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
>> index b0916fc..22e5e58 100644
>> --- a/include/uapi/linux/iio/types.h
>> +++ b/include/uapi/linux/iio/types.h
>> @@ -39,6 +39,7 @@ enum iio_chan_type {
>>       IIO_RESISTANCE,
>>       IIO_PH,
>>       IIO_UVINDEX,
>> +     IIO_ELECTRICALCONDUCTIVITY,
>>  };
>>
>>  enum iio_modifier {
>>
>
