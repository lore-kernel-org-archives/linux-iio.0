Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:22890
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751100Ab3FCIZJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2013 04:25:09 -0400
Message-ID: <51AC51E6.80108@analog.com>
Date: Mon, 3 Jun 2013 10:20:54 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/4] iio: frequency: ad4350: Fix bug / typo in mask
References: <1369321259-14602-1-git-send-email-michael.hennerich@analog.com> <51AB6E79.7070108@kernel.org>
In-Reply-To: <51AB6E79.7070108@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/02/2013 06:10 PM, Jonathan Cameron wrote:
> On 05/23/2013 04:00 PM, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
> I got lost in the original discussion.
>
> Is this a fix for the current cycle, or does it want to go with the
> rest of the series, for the next one?
>
> I'm guessing you'll do a refreshed version with the bits in patch
> 4 fixed up so I'll wait for that to apply it.

Hi Jonathan,

I'll send out a new series shortly - 1/4 is fixing a bug -
if it can go into the current cycle that would be good.

>
> Jonathan
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>   drivers/iio/frequency/adf4350.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
>> index a884252..e76d4ac 100644
>> --- a/drivers/iio/frequency/adf4350.c
>> +++ b/drivers/iio/frequency/adf4350.c
>> @@ -212,7 +212,7 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
>>   		(pdata->r2_user_settings & (ADF4350_REG2_PD_POLARITY_POS |
>>   		ADF4350_REG2_LDP_6ns | ADF4350_REG2_LDF_INT_N |
>>   		ADF4350_REG2_CHARGE_PUMP_CURR_uA(5000) |
>> -		ADF4350_REG2_MUXOUT(0x7) | ADF4350_REG2_NOISE_MODE(0x9)));
>> +		ADF4350_REG2_MUXOUT(0x7) | ADF4350_REG2_NOISE_MODE(0x3)));
>>   
>>   	st->regs[ADF4350_REG3] = pdata->r3_user_settings &
>>   				 (ADF4350_REG3_12BIT_CLKDIV(0xFFF) |
>>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


