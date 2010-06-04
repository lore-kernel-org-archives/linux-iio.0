Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:58677 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab0FDRFD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2010 13:05:03 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:45356)
	by ppsw-33.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1OKaKL-0003cM-hN (Exim 4.70) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Fri, 04 Jun 2010 18:05:01 +0100
Message-ID: <4C093257.2070702@cam.ac.uk>
Date: Fri, 04 Jun 2010 18:05:27 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [RFC] Event handling: The next bit to clean up.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Having cleaned up a fair bit of the abi in the last kernel cycle,
the next question is where to focus core work this time.

As there are currently a number of interesting pieces of work going on
do with buffering elsewhere in the kernel, I'm inclined to say we should
leave that big issue for a while.  I might well put together patches to
allow multiple buffers, but it is an area that will remain fluid in the
near future.  Obviously if anyone else wants to offer work in this area
I'm certainly not going to object!

The other bit element of IIO that we may want to think about
is the event to userspace interface.  This is concerned with things
like threshold events (often called alarms in datasheets) and also
events from the buffers.  Note the buffers add a level of complexity as
we want to be able to do a fifo arrangement for events (for obvious reasons)
yet with buffers 'event escalation' - e.g. replace the 50% full with a
100% full event' saves userspace time and is a feature I'm keen to keep.

At the moment we basically push single event codes up to a character
device.  I am reasonably happy with how we are controlling the event
enabling and parameters though I'm not entirely sure we have gotten all the naming
conventions right as yet. Suggestions on changes here are welcome.

So the points I'd like to suggest for discussion are:

1) Lack of unified interface.
		The way we handle events doesn't correspond to how any
		other element of the kernel is doing it.  Do we care and
		if so what should we match?  (the obvious case is input).

2) Events that carry data.
		Some devices store 'triggered' results such as the value
		that broke the threshold or how long it was broken for.
		How do we want to handle this.  An example in the max1363
		which stores the 'triggering' value.
		Options include having 'latched' sysfs attributes that get
		you more data on an event, or adding data to the event
		itself via the character device (like input).  However this
		adds at least some cost to every event.

3) Should every event be a possible trigger.
		Personally I'm inclined to say no as it will lead to a sysfs
		file count explosion, but others may disagree and now would
		be the time to fix this if people care!

4) Input bridge.
		This came up yet again with regard to ambient light sensors
		and Linus' issues with ALS. There is demand for a bridge
		to allow (with sufficient configuration info) IIO devices
		to push to userspace via input.  Doing the data flow assuming
		some form of triggering, this is straight forward as we can simply
		have a 'to input' buffer implementation selectable for
		devices where this makes sense.  There are numerous complexities
		in the tying of events etc, but that is for another discussion
		after we have some example code in place.

  		With events, things are harder and I'm not quite sure how to do it.
		In a sense this is more	about whether events should have in kernel
		hooks.  What do people think? It will add complexity to a large
		subset of our drivers.  Do we make it a core thing, or leave it for
		drivers to handle themselves?

5) Multiple readers.
		Do we care?  Personally I say no.  If we do the current work
		on bufflocks (see linux-input) looks promising.

Anything else anyone would like to add to the discussion?

Thanks,

Jonathan


