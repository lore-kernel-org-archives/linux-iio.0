Return-Path: <SRS0=axc1=6N=canonical.com=colin.king@kernel.org>
Subject: Re: [PATCH] iio:adc:at91-sama5d2: make array startup_lookup static
To: Jonathan Cameron <jic23@kernel.org>
References: <20170710165616.16734-1-colin.king@canonical.com>
 <20170710215938.4279bb07@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <65b9dd81-6c80-be97-513a-c7b0bec1ffa1@canonical.com>
Date: Mon, 10 Jul 2017 22:34:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170710215938.4279bb07@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 10/07/17 21:59, Jonathan Cameron wrote:
> On Mon, 10 Jul 2017 17:56:16 +0100
> Colin King <colin.king@canonical.com> wrote:
> 
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Don't populate array startup_lookup on the stack but instead make
>> it static.  Makes the object code smaller.  Also add in missing 'int' type
>> specifier to clean up a checkpatch warning.
>>
>> Before:
>>    text	   data	    bss	    dec	    hex	filename
>>   10297	   2800	    128	  13225	   33a9	drivers/iio/adc/at91-sama5d2_adc.o
>>
>> After:
>>    text	   data	    bss	    dec	    hex	filename
>>   10140	   2888	    128	  13156	   3364	drivers/iio/adc/at91-sama5d2_adc.o
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Hi Colin
> 
> I'm guessing accidental repost?  I applied this yesterday and you haven't marked
> it as a resend!

Yes, sorry, I lost track of what I was working on. Apologies.

> 
> Jonathan
>> ---
>>  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
>> index e10dca3ed74b..509988a6817a 100644
>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
>> @@ -231,7 +231,7 @@ static const struct iio_chan_spec at91_adc_channels[] = {
>>  static unsigned at91_adc_startup_time(unsigned startup_time_min,
>>  				      unsigned adc_clk_khz)
>>  {
>> -	const unsigned startup_lookup[] = {
>> +	static const unsigned int startup_lookup[] = {
>>  		  0,   8,  16,  24,
>>  		 64,  80,  96, 112,
>>  		512, 576, 640, 704,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
