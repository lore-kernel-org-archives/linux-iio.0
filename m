Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:38907 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757035AbaCDWGo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 4 Mar 2014 17:06:44 -0500
From: Sebastian Reichel <sre@debian.org>
To: Sebastian Reichel <sre@ring0.de>,
	Marek Belisko <marek@goldelico.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, Sebastian Reichel <sre@debian.org>
Subject: [PATCHv2 8/9] iio: documentation: Add ABI documentation for *_mean_raw
Date: Tue,  4 Mar 2014 23:05:50 +0100
Message-Id: <1393970751-18157-9-git-send-email-sre@debian.org>
In-Reply-To: <1393970751-18157-1-git-send-email-sre@debian.org>
References: <1393702365-26429-1-git-send-email-sre@debian.org>
 <1393970751-18157-1-git-send-email-sre@debian.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add ABI documentation for in_*_mean_raw files, which are
already supported and used in the kernel for some time.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 6e02c50..58ba333 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -210,6 +210,14 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Scaled humidity measurement in milli percent.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_X_mean_raw
+KernelVersion:	3.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Averaged raw measurement from channel X. The number of values
+		used for averaging is device specific. The converting rules for
+		normal raw values also applies to the averaged raw values.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_offset
-- 
1.9.0

