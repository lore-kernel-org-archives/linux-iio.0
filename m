Return-Path: <gregkh@linuxfoundation.org>
Date: Fri, 13 Apr 2012 11:13:11 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/14 V2] IIO: Kill off IIO_CHAN macro.
Message-ID: <20120413181311.GA7573@kroah.com>
References: <1334310180-22170-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334310180-22170-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Apr 13, 2012 at 10:42:46AM +0100, Jonathan Cameron wrote:
> Hi Greg,
> 
> This is clearly out some old cruft.  Arnd warned me it was
> a stupid idea and I didn't listen :(  Anyhow, I've been meanging
> to do this for ages.  Lars-Peter verified the Analog devices
> driver changes and the rest are my drivers so I doubt anyone will
> look at them even if I let this sit for longer.
> 
> I don't think this is dependent on the fix series I sent a few
> mins back, but it was after it in my tree, so there might be
> some fuzz in iio.h.

All applied, along with your previous series.

greg k-h
