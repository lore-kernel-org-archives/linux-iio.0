Return-Path: <gregkh@linuxfoundation.org>
Date: Fri, 19 Jul 2013 16:13:52 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, koen@dominion.thruhere.net
Subject: Re: [PATCH 01/15] MFD: ti_tscadc: disable TSC config registers in
 adc mode
Message-ID: <20130719231352.GB1701@kroah.com>
References: <1374186086-5015-1-git-send-email-zubair.lutfullah@gmail.com>
 <1374186086-5015-2-git-send-email-zubair.lutfullah@gmail.com>
 <20130718224555.GA7116@kroah.com>
 <20130719204715.GA8704@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130719204715.GA8704@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jul 19, 2013 at 09:47:16PM +0100, Zubair Lutfullah : wrote:
> On Thu, Jul 18, 2013 at 03:45:55PM -0700, Greg KH wrote:
> 
> > Did Rachna really sign off on this, and the other, patches?  Or did they
> Authored and signed off on it in their TI tree. based on 3.2.

Ok, as long as they did that, it's fine to have those lines in the
patch.  As you didn't have them in the previous version, I had to ask.

thanks,

greg k-h
