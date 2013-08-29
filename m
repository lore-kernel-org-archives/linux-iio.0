Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37229 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab3H2VaL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2013 17:30:11 -0400
Date: Thu, 29 Aug 2013 14:32:34 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO fixes for 3.11 - set 4
Message-ID: <20130829213234.GA24433@kroah.com>
References: <521FBB99.3040205@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <521FBB99.3040205@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 29, 2013 at 10:22:33PM +0100, Jonathan Cameron wrote:
> The following changes since commit d8dfad3876e4386666b759da3c833d62fb8b2267:
> 
>   Linux 3.11-rc7 (2013-08-25 17:43:22 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.11d
> 
> for you to fetch changes up to 947b8ec78610fdfd891da249629f79cfa8e5da57:
> 
>   iio: at91: fix adc_clk overflow (2013-08-29 21:42:11 +0100)
> 
> ----------------------------------------------------------------
> 4th round of fixes for IIO in the 3.11 series.
> 
> Another one patch pull request, this one for an overflow issue that
> can occur in the at91 adc driver.

How "necessary" is this for 3.11?  Is it something that a user can hit
today?  Is it a regression from 3.10?  Is it for a new driver?

It's really late in the 3.11 cycle for me to want to send anything to
Linus except for "this fixes a major issue" type patches.  Can we just
tag this for stable and have it show up in 3.11 after 3.12-rc1 is out?

thanks,

greg k-h
