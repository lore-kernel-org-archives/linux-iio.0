Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 10 Jun 2014 18:30:07 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>,
	linux-iio@vger.kernel.org
Subject: IIO drivers left in drivers/staging/
Message-ID: <20140611013007.GA32756@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

I'd really like to figure out what is left to do with all of the
remaining IIO staging drivers, and see if we can get them all moved out
soon.

As part of the OPW intern program, Kristina has agreed to help out with
staging kernel drivers and I thought that doing this type of work would
be a great task.  There seems to be a number of different types of
IIO drivers here, so that should keep her from being bored with just one
specific type of sensor.  There are also some "dummy" IIO drivers, which
I don't really understand what they are for (as well as why they remain
in staging.)

The drivers/staging/TODO file seems pretty old, being dated back in 2009
and not really done much with the exception of adding one entry.

So, any thoughts about what to do here?  Any pointers to devices that
she can aquire if that needs to happen, or APIs that need to be
standardized across types?

thanks,

greg k-h
