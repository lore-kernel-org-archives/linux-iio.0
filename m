Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8076 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbaKYMrP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 25 Nov 2014 07:47:15 -0500
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 1/4] iio: dummy: set scan_index for unbuffered channels
Date: Tue, 25 Nov 2014 14:48:04 +0200
Message-Id: <1416919687-14271-2-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If we do not set scan_index explicitly it will default to 0, causing
more than one channel to have the same scan_index.  This does not make
sense, as scan_index is used to order values in a buffer sample.

Set the activity and voltage output channels to unbuffered
(scan_index = -1) to fix this.

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/staging/iio/iio_simple_dummy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 10a9e08..2948900 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -242,6 +242,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		.output = 1,
 		.indexed = 1,
 		.channel = 0,
+		.scan_index = -1,
 	},
 	{
 		.type = IIO_STEPS,
@@ -259,6 +260,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_RUNNING,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.scan_index = -1,
 #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
 		.event_spec = &iio_running_event,
 		.num_event_specs = 1,
@@ -269,6 +271,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_WALKING,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.scan_index = -1,
 #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
 		.event_spec = &iio_walking_event,
 		.num_event_specs = 1,
-- 
1.9.1

