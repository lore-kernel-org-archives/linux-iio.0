Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0060.outbound.protection.outlook.com ([104.47.32.60]:44800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756353AbeEAR5C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 May 2018 13:57:02 -0400
From: Martin Kelly <mkelly@xevo.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>
Subject: [PATCH 0/2] inv_mpu6050 minor cleanup
Date: Tue,  1 May 2018 10:56:40 -0700
Message-Id: <20180501175642.8551-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These patches are minor cleanup for the inv_mpu6050 driver. They should be
applied to the iio testing branch, as they won't apply cleanly to master due to
recent changes in inv_mpu6050.

Martin Kelly (2):
  iio: imu: inv_mpu6050: minor grammar fixes
  iio: imu: inv_mpu6050: make loop a do-while

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.11.0

