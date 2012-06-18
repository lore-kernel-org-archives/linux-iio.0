Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47287 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186Ab2FRSdK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Jun 2012 14:33:10 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH RESEND] iio staging: fix tsl2x7x file mode
Date: Mon, 18 Jun 2012 20:33:05 +0200
Message-Id: <1340044387-2725-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
References: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

just drop execute permission

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 0 files changed
 mode change 100755 => 100644 drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
 mode change 100755 => 100644 drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x
 mode change 100755 => 100644 drivers/staging/iio/light/tsl2x7x.h
 mode change 100755 => 100644 drivers/staging/iio/light/tsl2x7x_core.c

diff --git a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583 b/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
old mode 100755
new mode 100644
diff --git a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x b/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x
old mode 100755
new mode 100644
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
old mode 100755
new mode 100644
diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
old mode 100755
new mode 100644
-- 
1.7.9.5

