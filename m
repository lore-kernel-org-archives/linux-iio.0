Return-Path: <greg@kroah.com>
Date: Thu, 10 Mar 2011 10:18:25 -0800
From: Greg KH <greg@kroah.com>
To: michael.hennerich@analog.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org, drivers@analog.com,
	stable@kernel.org, device-drivers-devel@blackfin.uclinux.org
Subject: Re: [stable] [PATCH] IIO: IMU: ADIS16400: Fix miscellaneous issues
Message-ID: <20110310181825.GA27171@kroah.com>
References: <1299774506-8620-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299774506-8620-1-git-send-email-michael.hennerich@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 10, 2011 at 05:28:26PM +0100, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Fix up SPI messages cs_change behavior
> Add delay after self test
> Fix product ID check, skip embedded revision number.
> Fix addresses of GYRO and ACCEL calibration offset.
> Make sure only enabled scan_elements are pushed into the ring
> 
> Changes since V1:
> fix white space issues
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Hint, blindly adding stable@kernel.org in the Cc: list when sending out
a patch is NOT the way to get patches into the stable kernel releases.

Please read Documentation/stable_kernel_rules.txt for how to do it
correctly.

thanks,

greg k-h
