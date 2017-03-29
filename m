Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35677 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755883AbdC2MdR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 08:33:17 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 0/4] drivers: iio: Replace ternary operator with min macro
Date: Wed, 29 Mar 2017 18:03:07 +0530
Message-Id: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use macro min() to get the minimum of two values for brevity and readability. 

simran singhal (4):
  iio: common: st_sensors: Replace ternary operator with min macro
  iio: imu: st_lsm6dsx: Replace ternary operator with min macro
  iio: imu: st_lsm6dsx: Replace ternary operator with min macro
  iio: light: si1145: Replace ternary operator with min macro

 drivers/iio/common/st_sensors/st_sensors_i2c.c | 2 +-
 drivers/iio/humidity/hts221_core.c             | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
 drivers/iio/light/si1145.c                     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4

