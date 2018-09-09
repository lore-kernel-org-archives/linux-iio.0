Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57556 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeIIMYN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Sep 2018 08:24:13 -0400
Date: Sun, 9 Sep 2018 09:35:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO fixes for the 4.19 cycle
Message-ID: <20180909073525.GA13833@kroah.com>
References: <20180908161700.10eb1fb3@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180908161700.10eb1fb3@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 08, 2018 at 04:17:00PM +0100, Jonathan Cameron wrote:
> The following changes since commit 6d4abf1c0e265d8e99c155b91c1cf44e37793e53:
> 
>   staging: axis-fifo: fix return value check in axis_fifo_probe() (2018-07-28 09:26:31 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-4.19a
> 
> for you to fetch changes up to a13bf65f3f2e36008ea60b49d3bda2527e09fd9c:
> 
>   iio: imu: st_lsm6dsx: take into account ts samples in wm configuration (2018-09-02 21:19:53 +0100)
> 
> ----------------------------------------------------------------
> First set of IIO fixes for the 4.19 cycle.
> 
> * ad9523
>   - sysfs write should return the number of characters used or an error, not
>     0 which could result in an infinite loop in userspace.
> * lsm6dsx
>   - Fix computation of length when updating the watermark to include
>     timestamps avoiding the watermark being set earlier than intended.
> * maxim_thermocouple
>   - Revert a patch adding the max31856 as it's not actually compatible with
>     the register set that this driver supports.
> * si1133
>   - Fix an impossible value check so we don't always error out whether the
>     passed in value is good or bad.
> 
> ----------------------------------------------------------------
> Colin Ian King (1):
>       iio: light: si1133 fix test for val being not zero or not one.
> 
> Lars-Peter Clausen (1):
>       iio: ad9523: Fix return value for ad952x_store()
> 
> Lorenzo Bianconi (1):
>       iio: imu: st_lsm6dsx: take into account ts samples in wm configuration
> 
> Matt Ranostay (1):
>       Revert "iio: temperature: maxim_thermocouple: add MAX31856 part"
> 
>  drivers/iio/frequency/ad9523.c                 |  2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 13 ++++++-------
>  drivers/iio/light/si1133.c                     |  2 +-
>  drivers/iio/temperature/maxim_thermocouple.c   |  1 -
>  4 files changed, 8 insertions(+), 10 deletions(-)

Are you sure all 4 patches were there?  I only saw 2 patches in the pull
request I just merged.

thanks,

greg k-h
