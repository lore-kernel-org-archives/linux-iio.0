Return-Path: <SRS0=sOfQ=A3=linuxfoundation.org=gregkh@kernel.org>
Date: Tue, 26 Sep 2017 09:36:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] iio:stm32-lp-timer and ep93xx: drop assign
 iio_info.driver_module and iio_trigger_ops.owner
Message-ID: <20170926073640.GA8850@kroah.com>
References: <20170926080508.740a6158@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170926080508.740a6158@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 26, 2017 at 08:05:08AM +0100, Jonathan Cameron wrote:
> 
> The equivalent of both of these are now done via macro magic when
> the relevant register calls are made.  The actual structure
> elements have gone away.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

You forgot a "Reported-by:" tag here, I'll go add it by hand :)

thanks,

greg k-h
