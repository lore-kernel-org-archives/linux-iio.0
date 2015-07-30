Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35324 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886AbbG3J2a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jul 2015 05:28:30 -0400
MIME-Version: 1.0
Date: Thu, 30 Jul 2015 17:28:29 +0800
Message-ID: <CALSz7m3Kb9Cs31ZXVdprq2Z8-O1VyR7Q8hCUTYjBAzymKaEySA@mail.gmail.com>
Subject: [PATCH] iio: declare struct to fix warning
From: Aaron Ma <mapengyu@gmail.com>
To: jic23@kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Aaron Ma <mapengyu@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Pengyu Ma <mapengyu@gmail.com>
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
  * @owner: used to monitor usage count of the trigger.
-- 
2.0.1
