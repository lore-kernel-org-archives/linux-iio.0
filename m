Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:41896 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbaGTQuu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jul 2014 12:50:50 -0400
Message-ID: <53CBF3F6.2060601@kernel.org>
Date: Sun, 20 Jul 2014 17:53:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio:kxcjk-1013: Fix endianness in scan_type
References: <1405370318-19699-1-git-send-email-pmeerw@pmeerw.net> <1405370318-19699-3-git-send-email-pmeerw@pmeerw.net> <53C576F6.2070604@linux.intel.com>
In-Reply-To: <53C576F6.2070604@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/07/14 19:46, Srinivas Pandruvada wrote:
> On 07/14/2014 01:38 PM, Peter Meerwald wrote:
>> driver uses i2c_smbus_read_word_data() to the data in the trigger handler and hence
>> already does endianness conversion; the I2C chip has data in little endian, but the
>> value is provides in CPU endianness
>>
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git

Thanks,

>> ---
>>   drivers/iio/accel/kxcjk-1013.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>> index a11588c..ea96170 100644
>> --- a/drivers/iio/accel/kxcjk-1013.c
>> +++ b/drivers/iio/accel/kxcjk-1013.c
>> @@ -466,7 +466,7 @@ static const struct attribute_group kxcjk1013_attrs_group = {
>>           .realbits = 12,                        \
>>           .storagebits = 16,                    \
>>           .shift = 4,                        \
>> -        .endianness = IIO_LE,                    \
>> +        .endianness = IIO_CPU,                    \
>>       },                                \
>>   }
>>
>>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

