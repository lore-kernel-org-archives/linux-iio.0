Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753013AbeAFNMf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 08:12:35 -0500
Date: Sat, 6 Jan 2018 13:12:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [RFP] iio: Support of gesture sensor as a standard IIO sensor
Message-ID: <20180106131231.078492c3@archlinux>
In-Reply-To: <20180106002024.012f44c0@alans-desktop>
References: <1515197240.26317.65.camel@intel.com>
        <20180106002024.012f44c0@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 6 Jan 2018 00:20:24 +0000
Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:

> > >From an IIO sensor point of view A Gesture sensor:    
> > Outputs
> > 	A pre defined activity type
> > 		WAKE
> > 		TILT
> > 		GLANCE
> > 		PICK_UP
> > 		 &
> > 		 more
> > 
> > 	A user defined activity type as "string"
> > 
> > Inputs
> > 	A raw binary cdev interface to download templates/patterns
> > 
> > 
> > I want to gather more opinions before submitting a RFC patch.  
> 
> The only question I have is should it appear under IIO or should it be an
> input event interface. It feels to me more like an input device in that in
> this case while it's not keys or joystick it is still 'please do X'. That
> might also make it much easier (in the non-Android space in particular)
> to bind these activities to actions in things like web browsers.
> 
I agree that this may well be an option for many of the gestures specifically
metioned (flicks etc and glyphs).

However, there are other obvious uses of this technology such as step detection
or activity classification (running, walking sitting) that so far have fallen
in the scope of IIO as they aren't really things you expect the device to
perform an an action in response to.  Another one of those messy corners
that fall through the gaps!

The drivers/iio/accel/mma9553.c does activity detection, but that isn't
really 'events' in the same way as we have here...

So right answer might be a hybrid of an underlying flexible IIO device
and an input front end for when it makes sense.

We probably need to get the in kernel use of IIO events sorted.  Non event
stuff has been sorted for years, but this last corner was never of enough
interest to anyone to actually implement it (it's fairly straight forward
to do).

> (+ linux-input)
> 
> Alan

