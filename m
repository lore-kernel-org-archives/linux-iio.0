Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35757 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab2FGPBK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jun 2012 11:01:10 -0400
Message-ID: <4FD0D04A.6050504@kernel.org>
Date: Thu, 07 Jun 2012 17:01:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: max517: mark probe() and remove() with __devinit
 and __devexit
References: <1339057907-17381-1-git-send-email-pmeerw@pmeerw.net> <1339057907-17381-2-git-send-email-pmeerw@pmeerw.net> <4FD07F69.3040600@antcom.de>
In-Reply-To: <4FD07F69.3040600@antcom.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/07/2012 11:16 AM, Roland Stigge wrote:
> On 07/06/12 10:31, Peter Meerwald wrote:
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> 
> Acked-by: Roland Stigge <stigge@antcom.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

Please send on to Greg KH.

> 
>> ---
>>  drivers/iio/dac/max517.c |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
>> index 352abe2..c3d748c 100644
>> --- a/drivers/iio/dac/max517.c
>> +++ b/drivers/iio/dac/max517.c
>> @@ -156,7 +156,7 @@ static const struct iio_chan_spec max517_channels[] = {
>>  	MAX517_CHANNEL(1)
>>  };
>>  
>> -static int max517_probe(struct i2c_client *client,
>> +static int __devinit max517_probe(struct i2c_client *client,
>>  			const struct i2c_device_id *id)
>>  {
>>  	struct max517_data *data;
>> @@ -210,7 +210,7 @@ exit:
>>  	return err;
>>  }
>>  
>> -static int max517_remove(struct i2c_client *client)
>> +static int __devexit max517_remove(struct i2c_client *client)
>>  {
>>  	iio_device_unregister(i2c_get_clientdata(client));
>>  	iio_device_free(i2c_get_clientdata(client));
>> @@ -232,7 +232,7 @@ static struct i2c_driver max517_driver = {
>>  		.pm		= MAX517_PM_OPS,
>>  	},
>>  	.probe		= max517_probe,
>> -	.remove		= max517_remove,
>> +	.remove		=  __devexit_p(max517_remove),
>>  	.id_table	= max517_id,
>>  };
>>  module_i2c_driver(max517_driver);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

