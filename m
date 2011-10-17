Return-Path: <greg@kroah.com>
Date: Mon, 17 Oct 2011 15:39:07 -0700
From: Greg KH <greg@kroah.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jonathan Cameron <jic23@cam.ac.uk>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] staging:iio:dac Add AD5064 driver
Message-ID: <20111017223907.GA19757@kroah.com>
References: <1318837110-3462-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318837110-3462-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 17, 2011 at 09:38:30AM +0200, Lars-Peter Clausen wrote:
> This patch adds support for the Analog Devices AD6064, AD6064-1, AD6044, AD6024
> quad channel digital-to-analog converter devices.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Please test your patches:

FATAL: drivers/staging/iio/dac/ad5064: sizeof(struct i2c_device_id)=32 is not a modulo of the size of section __mod_i2c_device_table=200.
Fix definition of struct i2c_device_id in mod_devicetable.h

This breaks the build :(

greg k-h
