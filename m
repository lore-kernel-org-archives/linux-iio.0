Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34206 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474AbcAIAR5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jan 2016 19:17:57 -0500
Received: by mail-pf0-f182.google.com with SMTP id q63so16894345pfb.1
        for <linux-iio@vger.kernel.org>; Fri, 08 Jan 2016 16:17:56 -0800 (PST)
From: tim.gardner@canonical.com
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tim Gardner <tim.gardner@canonical.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4.4-rc8] iio: magnetometer: ak8975: Silence 'may be used uninitialized' warning
Date: Fri,  8 Jan 2016 17:17:41 -0700
Message-Id: <1452298661-3636-1-git-send-email-tim.gardner@canonical.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Tim Gardner <tim.gardner@canonical.com>

drivers/iio/magnetometer/ak8975.c: In function 'ak8975_probe':
drivers/iio/magnetometer/ak8975.c:788:14: warning: 'chipset' may be used uninitialized in this function [-Wmaybe-uninitialized]
  data->def = &ak_def_array[chipset];

gcc version 5.3.1 20151219 (Ubuntu 5.3.1-4ubuntu1)

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---

This seems like a legitimate warning, though gcc should have complained
about an earlier use of chipset on line 782.

 drivers/iio/magnetometer/ak8975.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b13936d..80ec0ce 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -732,7 +732,7 @@ static int ak8975_probe(struct i2c_client *client,
 	int eoc_gpio;
 	int err;
 	const char *name = NULL;
-	enum asahi_compass_chipset chipset;
+	enum asahi_compass_chipset chipset = AK_MAX_TYPE;
 
 	/* Grab and set up the supplied GPIO. */
 	if (client->dev.platform_data)
-- 
1.9.1

