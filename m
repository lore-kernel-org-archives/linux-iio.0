Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 2/3] staging:iio:lis3l02dq - experimental move to new channel_spec approach.
Date: Fri, 25 Mar 2011 17:02:01 +0100
Cc: linux-iio@vger.kernel.org
References: <1300997125-2896-1-git-send-email-jic23@cam.ac.uk> <201103251526.16233.arnd@arndb.de> <4D8CB6EF.2000808@cam.ac.uk>
In-Reply-To: <4D8CB6EF.2000808@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201103251702.02292.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Friday 25 March 2011, Jonathan Cameron wrote:
> > I need some background information here. Why do you expose the configuration
> > register directly? Is this something that users normally access?
> > 
> > I would assume that it's highly device specific and would need to be
> > abstracted by the kernel.
> We could cache what events are enabled, and in some drivers we do.  Here it is
> just simpler to ask the device as it has a convenient bitmap of what is enabled.
> 
> It's actually a real pain to completely abstract this away because some
> devices only support sets of events at a time and exactly which are
> supported can be extremely complex.  The common cases are:
> 
> 1) Separate comparators for each event. (simple as we have here!)
> 2) n comparators which can be configured to any n events from a large list (adis16350
>         is a classic example though we haven't finally merged event support for that
>         part yet).
> 3) n comparators each of which can be configured to a subset of thresholds. e.g. one
>         comparator per channel, lots of different things it can compare about the channel.
> 
> It is possible that we can abstract these at some point, but right now I'm not even
> tempted to try!  We are mostly avoiding the nastiest case at the moment which is
> where you have controllable compound events.  In this particular device you can
> either have the events as 'or' as we do or 'and' for any set of them.  Right now
> we simply don't implement the 'and' case. 

Ok, thanks for the explanation.

	Arnd
