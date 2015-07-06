Return-Path: <harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2015 10:54:39 +0200
From: <harald@ccbib.org>
To: Jonathan Bell <jonathan@raspberrypi.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Sanjeev Sharma <sanjeev_sharma@mentor.com>,
 Richard Weinberger <richard@nod.at>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 <linux-iio@vger.kernel.org>, <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH] iio: humidity: dht11: Rewrite decode algorithm, improve
 read reliability
In-Reply-To: <op.x1cc5l17fh00o9@enterprised.lan>
References: <op.x1bjac2cfh00o9@enterprised.lan> <33438a3f3e237279d0807a4241efa495@imap.cosmopool.net> <op.x1cc5l17fh00o9@enterprised.lan>
Message-ID: <359b49b5215c47f497e3f255c63fdcb0@imap.cosmopool.net>
List-ID: <linux-iio@vger.kernel.org>

On Mon, 6 Jul 2015 08:45:11 +0100, Jonathan Bell
<jonathan@raspberrypi.org>
wrote:
> On Mon, 06 Jul 2015 00:39:53 +0100, <harald@ccbib.org> wrote:
> 
>> Hi!
>>
>> Thanks for looking into this driver. Actually I'm working actively
(even
>> if at a low pace) on cleaning up and improving the code, so I'd  
>> appreciate
>> coordination of work. I currently have a patch under review, so you
will
>> need to rebase your patch once mine got merged.
>>
>> Also you should split your patch into logical changes an grouping them
>> into fixes, improvements and cleanups, so that I can ACK them
>> individually.
> 
> This is a spare-time project for me.

The same is true for me.

> I was aware that others were working  
> on it, hence the RFC with my changes so far.

Sure, but if we coordinate, we won't have to rebase on each others
patches ...

>> On Sun, 5 Jul 2015 22:00:02 +0100, Jonathan Bell
>> <jonathan@raspberrypi.org>
>> wrote:
>>> This driver has a poor read success rate when any amount of hard-IRQ
>>> latency is encountered. On the Raspberry Pi platform for example, the
>>> read success rate is ~50% with no hardware activity and practically 0%
>>> with any other significant hardware activity.
>>
>> Actually I developed and tested this driver on a slow platform
>> (imx233-olinuxino) and it worked quite well there, so I believe what
>> really
>> fixes your problems is the added calls to smp_mb(), which you entirely
>> forgot to mention in your summary below.
>>
>> I admit I never tested my code on any multicore system and if decoding
>> results are really that bad there, this is a serious bug. Obviously I'm
>> not
>> competent about multiprocessing and can't review your solution, but if 

>> you
>> can confirm, that just adding smp_mb() calls to the existing code fixes
>> your problems, then you can add my Acked-By to such a patch and this
>> should
>> be applied as fix.
> 
> The driver was just as unreliable on a Pi model B+ (single-core, ARM11)
as
> it was on a B2 (quad-core A7).

I really wonder how that happens (in the no load case). Unfortunately I
don't have a Pi to test this. In the version I submitted initially, there
was some code to debug the timing - see
http://www.spinics.net/lists/linux-iio/msg11212.html
maybe you can use this to see what's going wrong. Maybe also apply the
patch I have currently under review to get more accurate information from
timekeeping and tell me what the timeresolution on your platforms is.

> The smp_mb() is necessary for multicore architectures that do not have a

> snoop control unit on their cache controller. As it happens, the A7
cache  
> unit *does* have one, but I was thinking about making the driver more  
> robust on more platforms.

Ok, if it hasn't been observed in real life, then this probably has to go
in as an ordinary update.

>> About your other changes:
>>> Rewrite several aspects of the decode mechanism to make it more
robust:
>>>
>>> - Cater for GPIO chips that can raise interrupts when I/O pins
>>>    are set as output by expanding the maximum number of edges
recorded.
>>> - Start decoding the bitstream right-justified to make the driver
>> agnostic
>>>    towards whether the start bits generate IRQs.
>>
>> That was the original behaviour, but is actively prohibited by some
GPIO
>> chip drivers. We asked Linus Walleij about it in
>> https://lkml.org/lkml/2014/12/1/171 who replied:
>> "IRQs on pins set to output *does* *not* *make* *sense*." I still
>> disagree,
>> but I don't feel like diving into discussions like this. I'll be happy
if
>> you can convince him, because the DHT11 driver lost a nice diagnostic
>> feature with that change, but before that GPIO code is changed, there
is
>> no chance this can be added back.
> 
> For Linus's benefit:
> 
> These sensors are prodded by initially driving their data line low for a

> long period (some ms) and then reverting the pin to an input to listen
to  
> their response. The first bit-edge arrives about 27us after reverting
the  
> pin to an input.
> 
> I moved the request_irq() back to the probe function originally because 

> the first edge was going missing - request_irq wasn't completing before 

> the first edge arrived in 27uS.
> 
> There is no electrical reason why GPIO outputs cannot also be interrupt 

> sources.  The generation of interrupts from edge/level events simply  
> samples the state of the pad and acts accordingly - it doesn't care
what's
> driving it (or at least shouldn't do). I'd be interested to see if
there's
> any GPIO hardware that gates its interrupt generation system with "am I
an
> input?". If the GPIO API doesn't support this then OK, there may be  
> reasons why (such as the locking referred to in the linked thread).
> 
> Rethinking the patch a bit, if we're now right-justifying our decode
then  
> we shouldn't care if we miss interrupts for the start bit or the first  
> phase of the response, so we can work around it.
> 
>>
>>> - Only bother decoding for GPIO "high" bit-times - the high-time is
what
>>>    encodes the useful information.
>>> - Use simple split-the-difference thresholding to decide if a received
>>>    data bit is a "1" or "0", instead of comparing relative bit
periods.
>>
>> These changes are actually in my queue of cleanup patches. However
>> selecting the right threshold is not quite trivial: There are the
timing
>> differences between sensor variants but there are also timing
differences
>> depending on cable length. I have DHT22s connected to cables up to
>> 15 meters. You must be careful to select a threshold that really works
>> with different impedances, etc.
> 
> I couldn't see any significant differences in the datasheets I've looked

> at (which I thought I had gathered for all the models out there). They
all
> seemed to suggest 28/70uS timing.

I get sligthly different results with DHT11 and DHT22, but then somebody
else, also working with mxs, got different results with DHT22 than me.
I guess with these cheap parts even if they look like the same outside,
they might be different ...

> It's true that for long wires the timings will vary due to the extra  
> capacitance. In particular the rising edge generated by the pull-up will

> be slower, meaning your high-bit timings get compressed.
> 
> 
>>> - Refine the start bit timing to use usleep_range() to stop the later
>>>    sensor models from timing out if the msleep() takes longer than
>>>    expected.
>>
>> Do you have any data (or even experiemental results) backing this
change?
>> The start bit timing is bothering me for a long time now: I never got
>> any conclusive answer, what is best. However I never saw any problems
>> obviously attributable to start bit time outs either. (Your change of
>> course makes sense independent of the actual timing used.)
> 
> If I put more process pressure on the system (i.e. more task switches), 

> the start bit sometimes took an extra jiffy to complete. I would only
get  
> 2 edges back, which I am assuming either a) the sensor doesn't respond,
or
> b) the sensor responds but we trample the signal by holding the line
low.
> 
> I've not tested the timing with a scope since the change, but the  
> no-response failure mode I was seeing has disappeared.

Ok. If this fixes a real world issue, then please submit a patch with just
this change and tested individually so this can go in as fix and be
considered by stable maintainers.

> Maybe the driver needs a few more (optional) DT properties. Since the  
> start-bit varies so widely between models, perhaps a few more compatible

> strings to tune start-bit length and a "wire-delay" parameter to tweak  
> detection thresholds?

Yes, if this gets to the point where we can't autodetect everything we
need to get reliable operation, then testing the compatible strings is
the way to go. I prefer autodetection though if possible.

>>> Also tweak a few error paths to be more informative.
>>
>> That's also on my todo list of cleanups. (And already begun with the  
>> patch
>> currently under review.)
>>
>>> The sensor decode success rate on a Pi after these changes is 99.1%
with
>>> no other hardware activity and approximately 78% with an Ethernet ping
>>> flood happening concurrently.
>>
>> Actually if you used the information from the GPIO "low" timings for  
>> error
>> correction, you probably could improve the ping flood case. However I'm
>> not
>> sure if it is worth the effort and code complexity.
> 
> How so? I am using all the timing information available (each recorded  
> edge) to generate my decode stream. Interrupt latency has the effect of 

> smearing out the received timings into a sort-of Gaussian distribution. 

> Splitting the difference for the high-time seemed the most sensible
case.
> 
> The majority of decode failures I get now are due to coalesced edges -  
> i.e. sampling the pin after an entire low- or high-time has passed,
which  
> we can't do much about. The only extension I could see that wouldn't  
> affect the complexity too much would be to infer the timing from the
edges
> received either side of the "missing" sample - but if our hard-IRQ
latency
> affects those as well, then this gets tricky.

Yes, this would be a probabilistic thing. I care about slow platforms, so
I kept the possibility around but was surprised it wasn't necessary on
mxs.

> Of course userspace could just try again in 2 seconds...

Which is the other reason nobody cared so far...

Thanks,
Harald
