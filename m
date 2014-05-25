Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54957 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbaEYLGH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 25 May 2014 07:06:07 -0400
Message-ID: <5381CF03.4010005@kernel.org>
Date: Sun, 25 May 2014 12:07:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Erik.Habbinga@schneider-electric.com
Subject: Re: [PATCH] iio:adc:max1363 incorrect resolutions for max11604, max11605,
 max11610 and max11611.
References: <1400933041-7007-1-git-send-email-jic23@kernel.org> <53810894.2000806@gmx.de>
In-Reply-To: <53810894.2000806@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/05/14 22:01, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>> Reported-by: Erik Habbinga <Erik.Habbinga@schneider-electric.com>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>

Thanks,

Given the late stage in the cycle and the relatively minor nature of this
bug I've applied it to the togreg tree for the next merge window.

Jonathan
>> ---
>>   drivers/iio/adc/max1363.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
>> index 9cf3229..1b3b74b 100644
>> --- a/drivers/iio/adc/max1363.c
>> +++ b/drivers/iio/adc/max1363.c
>> @@ -1252,8 +1252,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>>   		.num_modes = ARRAY_SIZE(max1238_mode_list),
>>   		.default_mode = s0to11,
>>   		.info = &max1238_info,
>> -		.channels = max1238_channels,
>> -		.num_channels = ARRAY_SIZE(max1238_channels),
>> +		.channels = max1038_channels,
>> +		.num_channels = ARRAY_SIZE(max1038_channels),
>>   	},
>>   	[max11605] = {
>>   		.bits = 8,
>> @@ -1262,8 +1262,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>>   		.num_modes = ARRAY_SIZE(max1238_mode_list),
>>   		.default_mode = s0to11,
>>   		.info = &max1238_info,
>> -		.channels = max1238_channels,
>> -		.num_channels = ARRAY_SIZE(max1238_channels),
>> +		.channels = max1038_channels,
>> +		.num_channels = ARRAY_SIZE(max1038_channels),
>>   	},
>>   	[max11606] = {
>>   		.bits = 10,
>> @@ -1312,8 +1312,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>>   		.num_modes = ARRAY_SIZE(max1238_mode_list),
>>   		.default_mode = s0to11,
>>   		.info = &max1238_info,
>> -		.channels = max1238_channels,
>> -		.num_channels = ARRAY_SIZE(max1238_channels),
>> +		.channels = max1138_channels,
>> +		.num_channels = ARRAY_SIZE(max1138_channels),
>>   	},
>>   	[max11611] = {
>>   		.bits = 10,
>> @@ -1322,8 +1322,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>>   		.num_modes = ARRAY_SIZE(max1238_mode_list),
>>   		.default_mode = s0to11,
>>   		.info = &max1238_info,
>> -		.channels = max1238_channels,
>> -		.num_channels = ARRAY_SIZE(max1238_channels),
>> +		.channels = max1138_channels,
>> +		.num_channels = ARRAY_SIZE(max1138_channels),
>>   	},
>>   	[max11612] = {
>>   		.bits = 12,
>

