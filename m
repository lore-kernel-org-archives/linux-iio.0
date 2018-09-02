Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeICApV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 20:45:21 -0400
Date: Sun, 2 Sep 2018 21:28:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] add support to STM LSM6DSO 6-axis Mems sensor
Message-ID: <20180902212819.00c34a7f@archlinux>
In-Reply-To: <20180830205259.7029-1-lorenzo.bianconi@redhat.com>
References: <20180830205259.7029-1-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 30 Aug 2018 22:52:54 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

I'm in a fussy mood.  Not a lot of point in putting a cover letter on
a series with nothing in it.  Please give a nice 'general' description
of what you are adding. In particular point out anything you think
might be controversial :)

Thanks,

Jonathan

> Lorenzo Bianconi (5):
>   iio: imu: st_lsm6dsx: add read_fifo callback to fifo_ops
>   iio: imu: st_lsm6dsx: make st_lsm6dsx_check_odr() non-static
>   iio: imu: st_lsm6dsx: add addr/max_word_len to st_lsm6dsx_read_block()
>   iio: imu: st_lsm6dsx: add support to LSM6DSO
>   dt-bindings: iio: imu: st_lsm6dsx: add LSM6DSO device bindings
> 
>  .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
>  drivers/iio/imu/st_lsm6dsx/Kconfig            |   2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  18 +-
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 166 ++++++++++++++++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  51 +++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
>  7 files changed, 228 insertions(+), 20 deletions(-)
> 
