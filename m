Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:57098 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbdJBQho (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Oct 2017 12:37:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id e195so8041726wma.5
        for <linux-iio@vger.kernel.org>; Mon, 02 Oct 2017 09:37:44 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH v2 0/4] rework st_lsm6dsx driver to support more devices
Date: Mon,  2 Oct 2017 18:37:36 +0200
Message-Id: <20171002163740.13780-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is the first patchset that reworks st_lsm6dsx driver to properly
support more devices

Changes since v1:
- drop a blank line in st_lsm6dsx_fifo_ops description
- improve commit log in patch 1

Lorenzo Bianconi (4):
  iio: imu: st_lsm6dsx: convert max_fifo_size in FIFO sample size
  iio: imu: st_lsm6dsx: split fifo mode and fifo odr configuration
  iio: imu: st_lsm6dsx: move decimator info in
    st_lsm6dsx_sensor_settings
  iio: imu: st_lsm6dsx: add FIFO ops data structure

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 32 +++++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 72 ++++++++++++------------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 78 ++++++++++++++++++++++----
 3 files changed, 132 insertions(+), 50 deletions(-)

-- 
2.14.1

