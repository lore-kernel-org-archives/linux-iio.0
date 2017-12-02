Return-Path: <SRS0=R3xd=C6=axtens.net=dja@kernel.org>
From: Daniel Axtens <dja@axtens.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] iio: adc: add MODULE_LICENSE to qcom-vadc-common.c
In-Reply-To: <20171202132414.032876f1@archlinux>
References: <20171202122209.14720-1-dja@axtens.net> <20171202132414.032876f1@archlinux>
Date: Sun, 03 Dec 2017 00:44:51 +1100
Message-ID: <87po7xfdm4.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

> On Sat,  2 Dec 2017 23:22:09 +1100
> Daniel Axtens <dja@axtens.net> wrote:
>
>> This fixes the following warning during an allmodconfig build:
>> WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/adc/qcom-vadc-common.o
>> 
>> This matches the header at the top of the file.
>> 
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
> This is second or third patch for this one as well.
>
> Please check the togreg (or testing) branch of iio.git on kernel.org.
>
Apologies - I don't think I have any other patches for iio, but if I do
I will check that branch before sending.

Regards,
Daniel

> Thanks,
>
> Jonathan
>
>> ---
>>  drivers/iio/adc/qcom-vadc-common.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
>> index 47d24ae5462f..3b2c48ab44ff 100644
>> --- a/drivers/iio/adc/qcom-vadc-common.c
>> +++ b/drivers/iio/adc/qcom-vadc-common.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/math64.h>
>>  #include <linux/log2.h>
>>  #include <linux/err.h>
>> +#include <linux/module.h>
>>  
>>  #include "qcom-vadc-common.h"
>>  
>> @@ -229,3 +230,5 @@ int qcom_vadc_decimation_from_dt(u32 value)
>>  	return __ffs64(value / VADC_DECIMATION_MIN);
>>  }
>>  EXPORT_SYMBOL(qcom_vadc_decimation_from_dt);
>> +
>> +MODULE_LICENSE("GPL v2");
