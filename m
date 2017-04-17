Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx-out-2.rwth-aachen.de ([134.130.5.187]:21215 "EHLO
        mx-out-2.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756879AbdDQWIz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Apr 2017 18:08:55 -0400
From: Stefan Bruens <stefan.bruens@rwth-aachen.de>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>
Subject: Re: [PATCH 2/2] iio: adc: Allow setting Shunt Voltage PGA gain and Bus Voltage range
Date: Tue, 18 Apr 2017 00:08:52 +0200
Message-ID: <8597867.ugCcYUdi7l@pebbles.site>
In-Reply-To: <9c003dd5-d3f9-0652-4f89-fe259ba5f8ea@kernel.org>
References: <20170412030140.9328-1-stefan.bruens@rwth-aachen.de> <81f81a0af7dd420db51f97d9be4dcbad@rwthex-w2-b.rwth-ad.de> <9c003dd5-d3f9-0652-4f89-fe259ba5f8ea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Freitag, 14. April 2017 17:12:03 CEST Jonathan Cameron wrote:
> On 12/04/17 04:01, Stefan Brüns wrote:
> > Reducing shunt and bus voltage range improves the accuracy, so allow
> > altering the default settings.
> > 
> > Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> 
> Hi Stefan,
> 
> There is new userspace ABI in here, so starting point is to document that.
> 
> That would allow the discussion of whether it is the right ABI to begin.
> 
> In particular can one of these at least be rolled into the standard
> scale attributes that are already supported by the driver?
> It looks to me like they both probably can - perhaps in conjunction with
> use of the _available callback to notify userspace the range available from
> _raw thus allowing easy computation of the range you are providing.
> 
> Keeping new ABI to a minimum makes life a lot easier for userspace tooling!
> 
> I particularly love the way it's described in the datasheet as a gain
> for the shunt voltage but a range for the bus voltage - despite being the
> same PGA (at least in the symbolic representation).

Unfortunately, correct use of raw and scale is somewhat underdocumented. I 
would expect the raw values to reflect the value read from the device, 
unaltered.

For the INA226, all value registers are 16 bit, while for the INA219 the 
voltage register is 13bit (msb aligned, lowest 3 bits from the register are 
masked), the other 3 registers are 16 bit as well.

The INA219 incorporates the bus range and shunt voltage gain in the register 
value, i.e. the shunt voltage value 0x0100 always corresponds to 256 * 10uV, 
irrespective of the PGA setting.

I think its a bad idea to incorporate the gain settings into the scale 
attribute:
1. Raw values would no longer be raw values
2. Scale for the INA219 would be settable, but readonly for the INA226
3. If the device has a gain setting, it should be exposed as such, and names 
should correspond to the datasheet
4. Any user of the gain settings had to be made aware of the possibility to 
change it, no matter how it is exposed. Making it part of the scale, and thus 
changing the meaning of the raw values, would be breaking the existing ABI.

Kind regards,

Stefan

-- 
Stefan Brüns  /  Bergstraße 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
work: +49 2405 49936-424
