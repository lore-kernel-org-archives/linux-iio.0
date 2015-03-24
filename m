Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37631 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbbCXV4K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2015 17:56:10 -0400
Date: Tue, 24 Mar 2015 22:54:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO new drivers, cleanups and functionality for the 4.1
 cycle.
Message-ID: <20150324215437.GD19829@kroah.com>
References: <5505EF30.5020205@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5505EF30.5020205@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 15, 2015 at 08:44:32PM +0000, Jonathan Cameron wrote:
> The following changes since commit 178cf7de6f1d3b95407f5a76af249fc924d42576:
> 
>   Merge 3.19-rc7 into staging-next (2015-02-02 08:41:02 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.1a

There was one merge conflict, and one merge that caused a build error,
but I fixed them both up.  If you could verify I got it all right, that
would be great.

thanks,

greg k-h
