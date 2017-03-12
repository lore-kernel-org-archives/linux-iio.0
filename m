Return-Path: <SRS0=OzGk=2V=gmail.com=karniksayli1995@kernel.org>
Date: Mon, 13 Mar 2017 03:49:13 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 2/2] staging: iio: ad9834: Remove unnecessary goto label
 and compress return logic
Message-ID: <59ddccc600cfd1594dcb4dadb44b80328fc06008.1489356140.git.karniksayli1995@gmail.com>
References: <cover.1489356140.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1489356140.git.karniksayli1995@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The patch removes excessive goto label and compresses return logic.

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 60461a6..18f3e8f 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -147,9 +147,8 @@ static ssize_t ad9834_write(struct device *dev,
 	int ret;
 	unsigned long val;
 
-	ret = kstrtoul(buf, 10, &val);
-	if (ret)
-		goto error_ret;
+	if (kstrtoul(buf, 10, &val))
+		return kstrtoul(buf, 10, &val);
 
 	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
@@ -211,7 +210,6 @@ static ssize_t ad9834_write(struct device *dev,
 	}
 	mutex_unlock(&st->lock);
 
-error_ret:
 	return ret ? ret : len;
 }
 
-- 
2.7.4
