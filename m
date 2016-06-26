Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47712 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbcFZQUN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 12:20:13 -0400
Subject: Re: [PATCH] iio: proximity: as3935: remove redundant zeroing of
 tune_cap
To: Marek Vasut <marek.vasut@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1466041622-1236-1-git-send-email-mranostay@gmail.com>
 <57634C9D.7090705@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c92b6f88-0eeb-ab87-75f6-a3fa59d16080@kernel.org>
Date: Sun, 26 Jun 2016 17:20:11 +0100
MIME-Version: 1.0
In-Reply-To: <57634C9D.7090705@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/06/16 02:04, Marek Vasut wrote:
> On 06/16/2016 03:47 AM, Matt Ranostay wrote:
> 
> Commit message explaining what the patch does and why this patch is
> needed is missing.
Applied with a note about why this is already 0 added to the commit
message.

Thanks,

Jonathan
> 
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>  drivers/iio/proximity/as3935.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
>> index 9aa2ce551ba8..692e9cda8ae0 100644
>> --- a/drivers/iio/proximity/as3935.c
>> +++ b/drivers/iio/proximity/as3935.c
>> @@ -346,7 +346,6 @@ static int as3935_probe(struct spi_device *spi)
>>  
>>  	st = iio_priv(indio_dev);
>>  	st->spi = spi;
>> -	st->tune_cap = 0;
>>  
>>  	spi_set_drvdata(spi, indio_dev);
>>  	mutex_init(&st->lock);
>>
> 
> 

