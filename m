Return-Path: <jic23@kernel.org>
Message-ID: <4EECBB29.8070102@kernel.org>
Date: Sat, 17 Dec 2011 15:54:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, archive@jic23.retrosnub.co.uk,
 linux-iio@vger.kernel.org, lars@metafoo.de,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 3/5] staging:iio:core add in kernel interface mapping
 and getting IIO channels.
References: <1323122164-32314-1-git-send-email-jic23@kernel.org> <1323122164-32314-4-git-send-email-jic23@kernel.org> <20111208194057.GA28532@kroah.com> <4EE39205.6030109@kernel.org> <20111210191524.GA17929@kroah.com> <20111216085057.3DE4240390@saturn.retrosnub.co.uk> <20111216162457.GA5403@kroah.com> <4EEB9ED8.8060704@cam.ac.uk> <20111216222332.GA6610@kroah.com>
In-Reply-To: <20111216222332.GA6610@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/16/2011 10:23 PM, Greg KH wrote:
> On Fri, Dec 16, 2011 at 07:41:12PM +0000, Jonathan Cameron wrote:
>>>>> for a world of hurt...
>>>> The entire purpose of this list is to allow a small built in chunk of
>>>> code to fill it up (typically from board files) whilst the rest of
>>> IIO can
>>>> still be built as a module.
>>>
>>> Why are you trying to do that?
>> Because I don't see any other remotely elegant way of doing it.
>> We need a mapping from this output channel on this device to this
>> input for this device that is using it as a service on a channel
>> by channel basis with a single output able to be used by many
>> inputs.
> 
> Who needs that mapping?
Any driver that needs to read/write (via a dac rather than
a regulator - and yes there is clearly a blurred line there) a voltage
(or other channel type) and doesn't have the support on chip.  Currently
we have hwmon and input bridge drivers for iio
supported parts.  Some channels are mapped to hwmon and some to input
on the same underlying adc.  The main interest is from the SoC side
of thing where this sort of sharing is common.  That's why Mark, Linus
are Arnd are cc'd on this. I've also added Maxime given the at91 adc
driver is a clasic example.
> 
>> This look up table (which is just a list to allow the more complex
>> boards to fill it from various places) serves that purpose.
> 
> And how is that shown by just a "bare" list being exported?
A bare is list only exported purely to allow to core parts of
IIO to comunicate.  Nothing else should ever touch that list.
Yes it should have had some locking (I fully except that).
It was a means of allowing IIO to remain buildable as a module.
To my mind that is a good thing, you evidently disagree.
Some input from the SoC guys here would be good.
  If you need
> to provide such a mapping, then by all means do so, but do so in a
> documented way with the proper locking for any data structures (which
> again, was the most obvious bug you had with this patch.)
I accept the locking and documentation points and will add those.
> 
>>>> All but one function that touches this are in
>>>> the IIO core modules.  I can wrap this up but only at considerable
>>> cost
>>>> (the wrappers will basically be the various list functions with a
>>> lock taken
>>>> - I'll add one of those).  I can write extreme warnings around it
>>> saying
>>>> that it strictly for use by the IIO core.  Would that be acceptable?
>>>
>>> I still don't understand the point of the list.  Why is this somehow
>>> different from any other bus in the kernel in that the only way to
>>> "register" a device is to actually register the device.
>> It is not for registering a device. It is for associations between
>> devices. Similar to the regulator API. That provides a means to request
>> a voltage from another device, this provides a means of reading from a
>> device.
> 
> Ok, then show how that works somehow?  Again, a list doesn't show that
> to me.
Read the functions using the list and you'll have your answer.  You are
focusing on the list when that really isn't the interface at all.
I will happily write extremely dire warnings around that list if that
helps.
> 
>> Ultimately it's a convenient way of passing platform data.  We could
>> pass it into every single supplier device (in a similar way to
>> regulators) as platform data.  Thus every iio device would have to
>> handle platform data and pass it on to the core, or, as here, we can
>> separate it out.
> 
> Having a function for all of the drivers to call to provide this
> information seems like the most obvious way to do this in a proper way,
> why not do that?
Because that means replacing the current platform data of ever single
driver. We can do this, but its messy and painful and breaks every
current user (yes they are out of tree given we are in staging and hence
can't have platform dat in tree - still I dislike pissing our users
off.)  The driver it self has no interest whatsoever in this data.

> 
>>>> Clearly this element should stay in the IIO directory once the rest
>>> of
>>>> the header has gone into include/linux/iio/.  I can do that division
>>> now
>>>> so the separation is more apparent.
>>>>
>>>> So in summary two options exist.
>>>>
>>>> 1) Leave as is with a suitable warning and maybe rename to make it
>>> appear
>>>> less friendly.
>>>> 2) Wrap it so we end up with accessors that are pretty much the
>>> standard
>>>> list accessors just with one parameter fixed and trivial locking.
>>> This isn't
>>>> too painful but seems conceptually wrong to me.
>>>> 3) Move everything that uses it into the bit that gets built in even
>>>> if IIO is a module.
>>>
>>> There should never be a "bit that is always built in if IIO is a
>>> module", sorry.
>> The only alternative is to make ever single IIO driver take platform
>> data to specify it's consumers and immediately pass it into the core.
>> It is only the core that cares.
> 
> What's wrong with a function call to the IIO core by the drivers?
Why pass data through them that they don't care about and won't touch?
> 
>>>> This last one will lead to an explosion in what is exported from IIO
>>> as we
>>>> will still need to have the divide between the bit that can be
>>> modular and
>>>> that which cannot somewhere! (which is why I didn't suggest it
>>>> before).
>>>
>>> Why are you trying to make such a strange distinction here?  If a
>>> device
>>> uses IIO, then you need to have the IIO core.
>> When that driver is loaded, not when the board file sets up it's
>> association with IIO.  It will not be dependent on the driver
>> supplying the channel anyway so we will need the backoff and
>> try again stuff to make this work.
>>
>> Why have I done it like this?
>>
>> Because this way we get a fairly clean addition to the subsystem
>> without having to rewrite every single driver's probe routine
>> which is the only other way making the data available that I can
>> see.
> 
> Rewriting all probe functions really shouldn't be hard as you have to
> just change from manipulating this list by-hand, to making a function
> call.  That sounds like an easy thing to do, and something that should
> be done, right?
That plus add a level of indirection to every driver that currently
has any platform data (which covers the vast majority).  Either
the array of consumers has to be added to their existing pd which is
clunky and driver specific or we have another structure with optional
consumer data and another level of platform data to pass in what the
driver actually cares about.  Note throughout that we are passing data
that is completely irrelevant to the driver.  We are doing all this
to support a usecase that isn't even relevant to many IIO drivers.

> 
>>> It can be built as a
>>> module or not, again, just like any other bus in the kernel.
>> Bus maybe, but other subsystems providing a 'service' like we
>> have here for iio such as regulators, pinmux etc cannot be built
>> as modules.  There the arguement was they were core to the
>> board; that is not typically true of IIO.
> 
> Then keep the IIO core from being built as a module if that is the
> requirement here.
A painful cost just to avoid having this one list (with locking added).
Not huge, but I really don't understand why this trivial list export
such a problem. (though there were clearly elements that could be
improved around it).
Note in the multiboard kernels that people are working for on for arm
etc we would just have added this to all configurations if only one
actually needs it.
> 
> Or, just be sure to initialize it early enough in the boot process that
> it happens before the drivers are, and then, it can be a module, as long
> as any driver that uses it is also a module, right?
There is a whole back off and try again infrastructure for module
loading.  Why not use that? (once/if it merges).  There is no
reason to get into the whole game of messing around with load
orders.
> 
> Again, just like all other busses :)
> 
> thanks,
Glad this came up before I tried to push the non staging version
as clearly there are questions to be addressed.

Jonathan
