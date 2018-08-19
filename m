Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeHSWky (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 18:40:54 -0400
Date: Sun, 19 Aug 2018 20:28:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: David Frey <dpfrey@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>,
        matt.ranostay@konsulko.com
Subject: Re: Buffert trigger and Power management support for BME680 ?
Message-ID: <20180819202816.7ded59d2@archlinux>
In-Reply-To: <20180818183150.GA1993@himanshu-Vostro-3559>
References: <20180730121241.GA4362@himanshu-Vostro-3559>
        <20180730140746.0000337a@huawei.com>
        <5b6c4b53-7141-93a5-b307-b7d91f8bea7f@gmail.com>
        <20180804143619.GA663@himanshu-Vostro-3559>
        <20180818175044.16820c0f@archlinux>
        <20180818183150.GA1993@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Aug 2018 00:01:50 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> > > Their design for high precision readings is just flawless!
> > > 
> > > I need some time to get ideas so as to start with buffer support.
> > > 
> > > But what kind of buffer support should be used ?
> > > sysfs trigger using scan_elements ?
> > > 
> > > There are no interrupt supported by the sensor! And I don't know
> > > how hrtimer would work.  
> > 
> > Is it possible to poll for new data?  I.e. is there an explicit
> > way of telling you are looking at a complete set of different data
> > from what you got on the previous reading?  
> 
> Yes, we have such facility:
> 
> 5.3.5.1 New data status
> 
> The measured data are stored into the output data registers at the
> end of each TPHG conversion phase along with status
> flags and index of measurement.
> 
> register	addr	bit pos		description
> meas_status_0	0x1D	new_data_0<7>	New data flag
> 
> And why do you ask ?

Because it lets you use a timer / thread in the drive to emulate
a trigger interrupt (be it in a fairly nasty fashion).
> 
> > It is unusual, but we do have a few other drivers where this is
> > necessary and some interesting dances to ensure they lock as closely
> > as possible with the actual sampling frequencies.  
> 
> The various problems for buffer support that I can see are:
> 
> o The press, temp have 20(8+8+4) bits resolution but humidity has 16 bits.
>   And then gas is 10 bits resolution(8 MSB + 2 LSB).
> 
> o Non-linear addressing:				decimal
> 	BME680_REG_TEMP_MSB                     0x22	34
> 	BME680_REG_PRESS_MSB                    0x1F	31
> 	BM6880_REG_HUMIDITY_MSB                 0x25	37
> 	BME680_REG_GAS_MSB                      0x2A	42
>  
>  Otherwise we could do large bulk read and push to buffer.

Yes, you'll need to shuffle the data around to get all aligned.

> 
> o Every time setting FORCED MODE to trigger measurement but then looking
>   at the following from BSEC makes me wonder:
> 
>      /* When the measurement is completed and data is ready for reading, the sensor must be in BME680_SLEEP_MODE.
>       * Read operation mode to check whether measurement is completely done and wait until the sensor is no more
>       * in BME680_FORCED_MODE. */
> 	while (bme680_g.power_mode == BME680_FORCED_MODE)
> 	{
> 		/* sleep for 5 ms */
> 		sleep(5);
> 		bme680_status = bme680_get_sensor_mode(&bme680_g);
> 	}
> 
>  Clearly, you wouldn't want this in interrupt handler, so we will
>  overwrite mode irrespective of current mode and avoid those checks.
You could have this in a thread.  Don't worry about anything in an interrupt
thread taking ages as it doesn't block anything from preempting the thread.

> 
> o And lastly compensation functions, we wouldn't pass raw values and
>   instead processed instead. Isn't ?

Now this is always awkward on devices with complex non linear functions
from raw to actual units.

I'm not sure it would be any use to output raw data in this case
so we would have to look at whether we can generate a packing without
loosing any precision of the final data.  It would probably have to be
'sort of raw' to give us the multipliers to do fixed point values.

We are looking at allowing a floating point output, but getting to that
in driver is going to be more than a little fiddly.  The intent is that
it is only really for cases where the device itself is outputting floating
point and we just pass it along...
> 
> So, now I see all these reading, setting config, checking bits,
> processing and finally pushing in an interrupt handler. Is this
> what shall be done ?
> 
> I'm asking too many questions because I don't want to waste my time
> doing wrong and getting a NACK in the end. Also, I have another huge
> project currently to focus by Linux Foundation.

The question is whether synchronized readings are needed across the channels.
If they are there is no other way of presenting them so we would need buffered
results.  If only nearly synchronized is fine then no point in bothering.

> 
> But I'm happy to review and test patches anytime.
> 
> > > Another question arises, say for eg., we use sysfs trigger and buffer
> > > capture comes in action:
> > > 
> > > * Would I enable FORCED mode everytime in the trigger interrupt handler ?
> > > * Also check for config setting(such as oversampling) and set
> > >   them accordingly in the interrupt handler ?
> > > 
> > > If no, then other suggestion ?
> > > If yes, isn't that bad to do all that in "bottom half" ?  
> > 
> > The bottom half in this case is an interrupt thread so you can do what
> > ever you like in it.  
> 
> Hmm. OK
> I have a different vision for top/bottom half.

For this sort of slow device (and quite a lot of quick ones) the traditional
top half / bottom half is long gone in favour of a light top half then waking
up a preemptible thread to do the stuff that used to be in the bottom half.
This means things like sleeping are fine.

>  
> > > I thought of preenable, but it works only 'once' prior to enabling but
> > > we need to set mode every time!  
> > 
> > Sounds like that might be necessary. I haven't read the datasheet
> > for a while and as you say it isn't always that informative!  
> 
> Yes, it is for the current revision.
> 
> > > > It's nice to see this driver progressing.  Keep up the good work!    
> > > 
> > > Thanks! Would need your help with its development.
> > >   
> > 
> > Indeed good to see this continue to move forwards.  
> 
> Well, as soon I saw BSEC, I realised I've done nothing and people would
> prefer BSEC.
> 
> But on the other hand, I was contacted by one Croatian developer who
> is backporting my driver to the their kernel since they are stuck
> with 4.14 and the product is already in assembly stage.
> 
> David also has a similar issue.
> 

Yes these devices are really fiddly.  What you have gets people started
but if they want to do all the bells and whistles they are going to end
up having to use something much more sophisticated to post process
the data.

Anyhow, good to know there are users of a sort (even if they tweak it
to get the data into something that can be hammered into the userspace
libraries.

Jonathan
