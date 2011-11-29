Return-Path: <rubini@mail.gnudd.com>
Date: Tue, 29 Nov 2011 16:17:32 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: lars@metafoo.de
Cc: jic23@kernel.org, federico.vaga@gmail.com, linux-iio@vger.kernel.org,
        greg@kroah.com
Subject: Re: ZIO wiki analysis of IIO and why it doesn't meet there
 requirements [was Re: Industrial Input Output analysis]
Message-ID: <20111129151732.GA17244@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: rubini@gnudd.com
In-Reply-To: <4ED4ECAF.3040906@metafoo.de>
References: <4ED4ECAF.3040906@metafoo.de>  <4ED36B93.5020703@metafoo.de>
  <CAH5GJ0qTW_DwaAVhe6ZjGYg=1CPPVuQQn3biyg+2BuYHp1Hefw@mail.gmail.com>
 <4ED21960.1000002@kernel.org> <20111129110013.GA27762@mail.gnudd.com>
List-ID: <linux-iio@vger.kernel.org>

Hello Lars.

> Yes, but you can inject the meta information in userspace, this does not
> have to come from kernel space, or am I missing something.

It does not _have_, but it is useful to. For example, we can have a
monitoring application that looks at all meta-information flowing
while the real application handles the data.  The monitor didn't
configure the hardware, yet it can read the control files and be
synced with data flow.  (Support for multiple non-conflicting readers
is not implemented yet, but it's in the queue and it's pretty easy to
have).

> Hm, so the FPGA will sample the data on a trigger event and put it into the
> FPGA memory and the host CPU will periodically move data from this buffer to
> storage. Is this understanding correct?

More or less. The card will DMA. With appropriate buffers it will DMA
to user space or to mmapped memory (sure in this case only one reader
can have the data, but still the meta-data is available to many
users).

> Will the FPGA insert a timestamp per sample or per block moved from the FPGA
> to storage?

Per block. If it's a burst, you know the data rate anyways (for us it
is in the meta-data).

> What I meant was that you can actively contribute to IIO and implement the
> features you need and don't have to wait until they show up in the
> framework.

Yes, you are right, I'm aware of it. But you are also aware that it's
not that easily done, when the project has already taken some
directions.  Let me repeat: we'll keep an eye on IIO, even submitting
patches when it makes sense to (and I'm serious about it).

> E.g. most of the issue mentioned are minor and easy to fix.

But write support is not. Nor is DMA to user space or just mmap.

> I just think it's a waste of resources to develop two frameworks
> which have more or less the same architecture and serve the same
> purpose.

As I wrote in another message, I agree but not completely.  Shouldn't
we try different ideas any now and then? Otherwise we would all be
using comedi.  We have kde and gnome (I have neither), we have git and
mercurial, and a zillion other examples.

Maybe at the end we'll go IIO for the accelerators, but currently our
abstraction is much simpler to use.  Sure it lacks users at this
point, but I think it's worth pushing our abstraction further into
real data streams and concurrent users.

I think we'll knock for feedback again when we have some drivers and
some performance figures, meanwhile we'll continue developing in the
zio list, keeping an eye on iio.

thanks again for your feedback
/alessandro
