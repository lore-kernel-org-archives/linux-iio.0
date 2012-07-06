Return-Path: <gregkh@linuxfoundation.org>
Date: Fri, 6 Jul 2012 16:06:24 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO new stuff - staging-next with IIO fixes merged.
Message-ID: <20120706230624.GB22495@kroah.com>
References: <4FEEF254.4060501@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FEEF254.4060501@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 30, 2012 at 01:34:28PM +0100, Jonathan Cameron wrote:
> Hi Greg,
> 
> I'm afraid I'm not that familiar with the complexities
> of pull requests.  What does one do as here if the patches
> are dependent on fixes in a separate series?  I merged
> in the fixes-togreg branch before applying these.
> 
> What is the standard way of handling this?

Don't do the merge.  I can easily do it if it's needed (here it wasn't
as I ended up pulling both into the -next branch.)

Don't do merges at all, let me do them, that makes things "cleaner" and
keeps the history easier to follow and is generally nicer.  I would
rather there be conflicts and figure them out and fix them, than have
you have to do them (although help in figuring them out is always
appreciated.)

Oh, and a signed tag would be great as mentioned before.  I've pulled
and pushed this, and the other pull request out.  Hopefully it made
things easier for you, it sure made things easier for me :)

thanks,

greg k-h
