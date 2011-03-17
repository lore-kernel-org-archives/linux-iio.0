Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53284 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab1CQNrX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Mar 2011 09:47:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: IIO comments
Date: Thu, 17 Mar 2011 14:47:17 +0100
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
	Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <guenter.roeck@ericsson.com>
References: <201103152215.20059.arnd@arndb.de> <201103161433.31303.arnd@arndb.de> <4D80CE2E.9000407@cam.ac.uk>
In-Reply-To: <4D80CE2E.9000407@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103171447.17960.arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I just went back to the older email and noticed that I missed some of your
important replies.

On Wednesday 16 March 2011, Jonathan Cameron wrote:
> > I'm slightly confused, mainly because I have no idea how the
> > buffer and event interfaces are actually being used. I would
> > have expected an interface as simple as:
> > 
> > * One iio device per sensor that can provide data, possibly
> >   many per hardware device
>
> One per device.

I'm not sure what that means. One iio device per hardware device?

What about hardware devices that have multiple unrelated streams
of buffered input data?

> > * One chardev for each iio device
>
> currently 1-3. (event line, buffer access, buffer event)

It would be really nice to unify this, as I said. What
are the reasons why you think it cannot or should not be
done?

> > * Use epoll to wait for data and/or out-of-band messages
> > * Use chrdev read to get events from the buffer
>
> and data?

I mean get the data associated with the event. The event
itself as you said does not have any data, so we would not
need to read it, just to use poll()/epoll() in order to
wait for it.

> > * Use sysfs to read from sensors that are not event based
> > 
> > What you have is obviously more complex than this, and you
> > probably have good reasons that I still need to understand.

	Arnd
