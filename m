Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35913 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036086AbdDUSWY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2017 14:22:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id u65so6335582wmu.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2017 11:22:24 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH 0/2] add power management support to st_lsm6dsx driver
Date: Fri, 21 Apr 2017 20:22:11 +0200
Message-Id: <20170421182213.21481-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: export st_lsm6dsx_flush_fifo() and
    st_lsm6dsx_set_fifo_mode() routines
  iio: imu: st_lsm6dsx: add system sleep power management support

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |  5 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  6 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 54 ++++++++++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    |  1 +
 5 files changed, 64 insertions(+), 3 deletions(-)

-- 
2.9.3

