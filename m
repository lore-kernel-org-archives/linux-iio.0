Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35758 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbdCAOpg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Mar 2017 09:45:36 -0500
Received: by mail-wm0-f51.google.com with SMTP id v186so112029142wmd.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Mar 2017 06:45:17 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v1 1/2] iio: Generalize counting direction modes
Date: Wed,  1 Mar 2017 15:45:05 +0100
Message-Id: <1488379506-23969-2-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1488379506-23969-1-git-send-email-benjamin.gaignard@st.com>
References: <1488379506-23969-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move counting direction documentation for 104-quad-8 to sysfs-bus-iio
to avoid duplicated for other incoming drivers

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 Documentation/ABI/testing/sysfs-bus-iio                    | 14 ++++++++++++++
 Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 |  8 --------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index b8f220f..b63723b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1597,3 +1597,17 @@ Description:
 		provides an absolute positional reference (e.g. a pulse once per
 		revolution) which may be used to home positional systems as
 		required.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_direction_available
+KernelVersion:	4.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		A list of possible counting directions which are:
+		- "up"	: counter device is increasing.
+		- "down": counter device is decreasing.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_direction
+KernelVersion:	4.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw counter device counters direction for channel Y.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
index ba67652..322c8da 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
+++ b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
@@ -1,4 +1,3 @@
-What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_direction_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_mode_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_count_noise_error_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
@@ -10,13 +9,6 @@ Description:
 		Discrete set of available values for the respective counter
 		configuration are listed in this file.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_direction
-KernelVersion:	4.9
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Read-only attribute that indicates whether the counter for
-		channel Y is counting up or down.
-
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_mode
 KernelVersion:	4.9
 Contact:	linux-iio@vger.kernel.org
-- 
1.9.1

