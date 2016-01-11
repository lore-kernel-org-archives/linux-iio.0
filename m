Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50427 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933689AbcAKTP7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2016 14:15:59 -0500
Subject: Re: [PATCH] iio: light: acpi-als: Report data as processed rather
 than raw
To: Crt Mori <cmo@melexis.com>
References: <1452180105-9584-1-git-send-email-gabriele.mzt@gmail.com>
 <569135DC.2090400@kernel.org>
 <CAKv63uujuDJDLK1Z6=UZUSRAhdUUeF_jJF92_iFyqOG_okGRzQ@mail.gmail.com>
Cc: Gabriele Mazzotta <gabriele.mzt@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, marex@denx.de,
	marxin.liska@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5693FF6B.9060200@kernel.org>
Date: Mon, 11 Jan 2016 19:15:55 +0000
MIME-Version: 1.0
In-Reply-To: <CAKv63uujuDJDLK1Z6=UZUSRAhdUUeF_jJF92_iFyqOG_okGRzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/16 10:16, Crt Mori wrote:
> On 9 January 2016 at 17:31, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 07/01/16 15:21, Gabriele Mazzotta wrote:
>>> As per the ACPI specification (Revision 5.0) [1], the data coming
>>> from the sensor represent the ambient light illuminance reading
>>> expressed in lux. Use IIO_CHAN_INFO_PROCESSED instead of
>>> IIO_CHAN_INFO_RAW to signify that the data are pre-processed.
>>>
>>> [1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf
>>>
>>> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
>> Hm. Whilst it's a fix in a sense, the original didn't really 'break'
>> the ABI so I worry a little that this change may break others.
>> Irritating as it is, perhaps we should keep the _RAW and add _PROCESSED
>> (which will then be exactly the same value).
>> We'll also then need a comment in the code, that leaving the _RAW
>> elements was for ABI compatibility.
>>
>> What do others think?
> For this case I agree to keep both for backwards ABI compatibility,
> but then other drivers returning the data in basic units, should be
> changed from raw to processed? I do not think this was the case
> before?
It's always been the case that devices that happen to output in the
right units (or do so after a non linear transform as tends to happen
with a lot of light sensors) should mark themselves as processed
to indicate that nothing else needs be done to convert to standard
units.

Sensor hubs in particular often do the unit conversion stuff on
a separate processor, though often their chosen 'base' units differ
from ours (not always though!)

Jonathan
> 
> Crt
> 
>>
>> Jonathan
>>> ---
>>>  drivers/iio/light/acpi-als.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
>>> index 60537ec..a53be07 100644
>>> --- a/drivers/iio/light/acpi-als.c
>>> +++ b/drivers/iio/light/acpi-als.c
>>> @@ -54,7 +54,7 @@ static const struct iio_chan_spec acpi_als_channels[] = {
>>>                       .realbits       = 32,
>>>                       .storagebits    = 32,
>>>               },
>>> -             .info_mask_separate     = BIT(IIO_CHAN_INFO_RAW),
>>> +             .info_mask_separate     = BIT(IIO_CHAN_INFO_PROCESSED),
>>>       },
>>>  };
>>>
>>> @@ -152,7 +152,7 @@ static int acpi_als_read_raw(struct iio_dev *indio_dev,
>>>       s32 temp_val;
>>>       int ret;
>>>
>>> -     if (mask != IIO_CHAN_INFO_RAW)
>>> +     if (mask != IIO_CHAN_INFO_PROCESSED)
>>>               return -EINVAL;
>>>
>>>       /* we support only illumination (_ALI) so far. */
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

