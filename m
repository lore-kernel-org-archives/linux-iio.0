Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:43696
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754651Ab1K3Psy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2011 10:48:54 -0500
From: "Getz, Robin" <robin.getz@analog.com>
To: Alessandro Rubini <rubini@gnudd.com>
Subject: Re: [Device-drivers-devel] ZIO wiki analysis of IIO and why it doesn't meet there requirements [was Re: Industrial Input Output analysis]
Date: Wed, 30 Nov 2011 10:47:24 -0500
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"greg@kroah.com" <greg@kroah.com>,
	"federico.vaga@gmail.com" <federico.vaga@gmail.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
References: <4ED4D611.7030701@analog.com> <20111129110013.GA27762@mail.gnudd.com> <20111129144449.GA14261@mail.gnudd.com>
In-Reply-To: <20111129144449.GA14261@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-ID: <201111301047.25521.robin.getz@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2011-11-29 15:17:32 GMT Alessandro wrote:
>On 2011-11-29 14:31:11 GMT Lars-Peter wrote:
> > I just think it's a waste of resources to develop two frameworks
> > which have more or less the same architecture and serve the same
> > purpose.
>
> As I wrote in another message, I agree but not completely.  Shouldn't
> we try different ideas any now and then? 

trying ideas in-kernel is a great idea.
Changing the userspace ABI isn't.

> Otherwise we would all be 
> using comedi.  We have kde and gnome (I have neither), we have git and
> mercurial, and a zillion other examples.

I think there is a huge difference between different applications in 
userspace, and different kernel interfaces - creating incompatible userspace 
applications.

While it was true that there was some overlap in the early iio in staging with 
other interfaces - I think most of them have been cleaned up, and the 
duplication has mostly disappeared - I think this was a requirement from 
Greg, and other subsystem maintainers.

I have been complaining for awhile about the similarities between comedi and 
iio, and the userspace problem (people wanting to prototype on a desktop with 
a PCIe card with comedi, are going to need to re-write their entire 
application when moving to an embedded target) - but have not had the time to 
contribute anything to solve the problem.

Using the IIO/Comedi overlap as justification to make a third subsystem which 
overlaps both.... I'm not sure I follow the logic.

On 2011-11-29 18:05:53 GMT, Mark Brown pointed out:
>It's also problematic for driver authors if we end up having to work
>with two separate frameworks that fulfil the same function depending on
>which application users end up using.

Which I think sums up my big concern.


> > But I'm pretty optimistic that there is nothing in IIO which
> > prevents me from getting the right solution in place.
>
> No, definitely. We'll keep our eyes open on the project, maybe the
> final choice will be IIO for our use case, but it's too early to know.

No one is saying that the points you make about IIO aren't valid, or that ZIO 
isn't going to work -- what I think everyone is saying - is let's talk about 
things, and determine what the end user needs are, and what the best solution 
is (It's not like in kernel subsystems don't get re-written over time, but 
the kernel/userspace ABI needs to be stable).

I think all anyone is saying is please give us more feedback, and stay 
involved.

> but currently our abstraction is much simpler to use. 

I don't think that IIO is complicated - but it might be. It's easy to say that 
when you are familiar with something. I'm sure that the documentation needs 
more work - if you want to point out the sections that aren't clear - let us 
know.

It also could be that ZIO doesn't handle the end user cases which created the 
need for the "complication" in the API... It's difficult to say without more 
details.

>I think we'll knock for feedback again when we have some drivers 
>and some performance figures, meanwhile we'll continue developing in 
>the zio list, keeping an eye on iio.

I think that's OK - but again - it would be good for everyone here to better 
understand your use cases - so when we are working on our AD9739A 2.4 GSPS 
DAC IIO driver, we can try to make sure that we incorporate what you are 
looking for.

The hardware (PCB) description, and HDL only solution is here:
http://wiki.analog.com/resources/fpga/xilinx/fmc/ad9739a
we are just waiting for production hardware to show up to start on the IIO 
side...

-Robin

