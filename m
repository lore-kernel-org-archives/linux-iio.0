Return-Path: <jic23@cam.ac.uk>
Message-ID: <4DA49C00.7070606@cam.ac.uk>
Date: Tue, 12 Apr 2011 19:37:52 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH 0/8] staging:iio:mixed bag of fixes and cleanups.
References: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 03/17/11 21:00, Jonathan Cameron wrote:
> I should probably have broken these up into more coherent subsets
> and made at least the allocate priv_data one an RFC.
> May do so before sending on to Greg.
> 
> Patches 3, 4 and 6 are direct results of suggestions from Arnd Bergmann.
> Basically it's the easy bits of the discussion before we get onto
> the more 'interesting' ones.
> 
> 1, 2 are things I spotted whilst working on the irq_chip stuff
> Thomas Gleixner suggested.  They are just cleanups of some bizare
> corners. That rewrite of triggers currently requires some
> exports to be added to allow a modular build and I need to chase
> down whether we are simply the first people to have a reasonable
> case for it, or whether there is something more fundamental
> going on.
> 
> The others are bugs / cleanups I came across whilst hammering
> max1363 with the new example code. Some of the timestamp bit
> was pointed out by Michael Hennerich a while back, but turns
> out the driver was broken as well as not obeying the ABI.
> 
> Thanks,
Gone to Greg. Note this set will break any drivers that are currently
out of tree. Simplest fix is trivial

iio_allocate_device() -> iio_allocate_device(0)

Note for new drivers I'll be encouraging people to use the new
allocation stuff though.

Jonathan
