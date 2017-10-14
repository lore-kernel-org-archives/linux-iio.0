Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-2.itc.rwth-aachen.de ([134.130.5.47]:8645 "EHLO
        mail-out-2.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750907AbdJNS1F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Oct 2017 14:27:05 -0400
From: Stefan Bruens <stefan.bruens@rwth-aachen.de>
To: Maciej Purski <m.purski@samsung.com>
CC: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [2/3] iio: adc: ina2xx: Adhere to documented ABI, use Ohm instead of uOhm
Date: Sat, 14 Oct 2017 20:27:01 +0200
Message-ID: <2075928.pSFUuclJ1z@pebbles.site>
In-Reply-To: <6144c719-5310-7358-bd57-f778ab481788@samsung.com>
References: <7ee955b2-a58f-45e0-985d-1f7508d41ae7@rwthex-w2-a.rwth-ad.de> <CGME20171009092944eucas1p18b2e66a4a07db309551a7e945c2611ec@eucas1p1.samsung.com> <6144c719-5310-7358-bd57-f778ab481788@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Montag, 9. Oktober 2017 11:29:43 CEST Maciej Purski wrote:
> On 10/01/2017 09:48 PM, Stefan Brüns wrote:
> > According to the ABI documentation, the shunt resistor value should be
> > specificied in Ohm. As this is also used/documented for the MAX9611,
> > use the same for the INA2xx driver.
> > 
> > This poses an ABI break for anyone actually altering the shunt value
> > through the sysfs interface, it does not alter the default value nor
> > a value set from the devicetree.
> > 
> > Minor change: Fix comment, 1mA is 10^-3A.
> 
> I have just a minor issue. There could be an inconsistency with units as in
> my patch I make current_lsb adjustable and I need it to be in uA (it used
> to be hardcoded as 1 mA so to achieve better precision we need smaller
> units). So in order to keep calibration register properly scaled, I convert
> uOhms to mOhms on each set_calibration(). So if both my changes and your
> changes were applied, on each shunt_resistore_store we would be performing
> multiplication by 10^6 and then in set_calibration() division by 10^3 which
> seems odd to me.
> 
> I guess we could keep it as shunt_resistor_ohms instead of
> shunt_resistor_uohm. We could avoid performing division on each
> shunt_resistor_show() and perform multiplication by 10^3 only once in
> set_calibration() on each
> shunt_resistore_store(). We could then change the default value and perform
> division only on probing, when reading the shunt_resistance from device
> tree.
> 
> There are many other options. It's not a major issue so maybe we could leave
> it as it is or you could suggest some changes in my patch.
 
Sorry it took me so long to answer ...

The current fixed current_lsb of 1mA is indeed a bad choice for everything but 
a shunt resistor value of 10mOhm, as it truncates the current value. So what 
is a *good* choice?

One important point is the current register is merely more than a convenience 
register. At least for the INA219/220, it provides nothing not achievable in 
software, and for the INA226 family it only has added value if the current is 
varying faster than the readout frequency and the averaging is used.

The precision of the current register is limited by the precision of the shunt 
voltage register, and may be reduced by the applied scaling/calibration 
factor.

The precision of the shunt voltage register is fixed at 10uV (INA219) resp. 
2.5uV (INA226). Changing conversion time (both) and PGA (219) affects the 
noise and offset, but the lsb value is still fixed.

If one wants to carry over the shunt voltage register precision into the 
current register, its important no (or hardly any) truncation happens. The 
terms therefor are given in the manual, formulas 8.5.1 (4) resp 7.5.1 (3):

INA219: current = shunt_voltage * cal_register / 4096
INA226: current = shunt_voltage * cal_register / 2048

So any cal value smaller than 4096 (2048) will introduce truncation errors, 
larger values may introduce overflows, if the full input range is used. Now, 
would it not be wise to always use 4096 (2048) for the calibration value?

The raw values from the IIO subsystem are meaningless without their 
accompanying scale factor. Instead of changing the calibration value, why not 
just change the reported scale factor?

More opinions are very welcome.

Kind regards,

Stefan

-- 
Stefan Brüns  /  Bergstraße 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
