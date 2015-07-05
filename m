Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58923 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658AbbGEL16 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 07:27:58 -0400
Message-ID: <559914BD.5070808@kernel.org>
Date: Sun, 05 Jul 2015 12:27:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] tools: iio: Add single-byte case for generic_buffer
References: <1435917456-2973-1-git-send-email-tiberiu.a.breana@intel.com> <5597E1F1.8070400@gmx.de>
In-Reply-To: <5597E1F1.8070400@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/07/15 14:38, Hartmut Knaack wrote:
> Tiberiu Breana schrieb am 03.07.2015 um 11:57:
>> Some sensors export data in an 8-bit format.
>> Add a single-byte case for the generic_buffer tool so that
>> these sensors' buffer data can be visualized.
>>
>> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
>> ---
>> v2: added the print1byte function to apply the channel shift and
>> address both signed and unsigned cases.
>> ---
>>  tools/iio/generic_buffer.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
>> index fc362d2..0e73723 100644
>> --- a/tools/iio/generic_buffer.c
>> +++ b/tools/iio/generic_buffer.c
>> @@ -61,6 +61,23 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
>>  	return bytes;
>>  }
>>  
>> +void print1byte(uint8_t input, struct iio_channel_info *info)
>> +{
>> +	/*
>> +	 * Shift before conversion to avoid sign extension
>> +	 * of left aligned data
>> +	 */
>> +	input >>= info->shift;
>> +	input &= info->mask;
>> +	if (info->is_signed) {
>> +		int8_t val = (int8_t)(input << (8 - info->bits_used)) >>
>> +			     (8 - info->bits_used);
>> +		printf("%05f ", ((float)val + info->offset) * info->scale);
>> +	} else {
>> +		printf("%05f ", ((float)input + info->offset) * info->scale);
>> +	}
>> +}
>> +
>>  void print2byte(uint16_t input, struct iio_channel_info *info)
>>  {
>>  	/* First swap if incorrect endian */
>> @@ -152,6 +169,10 @@ void process_scan(char *data,
>>  	for (k = 0; k < num_channels; k++)
>>  		switch (channels[k].bytes) {
>>  			/* only a few cases implemented so far */
> 
> Not sure though how long we should keep that comment. ^^^^^
> I probably had more reason to get rid of it during my rework.
> 
>> +		case 1:
>> +			print1byte(*(uint8_t *)(data + channels[k].location),
>> +				   &channels[k]);
>> +			break;
>>  		case 2:
>>  			print2byte(*(uint16_t *)(data + channels[k].location),
>>  				   &channels[k]);
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

