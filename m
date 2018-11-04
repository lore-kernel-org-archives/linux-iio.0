Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731477AbeKED2R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Nov 2018 22:28:17 -0500
Date: Sun, 4 Nov 2018 18:12:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] add i2c controller support to st_lsm6dsx driver
Message-ID: <20181104181223.48618c1f@archlinux>
In-Reply-To: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
References: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  4 Nov 2018 15:38:59 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Introduce i2c controller support to st_lsm6dsx driver for lsm6dso sensor.
> Add register map for lis2mdl magnetometer sensor.
> Add hw FIFO support to st_lsm6dsx sensorhub driver.
> 
> Lorenzo Bianconi (7):
>   iio: imu: st_lsm6dsx: introduce locked read/write utility routines
>   iio: imu: st_lsm6dsx: reboot memory content after reset
>   iio: imu: st_lsm6dsx: remove static from st_lsm6dsx_set_watermark
>   iio: imu: st_lsm6dsx: introduce ST_LSM6DSX_ID_EXT sensor ids
>   iio: imu: st_lsm6dsx: add i2c embedded controller support
>   iio: imu: st_lsm6dsx: add hw FIFO support to i2c controller
>   dt-bindings: iio: imu: st_lsm6dsx: add support to i2c pullup resistors
> 
>  .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
>  drivers/iio/imu/st_lsm6dsx/Makefile           |   3 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 167 +++-
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 169 ++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 273 +++++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  | 753 ++++++++++++++++++
>  .../linux/platform_data/st_sensors_pdata.h    |   2 +
>  7 files changed, 1226 insertions(+), 142 deletions(-)
>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> 

Hi Lorenzo,

Great to see this series.

It seems to have come together fairly nicely given the inherent complexity
of dealing with these slave i2c controllers.   What I would like to
see in this cover letter though is a brief description of what can be
put behind these devices?

The one thing I want to be careful of is ending up with lots of sort
of replicated drivers where we have a version in each sensor hub
and one for directly connected devices.  Superficially this
device seems to have a very restricted I2C master so that might not
be a significant problem.  What do you think?
This gets particularly interesting if we think about switching in
and out of pass through.  At that point this looks like an i2c offload
engine (sort of) similar to the one Lars did for spi, be it a very
restricted one.

Jonathan
