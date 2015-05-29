Return-Path: <rodriguez.twister@gmail.com>
From: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
To: jic23@kernel.org,
	daniel.baluta@intel.com,
	dan.carpenter@oracle.com,
	gregkh@linuxfoundation.org
Cc: cristina.opriceana@gmail.com,
	driverdev-devel@linuxdriverproject.org,
	linux-iio@vger.kernel.org,
	Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
Subject: [PATCH v2 1/3] staging: iio_simple_dummy: fix init function
Date: Sat, 30 May 2015 00:45:21 +0300
Message-Id: <1432935923-28928-2-git-send-email-rodriguez.twister@gmail.com>
In-Reply-To: <1432935923-28928-1-git-send-email-rodriguez.twister@gmail.com>
References: <1432935923-28928-1-git-send-email-rodriguez.twister@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the init function for the iio_simple_dummy driver.
The main issues were absence of kfree for the allocated array, and no
devices being removed in case the probe function fails, running in a loop.

Signed-off-by: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
---
 drivers/staging/iio/iio_simple_dummy.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index b47bf9f..d0a9963 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -722,9 +722,16 @@ static __init int iio_dummy_init(void)
 	for (i = 0; i < instances; i++) {
 		ret = iio_dummy_probe(i);
 		if (ret < 0)
-			return ret;
+			goto error_remove_devs;
 	}
 	return 0;
+
+error_remove_devs:
+	while (i--)
+		iio_dummy_remove(i);
+
+	kfree(iio_dummy_devs);
+	return ret;
 }
 module_init(iio_dummy_init);
 
-- 
2.4.1
