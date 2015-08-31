Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:35830 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbbHaRAQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 13:00:16 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Michael Welling <mwelling@ieee.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Date: Mon, 31 Aug 2015 09:59:33 -0700
Subject: RE: Adding MAX1363 to BBB
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4AC2@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD498E@sfamail.SAKURAUS.LOCAL>
 <20150827191616.GA8285@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD49A5@sfamail.SAKURAUS.LOCAL>
 <20150827204225.GA3789@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD49AB@sfamail.SAKURAUS.LOCAL>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD49B7@sfamail.SAKURAUS.LOCAL>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4A61@sfamail.SAKURAUS.LOCAL>
 <20150829003143.GA21865@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4AB2@sfamail.SAKURAUS.LOCAL>
 <55E47FB5.7030401@kernel.org> <20150831165217.GB11095@deathstar>
 <55E4872A.9080103@kernel.org>
In-Reply-To: <55E4872A.9080103@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 

> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org] 
> Sent: Monday, August 31, 2015 9:56 AM
> To: Michael Welling
> Cc: Greg Wilson-Lindberg; linux-iio@vger.kernel.org; Daniel Baluta
> Subject: Re: Adding MAX1363 to BBB
> 
> On 31/08/15 17:52, Michael Welling wrote:
> > On Mon, Aug 31, 2015 at 05:24:21PM +0100, Jonathan Cameron wrote:
> >> On 31/08/15 17:01, Greg Wilson-Lindberg wrote:
> >>>  
> >>>
> >>>> -----Original Message-----
> >>>> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf Of 
> >>>> Michael Welling
> >>>> Sent: Friday, August 28, 2015 5:32 PM
> >>>> To: Greg Wilson-Lindberg
> >>>> Cc: linux-iio@vger.kernel.org
> >>>> Subject: Re: Adding MAX1363 to BBB
> >>>>
> >>>> On Fri, Aug 28, 2015 at 04:56:20PM -0700, Greg 
> Wilson-Lindberg wrote:
> >>>>>
> >>>>> I've got the system running, but I get an invalid argument
> >>>> error on the call to iio_buffer_refill().  I'm basically 
> using the 
> >>>> same code as for the tsadc, just added in a fourth channel, and 
> >>>> none of the setup calls are returning errors, but the first 
> >>>> iio_buffer_refill() call returns an error.
> >>>> I've dumped out the parameter that is being passed to the
> >>>> iio_buffer_refill() call and it is the same as the value 
> that was 
> >>>> returned from the iio_device_create_buffer() call.
> >>>>>
> >>>>> I've looked at the libiio source and I don't see anything
> >>>> obvious that should return invalid argument for the
> >>>> iio_buffer_refill() call.
> >>>>>
> >>>>
> >>>> I believe that you need to register an interrupt for buffered 
> >>>> access to work.
> >>>>
> >>>> Do you have an interrupt connected and registered?
> >>>>
> >>>
> >>> Nope, no interrupt.  So I guess I would need to ask, how 
> would I register the interrupt in the Device Tree?
> >> The max1363 (and similar) don't have a dataready interrupt as they 
> >> are clocked of the actual clock cycles of the i2c 
> transfers.  So they 
> >> only read on demand.
> >>
> > 
> > Ah, yes. Looking at the datasheet the interrupt is triggered by a 
> > window comparator not end of sample.
> That takes me back. It was one of my first drivers ;)  They 
> monitor stuff is real pain as it does output normal readings 
> when monitor is running but only after a whole load of other 
> stuff.  I think I got lazy and decided not to unwind that but 
> just to make the driver not read the channels when monitor 
> was enabled.

Not a problem, we don't need the monitor function.

> 
> > 
> >>>
> >>> Or, alternatively, can I just get individual readings through IIO?
> >> Either via sysfs, or by adding a sysfs trigger and poking that.
> >> To add a sysfs trigger you'll need to probe the module, 
> then poke a 
> >> number into the add_trigger attribute to create a trigger 
> which can 
> >> then be associated with the max1363 (as normal).
> >>
> >> Then to 'fire' the trigger write to the trigger_now 
> attribute of the 
> >> relevant trigger.
> >>
> >> Ideally Daniel will be back soonish with a final version 
> of the high 
> >> resolution timer trigger that would also work well here.
> >> (it's rather tied up with some configfs support which wis 
> trickier!).
> > 
> > It is probably easiest to sample using sysfs directly.
> > 
> > This would be same as the last method we tried while trying 
> to access 
> > to TI ADC and touchscreen simultaneously.
> > 
> > http://www.spinics.net/lists/linux-iio/msg20577.html
> That should work fine.

I'm converting back to that style, I should have it running in a bit.
Greg

> 
> Jonathan
> > 
> >>
> >> Jonathan
> >>>  --
> >>> To unsubscribe from this list: send the line "unsubscribe 
> linux-iio" 
> >>> in the body of a message to majordomo@vger.kernel.org 
> More majordomo 
> >>> info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-iio" 
> > in the body of a message to majordomo@vger.kernel.org More 
> majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 