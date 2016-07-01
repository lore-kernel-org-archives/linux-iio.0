Return-Path: <afd@ti.com>
Subject: Re: [PATCH] iio: dac: mcp4725: Remove unneeded conversions to bool
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20160701143352.17224-1-afd@ti.com>
 <alpine.DEB.2.02.1607011700150.7271@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <577689C4.6090803@ti.com>
Date: Fri, 1 Jul 2016 10:18:28 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1607011700150.7271@pmeerw.net>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 07/01/2016 10:03 AM, Peter Meerwald-Stadler wrote:
> 
>> Found with scripts/coccinelle/misc/boolconv.cocci.
> 
> I'd argue that
> 
>         pd = (inbuf[0] >> 1) & 0x3;
>         if (pd) {
>                 data->powerdown = true;
>                 data->powerdown_mode = pd - 1;
>         } else {
>                 data->powerdown = false;
>                 data->powerdown_mode = 2; /* largest register to gnd */
>         }
> 
> is less compact but probably easier to read/understand;
> 

I agree, this is a much better fix. Would you like to submit this
version as a patch?

Andrew

>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> 
> but I'm fine with the proposed patch as well to make cocci happy
> 
> regards, p.
> 
>> ---
>>  drivers/iio/dac/mcp4725.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
>> index cca935c..c3bb3fd 100644
>> --- a/drivers/iio/dac/mcp4725.c
>> +++ b/drivers/iio/dac/mcp4725.c
>> @@ -361,7 +361,7 @@ static int mcp4725_probe(struct i2c_client *client,
>>  		return err;
>>  	}
>>  	pd = (inbuf[0] >> 1) & 0x3;
>> -	data->powerdown = pd > 0 ? true : false;
>> +	data->powerdown = pd > 0;
>>  	data->powerdown_mode = pd ? pd - 1 : 2; /* largest register to gnd */
>>  	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
>>  
>>
> 
