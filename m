Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:48974 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaGDJf1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jul 2014 05:35:27 -0400
Message-ID: <1404466519.3732.1.camel@nuvo>
Subject: Re: User-space API for accelerometer(s)?
From: Bastien Nocera <hadess@hadess.net>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Reyad Attiyat <reyad.attiyat@gmail.com>,
	linux-iio@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 04 Jul 2014 11:35:19 +0200
In-Reply-To: <53B59837.8080907@jic23.retrosnub.co.uk>
References: <1403100542.30918.29.camel@nuvo>
			 <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>
			 <53A224AB.9090305@linux.intel.com> <1403176834.30918.32.camel@nuvo>
		 <53A57414.8000104@kernel.org> <1404216616.7785.1.camel@nuvo>
	 <53B59837.8080907@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 2014-07-03 at 18:51 +0100, Jonathan Cameron wrote:
> On 01/07/14 13:10, Bastien Nocera wrote:
> > Hey again Jonathan,
> >
> > On Sat, 2014-06-21 at 13:01 +0100, Jonathan Cameron wrote:
> > <snip>
> >> Just to throw it in there.  There is an out of tree bridge driver from
> >> IIO to input.  It's only out of tree because I haven't had a chance to
> >> tidy it up (anyone else is welcome to take this on if they like!)
> >> Google for iio_input.c to find it.
> >>
> >> The intent of that was to allow general accelerometer drivers and similar
> >> in IIO to work in conjunction with iio-input to provide input style interfaces.
> >> This came about after previous debates on where the 'right' place for
> >> accelerometers was in the kernel. I believe that at least in principle,
> >> Dmitry was happy with this concept.
> >
> > After updating forward-porting the driver so that it runs on a more
> > recent version of the kernel, I tried to get it running.
> >
> > I'm guessing that you expected the iio_input driver to be instantiated
> > by a board specific file. Is there any way to have it generically try
> > out all the IIO devices, similarly to pci_register_driver()? Or should I
> > do that in the hid-sensor-accel driver?
> At the moment we only have support to instantiate it via such a board specific
> file. We probably want to be a little careful about how to add more generic
> means for creating such bindings..
> 
> Simply generically trying all IIO drivers isn't the way to go as there is
> no obvious way of deciding what it makes sense to bind to on a given machine.
> 
> Perhaps something closer to the way you can instantiate i2c devices from
> userspace, or perhaps we need to consider something else such as configfs for
> creating such bindings... (cc'd Lars for comments on whether that makes sense...)

Are there cases where we have a hid-sensor that we wouldn't want to
expose through the input layer?

> We did also have a uinput based approach at one point but it was fairly clunky.
> That took data from iio buffers and pushed it back into the kernel via inputs
> userspace driver support. Not particularly nice but I thought I'd best mention
> it!

That's actually something that I looked at and discussed with Benjamin.
And it currently looks like the best possible solution in the short-term
(I will only have the machine for a couple more weeks...).

Cheers

