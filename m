Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50361 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbaGYIwE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 25 Jul 2014 04:52:04 -0400
From: Teodora Baluta <teodora.baluta@intel.com>
To: linux-iio@vger.kernel.org
Cc: Teodora Baluta <teodora.baluta@intel.com>
Subject: [PATCH] staging: iio: ad5933: fix sparse warnings
Date: Fri, 25 Jul 2014 11:50:42 +0300
Message-Id: <1406278243-7135-1-git-send-email-teodora.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix the following sparse warnings:

  CHECK   drivers/staging/iio/impedance-analyzer/ad5933.c
drivers/staging/iio/impedance-analyzer/ad5933.c:241:17: warning:
incorrect type in assignment (different base types)
drivers/staging/iio/impedance-analyzer/ad5933.c:241:17:    expected
unsigned int [unsigned] [usertype] d32
drivers/staging/iio/impedance-analyzer/ad5933.c:241:17:    got
restricted __be32 [usertype] <noident>
drivers/staging/iio/impedance-analyzer/ad5933.c:263:13: warning:
incorrect type in assignment (different base types)
drivers/staging/iio/impedance-analyzer/ad5933.c:263:13:    expected
unsigned short [unsigned] dat
drivers/staging/iio/impedance-analyzer/ad5933.c:263:13:    got
restricted __be16 [usertype] <noident>
drivers/staging/iio/impedance-analyzer/ad5933.c:271:13: warning:
incorrect type in assignment (different base types)
drivers/staging/iio/impedance-analyzer/ad5933.c:271:13:    expected
unsigned short [unsigned] [addressable] dat
drivers/staging/iio/impedance-analyzer/ad5933.c:271:13:    got
restricted __be16 [usertype] <noident>
drivers/staging/iio/impedance-analyzer/ad5933.c:310:19: warning: cast to
restricted __be32
drivers/staging/iio/impedance-analyzer/ad5933.c:310:19: warning: cast to
restricted __be32
drivers/staging/iio/impedance-analyzer/ad5933.c:310:19: warning: cast to
restricted __be32
drivers/staging/iio/impedance-analyzer/ad5933.c:310:19: warning: cast to
restricted __be32
drivers/staging/iio/impedance-analyzer/ad5933.c:310:19: warning: cast to
restricted __be32
drivers/staging/iio/impedance-analyzer/ad5933.c:310:19: warning: cast to
restricted __be32
drivers/staging/iio/impedance-analyzer/ad5933.c:446:21: warning:
incorrect type in assignment (different base types)
drivers/staging/iio/impedance-analyzer/ad5933.c:446:21:    expected
unsigned short [unsigned] dat
drivers/staging/iio/impedance-analyzer/ad5933.c:446:21:    got
restricted __be16 [usertype] <noident>
drivers/staging/iio/impedance-analyzer/ad5933.c:454:21: warning:
incorrect type in assignment (different base types)
drivers/staging/iio/impedance-analyzer/ad5933.c:454:21:    expected
unsigned short [unsigned] [addressable] dat
drivers/staging/iio/impedance-analyzer/ad5933.c:454:21:    got
restricted __be16 [usertype] <noident>
drivers/staging/iio/impedance-analyzer/ad5933.c:548:23: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:548:23: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:548:23: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:548:23: warning: cast to
restricted __be16

Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 2b96665..2cef4b9 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -220,7 +220,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
 {
 	unsigned long long freqreg;
 	union {
-		u32 d32;
+		__be32 d32;
 		u8 d8[4];
 	} dat;
 
@@ -244,7 +244,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
 
 static int ad5933_setup(struct ad5933_state *st)
 {
-	unsigned short dat;
+	__be16 dat;
 	int ret;
 
 	ret = ad5933_reset(st);
@@ -297,7 +297,7 @@ static ssize_t ad5933_show_frequency(struct device *dev,
 	int ret;
 	unsigned long long freqreg;
 	union {
-		u32 d32;
+		__be32 d32;
 		u8 d8[4];
 	} dat;
 
@@ -402,7 +402,7 @@ static ssize_t ad5933_store(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	u16 val;
 	int i, ret = 0;
-	unsigned short dat;
+	__be16 dat;
 
 	if (this_attr->address != AD5933_IN_PGA_GAIN) {
 		ret = kstrtou16(buf, 10, &val);
@@ -521,7 +521,7 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad5933_state *st = iio_priv(indio_dev);
-	unsigned short dat;
+	__be16 dat;
 	int ret = -EINVAL;
 
 	mutex_lock(&indio_dev->mlock);
-- 
1.9.1

