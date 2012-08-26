Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:39260 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862Ab2HZMnu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 26 Aug 2012 08:43:50 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: document missing elements
Date: Sun, 26 Aug 2012 14:43:38 +0200
Message-Id: <1345985019-24288-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1345985019-24288-1-git-send-email-pmeerw@pmeerw.net>
References: <1345985019-24288-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 include/linux/iio/iio.h     |    4 ++++
 include/linux/iio/trigger.h |    5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f323e7b..f966a7e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -229,6 +229,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
  * @indexed:		Specify the channel has a numerical index. If not,
  *			the channel index number will be suppressed for sysfs
  *			attributes but not for event codes.
+ * @output:		Channel is output.
  * @differential:	Channel is differential.
  */
 struct iio_chan_spec {
@@ -312,6 +313,9 @@ struct iio_dev;
  *			Meaning is event dependent.
  * @validate_trigger:	function to validate the trigger when the
  *			current trigger gets changed.
+ * @update_scan_mode:	function to configure device and scan buffer when
+ *			channels have changed
+ * @debugfs_reg_access:	function to read or write register value of device
  **/
 struct iio_info {
 	struct module			*driver_module;
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index a981994..f0af267 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -39,7 +39,7 @@ struct iio_trigger_ops {
 
 /**
  * struct iio_trigger - industrial I/O trigger device
- *
+ * @ops:		[DRIVER] operations structure
  * @id:			[INTERN] unique id number
  * @name:		[DRIVER] unique name
  * @dev:		[DRIVER] associated device (if relevant)
@@ -104,7 +104,8 @@ void iio_trigger_unregister(struct iio_trigger *trig_info);
 
 /**
  * iio_trigger_poll() - called on a trigger occurring
- * @trig: trigger which occurred
+ * @trig:	trigger which occurred
+ * @time:	timestamp when trigger occurred
  *
  * Typically called in relevant hardware interrupt handler.
  **/
-- 
1.7.9.5

