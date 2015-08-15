Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47430 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbbHOOgy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 10:36:54 -0400
Subject: Re: [patch] iio: tsl4531: fix error handling in tsl4531_check_id()
To: Dan Murphy <dmurphy@ti.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <20150813202027.GA4385@mwanda> <55CD0611.5060606@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF4E85.1010400@kernel.org>
Date: Sat, 15 Aug 2015 15:36:53 +0100
MIME-Version: 1.0
In-Reply-To: <55CD0611.5060606@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/08/15 22:03, Dan Murphy wrote:
> Dan
> 
> On 08/13/2015 03:21 PM, Dan Carpenter wrote:
>> The caller expect us to return zero if the ID doesn't match.  Negative
>> error codes are treated as success.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
>> index 2697918..730fd2b 100644
>> --- a/drivers/iio/light/tsl4531.c
>> +++ b/drivers/iio/light/tsl4531.c
>> @@ -151,7 +151,7 @@ static int tsl4531_check_id(struct i2c_client *client)
>>  {
>>  	int ret = i2c_smbus_read_byte_data(client, TSL4531_ID);
>>  	if (ret < 0)
>> -		return ret;
>> +		return 0;
>>  
>>  	switch (ret >> TSL4531_ID_SHIFT) {
>>  	case TSL45311_ID:
> 
> Would this not be better to change the logic?
> 
> Zero return is generally true and non-zero is false.
> 
> Then this statement in the probe then can go from
> 
>     if (!tsl4531_check_id(client)) {
>         dev_err(&client->dev, "no TSL4531 sensor\n");
>         return -ENODEV;
>     }
> 
> to
> 
>     if (tsl4531_check_id(client)) {
>         dev_err(&client->dev, "no TSL4531 sensor\n");
>         return -ENODEV;
>     }
> 
> And if then return ret can be honored in probe.
> 
> Dan
> 
Oops, missed this email.  I'd prefer to take it further and spit
out 0 for success as you suggest, but also do the error code
generation for no device in the check_id function, thus
allowing read failures to be passed up as well.

Jonathan

