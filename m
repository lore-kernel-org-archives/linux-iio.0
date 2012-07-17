Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jul 2012 10:30:04 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [GIT PULL v2] iio fixes for staging/staging-next.
Message-ID: <20120717173004.GA17718@kroah.com>
References: <500309B8.60009@kernel.org>
 <20120717005843.GA16382@kroah.com>
 <50059E28.1080809@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50059E28.1080809@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 17, 2012 at 06:17:28PM +0100, Jonathan Cameron wrote:
> 
> The following changes since commit 2b6e6b8042a9f783170b0a15e0550a075381726e:
> 
>   staging: comedi: rtd520: remove RtdDio0Read macro (2012-07-13 08:12:31 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-3.6b
> 
> for you to fetch changes up to dcbc3c414e62faa4e1a1e17421f89eceea6bee30:
> 
>   iio staging: fix cast warning and cleanup alignment code (2012-07-15 17:33:18 +0100)
> 
> ----------------------------------------------------------------
> IIO fixes for elements queued for 3.6 merge window.
> 
> 3 types of fix here.
> 
> 1) Incorrect pointer casting via phys_addr_t which causes
>    trouble on some architectures.
> 2) request_irq and free_irq dev_id parameters not matching.
> 3) Inconsistencies in client_data for some i2c devices
> (writing one pointer and expecting another later).

Yeah!

That all looks great, thanks for working with me on these little
complaints, I appreciate it.

All pulled and pushed out, thanks.

greg k-h
