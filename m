Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 11 Feb 2013 10:00:54 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO cleanups, new drivers and fixes (IIO set 4 for the
 3.9 cycle)
Message-ID: <20130211180054.GA12528@kroah.com>
References: <51181368.8070107@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51181368.8070107@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Feb 10, 2013 at 09:38:48PM +0000, Jonathan Cameron wrote:
> The following changes since commit 82e9ee616a89f152f42c7051c5f9f5f0d7663652:
> 
>   staging: comedi: ni_mio_cs: use pcmcia_request_irq() (2013-02-05 18:16:19 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.9d

Hm, I said on Friday that my staging tree was closed for 3.9 stuff, but
I snuck this on in.

Now pulled and pushed out, please, only bugfixes for 3.9 from now on.

thanks,

greg k-h
