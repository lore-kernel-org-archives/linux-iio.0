Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38574 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbbAHTXE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 8 Jan 2015 14:23:04 -0500
Message-ID: <54AED914.5060108@kernel.org>
Date: Thu, 08 Jan 2015 19:23:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: IIO_LIGHT vs IIO_INTENSITY
References: <CAEnQRZAY82eKVK6B0-s1c1UWbZthML9gNvk2-+_hyb-VnTO-jw@mail.gmail.com>
In-Reply-To: <CAEnQRZAY82eKVK6B0-s1c1UWbZthML9gNvk2-+_hyb-VnTO-jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/01/15 15:19, Daniel Baluta wrote:
> Hi,
> 
> I'm not sure I understand the difference between
> IIO_LIGHT vs IIO_INTENSITY as seen by the IIO.
> 
> As far as i know:
> 
> * IIO_LIGHT channels are used to measure illuminance
>   [1] and the units after application of scale and offset
>   are lux.
> * IIO_INTENSITY channels are used to measure luminous
> intensity [2]? I guess that units after application of scale (?)
> are candela (although, not documented in the ABI file [3]).

Units are really tricky for this as it tends to be a measure of light
over a poorly specified frequency ranges.  Often these are not even
in the visible range (infrared typically).

Hence there isn't really a definition of what the units are.

It would have been very tempting to insist that all light sensors
only output the illuminance value and hide the real measurements,
but some (tsl2563 and family IIRC amongst others) have threshold
events based on the individual filtered light readings rather than
the computed illuminance.

> 
> Anyhow, reading the code for drivers with IIO_INTENSITY channels
> it is not very clear what is the unit for in_intensityY_input or
> in_intensityY_raw
> after application of scale.
> 
> e.g for isl29125 the unit is lux [4]
That's certainly novel given lux is only defined for a particular
spectrum of light.  Hmm. That is an RGB sensor making this
odd.  It's perfectly possible with calibrated colour sensors
to estimate the illuminance but it isn't invertible so I can't
really see how those can be in lux.  I suppose
it might be the case that using that scale and the magic
formula wikipedia gives, might give a resulting illuminance
measurement?  Certainly not what we'd normally think of for
scale though.

Anyone else have a better understanding of this area than I
can get from Wikipedia in 5 mins?

There is a note on on the isl29125 data sheet that may help us...

5. 565nm Green, 620nm Red LED, 485nm Blue in white LED is used
in production test. It’s irradiance is calibrated to produce
the same DATA count against an illuminance level of 130 lux
fluorescent light.

Clear as mud.  I guess that means they have a calibrated led
with those frequencies matched against a calibrated 130 lux
flourescent light?  Their scale is such that the colour
values match....

Jonathan
> 
> thanks,
> Daniel.
> 
> [1] http://en.wikipedia.org/wiki/Illuminance
> [2] http://en.wikipedia.org/wiki/Luminous_intensity
> [3] http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-bus-iio#L992
> [4] http://lxr.free-electrons.com/source/drivers/iio/light/isl29125.c#L122
> 
0
