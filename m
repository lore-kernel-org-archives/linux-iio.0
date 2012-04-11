Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:44918 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab2DKJCz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 05:02:55 -0400
Message-ID: <4F8548B8.8000709@cam.ac.uk>
Date: Wed, 11 Apr 2012 10:02:48 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	michael.hennerich@analog.com
Subject: Re: [PATCH 01/10] staging:iio: add a value element to the info_mask
References: <1334089663-22900-1-git-send-email-jic23@kernel.org> <1334089663-22900-2-git-send-email-jic23@kernel.org> <4F854295.4030009@metafoo.de>
In-Reply-To: <4F854295.4030009@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/11/2012 9:36 AM, Lars-Peter Clausen wrote:
> On 04/10/2012 10:27 PM, Jonathan Cameron wrote:
>> This will allow us to have drivers where the channel value
>> may not be read or written but other information is available.
>>
>> Signed-off-by: Jonathan Cameron<jic23@kernel.org>
>> ---
>>   drivers/staging/iio/iio.h               |    4 +++-
>>   drivers/staging/iio/industrialio-core.c |    5 +++--
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
>> index fa6fca0..d96ee4b 100644
>> --- a/drivers/staging/iio/iio.h
>> +++ b/drivers/staging/iio/iio.h
>> @@ -26,7 +26,7 @@ enum iio_data_type {
>>
>>   /* Could add the raw attributes as well - allowing buffer only devices */
>>   enum iio_chan_info_enum {
>> -	/* 0 is reserved for raw attributes */
>> +	IIO_CHAN_INFO_VALUE = 0,
> I think it would make sense to introduce both IIO_CHAN_INFO_RAW and
> IIO_CHAN_INFO_PROCESSED. This will certainly make the code more simpler and
> it also allows drivers to export both processed and raw values.
Good point.  I thought abouting using the two bits for the single entry 
for this, but you
are right, simply having a separate entry would be cleaner and only 
waste a couple
of bits of the mask... which we were wasting before anyway and allows us 
to drop the
separate flags for it.  I'll rework the set with that... your naming 
suggestion works as well.
>
>>   	IIO_CHAN_INFO_SCALE = 1,
>>   	IIO_CHAN_INFO_OFFSET,
>>   	IIO_CHAN_INFO_CALIBSCALE,
>> @@ -41,6 +41,8 @@ enum iio_chan_info_enum {
>>   #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
>>   #define IIO_CHAN_INFO_SEPARATE_BIT(type) BIT(type*2 + 1)
>>
>> +#define IIO_CHAN_INFO_VALUE_SEPARATE_BIT			\
>> +	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_VALUE)
>>   #define IIO_CHAN_INFO_SCALE_SEPARATE_BIT		\
>>   	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_SCALE)
>>   #define IIO_CHAN_INFO_SCALE_SHARED_BIT			\
>> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
>> index d303bfb..a4ac061 100644
>> --- a/drivers/staging/iio/industrialio-core.c
>> +++ b/drivers/staging/iio/industrialio-core.c
>> @@ -575,7 +575,8 @@ error_ret:
>>   static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>>   					struct iio_chan_spec const *chan)
>>   {
>> -	int ret, i, attrcount = 0;
>> +	int ret, attrcount = 0;
>> +	int i = 2;
>>   	const struct iio_chan_spec_ext_info *ext_info;
>>
>>   	if (chan->channel<  0)
>> @@ -594,7 +595,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>>   		goto error_ret;
>>   	attrcount++;
>>
>> -	for_each_set_bit(i,&chan->info_mask, sizeof(long)*8) {
>> +	for_each_set_bit_from(i,&chan->info_mask, sizeof(long)*8) {
>>   		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i/2],
>>   					     chan,
>>   					&iio_read_channel_info,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

