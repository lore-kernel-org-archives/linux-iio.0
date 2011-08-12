Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E4536FE.40502@cam.ac.uk>
Date: Fri, 12 Aug 2011 15:21:50 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: stufever@gmail.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, gregkh@suse.de, michael.hennerich@analog.com,
 Wang Shaoyan <wangshaoyan.pt@taobao.com>
Subject: Re: [PATCH] staging: IIO: DAC: Delete useless label error_ret in
 ad5791.c
References: <1312654158-28057-1-git-send-email-wangshaoyan.pt@taobao.com> <4E44E99E.3070302@cam.ac.uk>
In-Reply-To: <4E44E99E.3070302@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/12/11 09:51, Jonathan Cameron wrote:
> On 08/06/11 19:09, stufever@gmail.com wrote:
>> From: Wang Shaoyan <wangshaoyan.pt@taobao.com>
>>
>>   drivers/staging/iio/dac/ad5791.c: In function 'ad5791_probe':
>>   drivers/staging/iio/dac/ad5791.c:384: warning: label 'error_ret' defined but not used
>>
>> The label error_ret is defined, but never used, so delete it to avoid annoying warning.
> As with other one, this is fixed in iio-blue.git, but I'm happy to see either version merge.
I'm dozing.  This is the third fix for this one.  Greg, pick up which ever one you want!
>>
>> Signed-off-by: Wang Shaoyan <wangshaoyan.pt@taobao.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>>  drivers/staging/iio/dac/ad5791.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
>> index 64770d2..5b00b70 100644
>> --- a/drivers/staging/iio/dac/ad5791.c
>> +++ b/drivers/staging/iio/dac/ad5791.c
>> @@ -381,7 +381,6 @@ error_put_reg_pos:
>>  	if (!IS_ERR(reg_vdd))
>>  		regulator_put(reg_vdd);
>>  
>> -error_ret:
>>  	return ret;
>>  }
>>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
