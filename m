Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:32944 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab3HEGRJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2013 02:17:09 -0400
Date: Mon, 5 Aug 2013 14:18:27 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO cleanups, new stuff and staging graduations (IIO set
 1 for the 3.12 cycle)
Message-ID: <20130805061827.GA19734@kroah.com>
References: <51FE88B7.5000506@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51FE88B7.5000506@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Aug 04, 2013 at 06:00:39PM +0100, Jonathan Cameron wrote:
> 2) A Kconfig option to enabled some debug logging subsystem wide.

I think this patch is not ok, I'm spending a lot of time ripping the
same type of thing _out_ of the USB subsystem, let's learn from our
mistakes and not put it back into other ones.

I'll respond to the patch itself with details...

thanks,

greg k-h
