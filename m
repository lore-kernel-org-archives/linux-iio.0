Return-Path: <vilhelm.gray@gmail.com>
Date: Mon, 25 Jul 2016 08:41:15 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: stx104: Store channel output state values as int
Message-ID: <20160725124042.GA14327@sophia>
References: <20160713144334.GA24521@sophia>
 <88bcc7a2-0f30-6f45-c8a8-37e2777c8dff@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <88bcc7a2-0f30-6f45-c8a8-37e2777c8dff@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jul 24, 2016 at 02:06:49PM +0100, Jonathan Cameron wrote:
>On 13/07/16 15:43, William Breathitt Gray wrote:
>> The val parameter has a data type of int in the read_raw and write_raw
>> callbacks. The chan_out_states array should have elements of type int in
>> order to match the data type of the val parameter.
>> 
>> This patch fixes a possible integer overflow condition when the the int
>> pointer val is dereferenced to store the unsigned int chan_out_states
>> element in the read_raw callback.
>> 
>> Fixes: 97a445dad37a ("iio: Add IIO support for the DAC on the Apex Embedded Systems STX104")
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>Isn't this only a problem if an out of range value was written
>in the first place?  The values it'll take are only 16bits,
>so a simple range check around that would fix the root problem.
>
>J

Please disregard this patch.

When I submitted this patch I had assumed the possibility of platforms
with 16-bit int; if all platforms supported by the Linux kernel have at
minimum 32-bit int, then a simple range check should be sufficient.

William Breathitt Gray

>> ---
>>  drivers/iio/dac/stx104.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/iio/dac/stx104.c b/drivers/iio/dac/stx104.c
>> index 792a971..b22b744 100644
>> --- a/drivers/iio/dac/stx104.c
>> +++ b/drivers/iio/dac/stx104.c
>> @@ -47,7 +47,7 @@ MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
>>   * @base:		base port address of the IIO device
>>   */
>>  struct stx104_iio {
>> -	unsigned chan_out_states[STX104_NUM_CHAN];
>> +	int chan_out_states[STX104_NUM_CHAN];
>>  	unsigned base;
>>  };
>>  
>> 
>
