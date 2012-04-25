Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:43707 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab2DYOzH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Apr 2012 10:55:07 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/5] staging:iio:Documentation Trivial typo fixes.
Date: Wed, 25 Apr 2012 15:54:57 +0100
Message-Id: <1335365700-1138-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1335365700-1138-1-git-send-email-jic23@kernel.org>
References: <1335365700-1138-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Just a couple of things I came across whilst reviewing this file for
moving out of staging. I doubt anyone cares, but seemed sensible to fix
them now!

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index f7de494..2ce4dad 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -108,7 +108,7 @@ Description:
 		physically equivalent inputs when non differential readings are
 		separately available. In differential only parts, then all that
 		is required is a consistent labeling.  Units after application
-		of scale and offset are nanofarads..
+		of scale and offset are nanofarads.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_raw
@@ -119,7 +119,7 @@ KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled no bias removal etc) temperature measurement.
-		It an axis is specified it generally means that the temperature
+		If an axis is specified it generally means that the temperature
 		sensor is associated with one part of a compound device (e.g.
 		a gyroscope axis). Units after application of scale and offset
 		are milli degrees Celsuis.
@@ -232,7 +232,7 @@ Description:
 		If known for a device, scale to be applied to <type>Y[_name]_raw
 		post addition of <type>[Y][_name]_offset in order to obtain the
 		measured value in <type> units as specified in
-		<type>[Y][_name]_raw documentation..  If shared across all in
+		<type>[Y][_name]_raw documentation.  If shared across all in
 		channels then Y and <x|y|z> are not present and the value is
 		called <type>[Y][_name]_scale. The peak modifier means this
 		value is applied to <type>Y[_name]_peak_raw values.
-- 
1.7.0.4

