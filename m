Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33034 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbcFCMXq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 08:23:46 -0400
Subject: Re: [PATCH] iio: (ms5637) Add Measurement Specialties explicit MS5805
 and MS5837 support
To: "Markezana, William" <William.Markezana@te.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <A02AF0B2-1B1A-477E-952B-AA332C6650FE@te.com>
 <alpine.DEB.2.02.1605312318400.9332@pmeerw.net>
 <CY1PR01MB1947A8160E9C24A9398543EA95470@CY1PR01MB1947.prod.exchangelabs.com>
Cc: "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <07bdfb5d-5113-2174-a1dd-dec7af0bcf9b@kernel.org>
Date: Fri, 3 Jun 2016 13:23:44 +0100
MIME-Version: 1.0
In-Reply-To: <CY1PR01MB1947A8160E9C24A9398543EA95470@CY1PR01MB1947.prod.exchangelabs.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/06/16 08:27, Markezana, William wrote:
> On Tue, 31 May 2016, Markezana, William wrote:
> 
>> Signed-off-by: William Markezana <william.markezana@meas-spec.com>
>> ---
>>  drivers/iio/pressure/ms5637.c | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/ms5637.c 
>> b/drivers/iio/pressure/ms5637.c index e8d0e0d..6ecc686 100644
>> --- a/drivers/iio/pressure/ms5637.c
>> +++ b/drivers/iio/pressure/ms5637.c
>> @@ -1,5 +1,6 @@
>>  /*
>> - * ms5637.c - Support for Measurement-Specialties ms5637 and ms8607
>> + * ms5637.c - Support for Measurement-Specialties ms5637, ms8607,
>> +              ms5805 and ms5837
> 
> I guess we expect it to look like
>  *             ms5805 and ms5837 pressure & temperature sensors
> 
> and I suggest to list the chips in lexicographic order (here and all other
> lists)
> 
> -I will update the patch according to you suggestion.
> 
> it seems there is no functional difference?
> 
> -All sensors are different and have various measurement range. 
> This patch is about making people aware that this driver is compatible 
> with other sensors without duplicating code. 
> Is there a better way to do that ?
This is fine. 

As far as I can immediately see though the enum values are unused?

If so, don't bother having the enum and set all the client data to 0.

Thanks,

Jonathan
> 
>>   *            pressure & temperature sensor
>>   *
>>   * Copyright (c) 2015 Measurement-Specialties @@ -12,6 +13,10 @@
>>   *  http://www.meas-spec.com/downloads/MS5637-02BA03.pdf
>>   * Datasheet:
>>   *  http://www.meas-spec.com/downloads/MS8607-02BA01.pdf
>> + * Datasheet:
>> + *  http://www.meas-spec.com/downloads/MS5805-02BA01.pdf
>> + * Datasheet:
>> + *  http://meas-spec.com/downloads/MS5837-30BA.pdf
>>   */
>>  
>>  #include <linux/init.h>
>> @@ -26,6 +31,13 @@
>>  
>>  #include "../common/ms_sensors/ms_sensors_i2c.h"
>>  
>> +enum {
>> +	MS5637,
>> +	MS8607,
>> +	MS5805,
>> +	MS5837
>> +};
>> +
>>  static const int ms5637_samp_freq[6] = { 960, 480, 240, 120, 60, 30 
>> };
>>  /* String copy of the above const for readability purpose */  static 
>> const char ms5637_show_samp_freq[] = "960 480 240 120 60 30"; @@ 
>> -169,8 +181,10 @@ static int ms5637_probe(struct i2c_client *client,  
>> }
>>  
>>  static const struct i2c_device_id ms5637_id[] = {
>> -	{"ms5637", 0},
>> -	{"ms8607-temppressure", 1},
>> +	{"ms5637", MS5637},
>> +	{"ms8607-temppressure", MS8607},
>> +	{"ms5805", MS5805},
>> +	{"ms5837", MS5837},
>>  	{}
>>  };
>>  
>>
> 

