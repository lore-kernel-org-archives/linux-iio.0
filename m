Return-Path: <jic23@cam.ac.uk>
Message-ID: <4EEB9ED8.8060704@cam.ac.uk>
Date: Fri, 16 Dec 2011 19:41:12 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, archive@jic23.retrosnub.co.uk
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 lars@metafoo.de, Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH 3/5] staging:iio:core add in kernel interface mapping
 and getting IIO channels.
References: <1323122164-32314-1-git-send-email-jic23@kernel.org> <1323122164-32314-4-git-send-email-jic23@kernel.org> <20111208194057.GA28532@kroah.com> <4EE39205.6030109@kernel.org> <20111210191524.GA17929@kroah.com> <20111216085057.3DE4240390@saturn.retrosnub.co.uk> <20111216162457.GA5403@kroah.com>
In-Reply-To: <20111216162457.GA5403@kroah.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

I've cc'd a few more people who have an interest it this support
and have mostly been involved in the discussion for the non
staging patch set.

For those I've added a quick summary.

Greg is unhappy with the fact that the inkernel support in IIO
relies on a small chunck of code that must be built in.
That code just provides a list and a function to fill it. Everything
else is in the IIO core modules.  There were some other issues to
do with which files code was in etc all of which have been resolved.
(Thanks to Greg for looking at this code as clearly there are still
controversial bits in here!)  For reference it's a direct
copy of what was proposed for the out of staging tree).

Greg KH <greg@kroah.com> wrote:

>On Fri, Dec 16, 2011 at 08:50:57AM +0000, archive@jic23.retrosnub.co.uk
>wrote:
>> >And how are you guaranteing that anyone walking the list is doing so
>in
>> >a "safe" manner?  What's to keep an entry from being removed while
>some
>> >random kernel code is walking it?
>> >
>> >Hint, don't allow direct access to this list, if you do so, you are
>in
>> >for a world of hurt...
>> The entire purpose of this list is to allow a small built in chunk of
>> code to fill it up (typically from board files) whilst the rest of
>IIO can
>> still be built as a module.
>
>Why are you trying to do that?
Because I don't see any other remotely elegant way of doing it.
We need a mapping from this output channel on this device to this
input for this device that is using it as a service on a channel
by channel basis with a single output able to be used by many
inputs.  This look up table (which is just a list to allow
the more complex boards to fill it from various places) serves
that purpose.
>
>> All but one function that touches this are in
>> the IIO core modules.  I can wrap this up but only at considerable
>cost
>> (the wrappers will basically be the various list functions with a
>lock taken
>> - I'll add one of those).  I can write extreme warnings around it
>saying
>> that it strictly for use by the IIO core.  Would that be acceptable?
>
>I still don't understand the point of the list.  Why is this somehow
>different from any other bus in the kernel in that the only way to
>"register" a device is to actually register the device.
It is not for registering a device. It is for associations between
devices. Similar to the regulator API. That provides a means to request
a voltage from another device, this provides a means of reading from a
device.

Ultimately it's a convenient way of passing platform data.  We could
pass it into every single supplier device (in a similar way to
regulators) as platform data.  Thus every iio device would have to
handle platform data and pass it on to the core, or, as here, we can
separate it out.
>
>> Clearly this element should stay in the IIO directory once the rest
>of
>> the header has gone into include/linux/iio/.  I can do that division
>now
>> so the separation is more apparent.
>> 
>> So in summary two options exist.
>> 
>> 1) Leave as is with a suitable warning and maybe rename to make it
>appear
>> less friendly.
>> 2) Wrap it so we end up with accessors that are pretty much the
>standard
>> list accessors just with one parameter fixed and trivial locking.
>This isn't
>> too painful but seems conceptually wrong to me.
>> 3) Move everything that uses it into the bit that gets built in even
>> if IIO is a module.
>
>There should never be a "bit that is always built in if IIO is a
>module", sorry.
The only alternative is to make ever single IIO driver take platform
data to specify it's consumers and immediately pass it into the core.
It is only the core that cares.
>
>> This last one will lead to an explosion in what is exported from IIO
>as we
>> will still need to have the divide between the bit that can be
>modular and
>> that which cannot somewhere! (which is why I didn't suggest it
>> before).
>
>Why are you trying to make such a strange distinction here?  If a
>device
>uses IIO, then you need to have the IIO core.
When that driver is loaded, not when the board file sets up it's
association with IIO.  It will not be dependent on the driver
supplying the channel anyway so we will need the backoff and
try again stuff to make this work.

Why have I done it like this?

Because this way we get a fairly clean addition to the subsystem
without having to rewrite every single driver's probe routine
which is the only other way making the data available that I can
see.

> It can be built as a
>module or not, again, just like any other bus in the kernel.
Bus maybe, but other subsystems providing a 'service' like we
have here for iio such as regulators, pinmux etc cannot be built
as modules.  There the arguement was they were core to the
board; that is not typically true of IIO.

Note that if this feels like a bolt on to IIO that is because
inkernel support is exactly that.  We are happy to have it
only if enhances what IIO already offers.

Jonathan
