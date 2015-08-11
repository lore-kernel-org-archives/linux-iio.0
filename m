Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 10 Aug 2015 17:06:10 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] 4th set of IIO fixes for the 4.2 cycle
Message-ID: <20150811000610.GC31712@kroah.com>
References: <55C6536E.3030300@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C6536E.3030300@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Aug 08, 2015 at 08:07:26PM +0100, Jonathan Cameron wrote:
> The following changes since commit 40c3ef9d2f14cce91dbd6ae9c9ccf6210d8c5df7:
> 
>   staging: comedi: das1800: add missing break in switch (2015-07-31 16:59:47 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.2d

Can these wait for 4.3-rc1?  I'd like my last set of pull requests to be
the last one for 4.2.  If it's a big deal, we can mark these for -stable
and get them into 4.2.1?

thanks,

greg k-h
