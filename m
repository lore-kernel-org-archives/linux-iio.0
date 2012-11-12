Return-Path: <gregkh@linuxfoundation.org>
Date: Sun, 11 Nov 2012 18:30:31 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL V2] IIO fixes for v3.7-rc1 set 2 (tiny fixes and
 regressions only)
Message-ID: <20121112023031.GB17405@kroah.com>
References: <50969678.6020700@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50969678.6020700@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Nov 04, 2012 at 04:23:20PM +0000, Jonathan Cameron wrote:
> Axel Lin (2):
>       iio: hid-sensor: Use __devexit annotation for remove()

This one, while maybe nice, sure isn't necessary as CONFIG_HOTPLUG can't
be turned off anymore.  So it's not needed for 3.7, right?

thanks,

greg k-h
