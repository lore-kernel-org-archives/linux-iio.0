Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35761 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab2FGPBr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jun 2012 11:01:47 -0400
Message-ID: <4FD0D077.7080803@kernel.org>
Date: Thu, 07 Jun 2012 17:01:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: remove indio_dev pointer from max517_data
References: <1339057907-17381-1-git-send-email-pmeerw@pmeerw.net> <4FD07F42.5060007@antcom.de>
In-Reply-To: <4FD07F42.5060007@antcom.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/07/2012 11:15 AM, Roland Stigge wrote:
> On 07/06/12 10:31, Peter Meerwald wrote:
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> 
Well that would explain where the other one came from ;)
> Acked-by: Roland Stigge <stigge@antcom.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> 
>> ---
>>  drivers/iio/dac/max517.c |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
>> index 92c77c8..352abe2 100644
>> --- a/drivers/iio/dac/max517.c
>> +++ b/drivers/iio/dac/max517.c
>> @@ -43,7 +43,6 @@ enum max517_device_ids {
>>  };
>>  
>>  struct max517_data {
>> -	struct iio_dev		*indio_dev;
>>  	struct i2c_client	*client;
>>  	unsigned short		vref_mv[2];
>>  };
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

