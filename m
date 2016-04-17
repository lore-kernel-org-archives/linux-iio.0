Return-Path: <afd@ti.com>
Subject: Re: Question about differential muxing
To: Jonathan Cameron <jic23@kernel.org>
References: <5711362A.1020700@ti.com> <57123BA0.4070501@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <5713D9A7.4060106@ti.com>
Date: Sun, 17 Apr 2016 13:44:55 -0500
MIME-Version: 1.0
In-Reply-To: <57123BA0.4070501@kernel.org>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 04/16/2016 08:18 AM, Jonathan Cameron wrote:
> On 15/04/16 19:42, Andrew F. Davis wrote:
>> Hello all,
>>
>> I am currently working on a driver for a part similar to the AFE4300. I
>> was hoping to get some information on the recommended way to handle a
>> mux such as the one in the AFE4300 BCM front-end (page 13 of
>> http://www.ti.com/lit/ds/symlink/afe4300.pdf has a good image).
> That's marginally bonkers..
> 
> You do seem to get the weird and wonderful ;)  I'd never appreciated
> some of these weird devices existed!  Much more interesting than
> the average ADC.

I do wish one of these days they put a regular ADC on my desk, but what
fun would that be :)

>>
>> The top several pins are outputs that can be routed to the OP-AMP, but
>> only one at a time, because of this I'm not sure if they should be
>> exposed as output channels, or sysfs switches.
> So they are outputs the whole time?  But sometime internally fed back
> in to that amplifier.. both connecting to the input and output...
> 
> Is there a finite list of what the outputs can actually be at any time?
> I'm not sure if we can map this onto standard output channels or not.
> 

Yes, the list is technically finite, but any combination of one pin for
output and one for feedback is valid.

> It's described in the text as selecting between 6 contact points and
> 4 impedances so I'll pretend I can see exactly how the circuit is doing that
> as this is far too much thinking for a Saturday afternoon.
> 

It's been far to much thinking for my work-week too :) I think in the
data sheet they make the assumption that the PR0/1 and RN0/1 will be
connected external to a reference load, then any 2 pin combo of IOUTx
pins will be used to actually transmit. But this is not a hard
requirement so I don't really want to limit the device by not providing
a way to connect the combo IOUT3 and RN1, for instance.

> If treated as output channels it would have to be done on a last come
> basis with the others all being set to 0.  That's fine under the ABI that
> allows for any value to result in a change to any other but clunky.
> 

This was my concern, it seems kinda odd to automatically disable an
output when enabling another, but if it's explicitly allowed I'll do it.

> Hmm. Treating it as output channels does kind of match with how the device
> is used I think?  Fire a current out of pointN and read the resulting
> voltage between 2 points (one of which might be a reference)...
> 

I really don't know myself about all this, but the way it was explained
to me is that the user will connect a transmitter (for testing they gave
me simple resistors, so some kind of resistive load) between the output
pins, then they will read the value across a receiver (again probably
just some contacts with the subjects skin tied to a pair of input pins),
by switching between different transmit/receiver pairs placed at
different points and frequencies (and polarities I believe) you can get
a map of body impedance.

So I would like every combination of pins exposed in some way if I can.

> It's all channels, there is just a lot of restrictions on what can happen
> at a time.
> 

Yeah, I also like them as channels as you can set the frequency sent to
the output pins using the standard IIO_CHAN_INFO_FREQUENCY.

>>
>> The other issue is with the input pins, I believe the standard way to
>> handle this is by exposing every mux setting as a separate channel, then
>> only allowing one bit set in the scan mask, but for this part, when all
>> differential combinations are exposed we have more than 100 channels,
>> and the other part I'm working on makes this several times worse.
>>
>> Could someone point to any information, or an existing driver, that
>> explains the preferred way to handle this?
> You have it correct above.  At the end of the day there isn't much we can
> do to provide a compact yet general interface and occasionally we do end
> up with an awful lot of channels.  There are some analog devices battery
> chargers for example that end up as a cascade resulting in similar numbers
> of channels.
> 
> Each channel doesn't cost us that much other than making for a big set of
> files. 
> 

What about for buffered reads, active_scan_mask seems to be sent as bits
in a 64bit variable, does this then lead to a hard limitation of 64
channels?

> Doing it as mux switches would work, but be extremely difficult to describe
> simply to userspace in any way that would generalize.  The resulting programs
> would have to know too much about the sensor routing or to have a lot
> of complexity decoding how to set up the channel combinations they actually
> want.
> 

Maybe:

#cat in_voltage3_mux_available
VSENSE0
VSENSERP1
etc..
#echo VSENCE4 > in_voltage3_mux

or such for each real ADC channel with a mux in-front of it?

> As for existing drivers... Hmm. any of the differential ADC drivers provide a
> reference of sorts. For high channel counts, the ad7280a driver is still in
> staging but the principles are fine...
> 

Okay, I'll give that a look.

Thanks,
Andrew

> Lars, any input on this sort of highly complex device?  Looks a bit like some
> of the more nuts audio chips in some ways.
> 
> Jonathan
