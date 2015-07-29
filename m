Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33426 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbbG2M5i (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2015 08:57:38 -0400
Received: by wicmv11 with SMTP id mv11so218018297wic.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2015 05:57:37 -0700 (PDT)
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
Subject: [PATCH v3 6/7] iio: Add ABI documentation for debounce_time
Date: Wed, 29 Jul 2015 15:57:34 +0300
Message-Id: <1438174654-19333-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com>
References: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add ABI documentation for debounce_time

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
---
Changes in version 3:
- initially added

 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 09eac44..65bf49e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -539,6 +539,15 @@ Description:
 		specified and unique if the output corresponds to a single
 		channel.
 
+What:		/sys/bus/iio/devices/iio:deviceX/debounce_time
+Date:		July 2015
+KernelVersion:	4.2.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies number of milliseconds in which we perform hardware or
+		software debouncing. If value is set to 0 then debouncing is
+		disabled.
+
 What:		/sys/bus/iio/devices/iio:deviceX/events
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
-- 
1.9.1

