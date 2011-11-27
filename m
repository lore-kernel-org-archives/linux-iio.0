Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:48639 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941Ab1K0LjK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2011 06:39:10 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/3] staging:iio:documentation: document filter_low_pass_3db_frequency.
Date: Sun, 27 Nov 2011 11:39:14 +0000
Message-Id: <1322393954-31525-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1322393954-31525-1-git-send-email-jic23@kernel.org>
References: <1322393954-31525-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@cam.ac.uk>

Add the sysfs ABI docs for all current instances of this
parameter.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index 0d6823d..46a995d 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -276,6 +276,16 @@ Description:
 		If a discrete set of scale values are available, they
 		are listed in this attribute.
 
+What:		/sys/.../in_accel_filter_low_pass_3db_frequency
+What:		/sys/.../in_magn_filter_low_pass_3db_frequency
+What:		/sys/.../in_anglvel_filter_low_pass_3db_frequency
+KernelVersion:	3.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If a known or controllable low pass filter is applied
+		to the underlying data channel, then this parameter
+		gives the 3dB frequency of the filter in Hz.
+
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
-- 
1.7.7.3

