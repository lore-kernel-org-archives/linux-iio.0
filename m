Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8076 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbaKYMrR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 25 Nov 2014 07:47:17 -0500
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [RFC PATCH 3/4] iio: add valid sample channel
Date: Tue, 25 Nov 2014 14:48:06 +0200
Message-Id: <1416919687-14271-4-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When a sensor has channels which are sampled at different rates, the
situation can arise when a new buffer sample was triggered, but some of
the channels are not yet ready to be read.

To avoid serving bogus values, we can use a "valid sample" channel.
This value is a bitmap where bit N signifies that the Nth value in the
current buffer sample is a valid reading.

This new channel only makes sense for buffering, so it should have no
other files associated, save for the ones in the scan_elements
directory.  It is also entirely optional to define the channel.  If it
is not defined, all the values in the current sample should be
interpreted as valid, thus preserving semantics for existing drivers.

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 45bb3a4..b6bb1b3 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -72,6 +72,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
 	[IIO_ACTIVITY] = "activity",
 	[IIO_STEPS] = "steps",
+	[IIO_VALIDSAMPLE] = "validsample",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 904dcbb..c75b724 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -32,6 +32,7 @@ enum iio_chan_type {
 	IIO_HUMIDITYRELATIVE,
 	IIO_ACTIVITY,
 	IIO_STEPS,
+	IIO_VALIDSAMPLE,
 };
 
 enum iio_modifier {
-- 
1.9.1

