Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36158 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932363AbdBHOBm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Feb 2017 09:01:42 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 1/2] Documentation: iio: Fix KernelVersion in counter sysfs ABI documentation
Date: Wed,  8 Feb 2017 09:01:35 -0500
Message-Id: <859e16c87fce871b239b3355d0dc2f9e1eb9e7a9.1486562053.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1486562053.git.vilhelm.gray@gmail.com>
References: <cover.1486562053.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO counter driver support did not appear in the 4.9 version of the
Linux kernel. This patch fixes the KernelVersion lines of the relevant
IIO counter sysfs ABI documentation.

Fixes: 1a8f324aa1f2 ("iio: Implement counter channel type and info constants")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 530809ccfacf..789cae317cc2 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1593,7 +1593,7 @@ Description:
 		can be processed to siemens per meter.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_raw
-KernelVersion:	4.9
+KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw counter device counts from channel Y. For quadrature
@@ -1601,7 +1601,7 @@ Description:
 		the counts of a single quadrature signal phase from channel Y.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_raw
-KernelVersion:	4.9
+KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw counter device index value from channel Y. This attribute
-- 
2.11.1

