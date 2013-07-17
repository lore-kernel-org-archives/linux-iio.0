Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49751 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab3GQRtR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 13:49:17 -0400
Date: Wed, 17 Jul 2013 10:34:51 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, koen@dominion.thruhere.net
Subject: Re: [PATCH 01/21] MFD: ti_tscadc: disable TSC control
Message-ID: <20130717173451.GB17882@kroah.com>
References: <1374082010-28095-1-git-send-email-zubair.lutfullah@gmail.com>
 <1374082010-28095-2-git-send-email-zubair.lutfullah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374082010-28095-2-git-send-email-zubair.lutfullah@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 17, 2013 at 06:26:30PM +0100, Zubair Lutfullah wrote:
> Register bits when TSC not in use

What does this mean?

> AFE Pen Ctrl and TouchScreen transistors enabling is not
> 
> required when only ADC mode is being used, so check for availability of
> 
> TSC driver before accessing control register.

What's with the extra newlines?

> 
> This patch is based on work in the 3.2 tree by TI
> Original Author is Patil Rachna

If you didn't write this, you need to put the "From: " line for the
correct author/email in the patch, as Documentation/SubmittingPatches
describes so that they can get the correct credit.

> Signed-off-by: Zubair Lutfullah <zubair.lutfullah@gmail.com>

What happened to Patil's signed-off-by: line?
Same goes for other patches in this series.

thanks,

greg k-h
