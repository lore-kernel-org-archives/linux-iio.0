Return-Path: <groeck@ericsson.com>
Date: Thu, 28 Apr 2011 06:49:43 -0700
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "michael.hennerich@analog.com" <michael.hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>,
        Drivers <Drivers@analog.com>, Jean Delvare <khali@linux-fr.org>
Subject: Re: Oddities and how to handle them.
Message-ID: <20110428134943.GA27682@ericsson.com>
References: <4DB6EF2D.9090704@cam.ac.uk>
 <4DB7FEE8.3080004@analog.com>
 <4DB82B5C.5070900@cam.ac.uk>
 <544AC56F16B56944AEC3BD4E3D5917713AAEE15859@LIMKCMBX1.ad.analog.com>
 <4DB8322A.6050207@cam.ac.uk>
 <544AC56F16B56944AEC3BD4E3D5917713AAEE15A62@LIMKCMBX1.ad.analog.com>
 <4DB933E3.8070803@cam.ac.uk>
 <4DB93B9A.6050500@analog.com>
 <4DB93F1D.2090908@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4DB93F1D.2090908@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 28, 2011 at 06:19:09AM -0400, Jonathan Cameron wrote:
> On 04/28/11 11:04, Michael Hennerich wrote:
> > On 04/28/2011 11:31 AM, Jonathan Cameron wrote:
> >> Guenter / Jean - cc'd you two because we have an sysfs interface naming question for
> >> AC sensors that touches on the edge of hwmon.
> >>
> >>   
> >>>>>>>> Hi Michael,
> >>>>>>>>
> >>>>>>>> ade7758 - Complex driver I'm not that keen on touching without a lot
> >>>>>>>> of testing support. Don't suppose you want to take this one Michael?
> >>>>>>>> (*looks hopeful*) At lease blugeoning it into more or less current
> >>>>>>>> interfaces would be a great help. I can do it, but then I suspect
> >>>>>>>> I'll break it in a few exciting ways :(
> >>>>>>>>
> >>>>>>>>               
> >>>>>>> I can fix building on this one. However I currently don't have
> >>>>>>> enough time to fix and document the API.
> >>>>>>>             
> >>>>>> That's fine.  We won't be pushing any of the energy meter drivers out
> >>>>>> of staging for a while yet anyway!
> >>>>>>           
> >>>>>>> The buffer scan attribute naming is a bit complicated on this one.
> >>>>>>> Do you think we can stick with wform?
> >>>>>>> There is some interaction with the WAVEFORM MODE Register. Ideally
> >>>>>>> we have enable files for all possible waveform selection
> >>>>>>> possibilities, which are numerous, 3 sources (phases)  * 5
> >>>>>>> measurement options (Current, Voltage, Active Power, Reactive
> >>>>>>> Power and VA). Only one combination can be enabled at a given
> >>>>>>> time, since they are exclusive
> >>>>>>>             
> >>>>>> or.
> >>>>>>           
> >>> Hi Jonathan,
> >>>
> >>> For the metering parts I think we need to define a few more channel types.
> >>>
> >>> How about this ones
> >>>
> >>> inSX            S is the apparent power.
> >>> inPX            P is the active power.
> >>> inQX            Q is the reactive power.
> >>> inVX            V is the voltage. (only inX ?)
> >>> inVRMSX VRMS is the quadratic mean voltage.
> >>>     
> >> Call it 'root mean square' rather than quadratic in the docs. They have different
> >> meanings in English.
> >>   
> >>> inIX            I is the current.
> >>>     
> >> currX as per hwmon?  They also define a power attribute, but only 1 (as DC
> >> I guess). Cc'd Guenter and Jean to see if we can / want to share an interface...
> >>   
> > Honestly I don't like 'curr' - In my opinion we should use SI until
> > symbols (as well as standardized derived SI units where applicable).
> > In this particular case current is a SI unit.
> > For everything further we should use symbols commonly used in
> > Anglo-American EE and Physics literature. (NIST, IEEE, ...)
> Agreed, but it's an interface that is in place so best to match where
> we can. That way far fewer argument lie (we can always blame someone
> else :)

hwmon only uses inX for voltages. As such, usage of currX would only make sense
if you also use powerX for power, energyX for energy and so on.

> >  
> >> Guenter/ Jean, do you think hwmon will ever handle AC sensors? Maybe we want to be
> >> well clear of your interfaces just to avoid confusion? Or define a new set of shared
> >> names for the above that we will both use (when it becomes relevant?)
> >>   
Depends if this would be for hardware monitoring purposes, which seems to be unlikely.

If it were, any ABI extensions or driver-specific attributes would presumably be based
on the existing hwmon ABI.

Guenter
