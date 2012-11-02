Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:56247 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759320Ab2KBQ3w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Nov 2012 12:29:52 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1714835dak.19
        for <linux-iio@vger.kernel.org>; Fri, 02 Nov 2012 09:29:52 -0700 (PDT)
Date: Fri, 2 Nov 2012 09:29:53 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO fixes for v3.7-rc1 set 2
Message-ID: <20121102162953.GB13600@kroah.com>
References: <5093A416.1080409@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5093A416.1080409@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Nov 02, 2012 at 10:44:38AM +0000, Jonathan Cameron wrote:
> The following changes since commit 98f9c3c137cea016c57c9fd60b3caf88eb34e4cd:
> 
>   iio: Remove duplicates for light/ in Kconfig and Makefile (2012-10-19 19:44:06 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.7b
> 
> for you to fetch changes up to 7243b785c43d9aedc7a584dab81bb3f26989d6a1:
> 
>   iio: hid-sensor: Use __devexit annotation for remove() (2012-11-02 09:57:57 +0000)
> 
> ----------------------------------------------------------------
> Second round of fixes for IIO in 3.7 cycle, applies to 3.7-rc1.
> 
> A mixed bag of fixes mainly for drivers but with one core
> double free fix.
> 
> * A couple of little fixlets for the hid-sensors drivers.
> * Incorrect return value in adt7410
> * Fix up support for the adis16334 in the adis16400 driver.
>   Turned out there were some bits and bobs that need to be
>   handled different for this part.  This seems like a large
>   patch series but this is mostly because an additional chip
>   specific callback is needed to handle the variations.

That is a big patch so late in the release cycle, is it really needed?
Is it a regression from 3.6?  Or does it just fix a problem with a new
thing that showed up in 3.7-rc1?  If the latter, how about we postpone
it and just mark the driver BROKEN or something?

thanks,

greg k-h
