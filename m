Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43914 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab3JQRKd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Oct 2013 13:10:33 -0400
Date: Thu, 17 Oct 2013 10:10:32 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO fixes for 3.12 set 3
Message-ID: <20131017171032.GA27480@kroah.com>
References: <525DBC0B.9050903@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <525DBC0B.9050903@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Oct 15, 2013 at 11:04:59PM +0100, Jonathan Cameron wrote:
> The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:
> 
>   Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.12c

I've pulled this into my char-misc tree to go to Linus for 3.12-final as
I had some fixes there that needed to go to him, and my staging-linus
tree was empty.

thanks,

greg k-h
