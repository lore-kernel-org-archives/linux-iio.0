Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdBKPrF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 10:47:05 -0500
Date: Sat, 11 Feb 2017 16:46:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PULL] IIO fixes for 4.11 set 1 - a couple of regression fixes
 (resend as missed 4.10)
Message-ID: <20170211154653.GA12004@kroah.com>
References: <a8b4c6b5-b452-b10e-d0dd-85db54bdbb4b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a8b4c6b5-b452-b10e-d0dd-85db54bdbb4b@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Feb 11, 2017 at 09:14:35AM +0000, Jonathan Cameron wrote:
> The following changes since commit 5c113b5e0082e90d2e1c7b12e96a7b8cf0623e27:
> 
>   iio: dht11: Use usleep_range instead of msleep for start signal (2017-01-22 13:35:40 +0000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.11a

Pulled and pushed out, thanks.

greg k-h
