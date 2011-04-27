Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [RFC PATCH] IIO: break out const elements of iio_dev configuration
Date: Wed, 27 Apr 2011 15:58:37 +0200
Cc: linux-iio@vger.kernel.org,
 Michael.Hennerich@analog.com
References: <1303898975-26215-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303898975-26215-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201104271558.37971.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Wednesday 27 April 2011, Jonathan Cameron wrote:
> In conclusion max1363 gets bigger in all ways if we break this
> stuff out.  That is just down to the large number of devices supported.
> lis3l02dq which supports only one part gets smaller.
> 
> So not a clear descision either way as far as I am concerned, but
> putting the channel_spec into this structure is pretty costly for
> typical multipart drivers.
> 
> So the upshot of this RFC to my mind is: Is the clarity gained
> a good idea?
> 
> What do people think?

I suggested this initially, so it shouldn't surprise that I like
the patch.

For the increase in size, that seems to be purely because of the
change in one data structure from bool to pointer, right?
If you reorder the members of max1363_chip_info to remove the
padding, I think you can make up for that.

	Arnd
