Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 24 Dec 2013 10:22:58 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO fixes 3.13 - set 4
Message-ID: <20131224182258.GA4587@kroah.com>
References: <52B71A03.5000907@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52B71A03.5000907@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Dec 22, 2013 at 04:57:39PM +0000, Jonathan Cameron wrote:
> The following changes since commit c6236c0ce39c809c336ca929f68cf8ad02cf94e0:
> 
>   staging: comedi: drivers: fix return value of comedi_load_firmware() (2013-12-17 13:05:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.13d
> 
> for you to fetch changes up to 83d5f3246fc05a629278240c09688fd9960b97db:
> 
>   staging:iio:ad799x fix incorrect endianness specification for buffer elements (2013-12-17 21:50:54 +0000)
> 
> ----------------------------------------------------------------
> 4th round of iio fixes for the 3.13 cycle.
> 
> * Another miss reported endian fix that missed the last pull request due
>   to a bug in the first version posted (which made it look like a cleanup
>   rather than a fix).

Is this a regression fix?  Can it wait for 3.14-rc1 and then go into
3.13-stable as I really didn't want to have any more pull requests for
3.13-final due to vacations...

thanks,

greg k-h
