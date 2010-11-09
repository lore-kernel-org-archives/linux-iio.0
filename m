Return-Path: <greg@kroah.com>
Date: Tue, 9 Nov 2010 15:49:53 -0800
From: Greg KH <greg@kroah.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	mensch0815@gmail.com
Subject: Re: [PATCH] iio - add support for bmp085 barometer
Message-ID: <20101109234953.GA9001@kroah.com>
References: <4CCADE59.9070702@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CCADE59.9070702@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Oct 29, 2010 at 04:46:49PM +0200, Matthias Brugger wrote:
> This patch adds support for the Bosch Sensortec bmp085 digital
> barometer to the iio subsystem.
> 
> Signed-off-by: Matthias Brugger <m_brugger@web.de>
> ---
>  drivers/staging/iio/Kconfig            |    1 +
>  drivers/staging/iio/Makefile           |    1 +
>  drivers/staging/iio/barometer/Kconfig  |   12 +
>  drivers/staging/iio/barometer/Makefile |    5 +
>  drivers/staging/iio/barometer/baro.h   |    8 +
>  drivers/staging/iio/barometer/bmp085.c |  398
> ++++++++++++++++++++++++++++++++

The patch is line-wrapped and can't be applied :(

Care to get Jonathan's ack and resend it in a format I can apply it in?

thanks,

greg k-h
