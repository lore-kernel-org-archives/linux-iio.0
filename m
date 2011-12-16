Return-Path: <greg@kroah.com>
Date: Fri, 16 Dec 2011 08:24:57 -0800
From: Greg KH <greg@kroah.com>
To: archive@jic23.retrosnub.co.uk
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	lars@metafoo.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 3/5] staging:iio:core add in kernel interface mapping and
 getting IIO channels.
Message-ID: <20111216162457.GA5403@kroah.com>
References: <1323122164-32314-1-git-send-email-jic23@kernel.org>
 <1323122164-32314-4-git-send-email-jic23@kernel.org>
 <20111208194057.GA28532@kroah.com>
 <4EE39205.6030109@kernel.org>
 <20111210191524.GA17929@kroah.com>
 <20111216085057.3DE4240390@saturn.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111216085057.3DE4240390@saturn.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Dec 16, 2011 at 08:50:57AM +0000, archive@jic23.retrosnub.co.uk wrote:
> >And how are you guaranteing that anyone walking the list is doing so in
> >a "safe" manner?  What's to keep an entry from being removed while some
> >random kernel code is walking it?
> >
> >Hint, don't allow direct access to this list, if you do so, you are in
> >for a world of hurt...
> The entire purpose of this list is to allow a small built in chunk of
> code to fill it up (typically from board files) whilst the rest of IIO can
> still be built as a module.

Why are you trying to do that?

> All but one function that touches this are in
> the IIO core modules.  I can wrap this up but only at considerable cost
> (the wrappers will basically be the various list functions with a lock taken
> - I'll add one of those).  I can write extreme warnings around it saying
> that it strictly for use by the IIO core.  Would that be acceptable?

I still don't understand the point of the list.  Why is this somehow
different from any other bus in the kernel in that the only way to
"register" a device is to actually register the device.

> Clearly this element should stay in the IIO directory once the rest of
> the header has gone into include/linux/iio/.  I can do that division now
> so the separation is more apparent.
> 
> So in summary two options exist.
> 
> 1) Leave as is with a suitable warning and maybe rename to make it appear
> less friendly.
> 2) Wrap it so we end up with accessors that are pretty much the standard
> list accessors just with one parameter fixed and trivial locking. This isn't
> too painful but seems conceptually wrong to me.
> 3) Move everything that uses it into the bit that gets built in even
> if IIO is a module.

There should never be a "bit that is always built in if IIO is a
module", sorry.

> This last one will lead to an explosion in what is exported from IIO as we
> will still need to have the divide between the bit that can be modular and
> that which cannot somewhere! (which is why I didn't suggest it
> before).

Why are you trying to make such a strange distinction here?  If a device
uses IIO, then you need to have the IIO core.  It can be built as a
module or not, again, just like any other bus in the kernel.

greg k-h
