Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34049 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbHLL3r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 07:29:47 -0400
Date: Wed, 12 Aug 2015 14:28:34 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Documentation: iio-trig-sysfs: Document add_trigger
 attribute
Message-ID: <abec7567354027e794de15da5a61e44bf627eacc.1439378363.git.cristina.opriceana@gmail.com>
References: <cover.1439378363.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1439378363.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the ABI documentation for the add_trigger
attribute, which is provided by the iio-trig-sysfs stand-alone driver.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
index 5235e6c..887aa92 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
+++ b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
@@ -9,3 +9,14 @@ Description:
 		automated testing or in situations, where other trigger methods
 		are not applicable. For example no RTC or spare GPIOs.
 		X is the IIO index of the trigger.
+
+What:		/sys/bus/iio/devices/iio_sysfs_trigger/add_trigger
+KernelVersion:	2.6.39
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is provided by the iio-trig-sysfs stand-alone
+		driver and it is used to activate the creation of a new trigger.
+		In order to achieve this, one should write a positive integer
+		into the associated file, which will serve as the id of the
+		trigger. If the trigger with the specified id is already present
+		in the system, an invalid argument message will be returned.
-- 
1.9.1

