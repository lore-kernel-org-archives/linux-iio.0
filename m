Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:39956 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751290AbdBICO1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Feb 2017 21:14:27 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
Subject: [PATCH 6/7] iio: Documentation: add ABI documentation for in_proximity_sampling_frequency_available
Date: Wed,  8 Feb 2017 20:54:30 -0500
Message-Id: <20170209015431.17380-7-masneyb@onstation.org>
In-Reply-To: <20170209015431.17380-1-masneyb@onstation.org>
References: <20170209015431.17380-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add entry for the in_proximity_sampling_frequency_available sysfs
entry to the existing sampling_frequency_available ABI documentation.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 530809c..1ce4603 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -55,6 +55,7 @@ Description:
 		then it is to be found in the base device directory.
 
 What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_sampling_frequency_available
 What:		/sys/.../iio:deviceX/buffer/sampling_frequency_available
 What:		/sys/bus/iio/devices/triggerX/sampling_frequency_available
 KernelVersion:	2.6.35
-- 
2.9.3

