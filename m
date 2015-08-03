Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:49842 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbbHCCjo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 22:39:44 -0400
From: Pengyu Ma <pengyu.ma@windriver.com>
To: <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <pengyu.ma@windriver.com>
Subject: [PATCH V2] iio: declare struct to fix warning
Date: Mon, 3 Aug 2015 10:39:40 +0800
Message-ID: <1438569580-3712-1-git-send-email-pengyu.ma@windriver.com>
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

'struct iio_dev' and 'struct iio_trigger' was used before declaration,
forward declaration for these structs to fix warning.

Signed-off-by: Pengyu Ma <pengyu.ma@windriver.com>
---
 include/linux/iio/trigger.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index fa76c79..974cf73 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -18,6 +18,10 @@ struct iio_subirq {
 	bool enabled;
 };
 
+/* forward declaration */
+struct iio_dev;
+struct iio_trigger;
+
 /**
  * struct iio_trigger_ops - operations structure for an iio_trigger.
  * @owner:		used to monitor usage count of the trigger.
-- 
2.4.3

