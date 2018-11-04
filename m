Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbeKEC1W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Nov 2018 21:27:22 -0500
Date: Sun, 4 Nov 2018 17:11:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] iio: imu: st_lsm6dsx: introduce locked read/write
 utility routines
Message-ID: <20181104171139.4ca2e848@archlinux>
In-Reply-To: <31af70f2f7b832b984b3f1bd122ce1c9cf98582b.1541341926.git.lorenzo.bianconi@redhat.com>
References: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
        <31af70f2f7b832b984b3f1bd122ce1c9cf98582b.1541341926.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  4 Nov 2018 15:39:00 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Add st_lsm6dsx_update_bits_locked, st_lsm6dsx_read_locked and
> st_lsm6dsx_write_locked utility routines in order to guarantee
> the bus access is atomic respect to reg page configuration.
> This is a preliminary patch to add i2c sensor hub support since
> i2c master registers are accessed through a reg page multiplexer
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

Just one case inline where this doesn't seem as straight forward a
change as this suggests..

Jonathan

> ---
...
> @@ -536,16 +541,11 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
>  
>  int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
>  {
> -	int err;
> -
>  	mutex_lock(&hw->fifo_lock);
> -
>  	hw->settings->fifo_ops.read_fifo(hw);
> -	err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_BYPASS);

This one needs some explaining...  You've dropped the set_fifo_mode
out of the fifo_lock.  Is this because it was never needed or has
something changed?  If it was never needed then I'd like to see it
moved out in a precursor patch where you explain why that is safe.

Basically I want this patch to be purely mechanical application of
a lock around places where we need the page to be held constant.

> -
>  	mutex_unlock(&hw->fifo_lock);
>  
> -	return err;
> +	return st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_BYPASS);
>  }
>  
>  static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
