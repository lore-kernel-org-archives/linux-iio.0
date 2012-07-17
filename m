Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 16 Jul 2012 17:58:43 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [GIT PULL] iio fixes for staging/staging-next.
Message-ID: <20120717005843.GA16382@kroah.com>
References: <500309B8.60009@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <500309B8.60009@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jul 15, 2012 at 07:19:36PM +0100, Jonathan Cameron wrote:
> The following changes since commit 2b6e6b8042a9f783170b0a15e0550a075381726e:
> 
>   staging: comedi: rtd520: remove RtdDio0Read macro (2012-07-13 08:12:31 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git fixes-togreg
> 
> for you to fetch changes up to dcbc3c414e62faa4e1a1e17421f89eceea6bee30:
> 
>   iio staging: fix cast warning and cleanup alignment code (2012-07-15 17:33:18 +0100)
> 
> ----------------------------------------------------------------
> 3 types of fix here.

Subsystem?  Some kind of hint please?

> 
> 1) Incorrect pointer casting via phys_addr_t which causes
>    trouble on some architectures.
> 2) request_irq and free_irq dev_id parameters not matching.
> 3) Inconsistencies in client_data for some i2c devices
> (writing one pointer and expecting another later).

Also, none of this showed up in the tag listed above.  And odds are, the
above is really a branch, not a tag, did you forget to push the tag and
wait for it to propage to the public side before creating this pull
request?

Care to try it again?

Oh, at least you aren't line-wrapping :)

thanks,

greg k-h
