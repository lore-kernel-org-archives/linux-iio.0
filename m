Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750764AbeC3JNn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Mar 2018 05:13:43 -0400
Date: Fri, 30 Mar 2018 10:13:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Syne <john3909@gmail.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
Message-ID: <20180330101337.73d3413c@archlinux>
In-Reply-To: <AA2E74B3-EA99-46F7-9FC8-29C8FE6CDC14@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
        <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
        <20180307200730.08ed3c2f@archlinux>
        <20180309003733.aichruo53vqryafg@smtp.gmail.com>
        <20180310151045.4570e85d@archlinux>
        <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
        <20180317203037.1093cc11@archlinux>
        <A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
        <20180318122312.0d395367@archlinux>
        <C4AC18E6-E89B-4915-9B71-09EFC09B490D@gmail.com>
        <20180324150205.709aa211@archlinux>
        <D48DD58E-EB75-48F4-8E34-69D619206BA1@gmail.com>
        <20180325172911.39c0e42f@archlinux>
        <AA2E74B3-EA99-46F7-9FC8-29C8FE6CDC14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 25 Mar 2018 13:36:40 -0700
John Syne <john3909@gmail.com> wrote:

> > On Mar 25, 2018, at 9:29 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> > 
> > On Sat, 24 Mar 2018 15:45:21 -0700
> > John Syne <john3909@gmail.com> wrote:
> >   
> >>> On Mar 24, 2018, at 8:02 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> >>> 
> >>> On Mon, 19 Mar 2018 22:57:16 -0700
> >>> John Syne <john3909@gmail.com> wrote:
> >>>   
> >>>> Hi Jonathan,
> >>>> 
> >>>> Thank you for all your hard work. Your feedback is really helpful. I’m surprised that no one from Analog Device has offered any suggestions.
> >>>>   
> >>> 
> >>> Sadly those active in the mainline linux kernel from ADI are focused in
> >>> other areas currently :(    
> >> Good point. I will reach out to Analog Devices and get a name of someone 
> >> who is knowledgeable in this area. Perhaps Lars-Peters has a suggestion.   
> > Yes, Lars or Michael Hennerich (+CC) are my normal contact points.
> > I believe this is outside both of their areas, but they may be able to
> > put you in contact with the right person.  If nothing else it would be
> > good to make someone in ADI aware that people care about linux support for
> > these parts!  
> I sent in a request to ADI for a contact person to help with the review.

Cool.

> >   
> >>>> Anyway, please see my comments inline below
> >>>> 
> >>>> Regards,
> >>>> John
> >>>> 
> >>>> 
> >>>> 
> >>>> 
> >>>>   
> >>>>> On Mar 18, 2018, at 5:23 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> >>>>> 
> >>>>> On Sat, 17 Mar 2018 23:11:45 -0700
> >>>>> John Syne <john3909@gmail.com> wrote:
> >>>>>   
> >>>>>> Hi Jonathan,      
> >>>>> Hi John and All,
> >>>>> 
> >>>>> I'd love to get some additional input on this from anyone interested.
> >>>>> There are a lot of weird and wonderful derived quantities in an energy
> >>>>> meter and it seems we need to make some fundamental changes to support
> >>>>> them - including potentially a userspace breaking change to the event
> >>>>> code description.
> >>>>>   
> >>>>>> 
> >>>>>> Here is the complete list of registers for the ADE7878 which I copied from the data sheet. I added a column “IIO Attribute” which I hope follows your IIO ABI. Please make any changes you feel are incorrect. BTW, there are several registers that cannot be generalized and are used purely for chip configuration. I think we should add a new naming convention, namely {register}_{<chip-register-name>}. Also, I see in the sys_bus_iio doc    
> > 
> > No, registers can always be broken up in to real meaningful values if
> > they are exposed to userspace and userspace has a reason to tweak
> > them.
> > 
> > We never expose raw registers to userspace except through
> > debugfs and the clue is in the name - purely for debug.  
> OK
> > 
> >   
> >>> 
> >>> 
> >>> 
> >>>   
> >>>>>> in_accel_x_peak_raw
> >>>>>> 
> >>>>>> so shouldn’t the phase be represented as follows:
> >>>>>> 
> >>>>>> in_current_A_scale      
> >>>>> I'm still confused.  What does A represent here?  I assumed that was a wild
> >>>>> card for the channel number before but clearly not.
> >>>>> 
> >>>>> Ah, you are labelling the 3 separate phases as A, B and C. Hmm.
> >>>>> I guess they sort of look like axis, and sort of like independent channels.
> >>>>> So could be indexed or done via modifiers depending on how you look at it.      
> >>>> In metering terminology, the three phases are commonly referred to as RED, GREEN, BLUE or PhaseA, PhaseB, PhaseC and Neutral. Analog Devices uses the ABCN nomenclature so anyone using this driver will probably have referenced the Analog Devices datasheet so this terminology should be familiar.     
> >>> Which is more commonly used in general?  We are designing what we hope
> >>> will be a general interface and last thing we want is to have everyone
> >>> not using ADI parts confused!  Personally not assigning 'colours' makes
> >>> more sense to me.    
> >> I did a little research and here is the naming used by vendor:
> >> 
> >> ST Microelectronics: P1, P2, P3, N
> >> http://www.st.com/content/ccc/resource/technical/document/application_note/5e/f4/22/4d/90/96/4c/c4/CD00153264.pdf/files/CD00153264.pdf/jcr:content/translations/en.CD00153264.pdf
> >> 
> >> Teridian: ABCN
> >> https://www.mouser.com/ds/2/256/71M6513-71M6513H-22603.pdf
> >> 
> >> Maxim Integrated: ABCN
> >> https://datasheets.maximintegrated.com/en/ds/78M6631.pdf
> >> 
> >> Microchip: ABCN
> >> http://ww1.microchip.com/downloads/en/DeviceDoc/51643b.pdf
> >> 
> >> NXP: L1, L2, L3, N
> >> https://www.nxp.com/support/developer-resources/reference-designs/kinetis-km3x-256-mcu-three-phase-metering-reference-design:RD-KM3x-256-3PH-METERING
> >> 
> >> Renesas: ABCN
> >> https://www.renesas.com/en-us/solutions/home/metering/power-meter-three.html
> >> 
> >> So the most consistent would be ABCN  
> > Cool.   Makes sense to go with that.  Thanks for checking this out.
> >   
> >> 
> >> 
> >> All vendor providing three phase energy metering ICs use the ABCN terminology.   
> >>> 
> >>> (btw please wrap any lines that don't need to be long to around 80 characters).
> >>>   
> >>>>> 
> >>>>> Hmm. With neutral in there as well I guess we need to make them
> >>>>> modifiers (but might change my mind later ;)
> >>>>> 
> >>>>> Particularly as we are using the the modifier for RMS under the previous
> >>>>> plan... It appears we should treat that instead like we did for peak
> >>>>> and do it as an additional info mask element.  The problem with doing that
> >>>>> on a continuous measurement is that we can't treat it as a channel to
> >>>>> be output through the buffered interface.      
> >>>> I’ve changed the layout of the spreadsheet to breakout the Direction, Type, Index, Modifier and Info Mask to make sure there is no miss-understanding and will help identify all the items we need to add.
> >>>> 
> >>>> The ADE7878 channels that will use the buffer are IAWV, VAWV, IBWV, VBWV, ICWV, VCWV, INWV, AVA, BVA, CVA, AWATT, BWATT, CWATT, AVAR, BVAR, and CVAR. So I guess we have to add an index    
> >>> Probably a good idea anyway, we are sort of slowly moving away
> >>> from index less channels.  The ABI always allowed index assignment
> >>> and it makes for easier userspace code.
> >>>   
> >>>> 
> >>>> Address Register 	IIO Attribute							Dir	Type		Index 	Modifier	Info Mask	R/W	Bit		Bit Length	Type	Default	Description 
> >>>> 																									Length 	During Comm			Value	
> >>>> 0xE50C	IAWV	in_current0_phaseA_instantaneous		in	current			0	phaseA	instantaneous	R	24		32 SE		S		N/A		Instantaneous value of Phase A current.    
> >>> 
> >>> I'm unconvinced by "instantaneous".  That is the default assumption that you are
> >>> measuring current at this point in time.  I'm still confused on what this actually
> >>> is. Is it effectively the DC current? I.e. the wave form value for current? 
> >>> You answer this below.  They are DC measurements..    
> >> No, they are the output of the ADC at a point in time. The ADC samples 
> >> continuous at 8,000 samples per second, so when you read this register
> >> you are getting the sample measured just before your read. I don’t know
> >> why anyone would read this register. The samples are streamed via
> >> the SPI interface, with IAWV, VAWV, IBWV, VBWV, ICWV, VCWV, INWV, 
> >> AVA, BVA, CVA, AWATT, BWATT, CWATT, AVAR, BVAR, and CVAR transmitted 
> >> every 125uS. Probably better not to expose these registers to user space.  
> > I'm happy not to expose them, but if they are the instantaneous values
> > they are what I mean by DC values, literally the number you would
> > see on an oscilloscope if you were to probe them.  
> If you could read the instantaneous register after each sample, then you 
> would get an oscilloscope display of a sine wave. However, since a user 
> space app cannot read this on each sample, the output would look pretty
> random. Certainly not a DC value, which is much more consistent.
We are violently agreeing by the sound of it - just have a slightly different
view of terminology, I'm happy to have a rapidly varying DC voltage as
my view, you want to think of it differently.

Anyhow the oscilloscope bit makes it clear we are talking about the same
thing ;)  
 
> >   
> >> 
> >>   
> >>> 
> >>> Which actually raises a point I'd forgotten.  We have an explicit type 
> >>> for altvoltage (defined for DDS devices as the waveform amplitude IIRC).
> >>> We should be consistent with that if possible.
> >>> 
> >>> So I think this should be.
> >>> in_current0_phaseA_raw    
> >> Yeah, that sounds correct, which reminds me of another issue that does not make
> >> sense. To me, gain is something that is hardware related and is used to magnify 
> >> an input signal or is used to calibrate a measurement. Scale on the other had is 
> >> something that is used to convert a raw measurement into something that is more 
> >> meaningful, such as 0x820000 = 220V. So everywhere we have used scale and gain 
> >> interchangeable is confusing.  
> > 
> > Agreed - up to a point.  If you have a hardware gain control which for whatever
> > reason results in a different scaling needing to be applied to go from userspace
> > value to real world value (sometimes happens with multi range devices) then we
> > expose it only once - as scale.
> > 
> > We have hardwaregain and calibgain for tweaking the gain to account for cases
> > where it isn't apparent in the output value (hardware gain - normally used
> > when we are measuring something about the signal that isn't it's magnitude),
> > or is compensating for inaccuracies in the circuitry or sensor (calibgain)  
> That is what we have, the ADE7854 has a hardwaregain before the ADC to allow
> various input voltage and current ranges: 0-250mV, 0-0.5V, etc. Also, we have
> calibgain, which is used to compensate for the selected current transformer or 
> rogowski coil and the termination resistors. 
> 
> Maybe we should add additional attributes for scale and the real world values?
> The scale attribute would convert the raw value to real world value (220V, 100A
> 25KWh, etc)

So it should be possible to define everything using existing attributes and I
would really like to avoid adding more if we possibly can. It's way to easy
to end up with more than one way of describing things.

calibgain is good for mapping from some measurement to an expected gain.
That hardwaregain has two options.
1) The device is internally compensating for it so if you were to have a 250mV
value it would have the same raw counts value (seems unlikely but there are
devices that do this)
2) The device is not compensating for it, in which case it is simply 'scale'.

So we tweak the calibgain to adjust for the analog circuit then set the
the scale to the right range.  At that point in userspace we take
_raw * _scale and get the real world value of the relevant thing.

If for whatever reason this isn't possible (usually a non linear transform
from the adc reading to real world) then we do have the option of providing
_PROCESSED outputs which are in the base units of the relevant IIO unit.
However, we only do this if we 'can't' do the conversion in userspace.


> >> STATUS0:6	REVAPA	ACCMODE has changed sign. Power is exported rather
> >> than imported. User space application would use this to indicate the direction
> >> of power flow.  
> > This is where we start to run into a problem - mostly IIO only allows for
> > a single threshold for rising and falling on a given channel.  No way to
> > tell which one triggered in the ABI - even code says what and on what channel
> > it doesn't distinguish multiple levels.  
> Yeah, there is no threshold here. It occurs with the phase exceeds 90 deg,
> which indicates that the power is now being exported to the grid.
We could perhaps use a fixed threshold to represent this then.
Would need a phase channel to associate it with but that should be fine.
Nothing says a threshold needs to be changeable :)

in_phase0_thresh_either_value = 90 degrees

> > 
> > We can play games with defining additional channels but it isn't that elegant.
> > Now assuming we want to do both directions of change..  
> Correct, we need to know when the power is flowing from the power grid or
> flowing to the power grid. This is common with Distributed Energy Resources
> (DER) such as solar panels or wind farms. 
> > 
> > in_power0_thresh_either_value = 0
> > (to indicate a transition across 0 power - I assume the other direction is
> > negative?)
> > and associated event code.
> >   
> >> 
> >> STATUS1:0	NLOAD	At least one phase has entered no load condition. User 
> >> space app would probably alert the user of a faulty condition.  
> > Not sure what this maps to - but would be based on how it was detected.
> > Is this effectively 0 current?  
> The ADC is noisy and doesn’t output 0x000 when the current is 0A, so anything 
> below a defined threshold is considered to be NoLoad.
So that's a simple low current threshold - again with a fixed value which is
fine to represent as with the phase one above.

> >   
> >> 
> >> STATUS1:3	ZXTOVA	Indicates Phase A voltage zero crossing is missing. This 
> >> is another fault condition.  
> > 
> > Similar to the rate of change detection in some ways, but only explicitly looks
> > at the 0 point.  We would need something new to represent this I think…  
> This occurs when we have a phase failure (transformer failure, etc) or a sensor 
> failure (wiring failure, etc). If phase failure occurs, it could cause damage to 
> equipment like a motor.

This needs some thought.  Could be the kernel's RAS infrastructure is the way
to go but this is an odd thing to map to it (and that is a rather conservative
part of the kernel - it's hard enough getting people to agree on computer hardware
fault descriptions).
> >   
> >> 
..
> >>>>> OK, this is getting silly.  I presume this means the values above are filtered and these
> >>>>> aren't?  If so you need to have channels for both and different filter values.      
> >>>> These are the actual samples from the ADC and not a calculated measurement over 10/12 cycles. These are the samples that are placed in the buffer.    
> >>> OK, so DC values which answers my question above.
> >>> So this is the 'normal' measurement.  For the multi cycle ones we need to
> >>> represent them as additional measurements using the index and describe the
> >>> filtering applied to them (or use altvoltage etc to say we are looking
> >>> at measurements related to the fact they are alternating rather than DC.    
> >> I answered this above. I think we should remove these registers as I cannot see how anyone would use 
> >> them  
> > Cool. Even easier.   Though if we have a device that will allow us to push these
> > through the buffered interface (rather than the SPI master stuff on here)
> > then we would have the channels, but not export the _RAW attribute - thus
> > making them readable only as a stream of data.  
> There is no way to read all these instantaneous registers every 125uS. The 
> SPI master interface is the only way to retrieve these measurements, 
> running at about 4Mbps. 
Sounds like best plan is don't have userspace access to them - just have the channels
for associated events if there are any.

...
