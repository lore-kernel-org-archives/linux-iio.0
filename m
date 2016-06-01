Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:32987 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932454AbcFASPb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 1 Jun 2016 14:15:31 -0400
Message-ID: <574F263C.2010909@osg.samsung.com>
Date: Wed, 01 Jun 2016 19:15:24 +0100
From: Luis de Bethencourt <luisbg@osg.samsung.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
CC: gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: iio: ad5933: fix handling of settling time cycles
References: <1464796525-9030-1-git-send-email-luisbg@osg.samsung.com> <574F0BB5.7080105@metafoo.de>
In-Reply-To: <574F0BB5.7080105@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/06/16 17:22, Lars-Peter Clausen wrote:
> On 06/01/2016 05:55 PM, Luis de Bethencourt wrote:
>> Correctly handle the settling time cycles value. The else branch was an
>> impossible condition (> 1022 in the else branch of > 511) and the handling
>> of the values was dividing by 2 and 4, with a left shift, instead of
>> multiplying.
>>
>> Based on the Table 13 at the bottom of Page 25 of the Data Sheet:
>> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf
>>
>> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
>> ---
>>
>> Hi,
>>
>> I decided to use the hexadecimal values instead of (1 << 10) and (1 << 9), for
>> briefness, I could resend using those instead if it is prefered.
>>
>> I also decided to use multiplications instead of right-shifts for readability.
>> I could use change that as well.
>>
>> Thanks,
>> Luis
>>
>>  drivers/staging/iio/impedance-analyzer/ad5933.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
>> index 9f43976..3a2cf8f3 100644
>> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
>> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
>> @@ -444,10 +444,13 @@ static ssize_t ad5933_store(struct device *dev,
>>  		st->settling_cycles = val;
>>  
>>  		/* 2x, 4x handling, see datasheet */
>> -		if (val > 511)
>> -			val = (val >> 1) | (1 << 9);
>> -		else if (val > 1022)
>> -			val = (val >> 2) | (3 << 9);
>> +		if (val & 0x400 && val & 0x200) {
>> +			val &= 0x1ff;
>> +			val *= 4;
>> +		} else if (val & 0x200) {
>> +			val &= 0x1ff;
>> +			val *= 2;
>> +		}
> 
> This does not look correct. D10 and D9 select an additional multiplier of
> either 1, 2 or 4. So dividing the value before writing it to the register is
> the right approach in that case. Just flipping the order in which the
> conditions are evaluated should be sufficient.
> 
>>  
>>  		dat = cpu_to_be16(val);
>>  		ret = ad5933_i2c_write(st->client,
>>
> 

I misunderstood the register being read instead of being written. Looking at it
now, I have no idea why. Sorry.

Will resend a patch flipping the order of conditions.

Thanks for the review,
Luis
