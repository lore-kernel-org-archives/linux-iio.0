Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 23 Jul 2015 13:33:15 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] Third set of IIO fixes for the 4.2 cycle.
Message-ID: <20150723203315.GA16369@kroah.com>
References: <55B14BCC.30803@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55B14BCC.30803@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jul 23, 2015 at 09:17:16PM +0100, Jonathan Cameron wrote:
> The following changes since commit 7eb7ee30559c9c88ca23fa3b95bd06629669d0a8:
> 
>   staging: vt6656: check ieee80211_bss_conf bssid not NULL (2015-07-19 11:48:19 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.2c

I hit a merge conflict in drivers/iio/light/stk3310.c, which I think I
fixed up properly, but if you could pull my tree and verify I got it
correct, that would be great.

thanks,

greg k-h
