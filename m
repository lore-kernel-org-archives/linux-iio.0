Return-Path: <Robin.Getz@analog.com>
From: "Getz, Robin" <robin.getz@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: Userspace libs
Date: Mon, 18 Feb 2013 15:15:35 -0500
CC: Jonathan Cameron <jic23@cam.ac.uk>, "Clausen, Lars-Peter"
	<Lars-Peter.Clausen@analog.com>, "Hennerich, Michael"
	<Michael.Hennerich@analog.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
References: <201302131412.58742.robin.getz@analog.com> <511F7FA5.7060805@kernel.org>
In-Reply-To: <511F7FA5.7060805@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-ID: <201302181515.36379.robin.getz@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Sat 16 Feb 2013 07:46, Jonathan Cameron pondered:
> On 02/13/2013 07:12 PM, Getz, Robin wrote:
> > Jonathan:
[snip]
> > I would like to re-write some of the existing iio-utils.h (so iio device
> > context is managed by the application), to become a little more thread
> > friendly, and also merge in some of the networking piece - so when using
> > a headless embedded device - userspace doesn't need to change/manage
> > things much.
>
> All the above looks good and it is very nice to have some non trivial
> userspace support. I'll be happy to see any updates/cleanups to iio-utils.h
> but keep in mind that it is only really meant to be a trivial in kernel
> tree example. 

is there any performance metrics that we want the in-tree version to hit?

The existing versions are certainly slim on memory, but use malloc, which may 
cause memory leaks if the person on the application side isn't careful 
freeing things, or cause performance issues, or just cause plain failures in 
low memory embedded systems...

> The original plan was to have a separately maintained 
> userspace library to do things 'properly'.

Where was this suppost to live?

> I guess it depends on exactly what changes you are thinking of. 

There are some features which we use to "self-discover" the installed 
devices/drivers.

return a string of names

handle unsigned ints in the read/write functions

Some minor stuff.

> The networking stuff in particular 
> might introduce some non kernel dependencies that may or may not be a
> problem.

Ack - I think that sits beside yours. iio_utils_attach.h and the network one 
is iio_utils_net.h (ot something like that). It's the same structures, 
similar function names, it's does it include a IP address, or a path...

> > Is there a list of other things people want to see from userspace? [2]
>
> Nope.  Probably should be though. Well volunteered!
> Right now we don't really have a clean list of what people want on the
> kernel side, just a lot of randomly scattered mailing list threads.

Any in specific stand out?


> >
> > [1] Which reminds me - is this planned on moving out
> > of ./drivres/staging/iio/Documentation  into ./Documentation/iio ?
>
> err.  Yes.  Keep forgetting to do it.  Ah well next cycle ;)
> Lots of stuff still to move in general.

Thanks.

> > [2] I have been going through:
> >   - zio-dump   http://www.ohwr.org/projects/zio/wiki/Readme
> >   - Comedilib  various
> > ?
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
