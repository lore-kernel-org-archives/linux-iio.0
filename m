Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4DB7FEE8.3080004@analog.com>
Date: Wed, 27 Apr 2011 13:32:56 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Subject: Re: Oddities and how to handle them.
References: <4DB6EF2D.9090704@cam.ac.uk>
In-Reply-To: <4DB6EF2D.9090704@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On 04/26/2011 06:13 PM, Jonathan Cameron wrote:
> Hi Michael,
>
> I'm trying to squash the remaining drivers that don't build after
> all the changes in iio-onwards.  A couple of odd cases have come
> up.
>
> ad7291 - has two similar concurrent event measurements on the same temperature channel.
> One is almost a windowed average, but not quite. The other based on raw value.
> I'm not sure what event code we should generate for them to differentiate between
> them.  So for now I just have both producing a generic temperature threshold event.
> (filtering on data isn't covered by our abi's yet, let alone on event detectors!)
>
> ad7745 - slow capacitance adc.  This one actually makes a possibly valid use of the
> buffer event codes.  It is slow enough that it may make sense to notify userspace
> that a new reading is available (90Hz).  I'd prefer to see this happen by just allowing
> polling on the sysfs attributes though. I have no means to testing this one, and such
> a change is a little more invasive than I like to make without hardware!
>   
The /RDY interrupt in this driver should be a data available interrupt,
used by a buffer to trigger the readout.
Implementing it as an event is pointless.

> adt7310 - should be in hwmon as far as I can see.... + it's abusing our interfaces
> so I don't like it ;)  For now I've squashed the events into basic temp events.
> adt7410 - the same.
>
> adt7316 - The fault condition on the external temperature sensor isn't an event that
> one should ever see unless something is horribly wrong.  I'd be inclined to copy the
> hwmon interface for this and do it as an alarm sysfs attribute... I don't think it
> belongs in out main event path...  For now I've removed it's ability to be reported at all.
>
>   
Fixing these so that they build is fine for now.
There are a few more oddities with these drivers.
I have ordered hardware and there are some open tasks to test and
cleanup those drivers.
>  
> ade7758 - Complex driver I'm not that keen on touching without a lot of testing support.
> Don't suppose you want to take this one Michael? (*looks hopeful*)  At lease blugeoning
> it into more or less current interfaces would be a great help. I can do it, but then I
> suspect I'll break it in a few exciting ways :(
>   
I can fix building on this one. However I currently don't have enough
time to fix and document the API.
The buffer scan attribute naming is a bit complicated on this one. Do
you think we can stick with wform?
There is some interaction with the WAVEFORM MODE Register. Ideally we
have enable files for all possible waveform selection possibilities,
which are numerous, 3 sources (phases)  * 5 measurement options
(Current, Voltage, Active Power, Reactive Power and VA). Only one
combination can be enabled at a given time, since they are exclusive or.

Thoughts?
   
> So all in all, only ad7745 and ade7758 no longer build.
>
> Lots more clean up to be done all over the tree, but I think we are making good progress
> in the right direction.
>
> Jonathan
>   

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
