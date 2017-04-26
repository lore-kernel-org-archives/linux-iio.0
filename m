Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58352 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948447AbdDZGTr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 02:19:47 -0400
Subject: Re: [PATCH 2/2] iio: adc: Allow setting Shunt Voltage PGA gain and
 Bus Voltage range
To: Stefan Bruens <stefan.bruens@rwth-aachen.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>
References: <20170412030140.9328-1-stefan.bruens@rwth-aachen.de>
 <81f81a0af7dd420db51f97d9be4dcbad@rwthex-w2-b.rwth-ad.de>
 <9c003dd5-d3f9-0652-4f89-fe259ba5f8ea@kernel.org>
 <8597867.ugCcYUdi7l@pebbles.site>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c94eddda-9d22-2f9a-a31d-9c7ae5e58440@kernel.org>
Date: Wed, 26 Apr 2017 07:19:41 +0100
MIME-Version: 1.0
In-Reply-To: <8597867.ugCcYUdi7l@pebbles.site>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/04/17 23:08, Stefan Bruens wrote:
> On Freitag, 14. April 2017 17:12:03 CEST Jonathan Cameron wrote:
>> On 12/04/17 04:01, Stefan Brüns wrote:
>>> Reducing shunt and bus voltage range improves the accuracy, so allow
>>> altering the default settings.
>>>
>>> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
>>
>> Hi Stefan,
>>
>> There is new userspace ABI in here, so starting point is to document that.
>>
>> That would allow the discussion of whether it is the right ABI to begin.
>>
>> In particular can one of these at least be rolled into the standard
>> scale attributes that are already supported by the driver?
>> It looks to me like they both probably can - perhaps in conjunction with
>> use of the _available callback to notify userspace the range available from
>> _raw thus allowing easy computation of the range you are providing.
>>
>> Keeping new ABI to a minimum makes life a lot easier for userspace tooling!
>>
>> I particularly love the way it's described in the datasheet as a gain
>> for the shunt voltage but a range for the bus voltage - despite being the
>> same PGA (at least in the symbolic representation).
> 
> Unfortunately, correct use of raw and scale is somewhat underdocumented. I 
> would expect the raw values to reflect the value read from the device, 
> unaltered.
The raw value will indeed give you that.  The _available callbacks provide
the range of a particular value.  They are rather undocumented though and
rather new which is indeed less than ideal.

Correct use of raw and scale themselves is pretty well covered by the ABI
docs.
Documentation/ABI/testing/sysfs-bus-iio*

> 
> For the INA226, all value registers are 16 bit, while for the INA219 the 
> voltage register is 13bit (msb aligned, lowest 3 bits from the register are 
> masked), the other 3 registers are 16 bit as well.
> 
> The INA219 incorporates the bus range and shunt voltage gain in the register 
> value, i.e. the shunt voltage value 0x0100 always corresponds to 256 * 10uV, 
> irrespective of the PGA setting.
Ah. I hadn't realised that.  In that case the standard approach for this
is to use calibscale which reflects changes that are within the hardware
but not in the resulting _raw values (i.e. devices that apply the scale
internally only)
> 
> I think its a bad idea to incorporate the gain settings into the scale 
> attribute:
> 1. Raw values would no longer be raw values
I think this one is me being unclear in my original response.
> 2. Scale for the INA219 would be settable, but readonly for the INA226
That's not really a problem...

> 3. If the device has a gain setting, it should be exposed as such, and names 
> should correspond to the datasheet
Not necessarily. The aim here is to produce a single unified (and normally
minimal) ABI for all devices.  If a particular datasheet takes one particular
naming they user should not be obliged to get out said datasheet to find
out what it means.  Some of the early parts we supported did everything in
terms of scaling in the datasheets. They got in first and so we are stuck
with that ABI if we can possibly use it.
> 4. Any user of the gain settings had to be made aware of the possibility to 
> change it, no matter how it is exposed. Making it part of the scale, and thus 
> changing the meaning of the raw values, would be breaking the existing ABI.
The raw values should indeed not change.  That was a missunderstanding on my
part.  Usually when a device has a PGA it is not compensated for in the
output. So normally it's up to the driver to 'apply' the effective gain to
the incoming reading.  When that isn't the case, it can be considered some
sort of internal trim - hence the use of calibscale for this case.

Sorry for the delay in replying, I'm travelling at the moment and reviewing
with jet lag isn't much fun!

Thanks,

Jonathan
> 
> Kind regards,
> 
> Stefan
> 

