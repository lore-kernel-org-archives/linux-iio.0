Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 26 Apr 2016 15:10:02 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] Second set of new drivers, features and cleanups for IIO
 in the 4.7 cycle
Message-ID: <20160426221002.GA9771@kroah.com>
References: <b6cab6bb-240d-5db1-0a38-1758ebfc8a21@kernel.org>
 <384802CC-C2B0-46C3-A56F-601440043559@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <384802CC-C2B0-46C3-A56F-601440043559@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Apr 26, 2016 at 06:43:42AM +0100, Jonathan Cameron wrote:
> Hi Greg
> 
> I forgot to mention that the adr5592r will fire off some autobuilder warnings
> to do with
> Kconfig dependencies. The fix for that is working its way through the gpio tree
> a
> the Kconfig option that causes it no longer makes any sense (dates back a
> long way)

Thanks for the warning.  I've pulled these into my tree now.

> PS thanks for the yubikey and stickers (daughter ran off with those :)

Heh, glad it made it there safely.

thanks,

greg k-h
