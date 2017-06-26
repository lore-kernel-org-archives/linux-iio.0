Return-Path: <SRS0=cSj6=57=linuxfoundation.org=gregkh@kernel.org>
Date: Mon, 26 Jun 2017 07:10:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of new device support, cleanups etc for IIO in
 the 4.13 cycle.
Message-ID: <20170626051017.GA24188@kroah.com>
References: <20170620171217.6f8dd834@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170620171217.6f8dd834@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jun 20, 2017 at 05:12:17PM +0100, Jonathan Cameron wrote:
> The following changes since commit 57d14635f976404fac165047389ff0dbe83bcd5b:
> 
>   staging: vchiq_core: Replace remaining BUG_ON with WARN_ON (2017-05-29 17:04:13 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.13b
> 
> for you to fetch changes up to 881b556f6cf22d37be9340f293f2db10ce7ae8bf:
> 
>   iio: imu: inv_mpu6050: test whoami first and against all known values (2017-06-13 21:18:17 +0100)
>

Now merged and pushed out, thanks,

greg k-h
