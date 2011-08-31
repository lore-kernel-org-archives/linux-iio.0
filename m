Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E5E2297.1040207@cam.ac.uk>
Date: Wed, 31 Aug 2011 13:01:27 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 09/12] iio: core: fix IIO_EVENT_CODE_EXTRACT_DIR definition
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com> <1314788260-5791-9-git-send-email-michael.hennerich@analog.com> <4E5E17EA.40907@cam.ac.uk>
In-Reply-To: <4E5E17EA.40907@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/31/11 12:15, Jonathan Cameron wrote:
> On 08/31/11 11:57, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>>
> Gah and good spot. I'll merge that one down into the patch that introduced it
> with appropriate comment.
On closer inspection you are right that there is an issue here, but
it's not quite what you've fixed.

diff should be 1 bit, and direction 7.  Right now, diff is 7 and direction 1.

fix is something like IIO_EVENT_CODE(chan_type, diff, modifier, direction,		\
 		       type, chan, chan1, chan2)			\
-	(((u64)type << 56) | ((u64)direction << 48) | ((u64)modifier << 40) | \
+	(((u64)type << 56) | ((u64)diff << 55) |			\
+	 ((u64)direction << 48) | ((u64)modifier << 40) |		\
 	 ((u64)chan_type << 32) | (chan2 << 16) | chan1 | chan)

Will merge into the original patch and repost that in a mo.


Thanks,

Jonathan

>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>  drivers/staging/iio/sysfs.h |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
>> index d98d12d..8de6a65 100644
>> --- a/drivers/staging/iio/sysfs.h
>> +++ b/drivers/staging/iio/sysfs.h
>> @@ -146,7 +146,7 @@ enum iio_event_direction {
>>  	IIO_EVENT_CODE(channelclass, 0, 0, direction, type, number, 0, 0)
>>  
>>  #define IIO_EVENT_CODE_EXTRACT_TYPE(mask) ((mask >> 56) & 0xFF)
>> -#define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 48) & 0xFF)
>> +#define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 47) & 0xFF)
>>  #define IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(mask) ((mask >> 32) & 0xFF)
>>  
>>  /* Event code number extraction depends on which type of event we have.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
