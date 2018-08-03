Return-Path: <SRS0=7WRr=KS=gmail.com=dpfrey@kernel.org>
Subject: Re: Buffert trigger and Power management support for BME680 ?
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Himanshu Jha <himanshujha199640@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
 Daniel Baluta <daniel.baluta@gmail.com>, matt.ranostay@konsulko.com
References: <20180730121241.GA4362@himanshu-Vostro-3559>
 <20180730140746.0000337a@huawei.com>
From: David Frey <dpfrey@gmail.com>
Message-ID: <5b6c4b53-7141-93a5-b307-b7d91f8bea7f@gmail.com>
Date: Fri, 3 Aug 2018 09:14:27 -0700
MIME-Version: 1.0
In-Reply-To: <20180730140746.0000337a@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 7/30/2018 6:07 AM, Jonathan Cameron wrote:
> On Mon, 30 Jul 2018 17:42:41 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
>> Hi,
>>
>> The initial minimal driver has been recently merged[1] and irrespective
>> of the ending week of Google Summer of Code'18, I would like to extend this
>> driver and work on it.
>>
>> I have a few queries for the community:
>>
>> 1. Buffered Trigger Support:
>> ----------------------------
>>
>> Is it worth to add buffer support for this device ?
>> The device has 1Hz Forced mode which we need to enable everytime
>> we need a reading.
>>
>> Bosch provides[1] BSEC: Bosch Software Environmental Cluster binaries for
>> different platforms, and the software has various modes:
>>
>> 	* Ultra-low power mode.
>> 	* Ultra-low power mode.
>> 	* Continuous mode.
>>
>> According to datasheet "1.2 Gas sensor specification"
>>
>> Response time		Continuous mode		0.75s
>>
>> Now, these details are worth noting and confusing at the same to me!
>> Since, we only have 1Hz mode, so would it be a problem when adding this
>> interface to get continuous measurements ?
>> What other factors/caveats should I look for before proceeding further ?
> 
> Technically there is no problem with adding buffered mode, but there may
> be no real usecases at these very low rates.
> 
> The main convenience is that you could read out the various channels in one
> pass (I think - haven't checked the datasheet).

I think that buffered mode is essential because it will allow TPHG to be 
done all at once.  If you measure TPHG with the current driver, you are 
doing 4 measurements.  This is bad because it takes longer, uses more 
power, the values all have slightly different timestamps.


>> 2. Power Management:
>> -------------------
>>
>> 3.1 Sensor modes
>>
>> 	Forced mode:
>> 		* Single TPHG cycle is performed
>> 		* Sensor *automatically* returns to sleep mode afterwards
>> 		* Gas sensor heater only operates during gas measurement
>> 	Sleep mode:
>> 		* No measurements are performed
>> 		* Minimal power consumption
>>
>> So, in my opinion this device is already power managed.
>> Comments ?
> 
> It seems like there is little purpose in sleep mode, are there power
> numbers to indicate what 'minimal' means here?

 From the datasheet on page 3:
   Current consumption
     2.1 μA at 1 Hz humidity and temperature
     3.1 μA at 1 Hz pressure and temperature
     3.7 μA at 1 Hz humidity, pressure and temperature
     0.09‒12 mA for p/h/T/gas depending on operation mode
     0.15 μA in sleep mode

My interpretation of this is that you will consume 2.1 μA on average if 
you are reading the humidity and temperature once per second.  The 
datasheet goes into some more detail in Table 2 on page 8 where it 
describes the average supply current of the gas sensor as follows:
   Ultra-low power mode 0.09 ma with response time of 92 s
   Low power mode 0.9 mA with a response time of 1.4 s
   Continuous mode 12 mA with a response time of 0.75 s

I don't think there are actually different modes at all.  I believe what 
they call modes are just different settings corresponding to enum values 
in the BSEC library.  Maybe I'm wrong though.  Please correct me if you 
see any evidence of explicit mode settings.  I'm also skeptical of the 
current consumption numbers.  It seems weird to me that continuous mode 
consumes > 10x the current of low power mode and only produces roughly 
twice as many readings.

It's nice to see this driver progressing.  Keep up the good work!
