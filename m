Return-Path: <manuel.stahl9cd33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4E48CD76.3010909@iis.fraunhofer.de>
Date: Mon, 15 Aug 2011 09:40:38 +0200
From: ManuelStahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, michael.hennerich@analog.com
Subject: Re: [PATCH] staging:iio:scan element types: introduce endian description
 to the data format.
References: <1311960504-4268-1-git-send-email-jic23@cam.ac.uk> <4E45538A.5090104@cam.ac.uk>
In-Reply-To: <4E45538A.5090104@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

I'm not sure if we need the IIO_CPU, but as long as we only have BE and 
LE in the sysfs API it's fine for me.

Regards,
Manuel

Am 12.08.2011 18:23, schrieb Jonathan Cameron:
> On 07/29/11 18:28, Jonathan Cameron wrote:
>> If not set in chan_spec, cpu endianness used.
>>
>> Signed-off-by: Jonathan Cameron<jic23@cam.ac.uk>
>> ---
>> Result of discussion in [PATCH 0/2] blue part 6: IIO abi rework.
>> Michael highlighted that we need to specify the endianness of buffer
>> contents.  This patch does that.  The IIO_CPU option exists so that
>> existing drivers which do conversion to cpu endian should work
>> without change.
>>
>> Based on all sorts of fun I haven't pushed, so if you really want to
>> play with this see the iio-blue.git tree.
> Michael, Manuel
>
> Is this patch fine with you two?
>
> Thanks,
>
> Jonathan
>> Jonathan
>>
>>   drivers/staging/iio/iio.h               |    8 ++++++++
>>   drivers/staging/iio/industrialio-ring.c |   15 ++++++++++++++-
>>   2 files changed, 22 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
>> index bde8b87..d09f84b 100644
>> --- a/drivers/staging/iio/iio.h
>> +++ b/drivers/staging/iio/iio.h
>> @@ -86,6 +86,12 @@ enum iio_chan_info_enum {
>>   	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE,
>>   };
>>
>> +enum iio_endian {
>> +	IIO_CPU,
>> +	IIO_BE,
>> +	IIO_LE,
>> +};
>> +
>>   /**
>>    * struct iio_chan_spec - specification of a single channel
>>    * @type:		What type of measurement is the channel making.
>> @@ -101,6 +107,7 @@ enum iio_chan_info_enum {
>>    *			storage_bits:	Realbits + padding
>>    *			shift:		Shift right by this before masking out
>>    *					realbits.
>> + *			endianness:	little or big endian	
>>    * @info_mask:		What information is to be exported about this channel.
>>    *			This includes calibbias, scale etc.
>>    * @event_mask:	What events can this channel produce.
>> @@ -129,6 +136,7 @@ struct iio_chan_spec {
>>   		u8	realbits;
>>   		u8	storagebits;
>>   		u8	shift;
>> +	       	enum iio_endian endianness;
>>   	} scan_type;
>>   	const long		info_mask;
>>   	const long		event_mask;
>> diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
>> index 5edc6d8..aa1748b 100644
>> --- a/drivers/staging/iio/industrialio-ring.c
>> +++ b/drivers/staging/iio/industrialio-ring.c
>> @@ -24,6 +24,10 @@
>>   #include "iio_core.h"
>>   #include "ring_generic.h"
>>
>> +const static char *iio_endian_prefix[] = {
>> +	[IIO_BE] = "be",
>> +	[IIO_LE] = "le",
>> +};
>>
>>   /**
>>    * iio_ring_read_first_n_outer() - chrdev read for ring buffer access
>> @@ -95,7 +99,16 @@ static ssize_t iio_show_fixed_type(struct device *dev,
>>   				   char *buf)
>>   {
>>   	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> -	return sprintf(buf, "%c%d/%d>>%u\n",
>> +	u8 type = this_attr->c->scan_type.endianness;
>> +
>> +	if (type == IIO_CPU) {
>> +		if (__LITTLE_ENDIAN)
>> +			type = IIO_LE;
>> +		else
>> +			type = IIO_BE;
>> +	}
>> +	return sprintf(buf, "%s:%c%d/%d>>%u\n",
>> +		       iio_endian_prefix[type],
>>   		       this_attr->c->scan_type.sign,
>>   		       this_attr->c->scan_type.realbits,
>>   		       this_attr->c->scan_type.storagebits,
