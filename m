Return-Path: <stillcompiling@gmail.com>
From: Joshua Clayton <stillcompiling@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Matt Ranostay <mranostay@gmail.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio channel sync
Date: Sat, 03 Sep 2016 13:52:39 -0700
Message-ID: <3109858.4eJt4Uf2VN@diplodocus>
In-Reply-To: <e7291439-cb74-f5eb-8fbe-a7376b2d2bf8@kernel.org>
References: <4284e190-84c2-07cc-1157-ef6d2fdd0e8c@gmail.com> <aa577c0c-c18c-26d3-b5c6-16692e813d35@gmail.com> <e7291439-cb74-f5eb-8fbe-a7376b2d2bf8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

On Saturday, September 03, 2016 03:37:50 PM Jonathan Cameron wrote:
> On 31/08/16 23:47, Joshua Clayton wrote:
> > Greetings,
> > 
> > On 08/30/2016 09:26 AM, Jonathan Cameron wrote:
> >>
> >> On 30 August 2016 08:41:18 BST, Matt Ranostay <mranostay@gmail.com> wrote:
> >>> On Mon, Aug 29, 2016 at 10:03 AM, Joshua Clayton
> >>> <stillcompiling@gmail.com> wrote:
> >>>> Jonathan,
> >>>>
> >>>> I have an out-of tree driver I am working on mainlining.
> >>>>
> >>>> The device is a sensor that gets phase and amplitude (x and y) data
> >>>>
> >>>> on multiple physical and/or time multiplexed channels.
> >>>>
> >>>> It also has up to 4 optical encoders to get physical location.
> >>>>
> >>>> The existing driver bundles x and y together with a snapshot
> >>>>
> >>>> of the encoder sums at that moment.
> >>>>
> >>>>
> >>>> This seems like a good fit for iio, but one item is bothering me.
> >>>>
> >>>> How is synchronization between streams usually handled with
> >>>>
> >>>> iio drivers? Timing can be important.
> >>> Wouldn't the trigger buffer framework be good enough for this?
> >> Perhaps you could describe your usecase a little more?
> >>
> >> Is the interesting bit that you want to sync streams with different
> >> sampling frequencies? Are those encoders better represented by a
> >> separate driver? (In which case I have some thoughts on simple
> >> additions to IIO trigger handling that might help - basically a
> >> hold off on triggers until all relevant devices are attached)
> 
> > Thanks for responding.
> > 
> > The encoders (often a pair of them, could be up to 4) represent the position
> > of the sensor in relation to an object to be tested. (linear movement or
> > rotation around an axis).
> > The Maximum sample rate of the encoders is much higher than the sensor,
> > but they are moved by a motor or by hand, so the actual sample rate is
> > variable and may be higher or lower that the sensor sample rate.
> > 
> > The encoders are sometimes used as a trigger for data collection,
> It would certainly be possible to do this by having a slightly unusual type
> of trigger.
> > but
> > the encoders are also used as positional data alongside the sensor data.
> Makes sense.
> > 
> > The way we get around this now is to bundle a snapshot of the encoder
> > with the sensor data and discard it later if the encoder hasn't changed and
> > the trigger function is enabled.
> The only slight change I'd suggest is that if the encoders are read by
> separate hardware (presumably they are into a capture unit of some type?)
> then you may need to have the encoder capture triggered off the same
> trigger as the sensor data.  Thus you'd end up with two buffers that
> could be easily fused in user space.
> 
> That would allow  generic drivers for other users of either the sensor
> or the encoder capture hardware.
> 
> If they come in through the same bit of hardware (e.g. you are routing
> them both through an fpga or similar) then fine as you have it currently.
>

Thanks for responding to my questions. It is always hard to visualise how
something that already exists might be re-architected, and you've given me
enough to get my mind working on it.
 
> Sounds like an interesting bit of hardware ;) Some sort of radio test kit
> around an antenna? (feel free to not answer, I'm always curious)
> 
> Jonathan
> >
Haha. Yeah, its a bit of a tightrope walk trying to upstream code while
keeping the "secret sauce" safe.

I thinks its ok to tell you it is eddy current testing equipment, used in
non-destructive testing of metal items.

We set up a standing wave using a high speed A/C current in a coil,
and measure distortion in the amplitude and phase of secondary
A/C currents induced in another coil.

It can be used to find defects near the surface, such as hairline cracks,
as well as to indirectly measure thickness and conductivity that might
indicate metal fatigue.

Google "eddy current" if you are still curious.

Joshua
