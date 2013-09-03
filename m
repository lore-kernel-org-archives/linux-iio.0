Return-Path: <Jon.Brenner@ams.com>
From: Jon Brenner <Jon.Brenner@ams.com>
To: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>
Date: Tue, 3 Sep 2013 06:23:01 +0200
Subject: RE: [PATCH 1/2] iio: add INT_TIME (integration time) channel info
 attribute
Message-ID: <3C879D35B299F147B1DEDFBEE12F2E06012DAACE3E@SUX2182.office.amsiag.com>
References: <1376830828-2496-1-git-send-email-pmeerw@pmeerw.net>
 <521138C4.5050904@kernel.org>
 <alpine.DEB.2.01.1308182319000.4146@pmeerw.net>,<52238876.4030308@kernel.org>
In-Reply-To: <52238876.4030308@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan, et al.,
Sorry guys - I've been completely snowed under.
I have some thoughts but no time to annunciate.
What I do have is confidence in all of you to do the right thing.  I'll cat=
ch up later.
Relationships between integration time and gain can be tricky due to other =
external factors (aperture, glass density, inking, etc.) and need to be bal=
anced accordingly. =20
Throw in some filtering (ie persistence) and offset calibrations and you ha=
ve a sticky wicket.
Fortunately, most of these devices provide the ability to set parameters in=
dependently.  It's a blessing and it's a curse. =20
I will be immersed in a wicked project for the next several weeks, after wh=
ich I expect to come back on-line with some really cool devices coming to I=
IO.

BR
Jon

________________________________________
From: Jonathan Cameron [jic23@kernel.org]
Sent: Sunday, September 01, 2013 8:33 PM
To: Peter Meerwald
Cc: linux-iio@vger.kernel.org; Jon Brenner; Lars-Peter Clausen
Subject: Re: [PATCH 1/2] iio: add INT_TIME (integration time) channel info =
attribute

On 08/18/13 22:30, Peter Meerwald wrote:
> Hello,
>
>>> integration time is in seconds; it controls the measurement
>>> time and influences the gain of a sensor
>>>
>>> used by adjd_s311, tsl4531
>>> the following drivers have similar controls:
>>> * tsl2563 (integration time is controlled via CALIBSCALE among other th=
ings)
>>> * tsl2583 (has integration_time device_attr, but driver doesn't use cha=
nnels yet)
>>> * tsl2x7x (has integration_time attr)
>
>> I know this has come up before (and I'm not actually expressing opositio=
n
>> to this going into info_mask) but could you sumarise the arguments for w=
hy
>> this property cannot be covered by calibscale or scale?
>> I'd like to have a little stronger argument for the patch description in=
 Git.
>
> sounds good; I'd add:
>
>> There are two typical ways that scaling is implemented in a device:
>> 1) input amplifier
>> 2) reference to the ADC is changed.
>> These both result in the accuracy of the ADC varying (by applying it's
>> sampling over ta more relevant range).
>>
>> Integration time is a way of dealing with noise inherent in the analog
>> sensor itself.  In this case a mixture of Photon noise and device specif=
ic
>> noise.  Photon noise is dealt with by either improving the efficiency of
>> the sensor, (more photons actually captured) which is not easily varied =
dynamically,
>> or by integrating the measurement over a longer time period.  Note that =
this
>> can also be thought of as an averaging of a number of individual samples
>> and is infact sometimes implemented this way.
>
> altering integration time implies that the duration of a
> measurement changes and the user of the device may be interested
>
>> Hence it makes sense to distinguish between integration time and simple
>> scale. In some devices both types of control are present and whilst they
>> will have similar effects on the amplitude of the reading, their effect
>> on the noise on the measurements will differ considerably.
>
> integration time may or may not have an impact on the range of values
> measured
>
> both characteristics cannot be expressed with scale/calibscale in a
> satisfying way
>
> let's see if further comments come up, and I'll repost
Not much come out of the wood work so something like what you propose will =
do nicely!

I would also like a short description in the documentation file so we don't=
 have
to keep refering people back to the original patch.

Jon, you still out there?  Not heard anything from you for a while and your=
 input
on this sort of thing is always valued!

Jonathan
>
> please note that there is a fix for the adjd_s311 driver posted which you
> may want to fast-feed to Greg
>
> thanks, regards, p.
>=
