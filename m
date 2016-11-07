Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35030 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbcKGIUW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2016 03:20:22 -0500
Date: Mon, 7 Nov 2016 09:19:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] Second set of IIO new device support and cleanups for the
 4.10 cycle.
Message-ID: <20161107081917.GA21288@kroah.com>
References: <66401fac-d6f6-f62b-e6c2-540aa11d5688@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <66401fac-d6f6-f62b-e6c2-540aa11d5688@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Nov 06, 2016 at 05:55:23PM +0000, Jonathan Cameron wrote:
> The following changes since commit 49b9137a6002a06f7e44e59ece9b34fd1e4fca4c:
> 
>   staging: greybus: audio: remove redundant slot field (2016-10-24 15:48:02 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.10b
> 
> for you to fetch changes up to c2b0d2cfb0317275cf04257fc3f5dfbdd9ffa274:
> 
>   staging: iio: tsl2583: remove redudant i2c call in taos_als_calibrate() (2016-11-06 11:54:32 +0000)

Pulled and pushed out, thanks.

greg k-h
