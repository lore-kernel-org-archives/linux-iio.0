Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46957 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbbCLS0G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2015 14:26:06 -0400
Received: by wiwh11 with SMTP id h11so4018wiw.5
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2015 11:26:05 -0700 (PDT)
Date: Thu, 12 Mar 2015 21:26:00 +0300
From: Haneen Mohammed <hamohammed.sa@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: linux-iio@vger.kernel.org, jic23@kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH] iio : Add ABI documentation for thresh falling/rising value
 in accel
Message-ID: <20150312182600.GA23579@haneen-vb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds ABI documentation entries for
in_accel_thresh_falling_value, and in_accel_thresh_rising_value in /events.
There is at least one user for these, lis3l02dq in accel.

Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 9a70c31..9a1a5fc 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -612,6 +612,8 @@ Description:
 		a given event type is enabled a future point (and not those for
 		whatever event was previously enabled).
 
+What:		/sys/.../events/in_accel_thresh_rising_value
+What:		/sys/.../events/in_accel_thresh_falling_value
 What:		/sys/.../events/in_accel_x_raw_thresh_rising_value
 What:		/sys/.../events/in_accel_x_raw_thresh_falling_value
 What:		/sys/.../events/in_accel_y_raw_thresh_rising_value
-- 
1.9.1

