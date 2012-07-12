Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 12 Jul 2012 12:35:00 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [GIT PULL] IIO enhancements for staging-next
Message-ID: <20120712193500.GB2601@kroah.com>
References: <4FFF239F.5090502@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FFF239F.5090502@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jul 12, 2012 at 08:21:03PM +0100, Jonathan Cameron wrote:
> The following changes since commit c732a24c5a9392cf3738f5957e0d97d37c09e6e1:
> 
>   staging:iio:adt7410: use local platformdata if none is specified
> (2012-07-08 10:39:59 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> tags/togreg-3.6a

Again linewrap :(

Anyway, how about making the tags, and the descriptions in the tag, a
bit more IIO-specific?  So that I, and others, know what the merge was?

Something like "iio-3.6a" is fine, no need to have my name in there if
you don't want it.  Remember, the tag name will live on in the merge
message, which ends up in the changelog for forever :)

Oh, and pulled and pushed out.

thanks,

greg k-h
