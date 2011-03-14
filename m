Return-Path: <greg@kroah.com>
Date: Mon, 14 Mar 2011 11:49:48 -0700
From: Greg KH <greg@kroah.com>
To: michael.hennerich@analog.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org, drivers@analog.com,
	stable@kernel.org, device-drivers-devel@blackfin.uclinux.org
Subject: Re: [stable] [PATCH] IIO: IMU: ADIS16400: Fix miscellaneous issues
Message-ID: <20110314184948.GA21004@kroah.com>
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

In looking at this further, this should be broken up into one patch per
thing, like all good kernel patches should be.

Especially as you are wanting this to go into the stable tree.

So, please resend this and only mark the ones you feel are needed in
stable, with the proper "Cc: stable <stable@kernel.org>" in the
signed-off-by area.

thanks,

greg k-h
