Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:34701 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbbCQKhG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2015 06:37:06 -0400
Received: by wggv3 with SMTP id v3so4732415wgg.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2015 03:37:05 -0700 (PDT)
From: Haneen Mohammed <hamohammed.sa@gmail.com>
To: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
	jic23@kernel.org, daniel.baluta@intel.com
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Subject: [PATCH] iio: Add ABI documentation for out_voltage scan_elements
Date: Tue, 17 Mar 2015 13:36:49 +0300
Message-Id: <1426588609-24683-1-git-send-email-hamohammed.sa@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds ABI documentation entries for out_voltageY_en,
out_voltageY_type, and out_voltageY_index.
At least one user for these is preset:
AD8366 SPI Dual-Digital VGA.

Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index fd026d9..bbb0bfd 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -994,6 +994,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_en
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_en
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_en
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY-voltageZ_en
+What:		/sys/.../iio:deviceX/scan_elements/out_voltageY_en
 What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_en
 What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_en
 What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_en
@@ -1011,6 +1012,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_magn_type
 What:		/sys/.../iio:deviceX/scan_elements/in_incli_type
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_type
 What:		/sys/.../iio:deviceX/scan_elements/in_voltage_type
+What:		/sys/.../iio:deviceX/scan_elements/out_voltageY_type
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_type
 What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_type
 What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_type
@@ -1049,6 +1051,7 @@ Description:
 
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_index
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_index
+What:		/sys/.../iio:deviceX/scan_elements/out_voltageY_index
 What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_index
 What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_index
 What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_index
-- 
1.9.1

