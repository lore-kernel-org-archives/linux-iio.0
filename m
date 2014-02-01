Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:57399 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbaBAGRk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 1 Feb 2014 01:17:40 -0500
From: Matt Ranostay <mranostay@gmail.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org
Cc: matt.porter@linaro.org, koen@dominion.thruhere.net,
	pantelis.antoniou@gmail.com, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 1/3] iio: Add IIO_DISTANCE type
Date: Fri, 31 Jan 2014 22:17:40 -0800
Message-Id: <1391235462-32453-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Allow drivers to report distance values, but however it is up to
drivers to set scaling for meters, kilometers, etc.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index acc911a..ac999ab 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -70,6 +70,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CCT] = "cct",
 	[IIO_PRESSURE] = "pressure",
 	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
+	[IIO_DISTANCE] = "distance",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 084d882..675c2d8 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -30,6 +30,7 @@ enum iio_chan_type {
 	IIO_CCT,
 	IIO_PRESSURE,
 	IIO_HUMIDITYRELATIVE,
+	IIO_DISTANCE,
 };
 
 enum iio_modifier {
-- 
1.8.3.2

