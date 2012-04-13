Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54090 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757864Ab2DMJY0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 05:24:26 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/4] staging:iio:Documentation: Fix a cut and paste error.
Date: Fri, 13 Apr 2012 10:24:19 +0100
Message-Id: <1334309061-21073-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1334309061-21073-1-git-send-email-jic23@kernel.org>
References: <1334309061-21073-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

falling is repeated in some entries instead of 1x falling and 1x rising
for the entry.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index 46a995d..ca12784 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -453,9 +453,9 @@ What:		/sys/.../events/in_magn_z_raw_thresh_rising_value
 What:		/sys/.../events/in_magn_z_raw_thresh_falling_value
 What:		/sys/.../events/in_voltageY_supply_raw_thresh_rising_value
 What:		/sys/.../events/in_voltageY_supply_raw_thresh_falling_value
+What:		/sys/.../events/in_voltageY_raw_thresh_rising_value
 What:		/sys/.../events/in_voltageY_raw_thresh_falling_value
-What:		/sys/.../events/in_voltageY_raw_thresh_falling_value
-What:		/sys/.../events/in_tempY_raw_thresh_falling_value
+What:		/sys/.../events/in_tempY_raw_thresh_rising_value
 What:		/sys/.../events/in_tempY_raw_thresh_falling_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
@@ -490,9 +490,9 @@ What:		/sys/.../events/in_magn_z_raw_roc_rising_value
 What:		/sys/.../events/in_magn_z_raw_roc_falling_value
 What:		/sys/.../events/in_voltageY_supply_raw_roc_rising_value
 What:		/sys/.../events/in_voltageY_supply_raw_roc_falling_value
+What:		/sys/.../events/in_voltageY_raw_roc_rising_value
 What:		/sys/.../events/in_voltageY_raw_roc_falling_value
-What:		/sys/.../events/in_voltageY_raw_roc_falling_value
-What:		/sys/.../events/in_tempY_raw_roc_falling_value
+What:		/sys/.../events/in_tempY_raw_roc_rising_value
 What:		/sys/.../events/in_tempY_raw_roc_falling_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
-- 
1.7.0.4

