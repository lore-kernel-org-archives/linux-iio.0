Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55875 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbbGWTqs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 15:46:48 -0400
Subject: Re: [PATCH] tools: iio: make scale and offset files optional
To: Hartmut Knaack <knaack.h@gmx.de>, Joo Aun Saw <jasaw@dius.com.au>,
	linux-iio@vger.kernel.org
References: <1437620027-24635-1-git-send-email-jasaw@dius.com.au>
 <55B1406B.70005@gmx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55B144A6.8010309@kernel.org>
Date: Thu, 23 Jul 2015 20:46:46 +0100
MIME-Version: 1.0
In-Reply-To: <55B1406B.70005@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/07/15 20:28, Hartmut Knaack wrote:
> Joo Aun Saw schrieb am 23.07.2015 um 04:53:
>> From: Joo Aun Saw <jasaw@dius.com.au>
>>
>> Make scale and offset optional by adding -ENOENT check as not all
>> drivers implement them.
>>
>> Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Thanks.  Applied to the togreg branch of iio.git - initially
pushed out as testing (in this case to be completely ignored
- I think - but there we are ;)

Jonathan
>> ---
>>  tools/iio/iio_utils.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
>> index c3f9e37..1dcdf03 100644
>> --- a/tools/iio/iio_utils.c
>> +++ b/tools/iio/iio_utils.c
>> @@ -487,7 +487,7 @@ int build_channel_array(const char *device_dir,
>>  						       device_dir,
>>  						       current->name,
>>  						       current->generic_name);
>> -			if (ret < 0)
>> +			if ((ret < 0) && (ret != -ENOENT))
>>  				goto error_cleanup_array;
>>  
>>  			ret = iioutils_get_param_float(&current->offset,
>> @@ -495,7 +495,7 @@ int build_channel_array(const char *device_dir,
>>  						       device_dir,
>>  						       current->name,
>>  						       current->generic_name);
>> -			if (ret < 0)
>> +			if ((ret < 0) && (ret != -ENOENT))
>>  				goto error_cleanup_array;
>>  
>>  			ret = iioutils_get_type(&current->is_signed,
>>
> 

