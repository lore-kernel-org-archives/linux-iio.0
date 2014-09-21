Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48997 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaIUMSv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Sep 2014 08:18:51 -0400
Message-ID: <541EC22A.4030007@kernel.org>
Date: Sun, 21 Sep 2014 13:18:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Chris Ruffin <cmruffin@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: accel: remove unnecessary syntax
References: <1410737937-10773-1-git-send-email-cmruffin@gmail.com> <54175C04.70302@gmx.de>
In-Reply-To: <54175C04.70302@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/09/14 22:37, Hartmut Knaack wrote:
> Chris Ruffin schrieb, Am 15.09.2014 01:38:
>> The else clause in the conditional of lis3l02dq_data_rdy_trig_poll()
>> does not make consistent use of braces with the rest of the
>> conditional.  Fix this coding style problem by removing the
>> unnecessary conditional altogether.
>>
>> Signed-off-by: Chris Ruffin <cmruffin@gmail.com>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play.

Thanks,

Jonathan
>> ---
>>  drivers/staging/iio/accel/lis3l02dq_ring.c |    5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
>> index 1d934ee..9efc77b 100644
>> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
>> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
>> @@ -34,8 +34,9 @@ irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private)
>>  	if (st->trigger_on) {
>>  		iio_trigger_poll(st->trig);
>>  		return IRQ_HANDLED;
>> -	} else
>> -		return IRQ_WAKE_THREAD;
>> +	}
>> +
>> +	return IRQ_WAKE_THREAD;
>>  }
>>  
>>  static const u8 read_all_tx_array[] = {
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
