Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53902 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbeC3Ud7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Mar 2018 16:33:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id p9so17003298wmc.3
        for <linux-iio@vger.kernel.org>; Fri, 30 Mar 2018 13:33:58 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] add support to STM ISM330DLC 6-axis Mems sensor
Date: Fri, 30 Mar 2018 22:33:49 +0200
Message-Id: <20180330203351.22681-1-lorenzo.bianconi@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to ism330dlc
  Documentation: dt: iio: imu: st_lsm6dsx: add ism330dlc sensor device
    binding

 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt |  1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                       |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                  |  2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c           | 10 +++++-----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c             |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c              |  5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c              |  5 +++++
 7 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.16.2

