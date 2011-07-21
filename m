Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E28303A.5020805@analog.com>
Date: Thu, 21 Jul 2011 15:57:14 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Manuel Stahl
	<manuel.stahl@iis.fraunhofer.de>, Jon Brenner <jbrenner@taosinc.com>, Bryan
 Freed <bfreed@chromium.org>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: Updating the todo list.
References: <4E26D807.6010804@cam.ac.uk> <4E26EDD5.7010604@analog.com> <4E26FC8D.9080809@cam.ac.uk>
In-Reply-To: <4E26FC8D.9080809@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/20/2011 06:04 PM, Jonathan Cameron wrote:
> On 07/20/11 16:01, Michael Hennerich wrote:
>> On 07/20/2011 03:28 PM, Jonathan Cameron wrote:
>>> Hi All,
>>>
>>> The cc list is based on who turns up a lot in my in box so please
>>> forward to any other interested parties!
>>>
>>> It's time we updated our todo list and started moves towards
>>> leaving staging.  Looking at it the todo is way out of date
>>> so I'll just start from scratch.
>>>
>>> First purely administrative change is to push elements of this
>>> TODO down close to the drivers.  There are now way to many to
>>> document sensibly in one place.  I propose the following structure
>>>
>>> iio/TODO with stuff that applies to all drivers.
>>> iio/accel/TODO for general accel stuff.
>>> iio/accel/TODO-lis3l02dq etc for individual drivers.
>> That makes a lot of sense.
>>
>>> Anyhow we'll leave drivers for now. Lets consider what
>>> we might have in top level TODO
>>>
>>> Obvious and still required.
>>> 1) Review.
>>> 2) Testing.
>>>
>>> Big sections:
>>>
>>> * Core
>>>      ( ida cleanups, though that's not sensible to put in the TODO file.
>>>        Basically it's a case of rolling all 'device id' uses of ida's into
>>>        a central library with a single lock so as to avoid the huge amount of
>>>        boiler plate code.)
>>>
>>> * Buffering
>>>      1) Replace or get significant review of sw-ring. As I've mentioned many
>>>         times I really don't like my code.
>>>      2) More options.
>>>      3) Documentation. Arnd suggested a man page given unusual nature of the chrdev.
>>>         Our main docs probably need a thorough read over and possibly updates as well.
>>>
>>> * Triggering
>>>      Post the locking / registration fix set, not sure we want to do more in here?
>> Does it address the potential bug in case triggers happen faster than consumers can take?
> No.  That's another one for the todo list. Can you give an example of a device set on
> which it still occurs?
I'm pretty sure I saw it last with the ad7298 driver using 
CONFIG_IIO_BFIN_TMR_TRIGGER.
It only happens with high trigger frequencies.
> I think I'm right in saying this will only effect devices that schedule.  Anything else
> should be a ONESHOT threaded interrupt and hence the incoming interrupt is masked.  The
> trick is probably just to do manual masking of the interrupt in the driver.
>
> The other issue I know of is tight looping in dataready interrupts.  Some of them on
> try_reenable do a level check to see if they missed an interrupt, if they did they
> redo whatever should clear it (typically data read).  If that's not quick enough the
> individual drivers should fail. Under those conditions I'm not sure we shut the trigger
> down cleanly...
>
>>> * Events
>>>      Post making the fixes Arnd suggested and chasing down allocation / freeing issues
>>>      as a result of refactoring in my recent RFC.
>>>
>>>      1) Event codes need rethink.  Michael already has a device where he ran out of space.
>>>         Perhaps we just make the code 64 bit right now.  It actually costs us almost nothing
>>>         given padding of the event structure.
>> Also the scan mask stuff is limited to 31 channels.
>> Switching to bitmaps using DECLARE_BITMAP, __clear_bit, __set_bit and friends
>> will help here. Not sure if we really want to carry this channel limitation out of staging.
> Agreed.  Sensible to update that now.  Do you want to propose a patch or shall I?
A fix in the core is going to affect a big number of drivers.
I can take care to move the ADxxxx parts over.

>>>      2) Replace the event handling code.  It's simplistic and single user.  Is this an issue?
>> I discussed similar things with Manuel recently. A user space iio daemon could easily
>> gate the single user buffers for multiuser purposes.
> Certainly possible.  So shall we say we want to go that way?
Single user is fine with me.

> Other bit I forgot here is adding poll support to events.  That's fairly trivial but it's
> not there now.
Yes support for poll() should be mandatory.

>>>      3) Consider matching event structure format with input's evdev?
>> I think the iio to input event gateway is an important thing.
>> There can be various ways to do that, however I think doing it in user space by
>> translating events and injecting them back into the input queue is not a good idea
>> considering the additional latencies.
> Agreed. My main issue here is that the events from interrupt are pretty restricted,
> so translation at some level would still be needed. Also, remember our data stream
> is completely separate, so needs translation into input events as well.
>
> I have thought about just adding a mask that says 'these channels are input' from
> a board config file then registering the input device directly from within IIO.
> (basically hooking right in at the core level).
>> A lot of accelerometer drivers make their way into linux-input.
>> Starting with Android 2.3 GINGERBREAD, the API adds support for several new sensor types,
>> including gyroscope, rotation vector, linear acceleration,  and barometer sensors.
>>
>> Not sure if they also will go into input.
> Some will, but arguing a barometer is human input would be 'interesting'.
>>> * sysfs attribute names.
>>>      1) Consider dropping 'compatibility' with hwmon to allow more consistency. in ->   voltage
>>>         for example.
>>>      2) Have a prefix to specify direction.  So in_voltageX_raw out_voltageX_raw.  Michael
>>>         brought this up. If we are going to do it, now is the time.  We may need a
>>>         'compatibility mode' to smooth the transition.  Note however that we don't want to
>>>         carry that mode out of staging. (do we also need an inout option?)
>>>
>> Yes - that's a good thing todo.
>> In addition we should also make sure that buffers may function in both directions.
> Hmm.. The actual implementation would at least initially be completely separate. I think
> the abi would certainly allow this as is though. Whilst I agree this would be useful, we
> don't have an implementation and it seems non trivial. Last time we talked about it,
> I got the impression quite a lot of bus level stuff had to be added before this
> could actually be useful?
If you think about making the SPI bus more deterministic, then I agree.
However there may be various other use cases.

1)
Most ADI precision DACs feature a LDAC (Load DAC) strobe. You could use a
iio-trigger for example a HW timer or PWM with an output strobe, 
directly connected
to the LDAC strobe, in the iio-trigger handler you could write the next 
value into the
shadow/shift register of the DAC. This way you get no jitter on the 
update rate, the only
timing constraint is that the new value is loaded before the next 
trigger occurs.

2)
Think about data sink devices with build in buffers.

3)
Don't think about Linux SPI or I2C bus drivers at all.

So there can be lot's of cases where IIO user space write-able buffers 
are useful.

> Lets audit the abi to make sure this can be done in future though.
>
>>> The next big discussion is how to propose a patch set moving out of staging.  This is
>>> hopefully where we'll start to get more feedback.
>>>
>>> I propose the following:
>>>
>>> 1) Move the namespace of key exported bits and bobs to iio_st* (for staging)
>>> 2) Add a prefix to drivers in kconfig (as we move them);
>>>      IIO_ seems the obvious choice.
>>>
>>> That leaves us clear to lift code across.  How about a series that looks like:
>>>
>>> 1) core sysfs only infrastructure + docs.
>>> 2) A few example drivers
>>> ---review period---
>>> 3) Event support + docs
>>> 4) A few example drivers
>>> ---review period---
>>> 5) Core buffer support + docs
>>> 6) Hardware buffer example (sca3000 given I have one).
>>> 7) Software buffer example (kfifo first as it's easier to review).
>>> 8) A few example drivers.
>>> ---review period---
>>> 9) Sets of clean drivers
>>> continue till we run out.
>> That sounds like a plan.
>>
>>> Note some drivers will probably be in staging for quite
>>> a large period - ultimately some need a complete rewrite.
>>>
>>> As we go along I suggest we try and keep the staging tree in sync with
>>> any changes.   At the end, I'd like to drop the core from the staging
>>> tree if possible and just have all remaining drivers use the new core
>>> implementation whether they are in staging or not.
>>>
>>> The only other option that really makes sense is to do the events
>>> and buffering in the opposite order.
>>>
>>> So we need to figure out:
>>>
>>> a) are we happy with this order.
>> No strong p
>>> b) which drivers are we taking at each stage.
>> I think we decide on this when we get close to the next stage.
> Makes sense.
>>> c) how to post the changes (linux-iio first then lkml after a week?)
>> Sure
>>> For the which drivers, the set I will personally carry are (listed by where
>>> they are updated in the above tree).
>>>
>>> 2) max1363, adis16400, tsl2563
>>>
>>> 4) max1363, tsl2563 (adis16400 doesn't actually have support for events
>>> in tree)
>>>
>>> 6) sca3000
>>> 8) max1363, sysfs trigger.
>>>
>>> I'd certainly like to take a few of our other nice drivers along for the
>>> ride but I can't test them.  I'm not taking the lis3l02dq for now despite
>>> it being one of my core test drivers, because it will cause issues given
>>> the misc/lis3 driver.
>>>
>>> So what do people want to carry through the process?
>> Given the fact that we only need a handful of good examples for
>> the initial review process. I think I can take care of two or three
>> ADxxxx going forward.
> Excellent.
>
> Just to see how hard it would be I've hacked 1 and 2 from above
> carrying the max1363 for now.  Looks fine. I've left a few elements in
> at the driver level that aren't used to reduce silly churn, but commented
> them as such in the code (to hopefully keep reviewers quiet!)
>
> I'll hold that branch for now as we need to do the two changes above.
> (in/out naming - which is afterall a big abi change and larger masks / events).
>
> I'll do the in out naming now and propose it as an RFC.  We can have
> a compile time 'compatibility' option if enough people should loud enough.
For all these ABI changes can you add a new public git tree?

>>> Mostly it will involve stripping elements out and then slowly building things
>>> back up again as the support becomes available.  One important
>>> point I'd like to do is remove the IIO_CHAN macro and do things
>>> explicitly.  Partly that macro is becoming restrictive and confusing
>>> + it will make for a much cleaner build up of support.
>>>
>>> All comments welcome!
>>>
>>> Once a consensus has formed *cross fingers*, I'll do a clean
>>> version to post more widely so others are kept in the loop.
>>>
>>> Jonathan
>>>
>>>
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
