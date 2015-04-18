Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33562 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbbDRTcM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 15:32:12 -0400
Message-ID: <5532B13B.5070705@kernel.org>
Date: Sat, 18 Apr 2015 20:32:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:tcs4531: Fix leftover TCS3472_ prefix in tsl4531
 driver
References: <1429130378-19941-1-git-send-email-pmeerw@pmeerw.net> <552F7295.7000602@intel.com>
In-Reply-To: <552F7295.7000602@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/04/15 09:28, Daniel Baluta wrote:
> 
> 
> On 04/15/2015 11:39 PM, Peter Meerwald wrote:
>> just cleanup, no functional change
> 
> Commit message tag should be now "iio: tsl4531: ". Other than that
> it looks good to me.
> 
Good spot to both of you ;)

Anyhow, applied with patch title fixed to the togreg branch of iio.git.

Thanks,
> 
>>
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>> ---
>>   drivers/iio/light/tsl4531.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
>> index 0763b86..63c26e2 100644
>> --- a/drivers/iio/light/tsl4531.c
>> +++ b/drivers/iio/light/tsl4531.c
>> @@ -24,12 +24,12 @@
>>
>>   #define TSL4531_DRV_NAME "tsl4531"
>>
>> -#define TCS3472_COMMAND BIT(7)
>> +#define TSL4531_COMMAND BIT(7)
>>
>> -#define TSL4531_CONTROL (TCS3472_COMMAND | 0x00)
>> -#define TSL4531_CONFIG (TCS3472_COMMAND | 0x01)
>> -#define TSL4531_DATA (TCS3472_COMMAND | 0x04)
>> -#define TSL4531_ID (TCS3472_COMMAND | 0x0a)
>> +#define TSL4531_CONTROL (TSL4531_COMMAND | 0x00)
>> +#define TSL4531_CONFIG (TSL4531_COMMAND | 0x01)
>> +#define TSL4531_DATA (TSL4531_COMMAND | 0x04)
>> +#define TSL4531_ID (TSL4531_COMMAND | 0x0a)
>>
>>   /* operating modes in control register */
>>   #define TSL4531_MODE_POWERDOWN 0x00
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

