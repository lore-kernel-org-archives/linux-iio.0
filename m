Return-Path: <greg@kroah.com>
Date: Fri, 16 Dec 2011 14:23:32 -0800
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: archive@jic23.retrosnub.co.uk, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org, lars@metafoo.de,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH 3/5] staging:iio:core add in kernel interface mapping and
 getting IIO channels.
Message-ID: <20111216222332.GA6610@kroah.com>
References: <1323122164-32314-1-git-send-email-jic23@kernel.org>
 <1323122164-32314-4-git-send-email-jic23@kernel.org>
 <20111208194057.GA28532@kroah.com>
 <4EE39205.6030109@kernel.org>
 <20111210191524.GA17929@kroah.com>
 <20111216085057.3DE4240390@saturn.retrosnub.co.uk>
 <20111216162457.GA5403@kroah.com>
 <4EEB9ED8.8060704@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EEB9ED8.8060704@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Dec 16, 2011 at 07:41:12PM +0000, Jonathan Cameron wrote:
> >> >for a world of hurt...
> >> The entire purpose of this list is to allow a small built in chunk of
> >> code to fill it up (typically from board files) whilst the rest of
> >IIO can
> >> still be built as a module.
> >
> >Why are you trying to do that?
> Because I don't see any other remotely elegant way of doing it.
> We need a mapping from this output channel on this device to this
> input for this device that is using it as a service on a channel
> by channel basis with a single output able to be used by many
> inputs.

Who needs that mapping?

> This look up table (which is just a list to allow the more complex
> boards to fill it from various places) serves that purpose.

And how is that shown by just a "bare" list being exported?  If you need
to provide such a mapping, then by all means do so, but do so in a
documented way with the proper locking for any data structures (which
again, was the most obvious bug you had with this patch.)

> >> All but one function that touches this are in
> >> the IIO core modules.  I can wrap this up but only at considerable
> >cost
> >> (the wrappers will basically be the various list functions with a
> >lock taken
> >> - I'll add one of those).  I can write extreme warnings around it
> >saying
> >> that it strictly for use by the IIO core.  Would that be acceptable?
> >
> >I still don't understand the point of the list.  Why is this somehow
> >different from any other bus in the kernel in that the only way to
> >"register" a device is to actually register the device.
> It is not for registering a device. It is for associations between
> devices. Similar to the regulator API. That provides a means to request
> a voltage from another device, this provides a means of reading from a
> device.

Ok, then show how that works somehow?  Again, a list doesn't show that
to me.

> Ultimately it's a convenient way of passing platform data.  We could
> pass it into every single supplier device (in a similar way to
> regulators) as platform data.  Thus every iio device would have to
> handle platform data and pass it on to the core, or, as here, we can
> separate it out.

Having a function for all of the drivers to call to provide this
information seems like the most obvious way to do this in a proper way,
why not do that?

> >> Clearly this element should stay in the IIO directory once the rest
> >of
> >> the header has gone into include/linux/iio/.  I can do that division
> >now
> >> so the separation is more apparent.
> >> 
> >> So in summary two options exist.
> >> 
> >> 1) Leave as is with a suitable warning and maybe rename to make it
> >appear
> >> less friendly.
> >> 2) Wrap it so we end up with accessors that are pretty much the
> >standard
> >> list accessors just with one parameter fixed and trivial locking.
> >This isn't
> >> too painful but seems conceptually wrong to me.
> >> 3) Move everything that uses it into the bit that gets built in even
> >> if IIO is a module.
> >
> >There should never be a "bit that is always built in if IIO is a
> >module", sorry.
> The only alternative is to make ever single IIO driver take platform
> data to specify it's consumers and immediately pass it into the core.
> It is only the core that cares.

What's wrong with a function call to the IIO core by the drivers?

> >> This last one will lead to an explosion in what is exported from IIO
> >as we
> >> will still need to have the divide between the bit that can be
> >modular and
> >> that which cannot somewhere! (which is why I didn't suggest it
> >> before).
> >
> >Why are you trying to make such a strange distinction here?  If a
> >device
> >uses IIO, then you need to have the IIO core.
> When that driver is loaded, not when the board file sets up it's
> association with IIO.  It will not be dependent on the driver
> supplying the channel anyway so we will need the backoff and
> try again stuff to make this work.
> 
> Why have I done it like this?
> 
> Because this way we get a fairly clean addition to the subsystem
> without having to rewrite every single driver's probe routine
> which is the only other way making the data available that I can
> see.

Rewriting all probe functions really shouldn't be hard as you have to
just change from manipulating this list by-hand, to making a function
call.  That sounds like an easy thing to do, and something that should
be done, right?

> > It can be built as a
> >module or not, again, just like any other bus in the kernel.
> Bus maybe, but other subsystems providing a 'service' like we
> have here for iio such as regulators, pinmux etc cannot be built
> as modules.  There the arguement was they were core to the
> board; that is not typically true of IIO.

Then keep the IIO core from being built as a module if that is the
requirement here.

Or, just be sure to initialize it early enough in the boot process that
it happens before the drivers are, and then, it can be a module, as long
as any driver that uses it is also a module, right?

Again, just like all other busses :)

thanks,

greg k-h
