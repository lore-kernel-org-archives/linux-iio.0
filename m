Return-Path: <alan@lxorguk.ukuu.org.uk>
Date: Fri, 30 Sep 2011 10:47:07 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: IIO (+ more general?) Error condition handling (e.g. wire fell
 out errors)
Message-ID: <20110930104707.0645afda@lxorguk.ukuu.org.uk>
In-Reply-To: <4E858F5A.5000901@cam.ac.uk>
References: <4E858F5A.5000901@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

> 3) Consider these out of band (from the out of band event data)
> and look at other options for reporting them.

Treat it like a socket/pipe perhaps - if it "goes down" then report it as
having hung up and deliver a SIGPIPE or similar and with an appropriate
error code for those catching it (-EIO ?)

That generally gets noticed.

> Is there anything general out there for reporting hardware failures
> that would be appropriate?  Sometime these conditions are the sort
> of thing that should cause a siren to go off.
> They might be sensor failure

There are two things here - one is making sure the app notices (where we
have equivalent handling in other interfaces) the other is what to do
about it. We don't have a general framework for reporting system
component failure. That's something that ought to get fixed generally to
report everything from "that new nasty smell was formerly your hard disk"
to a sensor fail.

> (p.s. I hope no one is using the current driver for trains, though
> that might explain British trains...)

Tssh... there is Linux on UK trains, but it's usually driving annoying
announcement/video systems.

Alan
