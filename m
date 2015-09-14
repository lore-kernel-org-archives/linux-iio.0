Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35643 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbbIND0M (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 Sep 2015 23:26:12 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v5 2/4] iio: resistance: add IIO_RESISTANCE channel type
Date: Sun, 13 Sep 2015 20:26:12 -0700
Message-Id: <1442201174-10975-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1442201174-10975-1-git-send-email-mranostay@gmail.com>
References: <1442201174-10975-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 3 files changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 682c070..a91af51 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1470,3 +1470,11 @@ KernelVersion:	4.3
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled no offset etc.) percentage reading of a substance.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
+KernelVersion:	4.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no offset etc.) resistance reading that can be processed
+		into an ohm value.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 8eb6064..80439a6 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -76,6 +76,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_DISTANCE] = "distance",
 	[IIO_VELOCITY] = "velocity",
 	[IIO_CONCENTRATION] = "concentration",
+	[IIO_RESISTANCE] = "resistance",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 1e4c4e3..7c63bd6 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -36,6 +36,7 @@ enum iio_chan_type {
 	IIO_DISTANCE,
 	IIO_VELOCITY,
 	IIO_CONCENTRATION,
+	IIO_RESISTANCE,
 };
 
 enum iio_modifier {
-- 
1.9.1

