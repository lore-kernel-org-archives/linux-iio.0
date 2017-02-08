Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35424 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbdBHOB5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Feb 2017 09:01:57 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 2/2] Documentation: iio: 104-quad-8: Fix KernelVersion in sysfs ABI documentation
Date: Wed,  8 Feb 2017 09:01:45 -0500
Message-Id: <2d4b78e29bf1f67aa3fcc296af20d813f0c4724b.1486562053.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1486562053.git.vilhelm.gray@gmail.com>
References: <cover.1486562053.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ACCES 104-QUAD-8 IIO driver did not appear in the 4.9 version of the
Linux kernel. This patch fixes the KernelVersion lines of the 104-QUAD-8
sysfs ABI documentation.

Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8       | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
index ba676520b953..5f4924a94949 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
+++ b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
@@ -4,21 +4,21 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_count_noise_error_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_index_index_polarity_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_index_synchronous_mode_available
-KernelVersion:	4.9
+KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Discrete set of available values for the respective counter
 		configuration are listed in this file.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_direction
-KernelVersion:	4.9
+KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Read-only attribute that indicates whether the counter for
 		channel Y is counting up or down.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_mode
-KernelVersion:	4.9
+KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Count mode for channel Y. Four count modes are available:
@@ -52,7 +52,7 @@ Description:
 			continuously throughout.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_noise_error
-KernelVersion:	4.9
+KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Read-only attribute that indicates whether excessive noise is
@@ -60,14 +60,14 @@ Description:
 		irrelevant in non-quadrature clock mode.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_preset
-KernelVersion:	4.9
+KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
 		If the counter device supports preset registers, the preset
 		count for channel Y is provided by this attribute.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_quadrature_mode
-KernelVersion:	4.9
+KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Configure channel Y counter for non-quadrature or quadrature
@@ -88,7 +88,7 @@ Description:
 			decoded for UP/DN clock.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_set_to_preset_on_index
-KernelVersion:	4.9
+KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Whether to set channel Y counter with channel Y preset value
@@ -96,14 +96,14 @@ Description:
 		Valid attribute values are boolean.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_index_polarity
-KernelVersion:	4.9
+KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Active level of channel Y index input; irrelevant in
 		non-synchronous load mode.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_synchronous_mode
-KernelVersion:	4.9
+KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Configure channel Y counter for non-synchronous or synchronous
-- 
2.11.1

