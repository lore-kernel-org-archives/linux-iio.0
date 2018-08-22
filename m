Return-Path: <SRS0=GI0E=LF=gmail.com=himanshujha199640@kernel.org>
Date: Wed, 22 Aug 2018 17:24:50 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Frey <dpfrey@gmail.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>,
	matt.ranostay@konsulko.com
Subject: Re: Buffert trigger and Power management support for BME680 ?
Message-ID: <20180822115450.GC26015@himanshu-Vostro-3559>
References: <20180730121241.GA4362@himanshu-Vostro-3559>
 <20180730140746.0000337a@huawei.com>
 <5b6c4b53-7141-93a5-b307-b7d91f8bea7f@gmail.com>
 <20180804143619.GA663@himanshu-Vostro-3559>
 <20180818175044.16820c0f@archlinux>
 <20180818183150.GA1993@himanshu-Vostro-3559>
 <20180819202816.7ded59d2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180819202816.7ded59d2@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Aug 19, 2018 at 08:28:16PM +0100, Jonathan Cameron wrote:
> On Sun, 19 Aug 2018 00:01:50 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
> > > > Their design for high precision readings is just flawless!
> > > > 
> > > > I need some time to get ideas so as to start with buffer support.
> > > > 
> > > > But what kind of buffer support should be used ?
> > > > sysfs trigger using scan_elements ?
> > > > 
> > > > There are no interrupt supported by the sensor! And I don't know
> > > > how hrtimer would work.  
> > > 
> > > Is it possible to poll for new data?  I.e. is there an explicit
> > > way of telling you are looking at a complete set of different data
> > > from what you got on the previous reading?  
> > 
> > Yes, we have such facility:
> > 
> > 5.3.5.1 New data status
> > 
> > The measured data are stored into the output data registers at the
> > end of each TPHG conversion phase along with status
> > flags and index of measurement.
> > 
> > register	addr	bit pos		description
> > meas_status_0	0x1D	new_data_0<7>	New data flag
> > 
> > And why do you ask ?
> 
> Because it lets you use a timer / thread in the drive to emulate
> a trigger interrupt (be it in a fairly nasty fashion).

OK.
Actually Matt gave me reference to his PulsedLight LIDAR sensor
driver as a refernece for buffer support and the same suggestion
was provided by Daniel during GSoC.

So, now I will try and test because

	"Talk is cheap. Show me the code."

> > o Every time setting FORCED MODE to trigger measurement but then looking
> >   at the following from BSEC makes me wonder:
> > 
> >      /* When the measurement is completed and data is ready for reading, the sensor must be in BME680_SLEEP_MODE.
> >       * Read operation mode to check whether measurement is completely done and wait until the sensor is no more
> >       * in BME680_FORCED_MODE. */
> > 	while (bme680_g.power_mode == BME680_FORCED_MODE)
> > 	{
> > 		/* sleep for 5 ms */
> > 		sleep(5);
> > 		bme680_status = bme680_get_sensor_mode(&bme680_g);
> > 	}
> > 
> >  Clearly, you wouldn't want this in interrupt handler, so we will
> >  overwrite mode irrespective of current mode and avoid those checks.
> You could have this in a thread.  Don't worry about anything in an interrupt
> thread taking ages as it doesn't block anything from preempting the thread.

Thanks for the clarification.

> > o And lastly compensation functions, we wouldn't pass raw values and
> >   instead processed instead. Isn't ?
> 
> Now this is always awkward on devices with complex non linear functions
> from raw to actual units.
> 
> I'm not sure it would be any use to output raw data in this case
> so we would have to look at whether we can generate a packing without
> loosing any precision of the final data.  It would probably have to be
> 'sort of raw' to give us the multipliers to do fixed point values.

Ah yes, we can do 'sort of raw' since each channel outputs an integer
and we divide them with their respective resolutions.

So, this division can be done in userspace.

For eg: 43215 is pushed to buffer and later in userspace we divide
it by 1000(.0001 % resolution of humidity).

Also note that this 43215 is the result of "compensation function" and
raw read obtained is useless.

> We are looking at allowing a floating point output, but getting to that
> in driver is going to be more than a little fiddly.  The intent is that
> it is only really for cases where the device itself is outputting floating
> point and we just pass it along...
> > 
> > So, now I see all these reading, setting config, checking bits,
> > processing and finally pushing in an interrupt handler. Is this
> > what shall be done ?
> > 
> > I'm asking too many questions because I don't want to waste my time
> > doing wrong and getting a NACK in the end. Also, I have another huge
> > project currently to focus by Linux Foundation.
> 
> The question is whether synchronized readings are needed across the channels.
> If they are there is no other way of presenting them so we would need buffered
> results.  If only nearly synchronized is fine then no point in bothering.

Buffered support has the only advantage that we get all TPHG in one-go
without triggering measurement for each channel every time.

> > 
> > But I'm happy to review and test patches anytime.
> > 
> > > > Another question arises, say for eg., we use sysfs trigger and buffer
> > > > capture comes in action:
> > > > 
> > > > * Would I enable FORCED mode everytime in the trigger interrupt handler ?
> > > > * Also check for config setting(such as oversampling) and set
> > > >   them accordingly in the interrupt handler ?
> > > > 
> > > > If no, then other suggestion ?
> > > > If yes, isn't that bad to do all that in "bottom half" ?  
> > > 
> > > The bottom half in this case is an interrupt thread so you can do what
> > > ever you like in it.  
> > 
> > Hmm. OK
> > I have a different vision for top/bottom half.
> 
> For this sort of slow device (and quite a lot of quick ones) the traditional
> top half / bottom half is long gone in favour of a light top half then waking
> up a preemptible thread to do the stuff that used to be in the bottom half.
> This means things like sleeping are fine.

Ok.

Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
