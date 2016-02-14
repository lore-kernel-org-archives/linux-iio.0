Return-Path: <gregkh@linuxfoundation.org>
Date: Sun, 14 Feb 2016 11:12:46 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] Second round of IIO new device support, functionality and
 cleanups for the 4.6 cycle.
Message-ID: <20160214191246.GA28138@kroah.com>
References: <56C0985F.8080601@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56C0985F.8080601@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Feb 14, 2016 at 03:08:15PM +0000, Jonathan Cameron wrote:
> The following changes since commit e5349952de5b1138e6275529e4ec08c0ed33777f:
> 
>   staging: wilc1000: linux_mon: remove debug message of kmalloc failure (2016-02-03 15:34:29 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.6b
> 
> for you to fetch changes up to ecc24e72f43735cceab06f4e69aa6ce075a3ae46:
> 
>   iio: adc: Add TI ADS1015 ADC driver support (2016-02-13 20:54:15 +0000)

There was one merge issue with a Kconfig file,
drivers/iio/imu/inv_mpu6050/Kconfig, but I think I git the merge
correct, verifying it would be wise :)

thanks,

greg k-h
