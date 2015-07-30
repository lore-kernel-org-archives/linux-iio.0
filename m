Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:53921 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364AbbG3JTB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jul 2015 05:19:01 -0400
From: Pengyu Ma <pengyu.ma@windriver.com>
To: <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <pengyu.ma@windriver.com>
Subject: [PATCH] iio: declare struct to fix warning
Date: Thu, 30 Jul 2015 17:18:57 +0800
Message-ID: <1438247937-29955-1-git-send-email-pengyu.ma@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When compile iio related driver the following warning shown:

include/linux/iio/trigger.h:35:34: warning: 'struct iio_trigger'
declared inside parameter list
  int (*set_trigger_state)(struct iio_trigger *trig, bool state);

include/linux/iio/trigger.h:38:18: warning: 'struct iio_dev'
declared inside parameter list
           struct iio_dev *indio_dev);

1st warning: 'struct iio_trigger' was used before declaration;
2nd warning: 'struct iio_dev' was used without including head file.

Signed-off-by: Pengyu Ma <pengyu.ma@windriver.com>
---
 include/linux/iio/trigger.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 68f46cd..cbe4286 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/atomic.h>
+#include <linux/iio/iio.h>
 
 #ifndef _IIO_TRIGGER_H_
 #define _IIO_TRIGGER_H_
@@ -18,6 +19,8 @@ struct iio_subirq {
 	bool enabled;
 };
 
+struct iio_trigger; /* forward declaration */
+
 /**
  * struct iio_trigger_ops - operations structure for an iio_trigger.
  * @owner:		used to monitor usage count of the trigger.
-- 
2.0.1

