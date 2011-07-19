Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [RFC PATCH 0/7] IIO: Reduce to 1 the number of chrdevs per device
Date: Tue, 19 Jul 2011 16:27:19 +0200
Cc: linux-iio@vger.kernel.org,
 manuel.stahl@iis.fraunhofer.de,
 device-drivers-devel@blackfin.uclinux.org
References: <1310997004-22728-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310997004-22728-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201107191627.20087.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Monday 18 July 2011, Jonathan Cameron wrote:
> 4 uses Arnd's suggestion of an annon_fd obtained via ioctl on the buffer
> chrdev to get a file for easy use for reading events.  This is a very neat
> solution that lets us keep the actual event system separate from the data
> stream without two chrdevs.

IMHO, the series looks good overall, but you need to fix the iio_ioctl
function to take a proper ioctl command: you check for 'cmd == 0', which is
not allowed by convention.
Please use the _IOR() macro to define a number and document the command
range in Documentation/ioctl/ioctl-number.txt.

Also, you should have a .compat_ioctl file operation that points to
the same function, to make sure that the interface works in 32 bit
processes running on a 64 bit kernel.

	Arnd
