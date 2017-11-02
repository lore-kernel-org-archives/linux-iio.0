Return-Path: <SRS0=u5uj=CA=samsung.com=m.purski@kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
From: Maciej Purski <m.purski@samsung.com>
Subject: Re: [2/3] iio: adc: ina2xx: Adhere to documented ABI, use Ohm
 instead of uOhm
To: Stefan Bruens <stefan.bruens@rwth-aachen.de>
Cc: linux-iio@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, Javier
	Martinez Canillas <javier@osg.samsung.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack
	<knaack.h@gmx.de>
Message-id: <678f7605-3fc8-cc28-cb16-45381d75bad7@samsung.com>
Date: Thu, 02 Nov 2017 10:04:01 +0100
In-reply-to: <2075928.pSFUuclJ1z@pebbles.site>
References: <7ee955b2-a58f-45e0-985d-1f7508d41ae7@rwthex-w2-a.rwth-ad.de>
	<CGME20171009092944eucas1p18b2e66a4a07db309551a7e945c2611ec@eucas1p1.samsung.com>
	<6144c719-5310-7358-bd57-f778ab481788@samsung.com>
	<2075928.pSFUuclJ1z@pebbles.site>
List-ID: <linux-iio@vger.kernel.org>



On 10/14/2017 08:27 PM, Stefan Bruens wrote:
> On Montag, 9. Oktober 2017 11:29:43 CEST Maciej Purski wrote:
>> On 10/01/2017 09:48 PM, Stefan Brüns wrote:
>>> According to the ABI documentation, the shunt resistor value should be
>>> specificied in Ohm. As this is also used/documented for the MAX9611,
>>> use the same for the INA2xx driver.
>>>
>>> This poses an ABI break for anyone actually altering the shunt value
>>> through the sysfs interface, it does not alter the default value nor
>>> a value set from the devicetree.
>>>
>>> Minor change: Fix comment, 1mA is 10^-3A.
>>
>> I have just a minor issue. There could be an inconsistency with units as in
>> my patch I make current_lsb adjustable and I need it to be in uA (it used
>> to be hardcoded as 1 mA so to achieve better precision we need smaller
>> units). So in order to keep calibration register properly scaled, I convert
>> uOhms to mOhms on each set_calibration(). So if both my changes and your
>> changes were applied, on each shunt_resistore_store we would be performing
>> multiplication by 10^6 and then in set_calibration() division by 10^3 which
>> seems odd to me.
>>
>> I guess we could keep it as shunt_resistor_ohms instead of
>> shunt_resistor_uohm. We could avoid performing division on each
>> shunt_resistor_show() and perform multiplication by 10^3 only once in
>> set_calibration() on each
>> shunt_resistore_store(). We could then change the default value and perform
>> division only on probing, when reading the shunt_resistance from device
>> tree.
>>
>> There are many other options. It's not a major issue so maybe we could leave
>> it as it is or you could suggest some changes in my patch.
>   
> Sorry it took me so long to answer ...
> 
> The current fixed current_lsb of 1mA is indeed a bad choice for everything but
> a shunt resistor value of 10mOhm, as it truncates the current value. So what
> is a *good* choice?
> 
> One important point is the current register is merely more than a convenience
> register. At least for the INA219/220, it provides nothing not achievable in
> software, and for the INA226 family it only has added value if the current is
> varying faster than the readout frequency and the averaging is used.
> 
> The precision of the current register is limited by the precision of the shunt
> voltage register, and may be reduced by the applied scaling/calibration
> factor.
> 
> The precision of the shunt voltage register is fixed at 10uV (INA219) resp.
> 2.5uV (INA226). Changing conversion time (both) and PGA (219) affects the
> noise and offset, but the lsb value is still fixed.
> 
> If one wants to carry over the shunt voltage register precision into the
> current register, its important no (or hardly any) truncation happens. The
> terms therefor are given in the manual, formulas 8.5.1 (4) resp 7.5.1 (3):
> 
> INA219: current = shunt_voltage * cal_register / 4096
> INA226: current = shunt_voltage * cal_register / 2048
> 
> So any cal value smaller than 4096 (2048) will introduce truncation errors,
> larger values may introduce overflows, if the full input range is used. Now,
> would it not be wise to always use 4096 (2048) for the calibration value?
> 
> The raw values from the IIO subsystem are meaningless without their
> accompanying scale factor. Instead of changing the calibration value, why not
> just change the reported scale factor?
> 
> More opinions are very welcome.
> 
> Kind regards,
> 
> Stefan
> 

Thanks for the reply.

I agree that cal_register set to 4096 (2048) allows us to eliminate truncaction 
error. However according to your suggestion, if we made cal_reg a fixed value, 
then current_lsb and r_shunt should be also a fixed value, as they are related 
according to formula 8.5 (1)

cal_register = 0.00512 / (current_lsb * r_shunt)

Therefore, changing the scale value wouldn't affect the calib_reg value, so it 
wouldn't give the user any information on the actual current_lsb of the device.
The real value is calculated like this by the user:

processed_value = raw_value * scale

I think that even after changing the scale value processed_value is expected to 
be approximately the same.

Maybe I'm wrong or I didn't precisely understand what you have suggested. I hope
that someone will also comment on that.

Best regards,

Maciej
