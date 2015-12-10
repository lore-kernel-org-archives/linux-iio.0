Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35096 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbbLJVC7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2015 16:02:59 -0500
Received: by lfdl133 with SMTP id l133so65205089lfd.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2015 13:02:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1512101139110.9644@pmeerw.net>
References: <1449735048-16668-1-git-send-email-mranostay@gmail.com>
 <1449735048-16668-3-git-send-email-mranostay@gmail.com> <alpine.DEB.2.02.1512101139110.9644@pmeerw.net>
From: Matt Ranostay <mranostay@gmail.com>
Date: Thu, 10 Dec 2015 13:02:18 -0800
Message-ID: <CAKzfze8sXQH6Qf6VxOZyOSbG61PxYcWvWdkJuBiubss1mXzrCA@mail.gmail.com>
Subject: Re: [RFC v1 2/3] iio: ph: add IIO_PH channel type
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Dec 10, 2015 at 2:40 AM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 6 ++++++
>>  drivers/iio/industrialio-core.c         | 1 +
>>  include/uapi/linux/iio/types.h          | 1 +
>>  3 files changed, 8 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 0439c2a..b15314e 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -1491,3 +1491,9 @@ Description:
>>               This ABI is especially applicable for humidity sensors
>>               to heatup the device and get rid of any condensation
>>               in some humidity environment
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/in_ph_raw
>> +KernelVersion:       4.5
>> +Contact:     linux-iio@vger.kernel.org
>> +Description:
>> +             Raw (unscaled no offset etc.) pH reading of a substance.
>
> what is the unit (after application of offset and scale?
> or otherwise state that this is unit-less

It will be floating point 0.0 to 14.0 with the pH level.  Which is the
log scale of hydronium (per litre) in a solution.

>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index d42a8ff9..e1b9a9e 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -77,6 +77,7 @@ static const char * const iio_chan_type_name_spec[] = {
>>       [IIO_VELOCITY] = "velocity",
>>       [IIO_CONCENTRATION] = "concentration",
>>       [IIO_RESISTANCE] = "resistance",
>> +     [IIO_PH] = "ph",
>>  };
>>
>>  static const char * const iio_modifier_names[] = {
>> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
>> index 7c63bd6..c077617 100644
>> --- a/include/uapi/linux/iio/types.h
>> +++ b/include/uapi/linux/iio/types.h
>> @@ -37,6 +37,7 @@ enum iio_chan_type {
>>       IIO_VELOCITY,
>>       IIO_CONCENTRATION,
>>       IIO_RESISTANCE,
>> +     IIO_PH,
>>  };
>>
>>  enum iio_modifier {
>>
>
> --
>
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)
