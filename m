Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32868 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbcFCMAs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 08:00:48 -0400
Subject: Re: [PATCH] iio: dac: fix off-by-one comparison and out-of-bounds
 write
To: michael.hennerich@analog.com,
	Colin King <colin.king@canonical.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
References: <1464861990-9155-1-git-send-email-colin.king@canonical.com>
 <57501038.1070207@analog.com>
Cc: linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fcebdfbd-6d81-7e5a-4a85-27d41a4ea280@kernel.org>
Date: Fri, 3 Jun 2016 13:00:45 +0100
MIME-Version: 1.0
In-Reply-To: <57501038.1070207@analog.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/16 11:53, Michael Hennerich wrote:
> On 06/02/2016 12:06 PM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The check on reg is off-by-one, it should be >= rather than >. Fix
>> this to stop an out-of-bounds write to st->channel_modes[reg].
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Already have a fix queued from the 29th of April - will push out
in the next few days.  It just managed to miss going out in the
last cycle by a few days.

Thanks,

Jonathan

> 
>> ---
>>   drivers/iio/dac/ad5592r-base.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
>> index 948f600..69bde59 100644
>> --- a/drivers/iio/dac/ad5592r-base.c
>> +++ b/drivers/iio/dac/ad5592r-base.c
>> @@ -525,7 +525,7 @@ static int ad5592r_alloc_channels(struct ad5592r_state *st)
>>
>>       device_for_each_child_node(st->dev, child) {
>>           ret = fwnode_property_read_u32(child, "reg", &reg);
>> -        if (ret || reg > ARRAY_SIZE(st->channel_modes))
>> +        if (ret || reg >= ARRAY_SIZE(st->channel_modes))
>>               continue;
>>
>>           ret = fwnode_property_read_u32(child, "adi,mode", &tmp);
>>
> 
> 

