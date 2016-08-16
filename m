Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35246 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbcHPDLw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 23:11:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so14086348wmg.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Aug 2016 20:11:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8067f895-6ab3-9c40-f127-bc74da295f97@kernel.org>
References: <1470798359-4919-1-git-send-email-mranostay@gmail.com>
 <1470798359-4919-2-git-send-email-mranostay@gmail.com> <8067f895-6ab3-9c40-f127-bc74da295f97@kernel.org>
From: Matt Ranostay <mranostay@gmail.com>
Date: Mon, 15 Aug 2016 20:11:10 -0700
Message-ID: <CAKzfze-69WP9Y=iUkzyjD6i8Vbdvs74M=9EVFoqL3-V43w-gCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: chemical: atlas-ph-sensor: switch to
 iio_device_*_direct_mode helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 15, 2016 at 8:14 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 10/08/16 04:05, Matt Ranostay wrote:
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>  drivers/iio/chemical/atlas-ph-sensor.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
>> index ae038a59d256..8e39b37a5385 100644
>> --- a/drivers/iio/chemical/atlas-ph-sensor.c
>> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
>> @@ -402,7 +402,9 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
>>               case IIO_PH:
>>               case IIO_CONCENTRATION:
>>               case IIO_ELECTRICALCONDUCTIVITY:
>> -                     mutex_lock(&indio_dev->mlock);
>> +                     ret = iio_device_claim_direct_mode(indio_dev);
>> +                     if (ret)
>> +                             return ret;
>>
>>                       if (iio_buffer_enabled(indio_dev))
>>                               ret = -EBUSY;
> The claim_direct_mode helpers also perform this check...

Gah should have noticed this...

Will fix in v2!

>
>
>> @@ -410,7 +412,7 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
>>                               ret = atlas_read_measurement(data,
>>                                                       chan->address, &reg);
>>
>> -                     mutex_unlock(&indio_dev->mlock);
>> +                     iio_device_release_direct_mode(indio_dev);
>>                       break;
>>               default:
>>                       ret = -EINVAL;
>>
>
