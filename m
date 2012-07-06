Return-Path: <gregkh@linuxfoundation.org>
Date: Fri, 6 Jul 2012 16:03:27 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO fixes v3.5-rc4
Message-ID: <20120706230327.GA22495@kroah.com>
References: <4FEEEFF8.8050305@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FEEEFF8.8050305@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 30, 2012 at 01:24:24PM +0100, Jonathan Cameron wrote:
> Hi Greg,
> 
> Please consider pulling the following fixes.
> 
> I've based these on your staging-linus branch which happens
> right now to be v3.5-rc4.
> 
> None are exactly critical if you want to hold them for the next
> merge window.
> 
> Obviously any suggestions / requests on how to do these pull
> requests welcomed!
> 
> The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:
> 
>   Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git fixes-togreg

I took these into the staging-next tree as they didn't look all that
important for 3.5-final.

As for pull requests, this was great, but could you use signed tags to
create a pull request?  That way the information you provided here will
be in the merge message, and I will have a better chance that I, and
others, "know" it came from you.

thanks,

greg k-h
