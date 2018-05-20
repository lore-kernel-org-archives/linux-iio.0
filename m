Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751935AbeETQLU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 12:11:20 -0400
Date: Sun, 20 May 2018 17:11:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [RFC] Spectral ID sensor + floating point questions
Message-ID: <20180520171116.1fc57939@archlinux>
In-Reply-To: <CAJCx=g=9XoXygjdQ9r410jerbtDxOvUtN0a+KAdnj2OAb_1WGg@mail.gmail.com>
References: <CAJCx=g=9XoXygjdQ9r410jerbtDxOvUtN0a+KAdnj2OAb_1WGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 20 May 2018 22:21:03 +0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Jonathan et all,
> 
> Currently looking at ams AS7262 Spectral ID sensor, and thinking about
> adding support to enable a project I'm working on.
> 
> But I noticed it is a bit odd in that outputs data for the 6 color
> channels in either a) raw 16-bit ADC values b) or calibration adjusted
> values (factory calibration) but are presented as 32-bit single
> precision floats.
> 
> Clearly the latter data is  much more useful but of course it is a
> floating point which isn't exactly the ideal in the kernel and there
> isn't a precedent in iio (that I know of) for such values.
> 
> Datasheet: https://www.mouser.com/ds/2/588/AS7262_DS000486_2-00-1082195.pdf
> 
> Any thoughts, or suggestions?

Hmm. Will need to think about this a little, but from a very high
level look at the datasheet and you description, there is nothing technically
stopping us supporting devices that do standards compliant floating point.

The only similar case we have run into in the past was the mess of the HID
sensor spec which could in theory change range over time and report it
via the event path.  Thankfully I don't think we have ever seen a part
that actually does this. That was tricky because it wasn't in a standard
format and so pretty much required in kernel reformatting.

As this is real floating point, we probably just want to pass it straight
through to userspace using the buffered interface and a suitable
description of the type.

What we can't sensibly do is any in kernel consumers (as they'd have
to do fp maths) or anything involving maths in kernel on these.

We could do read_raw support with a suitable float to str function if
it is potentially useful...  

So I'm not totally against the idea.

However, we do need better description of light channels as giving
them colors is only going to get us so far as these devices expand
their number of channels and bring in the frequency range for each.
Go for generality when you work this one out.

Fun looking part. I hope you go ahead with this one.

Jonathan

> 
> Thanks,
> 
> Matt

