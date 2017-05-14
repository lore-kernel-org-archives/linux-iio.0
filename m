Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46531 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752897AbdENO3a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 10:29:30 -0400
Subject: Re: [PATCH RFC] iio: pressure: zpa2326: report interrupted case as
 failure
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicholas Mc Guire <der.herr@hofr.at>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        simran singhal <singhalsimran0@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1494751435-14189-1-git-send-email-der.herr@hofr.at>
 <alpine.DEB.2.20.1705141146060.1876@vps.pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9c47eb49-8ac9-566b-7f7c-ab5b97dac0a8@kernel.org>
Date: Sun, 14 May 2017 15:29:27 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1705141146060.1876@vps.pmeerw.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/05/17 10:46, Peter Meerwald-Stadler wrote:
> 
>> If the timeout-case prints a warning message then probably the interrupted
>> case should also. Further, wait_for_completion_interruptible_timeout()
>> returns long not int.
>>
>> Fixes: commit 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer support")
>> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> 
> this is actually a v2, looks good to me
A formal ack would be good!  Anyhow, I'll take that as an informal one.

A typo in the error message that I've fixed.

Applied to the togreg branch of iio.git.  Will be pushed out as testing
for the autobuilders to play with it.

BTW I don't think this one really should have been an RFC. It's a clear
tidy up to some confusing code being proposed for inclusion rather than
to start a discussion!

Jonathan
> 
>> ---
>>
>> The original control-flow was technically not wrong just confusing and a bit
>> complicated. Not clear if reporting the interrupted case actually is useful,
>> but given that the timeout is relatively long (200ms) it is not that unlikely
>> so differentiating the cases seems helpful.
>>
>> Patch was compile-tested with: x86_64_defconfig + CONFIG_IIO=m, CONFIG_ZPA2326=m
>>
>> Patch is against v4.11 (localversion-next is next-20170512)
>>
>>   drivers/iio/pressure/zpa2326.c | 17 ++++++++++-------
>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
>> index e58a0ad..617926f 100644
>> --- a/drivers/iio/pressure/zpa2326.c
>> +++ b/drivers/iio/pressure/zpa2326.c
>> @@ -867,12 +867,13 @@ static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
>>   {
>>   	int          ret;
>>   	unsigned int val;
>> +	long     timeout;
>>   
>>   	zpa2326_dbg(indio_dev, "waiting for one shot completion interrupt");
>>   
>> -	ret = wait_for_completion_interruptible_timeout(
>> +	timeout = wait_for_completion_interruptible_timeout(
>>   		&private->data_ready, ZPA2326_CONVERSION_JIFFIES);
>> -	if (ret > 0)
>> +	if (timeout > 0)
>>   		/*
>>   		 * Interrupt handler completed before timeout: return operation
>>   		 * status.
>> @@ -882,13 +883,15 @@ static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
>>   	/* Clear all interrupts just to be sure. */
>>   	regmap_read(private->regmap, ZPA2326_INT_SOURCE_REG, &val);
>>   
>> -	if (!ret)
>> +	if (!timeout) {
>>   		/* Timed out. */
>> +		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%ld)",
>> +			     timeout);
>>   		ret = -ETIME;
>> -
>> -	if (ret != -ERESTARTSYS)
>> -		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%d)",
>> -			     ret);
>> +	} else if (timeout < 0) {
>> +		zpa2326_warn(indio_dev, "wait for one shot interrupt canceled");
cancelled. I'll fix that.
>> +		ret = -ERESTARTSYS;
>> +	}
>>   
>>   	return ret;
>>   }
>>
> 

