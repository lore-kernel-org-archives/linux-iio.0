Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH RESEND] iio staging: fix tsl2x7x file mode
Date: Sun, 17 Jun 2012 19:03:13 +0200
Message-Id: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

just drop execute permission

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

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
