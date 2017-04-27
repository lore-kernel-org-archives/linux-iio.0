Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33579 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968866AbdD0UcB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 16:32:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id w50so5034733wrc.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Apr 2017 13:32:00 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH v2 0/2] add power management support to st_lsm6dsx driver
Date: Thu, 27 Apr 2017 22:31:54 +0200
Message-Id: <20170427203156.18637-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since v1:
- improve commit messages

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: modify st_lsm6dsx_flush_fifo and
    st_lsm6dsx_set_fifo_mode scope
  iio: imu: st_lsm6dsx: add system power management support

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |  5 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  6 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 54 ++++++++++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    |  1 +
 5 files changed, 64 insertions(+), 3 deletions(-)

-- 
2.9.3

