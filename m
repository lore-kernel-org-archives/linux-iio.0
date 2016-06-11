Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:35134 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbcFKRZ0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 13:25:26 -0400
Subject: Re: [PATCH v2] staging: iio: ad5933: fix order of cycle conditions
To: Jonathan Cameron <jic23@kernel.org>,
	Luis de Bethencourt <luisbg@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1464809154-14868-1-git-send-email-luisbg@osg.samsung.com>
 <d4277886-41b4-e1ea-e015-6e62ac0212de@kernel.org>
Cc: gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <575C497F.2080507@metafoo.de>
Date: Sat, 11 Jun 2016 19:25:19 +0200
MIME-Version: 1.0
In-Reply-To: <d4277886-41b4-e1ea-e015-6e62ac0212de@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/2016 06:50 PM, Jonathan Cameron wrote:
> On 01/06/16 20:25, Luis de Bethencourt wrote:
>> Correctly handle the settling time cycles value. The else branch is an
>> impossible condition, > 1022 in the else branch of > 511. Flipping the order.
>>
>> Based on the Table 13 at the bottom of Page 25 of the Data Sheet:
>> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf
>>
>> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
>> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> While Lars did review, it I'm not seeing an email where he
> gave this tag (my inbox may well have eaten it).
> 
> Lars, could you confirm that you are happy with the
> patch as it now stands.
> 

All good, thanks.

> Certainly looks right to me!
> 
> Thanks, 
> Jonathan
>> ---
>>  drivers/staging/iio/impedance-analyzer/ad5933.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
>> index 9f43976..170ac98 100644
>> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
>> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
>> @@ -444,10 +444,10 @@ static ssize_t ad5933_store(struct device *dev,
>>  		st->settling_cycles = val;
>>  
>>  		/* 2x, 4x handling, see datasheet */
>> -		if (val > 511)
>> -			val = (val >> 1) | (1 << 9);
>> -		else if (val > 1022)
>> +		if (val > 1022)
>>  			val = (val >> 2) | (3 << 9);
>> +		else if (val > 511)
>> +			val = (val >> 1) | (1 << 9);
>>  
>>  		dat = cpu_to_be16(val);
>>  		ret = ad5933_i2c_write(st->client,
>>
> 

