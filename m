Return-Path: <k.wrona@samsung.com>
Message-id: <553A2499.30501@samsung.com>
Date: Fri, 24 Apr 2015 13:10:17 +0200
From: Karol Wrona <k.wrona@samsung.com>
MIME-version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Karol Wrona <wrona.vy@gmail.com>
Subject: Re: [PATCH] iio: common: ssp_sensors: Fix uninitialized warning for
 timestamp
References: <1429176624-19223-1-git-send-email-k.wrona@samsung.com>
 <5532AA55.3040609@kernel.org>
In-reply-to: <5532AA55.3040609@kernel.org>
Content-type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 04/18/2015 09:02 PM, Jonathan Cameron wrote:
> On 16/04/15 10:30, Karol Wrona wrote:
>> calculated_time variable caused warning as uninitialized.  It was not harmful
>> because it was evaluated in the path in which was used later but it is to
>> satisfy the checkers.
>>
>> Signed-off-by: Karol Wrona <k.wrona@samsung.com>
> Dumb compiler. It's a false positive and as the function is an inline in the header,
> it should be able to tell. 
> 
> What compiler is spitting out the warning?


You should have krobot complain in the mail.
Subject: "include/linux/iio/buffer.h:142:32: warning: 'calculated_time'
may be used uninitialized in this function"

This was sh compiler. I suppose that we can treat it as false warning.
It will complain whenever the variable will stay uninitialized even if
not used in such path.


> 
>> ---
>>  drivers/iio/common/ssp_sensors/ssp_iio.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
>> index a3ae165..16180e6 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
>> +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
>> @@ -80,7 +80,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
>>  			    unsigned int len, int64_t timestamp)
>>  {
>>  	__le32 time;
>> -	int64_t calculated_time;
>> +	int64_t calculated_time = 0;
>>  	struct ssp_sensor_data *spd = iio_priv(indio_dev);
>>  
>>  	if (indio_dev->scan_bytes == 0)
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
