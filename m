Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58549 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754753AbcIJPj3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2016 11:39:29 -0400
Subject: Re: [PATCH] Tiny whitespace fix to make ad7192.c cleanly pass
 checkpatch.pl
To: Lars-Peter Clausen <lars@metafoo.de>, Ico Doornekamp <ico@pruts.nl>
References: <20160909134026.12055-1-ico@pruts.nl>
 <d848e8a4-d21d-8221-9e36-e89f653f9a35@metafoo.de>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cfb0e4da-7f6c-da8e-441d-3027b18c2ec2@kernel.org>
Date: Sat, 10 Sep 2016 16:39:27 +0100
MIME-Version: 1.0
In-Reply-To: <d848e8a4-d21d-8221-9e36-e89f653f9a35@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/09/16 14:59, Lars-Peter Clausen wrote:
> Hi,
> 
> Thanks for the patch. But this not a correct change, it is a false positive
> reported by checkpatch.

Just to explain a bit more.  Checkpatch is assuming that it is looking
at two parameters. It's not. That's a string being passed into the macro.
It ultimately forms a file name in sysfs.

Jonathan

p.s. We get patches for this from time to time ;(  Unfortunately it's
a somewhat obscure case for checkpatch.
> 
> - Lars
> 
> On 09/09/2016 03:40 PM, Ico Doornekamp wrote:
>> ---
>>  drivers/staging/iio/adc/ad7192.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
>> index 1cf6b79..5688b29 100644
>> --- a/drivers/staging/iio/adc/ad7192.c
>> +++ b/drivers/staging/iio/adc/ad7192.c
>> @@ -391,7 +391,7 @@ ad7192_show_scale_available(struct device *dev,
>>  }
>>  
>>  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
>> -			     in_voltage-voltage_scale_available,
>> +			     in_voltage - voltage_scale_available,
>>  			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
>>  
>>  static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

