Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:45485 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751200AbdGPWIg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jul 2017 18:08:36 -0400
From: Stefan Bruens <stefan.bruens@rwth-aachen.de>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>
Subject: Re: [PATCH 2/2] iio: adc: Allow setting Shunt Voltage PGA gain and Bus Voltage range
Date: Mon, 17 Jul 2017 00:08:32 +0200
Message-ID: <4260957.ARbqtWlM7H@pebbles.site>
In-Reply-To: <5b4eb76f-494d-138e-ec72-1fe7bbd20403@kernel.org>
References: <20170412030140.9328-1-stefan.bruens@rwth-aachen.de> <9342701.uSTzCLhmiO@pebbles.site> <5b4eb76f-494d-138e-ec72-1fe7bbd20403@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sonntag, 30. April 2017 18:19:39 CEST Jonathan Cameron wrote:
> On 29/04/17 21:37, Stefan Bruens wrote:
> > On Mittwoch, 26. April 2017 08:59:47 CEST Jonathan Cameron wrote:
> >> On 26/04/17 07:19, Jonathan Cameron wrote:
> >>> On 17/04/17 23:08, Stefan Bruens wrote:
> >>>> On Freitag, 14. April 2017 17:12:03 CEST Jonathan Cameron wrote:
> > [...]
> > 
> >>>> 4. Any user of the gain settings had to be made aware of the
> >>>> possibility
> >>>> to
> >>>> change it, no matter how it is exposed. Making it part of the scale,
> >>>> and
> >>>> thus changing the meaning of the raw values, would be breaking the
> >>>> existing ABI.>
> >>> 
> >>> The raw values should indeed not change.  That was a missunderstanding
> >>> on
> >>> my part.  Usually when a device has a PGA it is not compensated for in
> >>> the output. So normally it's up to the driver to 'apply' the effective
> >>> gain to the incoming reading.  When that isn't the case, it can be
> >>> considered some sort of internal trim - hence the use of calibscale for
> >>> this case.
> >> 
> >> Mulling this over, calibscale might not work either in this case. The
> >> datasheet helpfully sometimes uses ranges and sometimes uses scale
> >> factors.
> >> There is also obviously the calibration register kicking around which
> >> would
> >> also be handled with calibscale if exposed to userspace (currently it
> >> isn't)
> >> 
> >> I'm out of time tonight so will think it bit more about this and get back
> >> to you in the next few days...
> > 
> > hardwaregain may be a viable option. For the shunt voltage, available
> > values would be [0.125, 0.25, 0.5, 1.0], for the bus range we would have
> > either [0.5, 1.0] or [1.0, 2.0] for bus ranges [32V, 16V].
> > 
> > Does hardwaregain have the right semantics for shunt voltage gain and/or
> > bus range?
> 
> Description we currently have in
> Documentation/ABI/testing/sysfs-bus-iio is:
> 		Hardware applied gain factor. If shared across all channels,
> 		<type>_hardwaregain is used.
> 
> Just thinking about the use cases, it is mostly used for cases where the
> gain is not of the measurement being acquired, but rather of something
> related (like the gain on time of flight sensors or pulse counters).
> 
> It also gets used for output devices and amplifiers though so kind of
> similar as in those cases we felt calibrationscale was a bit of a stretch!
> 
> So yes, I can see that working.  Whether it is a better choice than
> simply allowing the range attributes (documented for this narrow
> case to say they should only be used when the range is independent of
> the scale) is an open question.  Given we have always preferred scales
> to ranges if you think you can make hardwaregain fit well then lets
> go with that, perhaps updating the docs to make this usecase explicit.
> 
> Looking back at the original emails we were actually thinking of
> transistioning calibscale to hardwaregain in general as it covered
> describing both uses, but it never happened...

Hi John,

as all other patches for INA2xx went into or on their way into mainline, its 
time to revisit the INA219/220 bus range and shunt voltage gain again.

TLDR: Using HARDWAREGAIN fits existing uses/semantics.

I had a look at current users of IIO_CHAN_INFO_HARDWAREGAIN:

amplifiers/ad8366.c: Variable gain amplifier without ADC or DAC, so no SCALE 
attribute

light/vl6180.c: ToF sensor with ambient light sensor. The ALS sensor has two 
settings affecting the RAW sensor readout, HARDWAREGAIN and INTegration_TIME. 
Baseline settings are gain=1 and integration time=0.1(seconds), with a 
corresponding raw reading of 1 ^= 0.32 lux.
The SCALE value is correct for the baseline setting, but although modifying 
HARDWAREGAIN and/or INT_TIME affects the RAW readout, this is not reflected in 
the SCALE attribute, i.e. to get the correct physical value, one has to use:
Light[lux] = raw_value * SCALE * (0.1s/INT_TIME) / HARDWAREGAIN

light/adjd_s311.c: HARDWAREGAIN affects the RAW readout, but as there is no 
given fixed relationship between RAW values and irradiance, there is no SCALE 
attribute.

adc/stx104.c: The ADC has a software controllable HARDWAREGAIN and a hardware 
controlled (jumper) offset and single ended/differential setting with software 
readback. HARDWAREGAIN and offset/differential are reflected in the SCALE and 
OFFSET attributes, i.e. the physical value can be determined by:
U[V] = (raw_value * SCALE) + OFFSET

So we have two users of HARDWAREGAIN with contradicting behaviour regarding 
SCALE. IMHO, the stx104 behaviour is the correct one.

For the INA2xx, neither INT_TIME nor AVERAGE affect the RAW <-> physical value 
relationship, i.e. the SCALE is fixed. The same is true for the INA219/220 bus 
range/shunt voltage gain. So using HARDWAREGAIN for both shunt voltage gain 
and bus voltage range does match existing semantics.

Kind regards,

Stefan

-- 
Stefan Brüns  /  Bergstraße 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
