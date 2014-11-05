Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43514 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982AbaKEPz1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 10:55:27 -0500
Message-ID: <545A486E.9050307@kernel.org>
Date: Wed, 05 Nov 2014 15:55:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Vlad Dogaru <vlad.dogaru@intel.com>
CC: IIO <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/3]iio:pressure:bmp280: cleanup
References: <5452E495.2020705@gmx.de> <20141031114416.GB24473@vdogaru> <5453D83D.3060405@gmx.de>
In-Reply-To: <5453D83D.3060405@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/10/14 18:43, Hartmut Knaack wrote:
> Vlad Dogaru schrieb am 31.10.2014 12:44:
>> On Fri, Oct 31, 2014 at 02:23:33AM +0100, Hartmut Knaack wrote:
>>> The calculations for temperature and pressure compensation were already slightly
>>> optimized in comparison to the data sheet. So, it makes sense to optimize even a
>>> bit more, making proper use of C operators:
>>>   - variable t in bmp280_compensate_temp() can be eliminated by directly
>>>     returning the result of the relevant equation.
>>>   - make use of the += operator, eliminate an unnecessary parenthesis level and
>>>     directly return the result of the last equation in
>>>     bmp280_compensate_press().
>>> When the initialization of the ctrl_meas register fails, the error message will
>>> now mention the right register name.
>>> During probe, i2c_set_clientdata() is called, although it is not necessary. Drop
>>> it.
>>>
>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>>> ---
>>> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
>>> index 75038da..4f6ae4d 100644
>>> --- a/drivers/iio/pressure/bmp280.c
>>> +++ b/drivers/iio/pressure/bmp280.c
>>> @@ -200,7 +200,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
>>>  				  struct bmp280_comp_temp *comp,
>>>  				  s32 adc_temp)
>>>  {
>>> -	s32 var1, var2, t;
>>> +	s32 var1, var2;
>>>  
>>>  	var1 = (((adc_temp >> 3) - ((s32) comp->dig_t1 << 1)) *
>>>  		((s32) comp->dig_t2)) >> 11;
>>> @@ -209,9 +209,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
>>>  		((s32) comp->dig_t3)) >> 14;
>>>  
>>>  	data->t_fine = var1 + var2;
>>> -	t = (data->t_fine * 5 + 128) >> 8;
>>> -
>>> -	return t;
>>> +	return (data->t_fine * 5 + 128) >> 8;
>>
>> Shouldn't the compiler take care of this?
> That would be preferable. I just don't see the real benefit in having the extra step of storing the result (and taking care of an extra variable) before returning it. And I am aware, that this calculation is derived from the one in the data sheet (which looks a bit questionable to me with its unnecessary parenthesis and variable). But since you already started optimizing, it seemed legitimate to consolidate it even a bit more.


I'm with Hartmut on this, no point in having more actual code / local variables than
needed...  Just a few more lines of code for no gain :)
>>
>>>  }
>>>  
>>>  /*
>>> @@ -229,11 +227,11 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
>>>  
>>>  	var1 = ((s64) data->t_fine) - 128000;
>>>  	var2 = var1 * var1 * (s64) comp->dig_p6;
>>> -	var2 = var2 + ((var1 * (s64) comp->dig_p5) << 17);
>>> -	var2 = var2 + (((s64) comp->dig_p4) << 35);
>>> +	var2 += ((var1 * (s64) comp->dig_p5) << 17);
>>> +	var2 += (((s64) comp->dig_p4) << 35);
>>>  	var1 = ((var1 * var1 * (s64) comp->dig_p3) >> 8) +
>>>  		((var1 * (s64) comp->dig_p2) << 12);
>>> -	var1 = (((((s64) 1) << 47) + var1)) * ((s64) comp->dig_p1) >> 33;
>>> +	var1 = ((((s64) 1) << 47) + var1) * ((s64) comp->dig_p1) >> 33;
>>>  
>>>  	if (var1 == 0)
>>>  		return 0;
>>> @@ -242,9 +240,7 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
>>>  	p = div64_s64(p, var1);
>>>  	var1 = (((s64) comp->dig_p9) * (p >> 13) * (p >> 13)) >> 25;
>>>  	var2 = (((s64) comp->dig_p8) * p) >> 19;
>>> -	p = ((p + var1 + var2) >> 8) + (((s64) comp->dig_p7) << 4);
>>> -
>>> -	return (u32) p;
>>> +	return (u32)((p + var1 + var2) >> 8) + (((s64) comp->dig_p7) << 4);
>>
>> And this?
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
