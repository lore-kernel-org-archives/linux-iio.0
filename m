Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: IIO comments
Date: Wed, 16 Mar 2011 19:52:07 +0100
Cc: linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Greg KH <greg@kroah.com>
References: <201103152215.20059.arnd@arndb.de> <4D80A5B5.2020805@cam.ac.uk> <4D80EB5F.6030805@cam.ac.uk>
In-Reply-To: <4D80EB5F.6030805@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103161952.07486.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Wednesday 16 March 2011 17:54:55 Jonathan Cameron wrote:
> >> * iio_allocate_device() could get a size argument and
> >> allocate the dev_data together with the iio_dev in 
> >> a single allocation, like netdev_alloc does. In addition,
> >> you can pass a structure with all constant data, such
> >> as THIS_MODULE, and the operations and/or attribute groups,
> >> instead of having to set them individually for each dev.
> > Good idea.
>
> There is an issue here I'd forgotten.  Some of our structures have a
> elements which are cacheline aligned.  For first version of this I'll
> set our alignment requirements as L1_CACHE_BYTES.  Would be nice to be
> able to relax that down the line though as it means we use at least two
> cachelines even if we don't care about that alignment requirement.

I think the data used by a device structure is not really an issue,
especially extending it by just another cache line.

	Arnd
