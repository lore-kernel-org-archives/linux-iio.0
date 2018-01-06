Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbeAFMVX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 07:21:23 -0500
Date: Sat, 6 Jan 2018 12:21:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] add regmap API support to st_lsm6dsx iio driver
Message-ID: <20180106122120.3c79810e@archlinux>
In-Reply-To: <20180101185444.22045-1-lorenzo.bianconi@redhat.com>
References: <20180101185444.22045-1-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  1 Jan 2018 19:54:41 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

Would have been nice to have a brief bit of text saying why...

Whilst I know all the advantages, that may not be the case for
someone new to the area who might read your series.

Thanks,

Jonathan


> Lorenzo Bianconi (3):
>   iio: imu: st_lsm6dsx: fix endianness in st_lsm6dsx_read_oneshot()
>   iio: imu: st_lsm6dsx: introduce conf_lock mutex
>   iio: imu: st_lsm6dsx: add regmap API support
> 
>  drivers/iio/imu/st_lsm6dsx/Kconfig             |   2 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |  33 ++------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 102 +++++++++++++++--------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 111 +++++++++++--------------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    |  55 ++++--------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    |  70 ++++------------
>  6 files changed, 153 insertions(+), 220 deletions(-)
> 

