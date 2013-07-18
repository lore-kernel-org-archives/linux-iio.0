Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 18 Jul 2013 15:45:55 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, koen@dominion.thruhere.net
Subject: Re: [PATCH 01/15] MFD: ti_tscadc: disable TSC config registers in
 adc mode
Message-ID: <20130718224555.GA7116@kroah.com>
References: <1374186086-5015-1-git-send-email-zubair.lutfullah@gmail.com>
 <1374186086-5015-2-git-send-email-zubair.lutfullah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374186086-5015-2-git-send-email-zubair.lutfullah@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jul 18, 2013 at 11:21:12PM +0100, Zubair Lutfullah wrote:
> From: "Patil, Rachna" <rachna@ti.com>
> 
> AFE Pen Ctrl and TouchScreen transistors enabling is not
> required when only ADC mode is being used, so check for availability of
> TSC driver before accessing control register.
> 
> Signed-off-by: Patil, Rachna <rachna@ti.com>

Did Rachna really sign off on this, and the other, patches?  Or did they
just author them and place them somewhere on the web?  You can't add
other people's signed-off-by lines, that's not allowed for obvious
reasons (read what Signed-off-by: means in the
Documentation/SubmittingPatches file if you are curious.)

thanks,

greg k-h
