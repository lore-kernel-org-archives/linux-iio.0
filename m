Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10038 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932670AbbD0PCn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Apr 2015 11:02:43 -0400
From: Octavian Purdila <octavian.purdila@intel.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robert.moore@intel.com,
	rafael.j.wysocki@intel.com, lenb@kernel.org,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-acpi@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 0/3] iio: export mounting matrix
Date: Mon, 27 Apr 2015 18:01:45 +0300
Message-Id: <1430146908-27919-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a RFC patch series that exports information about the way the
sensors are connected to the system so that userspace can correct
readings.

It is inspired by the way MPU6050 exports this information via the
in_{gyro,accel,magn}_matrix sysfs entries.

Octavian Purdila (3):
  iio: export mounting matrix information
  ACPICA: Add _PLD front and back panel constants
  iio: derive the mounting matrix from ACPI _PLD objects

 Documentation/ABI/testing/sysfs-bus-iio | 11 ++++
 drivers/iio/industrialio-core.c         | 93 +++++++++++++++++++++++++++++++++
 include/acpi/acbuffer.h                 |  5 ++
 include/linux/iio/iio.h                 | 55 +++++++++++++++++++
 4 files changed, 164 insertions(+)

-- 
1.9.1

