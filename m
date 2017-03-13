Return-Path: <SRS0=+A5L=2W=gmail.com=karniksayli1995@kernel.org>
Date: Mon, 13 Mar 2017 13:12:10 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 2/2] staging: iio: ad9834: Remove unnecessary goto
 statement
Message-ID: <50b408330bbebaf55bcbf5ad163e24452475764f.1489389770.git.karniksayli1995@gmail.com>
References: <cover.1489389769.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1489389769.git.karniksayli1995@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The patch removes unnecessary use of goto statement.

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
v3:
Uncompressed return logic to avoid calling the function twice

 drivers/staging/iio/frequency/ad9834.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 60461a6..e18e0f2 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -149,7 +149,7 @@ static ssize_t ad9834_write(struct device *dev,
 
 	ret = kstrtoul(buf, 10, &val);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
@@ -211,7 +211,6 @@ static ssize_t ad9834_write(struct device *dev,
 	}
 	mutex_unlock(&st->lock);
 
-error_ret:
 	return ret ? ret : len;
 }
 
-- 
2.7.4
