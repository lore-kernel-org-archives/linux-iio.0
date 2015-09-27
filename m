Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:34353 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbbI0Wfc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 18:35:32 -0400
Received: by lache4 with SMTP id he4so20064624lac.1
        for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2015 15:35:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5607EF50.6020102@kernel.org>
References: <1443334737-3772-1-git-send-email-mranostay@gmail.com>
	<5607EF50.6020102@kernel.org>
Date: Sun, 27 Sep 2015 15:35:29 -0700
Message-ID: <CAKzfze_1ArXEoyRtChEABh7EZrWa4MP9UD-xKocJT3YMbpNJmQ@mail.gmail.com>
Subject: Re: [PATCH] iio: hdc100x: correct IIO_CHAN_INFO_OFFSET value
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 27, 2015 at 6:29 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 27/09/15 07:18, Matt Ranostay wrote:
>> Previous offset wasn't applied in the correct order and invalid.
>> This patchset fixes this issue, and also has the correct scale value
>> applied to the offset.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> Oops, missed that.
>
> Given it's provided in the datasheet as effectively a fractional value
> would val = -40000, val2 = 65536 and type = IIO_FRACTIONAL not be cleaner
> and give the same answer?
>
Actually not because the way the datasheet states it  ((value / 2**16)
* 165) - 40,   so the scale value needs to be applied to the -40
offset (165/65536)

> Speaking of which, for the scale are we loosing any precision by shifting
> the bottom of the fraction right 2 rather than the top left 2 which would have
> the same result?

Ah possibly. But I suspect isn't anything measurable...

>
> Jonathan
>> ---
>>  drivers/iio/humidity/hdc100x.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
>> index 2824578..a7f61e8 100644
>> --- a/drivers/iio/humidity/hdc100x.c
>> +++ b/drivers/iio/humidity/hdc100x.c
>> @@ -221,8 +221,9 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
>>               }
>>               break;
>>       case IIO_CHAN_INFO_OFFSET:
>> -             *val = -40;
>> -             return IIO_VAL_INT;
>> +             *val = -3971;
>> +             *val2 = 879096;
>> +             return IIO_VAL_INT_PLUS_MICRO;
>>       default:
>>               return -EINVAL;
>>       }
>>
>
