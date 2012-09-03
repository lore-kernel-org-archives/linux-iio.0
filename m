Return-Path: <lars@metafoo.de>
Message-ID: <5044668C.5050707@metafoo.de>
Date: Mon, 03 Sep 2012 10:13:00 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 drivers@analog.com
Subject: Re: [PATCH 19/22] staging:iio:ad7192: Use common Sigma Delta library
References: <1344616596-8026-1-git-send-email-lars@metafoo.de> <1344616596-8026-19-git-send-email-lars@metafoo.de> <503BA93E.5060205@kernel.org>
In-Reply-To: <503BA93E.5060205@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/27/2012 07:07 PM, Jonathan Cameron wrote:
> On 08/10/2012 05:36 PM, Lars-Peter Clausen wrote:
>> Convert the ad7192 driver to make use of the new common code for devices from
>> the Analog Devices Sigma Delta family.
> 
> Hi Lars-Peter.
> 
> Was just applying these to my togreg branch and ran a few build tests with sparse.
> issue in this and ad7793 came up.
> 
> drivers/staging/iio/adc/ad7793.c:91:21: warning: incorrect type in initializer (incompatible argument 2 (different
> signedness))
> drivers/staging/iio/adc/ad7793.c:91:21:    expected int ( *set_mode )( ... )
> drivers/staging/iio/adc/ad7793.c:91:21:    got int ( static [toplevel] *<noident> )( ... )
> 
> 
> Now this is because set_mode takes and integer argument here, but is defined to
> take an enum.
> 
> Why not just take the enum directly?
> 
> I'm guessing this is a left over from a cleanup that didn't
> quite get everywhere.  Will convert them over to the enum argument before
> pushing them out, but would like you to take a quick glance at them...
> 
> Change given inline below.
>>
>>[...]
>>  
>> -static int ad7192_read_reg(struct ad7192_state *st,
>> -			   unsigned reg, int *val, unsigned size)
> Change is here,
> 
> static int ad7793_set_mode(struct ad_sigma_delta *sd,
> 			   enum ad_sigma_delta_mode mode)

Yes, looks good, except for the part number ;) Both patch 18 (ad7793) and 19
(ad7192) have the same issue.

Thanks.

> 
>> +static int ad7192_set_mode(struct ad_sigma_delta *sd, unsigned int mode)
>>  {
>> -	return __ad7192_read_reg(st, 0, 0, reg, val, size);
>> -}
