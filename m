Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: rjw@rjwysocki.net,
	len.brown@intel.com,
	linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] Fix suspend/resume delay
Date: Mon,  1 Jun 2015 16:36:26 -0700
Message-Id: <1433201787-22290-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

v1
Simplified patch to match user request before runtime resume.
This is very similar to USB xhci where runtime resume function is checking
any outstanding XHCI request to wake up before proceeding to resume.

v0
Optimize using Linux PM notifiers to get notification of PM states

Srinivas Pandruvada (1):
  hid-sensor: Fix suspend/resume delay

 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 11 ++++++++++-
 include/linux/hid-sensor-hub.h                      |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.1.4
