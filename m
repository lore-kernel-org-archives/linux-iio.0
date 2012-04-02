Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 2 Apr 2012 11:05:44 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jon Brenner <jbrenner@TAOSinc.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: TAOS Color sensor
Message-ID: <20120402180544.GA21374@kroah.com>
References: <B4B07CCC7B7A084E989CF9386538EA1D0120B2C6@exchsrvr.taosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B4B07CCC7B7A084E989CF9386538EA1D0120B2C6@exchsrvr.taosinc.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Apr 02, 2012 at 12:28:39PM -0500, Jon Brenner wrote:
> There is a need to release a driver for the TAOS tsl3x7x family of COLOR
> sensors.
> The driver provides Lux (clear and IR) , Proximity, Color temperature
> (calculated CCT) and raw - red, green, and blue data channels.
> Currently I do not think the IIO subsystem provides for CT or RGB data
> channels.
> Is this correct?
> What can be done to accommodate it and who can do it?

Do you have a driver written already for this?  What is the interface to
the device?  If this can this use the v4l layer to get the color channel
information out to userspace?

Or is this needed to be done in the kernel at all, lots of color sensors
are driven by libusb today, like the one on my desk at the moment, no
kernel changes needed at all.

thansk,

greg k-h
