Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8157 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbaLOVUE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Dec 2014 16:20:04 -0500
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/3] Enable AK8963 conneted via INV6500
Date: Mon, 15 Dec 2014 13:19:20 -0800
Message-Id: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now we have i2c-mux for invensense mpu6050/mpu6500 is merged, this patchset
enables sensors routed through this.
In this series enabling AK8975/AK8963. This device is connected to main
cpu i2c bus via invensense bypass mode enabled by i2c-mux.

Srinivas Pandruvada (3):
  iio: imu: inv_mpu6050: ACPI enumeration
  iio: imu: inv_mpu6050: Added adapter class
  iio: ak8975: Added autodetect feature for ACPI

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 11 +++++++++-
 drivers/iio/magnetometer/ak8975.c          | 35 ++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

-- 
1.9.3

