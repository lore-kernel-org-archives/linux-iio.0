Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbeKLCgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 21:36:00 -0500
Date: Sun, 11 Nov 2018 16:46:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/9] add i2c controller support to st_lsm6dsx driver
Message-ID: <20181111164655.786268b0@archlinux>
In-Reply-To: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 11 Nov 2018 15:15:27 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Introduce i2c controller support to st_lsm6dsx driver for lsm6dso sensor.
> st_lsm6dsx sensor-hub supports up to 3 concurrent slave devices.
> Add register map for lis2mdl magnetometer sensor.
> Add hw FIFO support to st_lsm6dsx sensorhub driver.
Hi Lorenzo.

A very nice series in general, though I did make a small change in patch 6
so please check I didn't mess that up.  It seemed fairly obvious but I've
been wrong on obvious things many times before :)

Thanks,

Jonathan

> 
> Changes since v1:
> - move back st_lsm6dsx_set_fifo_mode routine in fifo_lock critical section
>   in st_lsm6dsx_flush_fifo
> - improve documentation
> - move st_lsm6dsx_sensor_set_enable definition in a separated patch
> - move st_lsm6dsx_push_tagged_data definition in a separated patch
> - use proper ts_ref for ext devices in st_lsm6dsx_push_tagged_data
> - fix invalid iio_dev identification in st_lsm6dsx_push_tagged_data
>   when ST_LSM6DSX_EXT1_TAG is read from the FIFO
> - refactor st_lsm6dsx_shub_probe moving wai check in a dedicated routine
> - fix abi issue in scale_available definition
> 
> Lorenzo Bianconi (9):
>   iio: imu: st_lsm6dsx: introduce locked read/write utility routines
>   iio: imu: st_lsm6dsx: reload trimming parameter at bootstrap
>   iio: imu: st_lsm6dsx: remove static from st_lsm6dsx_set_watermark
>   iio: imu: st_lsm6dsx: introduce ST_LSM6DSX_ID_EXT sensor ids
>   iio: imu: st_lsm6dsx: introduce st_lsm6dsx_sensor_set_enable routine
>   iio: imu: st_lsm6dsx: add i2c embedded controller support
>   iio: imu: st_lsm6dsx: add st_lsm6dsx_push_tagged_data routine
>   iio: imu: st_lsm6dsx: add hw FIFO support to i2c controller
>   dt-bindings: iio: imu: st_lsm6dsx: add support to i2c pullup resistors
> 
>  .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
>  drivers/iio/imu/st_lsm6dsx/Makefile           |   3 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 167 +++-
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 165 ++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 283 +++++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  | 777 ++++++++++++++++++
>  .../linux/platform_data/st_sensors_pdata.h    |   2 +
>  7 files changed, 1263 insertions(+), 135 deletions(-)
>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> 
