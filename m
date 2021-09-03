Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D71C433EF
	for <linux-iio@archiver.kernel.org>; Fri,  3 Sep 2021 14:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A16A610E5
	for <linux-iio@archiver.kernel.org>; Fri,  3 Sep 2021 14:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhICOtZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 3 Sep 2021 10:49:25 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41709 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349502AbhICOtO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 10:49:14 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E029E60011;
        Fri,  3 Sep 2021 14:48:07 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-iio@vger.kernel.org
Subject: [PATCH v4 3/3] iio: ABI: docs: Document Senseair Sunrise ABI
Date:   Fri,  3 Sep 2021 16:48:28 +0200
Message-Id: <20210903144828.497166-4-jacopo@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210903144828.497166-1-jacopo@jmondi.org>
References: <20210903144828.497166-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for the sysfs attributes of the sunrise_co2 driver.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 .../sysfs-bus-iio-chemical-sunrise-co2        | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2 b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
new file mode 100644
index 000000000000..bbdbf9dd4818
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
@@ -0,0 +1,38 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_calibration_factory
+Date:		August 2021
+KernelVersion:
+Contact:	Jacopo Mondi <jacopo@jmondi.org>
+Description:
+		Writing '1' triggers a 'Factory' calibration cycle.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_calibration_background
+Date:		August 2021
+KernelVersion:
+Contact:	Jacopo Mondi <jacopo@jmondi.org>
+Description:
+		Writing '1' triggers a 'Background' calibration cycle.
+
+What:		/sys/bus/iio/devices/iio:deviceX/error_status_available
+Date:		August 2021
+KernelVersion:
+Contact:	Jacopo Mondi <jacopo@jmondi.org>
+Description:
+		Reading returns the list of possible chip error status.
+		Available options are:
+		- 'error_fatal': Analog front-end initialization error
+		- 'error_i2c': Read/write to non-existing register
+		- 'error_algorithm': Corrupted parameters
+		- 'error_calibration': Calibration has failed
+		- 'error_self_diagnostic': Internal interface failure
+		- 'error_out_of_range': Measured concentration out of scale
+		- 'error_memory': Error during memory operations
+		- 'error_no_measurement': Cleared at first measurement
+		- 'error_low_voltage': Sensor regulated voltage too low
+		- 'error_measurement_timeout': Unable to complete measurement
+
+What:		/sys/bus/iio/devices/iio:deviceX/error_status
+Date:		August 2021
+KernelVersion:
+Contact:	Jacopo Mondi <jacopo@jmondi.org>
+Description:
+		Reading returns the current chip error status.
-- 
2.32.0

