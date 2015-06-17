Return-Path: <knaack.h@gmx.de>
Message-ID: <55811E24.8020902@gmx.de>
Date: Wed, 17 Jun 2015 09:13:40 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Kevin Tsai <ktsai@capellamicro.com>,
 Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH 6/7] iio:light:cm3323: make use of GENMASK
References: <cover.1434492557.git.knaack.h@gmx.de> <8c611cebe2127d183b8fbb748d084dfc3a333d2e.1434492557.git.knaack.h@gmx.de> <alpine.DEB.2.02.1506170027470.22088@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1506170027470.22088@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Peter Meerwald schrieb am 17.06.2015 um 00:29:
> 
>> Use GENMASK to define the integration time bitmask.
> 
> Nack, should be GENMASK(6, 4) I think

Thanks, you are totally right. Seems like I wasn't in the
best shape for coding yesterday. Will fix this and actually
double check this series for other issues.
Thanks,

Hartmut

>  
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>> ---
>>  drivers/iio/light/cm3323.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
>> index 6bb75e7..4f362d5 100644
>> --- a/drivers/iio/light/cm3323.c
>> +++ b/drivers/iio/light/cm3323.c
>> @@ -29,7 +29,7 @@
>>  
>>  #define CM3323_CONF_SD_BIT	BIT(0) /* sensor disable */
>>  #define CM3323_CONF_AF_BIT	BIT(1) /* auto/manual force mode */
>> -#define CM3323_CONF_IT_MASK	(BIT(4) | BIT(5) | BIT(6))
>> +#define CM3323_CONF_IT_MASK	GENMASK(4, 6)
>>  #define CM3323_CONF_IT_SHIFT	4
>>  
>>  #define CM3323_INT_TIME_AVAILABLE "0.04 0.08 0.16 0.32 0.64 1.28"
>>
> 
