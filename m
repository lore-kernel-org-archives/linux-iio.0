Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30512 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbbFKPKA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 11 Jun 2015 11:10:00 -0400
From: Adriana Reus <adriana.reus@intel.com>
To: ggao@invensense.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH 0/2] iio: inv-mpu: small scale fixes 
Date: Fri, 12 Jun 2015 18:10:21 +0300
Message-Id: <1434121823-26266-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series exports available scales for inv-mpu6050 and also
fixes the format for write channels.

Adriana Reus (2):
  iio: inv-mpu: Export scale_available attributes
  iio: inv-mpu: Specify the expected format/precision for write channels

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
1.9.1

