Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45468 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbbHBRj6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:39:58 -0400
Subject: Re: [PATCH v2 2/2] tools: iio: print error message when buffer enable
 fails
To: Hartmut Knaack <knaack.h@gmx.de>,
	Irina Tirdea <irina.tirdea@intel.com>,
	linux-iio@vger.kernel.org
References: <1437744486-16456-1-git-send-email-irina.tirdea@intel.com>
 <1437744486-16456-3-git-send-email-irina.tirdea@intel.com>
 <55B282A8.40903@gmx.de>
Cc: linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE55EC.3010206@kernel.org>
Date: Sun, 2 Aug 2015 18:39:56 +0100
MIME-Version: 1.0
In-Reply-To: <55B282A8.40903@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/07/15 19:23, Hartmut Knaack wrote:
> Irina Tirdea schrieb am 24.07.2015 um 15:28:
>> Running generic_buffer without enabling any channel of the
>> sensor will fail without printing any error message.
>>
>> Add an error message that indicates buffer enable failed.
>>
>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.

Thanks

Jonathan
>> ---
>>  tools/iio/generic_buffer.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
>> index 32f389eb..9f7b85b 100644
>> --- a/tools/iio/generic_buffer.c
>> +++ b/tools/iio/generic_buffer.c
>> @@ -364,8 +364,11 @@ int main(int argc, char **argv)
>>  
>>  	/* Enable the buffer */
>>  	ret = write_sysfs_int("enable", buf_dir_name, 1);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>> +		fprintf(stderr,
>> +			"Failed to enable buffer: %s\n", strerror(-ret));
>>  		goto error_free_buf_dir_name;
>> +	}
>>  
>>  	scan_size = size_from_channelarray(channels, num_channels);
>>  	data = malloc(scan_size * buf_len);
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

