Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 4 Jun 2012 21:20:53 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: michael.hennerich@analog.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 2/2] iio: frequency: New driver for Analog Devices
 ADF4350/ADF4351 Wideband Synthesizers
Message-ID: <20120605042053.GA6378@kroah.com>
References: <1338288080-15615-1-git-send-email-michael.hennerich@analog.com>
 <1338288080-15615-2-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1338288080-15615-2-git-send-email-michael.hennerich@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 29, 2012 at 12:41:20PM +0200, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Changes since V1:
> Apply Jonathan's review feedback:
>     Introduce and use IIO_ALTVOLTAGE.
>     Fix up comments and documentation.
>     Remove dead code.
>     Reorder some code fragments.
>     Add missing iio_device_free.

I get the following warning with this driver:

drivers/iio/frequency/adf4350.c:316:32: warning: ‘val’ may be used uninitialized in this function [-Wuninitialized]

Care to send a follow-on patch fixing this up?

thanks,

greg k-h
