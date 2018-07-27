Return-Path: <SRS0=2uaw=KL=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <jic23@kernel.org>
CC: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: ad9523: Fix return value for ad952x_store()
Date: Fri, 27 Jul 2018 09:42:45 +0300
Message-ID: <20180727064245.7954-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Lars-Peter Clausen <lars@metafoo.de>

A sysfs write callback function needs to either return the number of
consumed characters or an error.

The ad952x_store() function currently returns 0 if the input value was "0",
this will signal that no characters have been consumed and the function
will be called repeatedly in a loop indefinitely. Fix this by returning
number of supplied characters to indicate that the whole input string has
been consumed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/frequency/ad9523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 37504739c277..059b2fda8cbd 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -518,7 +518,7 @@ static ssize_t ad9523_store(struct device *dev,
 		return ret;
 
 	if (!state)
-		return 0;
+		return len;
 
 	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
-- 
2.17.1
