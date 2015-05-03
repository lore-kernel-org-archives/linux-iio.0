Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39950 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbECTDU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2015 15:03:20 -0400
Message-ID: <554670F3.5080704@kernel.org>
Date: Sun, 03 May 2015 20:03:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: Re: [PATCH] staging:iio:light: Add some missing brackets to make
 sure code works as intended. Note this is not a bug due to the fact the region
 cannot be reached without the sanity check passing. The autobuilder reported
 it as missaligned code which is kind of true as well.
References: <1430564705-31119-1-git-send-email-jic23@kernel.org> <CAEnQRZAHSqssqmqSWSm4NYB5854um28MjsFPoBC5DkrJRySVzA@mail.gmail.com>
In-Reply-To: <CAEnQRZAHSqssqmqSWSm4NYB5854um28MjsFPoBC5DkrJRySVzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/15 19:54, Daniel Baluta wrote:
> This looks good to me. Anyhow, we need a newline somewhere in the
> commit subject.
Yeah, I messed that up.  Anyhow, applied with an appropriate new line
to the togreg branch of iio.git.

Thanks,

J
> 
> On Sat, May 2, 2015 at 2:05 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> Cc: Roberta Dobrescu <roberta.dobrescu@gmail.com>
>> ---
>>  drivers/staging/iio/light/isl29018.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
>> index 08ca9a4172e3..e646c5d24004 100644
>> --- a/drivers/staging/iio/light/isl29018.c
>> +++ b/drivers/staging/iio/light/isl29018.c
>> @@ -369,12 +369,13 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
>>                 }
>>                 break;
>>         case IIO_CHAN_INFO_INT_TIME:
>> -               if (chan->type == IIO_LIGHT)
>> +               if (chan->type == IIO_LIGHT) {
>>                         if (val != 0) {
>>                                 mutex_unlock(&chip->lock);
>>                                 return -EINVAL;
>>                         }
>>                         ret = isl29018_set_integration_time(chip, val2);
>> +               }
>>                 break;
>>         case IIO_CHAN_INFO_SCALE:
>>                 if (chan->type == IIO_LIGHT)
>> --
>> 2.3.5
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

