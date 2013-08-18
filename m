Return-Path: <pmeerw@pmeerw.net>
Date: Sun, 18 Aug 2013 23:30:19 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, Jon Brenner <jon.brenner@ams.com>,
    Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] iio: add INT_TIME (integration time) channel info
 attribute
In-Reply-To: <521138C4.5050904@kernel.org>
Message-ID: <alpine.DEB.2.01.1308182319000.4146@pmeerw.net>
References: <1376830828-2496-1-git-send-email-pmeerw@pmeerw.net> <521138C4.5050904@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

> > integration time is in seconds; it controls the measurement
> > time and influences the gain of a sensor
> > 
> > used by adjd_s311, tsl4531
> > the following drivers have similar controls:
> > * tsl2563 (integration time is controlled via CALIBSCALE among other things)
> > * tsl2583 (has integration_time device_attr, but driver doesn't use channels yet)
> > * tsl2x7x (has integration_time attr)

> I know this has come up before (and I'm not actually expressing oposition
> to this going into info_mask) but could you sumarise the arguments for why
> this property cannot be covered by calibscale or scale?
> I'd like to have a little stronger argument for the patch description in Git.

sounds good; I'd add:

> There are two typical ways that scaling is implemented in a device:
> 1) input amplifier
> 2) reference to the ADC is changed.
> These both result in the accuracy of the ADC varying (by applying it's
> sampling over ta more relevant range).
> 
> Integration time is a way of dealing with noise inherent in the analog
> sensor itself.  In this case a mixture of Photon noise and device specific
> noise.  Photon noise is dealt with by either improving the efficiency of
> the sensor, (more photons actually captured) which is not easily varied dynamically,
> or by integrating the measurement over a longer time period.  Note that this
> can also be thought of as an averaging of a number of individual samples
> and is infact sometimes implemented this way.

altering integration time implies that the duration of a 
measurement changes and the user of the device may be interested
 
> Hence it makes sense to distinguish between integration time and simple
> scale. In some devices both types of control are present and whilst they
> will have similar effects on the amplitude of the reading, their effect
> on the noise on the measurements will differ considerably.

integration time may or may not have an impact on the range of values
measured

both characteristics cannot be expressed with scale/calibscale in a 
satisfying way

let's see if further comments come up, and I'll repost

please note that there is a fix for the adjd_s311 driver posted which you 
may want to fast-feed to Greg

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
