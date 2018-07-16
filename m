Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:36453 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeGPJND (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jul 2018 05:13:03 -0400
Subject: Re: [PATCH V3] iio: ad9523: replace core mlock with local lock
To: Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com
References: <20180705123422.18786-1-alexandru.ardelean@analog.com>
 <20180707181153.3bd61a14@archlinux>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ea4c115c-341c-2631-ee86-7bb9c0afa19b@metafoo.de>
Date: Mon, 16 Jul 2018 10:46:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180707181153.3bd61a14@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/2018 07:11 PM, Jonathan Cameron wrote:
> On Thu, 5 Jul 2018 15:34:22 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> 
>> From: Lars-Peter Clausen <lars@metafoo.de>
>>
>> This is also part of a long term effort to make the use of mlock opaque and
>> single purpose.
>>
>> This lock is required for accessing device registers. The device may be
>> accessed by multiple processes at the same time, and this can result in
>> inconsistent data, where one device reads data before the other one has
>> finished writing.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>> ---
>>
>> V2 -> V3:
>> * added description about the impact of the change
>>
>>  drivers/iio/frequency/ad9523.c | 33 +++++++++++++++++++++++----------
>>  1 file changed, 23 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
>> index ddb6a334ae68..8fb4e5890713 100644
>> --- a/drivers/iio/frequency/ad9523.c
>> +++ b/drivers/iio/frequency/ad9523.c
>> @@ -274,6 +274,14 @@ struct ad9523_state {
>>  	unsigned long		vco_out_freq[AD9523_NUM_CLK_SRC];
>>  	unsigned char		vco_out_map[AD9523_NUM_CHAN_ALT_CLK_SRC];
>>  
>> +	/*
>> +	 * Lock for accessing device registers. The device may be accessed by
>> +	 * multiple processes at the same time, and this can result in
>> +	 * inconsistent data, where one device reads data before the other one
>> +	 * has finished writing.
>> +	 */
> I'm not sure this is accurate.  This is an SPI device so there is locking on
> the comms in the SPI layers.
> 
> The issue here is that we have state changes which involve multiple actions
> that need to be done an atomic fashion (as seen from other threads).
> In some cases because we have 'read modify write cycles' and in
> others because we need to be in a particular state to write another register.
> 
> So a little more detail would make this clearer.  Perhaps as simple as saying
> that some actions are a compound of multiple register writes and reads that
> need to not be interrupted?

The transfer buffers are shared between SPI transfers. So even if only one
register is accessed this need locking.

