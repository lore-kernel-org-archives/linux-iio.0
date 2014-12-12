Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47392 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966274AbaLLLuw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 06:50:52 -0500
Message-ID: <548AD69A.4040303@kernel.org>
Date: Fri, 12 Dec 2014 11:50:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: ensure scan index is unique at buffer register
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com> <1416919687-14271-3-git-send-email-vlad.dogaru@intel.com> <548364C2.10401@gmx.de>
In-Reply-To: <548364C2.10401@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/12/14 20:19, Hartmut Knaack wrote:
> Vlad Dogaru wrote on 25.11.2014 13:48:
>> Having two or more channels with the same positive scan_index field
>> makes no sense.  Prevent this situation by failing to register a buffer
>> if two scan indexes are identical.
>>
>> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
A sensible little sanity check that might avoid a few bugs.

I'm guessing will need a rebase (along with Harmut's point)
given the buffer set from Lars I applied earlier today.

Jonathan
>> ---
>>  drivers/iio/industrialio-buffer.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index f971f79..422b29e 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -309,6 +309,30 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>>  	return ret;
>>  }
>>  
>> +static int iio_check_unique_scan_index(struct iio_dev *indio_dev,
>> +				       const struct iio_chan_spec *channels,
>> +				       int num_channels)
>> +{
>> +	int i, j;
>> +
>> +	for (i = 0; i < num_channels - 1; i++) {
>> +		if (channels[i].scan_index < 0)
>> +			continue;
>> +		for (j = i + 1; j < num_channels; j++) {
>> +			if (channels[j].scan_index < 0)
>> +				continue;
> This check up here is unnecessary, since channels[i].scan_index is already equal or
> greater zero, so the check below results in a false for channels[j].scan_index smaller
> than zero and cause a new loop iteration anyway.
> 
>> +			if (channels[i].scan_index == channels[j].scan_index) {
>> +				dev_err(&indio_dev->dev,
>> +					"duplicate scan index %d\n",
>> +					channels[i].scan_index);
>> +				return -EINVAL;
>> +			}
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static const char * const iio_scan_elements_group_name = "scan_elements";
>>  
>>  int iio_buffer_register(struct iio_dev *indio_dev,
>> @@ -320,6 +344,10 @@ int iio_buffer_register(struct iio_dev *indio_dev,
>>  	struct iio_buffer *buffer = indio_dev->buffer;
>>  	int ret, i, attrn, attrcount, attrcount_orig = 0;
>>  
>> +	ret = iio_check_unique_scan_index(indio_dev, channels, num_channels);
>> +	if (ret < 0)
>> +		return ret;
>> +
>>  	if (buffer->attrs)
>>  		indio_dev->groups[indio_dev->groupcounter++] = buffer->attrs;
>>  
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

